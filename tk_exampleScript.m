% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to show the usage of the BED calculation and plotting
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


clear;clc
%% load artificial example data and plot total dose and one shot
load('./exampleData.mat')

%% load BED parameters
BED_settingsMillar2015

%% calculate BED
BED = tk_calc_BED(shots,dose,mu_fast,mu_slow,g,c,ABratio);

%% plot results
% total dose
Dfig = tk_plotBEDsliceTrans(dose_tot); 
Dfig.Name = 'total dose';

BEDfig = tk_plotBEDsliceTrans(BED);
BEDfig.Name = 'BED';

%% further plot examples
% only plot 3rd shot
fig3 = tk_plotBEDsliceTrans(squeeze(dose(:,:,3,:)));
fig3.Name = 'Shot number 3';

% only plot BED in volume of interest
VOIBEDfig = tk_plotBEDsliceTrans(BED,VOImask);
VOIBEDfig.Name = 'BED in VOI';

%% timeit() to show runtime of function with these inputs

f = @() tk_calc_BED(shots,dose,mu_fast,mu_slow,g,c,ABratio);
disp(['it took ' num2str(timeit(f,1)) ' s to calculate the BED matrix'])
