function handles2 = create_searchtool;

resolution = get(0,'ScreenSize');
resolution = resolution(1,3:4);
hdef = figure('units', 'pixels', 'position', [(resolution(1)-1200)./2 (resolution(2)-750)./2 1200 800], ...
    'Color', [0.1 0.1 0.1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Filter', ...
    'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(hdef), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;



%---analyser filter options
handles2.analyserfilteroptions_analyser = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 440, 150, 350], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'Title', 'Filter Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.analyserfilteroptions_analyser, 'fontunits', 'normalized');

handles2.txtfilter_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 310, 145, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 11, ...
    'String', 'Filter by:');
set(handles2.txtfilter_analyser, 'fontunits', 'normalized');

handles2.filteredit_meet_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 285, 130, 20], 'Callback', @filtereditmeet_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'String', 'Meet', ...
    'tooltipstring', ['Use ' '''' ';' '''' ' to add multiple strings']);
set(handles2.filteredit_meet_analyser, 'fontunits', 'normalized');

handles2.filteredit_year_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 260, 130, 20], 'Callback', @filteredityear_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'String', 'Year', ...
    'tooltipstring', ['Use ' '''' ';' '''' ' to add multiple strings']);
set(handles2.filteredit_year_analyser, 'fontunits', 'normalized');

handles2.filteredit_name_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 235, 130, 20], 'Callback', @filtereditname_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'String', 'Name', ...
    'tooltipstring', ['Use ' '''' ';' '''' ' to add multiple strings']);
set(handles2.filteredit_name_analyser, 'fontunits', 'normalized');

listpopGender = {'Gender', 'Male', 'Female'};
listpopType = {'Swim Type', 'Final', 'SemiFinal', 'Heat', 'SwimOff', 'TimeTrial'};
listpopStroke = {'Stroke Type', 'Butterfly', 'Backstroke', 'Breaststroke', 'Freestyle', 'Medley'};
listpopDistance = {'Distance', '50m', '100m', '200m', '400m', '800m', '1500m', '4x50m', '4x100m', '4x200m'};
listpopPool = {'Pool Type', 'SCM', 'LCM'};
listpopGroup = {'Category', 'Able', 'Para'};
listpopRelay = {'Race Type', 'Flat', 'Relay'};
listpopAge = {'Age Group', 'Open', 'Under18', 'Under17', 'Under16', 'Under15',  'Under14'};
listpopTime = {'All times', 'PBs only'};

handles2.listpopGender = listpopGender;
handles2.listpopType = listpopType;
handles2.listpopStroke = listpopStroke;
handles2.listpopDistance = listpopDistance;
handles2.listpopPool = listpopPool;
handles2.listpopGroup = listpopGroup;
handles2.listpopRelay = listpopRelay;
handles2.listpopAge = listpopAge;
handles2.listpopTime = listpopTime;

if ismac == 1;
    handles2.filterpop_gender_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 210, 130, 20], 'String', listpopGender, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpopgender_analyser);

    handles2.filterpop_type_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 185, 130, 20], 'String', listpopType, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpoptype_analyser);

    handles2.filterpop_stroke_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 160, 130, 20], 'String', listpopStroke, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpopstroke_analyser);

    handles2.filterpop_distance_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 135, 130, 20], 'String', listpopDistance, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpopdistance_analyser);

    handles2.filterpop_pool_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 110, 130, 20], 'String', listpopPool, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpoppool_analyser);

    handles2.filterpop_category_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 85, 130, 20], 'String', listpopGroup, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpopgroup_analyser);

    handles2.filterpop_relay_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 60, 130, 20], 'String', listpopRelay, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpoprelay_analyser);

    handles2.filterpop_group_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 35, 130, 20], 'String', listpopAge, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpopgroup_analyser);

    handles2.filterpop_time_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 10, 130, 20], 'String', listpopTime, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 10, 'Callback', @filterpoptime_analyser);
    
elseif ispc == 1;
    handles2.filterpop_gender_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 210, 130, 20], 'String', listpopGender, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpopgender_analyser);

    handles2.filterpop_type_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 185, 130, 20], 'String', listpopType, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpoptype_analyser);

    handles2.filterpop_stroke_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 160, 130, 20], 'String', listpopStroke, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpopstroke_analyser);

    handles2.filterpop_distance_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 135, 130, 20], 'String', listpopDistance, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpopdistance_analyser);

    handles2.filterpop_pool_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 110, 130, 20], 'String', listpopPool, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpoppool_analyser);

    handles2.filterpop_category_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 85, 130, 20], 'String', listpopGroup, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpopgroup_analyser);

    handles2.filterpop_relay_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 60, 130, 20], 'String', listpopRelay, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpoprelay_analyser);

    handles2.filterpop_group_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 35, 130, 20], 'String', listpopAge, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpopagegroup_analyser);

    handles2.filterpop_time_analyser = uicontrol('parent', handles2.analyserfilteroptions_analyser, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 10, 130, 20], 'String', listpopTime, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', 9.5, 'Callback', @filterpoptime_analyser);
end;
handles2.SearchMeet = [];
handles2.SearchYear = [];
handles2.SearchName = [];
handles2.SearchMeet = [];
handles2.SearchGender = [];
handles2.SearchSwimType = [];
handles2.SearchStrokeType = [];
handles2.SearchDistance = [];
handles2.SearchPoolType = [];
handles2.SearchCategory = [];
handles2.SearchRaceType = [];
handles2.SearchAgeGroup = [];
handles2.SearchPB = [];

set(handles2.filterpop_gender_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_type_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_stroke_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_distance_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_pool_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_category_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_relay_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_group_analyser, 'fontunits', 'normalized');
set(handles2.filterpop_time_analyser, 'fontunits', 'normalized');

%---clear button
handles2.clear_button_analyser = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 400, 60, 30], 'callback', @clearfilter_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', 10, 'String', 'Clear');
set(handles2.clear_button_analyser, 'fontunits', 'normalized', 'units', 'normalized');

%---apply button
handles2.apply_button_analyser = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [90, 400, 60, 30], 'callback', @applyfilter_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', 10, 'String', 'Apply');
set(handles2.apply_button_analyser, 'fontunits', 'normalized', 'units', 'normalized');

%---Validate button
handles2.validate_button_analyser = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, 10, 100, 30], 'callback', @validatefilter_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', 10, 'String', 'Validate');
set(handles2.validate_button_analyser, 'fontunits', 'normalized', 'units', 'normalized');


%---create summary table
handles2.table_analyser = uitable('parent', hdef, 'Visible', 'off', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', 10, ...
    'FontWeight', 'Bold', 'position', [170 10 1020 780], 'ColumnEditable', false, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');
% set(handles.SummaryData_table_analyser, 'fontunits', 'normalized');


%---Apply database
Disp_Database_analyser;


set(handles2.analyserfilteroptions_analyser, 'units', 'normalized');
set(handles2.txtfilter_analyser, 'units', 'normalized');
set(handles2.filteredit_meet_analyser, 'units', 'normalized');
set(handles2.filteredit_year_analyser, 'units', 'normalized');
set(handles2.filteredit_name_analyser, 'units', 'normalized');
set(handles2.filterpop_gender_analyser, 'units', 'normalized');
set(handles2.filterpop_type_analyser, 'units', 'normalized');
set(handles2.filterpop_stroke_analyser, 'units', 'normalized');
set(handles2.filterpop_distance_analyser, 'units', 'normalized');
set(handles2.filterpop_pool_analyser, 'units', 'normalized');
set(handles2.filterpop_category_analyser, 'units', 'normalized');
set(handles2.filterpop_relay_analyser, 'units', 'normalized');
set(handles2.filterpop_group_analyser, 'units', 'normalized');
set(handles2.filterpop_time_analyser, 'units', 'normalized');
set(handles2.apply_button_analyser, 'units', 'normalized');
set(handles2.clear_button_analyser, 'units', 'normalized');
set(handles2.validate_button_analyser, 'units', 'normalized');
drawnow;

fh = findobj(0,'type','figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);

uiwait(gcf);
fh = findobj(0,'type','figure');
set(0, 'CurrentFigure', fh(1).Number);

try;
    FullDBTab = get(handles2.table_analyser, 'data');
    handles2.FullDBTab = FullDBTab;
    guidata(gcf, handles2);
    close(gcf);
catch;
    FullDBTab = [];
    handles2.FullDBTab = FullDBTab;
    guidata(gcf, handles2);
    handles2.FullDBTab = FullDBTab;
    guidata(gcf, handles2);
end;





