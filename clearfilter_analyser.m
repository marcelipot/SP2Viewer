function [] = clearfilter_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);

handles2.SearchMeet = [];
handles2.SearchYear = [];
handles2.SearchName = [];
handles2.SearchMeet = [];
handles2.SearchGender = [];
handles2.SearchSwimType = [];
handles2.SearchStrokeType = [];
handles2.SearchDistance = [];
handles2.SearchPoolType = [];
handles2.SearchCategory = [];
handles2.SearchRaceType = [];
handles2.SearchAgeGroup = [];
handles2.SearchPB = [];

set(handles2.filteredit_meet_analyser, 'String', 'Meet');
set(handles2.filteredit_year_analyser, 'String', 'Year');
set(handles2.filteredit_name_analyser, 'String', 'Name');
set(handles2.filterpop_gender_analyser, 'Value', 1);
set(handles2.filterpop_type_analyser, 'Value', 1);
set(handles2.filterpop_stroke_analyser, 'Value', 1);
set(handles2.filterpop_distance_analyser, 'Value', 1);
set(handles2.filterpop_pool_analyser, 'Value', 1);
set(handles2.filterpop_category_analyser, 'Value', 1);
set(handles2.filterpop_relay_analyser, 'Value', 1);
set(handles2.filterpop_group_analyser, 'Value', 1);
set(handles2.filterpop_time_analyser, 'Value', 1);

Disp_Database_analyser;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);


