%centile and diff to best for swim speed
timeEC = [];
timeECrace = [];
timeECelement = [];

if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
    colACT = 32;

    databaseGroup = databaseGroupSave;
    classifier = databaseGroup(:,colACT);
    if valPB == 2;
        %filter down to PB, SB, CB (based on race time)
        classifierName = databaseGroup(:,2);
        colsource = 'SwimSpeed';
        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
        classifier = classifierFILT;
        databaseGroup = databaseGroup(likeepPBs,:);
    end;
    for i = 1:length(databaseGroup(:,1));
        val = classifier{i,1};
        timeEC(i,1) = str2num(val);
    end;
    [timeECelement, indexelement] = sort(timeEC, 'Descend');
    namelist = databaseGroup(indexelement,2);
    nameBestSwimSpeed = namelist{1,1};
    
    timeEC = [];
    databaseGroup = databaseGroupTime;
    classifier = databaseGroup(:,colACT);
    for i = 1:length(databaseGroup(:,1));
        val = classifier{i,1};
        timeEC(i,1) = str2num(val);
    end;
    [timeECrace, indexrace] = sort(timeEC, 'Descend');
    
else;
    colACT = 48;
    timeEC = [];
    timeECrace = [];
    timeECelement = [];
    classifier = [];
    
    databaseGroup = databaseGroupSave;
    for i = 1:length(databaseGroup(:,colACT));
        val = databaseGroup{i,colACT};
        if strcmpi(LegOption, 'Butterfly Only');
            leg_ini = 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Backstroke Only');
            leg_ini = (NbLap./4) + 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Breaststroke Only');
            leg_ini = (2.*(NbLap./4)) + 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Freestyle Only');
            leg_ini = (3.*(NbLap./4)) + 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        end;
        classifier(i,1) = mean(val(leg_ini:leg_end));
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
    nameBestSwimSpeed = namelist{1,1};
    
    timeEC = [];
    databaseGroup = databaseGroupTime;
    for i = 1:length(databaseGroup(:,colACT));
        val = databaseGroup{i,colACT};
        if strcmpi(LegOption, 'Butterfly Only');
            leg_ini = 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Backstroke Only');
            leg_ini = (NbLap./4) + 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Breaststroke Only');
            leg_ini = (2.*(NbLap./4)) + 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        elseif strcmpi(LegOption, 'Freestyle Only');
            leg_ini = (3.*(NbLap./4)) + 1;
            leg_end = leg_ini + (NbLap./4) - 1;
        end;
        classifier(i,1) = mean(val(leg_ini:leg_end));
    end;
    timeEC = classifier;
    [timeECrace, indexrace] = sort(timeEC, 'Descend'); 

end;

if graphType == 4;
    timeECSelect = [];
    if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
        classifier = databaseSelect(:,colACT);
        for i = 1:length(databaseSelect(:,1));
            val = classifier{i,1};
            timeECSelect(i,1) = str2num(val);
        end;
        [timeECSelect, indexSelect] = sort(timeECSelect, 'Descend');
    else;
        for i = 1:length(databaseSelect(:,colACT));
            val = databaseSelect{i,colACT};
            classifier(i,1) = mean(val(leg_ini:leg_end));
        end;
        timeECSelect = classifier;
    end;
end;

for loop = 1:3;
    if loop == 1
        val = databaseCurrent{1,colACT};
    elseif loop == 2;
        if isempty(databaseCurrentPB) == 0;
            val = databaseCurrentPB{1,colACT};
        else;
            val = '0.00';
        end;
    elseif loop == 3;
        if isempty(databaseCurrentSB) == 0;
            val = databaseCurrentSB{1,colACT};
        else;
            val = '0.00';
        end;
    end;

    if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
        for i = 1:length(val);
            timeACT(i) = str2num(val);
        end;
        timeACT = mean(timeACT);
    else;
        if ischar(val) == 0
            timeACT = mean(val(leg_ini:leg_end));
        else;
            timeACT = 0;
        end;
    end;
    
    diffTimeelement = timeECelement-timeACT;
    indexelement = find(diffTimeelement <= 0); %if < 0, slower than the current athlete
    if isempty(indexelement) == 1;
        indexelement = length(timeECelement);
    end;
    diffTimerace = timeECrace-timeACT;
    indexrace = find(diffTimerace <= 0); %if < 0, slower than the current athlete
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
            
        posSwimSpeedelement = indexelement(1);
        if posSwimSpeedelement == 1;
            rankSwimSpeedelement = 0;
        else;
            rankSwimSpeedelement = roundn(((indexelement(1))./length(timeECelement)).*100,-1);
        end;
        posSwimSpeedrace = indexrace(1);
        if posSwimSpeedrace == 1;
            rankSwimSpeedrace = 0;
        else;
            rankSwimSpeedrace = roundn(((indexrace(1))./length(timeECrace)).*100,-1);
        end;
        
        if graphType == 4;
            diff2bestSwimSpeedelement = [timeACT-timeECSelect timeACT timeECSelect];
            diff2bestSwimSpeedrace = diff2bestSwimSpeedelement;
        else;
            diff2bestSwimSpeedelement = [timeACT-timeRefelement timeACT timeRefelement];
            diff2bestSwimSpeedrace = [timeACT-timeRefrace timeACT timeRefrace];
        end;
            
    elseif loop == 2;
        if isempty(databaseCurrentPB) == 0;
            posSwimSpeedPB = index(1);
            if posSwimSpeedPB == 1;
                rankSwimSpeedPB = 0;
            else;
                rankSwimSpeedPB = roundn(((index(1))./length(timeEC)).*100,-1);
            end;

            if graphType == 4;
                diff2bestSwimSpeedelementPB = [timeACT-timeECSelect timeACT timeECSelect];
                diff2bestSwimSpeedracePB = diff2bestSwimSpeedelement;
            else;
                diff2bestSwimSpeedelementPB = [timeACT-timeRefelement timeACT timeRefelement];
                diff2bestSwimSpeedracePB = [timeACT-timeRefrace timeACT timeRefrace];
            end;
        else;
            posSwimSpeedPB = 0;
            rankSwimSpeedPB = 0;
            diff2bestSwimSpeedelementPB = [0 0 0];
            diff2bestSwimSpeedracePB = [0 0 0];
        end;
    elseif loop == 3;
        if isempty(databaseCurrentSB) == 0;
            posSwimSpeedSB = index(1);
            if posSwimSpeedSB == 1;
                rankSwimSpeedSB = 0;
            else;
                rankSwimSpeedSB = roundn(((index(1))./length(timeEC)).*100,-1);
            end;

            if graphType == 4;
                diff2bestSwimSpeedelementSB = [timeACT-timeECSelect timeACT timeECSelect];
                diff2bestSwimSpeedraceSB = diff2bestSwimSpeedelement;
            else;
                diff2bestSwimSpeedelementSB = [timeACT-timeRefelement timeACT timeRefelement];
                diff2bestSwimSpeedraceSB = [timeACT-timeRefrace timeACT timeRefrace];
            end;
        else;
            posSwimSpeedSB = 0;
            rankSwimSpeedSB = 0;
            diff2bestSwimSpeedelementSB = [0 0 0];
            diff2bestSwimSpeedraceSB = [0 0 0];
        end;
    end;
end;
handles.diff2bestSwimSpeedelement = diff2bestSwimSpeedelement;
handles.diff2bestSwimSpeedrace = diff2bestSwimSpeedrace;
handles.rankSwimSpeedelement = rankSwimSpeedelement;
handles.rankSwimSpeedrace = rankSwimSpeedrace;
handles.posSwimSpeedelement = posSwimSpeedelement;
handles.posSwimSpeedrace = posSwimSpeedrace;
