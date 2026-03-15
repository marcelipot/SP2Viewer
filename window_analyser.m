
% %------------------Create the popup window warming and error---------------
% window_popupwarning;
% %-----------------------------------------------------------------------


% set(handles.txtpage, 'string', 'Analyser');

%---create ask icone
handles.Question_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [10, 685, 30, 30], 'callback', @questionMarks_analyser, 'cdata', imresize(handles.icones.question_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Question_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Show definitions');

%---create pdf icone
handles.Reportpdf_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [45, 685, 30, 30], 'callback', @savePdf_analyser, 'cdata', imresize(handles.icones.saveReport_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Reportpdf_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Create Sparta reports');

%---create save icone
handles.Save_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [80, 685, 30, 30], 'callback', @saveDisplay_analyser, 'cdata', imresize(handles.icones.saveTab_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Save_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Save data / graph');

%---create download icone
handles.Download_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [115, 685, 30, 30], 'callback', @downloadRawData_analyser, 'cdata', imresize(handles.icones.saveRaw_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Download_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Download raw data');

%---create fullscreen icon
handles.Fullscreen_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [150, 685, 30, 30], 'callback', @fullScreenMode_analyser, 'cdata', imresize(handles.icones.fullscreen_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Fullscreen_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Full screen mode');

%---create arrow back icone
handles.Arrowback_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1245, 685, 30, 30], 'callback', @return2menu_analyser, 'cdata', imresize(handles.icones.arrow_back_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Arrowback_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Return to selection menu');



% %---Display button
% if ispc == 1;
%     font1 = 12;
%     font2 = 10;
%     font3 = 11;
%     font4 = 9;
% elseif ismac == 1;
%     font1 = 15;
%     font2 = 13;
%     font3 = 13.5;
%     font4 = 6.5;
% end;

% %---create search icon
% handles.Search_button_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [55, 645, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.search_offb);
% 
% %---create reset icon
% handles.Reset_button_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [95, 645, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.reset_offb);

%---create list athlete
handles.AthleteName_list_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Listbox', 'Visible', 'off', 'units', 'pixels', 'position', [5, 510, 170, 135], ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'max', 1, 'min', 1, ...
    'callback', @listAthleteName_analyser);
% set(handles.CurrentFolder_list_analyser, 'fontunits', 'normalized');

%---create search name
handles.Search_athletename_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 485, 170, 20], 'Callback', @searchathletename_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '');
set(handles.Search_athletename_analyser, 'fontunits', 'normalized');

%---create list races
handles.AthleteRace_list_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Listbox', 'Visible', 'off', 'units', 'pixels', 'position', [5, 295, 170, 185], ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4-1, 'max', 1, 'min', 1, ...
    'Callback', @listRaceName_analyser);
% set(handles.CurrentFolder_list_analyser, 'fontunits', 'normalized');

%---create search race
handles.Search_racename_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 270, 170, 20], 'Callback', @searchathleterace_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '');
set(handles.Search_racename_analyser, 'fontunits', 'normalized');

%---create list 
handles.FileAdded_list_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Listbox', 'Visible', 'off', 'units', 'pixels', 'position', [5, 120, 170, 100], ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4-1, ...
    'Callback', @listRaceAdded_analyser);
% set(handles.CurrentFolder_list_analyser, 'fontunits', 'normalized');

%---create add icone
handles.AddFile_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [40, 225, 30, 30], 'callback', @addRaceList_analyser, 'cdata', imresize(handles.icones.plus_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.AddFile_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Add a race');

%---create remove icone
handles.RemoveFile_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [75, 225, 30, 30], 'callback', @removeRaceList_analyser, 'cdata', imresize(handles.icones.minus_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.RemoveFile_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Remove a race');

%---create remove all icone
handles.RemoveAllFile_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [110, 225, 30, 30], 'callback', @removeallRaceList_analyser, 'cdata', imresize(handles.icones.redcross_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.RemoveAllFile_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Remove all races');


handles.display_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [32.5, 75, 120, 40], 'callback', @displaydata_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Display');
set(handles.display_button_analyser, 'fontunits', 'normalized');




if ismac == 1;
    %---create data panel button
    handles.DataPanel_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [180, 645, 125, 33], 'callback', @datapanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 15, 'String', 'Data Panel');

    %---create data panel button
    handles.PacingDisplay_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [306, 645, 125, 33], 'callback', @pacingpanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 15, 'String', 'Velocity');
    
    %---create data panel button
    handles.SplitsDisplay_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [432, 645, 125, 33], 'callback', @splitspanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 15, 'String', 'Pacing');

    %---create data panel button
    handles.SkillDisplay_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [558, 645, 125, 33], 'callback', @skillpanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 15, 'String', 'Skills');
    
elseif ispc == 1;
    %---create data panel button
    handles.DataPanel_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [180, 645, 125, 33], 'callback', @datapanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'String', 'Data Panel');
    
    %---create data panel button
    handles.PacingDisplay_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [306, 645, 125, 33], 'callback', @pacingpanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'String', 'Velocity');
    
    %---create data panel button
    handles.SplitsDisplay_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [432, 645, 125, 33], 'callback', @splitspanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'String', 'Pacing');

    %---create data panel button
    handles.SkillDisplay_toggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [558, 645, 125, 33], 'callback', @skillpanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'String', 'Skills');
end;


set(handles.DataPanel_toggle_analyser, 'fontunits', 'normalized');
set(handles.PacingDisplay_toggle_analyser, 'fontunits', 'normalized');
set(handles.SplitsDisplay_toggle_analyser, 'fontunits', 'normalized');
set(handles.SkillDisplay_toggle_analyser, 'fontunits', 'normalized');

%---create summary table
handles.SummaryData_table_analyser = uitable('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', font2, ...
    'FontWeight', 'Bold', 'position', [180 5 875 635], 'ColumnEditable', false, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');
% set(handles.SummaryData_table_analyser, 'fontunits', 'normalized');
handles.diffPosSummaryTable = 0;
handles.PosINI_SummaryTable = 875./1280;
handles.TopINI_SummaryTable = (5+635)./720;

%---create Pacing table
handles.PacingData_table_analyser = uitable('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', font2, ...
    'FontWeight', 'Bold', 'position', [180 5 875 635], 'ColumnEditable', false, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');
% set(handles.PacingData_table_analyser, 'fontunits', 'normalized');
handles.diffPosPacingTable = 0;
handles.PosINI_PacingTable = 875./1280;
handles.TopINI_PacingTable = (5+635)./720;

%---create skill table
handles.SkillData_table_analyser = uitable('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', font2, ...
    'FontWeight', 'Bold', 'position', [180 5 875 635], 'ColumnEditable', false, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');
% set(handles.SkillData_table_analyser, 'fontunits', 'normalized');
handles.diffPosSkillTable = 0;
handles.PosINI_SkillTable = 875./1280;
handles.TopINI_SkillTable = (5+635)./720;

%---create stroke table
handles.StrokeData_table_analyser = uitable('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', font2, ...
    'FontWeight', 'Bold', 'position', [180 5 875 635], 'ColumnEditable', false, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');
% set(handles.StrokeData_table_analyser, 'fontunits', 'normalized');
handles.diffPosStrokeTable = 0;
handles.PosINI_StrokeTable = 875./1280;
handles.TopINI_StrokeTable = (5+635)./720;


if ismac == 1;
    %---create summary data panel button
    handles.SummaryData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1070, 124, 100, 33], 'callback', @summaryDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Summary');
    set(handles.SummaryData_Panel_analyser, 'fontunits', 'normalized');

    %---create stroke data panel button
    handles.StrokeData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1171, 124, 100, 33], 'callback', @strokeDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Stroke');
    set(handles.StrokeData_Panel_analyser, 'fontunits', 'normalized');

    %---create pacing data panel button
    handles.PacingData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1070, 90, 100, 33], 'callback', @pacingDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Pacing');
    set(handles.PacingData_Panel_analyser, 'fontunits', 'normalized');

    %---create skill data panel button
    handles.SkillsData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1171, 90, 100, 33], 'callback', @skillDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Skill');
    set(handles.SkillsData_Panel_analyser, 'fontunits', 'normalized');
    
elseif ispc == 1;
    %---create summary data panel button
    handles.SummaryData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1070, 124, 100, 33], 'callback', @summaryDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Summary');
    set(handles.SummaryData_Panel_analyser, 'fontunits', 'normalized');

    %---create stroke data panel button
    handles.StrokeData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1171, 124, 100, 33], 'callback', @strokeDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Stroke');
    set(handles.StrokeData_Panel_analyser, 'fontunits', 'normalized');

    %---create pacing data panel button
    handles.PacingData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1070, 90, 100, 33], 'callback', @pacingDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Pacing');
    set(handles.PacingData_Panel_analyser, 'fontunits', 'normalized');

    %---create skill data panel button
    handles.SkillsData_Panel_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [1171, 90, 100, 33], 'callback', @skillDataPanel_analyser, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Skill');
    set(handles.SkillsData_Panel_analyser, 'fontunits', 'normalized');
end;




%---create skill option panel button
handles.panelgraph_skills1_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [960, 570, 318, 110], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'Title', 'Skill Display Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.panelgraph_skills1_analyser, 'fontunits', 'normalized');

%---create txt overlay
handles.txtoverlay_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [40, 65, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Overlay data :');
set(handles.txtoverlay_analyser, 'fontunits', 'normalized');

%---Create checkbox yes
handles.overlayyes_check_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [150, 65, 50, 20], 'value', 0, 'callback', @checkyes_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Yes');
set(handles.overlayyes_check_analyser, 'fontunits', 'normalized');

%---Create checkbox no
handles.overlayno_check_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [225, 65, 50, 20], 'value', 0, 'callback', @checkno_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'No');
set(handles.overlayno_check_analyser, 'fontunits', 'normalized');

%---create txt athlete
handles.txtathlete_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 35, 55, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Athlete :');
set(handles.txtathlete_analyser, 'fontunits', 'normalized');

%---create txt Turn
handles.txtturn_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 10, 55, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Turn :');
set(handles.txtturn_analyser, 'fontunits', 'normalized');

%---create popup menu athlete
if ispc == 1;
    handles.selectrace_pop_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [60, 35, 170, 20], 'string', 'None', 'callback', @popupathlete_analyser, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.selectrace_pop_analyser, 'fontunits', 'normalized');

    %---create popup menu turn
    handles.selectturn_pop_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [60, 10, 170, 20], 'string', 'None', 'callback', @popupturn_analyser, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.selectturn_pop_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
     handles.selectrace_pop_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [60, 35, 170, 20], 'string', 'None', 'callback', @popupathlete_analyser, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.selectrace_pop_analyser, 'fontunits', 'normalized');

    %---create popup menu turn
    handles.selectturn_pop_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [60, 10, 170, 20], 'string', 'None', 'callback', @popupturn_analyser, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.selectturn_pop_analyser, 'fontunits', 'normalized');
end;


%---update button
handles.updateskills_button_analyser = uicontrol('parent', handles.panelgraph_skills1_analyser, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [235, 20, 75, 25], 'callback', @updateskills_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Update');
set(handles.updateskills_button_analyser, 'fontunits', 'normalized');





%---create velocity display option panel
handles.insVelToggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1080, 640, 190, 30], 'Callback', @insVelToggle_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Instantaneous');
set(handles.insVelToggle_analyser, 'fontunits', 'normalized');

handles.predVelToggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1080, 605, 190, 30], 'Callback', @predVelToggle_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Distribution');
set(handles.predVelToggle_analyser, 'fontunits', 'normalized');

handles.flucVelToggle_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1080, 570, 190, 30], 'Callback', @flucVelToggle_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Crests & Troughs');
set(handles.flucVelToggle_analyser, 'fontunits', 'normalized');


handles.panelgraph_pacing_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [1070, 400, 205, 150], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Pacing displays', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.panelgraph_pacing_analyser, 'fontunits', 'normalized');

%---create txt data
handles.txtdata_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [20, 110, 50, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Data :');
set(handles.txtdata_analyser, 'fontunits', 'normalized');

%---Create checkbox DPS
handles.DPS_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [40, 90, 50, 20], 'value', 0, 'callback', @checkDPS_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'DPS');
set(handles.DPS_check_analyser, 'fontunits', 'normalized');

%---Create checkbox SR
handles.SR_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [120, 90, 50, 20], 'value', 0, 'callback', @checkSR_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'SR');
set(handles.SR_check_analyser, 'fontunits', 'normalized');

%---Create checkbox Breath
handles.Breath_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [30, 70, 100, 20], 'value', 0, 'callback', @checkBreath_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Breath');
set(handles.Breath_check_analyser, 'fontunits', 'normalized');

%---Create checkbox Splits
handles.Splits_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [115, 70, 100, 20], 'value', 0, 'callback', @checkSplits_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Splits');
set(handles.Splits_check_analyser, 'fontunits', 'normalized');

%---Create checkbox Smooth data
handles.Smooth_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [40, 50, 150, 20], 'value', 0, 'callback', @checkSmooth_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Velocity trend');
set(handles.Smooth_check_analyser, 'fontunits', 'normalized');

%---create txt x-axis
handles.txtxaxis_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [20, 25, 75, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'X-Axis :');
set(handles.txtxaxis_analyser, 'fontunits', 'normalized');

%---Create checkbox Distance
handles.Distance_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [30, 5, 75, 20], 'value', 0, 'callback', @checkDistance_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Distance');
set(handles.Distance_check_analyser, 'fontunits', 'normalized');

%---Create checkbox Time
handles.Time_check_analyser = uicontrol('parent', handles.panelgraph_pacing_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [115, 5, 75, 20], 'value', 0, 'callback', @checkTime_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Time');
set(handles.Time_check_analyser, 'fontunits', 'normalized');






%---create pacing zoom panel
handles.panelzoom_pacing_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [1070, 220, 205, 170], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Zoom', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.panelzoom_pacing_analyser, 'fontunits', 'normalized');

%---create txt min
handles.txtmin_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [85, 125, 50, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Min');
set(handles.txtmin_analyser, 'fontunits', 'normalized');

%---create txt max
handles.txtmax_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [140, 125, 50, 20], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Max');
set(handles.txtmax_analyser, 'fontunits', 'normalized');

%---create txt x_axis
handles.txtxaxiszoom_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 100, 75, 20], 'HorizontalAlignment', 'right', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'X-Axis :');
set(handles.txtxaxiszoom_analyser, 'fontunits', 'normalized');

%---create txt DPS-Axis:
handles.txtDPSaxiszoom_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 75, 75, 20], 'HorizontalAlignment', 'right', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'DPS-Axis :');
set(handles.txtDPSaxiszoom_analyser, 'fontunits', 'normalized');

%---create txt SR-Axis:
handles.txtSRaxiszoom_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 50, 75, 20], 'HorizontalAlignment', 'right', 'Callback', @xaxiszoom_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'SR-Axis :');
set(handles.txtSRaxiszoom_analyser, 'fontunits', 'normalized');

%---create edit min X-axis
handles.Edit_Xmin_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [85, 100, 50, 20], 'Callback', @xaxisminzoom_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.Edit_Xmin_analyser, 'fontunits', 'normalized');

%---create edit min DPS-axis
handles.Edit_YLeftmin_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [85, 75, 50, 20], 'Callback', @DPSaxisminzoom_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.Edit_YLeftmin_analyser, 'fontunits', 'normalized');

%---create edit min SR-axis
handles.Edit_YRightmin_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [85, 50, 50, 20], 'Callback', @SRaxisminzoom_analyser,  ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.Edit_YRightmin_analyser, 'fontunits', 'normalized');

%---create edit max X-axis
handles.Edit_Xmax_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [140, 100, 50, 20], 'Callback', @xaxismaxzoom_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.Edit_Xmax_analyser, 'fontunits', 'normalized');

%---create edit max DPS-axis
handles.Edit_YLeftmax_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [140, 75, 50, 20], 'Callback', @DPSaxismaxzoom_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.Edit_YLeftmax_analyser, 'fontunits', 'normalized');

%---create edit max SR-axis
handles.Edit_YRightmax_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [140, 50, 50, 20], 'Callback', @SRaxismaxzoom_analyser,  ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.Edit_YRightmax_analyser, 'fontunits', 'normalized');

%---create reset pushbutton
handles.zoom_reset_analyser = uicontrol('parent', handles.panelzoom_pacing_analyser, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [52, 10, 100, 30], 'Callback', @pushreset_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Reset');
set(handles.zoom_reset_analyser, 'fontunits', 'normalized');

%---other empty axes for graph display
handles.axesgraph1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', ...
    'Position', [180, 1, 880, 650], 'Visible', 'off');
set(handles.axesgraph1_analyser, 'units', 'normalized');

pospanel = [960, 570, 318, 110];
handles.axesgraph2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', ...
    'Position', [pospanel(1) 55 pospanel(3) 520], 'Visible', 'off');
set(handles.axesgraph2_analyser, 'units', 'normalized');

handles.axescover_analyser = axes('parent', handles.hf_w1_welcome, 'Position', [0, 0 , 1, 1], 'units', 'pixels', ...
    'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);



%---create Fluctuation Vel display panel
handles.displaypanel_fluctuation_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [1070, 350, 205, 200], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Display Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.displaypanel_fluctuation_analyser, 'fontunits', 'normalized');

%---create lap selection title
handles.displaylapfromto_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 155, 70, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Display:');
set(handles.displaylapfromto_analyser, 'fontunits', 'normalized');

%---create lap selection from TXT
handles.displaylapfromTXT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 135, 80, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'From Lap:');
set(handles.displaylapfromTXT_analyser, 'fontunits', 'normalized');

%---create lap selection from Edit
handles.displaylapfromEDIT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [85, 135, 30, 20], 'Callback', @displaylapfrom_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.displaylapfromEDIT_analyser, 'fontunits', 'normalized');

%---create lap selection to
handles.displaylaptoTXT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [125, 135, 30, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'to');
set(handles.displaylaptoTXT_analyser, 'fontunits', 'normalized');

%---create lap selection to Edit
handles.displaylaptoEDIT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [155, 135, 30, 20], 'Callback', @displaylapto_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.displaylaptoEDIT_analyser, 'fontunits', 'normalized');

%---create trend line order TXT
handles.trendorderTXT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 105, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Trend line order:');
set(handles.trendorderTXT_analyser, 'fontunits', 'normalized');

%---create trend line order POP
handles.trendorderLIST_analyser = {'Linear';'Quadratic';'Cubic'};
if ispc == 1;
    handles.trendorderPOP_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 105, 80, 20], 'string', handles.trendorderLIST_analyser, 'callback', @trendorder_analyser, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.trendorderPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.trendorderPOP_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 105, 80, 20], 'string', handles.trendorderLIST_analyser, 'callback', @trendorder_analyser, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.trendorderPOP_analyser, 'fontunits', 'normalized');
end;

%---create display options Mean Vel POP
handles.dispOptionMeanTXT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 75, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Show Av. Vel:');
set(handles.dispOptionMeanTXT_analyser, 'fontunits', 'normalized');

handles.dispOptionAvVelLIST_analyser = {'Av. Vel only';'Trend lines only';'All'};
if ispc == 1;
    handles.dispOptionAvVelPOP_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 75, 80, 20], 'string', handles.dispOptionAvVelLIST_analyser, 'callback', @dispOptionAvVel_analyser, 'Value', 3, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionAvVelPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptionAvVelPOP_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 75, 80, 20], 'string', handles.dispOptionAvVelLIST_analyser, 'callback', @dispOptionAvVel_analyser, 'Value', 3, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionAvVelPOP_analyser, 'fontunits', 'normalized');
end;

%---create display options Mean Vel POP
handles.dispOptionMaxTXT_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 45, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Show Max/Min Vel:');
set(handles.dispOptionMaxTXT_analyser, 'fontunits', 'normalized');

handles.dispOptionMaxVelLIST_analyser = {'Max/Min Vel only';'Trend lines only';'All'};
if ispc == 1;
    handles.dispOptionMaxVelPOP_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 45, 80, 20], 'string', handles.dispOptionMaxVelLIST_analyser, 'callback', @dispOptionMaxVel_analyser, 'Value', 3, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionMaxVelPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptionMaxVelPOP_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 45, 80, 20], 'string', handles.dispOptionMaxVelLIST_analyser, 'callback', @dispOptionMaxVel_analyser, 'Value', 3, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionMaxVelPOP_analyser, 'fontunits', 'normalized');
end;

%---update button
handles.updatefluc_button_analyser = uicontrol('parent', handles.displaypanel_fluctuation_analyser, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [50, 5, 100, 25], 'callback', @updatefluc_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Update');
set(handles.updatefluc_button_analyser, 'fontunits', 'normalized');









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---create Distribution Vel display panel
handles.displaypanel_distribution_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [1070, 285, 205, 265], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Display Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.displaypanel_distribution_analyser, 'fontunits', 'normalized');


%---create select data title
handles.selectdatatitleDistri_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 215, 200, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Data selection options:');
set(handles.selectdatatitleDistri_analyser, 'fontunits', 'normalized');

%---create Reference velocity
handles.refVelTXT_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 190, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Ref Speed base:');
set(handles.refVelTXT_analyser, 'fontunits', 'normalized');

handles.dispOptionrefVelLIST_analyser = {'Range';'Time'};
if ispc == 1;
    handles.dispOptionrefVelPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 190, 80, 20], 'string', handles.dispOptionrefVelLIST_analyser, 'callback', @dispOptionRefVel_analyser, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionrefVelPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptionrefVelPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 190, 80, 20], 'string', handles.dispOptionrefVelLIST_analyser, 'callback', @dispOptionRefVel_analyser, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionrefVelPOP_analyser, 'fontunits', 'normalized');
end;

%---create Reference speed distri
handles.zoneVelTXT_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 165, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Speed zones:');
set(handles.zoneVelTXT_analyser, 'fontunits', 'normalized');

handles.dispOptionzoneVelLIST_analyser = {'Range 0.025';'Range 0.015';'Range 0.01'};
if ispc == 1;
    handles.dispOptionzoneVelPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 165, 80, 20], 'string', handles.dispOptionzoneVelLIST_analyser, 'callback', @dispOptionZoneVel_analyser, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionzoneVelPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptionzoneVelPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 165, 80, 20], 'string', handles.dispOptionzoneVelLIST_analyser, 'callback', @dispOptionZoneVel_analyser, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionzoneVelPOP_analyser, 'fontunits', 'normalized');
end;

handles.dispOptionlegSelectTXT_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 140, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Leg Selection:');
set(handles.dispOptionlegSelectTXT_analyser, 'fontunits', 'normalized');

handles.dispOptionlegSelectLIST_analyser = {'All';'Butterfly';'Backstroke';'Breaststroke';'Freestyle'};
if ispc == 1;
    handles.dispOptionlegSelectPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 140, 80, 20], 'string', handles.dispOptionlegSelectLIST_analyser, 'callback', @dispOptionLegSelect_analyser, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionlegSelectPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptionlegSelectPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 140, 80, 20], 'string', handles.dispOptionlegSelectLIST_analyser, 'callback', @dispOptionLegSelect_analyser, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionlegSelectPOP_analyser, 'fontunits', 'normalized');
end;





%---create display data title
handles.displaydatatitleDistri_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 110, 150, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Data display options:');
set(handles.displaydatatitleDistri_analyser, 'fontunits', 'normalized');


%---Create graph options
handles.graphDispTXT_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 85, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Graph options:');
set(handles.graphDispTXT_analyser, 'fontunits', 'normalized');

handles.dispOptiongraphLineLIST_analyser = {'Bar & Trend line';'Bar only';'Trend line only'};
if ispc == 1;
    handles.dispOptiongraphLinePOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 85, 80, 20], 'string', handles.dispOptiongraphLineLIST_analyser, 'callback', @dispOptiongraphLine_analyser, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptiongraphLinePOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptiongraphLinePOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 85, 80, 20], 'string', handles.dispOptiongraphLineLIST_analyser, 'callback', @dispOptiongraphLine_analyser, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptiongraphLinePOP_analyser, 'fontunits', 'normalized');
end;

%---Create race data display options
handles.racedataDispTXT_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 60, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Race Data:');
set(handles.racedataDispTXT_analyser, 'fontunits', 'normalized');

handles.dispOptionRaceDataLIST_analyser = {'Race Time';'Lap Times';'All';'None'};
if ispc == 1;
    handles.dispOptionRaceDataPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 60, 80, 20], 'string', handles.dispOptionRaceDataLIST_analyser, 'callback', @dispOptionRaceData_analyser, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionRaceDataPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.dispOptionRaceDataPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 60, 80, 20], 'string', handles.dispOptionRaceDataLIST_analyser, 'callback', @dispOptionRaceData_analyser, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.dispOptionRaceDataPOP_analyser, 'fontunits', 'normalized');
end;

%---Create distri display options
handles.distriDispTXT_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 35, 120, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Distribution Data:');
set(handles.distriDispTXT_analyser, 'fontunits', 'normalized');

handles.distriDispLIST_analyser = {'None';'Cumulative zones';'All zones'};
if ispc == 1;
    handles.distriDispPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 35, 80, 20], 'string', handles.distriDispLIST_analyser, 'callback', @dispOptionDistriDisp_analyser, 'Value', 1, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.distriDispPOP_analyser, 'fontunits', 'normalized');
elseif ismac == 1;
    handles.distriDispPOP_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [120, 35, 80, 20], 'string', handles.distriDispLIST_analyser, 'callback', @dispOptionDistriDisp_analyser, 'Value', 1, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5);
    set(handles.distriDispPOP_analyser, 'fontunits', 'normalized');
end;

%---update button
handles.updatedistri_button_analyser = uicontrol('parent', handles.displaypanel_distribution_analyser, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [50, 5, 100, 25], 'callback', @updatedistri_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Update');
set(handles.updatedistri_button_analyser, 'fontunits', 'normalized');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%













%---Create Splits display panel
handles.panelgraph_splits_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [1075, 430, 200, 250], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Pacing Display Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.panelgraph_splits_analyser, 'fontunits', 'normalized');

%---1D, 2D, 3D graph
handles.txtDisplayType_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [10, 205, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Plot Type :');
set(handles.txtDisplayType_analyser, 'fontunits', 'normalized');

handles.splits1D_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 185, 60, 20], 'value', 0, 'callback', @checksplits1D_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Color');
set(handles.splits1D_check_analyser, 'fontunits', 'normalized');

handles.splits2D_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [60, 185, 50, 20], 'value', 0, 'callback', @checksplits2D_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Plot');
set(handles.splits2D_check_analyser, 'fontunits', 'normalized');

handles.splits3D_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [108, 185, 95, 20], 'value', 0, 'callback', @checksplits3D_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Animation');
set(handles.splits3D_check_analyser, 'fontunits', 'normalized');

%---Display Race/lap
handles.txtDisplayOption_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [10, 155, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Plot Options :');
set(handles.txtDisplayOption_analyser, 'fontunits', 'normalized');

handles.txtRaceLap_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [15, 135, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Display data for :');
set(handles.txtRaceLap_analyser, 'fontunits', 'normalized');

if ispc == 1;
    handles.popupRaceLap_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [105, 135, 85, 20], 'string', 'None', 'callback', @popupRaceLap_analyser, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
elseif ismac == 1;
    handles.popupRaceLap_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [110, 135, 85, 20], 'string', 'None', 'callback', @popupRaceLap_analyser, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
end;
set(handles.popupRaceLap_analyser, 'fontunits', 'normalized');

%---create splits every
if ispc == 1;
    handles.popupDistrance_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [20, 110, 70, 20], 'string', 'None', 'callback', @popupsplits_analyser, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
elseif ismac == 1;
    handles.popupDistrance_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'popupmenu', 'Visible', 'off', 'units', 'pixels', ...
        'position', [20, 110, 70, 20], 'string', 'None', 'callback', @popupsplits_analyser, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
end;
set(handles.popupDistrance_analyser, 'fontunits', 'normalized');

handles.txtdistrance_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [95, 110, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'meters splits');
set(handles.txtdistrance_analyser, 'fontunits', 'normalized');

%---Percentage or time or off
if ispc == 1;
    position1 = [5, 85, 100, 20];
    position2 = [95, 85, 50, 20];
    position3 = [150, 85, 40, 20];
elseif ismac == 1;
    position1 = [2, 85, 100, 20];
    position2 = [90, 85, 55, 20];
    position3 = [140, 85, 45, 20];
end;
handles.splitsPercentage_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', position1, 'value', 1, 'callback', @checksplitspercentage_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Percentage');
set(handles.splitsPercentage_check_analyser, 'fontunits', 'normalized');

handles.splitsTime_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', position2, 'value', 0, 'callback', @checksplitstime_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Time');
set(handles.splitsTime_check_analyser, 'fontunits', 'normalized');

handles.splitsOff_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', position3, 'value', 0, 'callback', @checksplitsoff_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Off');
set(handles.splitsOff_check_analyser, 'fontunits', 'normalized');

%---update button
handles.updatesplits_button_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [50, 55, 100, 25], 'callback', @updatesplits_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Update');
set(handles.updatesplits_button_analyser, 'fontunits', 'normalized');

%---Create checkbox show splits
handles.txtSplitsOption_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [10, 25, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Splits Display :');
set(handles.txtSplitsOption_analyser, 'fontunits', 'normalized');

handles.showsplits_check_analyser = uicontrol('parent', handles.panelgraph_splits_analyser, 'Style', 'Checkbox', 'Visible', 'off', 'units', 'pixels', ...
    'position', [55, 5, 110, 20], 'value', 0, 'callback', @showsplits_analyser, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Show splits');
set(handles.showsplits_check_analyser, 'fontunits', 'normalized');


%---Create Splits display panel
handles.panellanes3D_splits_analyser = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [1075, 70, 200, 350], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12, 'Title', 'Lanes Allocation', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.panelgraph_splits_analyser, 'fontunits', 'normalized');

handles.txtLane1_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 300, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 1 :');
set(handles.txtLane1_analyser, 'fontunits', 'normalized');
handles.txtLane1Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 283, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane1Name_analyser, 'fontunits', 'normalized');

handles.txtLane2_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 260, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 2 :');
set(handles.txtLane2_analyser, 'fontunits', 'normalized');
handles.txtLane2Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 243, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane2Name_analyser, 'fontunits', 'normalized');

handles.txtLane3_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 220, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 3 :');
set(handles.txtLane3_analyser, 'fontunits', 'normalized');
handles.txtLane3Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 203, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane3Name_analyser, 'fontunits', 'normalized');

handles.txtLane4_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 180, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 4 :');
set(handles.txtLane4_analyser, 'fontunits', 'normalized');
handles.txtLane4Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 163, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane4Name_analyser, 'fontunits', 'normalized');

handles.txtLane5_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 140, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 5 :');
set(handles.txtLane5_analyser, 'fontunits', 'normalized');
handles.txtLane5Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 123, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane5Name_analyser, 'fontunits', 'normalized');

handles.txtLane6_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 100, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 6 :');
set(handles.txtLane6_analyser, 'fontunits', 'normalized');
handles.txtLane6Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 83, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane6Name_analyser, 'fontunits', 'normalized');

handles.txtLane7_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 60, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 7 :');
set(handles.txtLane7_analyser, 'fontunits', 'normalized');
handles.txtLane7Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 43, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane7Name_analyser, 'fontunits', 'normalized');

handles.txtLane8_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 20, 190, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Lane 8 :');
set(handles.txtLane8_analyser, 'fontunits', 'normalized');
handles.txtLane8Name_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 3, 180, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '-----');
set(handles.txtLane8Name_analyser, 'fontunits', 'normalized');


%---animation player icones
handles.Precedentchap_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [230, 605, 30, 30], 'callback', @splits3D_PrevSplit_analyser, 'cdata', imresize(handles.icones.precedentchap_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Precedentchap_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Previous chapter');

handles.Precedentimage_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [265, 605, 30, 30], 'callback', @splits3D_PrevFrame_analyser, 'cdata', imresize(handles.icones.precedentimage_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Precedentimage_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Previous frame');

handles.Stop_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [300, 605, 30, 30], 'callback', @splits3D_Stop_analyser, 'cdata', imresize(handles.icones.stop_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Stop_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Stop playback');

handles.Play_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [335, 605, 30, 30], 'callback', @splits3D_PlayMain_analyser, 'cdata', imresize(handles.icones.play_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Play_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Play animation');
handles.AminationStatus_analyser = uicontrol('parent', handles.panellanes3D_splits_analyser, 'Position', [1, 1, 10, 10], 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', 'string', 'pause'); 

handles.Suivantimage_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [370, 605, 30, 30], 'callback', @splits3D_PlayMain_analyser, 'cdata', imresize(handles.icones.suivant_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Suivantimage_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'Next frame');

handles.Suivantchap_button_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [405, 605, 30, 30], 'callback', @splits3D_PlayMain_analyser, 'cdata', imresize(handles.icones.suivantchap_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Suivantchap_button_analyser, 'fontunits', 'normalized', 'Tooltipstring', 'previous frame');

handles.JumptoTXT_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [445, 610, 85, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', 'Jump to (m) :');
set(handles.JumptoTXT_analyser, 'fontunits', 'normalized');
handles.JumptoEDIT_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Edit', 'Visible', 'off', 'units', 'pixels', ...
    'position', [525, 610, 50, 25], 'Callback', @splits3D_JumpTo_analyser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, 'String', '');
set(handles.JumptoEDIT_analyser, 'fontunits', 'normalized');

handles.DispTimeAnimation_analyser = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', ...
    'position', [960, 610, 100, 20], 'HorizontalAlignment', 'Right', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', '0.00 s');
set(handles.DispTimeAnimation_analyser, 'fontunits', 'normalized');


%---hide axes
% set(allchild(handles.Question_button_analyser), 'Visible', 'off');
% set(allchild(handles.Search_button_analyser), 'Visible', 'off');
% set(allchild(handles.Reset_button_analyser), 'Visible', 'off');
% set(allchild(handles.Save_button_analyser), 'Visible', 'off');
% set(allchild(handles.Fullscreen_button_analyser), 'Visible', 'off');
% set(allchild(handles.Download_button_analyser), 'Visible', 'off');
% set(allchild(handles.Reportpdf_button_analyser), 'Visible', 'off');
% set(allchild(handles.Arrowback_button_analyser), 'Visible', 'off');
% set(allchild(handles.AddFile_button_analyser), 'Visible', 'off');
% set(allchild(handles.RemoveFile_button_analyser), 'Visible', 'off');
% set(allchild(handles.RemoveAllFile_button_analyser), 'Visible', 'off');
set(allchild(handles.Precedentchap_button_analyser), 'Visible', 'off');
set(allchild(handles.Precedentimage_button_analyser), 'Visible', 'off');
set(allchild(handles.Stop_button_analyser), 'Visible', 'off');
set(allchild(handles.Play_button_analyser), 'Visible', 'off');
set(allchild(handles.Suivantimage_button_analyser), 'Visible', 'off');
set(allchild(handles.Suivantchap_button_analyser), 'Visible', 'off');


%---reset the units
set(handles.Question_button_analyser, 'units', 'normalized');
set(handles.Save_button_analyser, 'units', 'normalized');
set(handles.Download_button_analyser, 'units', 'normalized');
set(handles.Fullscreen_button_analyser, 'units', 'normalized');
set(handles.Reportpdf_button_analyser, 'units', 'normalized');
set(handles.Arrowback_button_analyser, 'units', 'normalized');
set(handles.insVelToggle_analyser, 'units', 'normalized');
set(handles.predVelToggle_analyser, 'units', 'normalized');
set(handles.flucVelToggle_analyser, 'units', 'normalized');
% set(handles.Reset_button_analyser, 'units', 'normalized');
% set(handles.Search_button_analyser, 'units', 'normalized');
set(handles.displaypanel_fluctuation_analyser, 'units', 'normalized');
set(handles.displaylapfromto_analyser, 'units', 'normalized');
set(handles.displaylapfromTXT_analyser, 'units', 'normalized');
set(handles.displaylapfromEDIT_analyser, 'units', 'normalized');
set(handles.displaylaptoTXT_analyser, 'units', 'normalized');
set(handles.displaylaptoEDIT_analyser, 'units', 'normalized');
set(handles.trendorderPOP_analyser, 'units', 'normalized');
set(handles.trendorderTXT_analyser, 'units', 'normalized');
set(handles.dispOptionMeanTXT_analyser, 'units', 'normalized');
set(handles.dispOptionAvVelPOP_analyser, 'units', 'normalized');
set(handles.dispOptionMaxTXT_analyser, 'units', 'normalized');
set(handles.dispOptionMaxVelPOP_analyser, 'units', 'normalized');
set(handles.updatefluc_button_analyser, 'units', 'normalized');
set(handles.displaypanel_distribution_analyser, 'units', 'normalized');
set(handles.selectdatatitleDistri_analyser, 'units', 'normalized');
set(handles.refVelTXT_analyser, 'units', 'normalized');
set(handles.dispOptionrefVelPOP_analyser, 'units', 'normalized');
set(handles.zoneVelTXT_analyser, 'units', 'normalized');
set(handles.dispOptionlegSelectTXT_analyser, 'units', 'normalized');
set(handles.dispOptionzoneVelPOP_analyser, 'units', 'normalized');
set(handles.zoneVelTXT_analyser, 'units', 'normalized');
set(handles.dispOptionlegSelectPOP_analyser, 'units', 'normalized');
set(handles.displaydatatitleDistri_analyser, 'units', 'normalized');
set(handles.graphDispTXT_analyser, 'units', 'normalized');
set(handles.dispOptiongraphLinePOP_analyser, 'units', 'normalized');
set(handles.racedataDispTXT_analyser, 'units', 'normalized');
set(handles.dispOptionRaceDataPOP_analyser, 'units', 'normalized');
set(handles.distriDispTXT_analyser, 'units', 'normalized');
set(handles.distriDispPOP_analyser, 'units', 'normalized');
set(handles.updatedistri_button_analyser, 'units', 'normalized');
set(handles.Search_athletename_analyser, 'units', 'normalized');
set(handles.Search_racename_analyser, 'units', 'normalized');
set(handles.AddFile_button_analyser, 'units', 'normalized');
set(handles.RemoveFile_button_analyser, 'units', 'normalized');
set(handles.RemoveAllFile_button_analyser, 'units', 'normalized');
set(handles.Precedentchap_button_analyser, 'units', 'normalized');
set(handles.Precedentimage_button_analyser, 'units', 'normalized');
set(handles.Stop_button_analyser, 'units', 'normalized');
set(handles.Play_button_analyser, 'units', 'normalized');
set(handles.Suivantimage_button_analyser, 'units', 'normalized');
set(handles.Suivantchap_button_analyser, 'units', 'normalized');
set(handles.AthleteName_list_analyser, 'units', 'normalized');
set(handles.AthleteRace_list_analyser, 'units', 'normalized');
set(handles.FileAdded_list_analyser, 'units', 'normalized');
set(handles.display_button_analyser, 'units', 'normalized');
set(handles.DataPanel_toggle_analyser, 'units', 'normalized');
set(handles.PacingDisplay_toggle_analyser, 'units', 'normalized');
set(handles.SkillDisplay_toggle_analyser, 'units', 'normalized');
set(handles.SplitsDisplay_toggle_analyser, 'units', 'normalized');
set(handles.SummaryData_table_analyser, 'units', 'normalized');
set(handles.PacingData_table_analyser, 'units', 'normalized');
set(handles.SkillData_table_analyser, 'units', 'normalized');
set(handles.StrokeData_table_analyser, 'units', 'normalized');
set(handles.SummaryData_Panel_analyser, 'units', 'normalized');
set(handles.PacingData_Panel_analyser, 'units', 'normalized');
set(handles.StrokeData_Panel_analyser, 'units', 'normalized');
set(handles.SkillsData_Panel_analyser, 'units', 'normalized');
set(handles.panelgraph_skills1_analyser, 'units', 'normalized');
set(handles.txtoverlay_analyser, 'units', 'normalized');
set(handles.overlayyes_check_analyser, 'units', 'normalized');
set(handles.overlayno_check_analyser, 'units', 'normalized');
set(handles.txtathlete_analyser, 'units', 'normalized');
set(handles.txtturn_analyser, 'units', 'normalized');
set(handles.selectrace_pop_analyser, 'units', 'normalized');
set(handles.selectturn_pop_analyser, 'units', 'normalized');
set(handles.updateskills_button_analyser, 'units', 'normalized');
set(handles.panelgraph_pacing_analyser, 'units', 'normalized');
set(handles.txtdata_analyser, 'units', 'normalized');
set(handles.DPS_check_analyser, 'units', 'normalized');
set(handles.SR_check_analyser, 'units', 'normalized');
set(handles.Splits_check_analyser, 'units', 'normalized');
set(handles.Breath_check_analyser, 'units', 'normalized');
set(handles.Smooth_check_analyser, 'units', 'normalized');
set(handles.txtxaxis_analyser, 'units', 'normalized');
set(handles.Distance_check_analyser, 'units', 'normalized');
set(handles.Time_check_analyser, 'units', 'normalized');
set(handles.panelzoom_pacing_analyser, 'units', 'normalized');
set(handles.txtmin_analyser, 'units', 'normalized');
set(handles.txtmax_analyser, 'units', 'normalized');
set(handles.txtxaxiszoom_analyser, 'units', 'normalized');
set(handles.txtDPSaxiszoom_analyser, 'units', 'normalized');
set(handles.txtSRaxiszoom_analyser, 'units', 'normalized');
set(handles.Edit_Xmin_analyser, 'units', 'normalized');
set(handles.Edit_YLeftmin_analyser, 'units', 'normalized');
set(handles.Edit_YRightmin_analyser, 'units', 'normalized');
set(handles.Edit_Xmax_analyser, 'units', 'normalized');
set(handles.Edit_YLeftmax_analyser, 'units', 'normalized');
set(handles.Edit_YRightmax_analyser, 'units', 'normalized');
set(handles.zoom_reset_analyser, 'units', 'normalized');
set(handles.panelgraph_splits_analyser, 'units', 'normalized');
set(handles.showsplits_check_analyser, 'units', 'normalized');
set(handles.popupDistrance_analyser, 'units', 'normalized');
set(handles.txtdistrance_analyser, 'units', 'normalized');
set(handles.txtDisplayType_analyser, 'units', 'normalized');
set(handles.splits1D_check_analyser, 'units', 'normalized');
set(handles.splits2D_check_analyser, 'units', 'normalized');
set(handles.splits3D_check_analyser, 'units', 'normalized');
set(handles.txtRaceLap_analyser, 'units', 'normalized');
set(handles.popupRaceLap_analyser, 'units', 'normalized');
set(handles.updatesplits_button_analyser, 'units', 'normalized');
set(handles.txtDisplayOption_analyser, 'units', 'normalized');
set(handles.splitsPercentage_check_analyser, 'units', 'normalized');
set(handles.splitsTime_check_analyser, 'units', 'normalized');
set(handles.splitsOff_check_analyser, 'units', 'normalized');
set(handles.txtSplitsOption_analyser, 'units', 'normalized');
set(handles.JumptoTXT_analyser, 'units', 'normalized');
set(handles.JumptoEDIT_analyser, 'units', 'normalized');
set(handles.DispTimeAnimation_analyser, 'units', 'normalized');
set(handles.panellanes3D_splits_analyser, 'units', 'normalized');
set(handles.txtLane1_analyser, 'units', 'normalized');
set(handles.txtLane1Name_analyser, 'units', 'normalized');
set(handles.txtLane2_analyser, 'units', 'normalized');
set(handles.txtLane2Name_analyser, 'units', 'normalized');
set(handles.txtLane3_analyser, 'units', 'normalized');
set(handles.txtLane3Name_analyser, 'units', 'normalized');
set(handles.txtLane4_analyser, 'units', 'normalized');
set(handles.txtLane4Name_analyser, 'units', 'normalized');
set(handles.txtLane5_analyser, 'units', 'normalized');
set(handles.txtLane5Name_analyser, 'units', 'normalized');
set(handles.txtLane6_analyser, 'units', 'normalized');
set(handles.txtLane6Name_analyser, 'units', 'normalized');
set(handles.txtLane7_analyser, 'units', 'normalized');
set(handles.txtLane7Name_analyser, 'units', 'normalized');
set(handles.txtLane8_analyser, 'units', 'normalized');
set(handles.txtLane8Name_analyser, 'units', 'normalized');



