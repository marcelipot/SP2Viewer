function [] = datapanel_analyser(varargin);


handles = guidata(gcf);


%---Remove tooltip
% handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
% drawnow;


if isempty(handles.filelistAdded) == 1;
    if ispc == 1;
        set(handles.DataPanel_toggle_analyser, 'value', 0);
    end;
    return;
end;

if handles.updatedfiles == 1;
    if ispc == 1;
        set(handles.DataPanel_toggle_analyser, 'value', 0);
    end;
    return;
end;

if strcmpi(handles.current_toggle, 'Data') == 1;
    if ispc == 1;
        set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 0);
    elseif ismac == 1;
        set(handles.DataPanel_toggle_analyser, 'Visible', 'on');
    end;
    return;
end;

if strcmpi(handles.current_toggle, 'Splits') == 1;
    StatusEC = get(handles.AminationStatus_analyser, 'String');
    if strcmpi(StatusEC, 'Play');
        set(handles.AminationStatus_analyser, 'String', 'DataPanel');
        if ispc == 1;
            set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 0);
        elseif ismac == 1;
            set(handles.DataPanel_toggle_analyser, 'Visible', 'on');
        end;
        return;
    end;
end;

origin = 'panel';
delete_allaxes_analyser;
reset_screen_analyser;

set(handles.Save_button_analyser, 'cdata', imresize(handles.icones.saveTab_offb, [40 40]));
if ispc == 1;
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 1);
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
elseif ismac == 1;
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on');
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on');
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on');
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on');
end;

if ispc == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'on', 'Value', 1);
    set(handles.StrokeData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.PacingData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillsData_Panel_analyser, 'Visible', 'on', 'Value', 0);
elseif ismac == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'on');
    set(handles.StrokeData_Panel_analyser, 'Visible', 'on');
    set(handles.PacingData_Panel_analyser, 'Visible', 'on');
    set(handles.SkillsData_Panel_analyser, 'Visible', 'on');
end;

try;
    set(handles.boxpanel_analyser, 'Visible', 'off');
    drawnow;
end;

create_summarytable;

handles.current_toggle = 'Data';
handles.current_panel = 'Summary';


guidata(handles.hf_w1_welcome, handles);
