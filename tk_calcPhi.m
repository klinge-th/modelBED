function phi = tk_calcPhi(shots,dose,mu,interTime)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculations of repair factor based on eqn. (21) from:
% Millar, W. T. & Canney, P. A. Derivation and application of equations 
% describing the effects of fractionated protracted irradiation, based on 
% multiple and incomplete repair processes. Part I. Derivation of 
% equations. International journal of radiation biology, 1993, 64, 275-91
% -------------------------------------------------------------------------
% function to calculate phi for a given protocol (shots) assuming:
% - constant dose rate during fraction
% - single repair constant
% - induction of (sub-) lethal damage prop. to dose rate
% - transl. sub-lethal -> lethal damage prop. to dose rate
% -------------------------------------------------------------------------
% INPUT
% shots:    file containing info about every shot (order, duration)
% dose:     4D-cube [x,y,n_shots,z] containing 3D dose for every shot
% mu:       repair-rate (exponential repair) ln(2)/repair_half-life [1/min]
% interTime:intervall between the shots (minutes, optional)
% -------------------------------------------------------------------------
% OUTPUT
% phi:      number [3D cube] to be used in the BED/LQ formula
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright 2019 Thomas Klinge. 
% 
% This file is part of the Gamma Knife BED project. It is subject to the
% license terms in the LICENSE file found in the top-level directory of 
% this distribution and at 
% https://github.com/klinge-th/modelBED/blob/master/LICENSE. No part 
% of the Gamma Knife BED project, including this file, may be copied, 
% modified, propagated, or distributed except according to the terms 
% contained in the LICENSE file.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% check input
interT = zeros(size(shots,1)-1,1);
if nargin == 4
    interT = interT + interTime;
end    

%% get info from input
numOfShots = size(shots,1);
dt = shots(:,9); % duration of each shot
% add the inter-shot interval to the cummulative sum of durations to get
% the start time for every isocentre
t = cumsum([ 0; dt(1:end-1) + interT(1:end) ]);

%% prepare data
doseSq = dose.*dose;
doseSq_tot = squeeze(sum(doseSq,3));
dtSq = dt.*dt;

%% calculation
phi = zeros(size(squeeze(dose(:,:,1,:))));

for j = 1:numOfShots    
    temp1 = squeeze( doseSq(:,:,j,:) )...
            .*(1./dtSq(j))...
            .*( dt(j) - (1/mu) * (1 - exp(-mu*dt(j))) );
    temp2 = zeros(size(temp1));
    for i = 1:j-1
        temp3 = dose(:,:,i,:).*dose(:,:,j,:)...
            ./ (dt(i)*dt(j))...
            .* exp( -mu*(t(j)-t(i)) )...
            .* (exp( mu*dt(i) ) - 1)...
            .* (exp( -mu*dt(j) ) - 1);
        temp2 = temp2 + squeeze(temp3);
    end
    
    phi = phi + temp1 - ( (1/mu) .* temp2 );    
end

phi = squeeze( 2*phi./(mu*doseSq_tot) );

end