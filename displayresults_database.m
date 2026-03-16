function [] = displayresults_database(varargin);


handles = guidata(gcf);
handles.selectionDisplayResults = get(handles.popDisplayResults_database, 'value');

%display database
handles.sortbyExceptionSelection = 0;
source = 'Filter';
Disp_Database;
handles.sortbyExceptionSelection = 1;

guidata(handles.hf_w1_welcome, handles);
