function [] = popsortingtypeRanking_benchmark(varargin);


handles = guidata(gcf);

listSeason = get(handles.SelectSeasonRanking_benchmark, 'String');
valSeason = get(handles.SelectSeasonRanking_benchmark, 'Value');
SeasonEC = listSeason{valSeason};

sourceRankings = 'new';
sourceRankingsCustom = '';
filter_ranking_benchmark;
sort_ranking_benchmark;

handles.existRankings = 1;

guidata(handles.hf_w1_welcome, handles);

