function [] = skillDataPanel_analyser(varargin);


handles = guidata(gcf);


%---Remove tooltip
handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
drawnow;


if isempty(handles.filelistAdded) == 1;
    return;
end;

if strcmpi(handles.current_toggle, 'Pacing') == 1 | strcmpi(handles.current_toggle, 'Skill') == 1
    if ispc == 1;
        set(handles.SkillsData_Panel_analyser, 'Visible', 'on', 'Value', 1);
    elseif ismac == 1;
        set(handles.SkillsData_Panel_analyser, 'Visible', 'on');
    end;
    return;
end;

if ispc == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.StrokeData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.PacingData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillsData_Panel_analyser, 'Visible', 'on', 'Value', 1);
elseif ismac == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'on');
    set(handles.StrokeData_Panel_analyser, 'Visible', 'on');
    set(handles.PacingData_Panel_analyser, 'Visible', 'on');
    set(handles.SkillsData_Panel_analyser, 'Visible', 'on');
end;
origin = 'table';
create_skilltableINI;

handles.current_panel = 'Skill';

guidata(handles.hf_w1_welcome, handles);