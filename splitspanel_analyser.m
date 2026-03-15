function [] = splitspanel_analyser(varargin);


handles = guidata(gcf);


% %---Remove tooltip
% handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
% drawnow;



set(handles.AminationStatus_analyser, 'String', 'Other');
% axes(handles.Play_button_analyser); imshow(handles.icones.play_offb);

if isempty(handles.filelistAdded) == 1;
    if ispc == 1;
        set(handles.SplitsDisplay_toggle_analyser, 'value', 0);
    end;
    return;
end;

if handles.updatedfiles == 1;
    if ispc == 1;
        set(handles.SplitsDisplay_toggle_analyser, 'value', 0);
    end;
    return;
end;

if strcmpi(handles.current_toggle, 'Splits') == 1;
    if ispc == 1;
        set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    elseif ismac == 1;
        set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on');
    end;
    return;
end;

if ispc == 1;
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on', 'Value', 1);
elseif ismac == 1;
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on');
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on');
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on');
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on');
end;
set(handles.panelgraph_skills1_analyser, 'Visible', 'off');

try;
    set(handles.boxpanel_analyser, 'Visible', 'off');
end;


handles.UpdateListGraphPacing = 0;
handles.current_toggle = 'Splits';

set(handles.StrokeData_table_analyser, 'Visible', 'off');
set(handles.SkillData_table_analyser, 'Visible', 'off');
set(handles.PacingData_table_analyser, 'Visible', 'off');
set(handles.SummaryData_table_analyser, 'Visible', 'off');
set(handles.panelgraph_pacing_analyser, 'Visible', 'off');

set(handles.panelgraph_skills1_analyser, 'Visible', 'off');
set(handles.txtoverlay_analyser, 'Visible', 'off');
set(handles.overlayyes_check_analyser, 'Visible', 'off');
set(handles.overlayno_check_analyser, 'Visible', 'off');
set(handles.txtathlete_analyser, 'Visible', 'off');
set(handles.txtturn_analyser, 'Visible', 'off');
set(handles.selectrace_pop_analyser, 'Visible', 'off');
set(handles.selectturn_pop_analyser, 'Visible', 'off');
set(handles.updateskills_button_analyser, 'Visible', 'off');

set(handles.panelgraph_pacing_analyser, 'Visible', 'off');
set(handles.insVelToggle_analyser, 'Visible', 'off');
set(handles.predVelToggle_analyser, 'Visible', 'off');
set(handles.flucVelToggle_analyser, 'Visible', 'off');
set(handles.txtdata_analyser, 'Visible', 'off');
set(handles.DPS_check_analyser, 'Visible', 'off');
set(handles.SR_check_analyser, 'Visible', 'off');
set(handles.Breath_check_analyser, 'Visible', 'off');
set(handles.Splits_check_analyser, 'Visible', 'off');
set(handles.txtxaxis_analyser, 'Visible', 'off');
set(handles.Distance_check_analyser, 'Visible', 'off');
set(handles.Time_check_analyser, 'Visible', 'off');
set(handles.panelzoom_pacing_analyser, 'Visible', 'off');
set(handles.displaypanel_fluctuation_analyser, 'Visible', 'off');
set(handles.displaypanel_distribution_analyser, 'Visible', 'off');

set(handles.txtmin_analyser, 'Visible', 'off');
set(handles.txtmax_analyser, 'Visible', 'off');
set(handles.txtxaxiszoom_analyser, 'Visible', 'off');
set(handles.txtDPSaxiszoom_analyser, 'Visible', 'off');
set(handles.txtSRaxiszoom_analyser, 'Visible', 'off');
set(handles.Edit_Xmin_analyser, 'Visible', 'off');
set(handles.Edit_YLeftmin_analyser, 'Visible', 'off');
set(handles.Edit_YRightmin_analyser, 'Visible', 'off');
set(handles.Edit_Xmax_analyser, 'Visible', 'off');
set(handles.Edit_YLeftmax_analyser, 'Visible', 'off');
set(handles.Edit_YRightmax_analyser, 'Visible', 'off');
set(handles.zoom_reset_analyser, 'Visible', 'off');

set(handles.Save_button_analyser, 'cdata', imresize(handles.icones.saveJPG_offb, [40 40]));
if ispc == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'off', 'Value', 0);
    set(handles.StrokeData_Panel_analyser, 'Visible', 'off', 'Value', 0);
    set(handles.PacingData_Panel_analyser, 'Visible', 'off', 'Value', 0);
    set(handles.SkillsData_Panel_analyser, 'Visible', 'off', 'Value', 0);
elseif ismac == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'off');
    set(handles.StrokeData_Panel_analyser, 'Visible', 'off');
    set(handles.PacingData_Panel_analyser, 'Visible', 'off');
    set(handles.SkillsData_Panel_analyser, 'Visible', 'off');
end;

origin = 'Splits';
delete_allaxes_analyser;
create_splitsgraph;

set(handles.panelgraph_splits_analyser, 'Visible', 'on');
set(handles.txtDisplayType_analyser, 'Visible', 'on');
set(handles.showsplits_check_analyser, 'Visible', 'on');
set(handles.popupDistrance_analyser, 'Visible', 'on');
set(handles.txtdistrance_analyser, 'Visible', 'on');
set(handles.splits1D_check_analyser, 'Visible', 'on');
set(handles.splits2D_check_analyser, 'Visible', 'on');
set(handles.splits3D_check_analyser, 'Visible', 'on');
set(handles.txtRaceLap_analyser, 'Visible', 'on');
set(handles.popupRaceLap_analyser, 'Visible', 'on');
set(handles.updatesplits_button_analyser, 'Visible', 'on');
set(handles.txtDisplayOption_analyser, 'Visible', 'on');
set(handles.splitsPercentage_check_analyser, 'Visible', 'on');
set(handles.splitsTime_check_analyser, 'Visible', 'on');
set(handles.splitsOff_check_analyser, 'Visible', 'on');
set(handles.txtSplitsOption_analyser, 'Visible', 'on');
handles.actionplay_analyser = 0;
drawnow;
% try;
%     close(hwait);
% end;

guidata(handles.hf_w1_welcome, handles);
