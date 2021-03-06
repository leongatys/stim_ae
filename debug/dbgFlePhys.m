% Script to test FlePhysExperiment
% AE 2008-09-02

warning off TrialBasedExperiment:netStartTrial
warning off TrialBasedExperiment:netEndTrial
warning off StimulationData:setTrialParam
warning off StimulationData:setParam

T = FlePhysEffExperiment;
T = set(T,'debug',true);
T = openWindow(T);

% PARAMETERS for config file
constants.fixSpotColor = [255; 0; 0];
constants.fixSpotLocation = [0; 0];
constants.fixSpotSize = 10;

% Psychophysics was done on unlinearized monitor. Converted parameter values
% are:       before  now
%   bgColor  64      10
%   barColor 192     136    <-- run this since we didn't find contrast dep in PP
%            160     89
%            120     44
%            75      14
constants.bgColor = [10; 10; 10];
constants.barColor = [136; 136; 136];
constants.barSize = [20; 100];
% Speeds run in PP were: 1500, 1000, 750
% These correspond to dx:  15,   10, 7.5
constants.dx = 10;
constants.stimCenter = [960; 600];
constants.trajectoryAngle = 0;
constants.trajectoryLength = 300;
constants.numFlashLocs = 5;
constants.flashLocDistance = 10;
constants.direction = [0 1];
constants.postStimulusTime = 300;
constants.interStimulusTime = 300;
constants.maxStimulusTime = 1500;
constants.verticalDistance = 130;

constants.flashStop = 1;
constants.arrangement = 1;
constants.combined = 1;

constants.delayTime = -1;

constants.monitorSize = [41; 30];
constants.monitorDistance = 107;
constants.monitorCenter = [800; 600];

constants.subject = 'DEBUG';
constants.eyeControl = 0;
constants.rewardProb = 1;
constants.joystickThreshold = 200;
constants.fixationRadius = 50;
constants.passive = 1;
constants.acquireFixation = 1;
constants.allowSaccades = 0;
constants.rewardAmount = 0;
constants.date = datestr(now,'YYYY-mm-dd_HH-MM-SS');

trials = struct;

T = netStartSession(T,constants);

for i = 1:getNumConditions(T)
    
    fprintf('trial #%d\n',i)

    T = netStartTrial(T,trials);
    T = netSync(T,struct('counter',0));
    T = netSync(T,struct('counter',1));
    T = netInitTrial(T);
    
    T = netShowFixspot(T,struct);

    pause(0.5)
    
    T = netShowStimulus(T,struct);
    
    T = netTrialOutcome(T,struct('correctResponse',true,'behaviorTimestamp',NaN));
    T = netEndTrial(T);

    pause(0.5)
end

T = netEndSession(T);
T = cleanUp(T);

