function handles2 = create_selecttool_profile(FullDB, icones, Stroke, Distance, Pool, Sparta, SeasonEC, BenchmarkEvents, AgeGroup, source);


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

window_size = floor([(resolution(1)-150)./2 (resolution(2)-200)./2 200 200]);
window_size(1) = window_size(1) + offsetLeft;
window_size(2) = window_size(2) + offsetBottom;

hdef = figure('units', 'pixels', 'position', window_size, ...
    'Color', [0.1 0.1 0.1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Select a performance', ...
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
    font2 = 9;
elseif ismac == 1;
    font1 = 14;
    font2 = 11;
end;


AthleteNamesList = sort(FullDB(2:end, 2));
AthleteNamesList2 = {'Athlete name'};
iter = 2;
for i = 1:length(AthleteNamesList);
    nameACT = AthleteNamesList{i,1};
    interrupt = 0;
    if strfind(nameACT, 'Admin');
        interrupt = 1;
    end;
    if strfind(nameACT, 'AIS');
        interrupt = 1;
    end;
    if strfind(nameACT, 'Dino');
        interrupt = 1;
    end;
    if strfind(nameACT, 'Doe');
        interrupt = 1;
    end;
    
    if interrupt == 0;
        if isempty(AthleteNamesList2) == 0;
            Index = find(contains(AthleteNamesList2, nameACT));
            if isempty(Index) == 1;
                AthleteNamesList2(iter,1) = {nameACT};
                iter = iter + 1;
            end;
        else;
            AthleteNamesList2(iter,1) = {nameACT};
            iter = iter + 1;
        end;
    end;
end;

handles2.AthleteNamesList = AthleteNamesList2;
handles2.AthleteNamesListDispProfile = handles2.AthleteNamesList;
handles2.Stroke = Stroke;
handles2.Distance = Distance;
handles2.Pool = Pool;
handles2.Sparta = Sparta;
handles2.SeasonEC = SeasonEC;
handles2.FullDB = FullDB;
handles2.SearchPerf = [];
handles2.SearchAthlete = source{2,1};
handles2.BenchmarkEvents = BenchmarkEvents;
handles2.AgeGroup = AgeGroup;
handles2.source = source;
handles2.yearPerf = [];

%---create swimmer selection panel button
handles2.SelectSwimmerProfile_select = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 110, 185, 85], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select a swimmer', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.SelectSwimmerProfile_select, 'fontunits', 'normalized', 'units', 'normalized');

if ispc == 1;
    if strcmpi(source{1,1}, 'Ranking') == 1;
        if length(source(:,1)) > 2;
            handles2.SelectAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 40, 175, 20], 'string', source(2:end,1), 'callback', @popSwimmerRanking_select, ...
                'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
        else;
            handles2.SelectAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 40, 175, 20], 'string', source{2,1}, 'callback', '', 'enable', 'off', ...
                'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
        end;
    else;
        handles2.SelectAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
            'position', [5, 40, 175, 20], 'string', handles2.AthleteNamesList, 'callback', @popSwimmerProfile_select, ...
            'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    end;
    set(handles2.SelectAthleteProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
    
elseif ismac == 1;
    if strcmpi(source{1,1}, 'Ranking') == 1;
        if length(source(:,1)) > 2;
            handles2.SelectAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 40, 175, 20], 'string', source(2:end,1), 'callback', @popSwimmerRanking_select, ...
                'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
        else;
            handles2.SelectAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 40, 175, 20], 'string', source{2,1}, 'callback', '', 'enable', 'off', ...
                'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
        end;
    else;
        handles2.SelectAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
            'position', [5, 40, 175, 20], 'string', handles2.AthleteNamesList, 'callback', @popSwimmerProfile_select, ...
            'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    end;
    set(handles2.SelectAthleteProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
end;

if strcmpi(source{1,1}, 'Ranking') == 1;
    handles2.SearchAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 10, 175, 20], 'Callback', '', 'enable', 'off', ...
        'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', '');
else;
    handles2.SearchAthleteProfile_select = uicontrol('parent', handles2.SelectSwimmerProfile_select, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 10, 175, 20], 'Callback', @searchAthleteProfile_select, ...
        'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', '');
end;
set(handles2.SearchAthleteProfile_select, 'fontunits', 'normalized', 'units', 'normalized');




%---create performance selection panel button
handles2.SelectRaceProfile_select = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 40, 185, 60], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select a performance', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.SelectRaceProfile_select, 'fontunits', 'normalized', 'units', 'normalized');


if ispc == 1;
    if strcmpi(source{1,1}, 'Ranking') == 1;
        if length(source(:,1)) > 2;
            currentDate = datetime("today");
            for seasonEC = 1:length(BenchmarkEvents(:,1));
                dateINI = datetime(BenchmarkEvents(seasonEC,2), 'InputFormat', 'yyyy-MM-dd');
                dateEND = datetime(BenchmarkEvents(seasonEC,3), 'InputFormat', 'yyyy-MM-dd');
                
                if currentDate >= dateINI & currentDate <= dateEND;
                    %this is the current season
                    yearEC = year(dateINI);
                    handles2.raw_SeasonInterest = seasonEC;
                end;
            end;

            handles2.SelectPerfProfileList_select = {'Performance';'PB'; ['SB ' num2str(yearEC-1) '-' num2str(yearEC)]; ['SB ' num2str(yearEC) '-' num2str(yearEC+1)]};
            handles2.SelectPerfProfile_select = uicontrol('parent', handles2.SelectRaceProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 10, 175, 20], 'string', handles2.SelectPerfProfileList_select, 'callback', @popPerfProfile_select, ...
                'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
            set(handles2.SelectPerfProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            handles2.SelectPerfProfile_select = uicontrol('parent', handles2.SelectRaceProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 10, 175, 20], 'string', '', 'callback', @popPerfProfile_select, ...
                'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
            set(handles2.SelectPerfProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
        end;
        SearchName = source{2,1};
        SearchDistance = Distance;
        SearchStroke = Stroke;
        SearchPool = Pool;
        SearchSparta = Sparta;

        filter_listRace_ranking;

        handles2.SeasonEC = SeasonEC;
        handles2.FullDB = FullDB;
        handles2.SearchPerf = [];
        handles2.SearchAthlete = source{2,1};
        handles2.BenchmarkEvents = BenchmarkEvents;
        handles2.AgeGroup = AgeGroup;
        handles2.source = source;
    
    else;
        for seasonEC = 1:length(BenchmarkEvents(:,1));
            dateINI = datetime(BenchmarkEvents(seasonEC,2), 'InputFormat', 'yyyy-MM-dd');
            dateEND = datetime(BenchmarkEvents(seasonEC,3), 'InputFormat', 'yyyy-MM-dd');
            
            if dateINI >= currentDate & dateEND <= dateEND;
                %this is the current season
                yearEC = year(dateINI);
                raw_SeasonInterest = seasonEC;
            end;
        end;

        handles2.SelectPerfProfileList_select = {'Performance';'PB'; ['SB' num2str(yearEC-1) ' - ' num2str(yearEC)]; ['SB' num2str(yearEC) ' - ' num2str(yearEC+1)]};
        
        handles2.SelectPerfProfile_select = uicontrol('parent', handles2.SelectRaceProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
            'position', [5, 10, 175, 20], 'string', handles2.SelectPerfProfileList_select, 'callback', @popPerfProfile_select, ...
            'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
        set(handles2.SelectPerfProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
    end;    
    
elseif ismac == 1;
    if strcmpi(source{1,1}, 'Ranking') == 1;
        if length(source(:,1)) > 2;
            handles2.SelectPerfProfileList_select = {'Performance';'PB';'SB'};
            handles2.SelectPerfProfile_select = uicontrol('parent', handles2.SelectRaceProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 10, 175, 20], 'string', handles2.SelectPerfProfileList_select, 'callback', @popPerfProfile_select, ...
                'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
            set(handles2.SelectPerfProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
        else;
            handles2.SelectPerfProfile_select = uicontrol('parent', handles2.SelectRaceProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
                'position', [5, 10, 175, 20], 'string', '', 'callback', @popPerfProfile_select, ...
                'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
            set(handles2.SelectPerfProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
        end;
        SearchName = source{2,1};
        SearchDistance = Distance;
        SearchStroke = Stroke;
        SearchPool = Pool;
        SearchSparta = Sparta;

        filter_listRace_ranking;

        handles2.SeasonEC = SeasonEC;
        handles2.FullDB = FullDB;
        handles2.SearchPerf = [];
        handles2.SearchAthlete = source{2,1};
        handles2.BenchmarkEvents = BenchmarkEvents;
        handles2.AgeGroup = AgeGroup;
        handles2.source = source;
    
    else;
        handles2.SelectPerfProfileList_select = {'Performance';'PB';'SB'};
        handles2.SelectPerfProfile_select = uicontrol('parent', handles2.SelectRaceProfile_select, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
            'position', [5, 10, 175, 20], 'string', handles2.SelectPerfProfileList_select, 'callback', @popPerfProfile_select, ...
            'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
        set(handles2.SelectPerfProfile_select, 'fontunits', 'normalized', 'units', 'normalized');
    end;
end;


%---create remove all and validate icons
%---clear button
handles2.cancel_button_select = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, 10, 60, 20], 'callback', @cancelfilter_select, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'String', 'Cancel');
set(handles2.cancel_button_select, 'fontunits', 'normalized', 'units', 'normalized');

%---Validate button
handles2.validate_button_select = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [115, 10, 60, 20], 'callback', @validatefilter_select, ...
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
        handles2.SearchPerf = [];
        handles2.SearchAthlete = [];
        guidata(gcf, handles2);
    end;
end;



