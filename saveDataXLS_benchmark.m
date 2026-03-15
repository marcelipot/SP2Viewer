function [] = saveDataXLS_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 1;
    %Rankins
    if handles.existRankings == 0;
        return;
    end;

    if length(handles.databaseCurrent(:,1)) >= 10;
        databaseCurrent = handles.databaseCurrentSort(1:10,1:71);
    else;
        databaseCurrent = handles.databaseCurrentSort(:,1:71);
    end;
    databaseCurrentName = handles.databaseCurrentName;

    if isempty(databaseCurrentName) == 0;
        databaseCurrent(length(databaseCurrent(:,1))+1,:) = databaseCurrentName(1,:);
    end;

elseif handles.currentBenchmarkToggle == 2;
    %Profile
    if handles.existProfile == 0;
        return;
    end;
    databaseCurrent = handles.databaseGroup_profile;
end;


nbRaces = length(databaseCurrent(:,1));

handles2 = create_AMSExportOption_database;
AMSExportType = handles2.AMSExportType;
AMSExportHeader = handles2.AMSExportHeader;
AMSExportPath = handles2.AMSExportPath;

if isempty(AMSExportPath) == 1;
    herror = errordlg('No path selected', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(herror);
    return;
end;


% hexport = waitbar(0, 'Preparing data...  0% ');
% waitbar(0, hexport, ['Preparing data...  0%'], 'fontsize', 7);
% if ispc == 1;
%     MDIR = getenv('USERPROFILE');
%     jFrame=get(handle(hexport), 'javaframe');
%     jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
%     jFrame.setFigureIcon(jicon);
%     clc;
% end;
% drawnow;

clear_figures;
RaceDistList = {};

%---time series (time, position, velocity)
strokeListMain = {'Butterfly';'Backstroke';'Breaststroke';'Freestyle';'Medley'};
distList = {'50';'100';'150';'200';'400';'800';'1500'};
courseList = {'SCM';'LCM'};

if ispc == 1;
    fontEC = 11;
elseif ismac == 1;
    fontEC = 13;
end;
resolution = get(0,'ScreenSize');
resolution = resolution(1,3:4);
pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
    'color', [0 0 0], 'units', 'pixels','position', pos,'windowstyle','modal', ...
    'Name', 'Loading', 'NumberTitle', 'off');
h1 = uicontrol('parent', h, 'style', 'text', ...
    'string', 'Exporting your data ...', 'units', 'pixels', ...
    'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
    'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
    'FontWeight', 'Bold', 'Fontsize', fontEC);


for courseIter = 1:2;
    courseEC = courseList{courseIter};
    for strokeIter = 1:5;
        strokeEC = strokeListMain{strokeIter};
        for distIter = 1:7;
            distEC = distList{distIter};
            eval(['dataSeries_' distEC strokeEC '_' courseEC ' = [];']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,1} = ' '''' 'Name' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,2} = ' '''' 'Country' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,3} = ' '''' 'DOB' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,4} = ' '''' 'Meet' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,5} = ' '''' 'Year' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,6} = ' '''' 'Stage' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,7} = ' '''' 'Stroke' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,8} = ' '''' 'Distance' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,9} = ' '''' 'Type' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,10} = ' '''' 'Relay' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,11} = ' '''' 'Course' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,12} = ' '''' 'Date' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,13} = ' '''' 'System' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,14} = ' '''' 'Time' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,15} = ' '''' 'Skill Time' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,16} = ' '''' 'Free-Swim Time' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,17} = ' '''' 'Splits' '''' ';']);

            eval(['iter_' distEC strokeEC '_' courseEC ' = 3;']);
        end;
    end;
end;


for i = 1:nbRaces;

%     scoreN = roundn(i/nb_waitbar,-2);
%     scoreT = roundn(i/nb_waitbar*100,0);
%     waitbar(scoreN, hexport, {['Preparing data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
%     drawnow;

    set(h1, 'String', ['Exporting your data ... ' num2str(i) ' / ' num2str(nbRaces)]);
    drawnow;

    raceEC = i;
    Meet = databaseCurrent{i,7};
    Year = databaseCurrent{i,8};
    Athletename = databaseCurrent{i,2};
    StrokeType = databaseCurrent{i,4};
    Stage = databaseCurrent{i,6};
    RaceDist = databaseCurrent{i,3};
    valRelay = databaseCurrent{i,11};
    detailRelay = databaseCurrent{i,53};
    Course = databaseCurrent{i,10};
    NbLap = str2num(RaceDist)./str2num(Course);
    Lane = databaseCurrent{i,9};
    RaceDate = databaseCurrent{i,57};
    Country = databaseCurrent{i,35};
    DOB = databaseCurrent{i,13};

%     if strcmpi(valRelay, 'Flat(L.1)');
%         valRelay = 'Leg1';
%     elseif strcmpi(valRelay, 'Relay(L.2)');
%         valRelay = 'Leg2';
%     elseif strcmpi(valRelay, 'Relay(L.3)');
%         valRelay = 'Leg3';
%     elseif strcmpi(valRelay, 'Relay(L.4)');
%         valRelay = 'Leg4';
%     else;
%         valRelay = 'Flat';
%     end;
    
    Source = databaseCurrent{i,58};
    if Source == 1;
        answerReport = 'SP1';
    elseif Source == 2;
        answerReport = 'SP2';
    elseif Source == 3;
        answerReport = 'GE';
    end;

    table1 = databaseCurrent{i,67};
    table2 = databaseCurrent{i,68};
    table3 = databaseCurrent{i,69};
    table4 = databaseCurrent{i,70};
    table5 = databaseCurrent{i,71};


    %---filename
    filename = [Athletename '_' RaceDist StrokeType '_' Stage '_' Lane '_' Meet Year '_' valRelay '_' detailRelay];
    if str2num(Course) == 50;
        CourseDisp = 'LCM';
    elseif str2num(Course) == 25;
        CourseDisp = 'SCM';
    end;
    eval(['dataSeriesEC = dataSeries_' RaceDist StrokeType '_' CourseDisp ';']);
    eval(['iterEC = iter_' RaceDist StrokeType '_' CourseDisp ';']);

%     handles.filelistAdded = {filename};
%     origin = '';

    dataSeriesECnew = {};
    dataSeriesECnew{1,1} = Athletename;
    dataSeriesECnew{1,2} = Country;
    dataSeriesECnew{1,3} = DOB;
    dataSeriesECnew{1,4} = Meet;
    dataSeriesECnew{1,5} = Year;
    dataSeriesECnew{1,6} = Stage;
    dataSeriesECnew{1,7} = StrokeType;
    dataSeriesECnew{1,8} = RaceDist;
    dataSeriesECnew{1,9} = valRelay;
    dataSeriesECnew{1,10} = detailRelay;
    dataSeriesECnew{1,11} = Course;
    dataSeriesECnew{1,12} = RaceDate;
    dataSeriesECnew{1,13} = answerReport;


    if Source == 1 | Source == 3;
         if isnan(table2(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{i,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            table2(end,1) = str2num(racetimemissing);
        end;

        dataSeriesECnew{1,14} = timeSecToStr2(table2(end,1));
        TotalSkillTime = table5{10,3};

        index1 = strfind(TotalSkillTime, ' ');
        index2 = strfind(TotalSkillTime, 's');
        index3 = strfind(TotalSkillTime, '!');
        index = [index1 index2 index3];
        if isempty(index) == 0;
            TotalSkillTime(index) = [];
        end;
        TotalSkillTime = str2num(TotalSkillTime);

        dataSeriesECnew{1,15} = TotalSkillTime;
        dataSeriesECnew{1,16} = table2(end,1) - TotalSkillTime;
    else;
        TotalSkillTime = table4{1,1};
        dataSeriesECnew{1,14} = timeSecToStr2(table2{end,11});
        dataSeriesECnew{1,15} = TotalSkillTime;
        dataSeriesECnew{1,16} = table2{end,11} - TotalSkillTime;
    end;

    splitDistAll = 5:5:(NbLap*50);
    RaceDist = str2num(RaceDist);
    Course = str2num(Course);
    lapDist = Course:Course:RaceDist;
    if AMSExportType == 1;
        %--- 15m segment
        if Course == 25;
            NbZones = 5;
        else;
            NbZones = 10;
        end;
        if Course == 25;
            if RaceDist == 50;
                KeyDist = [15 25 35 45 50];
                KeyDistIndex = [3 5 7 9 10];
            else;
                for lap = 1:NbLap;
                    if lap == 1;
                        KeyDist = [15 20 25];
                        KeyDistIndex = [3 4 5];
                    else;
                        KeyDist = [KeyDist KeyDist(end)+10 KeyDist(end)+20 KeyDist(end)+25];
                        KeyDistIndex = [KeyDistIndex KeyDistIndex(end)+7 KeyDistIndex(end)+9 KeyDistIndex(end)+10];
                    end;
                end;
            end;
        else;
            for lap = 1:NbLap;
                if lap == 1;
                    KeyDist = [15 25 35 45 50];
                    KeyDistIndex = [3 5 7 9 10];
                else;
                    KeyDist = [KeyDist KeyDist(end)+15 KeyDist(end)+25 KeyDist(end)+35 KeyDist(end)+45 KeyDist(end)+50];
                    KeyDistIndex = [KeyDistIndex KeyDistIndex(end)+3 KeyDistIndex(end)+5 KeyDistIndex(end)+7 KeyDistIndex(end)+9 KeyDistIndex(end)+10];
                end;
            end;
        end;
        
    elseif AMSExportType == 2;
        %--- 25m segment
        if Course == 25;
            NbZones = 5;
        else;
            NbZones = 10;
        end;
        KeyDist = 25:25:RaceDist;
        KeyDistIndex = 5:5:(NbLap*NbZones);
    else;
        %--- 5m segment;
        if Course == 25;
            NbZones = 5;
        else;
            NbZones = 10;
        end;
        KeyDist = 5:5:RaceDist;
        KeyDistIndex = 1:(NbLap*NbZones);
    end;
    posTitle = 11;

    if Source == 1 | Source == 3;
        %---Get BO and kicks
        BOAllINI = [];

        BOKick_Start = table5{21,3};
        index = strfind(BOKick_Start, ' ');
        BOKick_Start = str2num(BOKick_Start(1:index(1)));

        BOTime_Start = table5{23,3};
        index1 = strfind(BOTime_Start, ' ');
        index2 = strfind(BOTime_Start, 's');
        index3 = strfind(BOTime_Start, '!');
        if isempty(index3) == 0;
            interpolationBOTime_Start = 1;
        else;
            interpolationBOTime_Start = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BOTime_Start(index) = [];
        end;
        BOTime_Start = str2num(BOTime_Start);

        BODist_Start = table5{22,3};
        index1 = strfind(BODist_Start, ' ');
        index2 = strfind(BODist_Start, 'm');
        index3 = strfind(BODist_Start, '!');
        if isempty(index3) == 0;
            interpolationBODist_Start = 1;
        else;
            interpolationBODist_Start = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BODist_Start(index) = [];
        end;
        BODist_Start = str2num(BODist_Start);
        BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

        locTurnData = [32 40 48 56 64 72 80 88 96 104 112 120 128 136 144 ...
            152 160 168 176 184 192 200 208 216 224 232 240 248 256];

        TurnTime = [];
        TurnTimeIn = [];
        TurnTimeOut = [];
        for lapEC = 1:NbLap-1;
            
            turnTXT = table5{locTurnData(lapEC),3};
            index = strfind(turnTXT, '/');
            inTime = turnTXT(1:index(1)-1);
            outTime = turnTXT(index(1)+1:index(2)-1);
            totTime = turnTXT(index(2)+2:end);

            index1 = strfind(inTime, ' ');
            index2 = strfind(inTime, 's');
            index3 = strfind(inTime, '!');
            if isempty(index3) == 0;
                interpolationTurnIn(lapEC) = 1;
            else;
                interpolationTurnIn(lapEC) = 0;
            end;
            %time in sec            
            index = [index1 index2 index3];
            if isempty(index) == 0;
                inTime(index) = [];
            end;
            inTime = str2num(inTime);

            index1 = strfind(outTime, ' ');
            index2 = strfind(outTime, 's');
            index3 = strfind(outTime, '!');
            if isempty(index3) == 0;
                interpolationTurnOut(lapEC) = 1;
            else;
                interpolationTurnOut(lapEC) = 0;
            end;
            %time in sec            
            index = [index1 index2 index3];
            if isempty(index) == 0;
                outTime(index) = [];
            end;
            outTime = str2num(outTime);

            index1 = strfind(totTime, ' ');
            index2 = strfind(totTime, 's');
            index3 = strfind(totTime, '!');
            if isempty(index3) == 0;
                interpolationTurnTot(lapEC) = 1;
            else;
                interpolationTurnTot(lapEC) = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                totTime(index) = [];
            end;
            totTime = str2num(totTime);
 
            TurnTime = [TurnTime totTime];
            TurnTimeIn = [TurnTimeIn inTime];
            TurnTimeOut = [TurnTimeOut outTime];
            
            if interpolationTurnIn(lapEC) == 1;
                eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(inTime,2) ' '''' ' !' '''' '];']);
            else;
                eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(inTime,2) ' '''' '  ' '''' '];']);
            end;
            if interpolationTurnOut(lapEC) == 1;
                eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(outTime,2) ' '''' ' !' '''' '];']);
            else;
                eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(outTime,2) ' '''' '  ' '''' '];']);
            end;
            if interpolationTurnTot(lapEC) == 1;
                eval(['TurnTime' num2str(lapEC) ' = [dataToStr(totTime,2) ' '''' ' !' '''' '];']);
            else;
                eval(['TurnTime' num2str(lapEC) ' = [dataToStr(totTime,2) ' '''' '  ' '''' '];']);
            end;
            
            BOKick_Turn = table5{35,3};
            index = strfind(BOKick_Turn, ' ');
            BOKick_Turn = str2num(BOKick_Turn(1:index(1)));

            BOTime_Turn = table5{37,3};
            index1 = strfind(BOTime_Turn, ' ');
            index2 = strfind(BOTime_Turn, 's');
            index3 = strfind(BOTime_Turn, '!');
            if isempty(index3) == 0;
                interpolationBOTime_Turn(lapEC) = 1;
            else;
                interpolationBOTime_Turn(lapEC) = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                BOTime_Turn(index) = [];
            end;
            BOTime_Turn = str2num(BOTime_Turn);

            BODist_Turn = table5{36,3};
            index1 = strfind(BODist_Turn, ' ');
            index2 = strfind(BODist_Turn, 'm');
            index3 = strfind(BODist_Turn, '!');
            if isempty(index3) == 0;
                interpolationBODist_Turn(lapEC) = 1;
            else;
                interpolationBODist_Turn(lapEC) = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                BODist_Turn(index) = [];
            end;
            BODist_Turn = str2num(BODist_Turn);

            BOAllINI = [BOAllINI; [BOTime_Turn BODist_Turn BOKick_Turn]];
        end;

    else;
        %SP2
        KickNb = databaseCurrent{i,64};
        BOAll = table4{1,24};
        BOAllINI = [];
        for lapEC = 1:NbLap;
            if lapEC >= 2;
                BODistEC = BOAll(lapEC,3) - lapDist(lapEC-1);
                BOTimeEC = BOAll(lapEC,2);
                BOAllINI = [BOAllINI; [BOAll(lapEC,2) BODistEC KickNb(lapEC)]];
            else;
                BOAllINI = [BOAllINI; [BOAll(lapEC,2) BOAll(lapEC,3) KickNb(lapEC)]];
            end;
        end;

        if NbLap >= 2;
            TurnTime = table4{1,2}; 
            TurnTimeIn = table4{1,3};
            TurnTimeOut = table4{1,4};           
        else;
            TurnTime = [];
            TurnTimeIn = [];
            TurnTimeOut = [];
        end;
    end;

    %---Create splits
    posEC = length(dataSeriesECnew(1,:));
    for spl = 1:length(KeyDist);
        if raceEC == 1;
            %Add titles
            if spl == 1;
                inDist = 0;
            else;
                inDist = KeyDist(spl-1);
            end;
            outDist = KeyDist(spl);
    
            if AMSExportHeader == 1
                dataSeriesEC{1,posEC+spl} = ['Spl ' num2str(inDist) '-' num2str(outDist) 'm'];
            else;
                dataSeriesEC{2,posEC+spl} = [num2str(inDist) '-' num2str(outDist) 'm'];
            end;
        end;

        if Source == 1 | Source == 3;
            if AMSExportType == 1;
                %10m segment
                colSplits = 2;
            elseif AMSExportType == 2;
                %25m segment
                colSplits = 3;
            elseif AMSExportType == 3;
                %5m semgnet
                colSplits = 1;
            end;
            if isnan(table2(KeyDistIndex(spl), colSplits)) == 0 & table2(KeyDistIndex(spl), colSplits) ~= 0;
                if table2(KeyDistIndex(spl), 4) == 1;
                    dataSeriesECnew{1,posEC+spl} = [num2str(table2(KeyDistIndex(spl), colSplits)) ' !'];
                else;
                    dataSeriesECnew{1,posEC+spl} = num2str(table2(KeyDistIndex(spl), colSplits));
                end;
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;


        elseif Source == 2;
            if AMSExportType == 1;
                %10m segment
                colSplits = 12;
            elseif AMSExportType == 2;
                %25m segment
                colSplits = 13;
            elseif AMSExportType == 3;
                %5m semgnet
                colSplits = 11;
            end;

            if isnan(table2{KeyDistIndex(spl), colSplits}) == 0 & table2{KeyDistIndex(spl), colSplits} ~= 0;
                dataSeriesECnew{1,posEC+spl} = num2str(table2{KeyDistIndex(spl), colSplits});
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
        end;
    end;

    %---Create Velocities
    posEC = length(dataSeriesECnew(1,:));
    posTitle(2) = posEC+1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if raceEC == 1;
        dataSeriesEC{1,posEC+1} = 'Velocity (m/s)';
    end;
    for spl = 1:length(KeyDist);
        if raceEC == 1;
            %Add titles
            if spl == 1;
                inDist = 0;
            else;
                inDist = KeyDist(spl-1);
            end;
            outDist = KeyDist(spl);
    
            if AMSExportHeader == 1;
                dataSeriesEC{1,posEC+spl} = ['Vel ' num2str(inDist) '-' num2str(outDist) 'm'];
            else;
                dataSeriesEC{2,posEC+spl} = [num2str(inDist) '-' num2str(outDist) 'm'];
            end;
            
        end;
        if Source == 1 | Source == 3;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
                %select speed col
                colSpeed = 6;
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
                %select speed col
                colSpeed = 7;
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
                %select speed col
                colSpeed = 5;
            end;
            if distEC ~= 15 & isempty(indexLap) == 1;
                if isnan(table2(KeyDistIndex(spl), colSpeed)) == 0 & table2(KeyDistIndex(spl), colSpeed) ~= 0;
                    if table2(KeyDistIndex(spl), 4) == 1; %use the interpolation from the splits
                        index45m = find((lapDist-5) == distEC);
                        if isempty(index45m) == 1;
                            dataSeriesECnew{1,posEC+spl} = [num2str(table2(KeyDistIndex(spl), colSpeed)) ' !'];
                        else;
                            dataSeriesECnew{1,posEC+spl} = num2str(table2(KeyDistIndex(spl), colSpeed));
                        end;
                    else;
                        dataSeriesECnew{1,posEC+spl} = num2str(table2(KeyDistIndex(spl), colSpeed));
                    end;
                else;
                    dataSeriesECnew{1,posEC+spl} = '';
                end;
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;


        elseif Source == 2;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
                %select speed col
                colSpeed = 3;
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
                %select speed col
                colSpeed = 4;
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
                %select speed col
                colSpeed = 2;
            end;
            if isnan(table2{KeyDistIndex(spl), colSpeed}) == 0 & table2{KeyDistIndex(spl), colSpeed} ~= 0;
                dataSeriesECnew{1,posEC+spl} = num2str(roundn(table2{KeyDistIndex(spl), colSpeed},-2));
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
        end;
    end;

    %---Create Stroke Counts
    posEC = length(dataSeriesECnew(1,:));
    posTitle(3) = posEC-4;
    if raceEC == 1;
        dataSeriesEC{1,posEC+1} = 'Stroke Count';
    end;
    for spl = 1:length(KeyDist);
        distEC = KeyDist(spl);
        indexLap = find(lapDist == distEC);
        if raceEC == 1;
            %Add titles
            if spl == 1;
                inDist = 0;
            else;
                inDist = KeyDist(spl-1);
            end;
            outDist = KeyDist(spl);

            if AMSExportHeader == 1;
                dataSeriesEC{1,posEC+spl} = ['Str ' num2str(inDist) '-' num2str(outDist) 'm'];
            else;
                dataSeriesEC{2,posEC+spl} = [num2str(inDist) '-' num2str(outDist) 'm'];
            end;
        end;

        if Source == 1 | Source == 3;
            if isempty(indexLap) == 0;
                valLap = table4(KeyDistIndex(spl)-(NbZones-1):KeyDistIndex(spl), 9);
                indexNaN = find(isnan(valLap) == 0);
                if isempty(indexNaN) == 0;
                    valLap = valLap(indexNaN);
                end;
                dataSeriesECnew{1,posEC+spl} = sum(valLap);
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
            

        elseif Source == 2;
            if isempty(indexLap) == 0;
                valLap = table2(KeyDistIndex(spl)-(NbZones-1):KeyDistIndex(spl), 16);
                valLap = cell2mat(valLap);
                indexNaN = find(isnan(valLap) == 0);
                if isempty(indexNaN) == 0;
                    valLap = valLap(indexNaN);
                end;
                dataSeriesECnew{1,posEC+spl} = sum(valLap);
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
        end;
    end;


    %---Create Stroke Rates
    posEC = length(dataSeriesECnew(1,:));
    posTitle(4) = posEC+1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if raceEC == 1;
        dataSeriesEC{1,posEC+1} = 'Stroke Rate';
    end;

    for spl = 1:length(KeyDist);
        if raceEC == 1;
            %Add titles
            if spl == 1;
                inDist = 0;
            else;
                inDist = KeyDist(spl-1);
            end;
            outDist = KeyDist(spl);
    
            if AMSExportHeader == 1;
                dataSeriesEC{1,posEC+spl} = ['SR ' num2str(inDist) '-' num2str(outDist) 'm'];
            else;
                dataSeriesEC{2,posEC+spl} = [num2str(inDist) '-' num2str(outDist) 'm'];
            end;
            
        end;

        if Source == 1 | Source == 3;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
                %select speed col
                colSR = 2;
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
                %select speed col
                colSR = 3;
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
                %select speed col
                colSR = 1;
            end;

            if isnan(table4(KeyDistIndex(spl), colSR)) == 0 & table4(KeyDistIndex(spl), colSR) ~= 0;
                if table4(KeyDistIndex(spl), 4) == 1;
                    dataSeriesECnew{1,posEC+spl} = [num2str(table4(KeyDistIndex(spl), colSR)) ' !'];
                else;
                    dataSeriesECnew{1,posEC+spl} = num2str(table4(KeyDistIndex(spl), colSR));
                end;
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;


        elseif Source == 2;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
                %select speed col
                colSR = 6;
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
                %select speed col
                colSR = 7;
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
                %select speed col
                colSR = 5;
            end;

            if isnan(table2{KeyDistIndex(spl), colSR}) == 0 & table2{KeyDistIndex(spl), colSR} ~= 0;
                dataSeriesECnew{1,posEC+spl} = num2str(roundn(table2{KeyDistIndex(spl), colSR},-1));
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
        end;
    end;

    %---Create DPS
    posEC = length(dataSeriesECnew(1,:));
    posTitle(5) = posEC+1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if raceEC == 1;
        dataSeriesEC{1,posEC+1} = 'Distance per Strokes (m)';
    end;

    for spl = 1:length(KeyDist);
        if raceEC == 1;
            %Add titles
            if spl == 1;
                inDist = 0;
            else;
                inDist = KeyDist(spl-1);
            end;
            outDist = KeyDist(spl);
    
            if AMSExportHeader == 1;
                dataSeriesEC{1,posEC+spl} = ['DPS ' num2str(inDist) '-' num2str(outDist) 'm'];
            else;
                dataSeriesEC{2,posEC+spl} = [num2str(inDist) '-' num2str(outDist) 'm'];
            end;
            
        end;

        if Source == 1 | Source == 3;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
                %select speed col
                colDPS = 6;
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
                %select speed col
                colDPS = 7;
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
                %select speed col
                colDPS = 5;
            end;
            if distEC ~= 15 & isempty(indexLap) == 1;
                if isnan(table4(KeyDistIndex(spl), colDPS)) == 0 & table4(KeyDistIndex(spl), colDPS) ~= 0;
                    if table4(KeyDistIndex(spl), 4) == 1; %use the interpolation from the SR
                        index45m = find((lapDist-5) == distEC);
                        if isempty(index45m) == 1;
                            dataSeriesECnew{1,posEC+spl} = [num2str(table4(KeyDistIndex(spl), colDPS)) ' !'];
                        else;
                            dataSeriesECnew{1,posEC+spl} = num2str(table4(KeyDistIndex(spl), colDPS));
                        end;
                    else;
                        dataSeriesECnew{1,posEC+spl} = num2str(table4(KeyDistIndex(spl), colDPS));
                    end;
                else;
                    dataSeriesECnew{1,posEC+spl} = '';
                end;
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;


        elseif Source == 2;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
                %select speed col
                colDPS = 9;
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
                %select speed col
                colDPS = 10;
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
                %select speed col
                colDPS = 8;
            end;
            if isnan(table2{KeyDistIndex(spl), colDPS}) == 0 & table2{KeyDistIndex(spl), colDPS} ~= 0;
                dataSeriesECnew{1,posEC+spl} = num2str(roundn(table2{KeyDistIndex(spl), colDPS},-2));
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
        end;
    end;

    %---Create SI
    posEC = length(dataSeriesECnew(1,:));
    posTitle(6) = posEC+1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if raceEC == 1;
        dataSeriesEC{1,posEC+1} = 'Stroke Index (m2/s/str)';
    end;

    %---Create SI table
    tableSI = [];
    if Source == 1 | Source == 3;
        for iter = 1:length(table2(:,1));
            valDPS = table4(iter,colDPS);
            valSpeed = table2(iter,colSpeed);
            
            valSI = valDPS.*valSpeed;
            tableSI(iter,1) = roundn(valSI,-2);
            if table2(iter,4) == 1 | table4(:,4) == 1;
                tableSI(iter,2) = 1;
            else;
                tableSI(iter,2) = 0;
            end;
        end;


    elseif Source == 2;
        for iter = 1:length(table2(:,1));
            valDPS = table2{iter,colDPS};
            valSpeed = table2{iter,colSpeed};
            valSI = valDPS.*valSpeed;
            if isempty(valSI) == 1;
                tableSI(iter,1) = NaN;
                tableSI(iter,2) = 0;
            else;
                tableSI(iter,1) = roundn(valSI,-2);
                tableSI(iter,2) = 0;
            end;
        end;
    end;

    for spl = 1:length(KeyDist);
        if raceEC == 1;
            %Add titles
            if spl == 1;
                inDist = 0;
            else;
                inDist = KeyDist(spl-1);
            end;
            outDist = KeyDist(spl);
    
            if AMSExportHeader == 1;
                dataSeriesEC{1,posEC+spl} = ['SI ' num2str(inDist) '-' num2str(outDist) 'm'];
            else;
                dataSeriesEC{2,posEC+spl} = [num2str(inDist) '-' num2str(outDist) 'm'];
            end;
            
        end;

%         if Source == 1 | Source == 3;
            distEC = KeyDist(spl);
            indexLap = find(lapDist == distEC);
            if AMSExportType == 1;
                %15m seg
            elseif AMSExportType == 2;
                %disable if 25m segment
                indexLap = [];
            elseif AMSExportType == 3;
                %disable if 5m segment
                indexLap = [];
            end;
            if distEC ~= 15 & isempty(indexLap) == 1;
                if isnan(tableSI(KeyDistIndex(spl), 1)) == 0 & tableSI(KeyDistIndex(spl), 1) ~= 0;
                    if tableSI(KeyDistIndex(spl), 2) == 1;
                        index45m = find((lapDist-5) == distEC);
                        if isempty(index45m) == 1;
                            dataSeriesECnew{1,posEC+spl} = [num2str(tableSI(KeyDistIndex(spl), 1)) ' !'];
                        else;
                            dataSeriesECnew{1,posEC+spl} = num2str(tableSI(KeyDistIndex(spl), 1));
                        end;
                    else;
                        dataSeriesECnew{1,posEC+spl} = num2str(tableSI(KeyDistIndex(spl), 1));
                    end;
                else;
                    dataSeriesECnew{1,posEC+spl} = '';
                end;
            else;
                dataSeriesECnew{1,posEC+spl} = '';
            end;
%         elseif Source == 2;
%     
%             e=e
%         
%         end;
    end;



    %---Create skills
    if Source == 1 | Source == 3;
        RT = table5{16,3};
        index1 = strfind(RT, ' ');
        index2 = strfind(RT, 's');
        index3 = strfind(RT, '!');
        index = [index1 index2 index3];
        if isempty(index) == 0;
            RT(index) = [];
        end;
    
        StartTime = table5{15,3};
        index1 = strfind(StartTime, ' ');
        index2 = strfind(StartTime, 's');
        index3 = strfind(StartTime, '!');
        index = [index1 index2 index3];
        if isempty(index) == 0;
            StartTime(index) = [];
        end;
        
        StartBOTime = timeSecToStr2(BOAllINI(1,1));
        StartBODist = dataToStr(BOAllINI(1,2),1);
        for tt = 1:length(lapDist)-1;
            eval(['Turn' num2str(tt) 'BOTime = timeSecToStr2(BOAllINI(' num2str(tt+1) ',1));']);
            
            eval(['TurnECBODist = dataToStr(BOAllINI(' num2str(tt+1) ',2),1);']);
            if strcmpi(TurnECBODist(1:end-1), '.');
                eval(['Turn' num2str(tt) 'BODist = TurnECBODist;']);
            else;
                eval(['Turn' num2str(tt) 'BODist = TurnECBODist;']);
            end;
        end;
    
        for tt = 1:length(lapDist);
            eval(['KickCountLapEC = dataToStr(BOAllINI(' num2str(tt) ',3),0);']);
            if strcmpi(KickCountLapEC, '0');
                eval(['KickCountLap' num2str(tt) ' = ' '''' '''' ';']);
            else;
                if strcmpi(KickCountLapEC, '.');
                    eval(['KickCountLap' num2str(tt) ' = KickCountLapEC(1);']);
                else;
                    eval(['KickCountLap' num2str(tt) ' = KickCountLapEC;']);
                end;
            end;
        end;
    
        Last5mINI = table5{end-1,3};
        index1 = strfind(Last5mINI, ' ');
        index2 = strfind(Last5mINI, 's');
        index3 = strfind(Last5mINI, '!');
        index = [index1 index2 index3];
        if isempty(index) == 0;
            Last5mINI(index) = [];
        end;
            
        posEC = length(dataSeriesECnew(1,:));
        posTitle(6) = posEC+1;
        if raceEC == 1;
            %add titles
            dataSeriesEC{1,posEC+1} = 'Start';
            dataSeriesEC{1,posEC+2} = 'Reaction Time';
            dataSeriesEC{1,posEC+3} = 'Start BO Distance';
            dataSeriesEC{1,posEC+4} = 'Start BO Time';
            dataSeriesEC{1,posEC+5} = 'Start Kicks';
            dataSeriesEC{1,posEC+6} = 'Turn TT';
        end;
        if table2(3,3) == 1;
            dataSeriesECnew{1,posEC+1} = [StartTime ' !'];
        else;
            dataSeriesECnew{1,posEC+1} = StartTime;
        end;
        dataSeriesECnew{1,posEC+2} = RT;
        if interpolationBOTime_Start == 1
            dataSeriesECnew{1,posEC+3} = [StartBODist ' !'];
            dataSeriesECnew{1,posEC+4} = [StartBOTime ' !'];
        else;
            dataSeriesECnew{1,posEC+3} = StartBODist;
            dataSeriesECnew{1,posEC+4} = StartBOTime;
        end;


    elseif Source == 2;
        RT = table4{1,22};
        StartTime = table4{1,5};
        StartBOTime = timeSecToStr2(BOAllINI(1,1));
        StartBODist = dataToStr(BOAllINI(1,2),1);

        for tt = 1:length(lapDist)-1;
            eval(['Turn' num2str(tt) 'BOTime = timeSecToStr2(BOAllINI(' num2str(tt+1) ',1));']);
            
            eval(['TurnECBODist = dataToStr(BOAllINI(' num2str(tt+1) ',2),1);']);
            if strcmpi(TurnECBODist(1:end-1), '.');
                eval(['Turn' num2str(tt) 'BODist = TurnECBODist;']);
            else;
                eval(['Turn' num2str(tt) 'BODist = TurnECBODist;']);
            end;
        end;
    
        for tt = 1:length(lapDist);
            eval(['KickCountLapEC = dataToStr(BOAllINI(' num2str(tt) ',3),0);']);
            if strcmpi(KickCountLapEC, '0');
                eval(['KickCountLap' num2str(tt) ' = ' '''' '''' ';']);
            else;
                if strcmpi(KickCountLapEC, '.');
                    eval(['KickCountLap' num2str(tt) ' = KickCountLapEC(1);']);
                else;
                    eval(['KickCountLap' num2str(tt) ' = KickCountLapEC;']);
                end;
            end;
        end;

        Last5mINI = table4{1,20};

        posEC = length(dataSeriesECnew(1,:));
        posTitle(6) = posEC+1;
        if raceEC == 1;
            %add titles
            dataSeriesEC{1,posEC+1} = 'Start';
            dataSeriesEC{1,posEC+2} = 'Reaction Time';
            dataSeriesEC{1,posEC+3} = 'Start BO Distance';
            dataSeriesEC{1,posEC+4} = 'Start BO Time';
            dataSeriesEC{1,posEC+5} = 'Start Kicks';
            dataSeriesEC{1,posEC+6} = 'Turn TT';
        end;
        dataSeriesECnew{1,posEC+1} = StartTime;
        dataSeriesECnew{1,posEC+2} = RT;
        dataSeriesECnew{1,posEC+3} = StartBODist;
        dataSeriesECnew{1,posEC+4} = StartBOTime;
    end;

    eval(['kcl = KickCountLap' num2str(1) ';']);
    dataSeriesECnew{1,posEC+5} = kcl;
    if RaceDist == 50 & Course == 50;
        dataSeriesECnew{1,posEC+6} = '';
    else;
        dataSeriesECnew{1,posEC+6} = sum(TurnTime);
    end;

    posEC = length(dataSeriesECnew(1,:));
    NbTurns = length(TurnTime);
    for tt = 1:length(TurnTime);
        if AMSExportHeader == 1;
            if raceEC == 1;
                dataSeriesEC{1,posEC+1} = ['T. ' num2str(tt) ' In'];
                dataSeriesEC{1,posEC+2} = ['T. ' num2str(tt) ' Out'];
                dataSeriesEC{1,posEC+3} = ['T. ' num2str(tt) ' Time'];
                dataSeriesEC{1,posEC+4} = ['T. ' num2str(tt) ' BO Turn'];
                dataSeriesEC{1,posEC+5} = ['T. ' num2str(tt) ' Kicks'];
                dataSeriesEC{1,posEC+6} = ['T. ' num2str(tt) ' T Index'];
            end;
        else;
            if raceEC == 1;
                dataSeriesEC{1,posEC+1} = ['Turn ' num2str(tt)];
                dataSeriesEC{2,posEC+1} = 'In';
                dataSeriesEC{2,posEC+2} = 'Out';
                dataSeriesEC{2,posEC+3} = 'Time';
                dataSeriesEC{2,posEC+4} = 'BO Turn';
                dataSeriesEC{2,posEC+5} = 'Kicks';
                dataSeriesEC{2,posEC+6} = 'T Index';
            end;
        end;
    
        if Course == 50 & RaceDist == 50;
            dataSeriesECnew{1,posEC+1} = '';
            dataSeriesECnew{1,posEC+2} = '';
            dataSeriesECnew{1,posEC+3} = '';
            dataSeriesECnew{1,posEC+4} = '';
            dataSeriesECnew{1,posEC+5} = '';
            dataSeriesECnew{1,posEC+6} = '';
        else;
            dataSeriesECnew{1,posEC+1} = TurnTimeIn(tt);
            dataSeriesECnew{1,posEC+2} = TurnTimeOut(tt);
            dataSeriesECnew{1,posEC+3} = TurnTime(tt);
            eval(['TurnECBODist = Turn' num2str(tt) 'BODist;']);
            if Source == 1 | Source == 3;
                if interpolationBOTime_Turn(tt) == 1;
                    dataSeriesECnew{1,posEC+4} = [TurnECBODist ' !'];
                else;
                    dataSeriesECnew{1,posEC+4} = TurnECBODist;
                end;
            elseif Source == 2;
                dataSeriesECnew{1,posEC+4} = TurnECBODist;
            end;
            eval(['kcl = KickCountLap' num2str(tt+1) ';']);
            dataSeriesECnew{1,posEC+5} = kcl;
            dataSeriesECnew{1,posEC+6} = [];
        end;
    
        posEC = length(dataSeriesECnew(1,:));
    end;
    
    posEC = length(dataSeriesECnew(1,:));
    if raceEC == 1;
        dataSeriesEC{1,posEC+1} = 'Finish';
    end;
    dataSeriesECnew{1,posEC+1} = Last5mINI;

    for val = 1:length(dataSeriesECnew);
        if AMSExportHeader == 1;
            dataSeriesEC{iterEC-1,val} = dataSeriesECnew{1,val};
        else;
            dataSeriesEC{iterEC,val} = dataSeriesECnew{1,val};
        end;
    end;

    eval(['dataSeries_' num2str(RaceDist) StrokeType '_' CourseDisp ' = dataSeriesEC;']);
    eval(['iter_' num2str(RaceDist) StrokeType '_' CourseDisp ' = iterEC + 1;']);
    iterEC = [];
end;

if ispc == 1;
    if isfile(AMSExportPath) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' AMSExportPath];
        [status, cmdout] = system(command);
    end;
    getCount = 0;
    for courseIter = 1:2;
        courseEC = courseList{courseIter};
        for strokeIter = 1:5;
            strokeEC = strokeListMain{strokeIter};
            for distIter = 1:7;
                distEC = distList{distIter};
                eval(['dataSeriesEC = dataSeries_' distEC strokeEC '_' courseEC ';']);
                li = length(dataSeriesEC(:,1));
                if li > 1;
                    getCount = getCount + 1;
                end;
            end;
        end;
    end;

%     scoreN = roundn(1/getCount,-2);
%     scoreT = roundn(1/getCount*100,0);
%     waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
%     drawnow;

    sheetNB = 1;
    specSheet = {};
    nameSheet = {};
    NbTurnsTot = [];
    for courseIter = 1:2;
        courseEC = courseList{courseIter};
        for strokeIter = 1:5;
            strokeEC = strokeListMain{strokeIter};
            for distIter = 1:7;
                distEC = distList{distIter};
                eval(['dataSeriesEC = dataSeries_' distEC strokeEC '_' courseEC ';']);
                li = length(dataSeriesEC(:,1));

                if li > 1;
                    exportstatusSheetEC = xlswrite(AMSExportPath, dataSeriesEC, sheetNB);
                    if strcmpi(courseEC, 'LCM') == 1
                        transCourse = 50;
                    else;
                        transCourse = 25;
                    end;
                    specSheet{sheetNB, 1} = distEC;
                    specSheet{sheetNB, 2} = strokeEC;
                    specSheet{sheetNB, 3} = transCourse;
                    nameSheet{sheetNB} = [distEC strokeEC '_' courseEC];
                    NbTurnsTot(sheetNB) = (str2num(distEC)./transCourse)-1;

%                     scoreN = roundn(sheetNB/getCount,-2);
%                     scoreT = roundn(sheetNB/getCount*100,0);
%                     waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
%                     drawnow;

                    sheetNB = sheetNB + 1;
                end;
            end;
        end;
    end;
    clc;
%     try;
%         excelRenderingAMS_database;
%     end;

elseif ismac == 1;
    
    if isfile(AMSExportPath) == 1;
        command = ['rm ' AMSExportPath];
        [status, cmdout] = system(command);
    end;
    
    getCount = 0;
    for courseIter = 1:2;
        courseEC = courseList{courseIter};
        for strokeIter = 1:5;
            strokeEC = strokeListMain{strokeIter};
            for distIter = 1:7;
                distEC = distList{distIter};
                eval(['dataSeriesEC = dataSeries_' distEC strokeEC '_' courseEC ';']);
                li = length(dataSeriesEC(:,1));
                if li > 1;
                    getCount = getCount + 1;
                end;
            end;
        end;
    end;
    
%    scoreN = roundn(1/getCount,-2);
%    scoreT = roundn(1/getCount*100,0);
%    waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
%    drawnow;

    sheetNB = 1;
    specSheet = {};
    nameSheet = {};
    NbTurnsTot = [];
    
    javaaddpath('poi-3.8-20120326.jar');
    javaaddpath('poi-ooxml-3.8-20120326.jar');
    javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('xmlbeans-2.3.0.jar');
    javaaddpath('dom4j-1.6.1.jar');
    javaaddpath('stax-api-1.0.1.jar');
    
    for courseIter = 1:2;
        courseEC = courseList{courseIter};
        for strokeIter = 1:5;
            strokeEC = strokeListMain{strokeIter};
            for distIter = 1:7;
                distEC = distList{distIter};
                eval(['dataSeriesEC = dataSeries_' distEC strokeEC '_' courseEC ';']);
                li = length(dataSeriesEC(:,1));

                if li > 1;
                    exportstatusSheetEC = xlswrite(AMSExportPath, dataSeriesEC, sheetNB);
                    
                    xlwrite(AMSExportPath, dataSeriesEC, [strokeEC '_' distEC '_' courseEC], 'A1');
                    
                    if strcmpi(courseEC, 'LCM') == 1
                        transCourse = 50;
                    else;
                        transCourse = 25;
                    end;
                    specSheet{sheetNB, 1} = distEC;
                    specSheet{sheetNB, 2} = strokeEC;
                    specSheet{sheetNB, 3} = transCourse;
                    nameSheet{sheetNB} = [distEC strokeEC '_' courseEC];
                    NbTurnsTot(sheetNB) = (str2num(distEC)./transCourse)-1;

%                    scoreN = roundn(sheetNB/getCount,-2);
%                    scoreT = roundn(sheetNB/getCount*100,0);
%                    waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
%                    drawnow;

                    sheetNB = sheetNB + 1;
                end;
            end;
        end;
    end;
    clc;
    
end;

close(h);

guidata(handles.hf_w1_welcome, handles);