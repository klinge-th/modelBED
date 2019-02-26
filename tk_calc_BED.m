function BED = tk_calc_BED(shots,dose,mu_fast,mu_slow,g,c,ABratio)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to calculate the BED based on Millar and Canney 1993
% http://dx.doi.org/10.1080/09553009314551431 
% and Pop et al. 2000 https://doi.org/10.1016/S0167-8140(00)00205-X
% 
% INPUT -------------------------------------------------------------------
% shots:    Nx9 array containing shot duration in 9th column
% dose:     31x31xNx31 cube containing dose for every shot 
% mu_fast:  fast repair coefficient
% mu_slow:  slow repair coefficient
% g:        gap vector containing duration of every gap (min)
% c:        partition coefficient to combine fast&slow repair BED
% ABratio:  alpha/beta ratio
% 
% OUTPUT ------------------------------------------------------------------
% BED:      31x31x31 BED matrix with BED for every voxel
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

%% calculations

% get factor depending on treatment protocol
phi_fast = tk_calcPhi(shots,dose,mu_fast,g);
phi_slow = tk_calcPhi(shots,dose,mu_slow,g);

% calculate BED with partition 
% pre-process dose terms
dose_tot = squeeze(sum(dose,4));
doseSq = dose.*dose;
doseSq_tot = squeeze(sum(doseSq,4));

% BED
BED = dose_tot...
    + ( (phi_fast + (c*phi_slow)) / (1+c) ) .* doseSq_tot ./ABratio;
    
end