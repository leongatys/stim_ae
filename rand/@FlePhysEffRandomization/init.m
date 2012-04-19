function r = init(r,params)
% AE 2008-09-03
% MS 2012-01-16
% parameters that are randomized
r.conditions = struct('isFlash',{},'isMoving',{},'isStop',{},'isInit',{}, ...
    'flashLocation',{},'barColor',{},'trajectoryAngle',{}, ...
    'direction',{},'dx',{},'arrangement',{});

%% Flashed and moving bars presented individually
%   In this case we present them both in the receptive fields of the neurons

if ~params.combined % Single condition
    for i = 1:size(params.barColor,2)
        for angle = params.trajectoryAngle
            
            %             % flashes only
            nLocs = params.numFlashLocs;
            r.conditions(end+(1:nLocs)) = ...
                struct('isFlash',1, ...
                'isMoving',0, ...
                'isStop',0, ...
                'isInit',0,...
                'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                'barColor',params.barColor(:,i), ...
                'trajectoryAngle',angle, ...
                'direction',NaN, ...
                'dx',NaN, ...
                'arrangement',1);
            
            % moving bars
            for dx = params.dx
                for dir = params.direction
                    % When we test the flash initiated and terminated
                    % conditions only, we do not want to show the continuous
                    % motion condition (full trajectory moving bar).
                    
                    if ~(params.flashStop || params.flashInit)
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
                            'arrangement',0);
                    end
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
                            'arrangement',0);
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
                            'arrangement',0);
                    end
                end
            end
        end
    end
else % combined condition
    for i = 1:size(params.barColor,2)
        for angle = params.trajectoryAngle
            for arr = params.arrangement
                % flashes only
                nLocs = params.numFlashLocs;
                r.conditions(end+(1:nLocs)) = ...
                    struct('isFlash',1, ...
                    'isMoving',0, ...
                    'isStop',0, ...
                    'isInit',0,...
                    'flashLocation',mat2cell(1:nLocs,1,ones(1,nLocs)), ...
                    'barColor',params.barColor(:,i), ...
                    'trajectoryAngle',angle, ...
                    'direction',NaN, ...
                    'dx',NaN, ...
                    'arrangement',arr);
                
                for dx = params.dx
                    for dir = params.direction
                        
                        % When we test the flash initiated and terminated
                        % conditions only, we do not want to show the continuous
                        % motion condition (full trajectory moving
                        % bar with or without flash).
                        if ~(params.flashStop || params.flashInit)
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
                                'arrangement',arr);
                            
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
                                'arrangement',arr);
                            % Moving bar in flash stop condition
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
                                'arrangement',arr);
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
                                'arrangement',arr);
                            % Moving bar in flash initiated condition
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
