function [] = popSwimmerProfile_select(varargin);


handles2 = guidata(gcf);

filter_listRace_select;
handles2.SearchAthlete = SearchName;
guidata(gcf, handles2);
