function r = init(r,params)
% AE 2008-09-03
% MS 2012-01-16/2012-04-21/2012-08-15
% parameters that are randomized
r.conditions = struct('isFlash',{},'isMoving',{},'isStop',{},'isInit',{}, ...
    'flashLocation',{},'barColor',{},'trajectoryAngle',{}, ...
    'direction',{},'dx',{},'trajOffset',{},'arrangement',{});

%% Flashed and moving bars presented individually
% In this case we present them both in the receptive fields of the neurons
movInRfArr = 0;
flashInRfArr = 1;
if ~params.combined % Single condition
    for i = 1:size(params.barColor,2)
        for angle = params.trajectoryAngle
            % flashes only
            nLocs = params.numFlashLocs;
            if params.flashInit || params.flashStop
                nLocsBarMap = params.numFlashLocsBarMap;
            else
                nLocsBarMap = nLocs;
            end
            r.conditions(end+(1:nLocsBarMap)) = ...
                struct('isFlash',1, ...
                'isMoving',0, ...
                'isStop',0, ...
                'isInit',0,...
                'flashLocation',mat2cell(1:nLocsBarMap,1,ones(1,nLocsBarMap)), ...
                'barColor',params.barColor(:,i), ...
                'trajectoryAngle',angle, ...
                'direction',NaN, ...
                'dx',NaN, ...
                'trajOffset',NaN,...
                'arrangement',flashInRfArr);
            
            % moving bars
            for iDx = 1:length(params.dx)
                dx = params.dx(iDx);
                trajOffset = params.trajOffsets(iDx);
                for dir = params.direction
                    % Continuous motion condition
                    r.conditions(end+1) = ...
                        struct('isFlash',0, ...
                        'isMoving',1, ...
                        'isStop',0, ...
                        'isInit',0,...
                        'flashLocation',NaN, ...
                        'barColor',params.barColor(:,i), ...
                        'trajectoryAngle',angle, ...
                        'direction',dir, ...
                        'dx',dx, ...
                        'trajOffset',trajOffset,...
                        'arrangement',movInRfArr);
                    % Flash-stop condition
                    if params.flashStop
                        r.conditions(end+(1:nLocs)) = ...
                            struct('isFlash',0, ...
                            'isMoving',1, ...
                            'isStop',1, ...
                            'isInit',0,...
                            'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                            'barColor',params.barColor(:,i), ...
                            'trajectoryAngle',angle, ...
                            'direction',dir, ...
                            'dx',dx, ...
                            'trajOffset',trajOffset,...
                            'arrangement',movInRfArr);
                    end
                    % Flash initiated condition
                    if params.flashInit
                        r.conditions(end+(1:nLocs)) = ...
                            struct('isFlash',0, ...
                            'isMoving',1, ...
                            'isStop',0, ...
                            'isInit',1,...
                            'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                            'barColor',params.barColor(:,i), ...
                            'trajectoryAngle',angle, ...
                            'direction',dir, ...
                            'dx',dx, ...
                            'trajOffset',trajOffset,...
                            'arrangement',movInRfArr);
                    end
                end
            end
        end
    end
else % combined condition
    for i = 1:size(params.barColor,2)
        for angle = params.trajectoryAngle
            
            % flashes only
            nLocs = params.numFlashLocs;
             if params.flashInit || params.flashStop
                nLocsBarMap = params.numFlashLocsBarMap;
            else
                nLocsBarMap = nLocs;
            end
            r.conditions(end+(1:nLocsBarMap)) = ...
                struct('isFlash',1, ...
                'isMoving',0, ...
                'isStop',0, ...
                'isInit',0,...
                'flashLocation',mat2cell(1:nLocsBarMap,1,ones(1,nLocsBarMap)), ...
                'barColor',params.barColor(:,i), ...
                'trajectoryAngle',angle, ...
                'direction',NaN, ...
                'dx',NaN, ...
                'trajOffset',NaN,...
                'arrangement',flashInRfArr);
            
            for iDx = 1:length(params.dx)
                dx = params.dx(iDx);
                trajOffset = params.trajOffsets(iDx);
                for dir = params.direction
                    % moving bars without flash
                    r.conditions(end+1) = ...
                        struct('isFlash',0, ...
                        'isMoving',1, ...
                        'isStop',0, ...
                        'isInit',0,...
                        'flashLocation',NaN, ...
                        'barColor',params.barColor(:,i), ...
                        'trajectoryAngle',angle, ...
                        'direction',dir, ...
                        'dx',dx, ...
                        'trajOffset',trajOffset,...
                        'arrangement',movInRfArr);
                    for arr = params.arrangement
                        % 'Continuous motion' condition
                        % Combined flash and moving bars
                        r.conditions(end+(1:nLocs)) = ...
                            struct('isFlash',1, ...
                            'isMoving',1, ...
                            'isStop',0, ...
                            'isInit',0,...
                            'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                            'barColor',params.barColor(:,i), ...
                            'trajectoryAngle',angle, ...
                            'direction',dir, ...
                            'dx',dx, ...
                            'trajOffset',trajOffset,...
                            'arrangement',arr);
                    end
                    % Flash-stop condition
                    if params.flashStop
                        % Moving bar only
                        r.conditions(end+1) = ...
                            struct('isFlash',0, ...
                            'isMoving',1, ...
                            'isStop',1, ...
                            'isInit',0,...
                            'flashLocation',NaN, ...
                            'barColor',params.barColor(:,i), ...
                            'trajectoryAngle',angle, ...
                            'direction',dir, ...
                            'dx',dx, ...
                            'trajOffset',trajOffset,...
                            'arrangement',movInRfArr);
                        % Moving bar in flash stop condition
                        for arr = params.arrangement
                            r.conditions(end+(1:nLocs)) = ...
                                struct('isFlash',1, ...
                                'isMoving',1, ...
                                'isStop',1, ...
                                'isInit',0,...
                                'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                                'barColor',params.barColor(:,i), ...
                                'trajectoryAngle',angle, ...
                                'direction',dir, ...
                                'dx',dx, ...
                                'trajOffset',trajOffset,...
                                'arrangement',arr);
                        end
                    end
                    if params.flashInit
                        % Moving bar only
                        r.conditions(end+1) = ...
                            struct('isFlash',0, ...
                            'isMoving',1, ...
                            'isStop',0, ...
                            'isInit',1,...
                            'flashLocation',NaN, ...
                            'barColor',params.barColor(:,i), ...
                            'trajectoryAngle',angle, ...
                            'direction',dir, ...
                            'dx',dx, ...
                            'trajOffset',trajOffset,...
                            'arrangement',movInRfArr);
                        % Moving bar in flash initiated condition
                        for arr = params.arrangement
                            r.conditions(end+(1:nLocs)) = ...
                                struct('isFlash',1, ...
                                'isMoving',1, ...
                                'isStop',0, ...
                                'isInit',1,...
                                'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                                'barColor',params.barColor(:,i), ...
                                'trajectoryAngle',angle, ...
                                'direction',dir, ...
                                'dx',dx, ...
                                'trajOffset',trajOffset,...
                                'arrangement',arr);
                        end
                    end
                end
            end
        end
    end
end

%% initialize WhiteNoiseRandomization on condition indices
r.white = setParams(WhiteNoiseRandomization,1:length(r.conditions));
