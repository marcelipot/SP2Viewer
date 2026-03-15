%centile and diff to best for speed decay
timeECrace = [];
timeECelement = [];
timeEC = [];

if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
%     if SearchDistance == 50 | SearchDistance == 100;
        colACT = 61;
%     elseif SearchDistance == 150 | SearchDistance == 200 | SearchDistance == 400;
%         colACT = 62;
%     else;
%         colACT = 63;
%     end;
    
    databaseGroup = databaseGroupSave;
    classifier = databaseGroup(:,colACT);
    if valPB == 2;
        %filter down to PB, SB, CB (based on race time)
        classifierName = databaseGroup(:,2);
        colsource = 'SpeedDecay';
        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
        classifier = classifierFILT;
        databaseGroup = databaseGroup(likeepPBs,:);
    end;
    for i = 1:length(databaseGroup(:,1));
        if strcmpi(SearchStroke, 'Medley') == 1;
            valZones = classifier{i,1};
            timeEC(i,1) = mean(valZones(:,1)) + mean(valZones(:,8));
        else;
            valZones = classifier{i,1};
            timeEC(i,1) = valZones(1) + valZones(8);
        end;
    end;
    [timeECelement, indexelement] = sort(timeEC, 'Descend');
    namelist = databaseGroup(indexelement,2);
    nameBestSpeedDecay = namelist{1,1};
    
    timeEC = [];
    databaseGroup = databaseGroupTime;
    classifier = databaseGroup(:,colACT);
    if valPB == 2;
        %filter down to PB, SB, CB (based on race time)
        classifierName = databaseGroup(:,2);
        colsource = 'SpeedDecay';
        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
        classifier = classifierFILT;
        databaseGroup = databaseGroup(likeepPBs,:);
    end;
    for i = 1:length(databaseGroup(:,1));
        if strcmpi(SearchStroke, 'Medley') == 1;
            valZones = classifier{i,1};
            timeEC(i,1) = mean(valZones(:,1)) + mean(valZones(:,8));
        else;
            valZones = classifier{i,1};
            timeEC(i,1) = valZones(1) + valZones(8);
        end;
    end;
    [timeECrace, indexrace] = sort(timeEC, 'Descend');
    
else;
%     if SearchDistance == 50 | SearchDistance == 100;
        colACT = 61;
%     elseif SearchDistance == 150 | SearchDistance == 200 | SearchDistance == 400;
%         colACT = 62;
%     else;
%         colACT = 63;
%     end;
    timeEC = [];
    timeECrace = [];
    timeECelement = [];
    classifier = [];

    databaseGroup = databaseGroupSave;
    for i = 1:length(databaseGroup(:,colACT));
        val = databaseGroup{i,colACT};
        if strcmpi(LegOption, 'Butterfly Only');
            leg = 1;
%             leg_ini = 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Backstroke Only');
            leg = 2;
%             leg_ini = (NbLap./4) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Breaststroke Only');
            leg = 3;
%             leg_ini = (2.*(NbLap./4)) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Freestyle Only');
            leg = 4;
%             leg_ini = (3.*(NbLap./4)) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        end;
%         classifier(i,1) = mean(val(leg_ini:leg_end));
        valZones = val(leg,:);
        classifier(i,1) = valZones(1) + valZones(8);
    end;
    if valPB == 2;
        %filter down to PB, SB, CB (based on race time)
        classifierName = databaseGroup(:,2);
        colsource = 'OtherVal';
        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
        classifier = classifierFILT;
        databaseGroup = databaseGroup(likeepPBs,:);    
    end;
    timeEC = classifier;
    [timeECelement, indexelement] = sort(timeEC, 'Descend');
    namelist = databaseGroup(indexelement,2);
    nameBestSpeedDecay = namelist{1,1};
    
    timeEC = [];
    databaseGroup = databaseGroupTime;
    for i = 1:length(databaseGroup(:,colACT));
        val = databaseGroup{i,colACT};
%         if strcmpi(LegOption, 'Butterfly Only');
%             leg_ini = 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
%         elseif strcmpi(LegOption, 'Backstroke Only');
%             leg_ini = (NbLap./4) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
%         elseif strcmpi(LegOption, 'Breaststroke Only');
%             leg_ini = (2.*(NbLap./4)) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
%         elseif strcmpi(LegOption, 'Freestyle Only');
%             leg_ini = (3.*(NbLap./4)) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
%         end;
%         classifier(i,1) = mean(val(leg_ini:leg_end));

        if strcmpi(LegOption, 'Butterfly Only');
            leg = 1;
%             leg_ini = 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Backstroke Only');
            leg = 2;
%             leg_ini = (NbLap./4) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Breaststroke Only');
            leg = 3;
%             leg_ini = (2.*(NbLap./4)) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Freestyle Only');
            leg = 4;
%             leg_ini = (3.*(NbLap./4)) + 1;
%             leg_end = leg_ini + (NbLap./4) - 1;
        end;
%         classifier(i,1) = mean(val(leg_ini:leg_end));
        valZones = val(leg,:);
        classifier(i,1) = valZones(1) + valZones(8);

    end;
    timeEC = classifier;
    [timeECrace, indexrace] = sort(timeEC, 'Descend');
end;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if graphType == 4;
    timeECSelect = [];
    if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
        val = databaseSelect{:,colACT};
        if strcmpi(LegOption, 'Butterfly Only');
            leg = 1;
        elseif strcmpi(LegOption, 'Backstroke Only');
            leg = 2;
        elseif strcmpi(LegOption, 'Breaststroke Only');
            leg = 3;
        elseif strcmpi(LegOption, 'Freestyle Only');
            leg = 4;
        end;
        valZones = val(leg,:);
        classifier = valZones(1) + valZones(8);

%         classifier = databaseSelect(:,colACT);
        for i = 1:length(databaseSelect(:,1));
            valTOT = classifier{i,1};
            timeECSelect(i,1) = mean(valTOT);
        end;
        [timeECSelect, indexSelect] = sort(timeECSelect, 'Descend');
    else;
        for i = 1:length(databaseSelect(:,colACT));
            val = databaseSelect{i,colACT};
            classifier(i,1) = mean(val(leg_ini:leg_end));
        end;
        timeECSelect = classifier;
%         e=e %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




for loop = 1:3;
    timeACT = [];
    if loop == 1
        if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
            valZones = databaseCurrent{1,colACT};
            val = mean(valZones(:,1)) + mean(valZones(:,8));
        else;
            valZones = databaseCurrent{1,colACT};
            if strcmpi(LegOption, 'Butterfly Only');
                leg = 1;
            elseif strcmpi(LegOption, 'Backstroke Only');
                leg = 2;
            elseif strcmpi(LegOption, 'Breaststroke Only');
                leg = 3;
            elseif strcmpi(LegOption, 'Freestyle Only');
                leg = 4;
            end;
            valZones = valZones(leg,:);
            val = valZones(1) + valZones(8);
%             val = databaseCurrent{1,colACT};
        end;

    elseif loop == 2;
        if isempty(databaseCurrentPB) == 0;
            if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
                valZones = databaseCurrentPB{1,colACT};
                val = mean(valZones(:,1)) + mean(valZones(:,8));
            else;
                valZones = databaseCurrentPB{1,colACT};
                if strcmpi(LegOption, 'Butterfly Only');
                    leg = 1;
                elseif strcmpi(LegOption, 'Backstroke Only');
                    leg = 2;
                elseif strcmpi(LegOption, 'Breaststroke Only');
                    leg = 3;
                elseif strcmpi(LegOption, 'Freestyle Only');
                    leg = 4;
                end;
                valZones = valZones(leg,:);
                val = valZones(1) + valZones(8);
%                 val = databaseCurrentPB{1,colACT};
            end;
        else;
            val = 0;
        end;

    elseif loop == 3;
        if isempty(databaseCurrentSB) == 0;
            if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
                valZones = databaseCurrentSB{1,colACT};
                val = mean(valZones(:,1)) + mean(valZones(:,8));
            else;
                valZones = databaseCurrentSB{1,colACT};
                if strcmpi(LegOption, 'Butterfly Only');
                    leg = 1;
                elseif strcmpi(LegOption, 'Backstroke Only');
                    leg = 2;
                elseif strcmpi(LegOption, 'Breaststroke Only');
                    leg = 3;
                elseif strcmpi(LegOption, 'Freestyle Only');
                    leg = 4;
                end;
                valZones = valZones(leg,:);
                val = valZones(1) + valZones(8);
%                 val = databaseCurrentSB{1,colACT};
            end;
        else;
            if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
                val = 0;
            else;
                val = 0;
            end;
        end;
    end;

    if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
        for i = 1:length(val);
            timeACT(i) = val;
        end;
        timeACT = mean(timeACT);
    else;
        for i = 1:length(val);
            timeACT(i) = val;
        end;
        timeACT = mean(timeACT);
    end;

    diffTimeelement = timeECelement-timeACT;
    indexelement = find(diffTimeelement <= 0); %if < 0, worse than the current athlete
    if isempty(indexelement) == 1;
        indexelement = length(timeECelement);
    end;

    diffTimerace = timeECrace-timeACT;
    indexrace = find(diffTimerace <= 0); %if < 0, worse than the current athlete
    if isempty(indexrace) == 1;
        indexrace = length(timeECrace);
    end;
    
    if loop == 1;
        if graphType == 1;
            startGroup = 1;
            endGroup = 1;
        elseif graphType == 2;
            startGroup = 1;
            endGroup = 3;
        elseif graphType == 3;
            startGroup = 1;
            endGroup = 8;
        elseif graphType == 4;
            startGroup = 1;
            endGroup = 1;
        end;
        timeRefelement = mean(timeECelement(startGroup:endGroup));
        timeRefrace = mean(timeECrace(startGroup:endGroup));

        posSpeedDecayelement = indexelement(1);
        if posSpeedDecayelement == 1;
            rankSpeedDecayelement = 0;
        else;
            rankSpeedDecayelement = roundn(((indexelement(1))./length(timeECelement)).*100,-1);
        end;

        posSpeedDecayrace = indexrace(1);
        if posSpeedDecayrace == 1;
            rankSpeedDecayrace = 0;
        else;
            rankSpeedDecayrace = roundn(((indexrace(1))./length(timeECrace)).*100,-1);
        end;
        
        if graphType == 4;
            diff2bestSpeedDecayelement = [timeACT-timeECSelect timeACT timeECSelect];
            diff2bestSpeedDecayrace = diff2bestStrokeEffelement;
        else;
            diff2bestSpeedDecayelement = [timeACT-timeRefelement timeACT timeRefelement];
            diff2bestSpeedDecayrace = [timeACT-timeRefrace timeACT timeRefrace];
        end;
               
    elseif loop == 2;
        if isempty(databaseCurrentPB) == 0;
            posSpeedDecayPB = index(1);
            if posSpeedDecayPB == 1;
                rankSpeedDecayPB = 0;
            else;
                rankSpeedDecayPB = roundn(((index(1))./length(timeEC)).*100,-1);
            end;

            if graphType == 4;
                diff2bestSpeedDecayelementPB = [timeACT-timeECSelect timeACT timeECSelect];
                diff2bestSpeedDecayracePB = diff2bestStrokeEffelement;
            else;
                diff2bestSpeedDecayelementPB = [timeACT-timeRefelement timeACT timeRefelement];
                diff2bestSpeedDecayracePB = [timeACT-timeRefrace timeACT timeRefrace];
            end;
        else;
            posSpeedDecayPB = 0;
            rankSpeedDecayPB = 0;
            diff2bestSpeedDecayelementPB = [0 0 0];
            diff2bestSpeedDecayracePB = [0 0 0];
        end;
    elseif loop == 3;
        if isempty(databaseCurrentSB) == 0;
            posSpeedDecaySB = index(1);
            if posSpeedDecaySB == 1;
                rankSpeedDecaySB = 0;
            else;
                rankSpeedDecaySB = roundn(((index(1))./length(timeEC)).*100,-1);
            end;

            if graphType == 4;
                diff2bestSpeedDecayelementSB = [timeACT-timeECSelect timeACT timeECSelect];
                diff2bestSpeedDecayraceSB = diff2bestStrokeEffelement;
            else;
                diff2bestSpeedDecayelementSB = [timeACT-timeRefelement timeACT timeRefelement];
                diff2bestSpeedDecayraceSB = [timeACT-timeRefrace timeACT timeRefrace];
            end;
        else;
            posSpeedDecaySB = 0;
            rankSpeedDecaySB = 0;
            diff2bestSpeedDecayelementSB = [0 0 0];
            diff2bestSpeedDecayraceSB = [0 0 0];
        end;
    end;
end;
handles.diff2bestSpeedDecayelement = diff2bestSpeedDecayelement;
handles.diff2bestSpeedDecayrace = diff2bestSpeedDecayrace;
handles.rankSpeedDecayelement = rankSpeedDecayelement;
handles.rankSpeedDecayrace = rankSpeedDecayrace;
handles.posSpeedDecayelement = posSpeedDecayelement;
handles.posSpeedDecayrace = posSpeedDecayrace;
