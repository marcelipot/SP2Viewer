function [] = deleteTemplateComp_benchmark(varargin);




handles = guidata(gcf);


%identify template to delete
valEC = get(handles.LoadComparisonCustomRanking_benchmark, 'Value');
if valEC == 1;
    return;
end;
comparison_templatelist = get(handles.LoadComparisonCustomRanking_benchmark, 'String');
fileEC = comparison_templatelist{valEC};


%Question
answer = questdlg(['Would you like to delete the ' fileEC ' template?'], ...
    'Delete', 'Yes', 'No', 'No');

if isempty(answer) == 1;
    return;
end;
if strcmpi(answer, 'No') == 1;
    return;
end;


%Delete file
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    filenamePreferences = [MDIR '\SP2Viewer\Preferences\customComp_' fileEC '.mat'];
    cmd = ['del /q ' filenamePreferences];
elseif ismac == 1;
    filenamePreferences = ['/Applications/SP2Viewer/Preferences/customComp_' fileEC '.mat'];
    cmd = ['rm ' filenamePreferences];
end;
[status, cmdout] = system(cmd);


%check comparison templates
if ispc == 1;
    listDir = dir([MDIR '\SP2Viewer\Preferences\']);
elseif ismac == 1;
    listDir = dir('/Applications/SP2Viewer/Preferences/');
end;
comparison_templatelist = {};
addtemp = 2;
for iter = 1:length(listDir);
    fileEC = listDir(iter).name;
    index = strfind(fileEC, 'customComp_');
    if isempty(index) == 0;
        index = index+11;
        index2 = strfind(fileEC, '.mat');
        templateEC = fileEC(index:index2-1);
        comparison_templatelist{addtemp,1} = templateEC;
        addtemp = addtemp + 1;
    end;
end;
if isempty(comparison_templatelist) == 1;
    comparison_templatelist = 'Select a template';
else;
    [~, index] = sort(lower(comparison_templatelist(2:end,1)));
    index = index + 1;
    comparison_templatelist2 = comparison_templatelist(index,1);
    li = find(index == addtemp-1);
    comparison_templatelist{1,1} = 'Select a template';
    comparison_templatelist(2:end,1) = comparison_templatelist2;
end;
set(handles.LoadComparisonCustomRanking_benchmark, 'String', comparison_templatelist, 'Value', 1);


%Reset display
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

