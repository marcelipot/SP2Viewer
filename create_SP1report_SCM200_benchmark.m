if ispc == 1;
    font1 = 14;
    font2 = 11;
    font3 = 8;
    font4 = 9.5;
elseif ismac == 1;
    font1 = 17;
    font2 = 14;
    font3 = 11;
    font4 = 12.5;
end;
% resolution = get(0,'ScreenSize');
% resolution = resolution(1,3:4);
% if strcmpi(source, 'display') == 1;
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))]);
%     hdef = figure('units', 'pixels', 'position', window_size, ...
%         'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Sparta - Report', ...
%         'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
% else;
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))]);
%     hdef = figure('units', 'pixels', 'position', window_size, ...
%         'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
%         'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
% end;

% 

resolution = get(0, 'MonitorPositions');
set(gcf, 'units', 'pixel');
figPos = get(gcf, 'Position');
set(gcf, 'units', 'normalized');

screenValid = 0;
for screenEC = 1:length(resolution(:,1));
    screenLim1 = resolution(screenEC,1);
    screenLim2 = screenLim1+resolution(screenEC,3)-1;

    if figPos(1) >= screenLim1 & figPos(1) <= screenLim2;
        screenValid = screenEC;
    end;
end;
if screenValid == 0;
    screenValid = 1;
end;
offsetLeft = resolution(screenValid,1);
offsetBottom = resolution(screenValid,2);
resolution = resolution(screenValid,3:4);

offzetSize = 0; %370;
if strcmpi(source, 'display') == 1;
    window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))-offzetSize]);
    window_size(1) = window_size(1) + offsetLeft;
    window_size(2) = window_size(2) + offsetBottom + 5;

    if window_size(3) < 1140 | window_size(4) < 665;
        h = warndlg('Screen resolution below [1140 665]. Display could be impacted', 'Warning');
        waitfor(h);
    end;

    hdef = figure('units', 'pixels', 'position', window_size, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Sparta - Report', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
else;
    resolution = [1920 1080];
    window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))-offzetSize]);
    hdef = figure('units', 'pixels', 'position', window_size, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
end;

if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(hdef), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;


%-----------------------------Create Slider--------------------------------
if strcmpi(source, 'display') == 1;
    handles2.save_button_report = uicontrol('parent', hdef, 'Style', 'Pushbutton', ...
        'Visible', 'on', 'units', 'pixels', ...
        'position', [970 window_size(4)-50 200 30], 'callback', @savedata_report_benchmark, ...
        'BackgroundColor', [0.9 0.9 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', ...
        'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Export to JPG');
    set(handles2.save_button_report, 'fontunits', 'normalized', 'Units', 'Normalized');
end;
%--------------------------------------------------------------------------




try;
    handles2.tempFolder = handles.tempFolder;
    handles2.databaseCurrent = databaseCurrent;
    handles2.RaceDist = RaceDist;
    handles2.Gender = Gender;
    handles2.Course = Course;
catch;
    handles = handles2;
    databaseCurrent = handles.databaseCurrent;
    RaceDist = handles.RaceDist;
    Gender = handles.Gender;
    Course = handles.Course;
end;




%------------------------------get the data--------------------------------
Source = databaseCurrent{1,58};
dataTableRefDist = [5:5:RaceDist]';
if Source == 1 | Source == 3;
    metaData_PDF = databaseCurrent{1,67};
    dataTablePacing = databaseCurrent{1,68};
    dataTableBreath = databaseCurrent{1,69};
    dataTableStroke = databaseCurrent{1,70};
    dataTableSkill = databaseCurrent{1,71};
elseif Source == 2;
    metaData_PDF = databaseCurrent{1,67};
    dataTableAverage = databaseCurrent{1,68};
    dataTableBreath = databaseCurrent{1,69};
    dataTableSkillVAL = databaseCurrent{1,70};
    dataTableSkillTXT = databaseCurrent{1,71};
end;

if Source == 1;
    answerReport = 'SP1';
elseif Source == 2;
    answerReport = 'SP2';
elseif Source == 3;
    answerReport = 'GE';
end;

%---Metadata
relayExist = databaseCurrent{1,11};
if isempty(strfind(relayExist, 'Relay')) == 0;
    isRelay = 1;
else;
    isRelay = 0;
end;
if isRelay == 1;
    relayLeg = databaseCurrent{1,11};
    index1 = strfind(relayLeg, '(');
    index2 = strfind(relayLeg, ')');
    relayLeg = relayLeg(index1+1:index2-1);
    RelayType = [databaseCurrent{1,53} ' (' relayLeg ')'];
else;
    RelayType = 'Individual';
end;

AthletenameFull = databaseCurrent{1,2};
index = strfind(AthletenameFull, ' ');
Athletename = [AthletenameFull(index(end)+1:end) AthletenameFull(1)];
Meet = databaseCurrent{1,7};
Stage = databaseCurrent{1,6};
Year = databaseCurrent{1,8};
StrokeType = databaseCurrent{1,4};
RaceDist = str2num(databaseCurrent{1,3});
Course = str2num(databaseCurrent{1,10});
AgeGroup = metaData_PDF{2,1}; %DOB
Venue = metaData_PDF{3,1};
AnalysisDate = metaData_PDF{4,1};
RaceDate = metaData_PDF{7,1};
KicksNb = databaseCurrent{1,64};
if Source == 1 | Source == 3;
    DiveT15 = dataTableSkill{15,3};
    index = strfind(DiveT15, ' ');
    DiveT15 = str2num(DiveT15(1:index(1)-1));
elseif Source == 2;
    DiveT15 = dataTableSkillVAL{1,5};
end;

idx = isstrprop(Meet,'upper');
MeetShort = Meet(idx);
if strcmpi(Stage, 'SemiFinal');
    StageShort = 'SF';
elseif strcmpi(Stage, 'Semi-final');
    StageShort = 'SF';
else;
    StageShort = Stage;
end;
if strcmpi(lower(StrokeType), 'freestyle');
    StrokeShort = 'FS';
elseif strcmpi(lower(StrokeType), 'medley');
    StrokeShort = 'IM';
elseif strcmpi(lower(StrokeType), 'backstroke');
    StrokeShort = 'BK';
elseif strcmpi(lower(StrokeType), 'breaststroke');
    StrokeShort = 'BR';
elseif strcmpi(lower(StrokeType), 'butterfly');
    StrokeShort = 'BF';
end;
        
filename = [Athletename '_' num2str(RaceDist) StrokeShort '_' MeetShort Year '_' StageShort];

if Course == 25;
    Race = [num2str(RaceDist) 'm ' StrokeType ' (SCM)'];
else;
    Race = [num2str(RaceDist) 'm ' StrokeType ' (LCM)'];
end;
Round = [AgeGroup ' - ' Stage];

if Source == 1 | Source == 3;
    AnalysisDate = ['Swim created at ' AnalysisDate];
elseif Source == 2;
    li1 = strfind(AnalysisDate, 'T');
    li2 = strfind(AnalysisDate, '.');
    AnalysisDate = AnalysisDate(1:li1-1);
    AnalysisDate = [AnalysisDate(9:10) '-' AnalysisDate(6:7) '-' AnalysisDate(1:4)];
    AnalysisDate = ['Swim created at ' AnalysisDate];
end;
    
index = strfind(AgeGroup, '/');
dateDiff(1) = datetime(str2num(AgeGroup(index(2)+1:end)), str2num(AgeGroup(index(1)+1:index(2)-1)), str2num(AgeGroup(1:index(1)-1)));
index = strfind(RaceDate, '-');
dateDiff(2) = datetime(str2num(RaceDate(1:index(1)-1)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(index(2)+1:end)));
[DYear, DMonth, DDay] = split(caldiff(dateDiff, {'years';'months';'days'}), {'years';'months';'days'});

if DYear > 18;
    AgeGroup = 'Open';
elseif DYear <= 18 & DYear > 17;
    AgeGroup = '18y';
elseif DYear <= 17 & DYear > 16;
    AgeGroup = '17y';
elseif DYear <= 16 & DYear > 15;
    AgeGroup = '16y';
elseif DYear <= 15 & DYear > 14;
    AgeGroup = '15y';
elseif DYear <= 14 & DYear > 13;
    AgeGroup = '14y';
else;
    AgeGroup = '13y & under';
end;
Round = [AgeGroup ' - ' Stage];

t = now;
ReportDate = ['Report last generated at ' datestr(datetime(t,'ConvertFrom','datenum'))];


%---Get splits & skills
BOAllINI = [];
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    %its a 200m so that short intervals
    colinterest_Splits = 3;
    colinterest_SplitsInterp = 4;
    if dataTablePacing(3,colinterest_SplitsInterp) == 1;
        Split15m = [timeSecToStr2(dataTablePacing(3,colinterest_Splits)) ' !'];
    else;
        Split15m = timeSecToStr2(dataTablePacing(3,colinterest_Splits));
    end;

    Split25m = timeSecToStr2(dataTablePacing(5,colinterest_Splits));
    Split50m = timeSecToStr2(dataTablePacing(10,colinterest_Splits));
    Split75m = timeSecToStr2(dataTablePacing(15,colinterest_Splits));
    Split100m = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
    Split125m = timeSecToStr2(dataTablePacing(25,colinterest_Splits));
    Split150m = timeSecToStr2(dataTablePacing(30,colinterest_Splits));
    Split175m = timeSecToStr2(dataTablePacing(35,colinterest_Splits));
    Split200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits));

    SplitLap1 = timeSecToStr2(dataTablePacing(5,colinterest_Splits));
    SplitLap2 = timeSecToStr2(dataTablePacing(10,colinterest_Splits) - dataTablePacing(5,colinterest_Splits));
    SplitLap3 = timeSecToStr2(dataTablePacing(15,colinterest_Splits) - dataTablePacing(10,colinterest_Splits));
    SplitLap4 = timeSecToStr2(dataTablePacing(20,colinterest_Splits) - dataTablePacing(15,colinterest_Splits));
    SplitLap5 = timeSecToStr2(dataTablePacing(25,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
    SplitLap6 = timeSecToStr2(dataTablePacing(30,colinterest_Splits) - dataTablePacing(25,colinterest_Splits));
    SplitLap7 = timeSecToStr2(dataTablePacing(35,colinterest_Splits) - dataTablePacing(30,colinterest_Splits));
    SplitLap8 = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(35,colinterest_Splits));

    SplitA100m = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
    SplitA200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
    SplitB200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits));

    RaceTime = timeSecToStr2(dataTablePacing(end,colinterest_Splits));
    
    StartTime = dataToStr(DiveT15,2);
    if dataTablePacing(3,colinterest_SplitsInterp) == 1;
        StartTime = [StartTime ' !'];
    end;
    
    Time25m = Split25m;
    if dataTablePacing(5,colinterest_SplitsInterp) == 1;
        Time25m = [Time25m ' !'];
    end;
    
    valFinishTime = dataTableSkill{end-1,3};
    index = strfind(valFinishTime, ' ');
    valFinishTime = str2num(valFinishTime(1:index(1)-1));
    FinishTime = timeSecToStr2(valFinishTime);

    RT = dataTableSkill{16,3};
    index = strfind(RT, ' ');
    RT = str2num(RT(1:index(1)-1));

    BOKick_Start = dataTableSkill{21,3};
    index = strfind(BOKick_Start, ' ');
    BOKick_Start = str2num(BOKick_Start(1:index(1)));

    BOTime_Start = dataTableSkill{23,3};
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

    BODist_Start = dataTableSkill{22,3};
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

elseif strcmpi(answerReport, 'SP2') == 1;
    colinterest_Splits = 13;
    colinterest_SplitsInterp = [];

    %take col = 13 for short intervals
    Split25m = timeSecToStr2(dataTableAverage{5,13});
    Split50m = timeSecToStr2(dataTableAverage{10,13});
    Split75m = timeSecToStr2(dataTableAverage{15,13});
    Split100m = timeSecToStr2(dataTableAverage{20,13});
    Split125m = timeSecToStr2(dataTableAverage{25,13});
    Split150m = timeSecToStr2(dataTableAverage{30,13});
    Split175m = timeSecToStr2(dataTableAverage{35,13});
    Split200m = timeSecToStr2(dataTableAverage{40,13});

    RaceTime = Split200m;
    SplitLap1 = timeSecToStr2(dataTableAverage{5,13});
    SplitLap2 = timeSecToStr2(dataTableAverage{10,13}-dataTableAverage{5,13});
    SplitLap3 = timeSecToStr2(dataTableAverage{15,13}-dataTableAverage{10,13});
    SplitLap4 = timeSecToStr2(dataTableAverage{20,13}-dataTableAverage{15,13});
    SplitLap5 = timeSecToStr2(dataTableAverage{25,13}-dataTableAverage{20,13});
    SplitLap6 = timeSecToStr2(dataTableAverage{30,13}-dataTableAverage{25,13});
    SplitLap7 = timeSecToStr2(dataTableAverage{35,13}-dataTableAverage{30,13});
    SplitLap8 = timeSecToStr2(dataTableAverage{40,13}-dataTableAverage{35,13});
    SplitA100m = timeSecToStr2(dataTableAverage{20,13});
    SplitA200m = timeSecToStr2(dataTableAverage{40,13}-dataTableAverage{20,13});
    SplitB200m = timeSecToStr2(dataTableAverage{40,13});

    StartTime = dataToStr(DiveT15,2);
    Time25m = Split25m;
    
    %Need to take col 12 to calculate the finish time
    valFinishTime = dataTableAverage{end,12} - dataTableAverage{end-1,12};
    FinishTime = timeSecToStr2(valFinishTime);
    RT = dataTableSkillVAL{1,22};
    BOAll = dataTableSkillVAL{1,24};
    BOKick_Start = KicksNb(1,1);
    BOTime_Start = BOAll(1,2);
    BODist_Start = BOAll(1,3);
    BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

    interpolationBODist_Start = 0;
    interpolationBOTime_Start = 0;
end;
StartBODist = roundn(BOAllINI(1,2),-1);
StartBOTime = roundn(BOAllINI(1,1),-2);

LapDist = [25 50 75 100 125 150 175 200];
KeyDist = [25 50 75 100 125 150 175 200];

NbLap = RaceDist./Course;
isInterpolatedTurn = [];
zoneSC = 5;
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    locTurnData = [32 40 48 56 64 72 80];
    for lapEC = 1:NbLap-1;
        turnTXT = dataTableSkill{locTurnData(lapEC),3};
        index = strfind(turnTXT, '/');
        inTime = turnTXT(1:index(1)-2);
        outTime = turnTXT(index(1)+2:index(2)-2);
        totTime = turnTXT(index(2)+2:end-2);

        index1 = strfind(inTime, ' ');
        index2 = strfind(inTime, 's');
        index3 = strfind(inTime, '!');
        if isempty(index3) == 0;
            interpolationTurnIn(lapEC) = 1;
        else;
            interpolationTurnIn(lapEC) = 0;
        end;
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

        BOKick_Turn = dataTableSkill{35,3};
        index = strfind(BOKick_Turn, ' ');
        BOKick_Turn = str2num(BOKick_Turn(1:index(1)));

        BOTime_Turn = dataTableSkill{37,3};
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

        BODist_Turn = dataTableSkill{36,3};
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
    
    AvturnTXT = dataTableSkill{26,3};
    index = strfind(AvturnTXT, '/');
    AvinTime = AvturnTXT(1:index(1)-2);
    AvoutTime = AvturnTXT(index(1)+2:index(2)-2);
    AvtotTime = AvturnTXT(index(2)+2:end-2);

    index1 = strfind(AvinTime, ' ');
    index2 = strfind(AvinTime, 's');
    index3 = strfind(AvinTime, '!');
    if isempty(index3) == 0;
        interpolationAvTurnIn(lapEC) = 1;
    else;
        interpolationAvTurnIn(lapEC) = 0;
    end;
    index = [index1 index2 index3];
    if isempty(index) == 0;
        AvinTime(index) = [];
    end;
    AvinTime = str2num(AvinTime);

    index1 = strfind(AvoutTime, ' ');
    index2 = strfind(AvoutTime, 's');
    index3 = strfind(AvoutTime, '!');
    if isempty(index3) == 0;
        interpolationAvTurnOut(lapEC) = 1;
    else;
        interpolationAvTurnOut(lapEC) = 0;
    end;
    index = [index1 index2 index3];
    if isempty(index) == 0;
        AvoutTime(index) = [];
    end;
    AvoutTime = str2num(AvoutTime);

    index1 = strfind(AvtotTime, ' ');
    index2 = strfind(AvtotTime, 's');
    index3 = strfind(AvtotTime, '!');
    if isempty(index3) == 0;
        interpolationAvTurnTot(lapEC) = 1;
    else;
        interpolationAvTurnTot(lapEC) = 0;
    end;
    index = [index1 index2 index3];
    if isempty(index) == 0;
        AvtotTime(index) = [];
    end;
    AvtotTime = str2num(AvtotTime);

    if isempty(find(interpolationAvTurnIn) == 1);
        %no interpolation
        TurnTimein_Average = [timeSecToStr2(AvinTime) '  '];
    else;
        TurnTimein_Average = [timeSecToStr2(AvinTime) ' !'];
    end;
    if isempty(find(interpolationAvTurnOut) == 1);
        %no interpolation
        TurnTimeout_Average = [timeSecToStr2(AvoutTime) '  '];
    else;
        TurnTimeout_Average = [timeSecToStr2(AvoutTime) ' !'];
    end;
    if isempty(find(interpolationAvTurnTot) == 1);
        %no interpolation
        TurnTime_Average = [timeSecToStr2(AvtotTime) '  '];
    else;
        TurnTime_Average = [timeSecToStr2(AvtotTime) ' !'];
    end;

elseif strcmpi(answerReport, 'SP2') == 1;
    
    turnTimeALL = dataTableSkillVAL{1,2};
    turnTimeInALL = dataTableSkillVAL{1,3};
    turnTimeOutALL = dataTableSkillVAL{1,4};
    
    for lapEC = 1:NbLap-1;        
        turnTimeEC = turnTimeALL(lapEC);
        turnTimeInEC = turnTimeInALL(lapEC);
        turnTimeOutEC = turnTimeOutALL(lapEC);
        
        eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(turnTimeInEC,2) ' '''' '  ' '''' '];']);
        eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(turnTimeOutEC,2) ' '''' '  ' '''' '];']);
        eval(['TurnTime' num2str(lapEC) ' = [dataToStr(turnTimeEC,2) ' '''' '  ' '''' '];']);
    
        BOKick_Turn = KicksNb(1,lapEC+1);

        %---200m take col = 12 for short interval splits
        BOTime_Turn = BOAll(lapEC+1,2) - dataTableAverage{(zoneSC*lapEC),12};
        BODist_Turn = BOAll(lapEC+1,3) - (lapEC*Course);
        BOAllINI = [BOAllINI; [BOTime_Turn BODist_Turn BOKick_Turn]];

        interpolationTurnIn(lapEC) = 0;
        interpolationTurnOut(lapEC) = 0;
        interpolationTurnTot(lapEC) = 0;
        interpolationBOTime_Turn(lapEC) = 0;
        interpolationBODist_Turn(lapEC) = 0;
    end;
    interpolationAvTurnIn = 0;
    interpolationAvTurnOut = 0;
    interpolationAvTurnTot = 0;
        
    AvTurnIn = dataTableSkillVAL{1,11};
    AvTurnOut = dataTableSkillVAL{1,12};
    AvTurnTime = dataTableSkillVAL{1,13};
    TurnTimein_Average = [timeSecToStr2(AvTurnIn) '  '];
    TurnTimeout_Average = [timeSecToStr2(AvTurnOut) '  '];
    TurnTime_Average = [timeSecToStr2(AvTurnTime) '  '];
end;
Turn1BODist = roundn(BOAllINI(2,2),-1);
Turn1BOTime = roundn(BOAllINI(2,1),-2);
Turn2BODist = roundn(BOAllINI(3,2),-1);
Turn2BOTime = roundn(BOAllINI(3,1),-2);
Turn3BODist = roundn(BOAllINI(4,2),-1);
Turn3BOTime = roundn(BOAllINI(4,1),-2);
Turn4BODist = roundn(BOAllINI(5,2),-1);
Turn4BOTime = roundn(BOAllINI(5,1),-2);
Turn5BODist = roundn(BOAllINI(6,2),-1);
Turn5BOTime = roundn(BOAllINI(6,1),-2);
Turn6BODist = roundn(BOAllINI(7,2),-1);
Turn6BOTime = roundn(BOAllINI(7,1),-2);
Turn7BODist = roundn(BOAllINI(8,2),-1);
Turn7BOTime = roundn(BOAllINI(8,1),-2);

KickCountLap1 = BOAllINI(1,3);
KickCountLap2 = BOAllINI(2,3);
KickCountLap3 = BOAllINI(3,3);
KickCountLap4 = BOAllINI(4,3);
KickCountLap5 = BOAllINI(5,3);
KickCountLap6 = BOAllINI(6,3);
KickCountLap7 = BOAllINI(7,3);
KickCountLap8 = BOAllINI(8,3);

RT = timeSecToStr2(RT);
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1; 
    valSkillTime = dataTableSkill{10,3};
    index1 = strfind(valSkillTime, ' ');
    index2 = strfind(valSkillTime, 's');
    index3 = strfind(valSkillTime, '!');

    if isempty(index3) == 0;
        interpolationSkillTime = 1;
    else;
        interpolationSkillTime = 0;
    end;

    if isempty(index2) == 1;
        %minute format
        index4 = strfind(valSkillTime, ':');
        
        timeMIN = valSkillTime(1:index4(1)-1);
        timeSEC = valSkillTime(index4(1)+1:end);

        valSkillTime = str2num(timeMIN).*60 + str2num(timeSEC);
    else;
        %second format
        index = [index1 index2 index3];
        if isempty(index) == 0;
            valSkillTime(index) = [];
        end;
        valSkillTime = str2num(valSkillTime);
    end;
    valFreeSwimTime = dataTablePacing(end,colinterest_Splits) - valSkillTime;

elseif strcmpi(answerReport, 'SP2') == 1;
    valSkillTime = DiveT15 + sum(turnTimeALL) + valFinishTime;
    valFreeSwimTime = dataTableAverage{end,12} - valSkillTime;
    interpolationSkillTime = 0;
end;

SkillTime = timeSecToStr2(roundn(valSkillTime,-2));
FreeSwimTime = timeSecToStr2(roundn(valFreeSwimTime,-2));
if interpolationSkillTime == 1;
    SkillTime = [SkillTime ' !'];
    FreeSwimTime = [FreeSwimTime ' !'];
else;
%         SkillTime = [SkillTime '  '];
%         FreeSwimTime = [FreeSwimTime '  '];
end;


%---Get SR, SC, breath and DPS
lapLim = Course:Course:RaceDist;
if Course == 25;
    if RaceDist == 50;
        dataZone(1,:) = [0 15];
        dataZone(2,:) = [15 25];
        dataZone(3,:) = [25 35];
        dataZone(4,:) = [35 45];
        dataZone(5,:) = [45 50];

    elseif RaceDist == 100;
        dataZone(1,:) = [0 15];
        dataZone(2,:) = [15 20];
        dataZone(3,:) = [20 25];
        dataZone(4,:) = [25 35];
        dataZone(5,:) = [35 45];
        dataZone(6,:) = [45 50];
        dataZone(7,:) = [50 60];
        dataZone(8,:) = [60 70];
        dataZone(9,:) = [70 75];
        dataZone(10,:) = [75 85];
        dataZone(11,:) = [85 95];
        dataZone(12,:) = [95 100];

    elseif RaceDist == 150;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];

    elseif RaceDist == 200;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];

    elseif RaceDist == 400;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];
        dataZone(9,:) = [200 225];
        dataZone(10,:) = [225 250];
        dataZone(11,:) = [250 275];
        dataZone(12,:) = [275 300];
        dataZone(13,:) = [300 325];
        dataZone(14,:) = [325 350];
        dataZone(15,:) = [350 375];
        dataZone(16,:) = [375 400];

    elseif RaceDist == 800;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];
        dataZone(9,:) = [200 225];
        dataZone(10,:) = [225 250];
        dataZone(11,:) = [250 275];
        dataZone(12,:) = [275 300];
        dataZone(13,:) = [300 325];
        dataZone(14,:) = [325 350];
        dataZone(15,:) = [350 375];
        dataZone(16,:) = [375 400];
        dataZone(17,:) = [400 425];
        dataZone(18,:) = [425 450];
        dataZone(19,:) = [450 475];
        dataZone(20,:) = [475 500];
        dataZone(21,:) = [500 525];
        dataZone(22,:) = [525 550];
        dataZone(23,:) = [550 575];
        dataZone(24,:) = [575 600];
        dataZone(25,:) = [600 625];
        dataZone(26,:) = [625 650];
        dataZone(27,:) = [650 675];
        dataZone(28,:) = [675 700];
        dataZone(29,:) = [700 725];
        dataZone(30,:) = [725 750];
        dataZone(31,:) = [750 775];
        dataZone(32,:) = [775 800];

    elseif RaceDist == 1500;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];
        dataZone(9,:) = [200 225];
        dataZone(10,:) = [225 250];
        dataZone(11,:) = [250 275];
        dataZone(12,:) = [275 300];
        dataZone(13,:) = [300 325];
        dataZone(14,:) = [325 350];
        dataZone(15,:) = [350 375];
        dataZone(16,:) = [375 400];
        dataZone(17,:) = [400 425];
        dataZone(18,:) = [425 450];
        dataZone(19,:) = [450 475];
        dataZone(20,:) = [475 500];
        dataZone(21,:) = [500 525];
        dataZone(22,:) = [525 550];
        dataZone(23,:) = [550 575];
        dataZone(24,:) = [575 600];
        dataZone(25,:) = [600 625];
        dataZone(26,:) = [625 650];
        dataZone(27,:) = [650 675];
        dataZone(28,:) = [675 700];
        dataZone(29,:) = [700 725];
        dataZone(30,:) = [725 750];
        dataZone(31,:) = [750 775];
        dataZone(32,:) = [775 800];
        dataZone(33,:) = [800 825];
        dataZone(34,:) = [825 850];
        dataZone(35,:) = [850 875];
        dataZone(36,:) = [875 900];
        dataZone(37,:) = [900 925];
        dataZone(38,:) = [925 950];
        dataZone(39,:) = [950 975];
        dataZone(40,:) = [975 1000];
        dataZone(41,:) = [1000 1025];
        dataZone(42,:) = [1025 1050];
        dataZone(43,:) = [1050 1075];
        dataZone(44,:) = [1075 1100];
        dataZone(45,:) = [1100 1125];
        dataZone(46,:) = [1125 1150];
        dataZone(47,:) = [1150 1175];
        dataZone(48,:) = [1175 1200];
        dataZone(49,:) = [1200 1225];
        dataZone(50,:) = [1225 1250];
        dataZone(51,:) = [1250 1275];
        dataZone(52,:) = [1275 1300];
        dataZone(53,:) = [1300 1325];
        dataZone(54,:) = [1325 1350];
        dataZone(55,:) = [1350 1375];
        dataZone(56,:) = [1375 1400];
        dataZone(57,:) = [1400 1425];
        dataZone(58,:) = [1425 1450];
        dataZone(59,:) = [1450 1475];
        dataZone(60,:) = [1475 1500];
    end;
elseif Course == 50;
    if RaceDist == 50;
        dataZone(1,:) = [0 15];
        dataZone(2,:) = [15 25];
        dataZone(3,:) = [25 35];
        dataZone(4,:) = [35 45];
        dataZone(5,:) = [45 50];

    elseif RaceDist == 100;
        dataZone(1,:) = [0 15];
        dataZone(2,:) = [15 25];
        dataZone(3,:) = [25 35];
        dataZone(4,:) = [35 45];
        dataZone(5,:) = [45 50];
        dataZone(6,:) = [50 65];
        dataZone(7,:) = [65 75];
        dataZone(8,:) = [75 85];
        dataZone(9,:) = [85 95];
        dataZone(10,:) = [95 100];

    elseif RaceDist == 150;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];

    elseif RaceDist == 200;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];

    elseif RaceDist == 400;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];
        dataZone(9,:) = [200 225];
        dataZone(10,:) = [225 250];
        dataZone(11,:) = [250 275];
        dataZone(12,:) = [275 300];
        dataZone(13,:) = [300 325];
        dataZone(14,:) = [325 350];
        dataZone(15,:) = [350 375];
        dataZone(16,:) = [375 400];

    elseif RaceDist == 800;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];
        dataZone(9,:) = [200 225];
        dataZone(10,:) = [225 250];
        dataZone(11,:) = [250 275];
        dataZone(12,:) = [275 300];
        dataZone(13,:) = [300 325];
        dataZone(14,:) = [325 350];
        dataZone(15,:) = [350 375];
        dataZone(16,:) = [375 400];
        dataZone(17,:) = [400 425];
        dataZone(18,:) = [425 450];
        dataZone(19,:) = [450 475];
        dataZone(20,:) = [475 500];
        dataZone(21,:) = [500 525];
        dataZone(22,:) = [525 550];
        dataZone(23,:) = [550 575];
        dataZone(24,:) = [575 600];
        dataZone(25,:) = [600 625];
        dataZone(26,:) = [625 650];
        dataZone(27,:) = [650 675];
        dataZone(28,:) = [675 700];
        dataZone(29,:) = [700 725];
        dataZone(30,:) = [725 750];
        dataZone(31,:) = [750 775];
        dataZone(32,:) = [775 800];

    elseif RaceDist == 1500;
        dataZone(1,:) = [0 25];
        dataZone(2,:) = [25 50];
        dataZone(3,:) = [50 75];
        dataZone(4,:) = [75 100];
        dataZone(5,:) = [100 125];
        dataZone(6,:) = [125 150];
        dataZone(7,:) = [150 175];
        dataZone(8,:) = [175 200];
        dataZone(9,:) = [200 225];
        dataZone(10,:) = [225 250];
        dataZone(11,:) = [250 275];
        dataZone(12,:) = [275 300];
        dataZone(13,:) = [300 325];
        dataZone(14,:) = [325 350];
        dataZone(15,:) = [350 375];
        dataZone(16,:) = [375 400];
        dataZone(17,:) = [400 425];
        dataZone(18,:) = [425 450];
        dataZone(19,:) = [450 475];
        dataZone(20,:) = [475 500];
        dataZone(21,:) = [500 525];
        dataZone(22,:) = [525 550];
        dataZone(23,:) = [550 575];
        dataZone(24,:) = [575 600];
        dataZone(25,:) = [600 625];
        dataZone(26,:) = [625 650];
        dataZone(27,:) = [650 675];
        dataZone(28,:) = [675 700];
        dataZone(29,:) = [700 725];
        dataZone(30,:) = [725 750];
        dataZone(31,:) = [750 775];
        dataZone(32,:) = [775 800];
        dataZone(33,:) = [800 825];
        dataZone(34,:) = [825 850];
        dataZone(35,:) = [850 875];
        dataZone(36,:) = [875 900];
        dataZone(37,:) = [900 925];
        dataZone(38,:) = [925 950];
        dataZone(39,:) = [950 975];
        dataZone(40,:) = [975 1000];
        dataZone(41,:) = [1000 1025];
        dataZone(42,:) = [1025 1050];
        dataZone(43,:) = [1050 1075];
        dataZone(44,:) = [1075 1100];
        dataZone(45,:) = [1100 1125];
        dataZone(46,:) = [1125 1150];
        dataZone(47,:) = [1150 1175];
        dataZone(48,:) = [1175 1200];
        dataZone(49,:) = [1200 1225];
        dataZone(50,:) = [1225 1250];
        dataZone(51,:) = [1250 1275];
        dataZone(52,:) = [1275 1300];
        dataZone(53,:) = [1300 1325];
        dataZone(54,:) = [1325 1350];
        dataZone(55,:) = [1350 1375];
        dataZone(56,:) = [1375 1400];
        dataZone(57,:) = [1400 1425];
        dataZone(58,:) = [1425 1450];
        dataZone(59,:) = [1450 1475];
        dataZone(60,:) = [1475 1500];
    end;
end;
nbZones = length(dataZone(:,1));

%Breath 200m, long intervals take col=3
validIndex = [5 10 15 20 25 30 35 40];
lapEC = 1;
for iter = 1:length(validIndex);
    valEC = roundn(dataTableBreath(validIndex(iter), 3),0);
    if isempty(valEC) == 1 | isnan(valEC) == 1;
        ValEC = '0';
    else;
        ValEC = dataToStr(valEC,0);
    end;
    eval(['BreathCountLap' num2str(lapEC) ' = ValEC;']);
    lapEC = lapEC + 1;
end;
BreathSum = sum(dataTableBreath(:,1));
if BreathSum == 0
    BreathTot = '0';
else;
    BreathTot = num2str(BreathSum);
end;


if Course == 25;
    seg = 5;
else;
    seg = 10;
end;
VelTOT = [];
iter = 1;

if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    validIndex = [5 10 15 20 25 30 35 40];
    interpVel = 0;
    VelLap = [];

    colinterest_Speed = 7;
    colinterest_SpeedInterp = 8;
    VELTOT = [];
    for iter = 1:length(validIndex);
        valEC = dataTablePacing(validIndex(iter),colinterest_Speed);

        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '         ';
        else;
            VELTOT = [VELTOT valEC];
            ValEC = [dataToStr(valEC,2) '  '];
        end;
        eval(['Vel' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;

    indexNAN = strfind(lower(databaseCurrent{1,32}), 'nan');
    if isempty(indexNAN) == 0;
        index1 = find(VELTOT == 0);
        index2 = find(isnan(VELTOT) == 1);
        index = [index1 index2];
        if isempty(index) == 0;
            VELTOT = VELTOT(index);
        end;
        VelAverage = mean(VELTOT);
        VelAverage = [dataToStr(VelAverage, 2) '  '];
    else;
        VelAverage = [databaseCurrent{1,32} '  '];
    end;

elseif strcmpi(answerReport, 'SP2') == 1;
    %200m race so take col 4 for the speed
    VelLap = [];
    interpVel = 0;
    colinterest_Speed = 4;
    colinterest_SpeedInterp = [];

    VELTOT = [];
    validIndex = [5 10 15 20 25 30 35 40];
    for iter = 1:length(validIndex);
        valEC = dataTableAverage{validIndex(iter),colinterest_Speed};
        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '         ';
        else;
            VELTOT = [VELTOT valEC];
            ValEC = dataToStr(valEC,2);
        end;
        eval(['Vel' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    VelAverage = databaseCurrent{1,32};
end;
    

DPSTOT = [];
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    %it's a 200 so take col = 7 for short intervals
    colinterest_DPS = 7;
    colinterest_DPSInterp = 8;

    validIndex = [5 10 15 20 25 30 35 40];
    DPSTOT = [];
    for iter = 1:length(validIndex);
        valEC = dataTableStroke(validIndex(iter),colinterest_DPS);
        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '         ';
        else;
            DPSTOT = [DPSTOT valEC];
            ValEC = [dataToStr(valEC,2) '  '];
        end;
        eval(['DPS' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    
    indexNAN = strfind(lower(databaseCurrent{1,34}), 'nan');
    if isempty(indexNAN) == 0;
        index1 = find(DPSTOT == 0);
        index2 = find(isnan(DPSTOT) == 1);
        index = [index1 index2];
        if isempty(index) == 0;
            DPSTOT = DPSTOT(index);
        end;
        DPSAverage = mean(DPSTOT);
        DPSAverage = [dataToStr(DPSAverage, 2) '  '];
    else;
        DPSAverage = [databaseCurrent{1,34} '  '];
    end;

elseif strcmpi(answerReport, 'SP2') == 1;
    %it's a 200 so take col = 10 for short intervals
    validIndex = [5 10 15 20 25 30 35 40];
    DPSLap = [];
    interpDPS = 0;
    colinterest_DPS = 10;
    colinterest_DPSInterp = [];

    DPSTOT = [];
    for iter = 1:length(validIndex);
        valEC = dataTableAverage{validIndex(iter),colinterest_DPS};
        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '         ';
        else;
            DPSTOT = [DPSTOT valEC];
            ValEC = dataToStr(valEC,2);
        end;
        eval(['DPS' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    DPSAverage = databaseCurrent{1,34};
end;

 
SRTOT = [];
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
   
    %It's a 200m so take col = 3 for short intervals
    validIndex = [5 10 15 20 25 30 35 40];
    SRLap = [];
    interpSR = 0;
    colinterest_SR = 3;
    colinterest_SRInterp = 4;

    SRTOT = [];
    for iter = 1:length(validIndex);
        valEC = dataTableStroke(validIndex(iter),colinterest_SR);
        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '         ';
        else;
            SRTOT = [SRTOT valEC];
            ValEC = [dataToStr(valEC,1) '  '];
        end;
        eval(['SR' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    
    indexNAN = strfind(lower(databaseCurrent{1,33}), 'nan');
    if isempty(indexNAN) == 0;
        index1 = find(SRTOT == 0);
        index2 = find(isnan(SRTOT) == 1);
        index = [index1 index2];
        if isempty(index) == 0;
            SRTOT = SRTOT(index);
        end;
        SRAverage = mean(SRTOT);
        SRAverage = [dataToStr(SRAverage, 1) '  '];
    else;
        SRAverage = [databaseCurrent{1,33} '  '];
    end;

elseif strcmpi(answerReport, 'SP2') == 1;
    
    %It's a 200m so take col = 7 for short intervals
    validIndex = [5 10 15 20 25 30 35 40];
    SRLap = [];
    interpSR = 0;
    colinterest_SR = 7;
    colinterest_SRInterp = [];

    SRTOT = [];
    for iter = 1:length(validIndex);
        valEC = dataTableAverage{validIndex(iter),colinterest_SR};
        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '         ';
        else;
            SRTOT = [SRTOT valEC];
            ValEC = dataToStr(valEC,1);
        end;
        eval(['SR' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    SRAverage = databaseCurrent{1,33};
end;


NbLap = (RaceDist./Course);
keyDist = Course:Course:(NbLap*Course);
if Source == 1 | Source == 3;
    %It's a 50m so take col = 10 for short intervals
    colinterest_SC = 10;

    indexLapINI = 1;
    for lapEC = 1:NbLap;
        indexLapEND = find(dataTableRefDist == keyDist(lapEC));
        valStrokes = dataTableStroke(indexLapINI:indexLapEND, colinterest_SC);
        indexNAN = find(isnan(valStrokes) == 1);
        valStrokes(indexNAN) = [];
        Stroke_Count(lapEC) = sum(valStrokes);

        indexLapINI = indexLapEND + 1;
    end;
elseif Source == 2;
    %It's a 50m so take col = 15 for short intervals
    indexLapINI = 1;
    for lapEC = 1:NbLap;
        indexLapEND = find(dataTableRefDist == keyDist(lapEC));
        
        valStrokes = dataTableAverage(indexLapINI:indexLapEND,16);
        valStrokes = cell2mat(valStrokes);
        indexNAN = find(isnan(valStrokes) == 1);
        valStrokes(indexNAN) = [];
        Stroke_Count(lapEC) = sum(valStrokes);

        indexLapINI = indexLapEND + 1;
    end;
end;

if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    midPoint = length(dataTablePacing(:,1))./2;
    TimeOutSec = timeSecToStr2(dataTablePacing(midPoint,colinterest_Splits));
    TimeBackSec = timeSecToStr2(dataTablePacing(end,colinterest_Splits) - dataTablePacing(midPoint,colinterest_Splits));
    valOut = roundn(dataTablePacing(midPoint,colinterest_Splits) ./ dataTablePacing(end,colinterest_Splits),-4);
    TimeOutPerc = [dataToStr((valOut).*100,2) ' %'];
    valBack = roundn((dataTablePacing(end,colinterest_Splits) - dataTablePacing(midPoint,colinterest_Splits)) ./ dataTablePacing(end,colinterest_Splits),-4);
    TimeBackPerc = [dataToStr((valBack).*100,2) ' %'];
    DropOff = timeSecToStr2((dataTablePacing(end,colinterest_Splits) - dataTablePacing(midPoint,colinterest_Splits)) - dataTablePacing(midPoint,colinterest_Splits));
elseif strcmpi(answerReport, 'SP2') == 1;
    midPoint = length(dataTableAverage(:,1))./2;
    TimeOutSec = timeSecToStr2(dataTableAverage{midPoint,colinterest_Splits});
    TimeBackSec = timeSecToStr2(dataTableAverage{end,colinterest_Splits} - dataTableAverage{midPoint,colinterest_Splits});
    valOut = roundn(dataTableAverage{midPoint,colinterest_Splits} ./ dataTableAverage{end,colinterest_Splits},-4);
    TimeOutPerc = [dataToStr((valOut).*100,2) ' %'];
    valBack = roundn((dataTableAverage{end,colinterest_Splits} - dataTableAverage{midPoint,colinterest_Splits}) ./ dataTableAverage{end,colinterest_Splits},-4);
    TimeBackPerc = [dataToStr((valBack).*100,2) ' %'];
    DropOff = timeSecToStr2((dataTableAverage{end,12} - dataTableAverage{midPoint,12}) - dataTableAverage{midPoint,12});
end;
%--------------------------------------------------------------------------






%--------------------------------Top info----------------------------------
txtLastname_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-40, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font1, 'String', AthletenameFull);
set(txtLastname_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtRace_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-70, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font2, 'String', Race);
set(txtRace_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtRound_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-90, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font2, 'String', Round);
set(txtRound_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtMeet_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-110, 600, 15], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', Meet);
set(txtMeet_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtVenue_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-125, 600, 15], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', Venue);
set(txtVenue_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtDate_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-145, 600, 15], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font2, 'String', RaceDate);
set(txtDate_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtUser1_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [window_size(3)-640, window_size(4)-145, 600, 15], 'HorizontalAlignment', 'right', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', ReportDate);
set(txtUser1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtUser2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [window_size(3)-640, window_size(4)-160, 600, 15], 'HorizontalAlignment', 'right', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', AnalysisDate);
set(txtUser2_pdf, 'fontunits', 'normalized', 'units', 'normalized');
%--------------------------------------------------------------------------




%--------------------------------Top table---------------------------------
txtLegend_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-195, window_size(3)-60, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'FontAngle', 'Italic', 'Fontsize', font3, 'String', '[ ! = Interpolated data for historical race analysis systems (GreenEye and Sparta 1)]');
set(txtLegend_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue1_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-240, window_size(3)-60, 50], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtBlue1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Times';
txtTitle1_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'First Breakout';
txtTitle2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [320, window_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Pacing';
txtTitle3_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, window_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle3_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Summary';
txtTitle4_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, window_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle4_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Block (s):';
txtBlock_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtBlock_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = RT;
txtBlock2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, window_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtBlock2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Start/15 m (s):';
txtST_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtST_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = StartTime;
txtST2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, window_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtST2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = '25 m (s):';
txt25m_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txt25m_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = Time25m;
txt25m2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, window_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txt25m2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Finish/Last 5 m (s):';
txtFinish_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, window_size(4)-330, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtFinish_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = FinishTime;
txtFinish2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, window_size(4)-330, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtFinish2_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Breakout time (s):';
txtStartBOTime1_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [320, window_size(4)-270, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtStartBOTime1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = StartBOTime;
txtStartBOTime2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [490, window_size(4)-270, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtStartBOTime2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Breakout distance (m):';
txtStartBODist1_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [320, window_size(4)-290, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtStartBODist1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = StartBODist;
txtStartBODist2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [490, window_size(4)-290, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtStartBODist2_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Out (s):';
txtOut_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, window_size(4)-270, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtOut_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = [TimeOutSec '   (' TimeOutPerc ')'];
txtOut2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [730, window_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtOut2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Back (s):';
txtBack_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, window_size(4)-290, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtBack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = [TimeBackSec '   (' TimeBackPerc ')'];
txtBack2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [730, window_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtBack2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Drop off (s):';
txtDropOff_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, window_size(4)-310, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtDropOff_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = DropOff;
txtDropOff2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [730, window_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtDropOff2_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Total time (s):';
txtTT_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, window_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtTT_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = RaceTime;
txtTT2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1030, window_size(4)-270, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTT2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Total skill time (s):';
txtSkillT_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, window_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtSkillT_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = SkillTime;
txtSkillT2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1030, window_size(4)-290, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtSkillT2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Total free swim (s):';
txtFreeT_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, window_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtFreeT_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = FreeSwimTime;
txtFreeT2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1030, window_size(4)-310, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtFreeT2_pdf, 'fontunits', 'normalized', 'units', 'normalized');
%--------------------------------------------------------------------------





%--------------------------------Top table---------------------------------
txtBlue2_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-400, window_size(3)-60, 50], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtBlue2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue5_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-385, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', 'Segment');
set(txtBlue5_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue6a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [150, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Vel');
set(txtBlue6a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue6b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [150, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(m/s)');
set(txtBlue6b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue7a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [210, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'SR');
set(txtBlue7a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue7b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [210, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(str/min)');
set(txtBlue7b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue8a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [270, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'DPS');
set(txtBlue8a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue8b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [270, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(m)');
set(txtBlue8b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue9_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [330, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Strokes');
set(txtBlue9_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue10_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [390, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Breaths');
set(txtBlue10_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue11_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [450, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Kicks');
set(txtBlue11_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue12a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [510, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Breakout');
set(txtBlue12a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue12b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [510, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(m)');
set(txtBlue12b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue13a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [570, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'In');
set(txtBlue13a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue13b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [570, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(s)');
set(txtBlue13b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue14a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [630, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Out');
set(txtBlue14a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue14b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [630, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(s)');
set(txtBlue14b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue15a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [690, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Turn');
set(txtBlue15a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue15b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [690, window_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(s)');
set(txtBlue15b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue16_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [750, window_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'TI');
set(txtBlue16_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue17_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [810, window_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Split');
set(txtBlue17_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue18_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [882 window_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Lap');
set(txtBlue18_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue19_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [954, window_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', '100 m');
set(txtBlue19_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue20_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1026, window_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', '200 m');
set(txtBlue20_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue21_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1098, window_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', '500 m');
set(txtBlue21_pdf, 'fontunits', 'normalized', 'units', 'normalized');


txtCol1a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-430, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-425, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0         -        25');
set(txtCol1A_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1b_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-460, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1b_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1B_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-455, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25       -        50');
set(txtCol1B_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1c_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-490, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1c_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1C_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-485, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50       -        75');
set(txtCol1C_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1d_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-520, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1d_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1D_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-515, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', ' 75        -        100');
set(txtCol1D_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1e_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-550, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1e_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1E_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-545, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100       -        125');
set(txtCol1E_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1f_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-580, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1f_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1F_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-575, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125       -        150');
set(txtCol1F_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1g_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-610, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1G_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-605, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150       -        175');
set(txtCol1G_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1h_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-640, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1h_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1H_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-635, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175       -        200');
set(txtCol1H_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1m_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-670, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.97 0.97 0.94], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1m_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1M_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-665, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.97 0.97 0.94], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Race Averages');
set(txtCol1M_pdf, 'fontunits', 'normalized', 'units', 'normalized');

% txtCol1i_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-670, 120, 30], 'HorizontalAlignment', 'left', ...
%     'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
% set(txtCol1i_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% txtCol1I_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-665, 120, 20], 'HorizontalAlignment', 'center', ...
%     'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '70        -        75');
% set(txtCol1I_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% 
% txtCol1j_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-700, 120, 30], 'HorizontalAlignment', 'left', ...
%     'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
% set(txtCol1j_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% txtCol1J_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-695, 120, 20], 'HorizontalAlignment', 'center', ...
%     'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75        -        85');
% set(txtCol1J_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% 
% txtCol1k_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-730, 120, 30], 'HorizontalAlignment', 'left', ...
%     'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
% set(txtCol1k_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% txtCol1K_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-725, 120, 20], 'HorizontalAlignment', 'center', ...
%     'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '85        -        95');
% set(txtCol1K_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% 
% txtCol1l_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-760, 120, 30], 'HorizontalAlignment', 'left', ...
%     'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
% set(txtCol1l_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% txtCol1L_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-755, 120, 20], 'HorizontalAlignment', 'center', ...
%     'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', ' 95        -      100');
% set(txtCol1L_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% 
% txtCol1m_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-790, 120, 30], 'HorizontalAlignment', 'left', ...
%     'BackgroundColor', [0.97 0.97 0.94], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
% set(txtCol1m_pdf, 'fontunits', 'normalized', 'units', 'normalized');
% txtCol1M_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
%     'position', [30, window_size(4)-785, 120, 20], 'HorizontalAlignment', 'center', ...
%     'BackgroundColor', [0.97 0.97 0.94], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
%     'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Race Averages');
% set(txtCol1M_pdf, 'fontunits', 'normalized', 'units', 'normalized');


position1INI = [150, window_size(4)-430, 60, 30];
position2INI = [150, window_size(4)-425, 60, 20];
ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol2a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol2A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', VelAverage);
        set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        eval(['val = Vel' num2str(LapDist(i)) 'm;']);
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;

position1INI = [210, window_size(4)-430, 60, 30];
position2INI = [210, window_size(4)-425, 60, 20];
ColorOdd = [0.98 0.97 0.91];
ColorEven = [0.88 0.89 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol3a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [210, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol3a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol3A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [210, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', SRAverage);
        set(txtCol3A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        eval(['val = SR' num2str(LapDist(i)) 'm;']);
        if isodd == 1;
            txtCol3a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol3a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol3A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol3A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol3a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol3a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol3A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol3A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [270, window_size(4)-430, 60, 30];
position2INI = [270, window_size(4)-425, 60, 20];
ColorOdd = [0.98 0.97 0.91];
ColorEven = [0.88 0.89 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol4a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [270, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol4a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol4A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [270, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', DPSAverage);
        set(txtCol4A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        eval(['val = DPS' num2str(LapDist(i)) 'm;']);
        if isodd == 1;
            txtCol4a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol4a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol4A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol4A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol4a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol4a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol4A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol4A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;


position1INI = [330, window_size(4)-430, 60, 30];
position2INI = [330, window_size(4)-425, 60, 20];
ColorOdd = [0.98 0.97 0.91];
ColorEven = [0.88 0.89 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol5a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [330, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol5a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol5A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [330, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol5A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        val = Stroke_Count(i);
        if isodd == 1;
            txtCol5a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol5a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol5A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol5A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol5a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol5a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol5A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol5A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [390, window_size(4)-430, 60, 30];
position2INI = [390, window_size(4)-425, 60, 20];
ColorOdd = [0.98 1 1];
ColorEven = [0.87 0.91 0.92];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol6a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [390, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol6a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol6A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [390, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol6A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        eval(['val = BreathCountLap' num2str(i) ';']);
        if isodd == 1;
            txtCol6a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol6a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol6A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol6A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol6a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol6a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol6A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol6A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [450, window_size(4)-430, 60, 30];
position2INI = [450, window_size(4)-425, 60, 20];
ColorOdd = [0.98 1 1];
ColorEven = [0.87 0.91 0.92];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol7a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [450, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol7a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol7A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [450, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol7A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        eval(['val = KickCountLap' num2str(i) ';']);
        if isodd == 1;
            txtCol7a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol7a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol7A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol7A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol7a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol7a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol7A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol7A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;




position1INI = [510, window_size(4)-430, 60, 30];
position2INI = [510, window_size(4)-425, 60, 20];
ColorOdd = [0.97 0.96 0.98];
ColorEven = [0.85 0.89 0.93];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol8a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [510, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol8a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol8A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [510, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol8A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        if i == 1;
            val = StartBODist;
        else;
            eval(['val = Turn' num2str(i-1) 'BODist;']);
        end;
        if isodd == 1;
            txtCol8a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol8a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol8A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol8A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol8a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol8a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol8A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol8A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [569, window_size(4)-430, 62, 30];
position2INI = [569, window_size(4)-425, 62, 20];
ColorOdd = [0.97 0.96 0.98];
ColorEven = [0.85 0.89 0.93];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol9a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [569, window_size(4)-670, 62, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol9a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol9A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [569, window_size(4)-665, 62, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTimein_Average);
        set(txtCol9A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        if i == length(LapDist);
            val = '';
        else;
            eval(['val = TurnTime' num2str(i) 'in;']);
        end;
        if isodd == 1;
            txtCol9a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol9a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol9A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol9A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol9a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol9a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol9A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol9A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [630, window_size(4)-430, 60, 30];
position2INI = [630, window_size(4)-425, 60, 20];
ColorOdd = [0.97 0.96 0.98];
ColorEven = [0.85 0.89 0.93];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol10a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [630, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol10a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol10A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [630, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTimeout_Average);
        set(txtCol10A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        if i == length(LapDist);
            val = '';
        else;
            eval(['val = TurnTime' num2str(i) 'out;']);
        end;
        if isodd == 1;
            txtCol10a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol10a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol10A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol10A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol10a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol10a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol10A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol10A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;




position1INI = [690, window_size(4)-430, 60, 30];
position2INI = [690, window_size(4)-425, 60, 20];
ColorOdd = [0.97 0.96 0.98];
ColorEven = [0.85 0.89 0.93];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol11a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [690, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol11a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol11A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [690, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTime_Average);
        set(txtCol11A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        if i == length(LapDist);
            val = '';
        else;
            eval(['val = TurnTime' num2str(i) ';']);
        end;
        if isodd == 1;
            txtCol11a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol11a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol11A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol11A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol11a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol11a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol11A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol11A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [750, window_size(4)-430, 60, 30];
position2INI = [750, window_size(4)-425, 60, 20];
ColorOdd = [0.97 0.96 0.98];
ColorEven = [0.85 0.89 0.93];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol12a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [750, window_size(4)-670, 60, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol12a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol12A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [750, window_size(4)-665, 60, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol12A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        val = '';
        if isodd == 1;
            txtCol12a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol12a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol12A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol12A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol12a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol12a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol12A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol12A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [810, window_size(4)-430, 72, 30];
position2INI = [810, window_size(4)-425, 72, 20];
ColorOdd = [0.97 0.96 0.98];
ColorEven = [0.85 0.89 0.93];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol13a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [810, window_size(4)-670, 72, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol13a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol13A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [810, window_size(4)-665, 72, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol13A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        eval(['val = Split' num2str(LapDist(i)) 'm;']);
        if isodd == 1;
            txtCol13a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol13a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol13A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol13A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol13a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol13a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol13A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol13A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [882, window_size(4)-430, 72, 30];
position2INI = [882, window_size(4)-425, 72, 20];
ColorOdd = [1 0.99 0.94];
ColorEven = [0.89 0.93 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol14a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [882, window_size(4)-670, 72, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol14a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol14A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [882, window_size(4)-665, 72, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol14A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        eval(['val = SplitLap' num2str(i) ';']);
        if isodd == 1;
            txtCol14a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol14a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol14A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol14A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol14a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol14a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol14A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol14A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [954, window_size(4)-430, 72, 30];
position2INI = [954, window_size(4)-425, 72, 20];
ColorOdd = [1 0.99 0.94];
ColorEven = [0.89 0.93 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
Inc = [4 8];
splitEC = 1;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol15a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [954, window_size(4)-670, 72, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol15a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol15A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [954, window_size(4)-665, 72, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol15A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        liInc = find(Inc == i);
        if isempty(liInc) == 1;
            val = '';
        else;
            eval(['val = SplitA' num2str(splitEC) '00m;']);
            splitEC = splitEC + 1;
        end;    
        if isodd == 1;
            txtCol15a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol15a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol15A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol15A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol15a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol15a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol15A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol15A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;




position1INI = [1026, window_size(4)-430, 72, 30];
position2INI = [1026, window_size(4)-425, 72, 20];
ColorOdd = [1 0.99 0.94];
ColorEven = [0.89 0.93 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
Inc = [8];
splitEC = 2;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol16a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [1026, window_size(4)-670, 72, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol16a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol16A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [1026, window_size(4)-665, 72, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol16A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        liInc = find(Inc == i);
        if isempty(liInc) == 1;
            val = '';
        else;
            eval(['val = SplitB' num2str(splitEC) '00m;']);
            splitEC = splitEC + 2;
        end;    
        if isodd == 1;
            txtCol16a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol16a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol16A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol16A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol16a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol16a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol16A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol16A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



position1INI = [1098, window_size(4)-430, 72, 30];
position2INI = [1098, window_size(4)-425, 72, 20];
ColorOdd = [1 0.99 0.94];
ColorEven = [0.89 0.93 0.89];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
Inc = [];
splitEC = 5;
for i = 1:length(LapDist)+1;
    isodd = rem(i, 2);
    if i == length(LapDist)+1;
        txtCol17a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [1098, window_size(4)-670, 72, 30], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol17a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        txtCol17A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [1098, window_size(4)-665, 72, 20], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtCol17A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
        position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        
        liInc = find(Inc == i);
        if isempty(liInc) == 1;
            val = '';
        else;
            eval(['val = SplitC' num2str(splitEC) '00m;']);
            splitEC = splitEC + 5;
        end;    
        if isodd == 1;
            txtCol17a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol17a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol17A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol17A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol17a_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol17a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol17A_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol17A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    end;
    iter = i*30;
end;



txtBlack_pdf = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, window_size(4)-670, 1140, 1], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
%--------------------------------------------------------------------------



handles2.filename = filename;
handles2.hdef = hdef;
handles2.RaceDist = LapDist(end);
guidata(handles2.hdef, handles2);
