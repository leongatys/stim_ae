function [e,retInt32,retStruct,returned] = netShowStimulus(e,params)
% Moving and flashed bars for Flash-Lag effect electrophysiology.
% AE 2008-09-02

% find out which stimulus to show
if getParam(e,'isFlashTrial')
    e = showFlashedBar(e,params);
elseif getParam(e,'isMovingTrial')
    e = showMovingBar(e,params);
elseif getParam(e,'isStopTrial')
    e = showStoppingBar(e,params);
end

% return values
retInt32 = int32(0);
retStruct = struct;
returned = true;
