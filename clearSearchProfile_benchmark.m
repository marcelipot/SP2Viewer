function [] = clearSearchProfile_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 2;
    set(handles.SelectAthleteProfile_benchmark, 'Value', 1);
    set(handles.SearchAthleteProfile_benchmark, 'String', '');
    set(handles.SelectDistanceProfile_benchmark, 'Value', 1);
    set(handles.SelectStrokeProfile_benchmark, 'Value', 1);
    set(handles.SelectPoolProfile_benchmark, 'Value', 1);
    handles.SelectPerfProfileList_benchmark = {'Race';'PB';'SB'};
    set(handles.SelectPerfProfile_benchmark, 'Value', 1, 'String', handles.SelectPerfProfileList_benchmark);
    set(handles.SelectCountryProfile_benchmark, 'Value', 1);
    set(handles.SelectAgeProfile_benchmark, 'Value', 1);

    set(handles.salRulesProfile_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.finaRulesProfile_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.strictAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.belowAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
    handles.selectAgeLimProfile_benchmark = 0;
    handles.selectAgeRulesProfile_benchmark = 0;

    try;
        [li, co] = size(handles.txtMainProfile_ID);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.txtMainProfile_ID{i,j}) == 0;
                    delete(handles.txtMainProfile_ID{i,j});
                end;
            end;
        end;
        handles.txtMainProfile_ID = {};
    end;

    try;
        [li, co] = size(handles.txtMainProfile_SUMMARY);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.txtMainProfile_SUMMARY{i,j}) == 0;
                    delete(handles.txtMainProfile_SUMMARY{i,j});
                end;
            end;
        end;
        handles.txtMainProfile_SUMMARY = {};
    end;

    try;
        [li, co] = size(handles.txtMainProfile_SPIDER);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.txtMainProfile_SPIDER{i,j}) == 0;
                    delete(handles.txtMainProfile_SPIDER{i,j});
                end;
            end;
        end;
        handles.txtMainProfile_SPIDER = {};
    end;

    try;
        [li, co] = size(handles.txtMainProfile_HIST);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.txtMainProfile_HIST{i,j}) == 0;
                    delete(handles.txtMainProfile_HIST{i,j});
                end;
            end;
        end;
        handles.txtMainProfile_HIST = {};
    end;

    try;
        [li, co] = size(handles.txtOBJ_TABLE);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.txtOBJ_TABLE{i,j}) == 0;
                    delete(handles.txtOBJ_TABLE{i,j});
                end;
            end;
        end;
        handles.txtOBJ_TABLE = {};
    end;

    try;
        [li, co] = size(handles.txtOBJ_GROUP);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.txtOBJ_GROUP{i,j}) == 0;
                    delete(handles.txtOBJ_GROUP{i,j});
                end;
            end;
        end;
        handles.txtOBJ_GROUP = {};
    end;

    try;
        [li, co] = size(handles.pushButtonsProfile_HIST);
        for i = 1:li;
            for j = 1:co;
                if isempty(handles.pushButtonsProfile_HIST{i,j}) == 0;
                    delete(handles.pushButtonsProfile_HIST{i,j});
                end;
            end;
        end;
        handles.pushButtonsProfile_HIST = {};
    end;
    set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');

    handles.existProfile = 0;
    handles.AthleteNamesListDispProfile = handles.AthleteNamesList;
    set(handles.SelectAthleteProfile_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    set(handles.SelectAgeProfile_benchmark, 'String', handles.SelectAgeProfileList_benchmark, 'Value', 1);
end;

guidata(handles.hf_w1_welcome, handles);