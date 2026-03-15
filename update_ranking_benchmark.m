iter = 1;


if isempty(list2keep) == 1;
    %empty... reset display
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

    handles.databaseCurrent = [];
    handles.databaseCurrentName = [];
    handles.filelistAddedCustom_benchmark = [];
    handles.filelistAddedDispCustom_benchmark = [];
    handles.RaceDistListCustom_benchmark = [];
    handles.StrokeListCustom_benchmark = [];
    handles.GenderListCustom_benchmark = [];
    handles.CourseListCustom_benchmark = [];

    guidata(handles.hf_w1_welcome, handles);

else;
    for i = 1:length(list2keep);
        databaseCurrent_rankingsNew(iter,:) = handles.databaseCurrent_rankings(list2keep(i),:);
        iter = iter + 1;
    end;
    
    if length(handles.databaseCurrent_rankings(:,1))+1 <= length(handles.databaseCurrentFull_rankings(:,1));
        databaseCurrent_rankingsNew(end+1,:) = handles.databaseCurrentFull_rankings(length(handles.databaseCurrent_rankings(:,1))+1,:);
    end;
    databaseCurrent = databaseCurrent_rankingsNew;
    databaseCurrentName = handles.databaseCurrentName_rankings;
    
    try;
        [li, co] = size(handles.txtMainRanking);
        for i = 1:li;
            for j = 1:co;
                delete(handles.txtMainRanking{i,j});
            end;
        end;
        handles.txtMainRanking = {};
    end;
    try;
        [li, co] = size(handles.txtSecondaryRanking);
        for i = 1:li;
            for j = 1:co;
                delete(handles.txtSecondaryRanking{i,j});
            end;
        end;
        handles.txtSecondaryRanking = {};
    end;
    
    returnval = 0;
    MatAge = handles.MatAgeRankings;
    MatAgeNew = [];
    iter = 1;

    for i = 1:length(list2keep);
        MatAgeNew(iter,:) = MatAge(list2keep(i),:);
        iter = iter + 1;
    end;

    if length(handles.databaseCurrent_rankings(:,1))+1 <= length(handles.databaseCurrentFull_rankings(:,1));
        MatAgeNew(end+1,:) = MatAge(length(handles.databaseCurrent_rankings(:,1))+1,:);
    end;
    MatAge = MatAgeNew;

    if isempty(databaseCurrentName) == 0;
        MatAgeName = handles.MatAgeNameRankings;
    end;
    valDataset = get(handles.SelectDatasetRanking_benchmark, 'value');
    valPB = get(handles.SelectPBRanking_benchmark, 'value');
    sourceRankings = 'update';
    valPool = get(handles.SelectPoolRanking_benchmark, 'value');
    SearchPool = handles.SelectPoolRankingList_benchmark{valPool};
    if strcmpi(SearchPool, 'SCM');
        SearchPool = '25';
    else;
        SearchPool = '50';
    end;   
    valDistance = get(handles.SelectDistanceRanking_benchmark, 'value');
    SearchDistance = handles.SelectDistanceRankingList_benchmark{valDistance};
    SearchDistance = SearchDistance(1:end-1);
    sourceRankingsCustom = '';
    
    valSourceTop10 = get(handles.typeRankingTop10_benchmark, 'Value');
    if valSourceTop10 == 0;
        %custom rankings
        sourceRankings = 'update';
        sourceRankingsCustom = '';
        returnval = 0;
        valDataset = 2;
        valPB = 1;
        databaseCurrentName = [];
        SearchPool = databaseCurrent{1,10};
        handles.databaseCurrent = databaseCurrent;
    
        filelistAddedCustom_benchmarkNew = [];
        filelistAddedDispCustom_benchmarkNew = [];
        iter = 1;
        for i = 1:length(list2keep);
            filelistAddedCustom_benchmarkNew{1,iter} = handles.filelistAddedCustom_benchmark(1,list2keep(i));
            filelistAddedDispCustom_benchmarkNew{1,iter} = handles.filelistAddedDispCustom_benchmark(1,list2keep(i));
            iter = iter + 1;
        end;
        handles.filelistAddedCustom_benchmark = filelistAddedCustom_benchmarkNew;
        handles.filelistAddedDispCustom_benchmark = filelistAddedDispCustom_benchmarkNew;
    end;
    sort_ranking_benchmark;
end;

