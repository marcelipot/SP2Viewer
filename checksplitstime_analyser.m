function [] = checksplitstime_analyser(varargin);


handles = guidata(gcf);
StatusEC = get(handles.AminationStatus_analyser, 'String');

if get(handles.splitsTime_check_analyser, 'Value') == 0;
    set(handles.splitsTime_check_analyser, 'Value', 1);
    return;
end;

if strcmpi(StatusEC, 'Play');
    set(handles.AminationStatus_analyser, 'String', 'SplitsTime');
    val = get(handles.splitsTime_check_analyser, 'Value');
    if val == 1;
        set(handles.splitsTime_check_analyser, 'Value', 1);
        set(handles.splitsPercentage_check_analyser, 'Value', 0);
        set(handles.splitsOff_check_analyser, 'Value', 0);
    else;
        set(handles.splitsTime_check_analyser, 'Value', 1);
    end;
    return;
end;

if get(handles.splitsTime_check_analyser, 'Value') == 1;
    NewSplitstime = 1;
else;
    NewSplitstime = 0;
end;

if NewSplitstime == handles.CurrentSplitsTimePacing;
    set(handles.splitsTime_check_analyser, 'Value', 1);
    return;
end;
set(handles.splitsPercentage_check_analyser, 'Value', 0);
set(handles.splitsOff_check_analyser, 'Value', 0);
handles.CurrentSplitsPercentagePacing = 0;
handles.CurrentSplitsOffPacing = 0;

handles.CurrentSplitsTimePacing = 1;

guidata(handles.hf_w1_welcome, handles);