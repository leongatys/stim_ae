function r = init(r,params)
% Initialize randomization
% AE 2010-10-24

% amount of change upon correct/wrong responses
r.correct = params.stepCorrect;
r.wrong = params.stepWrong;

% current threshold
r.threshold = params.initialThreshold;

% distribution used to draw stimulus levels in each trial (has to return
% integer values)
r.distribution = eval(params.distribution);

% pool size (enforce it to be even)
r.poolSize = params.poolSize + mod(params.poolSize,2);

% maximum stimulus level (to avoid ambiguities with circular quantities)
% note that this should be well above the actual threshold of the subject.
% otherwise the distribution of stimuli won't be what is expected because
% the same upper bound is applied to both, threshold and stimulus level.
r.maxLevel = fix(params.maxLevel);
