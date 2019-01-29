function fig = tk_plotBEDsliceTrans(BED,mask)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to plot a transversal slice from the BED cube and give a slider
% to control which slice is plotted
% INPUT -------------------------------------------------------------------
% BED:  3D-cube containing the BED data
% mask: 3D-cube (binary) masking the VOI (optional)
% OUTPUT ------------------------------------------------------------------
% fig:  figure handle
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

%% apply mask if provided
if nargin == 2
    BED(logical(1-mask)) = nan;
end
%% permute to get proper orientation of the transversal slice (as would be seen in GammaPlan)
BED = flip(flip(permute(BED,[1 3 2]),1),3);

%% plot, initialising at central slide
% find central slice
numOfSlices = size(BED,3);
sliceIdx = round( numOfSlices/2 );

fig = figure;
colormap(jet(512))
drawslice(BED, sliceIdx)

% Create slider
pos=get(gca,'position');
sldPos=[pos(1)-.05 pos(2) 0.05 pos(4)]; %left,bottom,width,height

sld = uicontrol('Style', 'slider',...
                'Min',1,'Max',numOfSlices,...
                'sliderStep',[1/(numOfSlices-1), 0.1],'Value',sliceIdx,...
                'units','normalized','Position', sldPos,...
                'Callback', @(source,event,~) updateslice(BED,source,event));
    
set(fig,'windowscrollWheelFcn', @(source,event,~,~) wheel(sld,BED,source,event));    
end

function updateslice(BED, source, ~)
% draws/updates the slice

sliceIdx = round(source.Value);
source.Value = sliceIdx;

drawslice(BED, sliceIdx)

end

function wheel(sld,BED,~,event)

if sld.Value - event.VerticalScrollCount > sld.Max
    sld.Value = sld.Max;
elseif sld.Value - event.VerticalScrollCount < sld.Min
    sld.Value = sld.Min;
else
    sld.Value = sld.Value - event.VerticalScrollCount;
end
drawslice(BED, sld.Value)
end

function drawslice(BED, sliceIdx)
% plotting the transversal slice specified by sliceIdx
imagesc(BED(:,:,sliceIdx))

axis equal
axis tight
set(gca,'YTickLabel',[],'XTickLabel',[]);
title(['Transversal Slice ' num2str(sliceIdx) '/' num2str(size(BED,3))])
colorbar
caxis([min(BED(:)) max(BED(:))])
hold on
contour(BED(:,:,sliceIdx),'ShowText','on','Linewidth',.5,'Color',[0 0 0],...
        'LineStyle',':')

end