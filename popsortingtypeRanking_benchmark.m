function [] = popsortingtypeRanking_benchmark(varargin);


handles = guidata(gcf);

databaseCurrent = handles.databaseCurrent;
MatAge = handles.MatAge;

sourceRankings = 'new';
sourceRankingsCustom = '';
returnval = 0;
valDataset = 2;
valPB = 1;
databaseCurrentName = [];
SearchPool = databaseCurrent{1,10};
SearchDistance = databaseCurrent{1,3};


sort_ranking_benchmark;
handles.databaseCurrentSort = databaseCurrentSort;
handles.existRankings = 1;

guidata(handles.hf_w1_welcome, handles);

