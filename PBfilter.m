function [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);

        
likeepPBs = []; %SB and CB
%race time
nameDone = {};

for i = 1:length(classifierName(:,1));
    nameSelect = classifierName{i,1};
    if i ~= 1;
        litest = strfind(lower(nameDone), lower(nameSelect));
        litestName = find(~cellfun('isempty', litest));

        if isempty(litestName) == 1;
            timeEC = [];
            lisearch = strfind(lower(classifierName), lower(nameSelect));
            likeepName = find(~cellfun('isempty', lisearch));
            timeKeep = classifier(likeepName,1);
            
            if strcmpi(colsource, 'RaceTime');
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    liSec = strfind(val, ' s');
                    if isempty(liSec) == 0;
                        timeEC(k,1) = str2num(val(1:5));
                    else;
                        lidot = strfind(val, ':');
                        min = str2num(val(1:lidot-1)).*60;
                        sec = str2num(val(lidot+1:lidot+3));
                        hun = str2num(['0.' val(end-1:end)]);
                        timeEC(k,1) = min+sec+hun;
                    end;
                end
                [sortTime, index] = sort(timeEC, 'Ascend');

            elseif strcmpi(colsource, 'SkillTime') | strcmpi(colsource, 'SwimTime');
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    index = strfind(val, 's');
                    if isempty(index) == 0;
                        indexNan = strfind(val, 'NaN');
                        if indexNan == 1;
                            timeEC(k,1) = 1000;
                        else;
                            timeEC(k,1) = str2num(val(1:index-2));
                        end;
                    else;
                        index = strfind(val, ':');
                        valsec = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                        timeEC(k,1) = valsec;
                    end;
                end;
                [sortTime, index] = sort(timeEC, 'Ascend');

            elseif strcmpi(colsource, 'StartTime') | strcmpi(colsource, 'TurnTime') | strcmpi(colsource, 'BlockTime') | ...
                    strcmpi(colsource, 'DropOff');
                
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    indexNan = strfind(val, 'NaN');
                    if indexNan == 1;
                        timeEC(k,1) = 1000;
                    else;
                        if isempty(str2num(val)) == 1;
                            timeEC(k,1) = 10000;
                        else;
                            timeEC(k,1) = str2num(val);
                        end;
                    end;

% 
% 
% 
%                     if val == 0;
%                         timeEC(k,1) = 1000000;
%                     else;
%                         timeEC(k,1) = val;
%                     end;
% 
% 
% 
% 
%                     
                end;
                [sortTime, index] = sort(timeEC, 'Ascend');

            elseif strcmpi(colsource, 'AvTurnTime');
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    if strcmpi(val, 'NaN00') == 1;
                        timeEC(k,1) = 0;
                    elseif strcmpi(val, 'na') == 1;
                        timeEC(k,1) = 0;
                    else;
                        liindex1 = strfind(val, '[');
                        timeEC(k,1) = str2num(val(1:liindex1-2));
                    end;
                end;
                [sortTime, index] = sort(timeEC, 'Ascend');
            
            elseif strcmpi(colsource, 'FinishTime');
                for k = 1:length(timeKeep);
                    timeEC(k,1) = timeKeep{k,1};
                end;
                [sortTime, index] = sort(timeEC, 'Ascend');
                
            elseif strcmpi(colsource, 'OtherTime') | strcmpi(colsource, 'LapTime');
                timeEC = timeKeep;
                [sortTime, index] = sort(timeEC, 'Ascend');
                
            elseif strcmpi(colsource, 'OtherVal');
                timeEC = timeKeep;
                [sortTime, index] = sort(timeEC, 'Descend');

            elseif strcmpi(colsource, 'UWSpeed') | strcmpi(colsource, 'SwimSpeed') | strcmpi(colsource, 'StrokeEff') | ...
                    strcmpi(colsource, 'BODist') | strcmpi(colsource, 'EntryDist');;
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    if strcmpi(val, 'NaN00') == 1;
                        timeEC(k,1) = 0;
                    elseif strcmpi(val, 'NaN.00') == 1;
                        timeEC(k,1) = 0;
                    elseif strcmpi(val, 'na') == 1;
                        timeEC(k,1) = 0;
                    else;
                        timeEC(k,1) = str2num(val);
                    end;
                end;
                [sortTime, index] = sort(timeEC, 'Descend');

            elseif strcmpi(colsource, 'DecayIndex');
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    if strcmpi(val, 'NaN00') == 1;
                        timeEC(k,1) = 0;
                    else;
                        timeEC(k,1) = val;
                    end;
                end;
                [sortTime, index] = sort(timeEC, 'Descend');
             
            elseif strcmpi(colsource, 'BOEff') | strcmpi(colsource, 'AppEff');
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    if strcmpi(val, 'NaN00') == 1;
                        timeEC(k,1) = 0;
                    else;
                        liindex1 = strfind(val, '[');
                        timeEC(k,1) = str2num(val(1:liindex1-2));
                    end;
                end;
                [sortTime, index] = sort(timeEC, 'Descend');
            
            elseif strcmpi(colsource, 'MaxVel') | strcmpi(colsource, 'MaxSR') | strcmpi(colsource, 'MaxDPS');
                for k = 1:length(timeKeep);
                    val = timeKeep{k,1};
                    liindex1 = strfind(val, '/');
                    liindex2 = strfind(val, '[');
                    timeEC(k,1) = str2num(val(liindex1+2:liindex2-2));
                end;
                [sortTime, index] = sort(timeEC, 'Descend');
                
            elseif strcmpi(colsource, 'SpeedDecay');
                for k = 1:length(timeKeep);
                    valZones = timeKeep{k,1};
                    if length(timeKeep{k,1}) > 1;
                        %4 values (IM races)
                        timeEC(k,1) = mean(valZones(:,1)) + mean(valZones(8));
                    else;
                        timeEC(k,1) = valZones(1) + valZones(8);
                    end;
                end;
                [sortTime, index] = sort(timeEC, 'Descend');
            end;
            likeepPBs = [likeepPBs likeepName(index(1))];
            nameDone{iter,1} = nameSelect;
            iter = iter + 1;
        end;
    else;
        timeEC = [];
        lisearch = strfind(lower(classifierName), lower(nameSelect));
        likeepName = find(~cellfun('isempty', lisearch));
        timeKeep = classifier(likeepName,1);

        if strcmpi(colsource, 'RaceTime');
            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                liSec = strfind(val, ' s');
                if isempty(liSec) == 0;
                    timeEC(k,1) = str2num(val(1:5));
                else;
                    lidot = strfind(val, ':');
                    min = str2num(val(1:lidot-1)).*60;
                    sec = str2num(val(lidot+1:lidot+3));
                    hun = str2num(['0.' val(end-1:end)]);
                    timeEC(k,1) = min+sec+hun;
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Ascend');

        elseif strcmpi(colsource, 'SkillTime') | strcmpi(colsource, 'SwimTime');
            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                index = strfind(val, 's');
                if isempty(index) == 0;
                    timeEC(k,1) = str2num(val(1:index-2));
                else;
                    index = strfind(val, ':');
                    valsec = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                    timeEC(k,1) = valsec;
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Ascend');

        elseif strcmpi(colsource, 'StartTime') | strcmpi(colsource, 'TurnTime') | strcmpi(colsource, 'BlockTime') | ...
                strcmpi(colsource, 'DropOff');
            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                if isempty(str2num(val)) == 1;
                    timeEC(k,1) = 10000;
                else;
                    timeEC(k,1) = str2num(val);
                end;

% 
% 
% 
%                     if val == 0;
%                         timeEC(k,1) = 1000000;
%                     else;
%                         timeEC(k,1) = val;
%                     end;
% 
% 
% 
% 


            end;
            [sortTime, index] = sort(timeEC, 'Ascend');
            
        elseif strcmpi(colsource, 'AvTurnTime');
            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                if strcmpi(val, 'NaN00') == 1;
                    timeEC(k,1) = 0;
                elseif strcmpi(val, 'na') == 1;
                    timeEC(k,1) = 0;
                else;
                    liindex1 = strfind(val, '[');
                    timeEC(k,1) = str2num(val(1:liindex1-2));
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Ascend');

        elseif strcmpi(colsource, 'FinishTime');
            for k = 1:length(timeKeep);
                timeEC(k,1) = timeKeep{k,1};
            end;
            [sortTime, index] = sort(timeEC, 'Ascend');

        elseif strcmpi(colsource, 'OtherTime') | strcmpi(colsource, 'LapTime');
            for k = 1:length(timeKeep);
                timeEC(k,1) = timeKeep(k,1);
            end;
            [sortTime, index] = sort(timeEC, 'Ascend');

        elseif strcmpi(colsource, 'OtherVal')
            timeEC = timeKeep;
            [sortTime, index] = sort(timeEC, 'Descend');

        elseif strcmpi(colsource, 'UWSpeed') | strcmpi(colsource, 'SwimSpeed') | strcmpi(colsource, 'StrokeEff') | ...
                strcmpi(colsource, 'BODist') | strcmpi(colsource, 'EntryDist');

            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                if strcmpi(val, 'NaN00') == 1;
                    timeEC(k,1) = 0;
                elseif strcmpi(val, 'na') == 1;
                    timeEC(k,1) = 0;
                else;
                    timeEC(k,1) = str2num(val);
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Descend');
        
        elseif strcmpi(colsource, 'DecayIndex');

            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                if strcmpi(val, 'NaN00') == 1;
                    timeEC(k,1) = 0;
                else;
                    timeEC(k,1) = val;
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Descend');

        elseif strcmpi(colsource, 'BOEff') | strcmpi(colsource, 'AppEff');
            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                if strcmpi(val, 'NaN00') == 1;
                    timeEC(k,1) = 0;
                else;
                    liindex1 = strfind(val, '[');
                    timeEC(k,1) = str2num(val(1:liindex1-2));
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Descend');
            
        elseif strcmpi(colsource, 'MaxVel') | strcmpi(colsource, 'MaxSR') | strcmpi(colsource, 'MaxDPS');
            for k = 1:length(timeKeep);
                val = timeKeep{k,1};
                liindex1 = strfind(val, '/');
                liindex2 = strfind(val, '[');
                timeEC(k,1) = str2num(val(liindex1+2:liindex2-2));
            end;
            [sortTime, index] = sort(timeEC, 'Descend');

        elseif strcmpi(colsource, 'SpeedDecay');
            for k = 1:length(timeKeep);
                valZones = timeKeep{k,1};
                if length(timeKeep{k,1}) > 1;
                    %4 values (IM races)
                    timeEC(k,1) = mean(valZones(:,1)) + mean(valZones(8));
                else;
                    timeEC(k,1) = valZones(1) + valZones(8);
                end;
            end;
            [sortTime, index] = sort(timeEC, 'Descend');
        end;

        likeepPBs = [likeepPBs likeepName(index(1))];
        nameDone{1,1} = nameSelect;
        iter = 2;
    end;
end;

if isempty(likeepPBs) == 1;
    classifierFILT = [];
else;
    classifierFILT = classifier(likeepPBs,:);
end;


