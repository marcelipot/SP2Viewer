function [] = popSwimmerRanking_select(varargin);


handles2 = guidata(gcf);
filter_listRaceRanking_select;

handles2.SearchAthlete = SearchName;

guidata(gcf, handles2);
