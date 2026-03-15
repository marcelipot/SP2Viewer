RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
% RaceUID = [];
% 
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
    
    PosINI = get(handles.PacingData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosPacingTable;
    set(handles.PacingData_table_analyser, 'Position', posCorr);

    set(handles.PacingData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.PacingData_table_analyser, 'position');
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
    set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
%     set(handles.PacingData_table_analyser, 'Units', 'normalized');
end;

dataTablePacing = {};
dataTablePacing{1,2} = 'Metadata';
dataTablePacing{8,2} = 'Pacing';
dataTablePacing{9,1} = 'Splits / Cumul';
dataTablePacing{9,2} = ' / Speed';
% dataMatSplitsPacing = [];
% dataMatCumSplitsPacing = [];

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
        dataTableStroke = databaseCurrent{mainIter-2,70};
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
    eval(['dataTableAverage_Race' num2str(mainIter-2) ' = databaseCurrent{mainIter-2,68};']);

    if Source == 1;
        answerReport = 'SP1';
        dataTablePacing{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        answerReport = 'SP2';
        dataTablePacing{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        answerReport = 'GE';
        dataTablePacing{7,mainIter} = 'GreenEye';
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
    eval(['dataTablePacing{2,' num2str(mainIter) '} = Athletename;']);
    
    Meet = databaseCurrent{mainIter-2,7};
    Stage = databaseCurrent{mainIter-2,6};
    Year = databaseCurrent{mainIter-2,8};
    StrokeType = databaseCurrent{mainIter-2,4};
    RaceDist = str2num(databaseCurrent{mainIter-2,3});
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTablePacing{3,' num2str(mainIter) '} = str;']);  
    Course = str2num(databaseCurrent{mainIter-2,10});

    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTablePacing{5,' num2str(mainIter) '} = str;']);
    
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
    dataTablePacing{6,mainIter} = TTtxt;

    if Source == 1;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP1']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(splitAll(end,1)) '  -  SP1']};
    elseif Source == 2;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP2']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(splitAll(end,1)) '  -  SP2']};
    elseif Source == 3;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-GE']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(splitAll(end,1)) '  -  GE']};
    end;
    storeTitle{i-2} = graphTitle;
    storeTitleBis{i-2} = graphTitleBis;

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


    
    %---------------------------------Pacing-------------------------------
    NbLap = RaceDist./Course;
    if i == 3;
        colorrow(9,:) = [1 0.9 0.70];
        lineEC = 10;
        lineECmat = 1;
        for lap = 1:NbLap;
            dataTablePacing{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = '20m-25m';
                
%                 dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
%                 dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
%                 dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
%                 dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
%                 dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];

                lineEC = lineEC + 6;
                lineECmat = lineECmat + 5;
            else;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = '20m-25m';
                dataTablePacing{lineEC+6,2} = '25m-30m';
                dataTablePacing{lineEC+7,2} = '30m-35m';
                dataTablePacing{lineEC+8,2} = '35m-40m';
                dataTablePacing{lineEC+9,2} = '40m-45m';
                dataTablePacing{lineEC+10,2} = '45m-50m';
                
%                 dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
%                 dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
%                 dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
%                 dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
%                 dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
%                 dataMatSplitsPacing(lineECmat+5, 1) = (Course*(lap-1)) + 30;
%                 dataMatSplitsPacing(lineECmat+6, 1) = (Course*(lap-1)) + 35;
%                 dataMatSplitsPacing(lineECmat+7, 1) = (Course*(lap-1)) + 40;
%                 dataMatSplitsPacing(lineECmat+8, 1) = (Course*(lap-1)) + 45;
%                 dataMatSplitsPacing(lineECmat+9, 1) = (Course*(lap-1)) + 50;

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
                colorrow(lineEC+11,:) = [0.9 0.9 0.9];

                lineEC = lineEC + 11;
                lineECmat = lineECmat + 10;
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
    elseif Source == 2;
        colinterest_Splits = 11;
        colinterest_SplitsInterp = [];

        colinterest_Speed = 2;
        colinterest_SpeedInterp = [];

        colinterest_DPS = 8;
        colinterest_DPSInterp = [];

        colinterest_SR = 5;
        colinterest_SRInterp = [];
    end;

    addLap = 0;
    lastIterValid = 0;
    for iter = 1:length(dataTableAverage(:,1));
        
        if Source == 1 | Source == 3;
            if isnan(dataTableAverage(iter,colinterest_Speed)) == 1 | dataTableAverage(iter,colinterest_Speed) == 0;
                VELtxt = '  -  ';
            else;
                if dataTableAverage(iter,colinterest_SpeedInterp) == 1;
                    VELtxt = [dataToStr(dataTableAverage(iter,colinterest_Speed),2) ' m/s !'];
                else;
                    VELtxt = [dataToStr(dataTableAverage(iter,colinterest_Speed),2) ' m/s  '];
                end;
            end;

            if isnan(dataTableAverage(iter,colinterest_Splits)) == 1 | dataTableAverage(iter,colinterest_Splits) == 0;
                STtxt = '  -  ';
                CTtxt = '  -  ';
            else;
                if dataTableAverage(iter,colinterest_SplitsInterp) == 1;
                    if dataTableAverage(iter,colinterest_Splits) < 60;
                        CTtxt = [timeSecToStr2(dataTableAverage(iter,colinterest_Splits)) 's !'];
                    else;
                        CTtxt = [timeSecToStr2(dataTableAverage(iter,colinterest_Splits)) '  !'];
                    end;
                else;
                    if dataTableAverage(iter,colinterest_Splits) < 60;
                        CTtxt = [timeSecToStr2(dataTableAverage(iter,colinterest_Splits)) 's  '];
                    else;
                        CTtxt = [timeSecToStr2(dataTableAverage(iter,colinterest_Splits)) '   '];
                    end;
                end;
                if lastIterValid == 0;
                    splitTime = dataTableAverage(iter,colinterest_Splits);
                else;
                    splitTime = dataTableAverage(iter,colinterest_Splits) - dataTableAverage(lastIterValid,colinterest_Splits);
                end;
                if dataTableAverage(iter,colinterest_SplitsInterp) == 1;
                    if splitTime < 60;
                        STtxt = [timeSecToStr2(splitTime) 's !'];
                    else;
                        STtxt = [timeSecToStr2(splitTime) '  !'];
                    end;
                else;
                    if splitTime < 60;
                        STtxt = [timeSecToStr2(splitTime) 's  '];
                    else;
                        STtxt = [timeSecToStr2(splitTime) '   '];
                    end;
                end;
                lastIterValid = iter;
            end;

              
        elseif Source == 2;   
            if isempty(dataTableAverage{iter,colinterest_Speed}) == 1;
                VELtxt = '  -  ';
            else;
                if isnan(dataTableAverage{iter,colinterest_Speed}) == 1 | dataTableAverage{iter,colinterest_Speed} == 0;
                    VELtxt = '  -  ';
                else;
                    VELtxt = [dataToStr(dataTableAverage{iter,colinterest_Speed},2) ' m/s  '];
                end;
            end;

            if isempty(dataTableAverage{iter,colinterest_Splits}) == 1;
                STtxt = '  -  ';
                CTtxt = '  -  ';
            else;
                if isnan(dataTableAverage{iter,colinterest_Splits}) == 1 | dataTableAverage{iter,colinterest_Splits} == 0;
                    STtxt = '  -  ';
                    CTtxt = '  -  ';
                else;
                    if dataTableAverage{iter,colinterest_Splits} < 60;
                        CTtxt = [timeSecToStr2(dataTableAverage{iter,colinterest_Splits}) 's  '];
                    else;
                        CTtxt = [timeSecToStr2(dataTableAverage{iter,colinterest_Splits}) '   '];
                    end;
                    if lastIterValid == 0;
                        splitTime = dataTableAverage{iter,colinterest_Splits};
                    else;
                        splitTime = dataTableAverage{iter,colinterest_Splits} - dataTableAverage{lastIterValid,colinterest_Splits};
                    end;
                    if splitTime < 60;
                        STtxt = [timeSecToStr2(splitTime) 's  '];
                    else;
                        STtxt = [timeSecToStr2(splitTime) '   ']; 
                    end;
                    lastIterValid = iter;
                end;
            end;
            
        end;
        if strcmpi(STtxt, '  -  ') == 1;
            data = [STtxt '  /  ' CTtxt '  /    -  '];
        else;
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
        end;
        eval(['dataTablePacing{' num2str(lineEC+iter+addLap) ',' num2str(i) '} = data;']);

        index = find(keyDist == dataTableRefDist(iter));
        if isempty(index) == 0;
            addLap = addLap + 1;
        end;
    end;
    
end;

if strcmpi(origin, 'table') == 1;
    handles.dataTablePacing = dataTablePacing;
    handles.colorrowPacing = colorrow;

    set(handles.StrokeData_table_analyser, 'Visible', 'off');
    set(handles.SkillData_table_analyser, 'Visible', 'off');
    set(handles.PacingData_table_analyser, 'data', dataTablePacing, 'backgroundcolor', colorrow);
    set(handles.SummaryData_table_analyser, 'Visible', 'off');
    
    table_extent = get(handles.PacingData_table_analyser, 'Extent');
    table_position = get(handles.PacingData_table_analyser, 'Position');
    pos_cor = table_position;
    if table_extent(4) < table_position(4);
        
        if Extent == 0;
            %Add 5% to give space for the slider bar at the bottom
            offset = 18;
            pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)-offset;
            pos_cor(4) = table_extent(4)+offset;
        else;
            pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)+1;
            pos_cor(4) = table_extent(4)+1;
        end;
        
    elseif table_extent(4) >= table_position(4);
        if table_position(2) < (0.0069*PosFig(4));
            pos_cor(2) = (0.0069*PosFig(4))+1;
            pos_cor(4) = (handles.TopINI_PacingTable*PosFig(4))+1;
            
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
            set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
        else;
            if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                pos_cor(2) = (0.0069*PosFig(4))+1;
                pos_cor(4) = (handles.TopINI_PacingTable*PosFig(4))+1;
                
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
                set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                if Extent == 0;
                    %Add 5% to give space for the slider bar at the bottom
                    offset = 18;
                    pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)-offset;
                    pos_cor(4) = table_extent(4)+offset;
                else;
                    pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)+1;
                    pos_cor(4) = table_extent(4)+1;
                end;
            end;
        end;
    end;
    
    if Extent == 1;
        if table_extent(3) > table_position(3);
            pos_cor(3) = table_extent(3)+1;
        end;
    end;
    set(handles.PacingData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
    set(handles.PacingData_table_analyser, 'Units', 'normalized');
    
    PosEND = get(handles.PacingData_table_analyser, 'Position');
    PosEND = PosEND(3);
    handles.diffPosPacingTable = PosEND - handles.PosINI_PacingTable;
end;

