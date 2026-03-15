function [] = refreshCloud_benchmark(varargin);


handles = guidata(gcf);

[connected,timing] = isnetavl;

%---Download current year DB
if connected == 1;

    if ispc == 1;
        fontEC = 14;
    elseif ismac == 1;
        fontEC = 16;
    end;
%     resolution = get(0,'ScreenSize');
%     resolution = resolution(1,3:4);
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
    
    window_size = floor([(resolution(1)-300)./2 (resolution(2)-100)./2 300 100]);
    window_size(1) = window_size(1) + offsetLeft;
    window_size(2) = window_size(2) + offsetBottom;
    h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
        'color', [0 0 0], 'units', 'pixels','position', window_size,'windowstyle','modal', ...
        'Name', 'Loading', 'NumberTitle', 'off');
    h1 = uicontrol('parent', h, 'style', 'text', ...
        'string', 'Preparing your data ...', 'units', 'pixels', ...
        'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
        'FontWeight', 'Bold', 'Fontsize', fontEC);
    drawnow;

    yearEC = year(datetime("today"));
%     for yearEC = 2018:currentYear;
        filenameDBin = ['s3://sparta2-prod/sparta2-data/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            filenameDBout = [MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        elseif ismac == 1;
            filenameDBout = ['/Applications/SP2Synchroniser/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        end;
        command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
        [status, out] = system(command);
%     end;
else;
    warningwindow = errordlg('No internet connection detected', 'Warning');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame = get(handle(warningwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    return;
end;


%---Update FullDB, uidDB and AgeGroup variables
FullDB = handles.FullDB_4update;
uidDB = handles.uidDB_4update;
AgeGroup = handles.AgeGroup_4update;

fileEC = ['FullDB_SP2_' num2str(yearEC)];
if exist(fileEC) == 1;
    rawIni = length(FullDB(:,1)) + 1;
    eval(['rawEnd = rawIni + length(FullDB_SP2_' num2str(yearEC) '(2:end,1)) - 1;']);
    eval(['FullDB(rawIni:rawEnd,:) = FullDB_SP2_' num2str(yearEC) '(2:end,:);']);

    rawIni = length(uidDB(:,1)) + 1;
    eval(['rawEnd = rawIni + length(uidDB_SP2_' num2str(yearEC) '(:,1)) - 1;']);
    eval(['uidDB(rawIni:rawEnd,:) = uidDB_SP2_' num2str(yearEC) ';']);

    eval(['listFieldsCheck = fieldnames(AgeGroup_SP2_' num2str(yearEC) ');']);
    for i = 1:length(listFieldsCheck);
        fieldCheck = listFieldsCheck{i};
        index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
        if isempty(index) == 1;
            eval(['val = AgeGroup_SP2_' num2str(yearEC) '.' fieldCheck ';']);
            eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
        end;
    end;
end;

%---Update athlete name list
handles.AthleteNamelist_analyser = [];
[AthleteNamesList, index] = sort(FullDB(2:end, 2));
AthleteNamesList2 = {'Athlete name'};

AthleteGendersList = FullDB(2:end, 5);
AthleteGendersList = AthleteGendersList(index,1);
AthleteGendersList2 = {'Gender'};

iter = 2;
for i = 1:length(AthleteNamesList);
    nameACT = AthleteNamesList{i,1};
    genderACT = AthleteGendersList{i,1};

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
                AthleteGendersList2(iter,1) = {genderACT};
                iter = iter + 1;
            end;
        else;
            AthleteNamesList2(iter,1) = {nameACT};
            AthleteGendersList2(iter,1) = {genderACT};
            iter = iter + 1;
        end;
    end;
end;
handles.AthleteNamesList = AthleteNamesList2;
handles.AthleteGendersList = AthleteGendersList2;
handles.AthleteNamelist_analyser = AthleteNamesList2;
handles.AthleteNamelistDisp_analyser = AthleteNamesList2;


%---Update Custom (if selected)
valEC = get(handles.typeRankingCustom_benchmark, 'Value');
if valEC == 1;
    %Update custom
    set(handles.LoadComparisonCustomRanking_benchmark, 'Value', 1);
    handles.AthleteNamelistDisp_benchmark = handles.AthleteNamelist_analyser(2:end);
    set(handles.AthleteName_list_benchmark, 'String', handles.AthleteNamelistDisp_benchmark, 'Value', 1);
    set(handles.Search_athletename_benchmark, 'String', '');
    handles.AthleteRacelist_benchmark = '';
    handles.AthleteRacelistDisp_benchmark = '';
    set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
    set(handles.Search_racename_benchmark, 'String', '');
        
    handles.addPerfRanking = [];
    handles.addPerfProfile = [];
    handles.filelistAddedCustom_benchmark = [];
    handles.databaseCurrent = [];
    handles.existRankings = 0;
    handles.RaceDistListCustom_benchmark = [];
    handles.StrokeListCustom_benchmark = [];
    handles.GenderListCustom_benchmark = [];
    handles.CourseListCustom_benchmark = [];
end;


%---Update Top10 (if selected)
valEC = get(handles.typeRankingTop10_benchmark, 'Value');
if valEC == 1;
    set(handles.SelectGenderRanking_benchmark, 'value', 1);
    set(handles.SelectStrokeRanking_benchmark, 'value', 1);
    set(handles.SelectDistanceRanking_benchmark, 'value', 1);
    set(handles.SelectPoolRanking_benchmark, 'value', 1);
    set(handles.SelectCategoryRanking_benchmark, 'value', 1);
    set(handles.SelectAgeRanking_benchmark, 'value', 1);
    set(handles.SelectDatasetRanking_benchmark, 'value', 1);
    set(handles.SelectPBRanking_benchmark, 'value', 1, 'enable', 'on');
    set(handles.SelectMeetRanking_benchmark, 'value', 1);
    set(handles.SelectTypeRanking_benchmark, 'value', 1);
    set(handles.SelectSeasonRanking_benchmark, 'value', 1);
    set(handles.SelectCountryRanking_benchmark, 'value', 1);
    set(handles.SelectSpartaRanking_benchmark, 'value', 1);
    set(handles.SelectRoundRanking_benchmark, 'value', 1);
    handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
    AthleteNamesListMod = handles.AthleteNamesList;
    AthleteNamesListMod{1,1} = 'All Swimmers';
    set(handles.SelectAthleteRanking_benchmark, 'String', AthleteNamesListMod, 'value', 1);
    set(handles.SearchAthleteRanking_benchmark, 'String', '');
    set(handles.SearchAddAthleteRanking_benchmark, 'String', '');

    set(handles.salRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.finaRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    handles.selectAgeLimRanking_benchmark = 0;
    handles.selectAgeRulesRanking_benchmark = 0;
    handles.addPerfRanking = [];
    handles.addPerfProfile = [];
    handles.filelistAddedCustom_benchmark = [];
    handles.databaseCurrent = [];
    handles.existRankings = 0;
    handles.RaceDistListCustom_benchmark = [];
    handles.StrokeListCustom_benchmark = [];
    handles.GenderListCustom_benchmark = [];
    handles.CourseListCustom_benchmark = [];
        
    handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
    handles.AthleteNamesListDispRanking{1,1} = 'All Swimmers';
    handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
    set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', 1);
end;


%---reset rankings
set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
set(handles.MainRanking_benchmark, 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
set(handles.SecondaryRanking_benchmark, 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);

set(handles.MainRanking_benchmark, 'Visible', 'off');
set(handles.SecondaryRanking_benchmark, 'Visible', 'off');
set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');



guidata(handles.hf_w1_welcome, handles);


delete(h);
