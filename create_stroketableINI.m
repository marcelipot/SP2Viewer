RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
% RaceUID = [];
% for raceEC = 1:nbRaces;
%     fileEC = handles.filelistAdded{raceEC};
%     proceed = 1;
%     iter = 1;
%     while proceed == 1;
%         raceCHECK = handles.uidDB{iter,2};
%         if strcmpi(fileEC, raceCHECK) == 1;
%             RaceUID{raceEC} = handles.uidDB{iter,1};
%             proceed = 0;
%         else;
%             iter = iter + 1;
%         end;
%     end;
% end;
set(gcf, 'units', 'pixels');
PosFig = get(gcf, 'Position');
set(gcf, 'units', 'normalized');

databaseCurrent = handles.databaseCurrent_analyser;

if strcmpi(origin, 'table') == 1;
    colorrow(1,:) = [1 0.9 0.1];
    colorrow(2,:) = [0.9 0.9 0.9];
    colorrow(3,:) = [0.75 0.75 0.75];
    colorrow(4,:) = [0.9 0.9 0.9];
    colorrow(5,:) = [0.75 0.75 0.75];
    colorrow(6,:) = [0.9 0.9 0.9];
    colorrow(7,:) = [1 1 1];
    colorrow(8,:) = [1 0.9 0.1];
    
    formatlist{1} = 'char';
    formatlist{2} = 'char';
    edittablelist(1) = false;
    edittablelist(2) = false;
    for i = 1:nbRaces;
        formatlist{i+2} = 'numeric';
        edittablelist(i+2) = false;
    end;

    PosINI = get(handles.StrokeData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosStrokeTable;
    set(handles.StrokeData_table_analyser, 'Position', posCorr);

    set(handles.StrokeData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.StrokeData_table_analyser, 'position');
    PixelTot = pos(3);
    PixelSwimmers = floor((PixelTot - 100 - 150)./nbRaces);
    if PixelSwimmers < 200;
        PixelSwimmers = 200;
        Extent = 0;
    else;
        Extent = 1;
    end;
    ColWidth = {100 150};
    for i = 3:nbRaces+2;
        ColWidth{i} = PixelSwimmers;
    end;
    set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
%     set(handles.StrokeData_table_analyser, 'Units', 'normalized');
end;

dataTableStroke = {};
dataTableStroke{1,2} = 'Metadata';
dataTableStroke{8,2} = 'Stroke Management';
dataTableStroke{9,1} = 'SR / SL / Stroke';

% SectionSRALL = [];
% SectionSDALL = [];
% SectionVelALL = [];
% SectionSRALLbis = [];
% SectionSDALLbis = [];
% SectionVelALLbis = [];

for i = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
%     UID = RaceUID{i-2};
%     li = findstr(UID, '-');
%     UID(li) = '_';
%     UID = ['A' UID 'A'];
    mainIter = i;
    
    Source = databaseCurrent{mainIter-2,58};
%     dataTableRefDist = [5:5:RaceDist]';
    if Source == 1 | Source == 3;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverage = databaseCurrent{mainIter-2,68};
        dataTableBreath = databaseCurrent{mainIter-2,69};
        dataTableStrokeData = databaseCurrent{mainIter-2,70};
        dataTableSkill = databaseCurrent{mainIter-2,71};
        if isnan(dataTableAverage(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTableAverage(end,1) = str2num(racetimemissing);
        end;
    
    elseif Source == 2;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverage = databaseCurrent{mainIter-2,68};
        dataTableBreath = databaseCurrent{mainIter-2,69};
        dataTableSkillVAL = databaseCurrent{mainIter-2,70};
        dataTableSkillTXT = databaseCurrent{mainIter-2,71};
    end;
    if Source == 1;
        answerReport = 'SP1';
        dataTableStroke{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        answerReport = 'SP2';
        dataTableStroke{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        answerReport = 'GE';
        dataTableStroke{7,mainIter} = 'GreenEye';
    end;
    
    
    %---Metadata
    relayExist = databaseCurrent{mainIter-2,11};
    if isempty(strfind(relayExist, 'Relay')) == 0;
        isRelay = 1;
    else;
        isRelay = 0;
    end;
    if isRelay == 1;
        relayLeg = databaseCurrent{mainIter-2,11};
        index1 = strfind(relayLeg, '(');
        index2 = strfind(relayLeg, ')');
        relayLeg = relayLeg(index1+1:index2-1);
        RelayType = [databaseCurrent{mainIter-2,53} ' (' relayLeg ')'];
    else;
        RelayType = 'Individual';
    end;
    valRelay = databaseCurrent{mainIter-2,11};
    detailRelay = databaseCurrent{mainIter-2,53};

    AthletenameFull = databaseCurrent{mainIter-2,2};
    index = strfind(AthletenameFull, ' ');
    Athletename = [AthletenameFull(index(end)+1:end) AthletenameFull(1)];
    eval(['dataTableStroke{2,' num2str(mainIter) '} = Athletename;']);
    
    Meet = databaseCurrent{mainIter-2,7};
    Stage = databaseCurrent{mainIter-2,6};
    Year = databaseCurrent{mainIter-2,8};
    StrokeType = databaseCurrent{mainIter-2,4};
    RaceDist = str2num(databaseCurrent{mainIter-2,3});
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableStroke{3,' num2str(mainIter) '} = str;']);  
    Course = str2num(databaseCurrent{mainIter-2,10});

    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableStroke{5,' num2str(mainIter) '} = str;']);
    
%     eval(['splitAll = handles.RacesDB.' UID '.splitAll;']);
    if Source == 1 | Source == 3;
        colinterest_Splits = 2;
        TTtxt = timeSecToStr(dataTableAverage(end,colinterest_Splits));
        splitAll = dataTableAverage(:,colinterest_Splits);
    else;
        colinterest_Splits = 12;
        TTtxt = timeSecToStr(dataTableAverage{end,colinterest_Splits});
        splitAll = cell2mat(dataTableAverage(:,colinterest_Splits));
    end;
    dataTableStroke{6,mainIter} = TTtxt;

    idx = isstrprop(Meet,'upper');
    MeetShort = Meet(idx);
    if strcmpi(Stage, 'Semi-Final');
        StageShort = 'SF';
    elseif strcmpi(Stage, 'Semi-final');
        StageShort = 'SF';
    else;
        StageShort = Stage;
    end;
    YearShort = Year(3:4);
    graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
    storeTitle2{i-2} = graphTitle2;
    

    %---------------------------------Stroke-------------------------------
    NbLap = RaceDist./Course;
    if i == 3;
        colorrow(9,:) = [1 0.9 0.70];
        lineEC = 10;
        for lap = 1:NbLap;
            dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-25m';

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];

                lineEC = lineEC + 6;
            else;
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-25m';
                dataTableStroke{lineEC+6,2} = '25m-30m';
                dataTableStroke{lineEC+7,2} = '30m-35m';
                dataTableStroke{lineEC+8,2} = '35m-40m';
                dataTableStroke{lineEC+9,2} = '40m-45m';
                dataTableStroke{lineEC+10,2} = '45m-50m';

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];
                colorrow(lineEC+6,:) = [0.75 0.75 0.75];
                colorrow(lineEC+7,:) = [0.9 0.9 0.9];
                colorrow(lineEC+8,:) = [0.75 0.75 0.75];
                colorrow(lineEC+9,:) = [0.9 0.9 0.9];
                colorrow(lineEC+10,:) = [0.75 0.75 0.75];

                lineEC = lineEC + 11;
            end;
        end;
    end;

    lineEC = 10;
    keyDist = Course:Course:RaceDist;
    dataTableRefDist = [5:5:RaceDist]';

    if Source == 1 | Source == 3;
        colinterest_Splits = 1;
        colinterest_SplitsInterp = 4;

        colinterest_Speed = 5;
        colinterest_SpeedInterp = 4; %use split interpolation
        
        colinterest_DPS = 5;
        colinterest_DPSInterp = 8;

        colinterest_SR = 1;
        colinterest_SRInterp = 4;

        colinterest_Nb = 9;

    elseif Source == 2;
        colinterest_Splits = 11;
        colinterest_SplitsInterp = [];

        colinterest_Speed = 2;
        colinterest_SpeedInterp = [];

        colinterest_DPS = 8;
        colinterest_DPSInterp = [];

        colinterest_SR = 5;
        colinterest_SRInterp = [];

        colinterest_Nb = 14;
    end;

    addLap = 0;
    lastIterValid = 0;
    for iter = 1:length(dataTableAverage(:,1));
        
        if Source == 1 | Source == 3;
            if isnan(dataTableStrokeData(iter,colinterest_DPS)) == 1 | dataTableStrokeData(iter,colinterest_DPS) == 0;
                SDtxt = '  -  ';
            else;
                if dataTableStrokeData(iter,colinterest_DPSInterp) == 1;
                    SDtxt = [dataToStr(dataTableStrokeData(iter,colinterest_DPS),2) ' m !'];
                else;
                    SDtxt = [dataToStr(dataTableStrokeData(iter,colinterest_DPS),2) ' m  '];
                end;
            end;

            if isnan(dataTableStrokeData(iter,colinterest_SR)) == 1 | dataTableStrokeData(iter,colinterest_SR) == 0;
                SRtxt = '  -  ';
            else;
                if dataTableStrokeData(iter,colinterest_SRInterp) == 1;
                    SRtxt = [dataToStr(dataTableStrokeData(iter,colinterest_SR),1) ' str/min !'];
                else;
                    SRtxt = [dataToStr(dataTableStrokeData(iter,colinterest_SR),1) ' str/min  '];
                end;
            end;

            if isnan(dataTableStrokeData(iter,colinterest_Nb)) == 1 | dataTableStrokeData(iter,colinterest_Nb) == 0;
                Nbtxt = '  -  ';
            else;
                Nbtxt = [dataToStr(dataTableStrokeData(iter,colinterest_Nb),0) ' str'];
            end;

        elseif Source == 2;   
            if isempty(dataTableAverage{iter,colinterest_DPS}) == 1;
                SDtxt = '  -  ';
            else;
                if isnan(dataTableAverage{iter,colinterest_DPS}) == 1 | dataTableAverage{iter,colinterest_DPS} == 0;
                    SDtxt = '  -  ';
                else;
                    SDtxt = [dataToStr(dataTableAverage{iter,colinterest_DPS},2) ' m  '];
                end;
            end;

            if isempty(dataTableAverage{iter,colinterest_SR}) == 1;
                SRtxt = '  -  ';
            else;
                if isnan(dataTableAverage{iter,colinterest_SR}) == 1 | dataTableAverage{iter,colinterest_SR} == 0;
                    SRtxt = '  -  ';
                else;
                    SRtxt = [dataToStr(dataTableAverage{iter,colinterest_SR},1) ' str/min  '];
                end;
            end;

            if isempty(dataTableAverage{iter,colinterest_Nb}) == 1;
                Nbtxt = '  -  ';
            else;
                if isnan(dataTableAverage{iter,colinterest_Nb}) == 1 | dataTableAverage{iter,colinterest_Nb} == 0;
                    Nbtxt = '  -  ';
                else;
                    Nbtxt = [dataToStr(dataTableAverage{iter,colinterest_Nb},0) ' str'];
                end;
            end;
        end;

%         if strcmpi(STtxt, '  -  ') == 1;
%             data = [SRtxt '  /  ' CTtxt '  /    -  '];
%         else;
            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
%         end;
        eval(['dataTableStroke{' num2str(lineEC+iter+addLap) ',' num2str(i) '} = data;']);

        index = find(keyDist == dataTableRefDist(iter));
        if isempty(index) == 0;
            addLap = addLap + 1;
        end;
    end;
end;

handles.dataTableStroke = dataTableStroke;
handles.colorrowStroke = colorrow;

if strcmpi(origin, 'table');
    set(handles.StrokeData_table_analyser, 'data', dataTableStroke, 'backgroundcolor', colorrow); %'RowName', rowNameList,
    set(handles.SkillData_table_analyser, 'Visible', 'off');
    set(handles.PacingData_table_analyser, 'Visible', 'off');
    set(handles.SummaryData_table_analyser, 'Visible', 'off');
    
    table_extent = get(handles.StrokeData_table_analyser, 'Extent');
    table_position = get(handles.StrokeData_table_analyser, 'Position');
    pos_cor = table_position;
    if table_extent(4) < table_position(4);

        if Extent == 0;
            %Add 5% to give space for the slider bar at the bottom
            offset = 18;
            pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)-offset;
            pos_cor(4) = table_extent(4)+offset;
        else;
            pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)+1;
            pos_cor(4) = table_extent(4)+1;
        end;

    elseif table_extent(4) >= table_position(4);
        if table_position(2) < (0.0069*PosFig(4));
            pos_cor(2) = (0.0069*PosFig(4))+1;
            pos_cor(4) = (handles.TopINI_StrokeTable*PosFig(4))+1;

            offset = 18;
            PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
            if PixelSwimmers < 200;
                PixelSwimmers = 200;
                Extent = 0;
            else;
                Extent = 1;
            end;
            ColWidth = {100 150};
            for i = 3:nbRaces+2;
                ColWidth{i} = PixelSwimmers;
            end;
            set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
        else;
            if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                pos_cor(2) = (0.0069*PosFig(4))+1;
                pos_cor(4) = (handles.TopINI_StrokeTable*PosFig(4))+1;

                offset = 18;
                PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
                if PixelSwimmers < 200;
                    PixelSwimmers = 200;
                    Extent = 0;
                else;
                    Extent = 1;
                end;
                ColWidth = {100 150};
                for i = 3:nbRaces+2;
                    ColWidth{i} = PixelSwimmers;
                end;
                set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                if Extent == 0;
                    %Add 5% to give space for the slider bar at the bottom
                    offset = 18;
                    pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)-offset;
                    pos_cor(4) = table_extent(4)+offset;
                else;
                    pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)+1;
                    pos_cor(4) = table_extent(4)+1;
                end;
            end;
        end;
    end;

    if Extent == 1;
        if table_extent(3) > table_position(3);
            pos_cor(3) = table_extent(3);
        end;
    end;
    set(handles.StrokeData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
    set(handles.StrokeData_table_analyser, 'Units', 'normalized');

    PosEND = get(handles.StrokeData_table_analyser, 'Position');
    PosEND = PosEND(3);
    handles.diffPosStrokeTable = PosEND - handles.PosINI_StrokeTable;
end;



