function [] = popDatasetRanking_benchmark(varargin);


handles = guidata(gcf);

set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
handles.addPerfRanking = [];

valPool = get(handles.SelectPoolRanking_benchmark, 'value');
valDist = get(handles.SelectDistanceRanking_benchmark, 'value');
valDataset = get(handles.SelectDatasetRanking_benchmark, 'value');
if valDataset == 2 | valDataset == 7;
    if valPool == 3;
        %SC
        if valDist <= 5;
            if valDist == 2;
                set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
            else;
                set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'on');
            end;
        else;
            set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'off');
        end;
    else;
        if valDist <= 6;
            if valDist == 2;
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

guidata(handles.hf_w1_welcome, handles);
