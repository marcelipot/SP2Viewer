function [] = showsplits_analyser(varargin);


handles = guidata(gcf);

StatusEC = get(handles.AminationStatus_analyser, 'String');
if strcmpi(StatusEC, 'Play');
    set(handles.AminationStatus_analyser, 'String', 'ShowSplit');
    val = get(handles.showsplits_check_analyser, 'Value');
    if val == 1;
        set(handles.showsplits_check_analyser, 'Value', 1);
    else;
        set(handles.showsplits_check_analyser, 'Value', 0);
    end;
    return;
end;

if get(handles.showsplits_check_analyser, 'Value') == 0;
    handles.CurrentvalueSplitsPacing = 0;
else;
    handles.CurrentvalueSplitsPacing = 1;
end;

if handles.CurrentvalueSplits1D == 1;
    if get(handles.splitsPercentage_check_analyser, 'Value') == 1;
        if handles.CurrentvalueSplitsPacing == 1;
            set(handles.DispSplitsPerc, 'Visible', 'on');
        else;
            set(handles.DispSplitsPerc, 'Visible', 'off');
        end;
    end;
    if get(handles.splitsTime_check_analyser, 'Value') == 1;
        if handles.CurrentvalueSplitsPacing == 1;
            set(handles.DispSplits, 'Visible', 'on');
        else;
            set(handles.DispSplits, 'Visible', 'off');
        end;
    end;
end;
if handles.CurrentvalueSplits2D == 1;
    if handles.CurrentvalueSplitsPacing == 1;
        handles.toolbarGraph2D.Visible = 'on';
    else;
        handles.toolbarGraph2D.Visible = 'off';
    end;
%     if get(handles.splitsPercentage_check_analyser, 'Value') == 1;
%         if handles.CurrentvalueSplitsPacing == 1;
%             set(handles.DispSplitsPerc, 'Visible', 'on');
%         else;
%             set(handles.DispSplitsPerc, 'Visible', 'off');
%         end;
%     end;
%     if get(handles.splitsTime_check_analyser, 'Value') == 1;
%         if handles.CurrentvalueSplitsPacing == 1;
%             set(handles.DispSplits, 'Visible', 'on');
%         else;
%             set(handles.DispSplits, 'Visible', 'off');
%         end;
%     end;
end;

if handles.CurrentvalueSplits3D == 1;
    DispSplits = handles.DispSplits;
    if handles.CurrentvalueSplitsPacing == 1;
        set(DispSplits, 'Visible', 'on');
    else;
        set(DispSplits, 'Visible', 'off');
    end;
end;


guidata(handles.hf_w1_welcome, handles);