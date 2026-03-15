function handles2 = create_eventSelect_analyser(settingsUI);


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

handles2.ListStroke = {'--- Stroke ---';'Butterfly';'Backstroke';'Breaststroke';'Freestyle'; 'IM'};
handles2.ListDistance = {'--- Distance ---';'50m';'100m';'150m';'200m';'400m';'800m';'1500m'};
handles2.ListPool = {'--- Course ---';'SCM';'LCM'};
handles2.ListRelay = {'--- Type ---';'Flat';'Change-Over'};
if isempty(settingsUI) == 1;
    posListStroke = 1;
    posListDistance = 1;
    posListPool = 1;
    posListRelay = 1;

    handles2.SelectedStroke = [];
    handles2.SelectedDistance = [];
    handles2.SelectedPool = [];
    handles2.SelectedRelay = [];

else;
    posListStroke = settingsUI(2);
    posListDistance = settingsUI(1);
    posListPool = settingsUI(3);
    posListRelay = settingsUI(4);

    handles2.SelectedStroke = handles2.ListStroke{posListStroke};
    handles2.SelectedDistance = handles2.ListDistance{posListDistance};
    handles2.SelectedPool = handles2.ListPool{posListPool};
    handles2.SelectedRelay = handles2.ListRelay{posListRelay};
end;


%---create swimmer selection panel button
handles2.eventSelection_select = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 40, 185, 115], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Event Selection', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.eventSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

if ispc == 1;
    handles2.strokeSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 80, 175, 20], 'string', handles2.ListStroke, 'Value', posListStroke, 'callback', @popstrokeSelection_select, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.strokeSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.distanceSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 55, 175, 20], 'string', handles2.ListDistance, 'Value', posListDistance, 'callback', @popdistanceSelection_select, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.distanceSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.poolSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 30, 175, 20], 'string', handles2.ListPool, 'Value', posListPool, 'callback', @poppoolSelection_select, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.poolSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.relaySelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 5, 175, 20], 'string', handles2.ListRelay, 'Value', posListRelay, 'callback', @poprelaySelection_select, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.relaySelection_select, 'fontunits', 'normalized', 'units', 'normalized');

elseif ismac == 1;
    handles2.strokeSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 80, 175, 20], 'string', handles2.ListStroke, 'Value', posListStroke, 'callback', @popstrokeSelection_select, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.strokeSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.distanceSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 55, 175, 20], 'string', handles2.ListDistance, 'Value', posListDistance, 'callback', @popdistanceSelection_select, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.distanceSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.poolSelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 30, 175, 20], 'string', handles2.ListPool, 'Value', posListPool, 'callback', @poppoolSelection_select, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles2.poolSelection_select, 'fontunits', 'normalized', 'units', 'normalized');

    handles2.relaySelection_select = uicontrol('parent', handles2.eventSelection_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 5, 175, 20], 'string', handles2.ListRelay, 'Value', posListRelay, 'callback', @poprelaySelection_select, ...
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



