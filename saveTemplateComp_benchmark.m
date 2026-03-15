function [] = saveTemplateComp_benchmark(varargin);


handles = guidata(gcf);

%grab variables
addPerfRanking = handles.addPerfRanking;
existRankings = handles.existRankings;
filelistAddedCustom_benchmark = handles.filelistAddedCustom_benchmark;
databaseCurrent = handles.databaseCurrent;
RaceDistListCustom_benchmark = handles.RaceDistListCustom_benchmark;
StrokeListCustom_benchmark = handles.StrokeListCustom_benchmark;
GenderListCustom_benchmark = handles.GenderListCustom_benchmark;
CourseListCustom_benchmark = handles.CourseListCustom_benchmark;
sortingOption_benchmark = get(handles.sortOptionCustomRanking_benchmark, 'Value');

%create file
answer = inputdlg('Comparison template name', 'Create a new template');
if isempty(answer) == 1;
    return;
end;
if isempty(answer{1}) == 1;
    return;
end;
filenamePreferences = answer{1};

index1 = strfind(filenamePreferences, ' ');
index2 = strfind(filenamePreferences, '-');
index3 = strfind(filenamePreferences, ';');
index4 = strfind(filenamePreferences, ',');
index5 = strfind(filenamePreferences, '''');
index6 = strfind(filenamePreferences, '#');
index7 = strfind(filenamePreferences, '%');
index8 = strfind(filenamePreferences, '$');
index9 = strfind(filenamePreferences, '!');
index10 = strfind(filenamePreferences, '*');
index11 = strfind(filenamePreferences, '&');
index12 = strfind(filenamePreferences, '+');
indexAll = [index1 index2 index3 index4 index5 index6 index7 index8 index9 index10 index11 index12];
if isempty(indexAll) == 0;
    filenamePreferences(indexAll) = [];
end;
filenamePreferencesSave = filenamePreferences;

if ispc == 1;
    MDIR = getenv('USERPROFILE');
    filenamePreferences = [MDIR '\SP2Viewer\Preferences\customComp_' filenamePreferences '.mat'];
elseif ismac == 1;
    filenamePreferences = ['/Applications/SP2Viewer/Preferences/customComp_' filenamePreferences '.mat'];
end;
if isfile(filenamePreferences) == 1;
    errordlg('Existing comparison template found. Please select a different name', 'Error');
    return;
end;
save(filenamePreferences, 'addPerfRanking', 'existRankings', 'filelistAddedCustom_benchmark', 'databaseCurrent', 'RaceDistListCustom_benchmark', 'StrokeListCustom_benchmark', 'GenderListCustom_benchmark', 'CourseListCustom_benchmark', 'sortingOption_benchmark');

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
    index = find(strcmpi(comparison_templatelist,filenamePreferencesSave));
end;
set(handles.LoadComparisonCustomRanking_benchmark, 'String', comparison_templatelist, 'Value', index);

guidata(handles.hf_w1_welcome, handles);

