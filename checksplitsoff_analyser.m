function [] = checksplitsoff_analyser(varargin);


handles = guidata(gcf);


if get(handles.splits1D_check_analyser, 'Value') == 1;
    set(handles.splitsOff_check_analyser, 'Value', 0);
    herror = errordlg('Option disabled', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    return;
end;
if get(handles.splits2D_check_analyser, 'Value') == 1;
    set(handles.splitsOff_check_analyser, 'Value', 0);
    herror = errordlg('Option disabled', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    return;
end;


if get(handles.splitsOff_check_analyser, 'Value') == 0;
    set(handles.splitsOff_check_analyser, 'Value', 1);
    return;
end;

StatusEC = get(handles.AminationStatus_analyser, 'String');
if strcmpi(StatusEC, 'Play');
    set(handles.AminationStatus_analyser, 'String', 'SplitsOff');
    val = get(handles.splitsOff_check_analyser, 'Value');
    if val == 1;
        set(handles.splitsOff_check_analyser, 'Value', 1);
        set(handles.splitsTime_check_analyser, 'Value', 0);
        set(handles.splitsPercentage_check_analyser, 'Value', 0);
    else;
        set(handles.splitsOff_check_analyser, 'Value', 0);
    end;
    return;
end;

if get(handles.splitsOff_check_analyser, 'Value') == 1;
    NewSplitsoff = 1;
else;
    NewSplitsoff = 0;
end;

if NewSplitsoff == handles.CurrentSplitsOffPacing;
    set(handles.splitsOff_check_analyser, 'Value', 1);
    return;
end;
set(handles.splitsTime_check_analyser, 'Value', 0);
set(handles.splitsPercentage_check_analyser, 'Value', 0);
handles.CurrentSplitsTimePacing = 0;
handles.CurrentSplitsPercentagePacing = 0;

handles.CurrentSplitsOffPacing = 1;

guidata(handles.hf_w1_welcome, handles);