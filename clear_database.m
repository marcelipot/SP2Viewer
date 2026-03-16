function [] = clear_database(varargin);


handles = guidata(gcf);

if isempty(handles.uidDB) == 0;
    %reset search
    handles.jCBModel.checkAll;
    handles.checkedColDisp = ones(length(handles.listDropCol),1);
    
    set(handles.popSort_database, 'value', 1);
    handles.sortbyCurrentSelection = 1;

    handles.SearchMeet = [];
    handles.SearchYear = [];
    handles.SearchName = [];
    handles.SearchMeet = [];
    handles.SearchGender = [];
    handles.SearchSwimType = [];
    handles.SearchStrokeType = [];
    handles.SearchDistance = [];
    handles.SearchPoolType = [];
    handles.SearchCategory = [];
    handles.SearchRaceType = [];
    handles.SearchAgeGroup = [];
    handles.SearchPB = [];
    
    set(handles.filteredit_meet_database, 'String', 'Meet');
    set(handles.filteredit_year_database, 'String', 'Year');
    set(handles.filteredit_name_database, 'String', 'Name');
    set(handles.filterpop_gender_database, 'Value', 1);
    set(handles.filterpop_type_database, 'Value', 1);
    set(handles.filterpop_stroke_database, 'Value', 1);
    set(handles.filterpop_distance_database, 'Value', 1);
    set(handles.filterpop_pool_database, 'Value', 1);
    set(handles.filterpop_category_database, 'Value', 1);
    set(handles.filterpop_relay_database, 'Value', 1);
    set(handles.filterpop_group_database, 'Value', 1);
    set(handles.filterpop_time_database, 'Value', 1);
    
    handles.sortbyExceptionSelection = 1;
    %Display database
    source = 'Filter';
    Disp_Database;
    
    handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
end;

guidata(handles.hf_w1_welcome, handles);