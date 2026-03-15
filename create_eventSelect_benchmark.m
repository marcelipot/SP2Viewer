function handles2 = create_eventSelect_benchmark;


handles = guidata(gcf);

handles2.ListStroke = {'--- Stroke ---';'Butterfly';'Backstroke';'Breaststroke';'Freestyle'; 'IM'};
handles2.ListDistance = {'--- Distance ---';'50m';'100m';'150m';'200m';'400m';'800m';'1500m'};
handles2.ListPool = {'--- Course ---';'SCM';'LCM'};
handles2.ListRelay = {'--- Type ---';'Flat';'Change-Over'};

if isempty(handles.RaceDistListCustom_benchmark) == 0;
    RaceDistEC = handles.RaceDistListCustom_benchmark{1,1};
    StrokeEC = handles.StrokeListCustom_benchmark{1,1};
    CourseEC = handles.CourseListCustom_benchmark{1,1};
    clear handles;

    if str2num(RaceDistEC) == 50;
        valDist = 2;
    elseif str2num(RaceDistEC) == 100;
        valDist = 3;
    elseif str2num(RaceDistEC) == 150;
        valDist = 4;
    elseif str2num(RaceDistEC) == 200;
        valDist = 5;
    elseif str2num(RaceDistEC) == 400;
        valDist = 6;
    elseif str2num(RaceDistEC) == 800;
        valDist = 7;
    elseif str2num(RaceDistEC) == 1500;
        valDist = 8;
    end;

    if isempty(strfind(lower(StrokeEC), 'butterfly')) == 0;
        valStroke = 2;
    end;
    if isempty(strfind(lower(StrokeEC), 'backstroke')) == 0;
        valStroke = 3;
    end;
    if isempty(strfind(lower(StrokeEC), 'breaststroke')) == 0;
        valStroke = 4;
    end;
    if isempty(strfind(lower(StrokeEC), 'freestyle')) == 0;
        valStroke = 5;
    end;
    if isempty(strfind(lower(StrokeEC), 'medley')) == 0;
        valStroke = 6;
    end;

    if str2num(CourseEC) == 25;
        valCourse = 2;
    elseif str2num(CourseEC) == 50;
        valCourse = 3;
    end;

    handles2.SelectedStroke = handles2.ListStroke{valStroke};
    handles2.SelectedDistance = handles2.ListDistance{valDist};
    handles2.SelectedPool = handles2.ListPool{valCourse};
    handles2.SelectedRelay = [];

else;
    valDist = 1;
    valStroke = 1;
    valCourse = 1;

    handles2.SelectedStroke = [];
    handles2.SelectedDistance = [];
    handles2.SelectedPool = [];
    handles2.SelectedRelay = [];
end;



% resolution = get(0,'ScreenSize');
% resolution = resolution(1,3:4);
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

window_size = floor([(resolution(1)-150)./2 (resolution(2)-80)./2 200 160]);
window_size(1) = window_size(1) + offsetLeft;
window_size(2) = window_size(2) + offsetBottom;

hdef = figure('units', 'pixels', 'position', window_size, ...
    'Color', [0.1 0.1 0.1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Event Selection', ...
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
    font2 = 12;
end;

%---create swimmer selection panel button
handles2.eventSelection_select = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 40, 185, 115], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Event Selection', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.eventSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

if ispc == 1;
    handles2.strokeSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 80, 175, 20], 'string', handles2.ListStroke, 'callback', @popstrokeSelection_select, 'Value', valStroke, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.strokeSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.distanceSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 55, 175, 20], 'string', handles2.ListDistance, 'callback', @popdistanceSelection_select, 'Value', valDist, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.distanceSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.poolSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 30, 175, 20], 'string', handles2.ListPool, 'callback', @poppoolSelection_select, 'Value', valCourse, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.poolSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.relaySelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 5, 175, 20], 'string', handles2.ListRelay, 'callback', @poprelaySelection_select, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.relaySelection_select, 'fontunits', 'normalized', 'units', 'normalized');

elseif ismac == 1;
    handles2.strokeSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 80, 175, 20], 'string', handles2.ListStroke, 'callback', @popstrokeSelection_select, 'Value', valStroke, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.strokeSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.distanceSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 55, 175, 20], 'string', handles2.ListDistance, 'callback', @popdistanceSelection_select, 'Value', valDist, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.distanceSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.poolSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 30, 175, 20], 'string', handles2.ListPool, 'callback', @poppoolSelection_select, 'Value', valCourse, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.poolSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.relaySelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 5, 175, 20], 'string', handles2.ListRelay, 'callback', @poprelaySelection_select, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.relaySelection_select, 'fontunits', 'normalized', 'units', 'normalized');
end;

%---create remove all and validate icons
%---clear button
handles2.cancel_button_select = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, 10, 60, 20], 'callback', @canceleventSelection_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'String', 'Cancel');
set(handles2.cancel_button_select, 'fontunits', 'normalized', 'units', 'normalized');

%---Validate button
handles2.validate_button_select = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [115, 10, 60, 20], 'callback', @validateeventSelection_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'String', 'Validate');
set(handles2.validate_button_select, 'fontunits', 'normalized', 'units', 'normalized');

drawnow;

fh = findobj(0,'type','figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);

uiwait(gcf);
fh = findobj(0,'type','figure');

if length(fh) > 1;
    set(0, 'CurrentFigure', fh(1).Number);

    handles2 = guidata(gcf);
    try;
        guidata(gcf, handles2);
        close(gcf);
    catch;
        handles2.SelectedStroke = [];
        handles2.SelectedDistance = [];
        handles2.SelectedPool = [];
        handles2.SelectedRelay = [];
        guidata(gcf, handles2);
    end;
end;



