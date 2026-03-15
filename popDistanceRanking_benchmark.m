function [] = popDistanceRanking_benchmark(varargin);


handles = guidata(gcf);

val = get(handles.SelectDistanceRanking_benchmark, 'Value');
valPool = get(handles.SelectPoolRanking_benchmark, 'value');
valDataset = get(handles.SelectDatasetRanking_benchmark, 'value');

if val == 2;
    %50m
    if valPool == 3;
        %SC
        handles.SelectDatasetRankingList_benchmark = {'Dataset';'Race Time';'Swim Speed';'Stroke Efficiency';'Speed Decay';'Decay Index';'Skill Time';'Block Time';'Start Time';'Turn Time'};
    else;
        handles.SelectDatasetRankingList_benchmark = {'Dataset';'Race Time';'Swim Speed';'Stroke Efficiency';'Speed Decay';'Decay Index';'Skill Time';'Block Time';'Start Time';'Finish Time'};
    end;
else;
    %other distances
    handles.SelectDatasetRankingList_benchmark = {'Dataset';'Race Time';'Swim Speed';'Stroke Efficiency';'Speed Decay';'Decay Index';'Skill Time';'Block Time';'Start Time';'Turn Time'};
end;

if valDataset == 2 | valDataset == 7;
    if valPool == 3;
        %SC
        if val <= 5;
            if val == 2;
                set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
            else;
                set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'on');
            end;
        else;
            set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
        end;
    else;
        if val <= 6;
            if val == 2;
                set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
            else;
                set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'on');
            end;
        else;
            set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
        end;
    end;
else;
    set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
end;

set(handles.SelectDatasetRanking_benchmark, 'String', handles.SelectDatasetRankingList_benchmark);

set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
handles.addPerfRanking = [];

guidata(handles.hf_w1_welcome, handles);
