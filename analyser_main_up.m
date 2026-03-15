P1 = get(handles.Question_button_analyser, 'position');
P2 = get(handles.Save_button_analyser, 'position');
P3 = get(handles.Download_button_analyser, 'position');
P4 = get(handles.Arrowback_button_analyser, 'position');
P5 = get(handles.AddFile_button_analyser, 'position');
P6 = get(handles.RemoveFile_button_analyser, 'position');
P7 = get(handles.RemoveAllFile_button_analyser, 'position');
% P8 = get(handles.Reset_button_analyser, 'position');
% P9 = get(handles.Search_button_analyser, 'position');
P10 = get(handles.Fullscreen_button_analyser, 'position');
P11 = get(handles.Precedentchap_button_analyser, 'position');
P12 = get(handles.Precedentimage_button_analyser, 'position');
P13 = get(handles.Stop_button_analyser, 'position');
P14 = get(handles.Play_button_analyser, 'position');
P15 = get(handles.Suivantimage_button_analyser, 'position');
P16 = get(handles.Suivantchap_button_analyser, 'position');
P17 = get(handles.Reportpdf_button_analyser, 'position');

%---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_analyser); imshow(handles.icones.question_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     create_glossary;
% %     drawnow;
% end;

%---Save button down
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Save_button_analyser); imshow(handles.icones.downloaddata_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     
% %     drawnow;
%     origin = 'save';
%     if ispc == 1;
%         if get(handles.DataPanel_toggle_analyser, 'value') == 1;
%             saveTables_analyser;
%         end;
%         if get(handles.PacingDisplay_toggle_analyser, 'value') == 1;
%             if handles.VelGraphAct == 1;
%                 saveGraphPacing_analyser;
%             elseif handles.VelGraphAct == 2;
%                 saveGraphVelDistri_analyser
%             elseif handles.VelGraphAct == 3;
%                 saveGraphVelFluc_analyser;
%             end;
%         end;
%         if get(handles.SkillDisplay_toggle_analyser, 'value') == 1;
%             saveGraphSkills_analyser;
%         end;
%         if get(handles.SplitsDisplay_toggle_analyser, 'value') == 1;
%             if get(handles.splits1D_check_analyser, 'Value') == 1;
%                 saveGraphSplits1D_analyser;
%             end;
%             if get(handles.splits2D_check_analyser, 'Value') == 1;
%                 saveGraphSplits2D_analyser;
%             end;
%             if get(handles.splits3D_check_analyser, 'Value') == 1;
%                 herror = errordlg('Impossible to save', 'Error');
%                 if ispc == 1;
%                     MDIR = getenv('USERPROFILE');
%                     jFrame=get(handle(herror), 'javaframe');
%                     jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                     jFrame.setFigureIcon(jicon);
%                     clc;
%                 end;
%             end;
%         end;
%         
%     elseif ismac == 1;
%         
%         if strcmpi(handles.current_toggle, 'Data') == 1;
%             saveTables_analyser;
%         end;
%         if strcmpi(handles.current_toggle, 'Pacing') == 1;
%             if handles.VelGraphAct == 1;
%                 saveGraphPacing_analyser;
%             elseif handles.VelGraphAct == 2;
%                 saveGraphVelDistri_analyser;
%             elseif handles.VelGraphAct == 3;
%                 saveGraphVelFluc_analyser;
%             end;
%         end;
%         if strcmpi(handles.current_toggle, 'Skill') == 1;
%             saveGraphSkills_analyser;
%         end;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             if get(handles.splits1D_check_analyser, 'Value') == 1;
%                 saveGraphSplits1D_analyser;
%             end;
%             if get(handles.splits2D_check_analyser, 'Value') == 1;
%                 saveGraphSplits2D_analyser;
%             end;
%             if get(handles.splits3D_check_analyser, 'Value') == 1;
%                 herror = errordlg('Impossible to save', 'Error');
%             end;
%         end;
%     end;
% end;

%---Download button down
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Download_button_analyser); imshow(handles.icones.downloadraw_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     
% %     drawnow;
%     downloadRawData_analyser;
% end;

%---Full screen button down
% if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
%     axes(handles.Fullscreen_button_analyser); imshow(handles.icones.fullscreen_offb);
% %     drawnow;
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
% 
%     origin = 'fullscreen';
%     if ispc == 1;
%         if get(handles.PacingDisplay_toggle_analyser, 'value') == 1;
%             if handles.VelGraphAct == 1;
%                 saveGraphPacing_analyser;
%             elseif handles.VelGraphAct == 2;
%                 saveGraphVelDistri_analyser;
%             elseif handles.VelGraphAct == 3;
%                 saveGraphVelFluc_analyser;
%             end;
%         end;
%         if get(handles.SkillDisplay_toggle_analyser, 'value') == 1;
%             saveGraphSkills_analyser;
%         end;
%         if get(handles.SplitsDisplay_toggle_analyser, 'value') == 1;
%             if get(handles.splits1D_check_analyser, 'Value') == 1;
%                 saveGraphSplits1D_analyser;
%             end;
%             if get(handles.splits2D_check_analyser, 'Value') == 1;
%                 saveGraphSplits2D_analyser;
%             end;
%             if get(handles.splits3D_check_analyser, 'Value') == 1;
%                 herror = errordlg('Full screen display impossible', 'Error');
%                 if ispc == 1;
%                     MDIR = getenv('USERPROFILE');
%                     jFrame=get(handle(herror), 'javaframe');
%                     jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                     jFrame.setFigureIcon(jicon);
%                     clc;
%                 end;
%             end;
%         end;
%     
%     elseif ismac == 1;        
%         if strcmpi(handles.current_toggle, 'Data') == 1;
%             saveTables_analyser;
%         end;
%         if strcmpi(handles.current_toggle, 'Pacing') == 1;
%             if handles.VelGraphAct == 1;
%                 saveGraphPacing_analyser;
%             elseif handles.VelGraphAct == 2;
%                 saveGraphVelDistri_analyser;
%             elseif handles.VelGraphAct == 3;
%                 saveGraphVelFluc_analyser;
%             end;
%         end;
%         if strcmpi(handles.current_toggle, 'Skill') == 1;
%             saveGraphSkills_analyser;
%         end;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             if get(handles.splits1D_check_analyser, 'Value') == 1;
%                 saveGraphSplits1D_analyser;
%             end;
%             if get(handles.splits2D_check_analyser, 'Value') == 1;
%                 saveGraphSplits2D_analyser;
%             end;
%             if get(handles.splits3D_check_analyser, 'Value') == 1;
%                 herror = errordlg('Impossible to save', 'Error');
%             end;
%         end;
%     end;
% end;


%----------------------------Back button down------------------------------
%--------------------------------------------------------------------------
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     axes(handles.Arrowback_button_analyser); imshow(handles.icones.arrow_back_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     
% %     drawnow;
% 
%     %---Remove graph elements
%     origin = 'back';
%     delete_allaxes_analyser;
% 
%     if ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         command = ['rmdir /Q /S ' MDIR '\SP2viewer\RaceDB\Temp'];
%     else;
%         command = ['rm -rf /Applications/SP2Viewer/RaceDB/Temp'];
%     end;
%     [status, cmdout] = system(command);
%     drawnow;
% 
%     handles.filelistAdded = [];
%     set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', 1);
%     handles.RaceDistList = [];
%     handles.StrokeList = [];
%     handles.GenderList = [];
%     handles.CourseList = [];
%     handles.filelistAddedDisp = handles.filelistAdded;
%     
%     handles.updatedfiles = 1;
%     
% 
%     %---show axes analyser
%     clear_figures;
%     set(allchild(handles.Question_button_analyser), 'Visible', 'off');
% %     set(allchild(handles.Reset_button_analyser), 'Visible', 'off');
% %     set(allchild(handles.Search_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Save_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Download_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Fullscreen_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Reportpdf_button_analyser), 'Visible', 'off');
% %     set(allchild(handles.Search_button_analyser), 'Visible', 'on');
%     set(allchild(handles.Arrowback_button_analyser), 'Visible', 'off');
%     set(allchild(handles.AddFile_button_analyser), 'Visible', 'off');
% %     set(allchild(handles.Search_button_analyser), 'Visible', 'off');
%     set(allchild(handles.RemoveFile_button_analyser), 'Visible', 'off');
%     set(allchild(handles.RemoveAllFile_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Precedentchap_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Precedentimage_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Stop_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Play_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Suivantimage_button_analyser), 'Visible', 'off');
%     set(allchild(handles.Suivantchap_button_analyser), 'Visible', 'off');
%     set(handles.displaypanel_distribution_analyser, 'Visible', 'off');
%     set(handles.displaypanel_fluctuation_analyser, 'Visible', 'off');
% 
%     %---show uicontrols analyser
%     set(handles.Question_button_analyser, 'Visible', 'off');
%     set(handles.Save_button_analyser, 'Visible', 'off');
%     set(handles.Download_button_analyser, 'Visible', 'off');
%     set(handles.Fullscreen_button_analyser, 'Visible', 'off');
%     set(handles.Reportpdf_button_analyser, 'Visible', 'off');
%     set(handles.Arrowback_button_analyser, 'Visible', 'off');
%     set(handles.AddFile_button_analyser, 'Visible', 'off');
%     set(handles.RemoveFile_button_analyser, 'Visible', 'off');
%     set(handles.RemoveAllFile_button_analyser, 'Visible', 'off');
%     set(handles.Search_athletename_analyser, 'Visible', 'off', 'String', '');
%     set(handles.Search_racename_analyser, 'Visible', 'off', 'String', '');
%     set(handles.AthleteName_list_analyser, 'Visible', 'off');
%     set(handles.AthleteRace_list_analyser, 'Visible', 'off');
%     set(handles.FileAdded_list_analyser, 'Visible', 'off');
%     set(handles.display_button_analyser, 'Visible', 'off');
%     set(handles.DataPanel_toggle_analyser, 'Visible', 'off');
%     set(handles.PacingDisplay_toggle_analyser, 'Visible', 'off');
%     set(handles.SkillDisplay_toggle_analyser, 'Visible', 'off');
%     set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'off');
%     set(handles.SummaryData_table_analyser, 'Visible', 'off');
%     set(handles.PacingData_table_analyser, 'Visible', 'off');
%     set(handles.SkillData_table_analyser, 'Visible', 'off');
%     set(handles.StrokeData_table_analyser, 'Visible', 'off');
%     set(handles.SummaryData_Panel_analyser, 'Visible', 'off');
%     set(handles.PacingData_Panel_analyser, 'Visible', 'off');
%     set(handles.StrokeData_Panel_analyser, 'Visible', 'off');
%     set(handles.SkillsData_Panel_analyser, 'Visible', 'off');
%     set(handles.panelgraph_skills1_analyser, 'Visible', 'off');
%     set(handles.txtoverlay_analyser, 'Visible', 'off');
%     set(handles.overlayyes_check_analyser, 'Visible', 'off');
%     set(handles.overlayno_check_analyser, 'Visible', 'off');
%     set(handles.txtathlete_analyser, 'Visible', 'off');
%     set(handles.txtturn_analyser, 'Visible', 'off');
%     set(handles.selectrace_pop_analyser, 'Visible', 'off');
%     set(handles.selectturn_pop_analyser, 'Visible', 'off');
%     set(handles.updateskills_button_analyser, 'Visible', 'off');
%     set(handles.panelgraph_pacing_analyser, 'Visible', 'off');
%     set(handles.insVelToggle_analyser, 'Visible', 'off');
%     set(handles.predVelToggle_analyser, 'Visible', 'off');
%     set(handles.flucVelToggle_analyser, 'Visible', 'off');
%     set(handles.txtdata_analyser, 'Visible', 'off');
%     set(handles.DPS_check_analyser, 'Visible', 'off');
%     set(handles.SR_check_analyser, 'Visible', 'off');
%     set(handles.Breath_check_analyser, 'Visible', 'off');
%     set(handles.Splits_check_analyser, 'Visible', 'off');
%     set(handles.Smooth_check_analyser, 'Visible', 'off');
%     set(handles.txtxaxis_analyser, 'Visible', 'off');
%     set(handles.Distance_check_analyser, 'Visible', 'off');
%     set(handles.Time_check_analyser, 'Visible', 'off');
%     set(handles.panelzoom_pacing_analyser, 'Visible', 'off');
%     set(handles.txtmin_analyser, 'Visible', 'off');
%     set(handles.txtmax_analyser, 'Visible', 'off');
%     set(handles.txtxaxiszoom_analyser, 'Visible', 'off');
%     set(handles.txtDPSaxiszoom_analyser, 'Visible', 'off');
%     set(handles.txtSRaxiszoom_analyser, 'Visible', 'off');
%     set(handles.Edit_Xmin_analyser, 'Visible', 'off');
%     set(handles.Edit_YLeftmin_analyser, 'Visible', 'off');
%     set(handles.Edit_YRightmin_analyser, 'Visible', 'off');
%     set(handles.Edit_Xmax_analyser, 'Visible', 'off');
%     set(handles.Edit_YLeftmax_analyser, 'Visible', 'off');
%     set(handles.Edit_YRightmax_analyser, 'Visible', 'off');
%     set(handles.zoom_reset_analyser, 'Visible', 'off');
%     set(handles.panelgraph_splits_analyser, 'Visible', 'off');
%     set(handles.panelgraph_splits_analyser, 'Visible', 'off');
%     set(handles.showsplits_check_analyser, 'Visible', 'off');
%     set(handles.popupDistrance_analyser, 'Visible', 'off');
%     set(handles.txtDisplayType_analyser, 'Visible', 'off');
%     set(handles.splits1D_check_analyser, 'Visible', 'off');
%     set(handles.splits2D_check_analyser, 'Visible', 'off');
%     set(handles.splits3D_check_analyser, 'Visible', 'off');
%     set(handles.txtRaceLap_analyser, 'Visible', 'off');
%     set(handles.popupRaceLap_analyser, 'Visible', 'off');
%     set(handles.updatesplits_button_analyser, 'Visible', 'off');
%     set(handles.txtDisplayOption_analyser, 'Visible', 'off');
%     set(handles.splitsPercentage_check_analyser, 'Visible', 'off');
%     set(handles.splitsTime_check_analyser, 'Visible', 'off');
%     set(handles.splitsOff_check_analyser, 'Visible', 'off');
%     set(handles.txtSplitsOption_analyser, 'Visible', 'off');
%     set(handles.JumptoTXT_analyser, 'Visible', 'off');
%     set(handles.JumptoEDIT_analyser, 'Visible', 'off');
%     set(handles.DispTimeAnimation_analyser, 'Visible', 'off');
%     set(handles.panellanes3D_splits_analyser, 'Visible', 'off');
%     
%     
%     %---Show axes welcome
%     set(handles.logo_sparta_main, 'Visible', 'on');
%     set(allchild(handles.logo_sparta_main), 'Visible', 'on');
%     set(handles.logo_sparta_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_analyser_main, 'Visible', 'on');
%     set(allchild(handles.logo_analyser_main), 'Visible', 'on');
%     set(handles.logo_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_database_main, 'Visible', 'on');
%     set(allchild(handles.logo_database_main), 'Visible', 'on');
%     set(handles.logo_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_benchmark_main, 'Visible', 'on');
%     set(allchild(handles.logo_benchmark_main), 'Visible', 'on');
%     set(handles.logo_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_analyser_main, 'Visible', 'on');
% %     set(allchild(handles.start_analyser_main), 'Visible', 'on');
% %     set(handles.start_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_database_main, 'Visible', 'on');
% %     set(allchild(handles.start_database_main), 'Visible', 'on');
% %     set(handles.start_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_benchmark_main, 'Visible', 'on');
% %     set(allchild(handles.start_benchmark_main), 'Visible', 'on');
% %     set(handles.start_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     uistack(handles.logo_sparta_main, 'top');
%     uistack(handles.logo_analyser_main, 'top');
%     uistack(handles.logo_database_main, 'top');
%     uistack(handles.logo_benchmark_main, 'top');
%     uistack(handles.start_analyser_main, 'top');
%     uistack(handles.start_database_main, 'top');
%     uistack(handles.start_benchmark_main, 'top');
%     
%     %---Show uicontrols welcome
%     set(handles.txtlasupdate_main, 'Visible', 'on');
%     set(handles.txtsoftwareversion_main, 'Visible', 'on');
%     set(handles.txtwelcome_main, 'Visible', 'on');
%     set(handles.txtlogo_analyser_main, 'Visible', 'on');
%     set(handles.txtlogo_database_main, 'Visible', 'on');
%     set(handles.txtlogo_benchmark_main, 'Visible', 'on');
%     set(handles.tasktodo_main, 'Visible', 'on');
%     
%     set(handles.hf_w1_welcome, 'ResizeFcn', '');
%     
%     set(handles.txtpage, 'string', 'Welcome');
% end;
%--------------------------------------------------------------------------


%----------------------------Add File button down--------------------------
%--------------------------------------------------------------------------
% if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
%     axes(handles.AddFile_button_analyser); imshow(handles.icones.plus_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
% 
% %     drawnow;
%     if isempty(handles.AthleteRacelistDisp_analyser);
%         return;
%     end;
% 
%     if length(handles.filelistAdded) == 8;
%         herror = errordlg('Maximum reached', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         return;
%     end;
%     
%     fileNum = get(handles.AthleteRace_list_analyser, 'Value');
%     if isempty(handles.filelistAdded) == 1;
%         li = 1;
%     else;
%         li = length(handles.filelistAdded) + 1;
%     end;
% 
%     for i = 1:length(fileNum);
%         
%         fileEC = handles.AthleteRacelistDisp_analyser{fileNum(i)};
%         getRaceID_analyser;
% 
%         if isempty(databaseCurrent) == 0;
%             indexCB = strfind(fileEC, 'CB');
%             indexSB = strfind(fileEC, 'SB');
%             indexPB = strfind(fileEC, 'PB');
%             if isempty(indexCB) ~= 0 | isempty(indexPB) ~= 0 | isempty(indexSB) ~= 0;
%                 yearRef = databaseCurrent{1,8};
%                 meetRef = databaseCurrent{1,7};
%                 name = databaseCurrent{1,2};
%                 dist = databaseCurrent{1,3};
%                 stroke = databaseCurrent{1,4};
%                 stage = databaseCurrent{1,6};
%                 relay = databaseCurrent(1,11);
%                 relayType = databaseCurrent{1,53};
%                 if strcmpi(relay, 'Flat');
%                     fileEC = [name '_' dist stroke '_' stage '_' meetRef yearRef];
%                 else;
%                     fileEC = [name '_' dist stroke '_' stage '(R-' relayType ')_' meetRef yearRef];
%                 end;
%             end;
%             fileECnew = fileEC;
% 
%             lisearch = strfind(handles.uidDB(:,1), databaseCurrent{1,1});
%             likeepName = find(~cellfun('isempty', lisearch));
%             fileEC = handles.uidDB{likeepName,2};
%           
%             if isempty(handles.filelistAdded) == 0;
%                 for i = 1:length(handles.filelistAdded);
%                     liexist = strcmpi(handles.filelistAdded{i}, fileEC);
%                     if liexist == 1;
%                         return;
%                     end;
%                 end;
%             end;
%             
%             proceed = 1;
%             iter = 1;
%             while proceed == 1;
%                 raceCHECK = handles.uidDB{iter,2};
%                 if strcmpi(fileEC, raceCHECK) == 1;
%                     itersave = iter;
%                     proceed = 0;
%                 else;
%                     iter = iter + 1;
%                 end;
%             end;
%             RaceDistEC = handles.uidDB{itersave,4};
%             StrokeEC = handles.uidDB{itersave,5};
%             GenderEC = handles.uidDB{itersave,10};        
%             CourseEC = handles.uidDB{itersave,11};
%             
%             if length(handles.filelistAdded) >= 1;
%                 if isempty(handles.RaceDistList{1}) == 0;
%                     refli = 1;
%                 else;
%                     if isempty(handles.RaceDistList{2}) == 0;
%                         refli = 2;
%                     else;
%                         if isempty(handles.RaceDistList{3}) == 0;
%                             refli = 3;
%                         else;
%                             if isempty(handles.RaceDistList{4}) == 0;
%                                 refli = 4;
%                             else;
%                                 if isempty(handles.RaceDistList{5}) == 0;
%                                     refli = 5;
%                                 else;
%                                     if isempty(handles.RaceDistList{6}) == 0;
%                                         refli = 6;
%                                     else;
%                                         if isempty(handles.RaceDistList{7}) == 0;
%                                             refli = 7;
%                                         else;
%                                             if isempty(handles.RaceDistList{8}) == 0;
%                                                 refli = 8;
%                                             end;
%                                         end;
%                                     end;
%                                 end;
%                             end;
%                         end;
%                     end;
%                 end;
%                         
%                 if strcmpi(RaceDistEC, handles.RaceDistList{refli}) == 0;
%                     herror = errordlg('Races must be of the same distance', 'Error');
%                     if ispc == 1;
%                         MDIR = getenv('USERPROFILE');
%                         jFrame=get(handle(herror), 'javaframe');
%                         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                         jFrame.setFigureIcon(jicon);
%                         clc;
%                     end;
%                     set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
%                     handles.updatedfiles = 1;
%                     return;
%                 end;
%                 if strcmpi(StrokeEC, handles.StrokeList{refli}) == 0;
%                     herror = errordlg('Races must be of the same stroke', 'Error');
%                     if ispc == 1;
%                         MDIR = getenv('USERPROFILE');
%                         jFrame=get(handle(herror), 'javaframe');
%                         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                         jFrame.setFigureIcon(jicon);
%                         clc;
%                     end;
%                     set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
%                     handles.updatedfiles = 1;
%                     return;
%                 end;
%                 
%                 if strcmpi(GenderEC, handles.GenderList{refli}) == 0;
%                     herror = errordlg('Races must be of the same gender', 'Error');
%                     if ispc == 1;
%                         MDIR = getenv('USERPROFILE');
%                         jFrame=get(handle(herror), 'javaframe');
%                         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                         jFrame.setFigureIcon(jicon);
%                         clc;
%                     end;
%                     set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
%                     handles.updatedfiles = 1;
%                     return;
%                 end;
%                 CourseEC = num2str(CourseEC);
%                 if strcmpi(CourseEC, handles.CourseList{refli}) == 0;
%                     herror = errordlg('Cannot process LCM and SCM races together', 'Error');
%                     if ispc == 1;
%                         MDIR = getenv('USERPROFILE');
%                         jFrame=get(handle(herror), 'javaframe');
%                         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                         jFrame.setFigureIcon(jicon);
%                         clc;
%                     end;
%                     set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
%                     handles.updatedfiles = 1;
%                     return;
%                 end;
%             else;
%                 CourseEC = num2str(CourseEC);
%             end;
%             
%             
%             handles.RaceDistList{length(handles.filelistAdded)+1,1} = RaceDistEC;
%             handles.StrokeList{length(handles.filelistAdded)+1,1} = StrokeEC;
%             handles.GenderList{length(handles.filelistAdded)+1,1} = GenderEC;
%             handles.CourseList{length(handles.filelistAdded)+1,1} = CourseEC;
%             
%             handles.filelistAdded{li} = fileEC;
%             handles.filelistAddedDisp{li} = fileECnew;
%             li = length(handles.filelistAdded) + 1;
% 
% 
%             %---Remove graph elements
%             origin = 'addrace';
%             delete_allaxes_analyser;
%             reset_screen_analyser;
%             set(handles.DataPanel_toggle_analyser, 'Value', 0);
%             set(handles.PacingDisplay_toggle_analyser, 'Value', 0);
%             set(handles.SkillDisplay_toggle_analyser, 'Value', 0);
%             set(handles.SplitsDisplay_toggle_analyser, 'Value', 0);
%             set(handles.SummaryData_Panel_analyser, 'Visible', 'off', 'Value', 1);
%             set(handles.StrokeData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%             set(handles.PacingData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%             set(handles.SkillsData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%             drawnow;
%         
%             set(handles.FileAdded_list_analyser, 'String', handles.filelistAddedDisp, 'Value', length(handles.filelistAdded));
%             handles.updatedfiles = 1;
%         end;
%     end;
% end;
%--------------------------------------------------------------------------


%--------------------------Remove File button down-------------------------
%--------------------------------------------------------------------------
% if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
%     axes(handles.RemoveFile_button_analyser); imshow(handles.icones.minus_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     
% %     drawnow;
% 
%     if isempty(handles.filelistAdded) == 1;
%         return;
%     end;
% 
%     %---Remove graph elements
%     origin = 'removerace';
%     delete_allaxes_analyser;
%     reset_screen_analyser;
%     set(handles.DataPanel_toggle_analyser, 'Value', 0);
%     set(handles.PacingDisplay_toggle_analyser, 'Value', 0);
%     set(handles.SkillDisplay_toggle_analyser, 'Value', 0);
%     set(handles.SplitsDisplay_toggle_analyser, 'Value', 0);
%     set(handles.SummaryData_Panel_analyser, 'Visible', 'off', 'Value', 1);
%     set(handles.StrokeData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%     set(handles.PacingData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%     set(handles.SkillsData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%     drawnow;
% 
%     fileNum = get(handles.FileAdded_list_analyser, 'Value');
% 
%     if length(handles.filelistAdded) == 1;
%         handles.filelistAdded = [];
%         set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', 1);
%         handles.RaceDistList = [];
%         handles.StrokeList = [];
%         handles.GenderList = [];
%         handles.CourseList = [];
%     else;
%         iter = 1;
%         filelistAddedNew = {};
%         for i = 1:length(handles.filelistAdded);
%             if i ~= fileNum;
%                 filelistAddedNew{iter} = handles.filelistAdded{i};
%                 iter = iter + 1;
%             end;
%         end;
%         handles.filelistAdded = filelistAddedNew;
%         handles.RaceDistList{fileNum,:} = [];
%         handles.StrokeList{fileNum,:} = [];
%         handles.GenderList{fileNum,:} = [];
%         handles.CourseList{fileNum,:} = [];
%         set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', 1);
%     end;
%     handles.filelistAddedDisp = handles.filelistAdded;
%     
%     handles.updatedfiles = 1;
% end;
%--------------------------------------------------------------------------


%-----------------------Remove All Files button down-----------------------
%--------------------------------------------------------------------------
% if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
%     axes(handles.RemoveAllFile_button_analyser); imshow(handles.icones.redcross_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     
% %     drawnow;
% 
%     if isempty(handles.filelistAdded) == 1;
%         return;
%     end;
% 
%     %---Remove graph elements
%     origin = 'removeallraces';
%     delete_allaxes_analyser;
%     reset_screen_analyser;
%     set(handles.DataPanel_toggle_analyser, 'Value', 0);
%     set(handles.PacingDisplay_toggle_analyser, 'Value', 0);
%     set(handles.SkillDisplay_toggle_analyser, 'Value', 0);
%     set(handles.SplitsDisplay_toggle_analyser, 'Value', 0);
%     set(handles.SummaryData_Panel_analyser, 'Visible', 'off', 'Value', 1);
%     set(handles.StrokeData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%     set(handles.PacingData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%     set(handles.SkillsData_Panel_analyser, 'Visible', 'off', 'Value', 0);
%     drawnow;
% 
%     handles.filelistAdded = [];
%     set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', 1);
%     handles.RaceDistList = [];
%     handles.StrokeList = [];
%     handles.GenderList = [];
%     handles.CourseList = [];
%     handles.filelistAddedDisp = handles.filelistAdded;
%     
%     handles.updatedfiles = 1;
% end;
%--------------------------------------------------------------------------


% %------------------------------Reset button down---------------------------
% if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
%     axes(handles.Reset_button_analyser); imshow(handles.icones.reset_offb);
%     set(handles.AminationStatus_analyser, 'String', 'Other');
%     
%     if length(handles.uidDB) == 0;
%         handles.filelist = [];
%         set(handles.CurrentFolder_list_analyser, 'string', handles.filelist);
%     else;
%         race = length(handles.uidDB(:,1));
%         for i = 1:race;
%             raceEC = handles.uidDB{i,2};
%             filelist{i} = raceEC;
%         end;
%         handles.filelist = sort(filelist);
%         set(handles.CurrentFolder_list_analyser, 'string', handles.filelist, 'value', 1);
%     end;
%     
% %     drawnow;
% end;
% %--------------------------------------------------------------------------
% 
% 
% %------------------------------Search button down--------------------------
% if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
%     axes(handles.Search_button_analyser); imshow(handles.icones.search_offb);
%     if isfield(handles, 'current_toggle') == 1;
%         if strcmpi(handles.current_toggle, 'Splits') == 1;
%             StatusEC = get(handles.AminationStatus_analyser, 'String');
%             if strcmpi(StatusEC, 'Play');
%                 set(handles.AminationStatus_analyser, 'String', 'Other');
%                 return;
%             end;
%         end;
%     end;
%     
%     res = create_searchtool;
%     database = res.FullDBTab;
%     if isempty(database) == 1;
%         database = handles.FullDB;
%     end;
%     database = database(:,1);
%     race = length(database(:,1));
%     iter = 1;
%     for i = 2:race;
%         raceEC = database{i,1};
%         lirace = find(strcmpi(handles.uidDB(:,1), raceEC) == 1);
%         if isempty(lirace) == 0;
%             raceEC = handles.uidDB{lirace,2};
%             filelist{iter} = raceEC;
%             iter = iter + 1;
%         end;
%     end;
%     handles.filelist = sort(filelist);
%     set(handles.CurrentFolder_list_analyser, 'string', handles.filelist, 'value', 1);
% end;
% %--------------------------------------------------------------------------


%------------------------------Precentchap button up--------------------------
% if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
%     axes(handles.Precedentchap_button_analyser); imshow(handles.icones.precedentchap_offb);
% %     drawnow;
%     splits3D_PrevSplit_analyser;
% end;
%--------------------------------------------------------------------------

%------------------------------Precentimage button up--------------------------
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     axes(handles.Precedentimage_button_analyser); imshow(handles.icones.precedentimage_offb);
% %     drawnow;
%     splits3D_PrevFrame_analyser;
% end;
%--------------------------------------------------------------------------

%------------------------------Stop button up--------------------------
% if pt(1,1) >= P13(1,1) & pt(1,1) <= (P13(1,1)+P13(1,3)) & pt(1,2) >= P13(1,2) & pt(1,2) <= (P13(1,2)+P13(1,4));
%     axes(handles.Stop_button_analyser); imshow(handles.icones.stop_offb);
% %     drawnow;
%     splits3D_Stop_analyser;
% end;
%--------------------------------------------------------------------------

%------------------------------Play button up--------------------------
% if pt(1,1) >= P14(1,1) & pt(1,1) <= (P14(1,1)+P14(1,3)) & pt(1,2) >= P14(1,2) & pt(1,2) <= (P14(1,2)+P14(1,4));
%     StatusEC = get(handles.AminationStatus_analyser, 'String');
%     if strcmpi(StatusEC, 'Play') == 0;
%         %the video is stopped and now launched
%         axes(handles.Play_button_analyser); imshow(handles.icones.pause_offb);
%         set(handles.AminationStatus_analyser, 'String', 'Play');
% %         drawnow;
%         splits3D_Play_analyser;
%     else;
%         %the video is running and now stopped
%         axes(handles.Play_button_analyser); imshow(handles.icones.play_offb);
%         set(handles.AminationStatus_analyser, 'String', 'Pause');
% %         drawnow;
%     end;
% end;
%--------------------------------------------------------------------------

%------------------------------Suivantimage button up--------------------------
% if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
%     axes(handles.Suivantimage_button_analyser); imshow(handles.icones.suivant_offb);
% %     drawnow;
%     splits3D_NextFrame_analyser;
% end;
%--------------------------------------------------------------------------

%------------------------------suivantchap button up--------------------------
% if pt(1,1) >= P16(1,1) & pt(1,1) <= (P16(1,1)+P16(1,3)) & pt(1,2) >= P16(1,2) & pt(1,2) <= (P16(1,2)+P16(1,4));
%     axes(handles.Suivantchap_button_analyser); imshow(handles.icones.suivantchap_offb);
% %     drawnow;
%     splits3D_NextSplit_analyser;
% end;
%--------------------------------------------------------------------------

%----------------------------Report pdf button down------------------------
% if pt(1,1) >= P17(1,1) & pt(1,1) <= (P17(1,1)+P17(1,3)) & pt(1,2) >= P17(1,2) & pt(1,2) <= (P17(1,2)+P17(1,4));
%     axes(handles.Reportpdf_button_analyser); imshow(handles.icones.report_offb);
%     savePdf_analyser;
% %     drawnow;
% %     if ispc == 1;
% %         
% %     elseif ismac == 1;
% %         
% %     end;
% end;
%--------------------------------------------------------------------------

