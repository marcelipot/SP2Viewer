function [] = skillpanel_analyser(varargin);


handles = guidata(gcf);


% %---Remove tooltip
% handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
% drawnow;



if isempty(handles.filelistAdded) == 1;
    if ispc == 1;
        set(handles.SkillDisplay_toggle_analyser, 'value', 0);
    end;
    return;
end;

if handles.updatedfiles == 1;
    if ispc == 1;
        set(handles.SkillDisplay_toggle_analyser, 'value', 0);
    end;
    return;
end;

if strcmpi(handles.current_toggle, 'Skill') == 1;
    if ispc == 1;
        set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    elseif ismac == 1;
        set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on');
    end;
    return;
end;

if strcmpi(handles.current_toggle, 'Splits') == 1;
    StatusEC = get(handles.AminationStatus_analyser, 'String');
    if strcmpi(StatusEC, 'Play');
        set(handles.AminationStatus_analyser, 'String', 'SkillPanel');
        if ispc == 1;
            set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
        elseif ismac == 1;
            set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on');
        end;
        return;
    end;
end;

if ispc == 1;
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 1);
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
elseif ismac == 1;
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on');
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on');
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on');
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on');
end;

handles.current_toggle = 'Skill';

origin = 'panel';
delete_allaxes_analyser;
create_emptyaxesSkill;
create_skillgraph;

% Graph1pos = get(handles.axesgraph1_analyser, 'position');
% Graph1unit = get(handles.axesgraph1_analyser, 'units');

% hwait = waitbar(0, 'Rendering...  0% ');
% WinOnTop(hwait,true);

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
set(handles.displaypanel_fluctuation_analyser, 'Visible', 'off');
set(handles.displaypanel_distribution_analyser, 'Visible', 'off');

set(handles.panelgraph_splits_analyser, 'Visible', 'off');
set(handles.txtDisplayType_analyser, 'Visible', 'off');
set(handles.showsplits_check_analyser, 'Visible', 'off');
set(handles.popupDistrance_analyser, 'Visible', 'off');
set(handles.txtdistrance_analyser, 'Visible', 'off');
set(handles.splits1D_check_analyser, 'Visible', 'off');
set(handles.splits2D_check_analyser, 'Visible', 'off');
set(handles.splits3D_check_analyser, 'Visible', 'off');
set(handles.txtRaceLap_analyser, 'Visible', 'off');
set(handles.popupRaceLap_analyser, 'Visible', 'off');
set(handles.updatesplits_button_analyser, 'Visible', 'off');
set(handles.txtDisplayOption_analyser, 'Visible', 'off');
set(handles.splitsPercentage_check_analyser, 'Visible', 'off');
set(handles.splitsTime_check_analyser, 'Visible', 'off');
set(handles.splitsOff_check_analyser, 'Visible', 'off');
set(handles.txtSplitsOption_analyser, 'Visible', 'off');
set(allchild(handles.Precedentchap_button_analyser), 'Visible', 'off');
set(allchild(handles.Precedentimage_button_analyser), 'Visible', 'off');
set(allchild(handles.Stop_button_analyser), 'Visible', 'off');
set(allchild(handles.Play_button_analyser), 'Visible', 'off');
set(allchild(handles.Suivantimage_button_analyser), 'Visible', 'off');
set(allchild(handles.Suivantchap_button_analyser), 'Visible', 'off');
set(handles.JumptoTXT_analyser, 'Visible', 'off');
set(handles.JumptoEDIT_analyser, 'Visible', 'off');
set(handles.DispTimeAnimation_analyser, 'Visible', 'off');
set(handles.panellanes3D_splits_analyser, 'Visible', 'off');
handles.actionplay_analyser = 0;
    
set(handles.panelgraph_skills1_analyser, 'Visible', 'on');
set(handles.txtoverlay_analyser, 'Visible', 'on');
set(handles.overlayyes_check_analyser, 'Visible', 'on');
set(handles.overlayno_check_analyser, 'Visible', 'on');
set(handles.txtathlete_analyser, 'Visible', 'on');
set(handles.txtturn_analyser, 'Visible', 'on');
set(handles.selectrace_pop_analyser, 'Visible', 'on');
set(handles.selectturn_pop_analyser, 'Visible', 'on');
set(handles.updateskills_button_analyser, 'Visible', 'on');

set(handles.Save_button_analyser, 'cdata', imresize(handles.icones.saveJPG_offb, [40 40]));
if ispc == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'off', 'Value', 1);
    set(handles.StrokeData_Panel_analyser, 'Visible', 'off', 'Value', 0);
    set(handles.PacingData_Panel_analyser, 'Visible', 'off', 'Value', 0);
    set(handles.SkillsData_Panel_analyser, 'Visible', 'off', 'Value', 0);
elseif ismac == 1;
    set(handles.SummaryData_Panel_analyser, 'Visible', 'off');
    set(handles.StrokeData_Panel_analyser, 'Visible', 'off');
    set(handles.PacingData_Panel_analyser, 'Visible', 'off');
    set(handles.SkillsData_Panel_analyser, 'Visible', 'off');
end;

set(handles.StrokeData_table_analyser, 'Visible', 'off');
set(handles.SkillData_table_analyser, 'Visible', 'off');
set(handles.PacingData_table_analyser, 'Visible', 'off');
set(handles.SummaryData_table_analyser, 'Visible', 'off');

handles.UpdateListGraphSkill = 0;
handles.TurnDisplaySelect = ones(nbRaces,1);

handles.UpdateListGraphSkillOverlay = 1;
handles.UpdateListGraphSkillMultiple = 1;
% close(hwait);

guidata(handles.hf_w1_welcome, handles);

