function handles2 = create_selectListBest_benchmark(FullDB, icones, BenchmarkEvents, AgeGroup, dataInput, source);


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

window_size = floor([(resolution(1)-800)./2 (resolution(2)-550)./2 800 550]);
window_size(1) = window_size(1) + offsetLeft;
window_size(2) = window_size(2) + offsetBottom;

hdef = figure('units', 'pixels', 'position', window_size, ...
    'Color', [0.1 0.1 0.1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Top 20 Performances', ...
    'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(hdef), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;

if ispc == 1;
    font1 = 12;
    font2 = 10;
elseif ismac == 1;
    font1 = 14;
    font2 = 11;
end;

%---Inputs
if isempty(dataInput{1}) == 0;
    handles2.Distance = dataInput{1};
else;
    handles2.Distance = [];
end;
if isempty(dataInput{2}) == 0;
    handles2.Stroke = dataInput{2};
else;
    handles2.Stroke = [];
end;
if isempty(dataInput{3}) == 0;
    handles2.Gender = dataInput{3};
else;
    handles2.Gender = [];
end;
if isempty(dataInput{4}) == 0;
    handles2.Course = dataInput{4};
else;
    handles2.Course = [];
end;
if isempty(dataInput{5}) == 0;
    handles2.currentRaceCount = dataInput{5};
else;
    handles2.currentRaceCount = [];
end;

handles2.Season = [];
handles2.TypeRelay = [];
handles2.Country = [];
handles2.PB = [];
handles2.FullDB = FullDB;
handles2.selectPerf = [];
% handles2.selectYear = [];
handles2.BenchmarkEvents = BenchmarkEvents;
handles2.AgeGroup = AgeGroup;
handles2.source = source;

%---Outputs
handles2.databaseCurrent = [];
handles2.selectedRaces = [];


%---create selection panel button
handles2.selectSearchPanel_select = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 490, 790, 55], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2+1, 'Title', 'Refine your search', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.selectSearchPanel_select, 'fontunits', 'normalized', 'units', 'normalized');

if isempty(handles2.Gender) == 0;
    if strcmpi(handles2.Gender, 'Male');
        valGender = 2;
    elseif strcmpi(handles2.Gender, 'Female');
        valGender = 3;
    else;
        valGender = 1;
    end;
else;
    valGender = 1;
end;
handles2.listGender = {'--Gender--'; 'Male'; 'Female'};
if ispc == 1;
    handles2.selectSearchGender_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 10, 80, 20], 'string', handles2.listGender, 'callback', [], 'Value', valGender, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchGender_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Stroke');
    
elseif ismac == 1;
    handles2.selectSearchGender_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [2, 10, 105, 20], 'string', handles2.listGender, 'callback', [], 'Value', valGender, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchGender_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Stroke');
end;


if isempty(handles2.Stroke) == 0;
    if strcmpi(handles2.Stroke, 'Butterfly');
        valStroke = 2;
    elseif strcmpi(handles2.Stroke, 'Backstroke');
        valStroke = 3;
    elseif strcmpi(handles2.Stroke, 'Breaststroke');
        valStroke = 4;
    elseif strcmpi(handles2.Stroke, 'Freestyle');
        valStroke = 5;
    elseif strcmpi(handles2.Stroke, 'Medley');
        valStroke = 6;
    else;
        valStroke = 1;
    end;
else;
    valStroke = 1;
end;
handles2.listStroke = {'--Stroke--'; 'Butterfly'; 'Backstroke'; 'Breaststroke'; 'Freestyle'; 'Medley'};
if ispc == 1;
    handles2.selectSearchStroke_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [95, 10, 90, 20], 'string', handles2.listStroke, 'callback', [], 'Value', valStroke, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchStroke_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Stroke');
    
elseif ismac == 1;
    handles2.selectSearchStroke_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [97, 10, 103, 20], 'string', handles2.listStroke, 'callback', [], 'Value', valStroke,  ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchStroke_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Stroke');
end;


if isempty(handles2.Distance) == 0;
    if strcmpi(handles2.Distance, '50');
        valDist = 2;
    elseif strcmpi(handles2.Distance, '100');
        valDist = 3;
    elseif strcmpi(handles2.Distance, '150');
        valDist = 4;
    elseif strcmpi(handles2.Distance, '200');
        valDist = 5;
    elseif strcmpi(handles2.Distance, '400');
        valDist = 6;
    elseif strcmpi(handles2.Distance, '800');
        valDist = 7;
    elseif strcmpi(handles2.Distance, '1500');
        valDist = 8;
    else;
        valDist = 1;
    end;
else;
    valDist = 1;
end;
handles2.listDistance = {'--Distance--';'50m'; "100m"; "150m"; "200m"; "400m"; "800m"; "1500m"};
if ispc == 1;
    handles2.selectSearchDistance_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [190, 10, 90, 20], 'string', handles2.listDistance, 'callback', [], 'Value', valDist, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchDistance_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Distance');
    
elseif ismac == 1;
    handles2.selectSearchDistance_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [189, 10, 115, 20], 'string', handles2.listDistance, 'callback', [], 'Value', valDist, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchDistance_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Distance');
end;

if isempty(handles2.Course) == 0;
    if strcmpi(handles2.Course, '50');
        valCourse = 2;
    elseif strcmpi(handles2.Course, '25');
        valCourse = 3;
    else;
        valCourse = 1;
    end;
else;
    valCourse = 1;
end;
handles2.listCourse = {'--Course--';'LCM'; "SCM"};
if ispc == 1;
    handles2.selectSearchCourse_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [285, 10, 80, 20], 'string', handles2.listCourse, 'callback', [], 'Value', valCourse, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchCourse_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Course');
    
elseif ismac == 1;
    handles2.selectSearchCourse_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [293, 10, 105, 20], 'string', handles2.listCourse, 'callback', [], 'Value', valCourse, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchCourse_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Course');
end;


if isempty(handles2.Distance) == 0;
    valYear = 2; %load all time as default if races have been already loaded
else;
    valYear = 1;
end;
handles2.listSeason = {'--Year--';'All Time'; "LA Cycle"; "Paris Cycle"; "Tokyo Cycle"};
liEC = length(handles2.listSeason(:,1));
iterYear = 1;
currentYear = year(datetime("today"));
for yearEC = -(currentYear-1):-2019;
    handles2.listSeason{iterYear+liEC,1} = ['s. ' num2str(abs(yearEC)) '-' num2str(abs(yearEC)+1)];
    iterYear = iterYear + 1;
end;
if ispc == 1;
    handles2.selectSearchSeason_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [370, 10, 90, 20], 'string', handles2.listSeason, 'callback', [], 'Value', valYear, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchSeason_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Season/Cycle');
    
elseif ismac == 1;
    handles2.selectSearchSeason_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [388, 10, 95, 20], 'string', handles2.listSeason, 'callback', [], 'Value', valYear, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchSeason_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Season/Cycle');
end;

if isempty(handles2.Distance) == 0;
    valType = 2; %load all indiv races as default if races have been already loaded
else;
    valType = 1;
end;
handles2.listType{1,1} = '--Type--';
handles2.listType{2,1} = 'All ind. races';
handles2.listType{3,1} = 'All flat races';
handles2.listType{4,1} = 'All Leg 1 races';
handles2.listType{5,1} = 'All C.O. races';
if ispc == 1;
    handles2.selectSearchRelay_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [465, 10, 100, 20], 'string', handles2.listType, 'callback', [], 'Value', valType, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchRelay_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Type');
    
elseif ismac == 1;
    handles2.selectSearchRelay_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [472, 10, 95, 20], 'string', handles2.listType, 'callback', [], 'Value', valType, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchRelay_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Type');
end;


if isempty(handles2.Distance) == 0;
    valPB = 2; %load PB races as default if races have been already loaded
else;
    valPB = 1;
end;
handles2.listPB{1,1} = '--Times--';
handles2.listPB{2,1} = 'PB only';
handles2.listPB{3,1} = 'All perf.';
if ispc == 1;
    handles2.selectSearchPB_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [570, 10, 73, 20], 'string', handles2.listPB, 'callback', [], 'Value', valPB, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchPB_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Performances');
    
elseif ismac == 1;
    handles2.selectSearchPB_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [556, 10, 95, 20], 'string', handles2.listPB, 'callback', [], 'Value', valPB, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchPB_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Performances');
end;


if isempty(handles2.Distance) == 0;
    valNAT = 2; %load any country races as default if races have been already loaded
else;
    valNAT = 1;
end;
handles2.listCountry{1,1} = '--Country--';
handles2.listCountry{2,1} = 'Any';
handles2.listCountry{3,1} = 'Australia';
if ispc == 1;
    handles2.selectSearchCountry_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [648, 10, 85, 20], 'string', handles2.listCountry, 'callback', [], 'Value', valNAT, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchCountry_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Performances');
    
elseif ismac == 1;
    handles2.selectSearchCountry_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [641, 10, 105, 20], 'string', handles2.listCountry, 'callback', [], 'Value', valNAT, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.selectSearchCountry_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Country');
end;



%---Validate button
handles2.confirm_button_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [740, 10, 20, 20], 'callback', @confirmSearchList_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'cdata', imresize(icones.validate_offb, [20 20]));
set(handles2.confirm_button_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Validate');

%---Cancel button
handles2.delete_button_select = uicontrol('parent', handles2.selectSearchPanel_select, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [762, 10, 20, 20], 'callback', @deleteSearchList_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'cdata', imresize(icones.redcross_offb, [20 20]));
set(handles2.delete_button_select, 'fontunits', 'normalized', 'units', 'normalized', 'tooltip', 'Validate');





%---create race panel button
handles2.selectRacePanel_select = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 35, 790, 450], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2+1, 'Title', 'Select your races', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.selectRacePanel_select, 'fontunits', 'normalized', 'units', 'normalized');

%---Check races 1
valVertical_ini = 425;
for raceEC = 1:20;
    selectECRace_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
        'position', [5, valVertical_ini-(raceEC*20), 200, 20], 'value', 0, 'callback', [], 'enable', 'on', ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(selectECRace_select, 'fontunits', 'normalized', 'units', 'normalized');
    
    txtRaceECMeet_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'text', 'Visible', 'off', 'units', 'pixels', ...
        'position', [210, valVertical_ini-(raceEC*20), 250, 20], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(txtRaceECMeet_select, 'fontunits', 'normalized', 'units', 'normalized');
    
    txtRaceECYear_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'text', 'Visible', 'off', 'units', 'pixels', ...
        'position', [465, valVertical_ini-(raceEC*20), 40, 20], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1],  'HorizontalAlignment', 'left', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(txtRaceECYear_select, 'fontunits', 'normalized', 'units', 'normalized');
    
    txtRaceECStage_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'text', 'Visible', 'off', 'units', 'pixels', ...
        'position', [510, valVertical_ini-(raceEC*20), 60, 20], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1],  'HorizontalAlignment', 'left', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(txtRaceECStage_select, 'fontunits', 'normalized', 'units', 'normalized');
    
    txtRaceECRelay_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'text', 'Visible', 'off', 'units', 'pixels', ...
        'position', [570, valVertical_ini-(raceEC*20), 60, 20], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1],  'HorizontalAlignment', 'left', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(txtRaceECRelay_select, 'fontunits', 'normalized', 'units', 'normalized');
    
    txtRaceECTime_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'text', 'Visible', 'off', 'units', 'pixels', ...
        'position', [650, valVertical_ini-(raceEC*20), 80, 20], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1],  'HorizontalAlignment', 'left', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(txtRaceECTime_select, 'fontunits', 'normalized', 'units', 'normalized');
    
    txtRaceECSystem_select = uicontrol('parent', handles2.selectRacePanel_select, 'Style', 'text', 'Visible', 'off', 'units', 'pixels', ...
        'position', [720, valVertical_ini-(raceEC*20), 50, 20], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1],  'HorizontalAlignment', 'left', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', []);
    set(txtRaceECSystem_select, 'fontunits', 'normalized', 'units', 'normalized');

    eval(['handles2.select' num2str(raceEC) 'Race_select = selectECRace_select;']);
    eval(['handles2.txtRace' num2str(raceEC) 'Meet_select = txtRaceECMeet_select;']);
    eval(['handles2.txtRace' num2str(raceEC) 'Year_select = txtRaceECYear_select;']);
    eval(['handles2.txtRace' num2str(raceEC) 'Stage_select = txtRaceECStage_select;']);
    eval(['handles2.txtRace' num2str(raceEC) 'Relay_select = txtRaceECRelay_select;']);
    eval(['handles2.txtRace' num2str(raceEC) 'Time_select = txtRaceECTime_select;']);
    eval(['handles2.txtRace' num2str(raceEC) 'System_select = txtRaceECSystem_select;']);
end;



%---Cancel button
handles2.cancel_button_select = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [290, 5, 100, 25], 'callback', @cancelSearchList_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2+1, 'String', 'Cancel');
set(handles2.cancel_button_select, 'fontunits', 'normalized', 'units', 'normalized');

%---Validate button
handles2.validate_button_select = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [410, 5, 100, 25], 'callback', @validateSearchList_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2+1, 'String', 'Validate');
set(handles2.validate_button_select, 'fontunits', 'normalized', 'units', 'normalized');


%---Pre display search
valGender = get(handles2.selectSearchGender_select, 'Value');
listGender = get(handles2.selectSearchGender_select, 'String');
if valGender == 1;
    SearchGender = [];
else;
    SearchGender = listGender{valGender};
end;

valStroke = get(handles2.selectSearchStroke_select, 'Value');
listStroke = get(handles2.selectSearchStroke_select, 'String');
if valStroke == 1;
    SearchStroke = [];
else;
    SearchStroke = listStroke{valStroke};
end;

valDist = get(handles2.selectSearchDistance_select, 'Value');
listDist = get(handles2.selectSearchDistance_select, 'String');
if valDist == 1;
    SearchDistance = [];
else;
    SearchDistance = listDist{valDist};
    SearchDistance = SearchDistance(1:end-1);
end;

valCourse = get(handles2.selectSearchCourse_select, 'Value');
listCourse = get(handles2.selectSearchCourse_select, 'String');
if valCourse == 1;
    SearchPool = [];
else;
    if strcmpi(listCourse{valCourse}, 'SCM');
        SearchPool = '25';
    else;
        SearchPool = '50';
    end;    
end;

valYear = get(handles2.selectSearchSeason_select, 'Value');
listYear = get(handles2.selectSearchSeason_select, 'String');
if valYear == 1;
    SearchSeason = [];
else;
    SearchSeason = listYear{valYear};
end;

valPB = get(handles2.selectSearchPB_select, 'Value');
listPB = get(handles2.selectSearchPB_select, 'String');
if valPB == 1;
    SearchPB = [];
else;
    SearchPB = listPB{valPB};
end;

valCountry = get(handles2.selectSearchCountry_select, 'Value');
listCountry = get(handles2.selectSearchCountry_select, 'String');
if valCountry == 1;
    SearchCountry = [];
else;
    SearchCountry = listCountry{valCountry};
end;


valType = get(handles2.selectSearchRelay_select, 'Value');
listType = get(handles2.selectSearchRelay_select, 'String');
if valType == 1;
    SearchType = [];
else;
   SearchType = listType{valType};
end;

drawnow;

fh = findobj(0,'type','figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);

if isempty(SearchGender) == 1 | ...
        isempty(SearchStroke) == 1 | ...
        isempty(SearchDistance) == 1 | ...
        isempty(SearchPool) == 1 | ...
        isempty(SearchSeason) == 1 | ...
        isempty(SearchType) == 1 | ...
        isempty(SearchPB) == 1 | ...
        isempty(SearchCountry) == 1;

else;
    
    confirmSearchList_select;
end;

uiwait(gcf);
fh = findobj(0,'type','figure');

if length(fh) > 1;
    set(0, 'CurrentFigure', fh(1).Number);

    handles2 = guidata(gcf);
    try;
        guidata(gcf, handles2);
        close(gcf);
    catch;
        handles2.databaseCurrent = [];
        handles2.selectedRaces = [];
        guidata(gcf, handles2);
    end;
end;



