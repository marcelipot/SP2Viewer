function [] = checksplitspercentage_analyser(varargin);


handles = guidata(gcf);
StatusEC = get(handles.AminationStatus_analyser, 'String');

if get(handles.splitsPercentage_check_analyser, 'Value') == 0;
    set(handles.splitsPercentage_check_analyser, 'Value', 1);
    return;
end;

if strcmpi(StatusEC, 'Play');
    set(handles.AminationStatus_analyser, 'String', 'SplitsPercentage');
    val = get(handles.splitsPercentage_check_analyser, 'Value');
    if val == 1;
        set(handles.splitsPercentage_check_analyser, 'Value', 1);
        set(handles.splitsOff_check_analyser, 'Value', 0);
        set(handles.splitsTime_check_analyser, 'Value', 0);
    else;
        set(handles.splitsPercentage_check_analyser, 'Value', 1);
    end;
    return;
end;

if get(handles.splitsPercentage_check_analyser, 'Value') == 1;
    NewSplitspercentage = 1;
else;
    NewSplitspercentage = 0;
end;

if NewSplitspercentage == handles.CurrentSplitsPercentagePacing;
    set(handles.splitsPercentage_check_analyser, 'Value', 1);
    return;
end;
set(handles.splitsTime_check_analyser, 'Value', 0);
set(handles.splitsOff_check_analyser, 'Value', 0);
handles.CurrentSplitsTimePacing = 0;
handles.CurrentSplitsOffPacing = 0;

handles.CurrentSplitsPercentagePacing = 1;

guidata(handles.hf_w1_welcome, handles);