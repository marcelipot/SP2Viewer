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

    if window_size(3) < 1140 | window_size(4) < 850;
        h = warndlg('Screen resolution below [1140 850]. Display could be impacted', 'Warning');
        waitfor(h);
    end;

    hdef = figure('units', 'pixels', 'position', window_size, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Sparta - Report', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
else;
    resolution = [1920 1080];
    window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 850]);
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))-offzetSize]);
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
    handles2.panelMain = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, resolution(2)-(0.1*resolution(2))-1420, 1200, 1410], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, resolution(2)-1410, 1200, 1410];
    handles2.panel_size = get(handles2.panelMain, 'Position');
    
    handles2.sliderRight = uicontrol('parent', hdef, 'Style', 'Slider', 'Visible', 'on', ...
        'Units', 'Pixels', 'Position', [1180 1 20 resolution(2)-(0.1*resolution(2))-1],...
        'min', 0, 'max', 1, 'callback', @sliderRight_report, 'Value', 1, ...
        'sliderstep', [1 1]);
    set(handles2.sliderRight, 'fontunits', 'normalized', 'units', 'normalized');
    
    handles2.save_button_report = uicontrol('parent', handles2.panelMain, 'Style', 'Pushbutton', ...
        'Visible', 'on', 'units', 'pixels', ...
        'position', [970 panel_size(4)-50 200 30], 'callback', @savedata_report_benchmark, ...
        'BackgroundColor', [0.9 0.9 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', ...
        'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Export to JPG');
    set(handles2.save_button_report, 'fontunits', 'normalized', 'units', 'normalized');

    set(hdef, 'WindowScrollWheelFcn', @scrollSP1report);
else;
    handles2.panelMain = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, 850], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, 10, 1200, 850];
    handles2.panel_size = get(handles2.panelMain, 'Position');
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
    %its a 400m so that short intervals
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
    Split225m = timeSecToStr2(dataTablePacing(45,colinterest_Splits));
    Split250m = timeSecToStr2(dataTablePacing(50,colinterest_Splits));
    Split275m = timeSecToStr2(dataTablePacing(55,colinterest_Splits));
    Split300m = timeSecToStr2(dataTablePacing(60,colinterest_Splits));
    Split325m = timeSecToStr2(dataTablePacing(65,colinterest_Splits));
    Split350m = timeSecToStr2(dataTablePacing(70,colinterest_Splits));
    Split375m = timeSecToStr2(dataTablePacing(75,colinterest_Splits));
    Split400m = timeSecToStr2(dataTablePacing(80,colinterest_Splits));
    Split425m = timeSecToStr2(dataTablePacing(85,colinterest_Splits));
    Split450m = timeSecToStr2(dataTablePacing(90,colinterest_Splits));
    Split475m = timeSecToStr2(dataTablePacing(95,colinterest_Splits));
    Split500m = timeSecToStr2(dataTablePacing(100,colinterest_Splits));
    Split525m = timeSecToStr2(dataTablePacing(105,colinterest_Splits));
    Split550m = timeSecToStr2(dataTablePacing(110,colinterest_Splits));
    Split575m = timeSecToStr2(dataTablePacing(115,colinterest_Splits));
    Split600m = timeSecToStr2(dataTablePacing(120,colinterest_Splits));
    Split625m = timeSecToStr2(dataTablePacing(125,colinterest_Splits));
    Split650m = timeSecToStr2(dataTablePacing(130,colinterest_Splits));
    Split675m = timeSecToStr2(dataTablePacing(135,colinterest_Splits));
    Split700m = timeSecToStr2(dataTablePacing(140,colinterest_Splits));
    Split725m = timeSecToStr2(dataTablePacing(145,colinterest_Splits));
    Split750m = timeSecToStr2(dataTablePacing(150,colinterest_Splits));
    Split775m = timeSecToStr2(dataTablePacing(155,colinterest_Splits));
    Split800m = timeSecToStr2(dataTablePacing(160,colinterest_Splits));


    SplitLap1 = timeSecToStr2(dataTablePacing(5,colinterest_Splits));
    SplitLap2 = timeSecToStr2(dataTablePacing(10,colinterest_Splits) - dataTablePacing(5,colinterest_Splits));
    SplitLap3 = timeSecToStr2(dataTablePacing(15,colinterest_Splits) - dataTablePacing(10,colinterest_Splits));
    SplitLap4 = timeSecToStr2(dataTablePacing(20,colinterest_Splits) - dataTablePacing(15,colinterest_Splits));
    SplitLap5 = timeSecToStr2(dataTablePacing(25,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
    SplitLap6 = timeSecToStr2(dataTablePacing(30,colinterest_Splits) - dataTablePacing(25,colinterest_Splits));
    SplitLap7 = timeSecToStr2(dataTablePacing(35,colinterest_Splits) - dataTablePacing(30,colinterest_Splits));
    SplitLap8 = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(35,colinterest_Splits));
    SplitLap9 = timeSecToStr2(dataTablePacing(45,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
    SplitLap10 = timeSecToStr2(dataTablePacing(50,colinterest_Splits) - dataTablePacing(45,colinterest_Splits));
    SplitLap11 = timeSecToStr2(dataTablePacing(55,colinterest_Splits) - dataTablePacing(50,colinterest_Splits));
    SplitLap12 = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(55,colinterest_Splits));
    SplitLap13 = timeSecToStr2(dataTablePacing(65,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
    SplitLap14 = timeSecToStr2(dataTablePacing(70,colinterest_Splits) - dataTablePacing(65,colinterest_Splits));
    SplitLap15 = timeSecToStr2(dataTablePacing(75,colinterest_Splits) - dataTablePacing(70,colinterest_Splits));
    SplitLap16 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(75,colinterest_Splits));
    SplitLap17 = timeSecToStr2(dataTablePacing(85,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
    SplitLap18 = timeSecToStr2(dataTablePacing(90,colinterest_Splits) - dataTablePacing(85,colinterest_Splits));
    SplitLap19 = timeSecToStr2(dataTablePacing(95,colinterest_Splits) - dataTablePacing(90,colinterest_Splits));
    SplitLap20 = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(95,colinterest_Splits));
    SplitLap21 = timeSecToStr2(dataTablePacing(105,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
    SplitLap22 = timeSecToStr2(dataTablePacing(110,colinterest_Splits) - dataTablePacing(105,colinterest_Splits));
    SplitLap23 = timeSecToStr2(dataTablePacing(115,colinterest_Splits) - dataTablePacing(110,colinterest_Splits));
    SplitLap24 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(115,colinterest_Splits));
    SplitLap25 = timeSecToStr2(dataTablePacing(125,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
    SplitLap26 = timeSecToStr2(dataTablePacing(130,colinterest_Splits) - dataTablePacing(125,colinterest_Splits));
    SplitLap27 = timeSecToStr2(dataTablePacing(135,colinterest_Splits) - dataTablePacing(130,colinterest_Splits));
    SplitLap28 = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(135,colinterest_Splits));
    SplitLap29 = timeSecToStr2(dataTablePacing(145,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));
    SplitLap30 = timeSecToStr2(dataTablePacing(150,colinterest_Splits) - dataTablePacing(145,colinterest_Splits));
    SplitLap31 = timeSecToStr2(dataTablePacing(155,colinterest_Splits) - dataTablePacing(150,colinterest_Splits));
    SplitLap32 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(155,colinterest_Splits));


    SplitA100m = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
    SplitA200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
    SplitA300m = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
    SplitA400m = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
    SplitA500m = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
    SplitA600m = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
    SplitA700m = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
    SplitA800m = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));
    SplitB200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits));
    SplitB400m = timeSecToStr2(dataTablePacing(80,colinterest_Splits)-dataTablePacing(40,colinterest_Splits));
    SplitB600m = timeSecToStr2(dataTablePacing(120,colinterest_Splits)-dataTablePacing(80,colinterest_Splits));
    SplitB800m = timeSecToStr2(dataTablePacing(160,colinterest_Splits)-dataTablePacing(120,colinterest_Splits));
    SplitC400m = timeSecToStr2(dataTablePacing(80,colinterest_Splits));
    SplitC800m = timeSecToStr2(dataTablePacing(160,colinterest_Splits)-dataTablePacing(80,colinterest_Splits));
    SplitC500m = timeSecToStr2(dataTablePacing(100,colinterest_Splits));

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
    Split225m = timeSecToStr2(dataTableAverage{45,13});
    Split250m = timeSecToStr2(dataTableAverage{50,13});
    Split275m = timeSecToStr2(dataTableAverage{55,13});
    Split300m = timeSecToStr2(dataTableAverage{60,13});
    Split325m = timeSecToStr2(dataTableAverage{65,13});
    Split350m = timeSecToStr2(dataTableAverage{70,13});
    Split375m = timeSecToStr2(dataTableAverage{75,13});
    Split400m = timeSecToStr2(dataTableAverage{80,13});
    Split425m = timeSecToStr2(dataTableAverage{85,13});
    Split450m = timeSecToStr2(dataTableAverage{90,13});
    Split475m = timeSecToStr2(dataTableAverage{95,13});
    Split500m = timeSecToStr2(dataTableAverage{100,13});
    Split525m = timeSecToStr2(dataTableAverage{105,13});
    Split550m = timeSecToStr2(dataTableAverage{110,13});
    Split575m = timeSecToStr2(dataTableAverage{115,13});
    Split600m = timeSecToStr2(dataTableAverage{120,13});
    Split625m = timeSecToStr2(dataTableAverage{125,13});
    Split650m = timeSecToStr2(dataTableAverage{130,13});
    Split675m = timeSecToStr2(dataTableAverage{135,13});
    Split700m = timeSecToStr2(dataTableAverage{140,13});
    Split725m = timeSecToStr2(dataTableAverage{145,13});
    Split750m = timeSecToStr2(dataTableAverage{150,13});
    Split775m = timeSecToStr2(dataTableAverage{155,13});
    Split800m = timeSecToStr2(dataTableAverage{160,13});

    RaceTime = Split800m;
    SplitLap1 = timeSecToStr2(dataTableAverage{5,13});
    SplitLap2 = timeSecToStr2(dataTableAverage{10,13}-dataTableAverage{5,13});
    SplitLap3 = timeSecToStr2(dataTableAverage{15,13}-dataTableAverage{10,13});
    SplitLap4 = timeSecToStr2(dataTableAverage{20,13}-dataTableAverage{15,13});
    SplitLap5 = timeSecToStr2(dataTableAverage{25,13}-dataTableAverage{20,13});
    SplitLap6 = timeSecToStr2(dataTableAverage{30,13}-dataTableAverage{25,13});
    SplitLap7 = timeSecToStr2(dataTableAverage{35,13}-dataTableAverage{30,13});
    SplitLap8 = timeSecToStr2(dataTableAverage{40,13}-dataTableAverage{35,13});
    SplitLap9 = timeSecToStr2(dataTableAverage{45,13}-dataTableAverage{40,13});
    SplitLap10 = timeSecToStr2(dataTableAverage{50,13}-dataTableAverage{45,13});
    SplitLap11 = timeSecToStr2(dataTableAverage{55,13}-dataTableAverage{50,13});
    SplitLap12 = timeSecToStr2(dataTableAverage{60,13}-dataTableAverage{55,13});
    SplitLap13 = timeSecToStr2(dataTableAverage{65,13}-dataTableAverage{60,13});
    SplitLap14 = timeSecToStr2(dataTableAverage{70,13}-dataTableAverage{65,13});
    SplitLap15 = timeSecToStr2(dataTableAverage{75,13}-dataTableAverage{70,13});
    SplitLap16 = timeSecToStr2(dataTableAverage{80,13}-dataTableAverage{75,13});
    SplitLap17 = timeSecToStr2(dataTableAverage{85,13}-dataTableAverage{80,13});
    SplitLap18 = timeSecToStr2(dataTableAverage{90,13}-dataTableAverage{85,13});
    SplitLap19 = timeSecToStr2(dataTableAverage{95,13}-dataTableAverage{90,13});
    SplitLap20 = timeSecToStr2(dataTableAverage{100,13}-dataTableAverage{95,13});
    SplitLap21 = timeSecToStr2(dataTableAverage{105,13}-dataTableAverage{100,13});
    SplitLap22 = timeSecToStr2(dataTableAverage{110,13}-dataTableAverage{105,13});
    SplitLap23 = timeSecToStr2(dataTableAverage{115,13}-dataTableAverage{110,13});
    SplitLap24 = timeSecToStr2(dataTableAverage{120,13}-dataTableAverage{115,13});
    SplitLap25 = timeSecToStr2(dataTableAverage{125,13}-dataTableAverage{120,13});
    SplitLap26 = timeSecToStr2(dataTableAverage{130,13}-dataTableAverage{125,13});
    SplitLap27 = timeSecToStr2(dataTableAverage{135,13}-dataTableAverage{130,13});
    SplitLap28 = timeSecToStr2(dataTableAverage{140,13}-dataTableAverage{135,13});
    SplitLap29 = timeSecToStr2(dataTableAverage{145,13}-dataTableAverage{140,13});
    SplitLap30 = timeSecToStr2(dataTableAverage{150,13}-dataTableAverage{145,13});
    SplitLap31 = timeSecToStr2(dataTableAverage{155,13}-dataTableAverage{150,13});
    SplitLap32 = timeSecToStr2(dataTableAverage{160,13}-dataTableAverage{155,13});



    SplitA100m = timeSecToStr2(dataTableAverage{20,13});
    SplitA200m = timeSecToStr2(dataTableAverage{40,13}-dataTableAverage{20,13});
    SplitA300m = timeSecToStr2(dataTableAverage{60,13}-dataTableAverage{40,13});
    SplitA400m = timeSecToStr2(dataTableAverage{80,13}-dataTableAverage{60,13});
    SplitA500m = timeSecToStr2(dataTableAverage{100,13}-dataTableAverage{80,13});
    SplitA600m = timeSecToStr2(dataTableAverage{120,13}-dataTableAverage{100,13});
    SplitA700m = timeSecToStr2(dataTableAverage{140,13}-dataTableAverage{120,13});
    SplitA800m = timeSecToStr2(dataTableAverage{160,13}-dataTableAverage{140,13});
    SplitB200m = timeSecToStr2(dataTableAverage{40,13});
    SplitB400m = timeSecToStr2(dataTableAverage{80,13}-dataTableAverage{40,13});
    SplitB600m = timeSecToStr2(dataTableAverage{120,13}-dataTableAverage{80,13});
    SplitB800m = timeSecToStr2(dataTableAverage{160,13}-dataTableAverage{120,13});
    SplitC400m = timeSecToStr2(dataTableAverage{80,13});
    SplitC800m = timeSecToStr2(dataTableAverage{160,13}-dataTableAverage{80,13});
    SplitC500m = timeSecToStr2(dataTableAverage{100,13});

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

KeyDist = [25 50 75 100 125 150 175 200 225 250 275 300 325 350 375 400 ...
    425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800];
LapDist = [25 50 75 100 125 150 175 200 225 250 275 300 325 350 375 400 ...
    425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800];

NbLap = RaceDist./Course;
isInterpolatedTurn = [];
zoneSC = 5;
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    locTurnData = [32 40 48 56 64 72 80 88 96 104 112 120 128 136 144 ...
        152 160 168 176 184 192 200 208 216 224 232 240 248 256 264];
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
Turn8BODist = roundn(BOAllINI(9,2),-1);
Turn8BOTime = roundn(BOAllINI(9,1),-2);
Turn9BODist = roundn(BOAllINI(10,2),-1);
Turn9BOTime = roundn(BOAllINI(10,1),-2);
Turn10BODist = roundn(BOAllINI(11,2),-1);
Turn10BOTime = roundn(BOAllINI(11,1),-2);
Turn11BODist = roundn(BOAllINI(12,2),-1);
Turn11BOTime = roundn(BOAllINI(12,1),-2);
Turn12BODist = roundn(BOAllINI(13,2),-1);
Turn12BOTime = roundn(BOAllINI(13,1),-2);
Turn13BODist = roundn(BOAllINI(14,2),-1);
Turn13BOTime = roundn(BOAllINI(14,1),-2);
Turn14BODist = roundn(BOAllINI(15,2),-1);
Turn14BOTime = roundn(BOAllINI(15,1),-2);
Turn15BODist = roundn(BOAllINI(16,2),-1);
Turn15BOTime = roundn(BOAllINI(16,1),-2);
Turn16BODist = roundn(BOAllINI(17,2),-1);
Turn16BOTime = roundn(BOAllINI(17,1),-2);
Turn17BODist = roundn(BOAllINI(18,2),-1);
Turn17BOTime = roundn(BOAllINI(18,1),-2);
Turn18BODist = roundn(BOAllINI(19,2),-1);
Turn18BOTime = roundn(BOAllINI(19,1),-2);
Turn19BODist = roundn(BOAllINI(20,2),-1);
Turn19BOTime = roundn(BOAllINI(20,1),-2);
Turn20BODist = roundn(BOAllINI(21,2),-1);
Turn20BOTime = roundn(BOAllINI(21,1),-2);
Turn21BODist = roundn(BOAllINI(22,2),-1);
Turn21BOTime = roundn(BOAllINI(22,1),-2);
Turn22BODist = roundn(BOAllINI(23,2),-1);
Turn22BOTime = roundn(BOAllINI(23,1),-2);
Turn23BODist = roundn(BOAllINI(24,2),-1);
Turn23BOTime = roundn(BOAllINI(24,1),-2);
Turn24BODist = roundn(BOAllINI(25,2),-1);
Turn24BOTime = roundn(BOAllINI(25,1),-2);
Turn25BODist = roundn(BOAllINI(26,2),-1);
Turn25BOTime = roundn(BOAllINI(26,1),-2);
Turn26BODist = roundn(BOAllINI(27,2),-1);
Turn26BOTime = roundn(BOAllINI(27,1),-2);
Turn27BODist = roundn(BOAllINI(28,2),-1);
Turn27BOTime = roundn(BOAllINI(28,1),-2);
Turn28BODist = roundn(BOAllINI(29,2),-1);
Turn28BOTime = roundn(BOAllINI(29,1),-2);
Turn29BODist = roundn(BOAllINI(30,2),-1);
Turn29BOTime = roundn(BOAllINI(30,1),-2);
Turn30BODist = roundn(BOAllINI(31,2),-1);
Turn30BOTime = roundn(BOAllINI(31,1),-2);
Turn31BODist = roundn(BOAllINI(32,2),-1);
Turn31BOTime = roundn(BOAllINI(32,1),-2);


KickCountLap1 = BOAllINI(1,3);
KickCountLap2 = BOAllINI(2,3);
KickCountLap3 = BOAllINI(3,3);
KickCountLap4 = BOAllINI(4,3);
KickCountLap5 = BOAllINI(5,3);
KickCountLap6 = BOAllINI(6,3);
KickCountLap7 = BOAllINI(7,3);
KickCountLap8 = BOAllINI(8,3);
KickCountLap9 = BOAllINI(9,3);
KickCountLap10 = BOAllINI(10,3);
KickCountLap11 = BOAllINI(11,3);
KickCountLap12 = BOAllINI(12,3);
KickCountLap13 = BOAllINI(13,3);
KickCountLap14 = BOAllINI(14,3);
KickCountLap15 = BOAllINI(15,3);
KickCountLap16 = BOAllINI(16,3);
KickCountLap17 = BOAllINI(17,3);
KickCountLap18 = BOAllINI(18,3);
KickCountLap19 = BOAllINI(19,3);
KickCountLap20 = BOAllINI(20,3);
KickCountLap21 = BOAllINI(21,3);
KickCountLap22 = BOAllINI(22,3);
KickCountLap23 = BOAllINI(23,3);
KickCountLap24 = BOAllINI(24,3);
KickCountLap25 = BOAllINI(25,3);
KickCountLap26 = BOAllINI(26,3);
KickCountLap27 = BOAllINI(27,3);
KickCountLap28 = BOAllINI(28,3);
KickCountLap29 = BOAllINI(29,3);
KickCountLap30 = BOAllINI(30,3);
KickCountLap31 = BOAllINI(31,3);
KickCountLap32 = BOAllINI(32,3);

RT = timeSecToStr2(RT);
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
    valSkillTime = dataTableSkill{10,3};
    indexCheck = strfind(valSkillTime, ':');
    if isempty(indexCheck) == 1;
        %Time is in sec
        index1 = strfind(valSkillTime, ' ');
        index2 = strfind(valSkillTime, 's');
        index3 = strfind(valSkillTime, '!');
        if isempty(index3) == 0;
            interpolationSkillTime = 1;
        else;
            interpolationSkillTime = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            valSkillTime(index) = [];
        end;
        valSkillTime = str2num(valSkillTime);
    else;
        %Time is in minutes
        index1 = strfind(valSkillTime, ':');
        index2 = strfind(valSkillTime, '.');
        index3 = strfind(valSkillTime, ' ');
        index4 = strfind(valSkillTime, '!');

        if isempty(index4) == 0;
            interpolationSkillTime = 1;
        else;
            interpolationSkillTime = 0;
        end;

        index = [index3 index4];
        if isempty(index) == 0;
            valSkillTime(index) = [];
        end;

        minuVal = 60.*str2num(valSkillTime(1:index1-1));
        if isempty(index4) == 1
            secoVal = str2num(valSkillTime(index1+1:end));
        else;
            secoVal = str2num(valSkillTime(index1+1:index3-1));
        end;
        valSkillTime = minuVal + secoVal;
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

%Breath 800m, long intervals take col=3
validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
lapEC = 1;
for iter = 1:length(validIndex);
    valEC = dataTableBreath(validIndex(iter), 3);
    valEC = roundn(valEC,0);
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
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
    %800m race so take col 4 for the speed
    VelLap = [];
    interpVel = 0;
    colinterest_Speed = 4;
    colinterest_SpeedInterp = [];

    VELTOT = [];
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
    %it's a 800 so take col = 7 for short intervals
    colinterest_DPS = 7;
    colinterest_DPSInterp = 8;

    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
    %it's a 800 so take col = 10 for short intervals
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
end;

 
SRTOT = [];
if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
   
    %It's a 800m so take col = 3 for short intervals
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
            ValEC = [dataToStr(valEC,2) '  '];
        end;
        eval(['SR' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    SRAverage = [databaseCurrent{1,33} '  '];

elseif strcmpi(answerReport, 'SP2') == 1;
    
    %It's a 800m so take col = 7 for short intervals
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
            ValEC = dataToStr(valEC,2);
        end;
        eval(['SR' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    SRAverage = databaseCurrent{1,33};
end;


NbLap = (RaceDist./Course);
keyDist = Course:Course:(NbLap*Course);
if Source == 1 | Source == 3;
    %It's a 800m so take col = 10 for short intervals
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
    %It's a 800m so take col = 15 for short intervals
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

midPoint = 80;
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
txtLastname_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-40, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font1, 'String', AthletenameFull);
set(txtLastname_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtRace_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-70, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font2, 'String', Race);
set(txtRace_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtRound_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-90, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font2, 'String', Round);
set(txtRound_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtMeet_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-110, 600, 15], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', Meet);
set(txtMeet_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtVenue_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-125, 600, 15], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', Venue);
set(txtVenue_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtDate_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-145, 600, 15], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font2, 'String', RaceDate);
set(txtDate_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtUser1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [window_size(3)-640, panel_size(4)-145, 600, 15], 'HorizontalAlignment', 'right', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', ReportDate);
set(txtUser1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtUser2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [window_size(3)-640, panel_size(4)-160, 600, 15], 'HorizontalAlignment', 'right', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font3, 'String', AnalysisDate);
set(txtUser2_pdf, 'fontunits', 'normalized', 'units', 'normalized');
%--------------------------------------------------------------------------




%--------------------------------Top table---------------------------------
%Colors
txtLegend_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-195, panel_size(3)-60, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'FontAngle', 'Italic', 'Fontsize', font3, 'String', '[ ! = Interpolated data for historical race analysis systems (GreenEye and Sparta 1)]');
set(txtLegend_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-240, window_size(3)-60, 50], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtBlue1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Times';
txtTitle1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'First Breakout';
txtTitle2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [320, panel_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Pacing';
txtTitle3_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, panel_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle3_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Summary';
txtTitle4_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, panel_size(4)-228, 280, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTitle4_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Block (s):';
txtBlock_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtBlock_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = RT;
txtBlock2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, panel_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtBlock2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Start/15 m (s):';
txtST_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtST_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = StartTime;
txtST2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, panel_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtST2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = '25 m (s):';
txt25m_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txt25m_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = Time25m;
txt25m2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, panel_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txt25m2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Finish/Last 5 m (s):';
txtFinish_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-330, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtFinish_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = FinishTime;
txtFinish2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [190, panel_size(4)-330, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtFinish2_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Breakout time (s):';
txtStartBOTime1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [320, panel_size(4)-270, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtStartBOTime1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = StartBOTime;
txtStartBOTime2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [490, panel_size(4)-270, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtStartBOTime2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Breakout distance (m):';
txtStartBODist1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [320, panel_size(4)-290, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtStartBODist1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = StartBODist;
txtStartBODist2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [490, panel_size(4)-290, 170, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtStartBODist2_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Out (s):';
txtOut_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, panel_size(4)-270, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtOut_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = [TimeOutSec '   (' TimeOutPerc ')'];
txtOut2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [730, panel_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtOut2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Back (s):';
txtBack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, panel_size(4)-290, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtBack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = [TimeBackSec '   (' TimeBackPerc ')'];
txtBack2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [730, panel_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtBack2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Drop off (s):';
txtDropOff_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [600, panel_size(4)-310, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtDropOff_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = DropOff;
txtDropOff2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [730, panel_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtDropOff2_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txt = 'Total time (s):';
txtTT_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, panel_size(4)-270, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtTT_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = RaceTime;
txtTT2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1030, panel_size(4)-270, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtTT2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Total skill time (s):';
txtSkillT_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, panel_size(4)-290, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtSkillT_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = SkillTime;
txtSkillT2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1030, panel_size(4)-290, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtSkillT2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Total free swim (s):';
txtFreeT_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [880, panel_size(4)-310, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
set(txtFreeT_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = FreeSwimTime;
txtFreeT2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1030, panel_size(4)-310, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
set(txtFreeT2_pdf, 'fontunits', 'normalized', 'units', 'normalized');
%--------------------------------------------------------------------------





%--------------------------------Top table---------------------------------
txtBlue2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-400, panel_size(3)-60, 50], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtBlue2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue5_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-385, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font4, 'String', 'Segment');
set(txtBlue5_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue6a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [150, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Vel');
set(txtBlue6a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue6b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [150, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(m/s)');
set(txtBlue6b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue7a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [210, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'SR');
set(txtBlue7a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue7b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [210, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(str/min)');
set(txtBlue7b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue8a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [270, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'DPS');
set(txtBlue8a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue8b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [270, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(m)');
set(txtBlue8b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue9_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [330, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Strokes');
set(txtBlue9_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue10_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [390, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Breaths');
set(txtBlue10_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue11_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [450, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Kicks');
set(txtBlue11_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue12a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [510, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Breakout');
set(txtBlue12a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue12b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [510, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(m)');
set(txtBlue12b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue13a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [570, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'In');
set(txtBlue13a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue13b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [570, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(s)');
set(txtBlue13b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue14a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [630, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Out');
set(txtBlue14a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue14b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [630, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(s)');
set(txtBlue14b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue15a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [690, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Turn');
set(txtBlue15a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtBlue15b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [690, panel_size(4)-400, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'Fontsize', font3, 'String', '(s)');
set(txtBlue15b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue16_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [750, panel_size(4)-385, 60, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'TI');
set(txtBlue16_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue17_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [810, panel_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Split');
set(txtBlue17_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue18_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [882 panel_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', 'Lap');
set(txtBlue18_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue19_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [954, panel_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', '100 m');
set(txtBlue19_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue20_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1026, panel_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', '200 m');
set(txtBlue20_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue21_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1098, panel_size(4)-385, 72, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'bold', 'Fontsize', font4, 'String', '500 m');
set(txtBlue21_pdf, 'fontunits', 'normalized', 'units', 'normalized');


txtCol1a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-430, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1A_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-425, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0         -        25');
set(txtCol1A_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1b_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-460, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1b_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1B_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-455, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25       -        50');
set(txtCol1B_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1c_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-490, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1c_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1C_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-485, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50       -        75');
set(txtCol1C_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1d_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-520, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1d_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1D_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-515, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', ' 75        -        100');
set(txtCol1D_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1e_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-550, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1e_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1E_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-545, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '105       -        125');
set(txtCol1E_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1f_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-580, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1f_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1F_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-575, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125       -        150');
set(txtCol1F_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1g_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-610, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1G_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-605, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150       -        175');
set(txtCol1G_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1h_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-640, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1h_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1H_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-635, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175       -        200');
set(txtCol1H_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1i_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-670, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1i_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1I_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-665, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200        -        225');
set(txtCol1I_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1j_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-700, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1j_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1J_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-695, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225        -        250');
set(txtCol1J_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1k_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-730, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1k_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1K_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-725, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250        -        275');
set(txtCol1K_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1l_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-760, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1l_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1L_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-755, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275        -      300');
set(txtCol1L_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1m_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-790, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1m_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1M_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-785, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300        -        325');
set(txtCol1M_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1n_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-820, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1n_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-815, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325        -        350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1o_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-850, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-845, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350        -        375');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');



if strcmpi(source, 'display') == 1;
    figSource = handles2.panelMain;
    panel_size2 = panel_size;
    pos1 = 880;
    pos2 = 875;
    pos3 = 910;
    pos4 = 905;
    pos5 = 940;
    pos6 = 935;
    pos7 = 970;
    pos8 = 965;
    pos9 = 1000;
    pos10 = 995;
    pos11 = 1030;
    pos12 = 1025;
    pos13 = 1060;
    pos14 = 1055;
    pos15 = 1090;
    pos16 = 1085;
    pos17 = 1120;
    pos18 = 1115;
    pos19 = 1150;
    pos20 = 1145;
    pos21 = 1180;
    pos22 = 1175;
    pos23 = 1210;
    pos24 = 1205;
    pos25 = 1240;
    pos26 = 1235;
    pos27 = 1270;
    pos28 = 1265;
    pos29 = 1300;
    pos30 = 1295;
    pos31 = 1330;
    pos32 = 1325;
    pos33 = 1360;
    pos34 = 1355;
    pos35 = 1390;
    pos36 = 1385;
else;

    pos1 = 30;
    pos2 = 25;
    pos3 = 60;
    pos4 = 55;
    pos5 = 90;
    pos6 = 85;
    pos7 = 120;
    pos8 = 115;
    pos9 = 150;
    pos10 = 145;
    pos11 = 180;
    pos12 = 175;
    pos13 = 210;
    pos14 = 205;
    pos15 = 240;
    pos16 = 235;
    pos17 = 270;
    pos18 = 265;
    pos19 = 300;
    pos20 = 295;
    pos21 = 330;
    pos22 = 325;
    pos23 = 360;
    pos24 = 355;
    pos25 = 390;
    pos26 = 385;
    pos27 = 420;
    pos28 = 415;
    pos29 = 450;
    pos30 = 445;
    pos31 = 480;
    pos32 = 475;
    pos33 = 510;
    pos34 = 505;
    pos35 = 540;
    pos36 = 535;

    window_size2 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 550]);
    hdef2 = figure('units', 'pixels', 'position', window_size2, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef2), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain2 = uipanel('parent', hdef2, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, 550], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain2, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size2 = [1, 10, 1200, 550];
    figSource = panelMain2;
end;

txtCol1p_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos1, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1p_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1P_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos2, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375        -        400');
set(txtCol1P_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos3, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos4, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         -        425');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1r_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos5, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1R_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos6, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425       -        450');
set(txtCol1R_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1s_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos7, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1s_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1S_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos8, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450       -        475');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1t_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos9, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1T_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos10, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475        -        500');
set(txtCol1T_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1u_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos11, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1u_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1U_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos12, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500       -        525');
set(txtCol1U_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1v_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos13, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1v_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1V_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos14, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525       -        550');
set(txtCol1V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1w_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos15, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1w_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos16, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550       -        575');
set(txtCol1W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1x_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos17, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1x_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1X_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos18, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575       -        600');
set(txtCol1X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1y_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos19, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1Y_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos20, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600        -        625');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1z_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos21, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1z_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1Z_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos22, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625        -        650');
set(txtCol1Z_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1aa_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos23, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1aa_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AA_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos24, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650        -        675');
set(txtCol1AA_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1ab_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos25, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1ab_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AB_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos26, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675        -      700');
set(txtCol1AB_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1ac_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos27, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1ac_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AC_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos28, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700        -        725');
set(txtCol1AC_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1ad_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos29, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1ad_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AD_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos30, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725        -        750');
set(txtCol1AD_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1ae_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos31, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1ae_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AE_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos32, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750        -        775');
set(txtCol1AE_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1af_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos33, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1af_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AF_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos34, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.88 0.92 0.92], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775        -        800');
set(txtCol1AF_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1ag_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos35, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.97 0.97 0.94], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1ag_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1AG_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos36, 120, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.97 0.97 0.94], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Race Averages');
set(txtCol1AG_pdf, 'fontunits', 'normalized', 'units', 'normalized');



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [150, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [150, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', VelAverage);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [150, panel_size2(4)-pos1, 60, 30];
            position2INI = [150, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', VelAverage);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [150, panel_size(4)-posa, 60, 30];
            position2INI = [150, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [150, panel_size(4)-posa, 60, 30];
                position2INI = [150, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [150, panel_size2(4)-pos1, 60, 30];
                position2INI = [150, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        eval(['val = Vel' num2str(KeyDist(i)) 'm;']);
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [210, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [210, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', SRAverage);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [210, panel_size2(4)-pos1, 60, 30];
            position2INI = [210, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', SRAverage);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [210, panel_size(4)-posa, 60, 30];
            position2INI = [210, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [210, panel_size(4)-posa, 60, 30];
                position2INI = [210, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [210, panel_size2(4)-pos1, 60, 30];
                position2INI = [210, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        eval(['val = SR' num2str(KeyDist(i)) 'm;']);
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;


ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [270, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [270, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', DPSAverage);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [270, panel_size2(4)-pos1, 60, 30];
            position2INI = [270, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', DPSAverage);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [270, panel_size(4)-posa, 60, 30];
            position2INI = [270, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [270, panel_size(4)-posa, 60, 30];
                position2INI = [270, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [270, panel_size2(4)-pos1, 60, 30];
                position2INI = [270, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        eval(['val = DPS' num2str(KeyDist(i)) 'm;']);
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;


ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [330, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [330, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [330, panel_size2(4)-pos1, 60, 30];
            position2INI = [330, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [330, panel_size(4)-posa, 60, 30];
            position2INI = [330, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [330, panel_size(4)-posa, 60, 30];
                position2INI = [330, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [330, panel_size2(4)-pos1, 60, 30];
                position2INI = [330, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        val = Stroke_Count(Inc);
        Inc = Inc + 1;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [390, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [390, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [390, panel_size2(4)-pos1, 60, 30];
            position2INI = [390, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [390, panel_size(4)-posa, 60, 30];
            position2INI = [390, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [390, panel_size(4)-posa, 60, 30];
                position2INI = [390, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [390, panel_size2(4)-pos1, 60, 30];
                position2INI = [390, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        eval(['val = BreathCountLap' num2str(Inc) ';']);
        Inc = Inc + 1;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [450, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [450, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [450, panel_size2(4)-pos1, 60, 30];
            position2INI = [450, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [450, panel_size(4)-posa, 60, 30];
            position2INI = [450, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [450, panel_size(4)-posa, 60, 30];
                position2INI = [450, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [450, panel_size2(4)-pos1, 60, 30];
                position2INI = [450, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        eval(['val = KickCountLap' num2str(Inc) ';']);
        Inc = Inc + 1;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;




ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [510, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [510, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [510, panel_size2(4)-pos1, 60, 30];
            position2INI = [510, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [510, panel_size(4)-posa, 60, 30];
            position2INI = [510, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [510, panel_size(4)-posa, 60, 30];
                position2INI = [510, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [510, panel_size2(4)-pos1, 60, 30];
                position2INI = [510, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        if i == 1;
            val = StartBODist;
        else;
            eval(['val = Turn' num2str(Inc) 'BODist;']);
            Inc = Inc + 1;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [569, panel_size(4)-pos35, 62, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [569, panel_size(4)-pos36, 62, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTimein_Average);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [569, panel_size2(4)-pos1, 62, 30];
            position2INI = [569, panel_size2(4)-pos2, 62, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTimein_Average);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [569, panel_size(4)-posa, 62, 30];
            position2INI = [569, panel_size(4)-posb, 62, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [569, panel_size(4)-posa, 62, 30];
                position2INI = [569, panel_size(4)-posb, 62, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [569, panel_size2(4)-pos1, 62, 30];
                position2INI = [569, panel_size2(4)-pos2, 62, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        if Inc == length(LapDist);
            val = '';
        else;
            eval(['val = TurnTime' num2str(Inc) 'in;']);
            Inc = Inc + 1;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [630, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [630, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTimeout_Average);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [630, panel_size2(4)-pos1, 60, 30];
            position2INI = [630, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTimeout_Average);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [630, panel_size(4)-posa, 60, 30];
            position2INI = [630, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [630, panel_size(4)-posa, 60, 30];
                position2INI = [630, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [630, panel_size2(4)-pos1, 60, 30];
                position2INI = [630, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        if Inc == length(LapDist);
            val = '';
        else;
            eval(['val = TurnTime' num2str(Inc) 'out;']);
            Inc = Inc + 1;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [690, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [690, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTime_Average);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [690, panel_size2(4)-pos1, 60, 30];
            position2INI = [690, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', TurnTime_Average);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [690, panel_size(4)-posa, 60, 30];
            position2INI = [690, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [690, panel_size(4)-posa, 60, 30];
                position2INI = [690, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [690, panel_size2(4)-pos1, 60, 30];
                position2INI = [690, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        if Inc == length(LapDist);
            val = '';
        else;
            eval(['val = TurnTime' num2str(Inc) ';']);
            Inc = Inc + 1;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [750, panel_size(4)-pos35, 60, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [750, panel_size(4)-pos36, 60, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [750, panel_size2(4)-pos1, 60, 30];
            position2INI = [750, panel_size2(4)-pos2, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [750, panel_size(4)-posa, 60, 30];
            position2INI = [750, panel_size(4)-posb, 60, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [750, panel_size(4)-posa, 60, 30];
                position2INI = [750, panel_size(4)-posb, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [750, panel_size2(4)-pos1, 60, 30];
                position2INI = [750, panel_size2(4)-pos2, 60, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        if isodd == 1;
            val = '';

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            val = '';
        
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [810, panel_size(4)-pos35, 72, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [810, panel_size(4)-pos36, 72, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [810, panel_size2(4)-pos1, 72, 30];
            position2INI = [810, panel_size2(4)-pos2, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [810, panel_size(4)-posa, 72, 30];
            position2INI = [810, panel_size(4)-posb, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [810, panel_size(4)-posa, 72, 30];
                position2INI = [810, panel_size(4)-posb, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [810, panel_size2(4)-pos1, 72, 30];
                position2INI = [810, panel_size2(4)-pos2, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        eval(['val = Split' num2str(KeyDist(i)) 'm;']);
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [882, panel_size(4)-pos35, 72, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [882, panel_size(4)-pos36, 72, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [882, panel_size2(4)-pos1, 72, 30];
            position2INI = [882, panel_size2(4)-pos2, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [882, panel_size(4)-posa, 72, 30];
            position2INI = [882, panel_size(4)-posb, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [882, panel_size(4)-posa, 72, 30];
                position2INI = [882, panel_size(4)-posb, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [882, panel_size2(4)-pos1, 72, 30];
                position2INI = [882, panel_size2(4)-pos2, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        eval(['val = SplitLap' num2str(Inc) ';']);
        Inc = Inc + 1;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = [4 8 12 16 20 24 28 32];
splitEC = 1;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [954, panel_size(4)-pos35, 72, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [954, panel_size(4)-pos36, 72, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [954, panel_size2(4)-pos1, 72, 30];
            position2INI = [954, panel_size2(4)-pos2, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [954, panel_size(4)-posa, 72, 30];
            position2INI = [954, panel_size(4)-posb, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [954, panel_size(4)-posa, 72, 30];
                position2INI = [954, panel_size(4)-posb, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [954, panel_size2(4)-pos1, 72, 30];
                position2INI = [954, panel_size2(4)-pos2, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        liInc = find(Inc == i);
        if isempty(liInc) == 1;
            val = '';
        else;
            eval(['val = SplitA' num2str(splitEC) '00m;']);
            splitEC = splitEC + 1;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;




ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = [8 16 24 32];
splitEC = 2;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [1026, panel_size(4)-pos35, 72, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [1026, panel_size(4)-pos36, 72, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [1026, panel_size2(4)-pos1, 72, 30];
            position2INI = [1026, panel_size2(4)-pos2, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [1026, panel_size(4)-posa, 72, 30];
            position2INI = [1026, panel_size(4)-posb, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [1026, panel_size(4)-posa, 72, 30];
                position2INI = [1026, panel_size(4)-posb, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [1026, panel_size2(4)-pos1, 72, 30];
                position2INI = [1026, panel_size2(4)-pos2, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        liInc = find(Inc == i);
        if isempty(liInc) == 1;
            val = '';
        else;
            eval(['val = SplitB' num2str(splitEC) '00m;']);
            splitEC = splitEC + 2;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;



ColorOdd = [0.97 0.99 0.96];
ColorEven = [0.86 0.9 0.9];
ColorEnd = [0.95 0.95 0.83];
iter = 0;
limDist = 375;
irem = 0;
Inc = [20];
splitEC = 5;
for i = 1:length(KeyDist)+1;
    isodd = rem(i, 2);
    if i == length(KeyDist)+1;
        if strcmpi(source, 'display') == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [1098, panel_size(4)-pos35, 72, 30], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [1098, panel_size(4)-pos36, 72, 20], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            figSource = panelMain2;
            position1INI = [1098, panel_size2(4)-pos1, 72, 30];
            position2INI = [1098, panel_size2(4)-pos2, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 

            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEnd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;
    else;
        if strcmpi(source, 'display') == 1;
            posa = 430;
            posb = 425;
            position1INI = [1098, panel_size(4)-posa, 72, 30];
            position2INI = [1098, panel_size(4)-posb, 72, 20];
            position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
            position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
        else;
            if KeyDist(i) <= limDist;
                figSource = handles2.panelMain;
                posa = 430;
                posb = 425;
                position1INI = [1098, panel_size(4)-posa, 72, 30];
                position2INI = [1098, panel_size(4)-posb, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)];
            else;
                figSource = panelMain2;
                position1INI = [1098, panel_size2(4)-pos1, 72, 30];
                position2INI = [1098, panel_size2(4)-pos2, 72, 20];
                position1 = [position1INI(1) position1INI(2)-iter position1INI(3) position1INI(4)];
                position2 = [position2INI(1) position2INI(2)-iter position2INI(3) position2INI(4)]; 
            end;
        end;
        
        liInc = find(Inc == i);
        if isempty(liInc) == 1;
            val = '';
        else;
            eval(['val = SplitC' num2str(splitEC) '00m;']);
            splitEC = splitEC + 5;
        end;
        if isodd == 1;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorOdd, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            txtCol2a_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position1, 'HorizontalAlignment', 'left', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
            set(txtCol2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
            txtCol2A_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', position2, 'HorizontalAlignment', 'center', ...
                'BackgroundColor', ColorEven, 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', val);
            set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        end;

        iter = (i-irem)*30;
        if strcmpi(source, 'display') == 1;

        else;
            if KeyDist(i) == limDist;
                irem = i;
                iter = 0;
            end;
        end;
    end;
end;


if strcmpi(source, 'display') == 1;
    txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size(4)-1390, 1140, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    figSource = panelMain2;
    txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size2(4)-pos35, 1140, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
end;
%--------------------------------------------------------------------------

handles2.filename = filename;
handles2.hdef = hdef;
handles2.RaceDist = LapDist(end);
guidata(handles2.hdef, handles2);
