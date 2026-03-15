function [] = rankingpanel_benchmark(varargin);


handles = guidata(gcf);


if handles.currentBenchmarkToggle == 1;
    set(handles.ranking_toggle_benchmark, 'Value', 1);
    return;
end;

%Hide elements
if handles.currentBenchmarkToggle == 2;
    set(handles.profile_toggle_benchmark, 'Value', 0);
    set(handles.trend_toggle_benchmark, 'Value', 0);

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


    set(handles.ClearSearchProfile_benchmark, 'Visible', 'off'); 
    set(allchild(handles.ClearSearchProfile_benchmark), 'Visible', 'off');
    set(handles.ValidateSearchProfile_benchmark, 'Visible', 'off');
    set(allchild(handles.ValidateSearchProfile_benchmark), 'Visible', 'off');
    set(handles.MainProfile_benchmark, 'Visible', 'off');
    set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');
    
    set(handles.SelectSwimmerProfile_benchmark, 'Visible', 'off');
    set(handles.SelectRaceProfile_benchmark, 'Visible', 'off');
    set(handles.SelectPopulationProfile_benchmark, 'Visible', 'off');
    
elseif handles.currentBenchmarkToggle == 3;
    
end;


%Show rankings elements
set(handles.ClearSearchRanking_benchmark, 'Visible', 'on');
% set(allchild(handles.ClearSearchRanking_benchmark), 'Visible', 'on');
% set(handles.ClearSearchRanking_benchmark, 'XTick', [], 'YTick', []);
set(handles.ValidateSearchRanking_benchmark, 'Visible', 'on');
% set(allchild(handles.ValidateSearchRanking_benchmark), 'Visible', 'on');
% set(handles.ValidateSearchRanking_benchmark, 'XTick', [], 'YTick', []);
set(handles.MainRanking_benchmark, 'Visible', 'off');
set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
set(handles.SecondaryRanking_benchmark, 'Visible', 'off');
set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
set(handles.SecondaryRanking_benchmark, 'Visible', 'off');

set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');
set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');

set(handles.typeRankingTop10_benchmark, 'Visible', 'on', 'Value', 1);
set(handles.typeRankingCustom_benchmark, 'Visible', 'on', 'Value', 0);
set(handles.SelectRaceRanking_benchmark, 'Visible', 'on');
set(handles.SelectDataRanking_benchmark, 'Visible', 'on');
set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'on');

set(handles.SelectGenderRanking_benchmark, 'Value', 1);
set(handles.SelectStrokeRanking_benchmark, 'Value', 1);
set(handles.SelectDistanceRanking_benchmark, 'Value', 1);
set(handles.SelectPoolRanking_benchmark, 'Value', 1);
set(handles.SelectCategoryRanking_benchmark, 'Value', 1);
set(handles.SelectAgeRanking_benchmark, 'Value', 1);
set(handles.SelectDatasetRanking_benchmark, 'Value', 1);
set(handles.SelectMeetRanking_benchmark, 'value', 1);
set(handles.SelectTypeRanking_benchmark, 'value', 1);
set(handles.SelectSeasonRanking_benchmark, 'value', 1);
set(handles.SelectCountryRanking_benchmark, 'value', 1);
set(handles.SelectSpartaRanking_benchmark, 'value', 1);
set(handles.SelectRoundRanking_benchmark, 'value', 1);
set(handles.SelectPBRanking_benchmark, 'Value', 1);
set(handles.SelectAthleteRanking_benchmark, 'Value', 1);

set(handles.salRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
set(handles.finaRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
set(handles.displayTurnsRanking_benchmark, 'Value', 0, 'enable', 'on');
handles.selectAgeLimRanking_benchmark = 0;
handles.selectAgeRulesRanking_benchmark = 0;

set(handles.SelectCountryRanking_benchmark, 'Value', 1);
set(handles.SelectSeasonRanking_benchmark, 'Value', 1);
set(handles.SearchAthleteRanking_benchmark, 'String', '');

handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
set(handles.SelectAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', 1);
handles.existRankings = 0;

handles.currentBenchmarkToggle = 1;
handles.addPerfRanking = [];


guidata(handles.hf_w1_welcome, handles);
