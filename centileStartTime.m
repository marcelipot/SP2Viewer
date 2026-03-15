%centile and diff to best for Start Time
timeEC = [];
timeECrace = [];
timeECelement = [];

if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
    colACT = 22;
    
    databaseGroup = databaseGroupSave;
    classifier = databaseGroup(:,colACT);
    if valPB == 2;
        %filter down to PB, SB, CB (based on race time)
        classifierName = databaseGroup(:,2);
        colsource = 'StartTime';
        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
        classifier = classifierFILT;
        databaseGroup = databaseGroup(likeepPBs,:);
    end;
    for i = 1:length(databaseGroup(:,1));
        val = classifier{i,1};
        timeEC(i,1) = str2num(val);
    end;
    [timeECelement, indexelement] = sort(timeEC, 'Ascend');
    namelist = databaseGroup(indexelement,2);
    nameBestStartTime = namelist{1,1};

    timeEC = [];
    databaseGroup = databaseGroupTime;
    classifier = databaseGroup(:,colACT);
    for i = 1:length(databaseGroup(:,1));
        val = classifier{i,1};
        timeEC(i,1) = str2num(val);
    end;
    [timeECrace, indexrace] = sort(timeEC, 'Ascend');
    
else;
    colACT = 22;
    timeEC = [];
    timeECrace = [];
    timeECelement = [];
    classifier = [];
    
    databaseGroup = databaseGroupSave;
    if strcmpi(LegOption, 'Butterfly Only');
        classifier = databaseGroup(:,colACT);
        if valPB == 2;
            %filter down to PB, SB, CB (based on race time)
            classifierName = databaseGroup(:,2);
            colsource = 'StartTime';
            [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
            classifier = classifierFILT;
            databaseGroup = databaseGroup(likeepPBs,:);
        end;
        for i = 1:length(databaseGroup(:,1));
            val = classifier{i,1};
            timeEC(i,1) = str2num(val);
        end;
    else;
        timeEC = zeros(length(databaseGroup(:,1)), 1);
    end;
    [timeECelement, indexelement] = sort(timeEC, 'Ascend');
    namelist = databaseGroup(indexelement,2);
    nameBestStartTime = namelist{1,1};
    
    timeEC = [];
    databaseGroup = databaseGroupTime;
    if strcmpi(LegOption, 'Butterfly Only');
        classifier = databaseGroup(:,colACT);
        for i = 1:length(databaseGroup(:,1));
            val = classifier{i,1};
            timeEC(i,1) = str2num(val);
        end;
    else;
        timeEC = zeros(length(databaseGroup(:,1)), 1);
    end;
    [timeECrace, indexrace] = sort(timeEC, 'Ascend');
end;

if graphType == 4;
    timeECSelect = [];
    if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
        classifier = databaseSelect(:,colACT);
        for i = 1:length(databaseSelect(:,1));
            val = classifier{i,1};
            timeECSelect(i,1) = str2num(val);
        end;
        [timeECSelect, indexSelect] = sort(timeECSelect, 'Ascend');
    else;
        if strcmpi(LegOption, 'Butterfly Only');
            classifier = databaseSelect(:,colACT);
            for i = 1:length(databaseSelect(:,1));
                val = classifier{i,1};
                timeECSelect(i,1) = str2num(val);
            end;
            [timeECSelect, indexSelect] = sort(timeECSelect, 'Ascend');
        else;
            timeECSelect = 0;
            indexSelect = 1;
        end;
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
    timeACT = str2num(val);

    diffTimeelement = timeECelement-timeACT;
    indexelement = find(diffTimeelement >= 0); %if < 0, slower than the current athlete
    if isempty(indexelement) == 1;
        indexelement = length(timeECelement);
    end;
    diffTimerace = timeECrace-timeACT;
    indexrace = find(diffTimerace >= 0); %if < 0, slower than the current athlete
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
        
        posStartTimeelement = indexelement(1);
        if posStartTimeelement == 1;
            rankStartTimeelement = 0;
        else;
            rankStartTimeelement = roundn(((indexelement(1))./length(timeECelement)).*100,-1);
        end;
        posStartTimerace = indexrace(1);
        if posStartTimerace == 1;
            rankStartTimerace = 0;
        else;
            rankStartTimerace = roundn(((indexrace(1))./length(timeECrace)).*100,-1);
        end;
        
        if graphType == 4;
            diff2bestStartTimeelement = [timeACT-timeECSelect timeACT timeECSelect];
            diff2bestStartTimerace = diff2bestStartTimeelement;
        else;
            diff2bestStartTimeelement = [timeACT-timeRefelement timeACT timeRefelement];
            diff2bestStartTimerace = [timeACT-timeRefrace timeACT timeRefrace];
        end;

    elseif loop == 2;
        if isempty(databaseCurrentPB) == 0;
            posStartTimePB = index(1);
            if posStartTimePB == 1;
                rankStartTimePB = 0;
            else;
                rankStartTimePB = roundn(((index(1))./length(timeEC)).*100,-1);
            end;

            if graphType == 4;
                diff2bestStartTimeelementPB = [timeACT-timeECSelect timeACT timeECSelect];
                diff2bestStartTimeracePB = diff2bestStartTimeelement;
            else;
                diff2bestStartTimeelementPB = [timeACT-timeRefelement timeACT timeRefelement];
                diff2bestStartTimeracePB = [timeACT-timeRefrace timeACT timeRefrace];
            end;

        else;
            posStartTimePB = 0;
            rankStartTimePB = 0;
            diff2bestStartTimeelementPB = [0 0 0];
            diff2bestStartTimeracePB = [0 0 0];
        end;
    elseif loop == 3;
        if isempty(databaseCurrentSB) == 0;
            posStartTimeSB = index(1);
            if posStartTimeSB == 1;
                rankStartTimeSB = 0;
            else;
                rankStartTimeSB = roundn(((index(1))./length(timeEC)).*100,-1);
            end;

            if graphType == 4;
                diff2bestStartTimeelementSB = [timeACT-timeECSelect timeACT timeECSelect];
                diff2bestStartTimeraceSB = diff2bestStartTimeelement;
            else;
                diff2bestStartTimeelementSB = [timeACT-timeRefelement timeACT timeRefelement];
                diff2bestStartTimeraceSB = [timeACT-timeRefrace timeACT timeRefrace];
            end;
        else;
            posStartTimeSB = 0;
            rankStartTimeSB = 0;
            diff2bestStartTimeelementSB = [0 0 0];
            diff2bestStartTimeraceSB = [0 0 0];
        end;
    end;
end;
handles.diff2bestStartTimeelement = diff2bestStartTimeelement;
handles.diff2bestStartTimerace = diff2bestStartTimerace;
handles.rankStartTimeelement = rankStartTimeelement;
handles.rankStartTimerace = rankStartTimerace;
handles.posStartTimeelement = posStartTimeelement;
handles.posStartTimerace = posStartTimerace;
