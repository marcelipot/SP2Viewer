function [] = return2menu_analyser(varargin);


handles = guidata(gcf);


if isfield(handles, 'current_toggle') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        StatusEC = get(handles.AminationStatus_analyser, 'String');
        if strcmpi(StatusEC, 'Play');
            set(handles.AminationStatus_analyser, 'String', 'Other');
            return;
        end;
    end;
end;

%     drawnow;

%---Remove graph elements
origin = 'back';
delete_allaxes_analyser;

if ispc == 1;
    MDIR = getenv('USERPROFILE');
    command = ['rmdir /Q /S ' MDIR '\SP2viewer\RaceDB\Temp'];
else;
    command = ['rm -rf /Applications/SP2Viewer/RaceDB/Temp'];
end;
[status, cmdout] = system(command);
drawnow;

handles.filelistAdded = [];
set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', 1);
handles.RaceDistList = [];
handles.StrokeList = [];
handles.GenderList = [];
handles.CourseList = [];
handles.filelistAddedDisp = handles.filelistAdded;

handles.updatedfiles = 1;


%---show axes analyser
clear_figures;
set(allchild(handles.Question_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Reset_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Search_button_analyser), 'Visible', 'off');
set(allchild(handles.Save_button_analyser), 'Visible', 'off');
set(allchild(handles.Download_button_analyser), 'Visible', 'off');
set(allchild(handles.Fullscreen_button_analyser), 'Visible', 'off');
set(allchild(handles.Reportpdf_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Search_button_analyser), 'Visible', 'on');
set(allchild(handles.Arrowback_button_analyser), 'Visible', 'off');
set(allchild(handles.AddFile_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Search_button_analyser), 'Visible', 'off');
set(allchild(handles.RemoveFile_button_analyser), 'Visible', 'off');
set(allchild(handles.RemoveAllFile_button_analyser), 'Visible', 'off');
set(allchild(handles.Precedentchap_button_analyser), 'Visible', 'off');
set(allchild(handles.Precedentimage_button_analyser), 'Visible', 'off');
set(allchild(handles.Stop_button_analyser), 'Visible', 'off');
set(allchild(handles.Play_button_analyser), 'Visible', 'off');
set(allchild(handles.Suivantimage_button_analyser), 'Visible', 'off');
set(allchild(handles.Suivantchap_button_analyser), 'Visible', 'off');
set(handles.displaypanel_distribution_analyser, 'Visible', 'off');
set(handles.displaypanel_fluctuation_analyser, 'Visible', 'off');

%---show uicontrols analyser
set(handles.Question_button_analyser, 'Visible', 'off');
set(handles.Save_button_analyser, 'Visible', 'off');
set(handles.Download_button_analyser, 'Visible', 'off');
set(handles.Fullscreen_button_analyser, 'Visible', 'off');
set(handles.Reportpdf_button_analyser, 'Visible', 'off');
set(handles.Arrowback_button_analyser, 'Visible', 'off');
set(handles.AddFile_button_analyser, 'Visible', 'off');
set(handles.RemoveFile_button_analyser, 'Visible', 'off');
set(handles.RemoveAllFile_button_analyser, 'Visible', 'off');
set(handles.Search_athletename_analyser, 'Visible', 'off', 'String', '');
set(handles.Search_racename_analyser, 'Visible', 'off', 'String', '');
set(handles.AthleteName_list_analyser, 'Visible', 'off');
set(handles.AthleteRace_list_analyser, 'Visible', 'off');
set(handles.FileAdded_list_analyser, 'Visible', 'off');
set(handles.display_button_analyser, 'Visible', 'off');
set(handles.DataPanel_toggle_analyser, 'Visible', 'off');
set(handles.PacingDisplay_toggle_analyser, 'Visible', 'off');
set(handles.SkillDisplay_toggle_analyser, 'Visible', 'off');
set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'off');
set(handles.SummaryData_table_analyser, 'Visible', 'off');
set(handles.PacingData_table_analyser, 'Visible', 'off');
set(handles.SkillData_table_analyser, 'Visible', 'off');
set(handles.StrokeData_table_analyser, 'Visible', 'off');
set(handles.SummaryData_Panel_analyser, 'Visible', 'off');
set(handles.PacingData_Panel_analyser, 'Visible', 'off');
set(handles.StrokeData_Panel_analyser, 'Visible', 'off');
set(handles.SkillsData_Panel_analyser, 'Visible', 'off');
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
set(handles.Smooth_check_analyser, 'Visible', 'off');
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
set(handles.panelgraph_splits_analyser, 'Visible', 'off');
set(handles.panelgraph_splits_analyser, 'Visible', 'off');
set(handles.showsplits_check_analyser, 'Visible', 'off');
set(handles.popupDistrance_analyser, 'Visible', 'off');
set(handles.txtDisplayType_analyser, 'Visible', 'off');
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
set(handles.JumptoTXT_analyser, 'Visible', 'off');
set(handles.JumptoEDIT_analyser, 'Visible', 'off');
set(handles.DispTimeAnimation_analyser, 'Visible', 'off');
set(handles.panellanes3D_splits_analyser, 'Visible', 'off');


%---Show axes welcome
set(handles.logo_sparta_main, 'Visible', 'on');
set(allchild(handles.logo_sparta_main), 'Visible', 'on');
set(handles.logo_sparta_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.logo_analyser_main, 'Visible', 'on');
set(allchild(handles.logo_analyser_main), 'Visible', 'on');
set(handles.logo_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.logo_database_main, 'Visible', 'on');
set(allchild(handles.logo_database_main), 'Visible', 'on');
set(handles.logo_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.logo_benchmark_main, 'Visible', 'on');
set(allchild(handles.logo_benchmark_main), 'Visible', 'on');
set(handles.logo_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.start_analyser_main, 'Visible', 'on');
%     set(allchild(handles.start_analyser_main), 'Visible', 'on');
%     set(handles.start_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.start_database_main, 'Visible', 'on');
%     set(allchild(handles.start_database_main), 'Visible', 'on');
%     set(handles.start_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.start_benchmark_main, 'Visible', 'on');
%     set(allchild(handles.start_benchmark_main), 'Visible', 'on');
%     set(handles.start_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
uistack(handles.logo_sparta_main, 'top');
uistack(handles.logo_analyser_main, 'top');
uistack(handles.logo_database_main, 'top');
uistack(handles.logo_benchmark_main, 'top');
uistack(handles.start_analyser_main, 'top');
uistack(handles.start_database_main, 'top');
uistack(handles.start_benchmark_main, 'top');

%---Show uicontrols welcome
set(handles.txtlasupdate_main, 'Visible', 'on');
set(handles.txtsoftwareversion_main, 'Visible', 'on');
set(handles.txtwelcome_main, 'Visible', 'on');
set(handles.txtlogo_analyser_main, 'Visible', 'on');
set(handles.txtlogo_database_main, 'Visible', 'on');
set(handles.txtlogo_benchmark_main, 'Visible', 'on');
set(handles.tasktodo_main, 'Visible', 'on');

set(handles.hf_w1_welcome, 'ResizeFcn', '');

set(handles.txtpage, 'string', 'Welcome');



guidata(handles.hf_w1_welcome, handles);
