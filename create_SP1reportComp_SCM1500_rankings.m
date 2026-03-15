if ispc == 1;
    font1 = 12;
    font2 = 9;
    font3 = 7;
    font4 = 8.5;
elseif ismac == 1;
    font1 = 15;
    font2 = 12;
    font3 = 10;
    font4 = 11.5;
end;
% resolution = get(0,'ScreenSize');
% resolution = resolution(1,3:4);
% if strcmpi(source, 'display') == 1;
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))]);
%     hdef = figure('units', 'pixels', 'position', window_size, ...
%         'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Sparta - Report', ...
%         'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
% else;
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 860]);
%     hdef = figure('units', 'pixels', 'position', window_size, ...
%         'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
%         'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
% end;

resolution = get(0, 'MonitorPositions');
set(gcf, 'units', 'pixel');
figPos = get(gcf, 'Position');
set(gcf, 'units', 'normalized');

screenValid = 0;
for screenEC = 1:length(resolution(:,1));
    screenLim1 = resolution(screenEC,1);
    screenLim2 = screenLim1+resolution(screenEC,3)-1;

    if figPos(1) >= screenLim1 & figPos(1) <= screenLim2;
        screenValid = screenEC;
    end;
end;
if screenValid == 0;
    screenValid = 1;
end;
offsetLeft = resolution(screenValid,1);
offsetBottom = resolution(screenValid,2);
resolution = resolution(screenValid,3:4);

offzetSize = 0; %370;
if strcmpi(source, 'display') == 1;
    window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))-offzetSize]);
    window_size(1) = window_size(1) + offsetLeft;
    window_size(2) = window_size(2) + offsetBottom + 5;

    if window_size(3) < 1140 | window_size(4) < 860;
        h = warndlg('Screen resolution below [1140 860]. Display could be impacted', 'Warning');
        waitfor(h);
    end;

    hdef = figure('units', 'pixels', 'position', window_size, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Sparta - Report', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
else;
    resolution = [1920 1080];
    window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 860]);
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))-offzetSize]);
    hdef = figure('units', 'pixels', 'position', window_size, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');

end;

if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(hdef), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;



%--------------------------------Top info----------------------------------
if strcmpi(source, 'display') == 1;
    handles2.panelMain = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, resolution(2)-(0.1*resolution(2))-8935, 1200, 8905], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, resolution(2)-8905, 1200, 8905];
    handles2.panel_size = get(handles2.panelMain, 'Position');
    
    handles2.sliderRight = uicontrol('parent', hdef, 'Style', 'Slider', 'Visible', 'on', ...
        'Units', 'Pixels', 'Position', [1180 1 20 resolution(2)-(0.1*resolution(2))-1],...
        'min', 0, 'max', 1, 'callback', @sliderRight_report, 'Value', 1, ...
        'sliderstep', [1 1]);
    set(handles2.sliderRight, 'fontunits', 'normalized', 'units', 'normalized');
    
    handles2.save_button_report = uicontrol('parent', handles2.panelMain, 'Style', 'Pushbutton', ...
        'Visible', 'on', 'units', 'pixels', ...
        'position', [970 panel_size(4)-50 200 30], 'callback', @savedata_report_benchmark, ...
        'BackgroundColor', [0.9 0.9 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', ...
        'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Export to JPG');
    set(handles2.save_button_report, 'fontunits', 'normalized', 'Units', 'Normalized');

    set(hdef, 'WindowScrollWheelFcn', @scrollSP1report);

else;
    handles2.panelMain = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, 1125], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, resolution(2)-845, 1200, 845];
    handles2.panel_size = get(handles2.panelMain, 'Position');
end;

txtTitle_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-50, 575, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Comparison Report');
set(txtTitle_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtLegend_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-95, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'FontAngle', 'Italic', 'Fontsize', font3, 'String', '[ ! = Interpolated data for historical race analysis systems (GreenEye and Sparta 1)]');
set(txtLegend_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtBlue1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-200, window_size(3)-90, 110], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtBlue1_pdf, 'fontunits', 'normalized', 'units', 'normalized');
%--------------------------------------------------------------------------

try;
    handles2.tempFolder = handles.tempFolder;
    handles2.databaseCurrent = databaseCurrent;
    handles2.RaceDist = RaceDist;
    handles2.Gender = Gender;
    handles2.Course = Course;
catch;
    handles = handles2;
    databaseCurrent = handles.databaseCurrent;
    RaceDist = handles.RaceDist;
    Gender = handles.Gender;
    Course = handles.Course;
end;

txtCol1a_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-230, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1A_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-227, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'ANALYSIS TYPE');
set(txtCol1A_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1B_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-255, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Source');
set(txtCol1B_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1C_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-275, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Analysis method');
set(txtCol1C_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1d_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-310, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1d_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1D_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-307, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'RACE SUMMARY');
set(txtCol1D_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1E_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-335, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Total time');
set(txtCol1E_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1F_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-355, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Total skill time');
set(txtCol1F_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1G_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-375, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Total free swim');
set(txtCol1G_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1H_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-395, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Average velocity (m/s)');
set(txtCol1H_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1I_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-415, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Block (s)');
set(txtCol1I_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1J_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-435, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Start/15m (s)');
set(txtCol1J_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1J2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-450, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1J2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1K_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-470, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25m (s)');
set(txtCol1K_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1k_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-490, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Average Turns (s)');
set(txtCol1k_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1k2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-505, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1k2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1L_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-525, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Finish/Last 5m (s)');
set(txtCol1L_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1m_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size(4)-560, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1m_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1M_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-557, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25 m SPLITS');
set(txtCol1M_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-585, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-605, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-625, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-645, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-665, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-685, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-705, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-725, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-745, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-765, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-785, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-805, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-825, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-845, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource = handles2.panelMain;

    pos1 = 865;
    pos2 = 885;
    pos3 = 905;
    pos4 = 925;
    pos5 = 945;
    pos6 = 965;
    pos7 = 985;
    pos8 = 1005;
    pos9 = 1025;
    pos10 = 1045;
    pos11 = 1065;
    pos12 = 1085;
    pos13 = 1105;
    pos14 = 1125;
    pos15 = 1145;
    pos16 = 1165;
    pos17 = 1185;
    pos18 = 1205;
    pos19 = 1225;
    pos20 = 1245;
    pos21 = 1265;
    pos22 = 1285;
    pos23 = 1305;
    pos24 = 1325;
    pos25 = 1345;
    pos26 = 1365;
    pos27 = 1385;
    pos28 = 1405;
    pos29 = 1425;
    pos30 = 1445;
    pos31 = 1465;
    pos32 = 1485;
    pos33 = 1505;
    pos34 = 1525;
    pos35 = 1545;
    pos36 = 1565;
    pos37 = 1585;
    pos38 = 1605;
    pos39 = 1625;
    pos40 = 1645;
    pos41 = 1665;
    pos42 = 1685;

    panel_size2 = panel_size;
else;
    
    txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size(4)-1330, 1, 1250], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos1 = 20;
    pos2 = 40;
    pos3 = 60;
    pos4 = 80;
    pos5 = 100;
    pos6 = 120;
    pos7 = 140;
    pos8 = 160;
    pos9 = 180;
    pos10 = 200;
    pos11 = 220;
    pos12 = 240;
    pos13 = 260;
    pos14 = 280;
    pos15 = 300;
    pos16 = 320;
    pos17 = 340;
    pos18 = 360;
    pos19 = 380;
    pos20 = 400;
    pos21 = 420;
    pos22 = 440;
    pos23 = 460;
    pos24 = 480;
    pos25 = 500;
    pos26 = 520;
    pos27 = 540;
    pos28 = 560;
    pos29 = 580;
    pos30 = 600;
    pos31 = 620;
    pos32 = 640;
    pos33 = 660;
    pos34 = 680;
    pos35 = 700;
    pos36 = 720;
    pos37 = 740;
    pos38 = 760;
    pos39 = 780;
    pos40 = 800;
    pos41 = 820;
    pos42 = 840;

   
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 resolution(2)-(0.1*resolution(2))]);
    window_size2 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos42]);
    hdef2 = figure('units', 'pixels', 'position', window_size2, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef2), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain2 = uipanel('parent', hdef2, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos42], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain2, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size2 = [1, 10, 1200, pos42];
    figSource = panelMain2;
end;

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos1, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos2, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos3, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos4, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos5, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos6, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos7, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos8, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos9, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos10, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos11, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos12, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos13, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos14, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos15, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos16, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos17, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos18, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos19, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '825 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos20, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '850 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos21, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '875 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos22, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '900 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos23, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '925 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos24, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '950 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos25, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '975 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos26, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos27, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1025 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos28, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1050 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos29, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1075 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos30, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1100 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos31, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1125 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos32, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1150 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos33, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1175 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos34, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1200 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos35, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1225 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos36, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1250 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos37, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1275 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos38, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1300 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos39, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1325 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos40, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1350 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos41, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1375 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos42, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1400 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource2 = handles2.panelMain;

    pos43 = 1705;
    pos44 = 1725;
    pos45 = 1745;
    pos46 = 1765;
    pos47 = 1800;
    pos48 = 1797;
    pos49 = 1830;
    pos50 = 1850;
    pos51 = 1870;
    pos52 = 1890;
    pos53 = 1910;
    pos54 = 1930;
    pos55 = 1950;
    pos56 = 1970;
    pos57 = 1990;
    pos58 = 2010;
    pos59 = 2030;
    pos60 = 2050;
    pos61 = 2070;
    pos62 = 2090;
    pos63 = 2110;
    pos64 = 2130;
    pos65 = 2150;
    pos66 = 2170;
    pos67 = 2190;
    pos68 = 2210;
    pos69 = 2230;
    pos70 = 2250;
    pos71 = 2270;
    pos72 = 2290;
    pos73 = 2310;
    pos74 = 2330;
    pos75 = 2350;
    pos76 = 2370;
    pos77 = 2390;
    pos78 = 2410;
    pos79 = 2430;
    pos80 = 2450;
    pos81 = 2470;
    pos82 = 2490;
    pos83 = 2510;
    pos84 = 2530;
    pos85 = 2550;

    panel_size3 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size2(4)-pos42, 1, pos42], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos43 = 20;
    pos44 = 40;
    pos45 = 60;
    pos46 = 80;
    pos47 = 115;
    pos48 = 112;
    pos49 = 145;
    pos50 = 165;
    pos51 = 185;
    pos52 = 205;
    pos53 = 225;
    pos54 = 245;
    pos55 = 265;
    pos56 = 285;
    pos57 = 305;
    pos58 = 325;
    pos59 = 345;
    pos60 = 365;
    pos61 = 385;
    pos62 = 405;
    pos63 = 425;
    pos64 = 445;
    pos65 = 465;
    pos66 = 485;
    pos67 = 505;
    pos68 = 525;
    pos69 = 545;
    pos70 = 565;
    pos71 = 585;
    pos72 = 605;
    pos73 = 625;
    pos74 = 645;
    pos75 = 665;
    pos76 = 685;
    pos77 = 705;
    pos78 = 725;
    pos79 = 745;
    pos80 = 765;
    pos81 = 785;
    pos82 = 805;
    pos83 = 825;
    pos84 = 845;
    pos85 = 865;


    window_size3 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos85]);
    hdef3 = figure('units', 'pixels', 'position', window_size3, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef3), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain3 = uipanel('parent', hdef3, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos85], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain3, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size3 = [1, 10, 1200, pos85];
    figSource2 = panelMain3;
end;

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos43, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1425 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos44, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1450 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos45, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1475 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos46, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1500 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');





txtCol1o_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size3(4)-pos47, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos48, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos49, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --          25');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos50, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25           --          50');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos51, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --          75');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos52, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75           --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos53, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         125');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos54, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125         --         150');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos55, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         175');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos56, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos57, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         225');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos58, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225         --         250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos59, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         275');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos60, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos61, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         325');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos62, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325         --         350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos63, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         375');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos64, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos65, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         425');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos66, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425         --         450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos67, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         475');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos68, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos69, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         525');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos70, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525         --         550');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos71, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         575');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos72, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos73, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         625');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos74, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625         --         650');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos75, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         675');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos76, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos77, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         725');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos78, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725         --         750');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos79, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         775');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos80, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos81, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800         --         825');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos82, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '825         --         850');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos83, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '850         --         875');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos84, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '875         --         900');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos85, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '900         --         925');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');



if strcmpi(source, 'display') == 1;
    figSource3 = handles2.panelMain;

    pos86 = 2570;
    pos87 = 2590;
    pos88 = 2610;
    pos89 = 2630;
    pos90 = 2650;
    pos91 = 2670;
    pos92 = 2690;
    pos93 = 2710;
    pos94 = 2730;
    pos95 = 2750;
    pos96 = 2770;
    pos97 = 2790;
    pos98 = 2810;
    pos99 = 2830;
    pos100 = 2850;
    pos101 = 2870;
    pos102 = 2890;
    pos103 = 2910;
    pos104 = 2930;
    pos105 = 2950;
    pos106 = 2970;
    pos107 = 2990;
    pos108 = 3010;
    pos109 = 3045;
    pos110 = 3042;
    pos111 = 3075;
    pos112 = 3095;
    pos113 = 3115;
    pos114 = 3135;
    pos115 = 3155;
    pos116 = 3175;
    pos117 = 3195;
    pos118 = 3215;
    pos119 = 3235;
    pos120 = 3255;
    pos121 = 3275;
    pos122 = 3295;
    pos123 = 3315;
    pos124 = 3335;
    pos125 = 3355;
    pos126 = 3375;
    pos127 = 3395;
    pos128 = 3415;
    pos129 = 3435;
  

    panel_size4 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size3(4)-pos85, 1, pos85], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    pos86 = 20;
    pos87 = 40;
    pos88 = 60;
    pos89 = 80;
    pos90 = 100;
    pos91 = 120;
    pos92 = 140;
    pos93 = 160;
    pos94 = 180;
    pos95 = 200;
    pos96 = 220;
    pos97 = 240;
    pos98 = 260;
    pos99 = 280;
    pos100 = 300;
    pos101 = 320;
    pos102 = 340;
    pos103 = 360;
    pos104 = 380;
    pos105 = 400;
    pos106 = 420;
    pos107 = 440;
    pos108 = 460;
    pos109 = 495;
    pos110 = 492;
    pos111 = 525;
    pos112 = 545;
    pos113 = 565;
    pos114 = 585;
    pos115 = 605;
    pos116 = 625;
    pos117 = 645;
    pos118 = 665;
    pos119 = 685;
    pos120 = 705;
    pos121 = 725;
    pos122 = 745;
    pos123 = 765;
    pos124 = 785;
    pos125 = 805;
    pos126 = 825;
    pos127 = 845;
    pos128 = 865;
    pos129 = 885;

    window_size4 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos129]);
    hdef4 = figure('units', 'pixels', 'position', window_size4, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef4), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain4 = uipanel('parent', hdef4, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos129], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain4, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size4 = [1, 10, 1200, pos129];
    figSource3 = panelMain4;
end;


txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos86, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '925         --         950');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos87, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '950         --         975');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos88, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '975         --        1000');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos89, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000       --        1025');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos90, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1025       --        1050');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos91, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1050       --        1075');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos92, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1075       --        1100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos93, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1100       --        1125');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos94, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1125       --        1150');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos95, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1150       --        1175');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos96, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1175       --        1200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos97, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1200       --        1225');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos98, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1225       --        1250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos99, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1250       --        1275');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos100, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1275       --        1300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos101, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1300       --        1325');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos102, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1325       --        1350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos103, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1350       --        1375');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos104, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1375       --        1400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos105, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1400       --        1425');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos106, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1425       --        1450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos107, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1450       --        1475');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos108, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1475       --        1500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');








txtCol1o_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size4(4)-pos109, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos110, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos111, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --          50');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos112, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos113, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         150');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos114, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos115, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos116, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos117, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos118, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos119, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos120, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos121, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         550');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos122, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos123, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         650');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos124, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos125, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         750');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos126, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos127, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800         --         850');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos128, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '850         --         900');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos129, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '900         --         950');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource4 = handles2.panelMain;


    pos130 = 3455;
    pos131 = 3475;
    pos132 = 3495;
    pos133 = 3515;
    pos134 = 3535;
    pos135 = 3555;
    pos136 = 3575;
    pos137 = 3595;
    pos138 = 3615;
    pos139 = 3635;
    pos140 = 3655;
    pos141 = 3690;
    pos142 = 3687;
    pos143 = 3720;
    pos144 = 3740;
    pos145 = 3760;
    pos146 = 3780;
    pos147 = 3800;
    pos148 = 3820;
    pos149 = 3840;
    pos150 = 3860;
    pos151 = 3880;
    pos152 = 3900;
    pos153 = 3920;
    pos154 = 3940;
    pos155 = 3960;
    pos156 = 3980;
    pos157 = 4000;
    pos158 = 4035;
    pos159 = 4032;
    pos160 = 4065;
    pos161 = 4085;
    pos162 = 4105;
    pos163 = 4125;
    pos164 = 4145;
    pos165 = 4165;
    pos166 = 4185;
    pos167 = 4220;
    pos168 = 4217;
    pos169 = 4245;
    pos170 = 4265;
    pos171 = 4285;


    panel_size5 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size4(4)-pos129, 1, pos129], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    pos130 = 20;
    pos131 = 40;
    pos132 = 60;
    pos133 = 80;
    pos134 = 100;
    pos135 = 120;
    pos136 = 140;
    pos137 = 160;
    pos138 = 180;
    pos139 = 200;
    pos140 = 220;
    pos141 = 255;
    pos142 = 252;
    pos143 = 285;
    pos144 = 305;
    pos145 = 325;
    pos146 = 345;
    pos147 = 365;
    pos148 = 385;
    pos149 = 405;
    pos150 = 425;
    pos151 = 445;
    pos152 = 465;
    pos153 = 485;
    pos154 = 505;
    pos155 = 525;
    pos156 = 545;
    pos157 = 565;
    pos158 = 600;
    pos159 = 597;
    pos160 = 630;
    pos161 = 650;
    pos162 = 670;
    pos163 = 690;
    pos164 = 710;
    pos165 = 730;
    pos166 = 750;
    pos167 = 785;
    pos168 = 782;
    pos169 = 815;
    pos170 = 835;
    pos171 = 855;


    window_size5 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos171]);
    hdef5 = figure('units', 'pixels', 'position', window_size5, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef5), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain5 = uipanel('parent', hdef5, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos171], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain5, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size5 = [1, 10, 1200, pos171];
    figSource4 = panelMain5;
end;


txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos130, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '900         --         950');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos131, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '950         --        1000');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos132, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000       --        1050');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos133, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1050       --        1100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos134, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1150       --        1200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos135, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1200       --        1250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos136, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1250       --        1300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos137, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1300       --        1350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos138, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1350       --        1400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos139, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1400       --        1450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos140, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1450       --        1500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');





txtCol1o_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size5(4)-pos141, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos142, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos143, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos144, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos145, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos146, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos147, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos148, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos149, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos150, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos151, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800         --         900');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos152, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '900         --        1000');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos153, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000       --        1100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos154, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1100       --        1200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos155, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1200       --        1300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos156, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1300       --        1400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos157, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1400       --        1500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');






txtCol1o_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size5(4)-pos158, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos159, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos160, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos161, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos162, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos163, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos164, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800         --        1000');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos165, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000       --        1200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos166, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1200       --        1400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');







txtCol1o_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size5(4)-pos167, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos168, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos169, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos170, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --        1000');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos171, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000       --        1500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');







if strcmpi(source, 'display') == 1;
    figSource5 = handles2.panelMain;

    pos172 = 4320;
    pos173 = 4317;
    pos174 = 4350;
    pos175 = 4370;
    pos176 = 4390;
    pos177 = 4410;
    pos178 = 4430;
    pos179 = 4450;
    pos180 = 4470;
    pos181 = 4490;
    pos182 = 4510;
    pos183 = 4530;
    pos184 = 4550;
    pos185 = 4570;
    pos186 = 4590;
    pos187 = 4610;
    pos188 = 4630;
    pos189 = 4650;
    pos190 = 4670;
    pos191 = 4690;
    pos192 = 4710;
    pos193 = 4730;
    pos194 = 4750;
    pos195 = 4770;
    pos196 = 4790;
    pos197 = 4810;
    pos198 = 4830;
    pos199 = 4850;
    pos200 = 4870;
    pos201 = 4890;
    pos202 = 4910;
    pos203 = 4930;
    pos204 = 4950;
    pos205 = 4970;
    pos206 = 4990;
    pos207 = 5010;
    pos208 = 5030;
    pos209 = 5050;
    pos210 = 5070;
    pos211 = 5090;
    pos212 = 5110;
    pos213 = 5130;
    pos214 = 5150;

    panel_size6 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size5(4)-pos171, 1, pos171], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    pos172 = 35;
    pos173 = 32;
    pos174 = 65;
    pos175 = 85;
    pos176 = 105;
    pos177 = 125;
    pos178 = 145;
    pos179 = 165;
    pos180 = 185;
    pos181 = 205;
    pos182 = 225;
    pos183 = 245;
    pos184 = 265;
    pos185 = 285;
    pos186 = 305;
    pos187 = 325;
    pos188 = 345;
    pos189 = 365;
    pos190 = 385;
    pos191 = 405;
    pos192 = 425;
    pos193 = 445;
    pos194 = 465;
    pos195 = 485;
    pos196 = 505;
    pos197 = 525;
    pos198 = 545;
    pos199 = 565;
    pos200 = 585;
    pos201 = 605;
    pos202 = 625;
    pos203 = 645;
    pos204 = 665;
    pos205 = 685;
    pos206 = 705;
    pos207 = 725;
    pos208 = 745;
    pos209 = 765;
    pos210 = 785;
    pos211 = 805;
    pos212 = 825;
    pos213 = 845;
    pos214 = 865;

    window_size6 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos214]);
    hdef6 = figure('units', 'pixels', 'position', window_size6, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef6), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain6 = uipanel('parent', hdef6, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos214], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain6, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size6 = [1, 10, 1200, pos214];
    figSource5 = panelMain6;
end;


txtCol1o_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size6(4)-pos172, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos173, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'STROKE COUNTS');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1P_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos174, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 1');
set(txtCol1P_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos175, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 2');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos176, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 3');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos177, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 4');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos178, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 5');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos179, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 6');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos180, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 7');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos181, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 8');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos182, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 9');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos183, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 10');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos184, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 11');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos185, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 12');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos186, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 13');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos187, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 14');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos188, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 15');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos189, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 16');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos190, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 17');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos191, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 18');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos192, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 19');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos193, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 20');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos194, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 21');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos195, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 22');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos196, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 23');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos197, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 24');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos198, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 25');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos199, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 26');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos200, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 27');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos201, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 28');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos202, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 29');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos203, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 30');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos204, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 31');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos205, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 32');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos206, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 33');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos207, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 34');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos208, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 35');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos209, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 36');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos210, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 37');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos211, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 38');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos212, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 39');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos213, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 40');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos214, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 41');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource6 = handles2.panelMain;
    
    pos215 = 5170;
    pos216 = 5190;
    pos217 = 5210;
    pos218 = 5230;
    pos219 = 5250;
    pos220 = 5270;
    pos221 = 5290;
    pos222 = 5310;
    pos223 = 5330;
    pos224 = 5350;
    pos225 = 5370;
    pos226 = 5390;
    pos227 = 5410;
    pos228 = 5430;
    pos229 = 5450;
    pos230 = 5470;
    pos231 = 5490;
    pos232 = 5510;
    pos233 = 5530;
    pos234 = 5565;
    pos235 = 5562;
    pos236 = 5595;
    pos237 = 5610;
    pos238 = 5630;
    pos239 = 5645;
    pos240 = 5665;
    pos241 = 5680;
    pos242 = 5700;
    pos243 = 5715;
    pos244 = 5735;
    pos245 = 5750;
    pos246 = 5775;
    pos247 = 5790;
    pos248 = 5810;
    pos249 = 5825;
    pos250 = 5845;
    pos251 = 5860;
    pos252 = 5880;
    pos253 = 5895;
    pos254 = 5915;
    pos255 = 5930;
    pos256 = 5950;
    pos257 = 5965;
    pos258 = 5985;
    pos259 = 6000;
    pos260 = 6020;
    pos261 = 6035;


    panel_size7 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size6(4)-pos214, 1, pos214], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos215 = 20;
    pos216 = 40;
    pos217 = 60;
    pos218 = 80;
    pos219 = 100;
    pos220 = 120;
    pos221 = 140;
    pos222 = 160;
    pos223 = 180;
    pos224 = 200;
    pos225 = 220;
    pos226 = 240;
    pos227 = 260;
    pos228 = 280;
    pos229 = 300;
    pos230 = 320;
    pos231 = 340;
    pos232 = 360;
    pos233 = 380;
    pos234 = 415;
    pos235 = 412;
    pos236 = 445;
    pos237 = 460;
    pos238 = 480;
    pos239 = 495;
    pos240 = 510;
    pos241 = 525;
    pos242 = 545;
    pos243 = 560;
    pos244 = 580;
    pos245 = 595;
    pos246 = 615;
    pos247 = 630;
    pos248 = 650;
    pos249 = 665;
    pos250 = 685;
    pos251 = 700;
    pos252 = 720;
    pos253 = 735;
    pos254 = 755;
    pos255 = 770;
    pos256 = 790;
    pos257 = 805;
    pos258 = 825;
    pos259 = 840;
    pos260 = 860;
    pos261 = 875;


    window_size7 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos261]);
    hdef7 = figure('units', 'pixels', 'position', window_size7, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef7), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain7 = uipanel('parent', hdef7, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos261], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain7, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size7 = [1, 10, 1200, pos261];
    figSource6 = panelMain7;
end;

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos215, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 42');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos216, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 43');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos217, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 44');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos218, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 45');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos219, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 46');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos220, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 47');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos221, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 48');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos222, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 49');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos223, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 50');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos224, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 51');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos225, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 52');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos226, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 53');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos227, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 54');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos228, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 55');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos229, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 56');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos230, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 57');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos231, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 58');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos232, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 59');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos233, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 60');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');







txtCol1r_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size7(4)-pos234, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1R_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos235, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'TURNS [in out turn (s)]');
set(txtCol1R_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sa_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos236, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 1');
set(txtCol1Sa_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2a_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos237, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');











txtCol1Sb_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos238, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 2');
set(txtCol1Sb_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2b_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos239, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sc_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos240, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 3');
set(txtCol1Sc_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2c_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos241, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2c_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sd_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos242, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 4');
set(txtCol1Sd_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2d_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos243, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2d_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Se_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos244, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 5');
set(txtCol1Se_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2e_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos245, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2e_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sf_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos246, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 6');
set(txtCol1Sf_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2f_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos247, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2f_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos248, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 7');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos249, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos250, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 8');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos251, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos252, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 9');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos253, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos254, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 10');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos255, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos256, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 11');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos257, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos258, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 12');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos259, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos260, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 13');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos261, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource7 = handles2.panelMain;
    
    pos262 = 6055;
    pos263 = 6070;
    pos264 = 6090;
    pos265 = 6105;
    pos266 = 6125;
    pos267 = 6140;
    pos268 = 6160;
    pos269 = 6175;
    pos270 = 6195;
    pos271 = 6210;
    pos272 = 6230;
    pos273 = 6245;
    pos274 = 6265;
    pos275 = 6280;
    pos276 = 6300;
    pos277 = 6315;
    pos278 = 6335;
    pos279 = 6350;
    pos280 = 6370;
    pos281 = 6385;
    pos282 = 6405;
    pos283 = 6420;
    pos284 = 6440;
    pos285 = 6455;
    pos286 = 6475;
    pos287 = 6490;
    pos288 = 6510;
    pos289 = 6525;
    pos290 = 6545;
    pos291 = 6560;
    pos292 = 6580;
    pos293 = 6595;
    pos294 = 6615;
    pos295 = 6630;
    pos296 = 6650;
    pos297 = 6665;
    pos298 = 6685;
    pos299 = 6700;
    pos300 = 6720;
    pos301 = 6735;
    pos302 = 6755;
    pos303 = 6770;
    pos304 = 6790;
    pos305 = 6805;


    panel_size8 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size7(4)-pos261, 1, pos261], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos262 = 20;
    pos263 = 35;
    pos264 = 55;
    pos265 = 70;
    pos266 = 90;
    pos267 = 105;
    pos268 = 125;
    pos269 = 140;
    pos270 = 160;
    pos271 = 175;
    pos272 = 195;
    pos273 = 210;
    pos274 = 230;
    pos275 = 245;
    pos276 = 265;
    pos277 = 280;
    pos278 = 300;
    pos279 = 315;
    pos280 = 335;
    pos281 = 350;
    pos282 = 370;
    pos283 = 385;
    pos284 = 405;
    pos285 = 420;
    pos286 = 440;
    pos287 = 455;
    pos288 = 475;
    pos289 = 490;
    pos290 = 510;
    pos291 = 525;
    pos292 = 545;
    pos293 = 560;
    pos294 = 580;
    pos295 = 595;
    pos296 = 615;
    pos297 = 630;
    pos298 = 650;
    pos299 = 665;
    pos300 = 685;
    pos301 = 700;
    pos302 = 720;
    pos303 = 735;
    pos304 = 755;
    pos305 = 770;


    window_size8 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos305]);
    hdef8 = figure('units', 'pixels', 'position', window_size8, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef8), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain8 = uipanel('parent', hdef8, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos305], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain8, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size8 = [1, 10, 1200, pos305];
    figSource7 = panelMain8;
end;


txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos262, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 14');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos263, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos264, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 15');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos265, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos266, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 16');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos267, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos268, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 17');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos269, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos270, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 18');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos271, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos272, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 19');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos273, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos274, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 20');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos275, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos276, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 21');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos277, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos278, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 22');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos279, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos280, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 23');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos281, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos282, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 24');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos283, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos284, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 25');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos285, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos286, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 26');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos287, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos288, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 27');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos289, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos290, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 28');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos291, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos292, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 29');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos293, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos294, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 30');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos295, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos296, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 31');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos297, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos298, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 32');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos299, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos300, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 33');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos301, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos302, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 34');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos303, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos304, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 35');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size8(4)-pos305, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource8 = handles2.panelMain;
    
    pos306 = 6825;
    pos307 = 6840;
    pos308 = 6860;
    pos309 = 6875;
    pos310 = 6895;
    pos311 = 6910;
    pos312 = 6930;
    pos313 = 6945;
    pos314 = 6965;
    pos315 = 6980;
    pos316 = 7000;
    pos317 = 7015;
    pos318 = 7035;
    pos319 = 7050;
    pos320 = 7070;
    pos321 = 7085;
    pos322 = 7105;
    pos323 = 7120;
    pos324 = 7140;
    pos325 = 7155;
    pos326 = 7175;
    pos327 = 7190;
    pos328 = 7210;
    pos329 = 7225;
    pos330 = 7245;
    pos331 = 7260;
    pos332 = 7280;
    pos333 = 7295;
    pos334 = 7315;
    pos335 = 7330;
    pos336 = 7350;
    pos337 = 7365;
    pos338 = 7385;
    pos339 = 7400;
    pos340 = 7420;
    pos341 = 7435;
    pos342 = 7455;
    pos343 = 7470;
    pos344 = 7490;
    pos345 = 7505;
    pos346 = 7525;
    pos347 = 7540;
    pos348 = 7560;
    pos349 = 7575;
    pos350 = 7595;
    pos351 = 7610;
    pos352 = 7630;
    pos353 = 7645;
    pos354 = 7680;
    pos355 = 7677;
    pos356 = 7700;
    pos357 = 7720;
    pos358 = 7740;
    pos359 = 7760;
    pos360 = 7780;
    pos361 = 7800;
    pos362 = 7820;
    pos363 = 7840;
    pos364 = 7860;



    panel_size9 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size8(4)-pos305, 1, pos305], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos306 = 20;
    pos307 = 35;
    pos308 = 55;
    pos309 = 70;
    pos310 = 90;
    pos311 = 105;
    pos312 = 125;
    pos313 = 140;
    pos314 = 160;
    pos315 = 175;
    pos316 = 195;
    pos317 = 210;
    pos318 = 230;
    pos319 = 245;
    pos320 = 265;
    pos321 = 280;
    pos322 = 300;
    pos323 = 315;
    pos324 = 335;
    pos325 = 350;
    pos326 = 370;
    pos327 = 385;
    pos328 = 405;
    pos329 = 420;
    pos330 = 440;
    pos331 = 455;
    pos332 = 475;
    pos333 = 490;
    pos334 = 510;
    pos335 = 525;
    pos336 = 545;
    pos337 = 560;
    pos338 = 580;
    pos339 = 595;
    pos340 = 615;
    pos341 = 630;
    pos342 = 650;
    pos343 = 665;
    pos344 = 685;
    pos345 = 700;
    pos346 = 720;
    pos347 = 735;
    pos348 = 755;
    pos349 = 770;
    pos350 = 790;
    pos351 = 805;
    pos352 = 825;
    pos353 = 840;
    pos354 = 875;
    pos355 = 872;
    pos356 = 905;
    pos357 = 925;
    pos358 = 945;
    pos359 = 965;
    pos360 = 985;
    pos361 = 1005;
    pos362 = 1025;
    pos363 = 1045;
    pos364 = 1065;


    window_size9 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos364]);
    hdef9 = figure('units', 'pixels', 'position', window_size9, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef9), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain9 = uipanel('parent', hdef9, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos364], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain9, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size9 = [1, 10, 1200, pos364];
    figSource8 = panelMain9;
end;

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos306, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 36');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos307, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos308, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 37');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos309, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos310, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 38');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos311, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos312, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 39');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos313, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos314, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 40');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos315, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos316, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 41');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos317, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos318, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 42');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos319, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos320, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 43');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos321, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos322, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 44');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos323, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos324, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 45');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos325, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos326, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 46');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos327, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos328, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 47');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos329, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos330, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 48');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos331, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos332, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 49');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos333, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos334, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 50');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos335, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos336, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 51');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos337, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos338, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 52');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos339, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos340, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 53');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos341, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos342, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 54');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos343, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos344, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 55');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos345, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos346, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 56');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos347, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos348, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 57');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos349, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos350, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 58');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos351, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos352, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 59');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos353, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');










txtCol1t_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size9(4)-pos354, 120, 32], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1T_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos355, 115, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', {'STROKES'; '[SR DPS Breath]'});
set(txtCol1T_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1U_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos356, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --           25');
set(txtCol1U_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1V_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos357, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25           --           50');
set(txtCol1V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos358, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --           75');
set(txtCol1X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos359, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75           --         100');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos360, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         125');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos361, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125         --         150');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos362, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         175');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos363, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175         --         200');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size9(4)-pos364, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         225');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource9 = handles2.panelMain;
    
%     7640
    pos365 = 7880;
    pos366 = 7900;
    pos367 = 7920;
    pos368 = 7940;
    pos369 = 7960;
    pos370 = 7980;
    pos371 = 8000;
    pos372 = 8020;
    pos373 = 8040;
    pos374 = 8060;
    pos375 = 8080;
    pos376 = 8100;
    pos377 = 8120;
    pos378 = 8140;
    pos379 = 8160;
    pos380 = 8180;
    pos381 = 8200;
    pos382 = 8220;
    pos383 = 8240;
    pos384 = 8260;
    pos385 = 8280;
    pos386 = 8300;
    pos387 = 8320;
    pos388 = 8340;
    pos389 = 8360;
    pos390 = 8380;
    pos391 = 8400;
    pos392 = 8420;
    pos393 = 8440;
    pos394 = 8460;
    pos395 = 8480;
    pos396 = 8500;
    pos397 = 8520;
    pos398 = 8540;
    pos399 = 8560;
    pos400 = 8580;
    pos401 = 8600;
    pos402 = 8620;
    pos403 = 8640;
    pos404 = 8660;
    pos405 = 8680;
    pos406 = 8700;
    pos407 = 8720;


    panel_size10 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size9(4)-pos364, 1, pos364], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos365 = 20;
    pos366 = 40;
    pos367 = 60;
    pos368 = 80;
    pos369 = 100;
    pos370 = 120;
    pos371 = 140;
    pos372 = 160;
    pos373 = 180;
    pos374 = 200;
    pos375 = 220;
    pos376 = 240;
    pos377 = 260;
    pos378 = 280;
    pos379 = 300;
    pos380 = 320;
    pos381 = 340;
    pos382 = 360;
    pos383 = 380;
    pos384 = 400;
    pos385 = 420;
    pos386 = 440;
    pos387 = 460;
    pos388 = 480;
    pos389 = 500;
    pos390 = 520;
    pos391 = 540;
    pos392 = 560;
    pos393 = 580;
    pos394 = 600;
    pos395 = 620;
    pos396 = 640;
    pos397 = 660;
    pos398 = 680;
    pos399 = 700;
    pos400 = 720;
    pos401 = 740;
    pos402 = 760;
    pos403 = 780;
    pos404 = 800;
    pos405 = 820;
    pos406 = 840;
    pos407 = 860;

    window_size10 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos407]);
    hdef10 = figure('units', 'pixels', 'position', window_size10, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef10), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain10 = uipanel('parent', hdef10, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos407], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain10, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size10 = [1, 10, 1200, pos407];
    figSource9 = panelMain10;
end;

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos365, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225         --         250');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos366, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         275');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos367, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275         --         300');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos368, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         325');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos369, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325         --         350');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos370, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         375');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos371, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375         --         400');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos372, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         425');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos373, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425         --         450');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos374, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         475');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos375, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475         --         500');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos376, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         525');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos377, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525         --         550');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos378, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         575');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos379, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575         --         600');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos380, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         625');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos381, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625         --         650');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos382, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         675');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos383, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675         --         700');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos384, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         725');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos385, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725         --         750');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos386, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         775');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos387, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775         --         800');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos388, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800         --         825');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos389, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '825         --         850');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos390, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '850         --         875');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos391, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '875         --         900');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos392, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '900         --         925');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos393, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '925         --         950');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos394, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '950         --         975');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos395, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '975         --        1000');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos396, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1000       --        1025');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos397, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1025       --        1050');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos398, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1050      --        1075');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos399, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1075       --        1100');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos400, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1100       --        1125');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos401, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1125       --        1150');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos402, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1150       --        1175');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos403, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1175       --        1200');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos404, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1200       --        1225');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos405, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1225       --        1250');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos406, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1250       --        1275');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size10(4)-pos407, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1275       --        1300');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource10 = handles2.panelMain;
    
    pos408 = 8740;
    pos409 = 8760;
    pos410 = 8780;
    pos411 = 8800;
    pos412 = 8820;
    pos413 = 8840;
    pos414 = 8860;
    pos415 = 8880;
    pos416 = 8900;

    panel_size11 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size10(4)-pos407, 1, pos407], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    
    pos408 = 20;
    pos409 = 40;
    pos410 = 60;
    pos411 = 80;
    pos412 = 100;
    pos413 = 120;
    pos414 = 140;
    pos415 = 160;
    pos416 = 180;

    window_size11 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos416]);
    hdef11 = figure('units', 'pixels', 'position', window_size11, ...
        'Color', [1 1 1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'to delete', ...
        'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(hdef11), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;

    panelMain11 = uipanel('parent', hdef11, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, pos416], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain11, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size11 = [1, 10, 1200, pos416];
    figSource10 = panelMain11;
end;

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos408, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1300       --        1325');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos409, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1325       --        1350');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos410, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1350       --        1375');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos411, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1375       --        1400');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos412, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1400       --        1425');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos413, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1425       --        1450');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos414, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1450       --        1475');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos415, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '1475       --        1500');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Averages / Totals';
txtCol1Z_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size11(4)-pos416, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'Fontsize', font4, 'String', txt, 'FontWeight', 'bold');
set(txtCol1Z_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size11(4)-pos416, 1, pos416-90], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    txtBlack_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size11(4)-pos416, 1, pos416], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
end;



shiftRight = 90;
bestRaceTime = [];
bestSkillTime = [];
bestFreeSwimTime = [];
bestVelocity = [];
bestBlock = [];
bestStartTime = [];
best25m = [];
bestFinish = [];
bestTurnTot = [];
bestTurnIn = [];
bestTurnOut = [];
bestTurnAv = [];
nbRaces = length(databaseCurrent(:,1));
for raceECmain = 3:nbRaces+2;
    
    %----------------------------get the data------------------------------
    Source = databaseCurrent{raceECmain-2,58};
    dataTableRefDist = [5:5:RaceDist]';
    if Source == 1 | Source == 3;
        metaData_PDF = databaseCurrent{raceECmain-2,67};
        dataTablePacing = databaseCurrent{raceECmain-2,68};
        dataTableBreath = databaseCurrent{raceECmain-2,69};
        dataTableStroke = databaseCurrent{raceECmain-2,70};
        dataTableSkill = databaseCurrent{raceECmain-2,71};

    elseif Source == 2;
        metaData_PDF = databaseCurrent{raceECmain-2,67};
        dataTableAverage = databaseCurrent{raceECmain-2,68};
        dataTableBreath = databaseCurrent{raceECmain-2,69};
        dataTableSkillVAL = databaseCurrent{raceECmain-2,70};
        dataTableSkillTXT = databaseCurrent{raceECmain-2,71};
    end;

    if Source == 1;
        answerReport = 'SP1';
    elseif Source == 2;
        answerReport = 'SP2';
    elseif Source == 3;
        answerReport = 'GE';
    end;

    %---Metadata
    relayExist = databaseCurrent{raceECmain-2,11};
    if isempty(strfind(relayExist, 'Relay')) == 0;
        isRelay = 1;
    else;
        isRelay = 0;
    end;
    if isRelay == 1;
        relayLeg = databaseCurrent{raceECmain-2,11};
        index1 = strfind(relayLeg, '(');
        index2 = strfind(relayLeg, ')');
        relayLeg = relayLeg(index1+1:index2-1);
        RelayType = [databaseCurrent{raceECmain-2,53} ' (' relayLeg ')'];
    else;
        RelayType = 'Individual';
    end;
    
    AthletenameFull = databaseCurrent{raceECmain-2,2};
    index = strfind(AthletenameFull, ' ');
    Athletename = [AthletenameFull(index(end)+1:end) AthletenameFull(1)];
    Meet = databaseCurrent{raceECmain-2,7};
    Stage = databaseCurrent{raceECmain-2,6};
    Year = databaseCurrent{raceECmain-2,8};
    StrokeType = databaseCurrent{raceECmain-2,4};
    RaceDist = str2num(databaseCurrent{raceECmain-2,3});
    Course = str2num(databaseCurrent{raceECmain-2,10});
    AgeGroup = metaData_PDF{2,1}; %DOB
    Venue = metaData_PDF{3,1};
    AnalysisDate = metaData_PDF{4,1};
    RaceDate = metaData_PDF{7,1};
    KicksNb = databaseCurrent{raceECmain-2,64};
    if Source == 1 | Source == 3;
        DiveT15 = dataTableSkill{15,3};
        index = strfind(DiveT15, ' ');
        DiveT15 = str2num(DiveT15(1:index(1)-1));
    elseif Source == 2;
        DiveT15 = dataTableSkillVAL{1,5};
    end;

    idx = isstrprop(Meet,'upper');
    MeetShort = Meet(idx);
    if strcmpi(Stage, 'SemiFinal');
        StageShort = 'SF';
    elseif strcmpi(Stage, 'Semi-final');
        StageShort = 'SF';
    else;
        StageShort = Stage;
    end;
    if strcmpi(lower(StrokeType), 'freestyle');
        StrokeShort = 'FS';
    elseif strcmpi(lower(StrokeType), 'medley');
        StrokeShort = 'IM';
    elseif strcmpi(lower(StrokeType), 'backstroke');
        StrokeShort = 'BK';
    elseif strcmpi(lower(StrokeType), 'breaststroke');
        StrokeShort = 'BR';
    elseif strcmpi(lower(StrokeType), 'butterfly');
        StrokeShort = 'BF';
    end;
        
    filename = [Athletename '_' num2str(RaceDist) StrokeShort '_' MeetShort Year '_' StageShort '_SP1'];
    
    if Course == 25;
        Race = [num2str(RaceDist) 'm ' StrokeType ' (SCM)'];
    else;
        Race = [num2str(RaceDist) 'm ' StrokeType ' (LCM)'];
    end;
    Round = [AgeGroup ' - ' Stage];

    if Source == 1 | Source == 3;
        AnalysisDate = ['Swim created at ' AnalysisDate];
    elseif Source == 2;
        li1 = strfind(AnalysisDate, 'T');
        li2 = strfind(AnalysisDate, '.');
        AnalysisDate = AnalysisDate(1:li1-1);
        AnalysisDate = [AnalysisDate(9:10) '-' AnalysisDate(6:7) '-' AnalysisDate(1:4)];
        AnalysisDate = ['Swim created at ' AnalysisDate];
    end;
    
    index = strfind(AgeGroup, '/');
    dateDiff(1) = datetime(str2num(AgeGroup(index(2)+1:end)), str2num(AgeGroup(index(1)+1:index(2)-1)), str2num(AgeGroup(1:index(1)-1)));
    index = strfind(RaceDate, '-');
    dateDiff(2) = datetime(str2num(RaceDate(1:index(1)-1)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(index(2)+1:end)));
    [DYear, DMonth, DDay] = split(caldiff(dateDiff, {'years';'months';'days'}), {'years';'months';'days'});

    if DYear > 18;
        AgeGroup = 'Open';
    elseif DYear <= 18 & DYear > 17;
        AgeGroup = '18y';
    elseif DYear <= 17 & DYear > 16;
        AgeGroup = '17y';
    elseif DYear <= 16 & DYear > 15;
        AgeGroup = '16y';
    elseif DYear <= 15 & DYear > 14;
        AgeGroup = '15y';
    elseif DYear <= 14 & DYear > 13;
        AgeGroup = '14y';
    else;
        AgeGroup = '13y & under';
    end;
    
    t = now;
    ReportDate = ['Report last generated at ' datestr(datetime(t,'ConvertFrom','datenum'))];

    %---Get splits & skills
    BOAllINI = [];
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        %its a 200m so that long intervals col = 3
        colinterest_Splits = 3;
        colinterest_SplitsInterp = 4;
        if dataTablePacing(3,colinterest_SplitsInterp) == 1;
            Split15m = [timeSecToStr2(dataTablePacing(3,colinterest_Splits)) ' !'];
        else;
            Split15m = timeSecToStr2(dataTablePacing(3,colinterest_Splits));
        end;
        
        if dataTablePacing(5,colinterest_SplitsInterp) == 1;
            Split25m = [timeSecToStr2(dataTablePacing(5,colinterest_Splits)) '!'];
        else;
            Split25m = timeSecToStr2(dataTablePacing(5,colinterest_Splits));
        end;
        best25m = [best25m dataTablePacing(5,colinterest_Splits)];
        
        Split50m = timeSecToStr2(dataTablePacing(10,colinterest_Splits));
        Split75m = timeSecToStr2(dataTablePacing(15,colinterest_Splits));
        Split100m = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
        Split125m = timeSecToStr2(dataTablePacing(25,colinterest_Splits));
        Split150m = timeSecToStr2(dataTablePacing(30,colinterest_Splits));
        Split175m = timeSecToStr2(dataTablePacing(35,colinterest_Splits));
        Split200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits));
        Split225m = timeSecToStr2(dataTablePacing(45,colinterest_Splits));
        Split250m = timeSecToStr2(dataTablePacing(50,colinterest_Splits));
        Split275m = timeSecToStr2(dataTablePacing(55,colinterest_Splits));
        Split300m = timeSecToStr2(dataTablePacing(60,colinterest_Splits));
        Split325m = timeSecToStr2(dataTablePacing(65,colinterest_Splits));
        Split350m = timeSecToStr2(dataTablePacing(70,colinterest_Splits));
        Split375m = timeSecToStr2(dataTablePacing(75,colinterest_Splits));
        Split400m = timeSecToStr2(dataTablePacing(80,colinterest_Splits));
        Split425m = timeSecToStr2(dataTablePacing(85,colinterest_Splits));
        Split450m = timeSecToStr2(dataTablePacing(90,colinterest_Splits));
        Split475m = timeSecToStr2(dataTablePacing(95,colinterest_Splits));
        Split500m = timeSecToStr2(dataTablePacing(100,colinterest_Splits));
        Split525m = timeSecToStr2(dataTablePacing(105,colinterest_Splits));
        Split550m = timeSecToStr2(dataTablePacing(110,colinterest_Splits));
        Split575m = timeSecToStr2(dataTablePacing(115,colinterest_Splits));
        Split600m = timeSecToStr2(dataTablePacing(120,colinterest_Splits));
        Split625m = timeSecToStr2(dataTablePacing(125,colinterest_Splits));
        Split650m = timeSecToStr2(dataTablePacing(130,colinterest_Splits));
        Split675m = timeSecToStr2(dataTablePacing(135,colinterest_Splits));
        Split700m = timeSecToStr2(dataTablePacing(140,colinterest_Splits));
        Split725m = timeSecToStr2(dataTablePacing(145,colinterest_Splits));
        Split750m = timeSecToStr2(dataTablePacing(150,colinterest_Splits));
        Split775m = timeSecToStr2(dataTablePacing(155,colinterest_Splits));
        Split800m = timeSecToStr2(dataTablePacing(160,colinterest_Splits));
        Split825m = timeSecToStr2(dataTablePacing(165,colinterest_Splits));
        Split850m = timeSecToStr2(dataTablePacing(170,colinterest_Splits));
        Split875m = timeSecToStr2(dataTablePacing(175,colinterest_Splits));
        Split900m = timeSecToStr2(dataTablePacing(180,colinterest_Splits));
        Split925m = timeSecToStr2(dataTablePacing(185,colinterest_Splits));
        Split950m = timeSecToStr2(dataTablePacing(190,colinterest_Splits));
        Split975m = timeSecToStr2(dataTablePacing(195,colinterest_Splits));
        Split1000m = timeSecToStr2(dataTablePacing(200,colinterest_Splits));
        Split1025m = timeSecToStr2(dataTablePacing(205,colinterest_Splits));
        Split1050m = timeSecToStr2(dataTablePacing(210,colinterest_Splits));
        Split1075m = timeSecToStr2(dataTablePacing(215,colinterest_Splits));
        Split1100m = timeSecToStr2(dataTablePacing(220,colinterest_Splits));
        Split1125m = timeSecToStr2(dataTablePacing(225,colinterest_Splits));
        Split1150m = timeSecToStr2(dataTablePacing(230,colinterest_Splits));
        Split1175m = timeSecToStr2(dataTablePacing(235,colinterest_Splits));
        Split1200m = timeSecToStr2(dataTablePacing(240,colinterest_Splits));
        Split1225m = timeSecToStr2(dataTablePacing(245,colinterest_Splits));
        Split1250m = timeSecToStr2(dataTablePacing(250,colinterest_Splits));
        Split1275m = timeSecToStr2(dataTablePacing(255,colinterest_Splits));
        Split1300m = timeSecToStr2(dataTablePacing(260,colinterest_Splits));
        Split1325m = timeSecToStr2(dataTablePacing(265,colinterest_Splits));
        Split1350m = timeSecToStr2(dataTablePacing(270,colinterest_Splits));
        Split1375m = timeSecToStr2(dataTablePacing(275,colinterest_Splits));
        Split1400m = timeSecToStr2(dataTablePacing(280,colinterest_Splits));
        Split1425m = timeSecToStr2(dataTablePacing(285,colinterest_Splits));
        Split1450m = timeSecToStr2(dataTablePacing(290,colinterest_Splits));
        Split1475m = timeSecToStr2(dataTablePacing(295,colinterest_Splits));
        Split1500m = timeSecToStr2(dataTablePacing(300,colinterest_Splits));
        
        SplitLap1_25 = timeSecToStr2(dataTablePacing(5,colinterest_Splits));
        SplitLap2_25 = timeSecToStr2(dataTablePacing(10,colinterest_Splits) - dataTablePacing(5,colinterest_Splits));
        SplitLap3_25 = timeSecToStr2(dataTablePacing(15,colinterest_Splits) - dataTablePacing(10,colinterest_Splits));
        SplitLap4_25 = timeSecToStr2(dataTablePacing(20,colinterest_Splits) - dataTablePacing(15,colinterest_Splits));
        SplitLap5_25 = timeSecToStr2(dataTablePacing(25,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
        SplitLap6_25 = timeSecToStr2(dataTablePacing(30,colinterest_Splits) - dataTablePacing(25,colinterest_Splits));
        SplitLap7_25 = timeSecToStr2(dataTablePacing(35,colinterest_Splits) - dataTablePacing(30,colinterest_Splits));
        SplitLap8_25 = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(35,colinterest_Splits));
        SplitLap9_25 = timeSecToStr2(dataTablePacing(45,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap10_25 = timeSecToStr2(dataTablePacing(50,colinterest_Splits) - dataTablePacing(45,colinterest_Splits));
        SplitLap11_25 = timeSecToStr2(dataTablePacing(55,colinterest_Splits) - dataTablePacing(50,colinterest_Splits));
        SplitLap12_25 = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(55,colinterest_Splits));
        SplitLap13_25 = timeSecToStr2(dataTablePacing(65,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
        SplitLap14_25 = timeSecToStr2(dataTablePacing(70,colinterest_Splits) - dataTablePacing(65,colinterest_Splits));
        SplitLap15_25 = timeSecToStr2(dataTablePacing(75,colinterest_Splits) - dataTablePacing(70,colinterest_Splits));
        SplitLap16_25 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(75,colinterest_Splits));
        SplitLap17_25 = timeSecToStr2(dataTablePacing(85,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap18_25 = timeSecToStr2(dataTablePacing(90,colinterest_Splits) - dataTablePacing(85,colinterest_Splits));
        SplitLap19_25 = timeSecToStr2(dataTablePacing(95,colinterest_Splits) - dataTablePacing(90,colinterest_Splits));
        SplitLap20_25 = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(95,colinterest_Splits));
        SplitLap21_25 = timeSecToStr2(dataTablePacing(105,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
        SplitLap22_25 = timeSecToStr2(dataTablePacing(110,colinterest_Splits) - dataTablePacing(105,colinterest_Splits));
        SplitLap23_25 = timeSecToStr2(dataTablePacing(115,colinterest_Splits) - dataTablePacing(110,colinterest_Splits));
        SplitLap24_25 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(115,colinterest_Splits));
        SplitLap25_25 = timeSecToStr2(dataTablePacing(125,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
        SplitLap26_25 = timeSecToStr2(dataTablePacing(130,colinterest_Splits) - dataTablePacing(125,colinterest_Splits));
        SplitLap27_25 = timeSecToStr2(dataTablePacing(135,colinterest_Splits) - dataTablePacing(130,colinterest_Splits));
        SplitLap28_25 = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(135,colinterest_Splits));
        SplitLap29_25 = timeSecToStr2(dataTablePacing(145,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));
        SplitLap30_25 = timeSecToStr2(dataTablePacing(150,colinterest_Splits) - dataTablePacing(145,colinterest_Splits));
        SplitLap31_25 = timeSecToStr2(dataTablePacing(155,colinterest_Splits) - dataTablePacing(150,colinterest_Splits));
        SplitLap32_25 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(155,colinterest_Splits));
        SplitLap33_25 = timeSecToStr2(dataTablePacing(165,colinterest_Splits) - dataTablePacing(160,colinterest_Splits));
        SplitLap34_25 = timeSecToStr2(dataTablePacing(170,colinterest_Splits) - dataTablePacing(165,colinterest_Splits));
        SplitLap35_25 = timeSecToStr2(dataTablePacing(175,colinterest_Splits) - dataTablePacing(170,colinterest_Splits));
        SplitLap36_25 = timeSecToStr2(dataTablePacing(180,colinterest_Splits) - dataTablePacing(175,colinterest_Splits));
        SplitLap37_25 = timeSecToStr2(dataTablePacing(185,colinterest_Splits) - dataTablePacing(180,colinterest_Splits));
        SplitLap38_25 = timeSecToStr2(dataTablePacing(190,colinterest_Splits) - dataTablePacing(185,colinterest_Splits));
        SplitLap39_25 = timeSecToStr2(dataTablePacing(195,colinterest_Splits) - dataTablePacing(190,colinterest_Splits));
        SplitLap40_25 = timeSecToStr2(dataTablePacing(200,colinterest_Splits) - dataTablePacing(195,colinterest_Splits));
        SplitLap41_25 = timeSecToStr2(dataTablePacing(205,colinterest_Splits) - dataTablePacing(200,colinterest_Splits));
        SplitLap42_25 = timeSecToStr2(dataTablePacing(210,colinterest_Splits) - dataTablePacing(205,colinterest_Splits));
        SplitLap43_25 = timeSecToStr2(dataTablePacing(215,colinterest_Splits) - dataTablePacing(210,colinterest_Splits));
        SplitLap44_25 = timeSecToStr2(dataTablePacing(220,colinterest_Splits) - dataTablePacing(215,colinterest_Splits));
        SplitLap45_25 = timeSecToStr2(dataTablePacing(225,colinterest_Splits) - dataTablePacing(220,colinterest_Splits));
        SplitLap46_25 = timeSecToStr2(dataTablePacing(230,colinterest_Splits) - dataTablePacing(225,colinterest_Splits));
        SplitLap47_25 = timeSecToStr2(dataTablePacing(235,colinterest_Splits) - dataTablePacing(230,colinterest_Splits));
        SplitLap48_25 = timeSecToStr2(dataTablePacing(240,colinterest_Splits) - dataTablePacing(235,colinterest_Splits));
        SplitLap49_25 = timeSecToStr2(dataTablePacing(245,colinterest_Splits) - dataTablePacing(240,colinterest_Splits));
        SplitLap50_25 = timeSecToStr2(dataTablePacing(250,colinterest_Splits) - dataTablePacing(245,colinterest_Splits));
        SplitLap51_25 = timeSecToStr2(dataTablePacing(255,colinterest_Splits) - dataTablePacing(250,colinterest_Splits));
        SplitLap52_25 = timeSecToStr2(dataTablePacing(260,colinterest_Splits) - dataTablePacing(255,colinterest_Splits));
        SplitLap53_25 = timeSecToStr2(dataTablePacing(265,colinterest_Splits) - dataTablePacing(260,colinterest_Splits));
        SplitLap54_25 = timeSecToStr2(dataTablePacing(270,colinterest_Splits) - dataTablePacing(265,colinterest_Splits));
        SplitLap55_25 = timeSecToStr2(dataTablePacing(275,colinterest_Splits) - dataTablePacing(270,colinterest_Splits));
        SplitLap56_25 = timeSecToStr2(dataTablePacing(280,colinterest_Splits) - dataTablePacing(275,colinterest_Splits));
        SplitLap57_25 = timeSecToStr2(dataTablePacing(285,colinterest_Splits) - dataTablePacing(280,colinterest_Splits));
        SplitLap58_25 = timeSecToStr2(dataTablePacing(290,colinterest_Splits) - dataTablePacing(285,colinterest_Splits));
        SplitLap59_25 = timeSecToStr2(dataTablePacing(295,colinterest_Splits) - dataTablePacing(290,colinterest_Splits));
        SplitLap60_25 = timeSecToStr2(dataTablePacing(300,colinterest_Splits) - dataTablePacing(295,colinterest_Splits));

    
        SplitLap1_50 = timeSecToStr2(dataTablePacing(10,colinterest_Splits));
        SplitLap2_50 = timeSecToStr2(dataTablePacing(20,colinterest_Splits) - dataTablePacing(10,colinterest_Splits));
        SplitLap3_50 = timeSecToStr2(dataTablePacing(30,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
        SplitLap4_50 = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(30,colinterest_Splits));
        SplitLap5_50 = timeSecToStr2(dataTablePacing(50,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap6_50 = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(50,colinterest_Splits));
        SplitLap7_50 = timeSecToStr2(dataTablePacing(70,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
        SplitLap8_50 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(70,colinterest_Splits));
        SplitLap9_50 = timeSecToStr2(dataTablePacing(90,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap10_50 = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(90,colinterest_Splits));
        SplitLap11_50 = timeSecToStr2(dataTablePacing(110,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
        SplitLap12_50 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(110,colinterest_Splits));
        SplitLap13_50 = timeSecToStr2(dataTablePacing(130,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
        SplitLap14_50 = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(130,colinterest_Splits));
        SplitLap15_50 = timeSecToStr2(dataTablePacing(150,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));
        SplitLap16_50 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(150,colinterest_Splits));
        SplitLap17_50 = timeSecToStr2(dataTablePacing(170,colinterest_Splits) - dataTablePacing(160,colinterest_Splits));
        SplitLap18_50 = timeSecToStr2(dataTablePacing(180,colinterest_Splits) - dataTablePacing(170,colinterest_Splits));
        SplitLap19_50 = timeSecToStr2(dataTablePacing(190,colinterest_Splits) - dataTablePacing(180,colinterest_Splits));
        SplitLap20_50 = timeSecToStr2(dataTablePacing(200,colinterest_Splits) - dataTablePacing(190,colinterest_Splits));
        SplitLap21_50 = timeSecToStr2(dataTablePacing(210,colinterest_Splits) - dataTablePacing(200,colinterest_Splits));
        SplitLap22_50 = timeSecToStr2(dataTablePacing(220,colinterest_Splits) - dataTablePacing(210,colinterest_Splits));
        SplitLap23_50 = timeSecToStr2(dataTablePacing(230,colinterest_Splits) - dataTablePacing(220,colinterest_Splits));
        SplitLap24_50 = timeSecToStr2(dataTablePacing(240,colinterest_Splits) - dataTablePacing(230,colinterest_Splits));
        SplitLap25_50 = timeSecToStr2(dataTablePacing(250,colinterest_Splits) - dataTablePacing(240,colinterest_Splits));
        SplitLap26_50 = timeSecToStr2(dataTablePacing(260,colinterest_Splits) - dataTablePacing(250,colinterest_Splits));
        SplitLap27_50 = timeSecToStr2(dataTablePacing(270,colinterest_Splits) - dataTablePacing(260,colinterest_Splits));
        SplitLap28_50 = timeSecToStr2(dataTablePacing(280,colinterest_Splits) - dataTablePacing(270,colinterest_Splits));
        SplitLap29_50 = timeSecToStr2(dataTablePacing(290,colinterest_Splits) - dataTablePacing(280,colinterest_Splits));
        SplitLap30_50 = timeSecToStr2(dataTablePacing(300,colinterest_Splits) - dataTablePacing(290,colinterest_Splits));


        SplitLap1_100 = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
        SplitLap2_100 = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
        SplitLap3_100 = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap4_100 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
        SplitLap5_100 = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap6_100 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
        SplitLap7_100 = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
        SplitLap8_100 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));
        SplitLap9_100 = timeSecToStr2(dataTablePacing(180,colinterest_Splits) - dataTablePacing(160,colinterest_Splits));
        SplitLap10_100 = timeSecToStr2(dataTablePacing(200,colinterest_Splits) - dataTablePacing(180,colinterest_Splits));
        SplitLap11_100 = timeSecToStr2(dataTablePacing(220,colinterest_Splits) - dataTablePacing(200,colinterest_Splits));
        SplitLap12_100 = timeSecToStr2(dataTablePacing(240,colinterest_Splits) - dataTablePacing(220,colinterest_Splits));
        SplitLap13_100 = timeSecToStr2(dataTablePacing(260,colinterest_Splits) - dataTablePacing(240,colinterest_Splits));
        SplitLap14_100 = timeSecToStr2(dataTablePacing(280,colinterest_Splits) - dataTablePacing(260,colinterest_Splits));
        SplitLap15_100 = timeSecToStr2(dataTablePacing(300,colinterest_Splits) - dataTablePacing(280,colinterest_Splits));

        
        SplitLap1_200 = timeSecToStr2(dataTablePacing(40,colinterest_Splits));
        SplitLap2_200 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap3_200 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap4_200 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
        SplitLap5_200 = timeSecToStr2(dataTablePacing(200,colinterest_Splits) - dataTablePacing(160,colinterest_Splits));
        SplitLap6_200 = timeSecToStr2(dataTablePacing(240,colinterest_Splits) - dataTablePacing(200,colinterest_Splits));
        SplitLap7_200 = timeSecToStr2(dataTablePacing(280,colinterest_Splits) - dataTablePacing(240,colinterest_Splits));

        SplitLap1_500 = timeSecToStr2(dataTablePacing(100,colinterest_Splits));
        SplitLap2_500 = timeSecToStr2(dataTablePacing(200,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
        SplitLap3_500 = timeSecToStr2(dataTablePacing(300,colinterest_Splits) - dataTablePacing(200,colinterest_Splits));


        RaceTime = timeSecToStr2(dataTablePacing(end,colinterest_Splits));
        bestRaceTime = [bestRaceTime dataTablePacing(end,colinterest_Splits)];

        bestStartTime = [bestStartTime DiveT15];
        StartTime = dataToStr(DiveT15,2);
        if dataTablePacing(3,colinterest_SplitsInterp) == 1;
            StartTime = [StartTime ' !'];
        end;
        
        Time25m = Split25m;
        if dataTablePacing(5,colinterest_SplitsInterp) == 1;
            Time25m = [Time25m ' !'];
        end;
    
        valFinishTime = dataTableSkill{end-1,3};
        index = strfind(valFinishTime, ' ');
        valFinishTime = str2num(valFinishTime(1:index(1)-1));
        FinishTime = timeSecToStr2(valFinishTime);
        bestFinish = [bestFinish valFinishTime];
        RT = dataTableSkill{16,3};
        index = strfind(RT, ' ');
        RT = str2num(RT(1:index(1)-1));

        BOKick_Start = dataTableSkill{21,3};
        index = strfind(BOKick_Start, ' ');
        BOKick_Start = str2num(BOKick_Start(1:index(1)));

        BOTime_Start = dataTableSkill{23,3};
        index1 = strfind(BOTime_Start, ' ');
        index2 = strfind(BOTime_Start, 's');
        index3 = strfind(BOTime_Start, '!');
        if isempty(index3) == 0;
            interpolationBOTime_Start = 1;
        else;
            interpolationBOTime_Start = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BOTime_Start(index) = [];
        end;
        BOTime_Start = str2num(BOTime_Start);

        BODist_Start = dataTableSkill{22,3};
        index1 = strfind(BODist_Start, ' ');
        index2 = strfind(BODist_Start, 'm');
        index3 = strfind(BODist_Start, '!');
        if isempty(index3) == 0;
            interpolationBODist_Start = 1;
        else;
            interpolationBODist_Start = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BODist_Start(index) = [];
        end;
        BODist_Start = str2num(BODist_Start);
        BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

    elseif strcmpi(answerReport, 'SP2') == 1;
        %take col = 12 for long intervals
        Split25m = timeSecToStr2(dataTableAverage{5,12});
        Split50m = timeSecToStr2(dataTableAverage{10,12});
        Split75m = timeSecToStr2(dataTableAverage{15,12});
        Split100m = timeSecToStr2(dataTableAverage{20,12});
        Split125m = timeSecToStr2(dataTableAverage{25,12});
        Split150m = timeSecToStr2(dataTableAverage{30,12});
        Split175m = timeSecToStr2(dataTableAverage{35,12});
        Split200m = timeSecToStr2(dataTableAverage{40,12});
        Split225m = timeSecToStr2(dataTableAverage{45,12});
        Split250m = timeSecToStr2(dataTableAverage{50,12});
        Split275m = timeSecToStr2(dataTableAverage{55,12});
        Split300m = timeSecToStr2(dataTableAverage{60,12});
        Split325m = timeSecToStr2(dataTableAverage{65,12});
        Split350m = timeSecToStr2(dataTableAverage{70,12});
        Split375m = timeSecToStr2(dataTableAverage{75,12});
        Split400m = timeSecToStr2(dataTableAverage{80,12});
        Split425m = timeSecToStr2(dataTableAverage{85,12});
        Split450m = timeSecToStr2(dataTableAverage{90,12});
        Split475m = timeSecToStr2(dataTableAverage{95,12});
        Split500m = timeSecToStr2(dataTableAverage{100,12});
        Split525m = timeSecToStr2(dataTableAverage{105,12});
        Split550m = timeSecToStr2(dataTableAverage{110,12});
        Split575m = timeSecToStr2(dataTableAverage{115,12});
        Split600m = timeSecToStr2(dataTableAverage{120,12});
        Split625m = timeSecToStr2(dataTableAverage{125,12});
        Split650m = timeSecToStr2(dataTableAverage{130,12});
        Split675m = timeSecToStr2(dataTableAverage{135,12});
        Split700m = timeSecToStr2(dataTableAverage{140,12});
        Split725m = timeSecToStr2(dataTableAverage{145,12});
        Split750m = timeSecToStr2(dataTableAverage{150,12});
        Split775m = timeSecToStr2(dataTableAverage{155,12});
        Split800m = timeSecToStr2(dataTableAverage{160,12});
        Split825m = timeSecToStr2(dataTableAverage{165,12});
        Split850m = timeSecToStr2(dataTableAverage{170,12});
        Split875m = timeSecToStr2(dataTableAverage{175,12});
        Split900m = timeSecToStr2(dataTableAverage{180,12});
        Split925m = timeSecToStr2(dataTableAverage{185,12});
        Split950m = timeSecToStr2(dataTableAverage{190,12});
        Split975m = timeSecToStr2(dataTableAverage{195,12});
        Split1000m = timeSecToStr2(dataTableAverage{200,12});
        Split1025m = timeSecToStr2(dataTableAverage{205,12});
        Split1050m = timeSecToStr2(dataTableAverage{210,12});
        Split1075m = timeSecToStr2(dataTableAverage{215,12});
        Split1100m = timeSecToStr2(dataTableAverage{220,12});
        Split1125m = timeSecToStr2(dataTableAverage{225,12});
        Split1150m = timeSecToStr2(dataTableAverage{230,12});
        Split1175m = timeSecToStr2(dataTableAverage{235,12});
        Split1200m = timeSecToStr2(dataTableAverage{240,12});
        Split1225m = timeSecToStr2(dataTableAverage{245,12});
        Split1250m = timeSecToStr2(dataTableAverage{250,12});
        Split1275m = timeSecToStr2(dataTableAverage{255,12});
        Split1300m = timeSecToStr2(dataTableAverage{260,12});
        Split1325m = timeSecToStr2(dataTableAverage{265,12});
        Split1350m = timeSecToStr2(dataTableAverage{270,12});
        Split1375m = timeSecToStr2(dataTableAverage{275,12});
        Split1400m = timeSecToStr2(dataTableAverage{280,12});
        Split1425m = timeSecToStr2(dataTableAverage{285,12});
        Split1450m = timeSecToStr2(dataTableAverage{290,12});
        Split1475m = timeSecToStr2(dataTableAverage{295,12});
        Split1500m = timeSecToStr2(dataTableAverage{300,12});

        
        bestRaceTime = [bestRaceTime dataTableAverage{300,12}];
        RaceTime = Split1500m;
        SplitLap1_25 = timeSecToStr2(dataTableAverage{5,12});
        SplitLap2_25 = timeSecToStr2(dataTableAverage{10,12}-dataTableAverage{5,12});
        SplitLap3_25 = timeSecToStr2(dataTableAverage{15,12}-dataTableAverage{10,12});
        SplitLap4_25 = timeSecToStr2(dataTableAverage{20,12}-dataTableAverage{15,12});
        SplitLap5_25 = timeSecToStr2(dataTableAverage{25,12}-dataTableAverage{20,12});
        SplitLap6_25 = timeSecToStr2(dataTableAverage{30,12}-dataTableAverage{25,12});
        SplitLap7_25 = timeSecToStr2(dataTableAverage{35,12}-dataTableAverage{30,12});
        SplitLap8_25 = timeSecToStr2(dataTableAverage{40,12}-dataTableAverage{35,12});
        SplitLap9_25 = timeSecToStr2(dataTableAverage{45,12}-dataTableAverage{40,12});
        SplitLap10_25 = timeSecToStr2(dataTableAverage{50,12}-dataTableAverage{45,12});
        SplitLap11_25 = timeSecToStr2(dataTableAverage{55,12}-dataTableAverage{50,12});
        SplitLap12_25 = timeSecToStr2(dataTableAverage{60,12}-dataTableAverage{55,12});
        SplitLap13_25 = timeSecToStr2(dataTableAverage{65,12}-dataTableAverage{60,12});
        SplitLap14_25 = timeSecToStr2(dataTableAverage{70,12}-dataTableAverage{65,12});
        SplitLap15_25 = timeSecToStr2(dataTableAverage{75,12}-dataTableAverage{70,12});
        SplitLap16_25 = timeSecToStr2(dataTableAverage{80,12}-dataTableAverage{75,12});
        SplitLap17_25 = timeSecToStr2(dataTableAverage{85,12}-dataTableAverage{80,12});
        SplitLap18_25 = timeSecToStr2(dataTableAverage{90,12}-dataTableAverage{85,12});
        SplitLap19_25 = timeSecToStr2(dataTableAverage{95,12}-dataTableAverage{90,12});
        SplitLap20_25 = timeSecToStr2(dataTableAverage{100,12}-dataTableAverage{95,12});
        SplitLap21_25 = timeSecToStr2(dataTableAverage{105,12}-dataTableAverage{100,12});
        SplitLap22_25 = timeSecToStr2(dataTableAverage{110,12}-dataTableAverage{105,12});
        SplitLap23_25 = timeSecToStr2(dataTableAverage{115,12}-dataTableAverage{110,12});
        SplitLap24_25 = timeSecToStr2(dataTableAverage{120,12}-dataTableAverage{115,12});
        SplitLap25_25 = timeSecToStr2(dataTableAverage{125,12}-dataTableAverage{120,12});
        SplitLap26_25 = timeSecToStr2(dataTableAverage{130,12}-dataTableAverage{125,12});
        SplitLap27_25 = timeSecToStr2(dataTableAverage{135,12}-dataTableAverage{130,12});
        SplitLap28_25 = timeSecToStr2(dataTableAverage{140,12}-dataTableAverage{135,12});
        SplitLap29_25 = timeSecToStr2(dataTableAverage{145,12}-dataTableAverage{140,12});
        SplitLap30_25 = timeSecToStr2(dataTableAverage{150,12}-dataTableAverage{145,12});
        SplitLap31_25 = timeSecToStr2(dataTableAverage{155,12}-dataTableAverage{150,12});
        SplitLap32_25 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{155,12});
        SplitLap33_25 = timeSecToStr2(dataTableAverage{165,12}-dataTableAverage{160,12});
        SplitLap34_25 = timeSecToStr2(dataTableAverage{170,12}-dataTableAverage{165,12});
        SplitLap35_25 = timeSecToStr2(dataTableAverage{175,12}-dataTableAverage{170,12});
        SplitLap36_25 = timeSecToStr2(dataTableAverage{180,12}-dataTableAverage{175,12});
        SplitLap37_25 = timeSecToStr2(dataTableAverage{185,12}-dataTableAverage{180,12});
        SplitLap38_25 = timeSecToStr2(dataTableAverage{190,12}-dataTableAverage{185,12});
        SplitLap39_25 = timeSecToStr2(dataTableAverage{195,12}-dataTableAverage{190,12});
        SplitLap40_25 = timeSecToStr2(dataTableAverage{200,12}-dataTableAverage{195,12});
        SplitLap41_25 = timeSecToStr2(dataTableAverage{205,12}-dataTableAverage{200,12});
        SplitLap42_25 = timeSecToStr2(dataTableAverage{210,12}-dataTableAverage{205,12});
        SplitLap43_25 = timeSecToStr2(dataTableAverage{215,12}-dataTableAverage{210,12});
        SplitLap44_25 = timeSecToStr2(dataTableAverage{220,12}-dataTableAverage{215,12});
        SplitLap45_25 = timeSecToStr2(dataTableAverage{225,12}-dataTableAverage{220,12});
        SplitLap46_25 = timeSecToStr2(dataTableAverage{230,12}-dataTableAverage{225,12});
        SplitLap47_25 = timeSecToStr2(dataTableAverage{235,12}-dataTableAverage{230,12});
        SplitLap48_25 = timeSecToStr2(dataTableAverage{240,12}-dataTableAverage{235,12});
        SplitLap49_25 = timeSecToStr2(dataTableAverage{245,12}-dataTableAverage{240,12});
        SplitLap50_25 = timeSecToStr2(dataTableAverage{250,12}-dataTableAverage{245,12});
        SplitLap51_25 = timeSecToStr2(dataTableAverage{255,12}-dataTableAverage{250,12});
        SplitLap52_25 = timeSecToStr2(dataTableAverage{260,12}-dataTableAverage{255,12});
        SplitLap53_25 = timeSecToStr2(dataTableAverage{265,12}-dataTableAverage{260,12});
        SplitLap54_25 = timeSecToStr2(dataTableAverage{270,12}-dataTableAverage{265,12});
        SplitLap55_25 = timeSecToStr2(dataTableAverage{275,12}-dataTableAverage{270,12});
        SplitLap56_25 = timeSecToStr2(dataTableAverage{280,12}-dataTableAverage{275,12});
        SplitLap57_25 = timeSecToStr2(dataTableAverage{285,12}-dataTableAverage{280,12});
        SplitLap58_25 = timeSecToStr2(dataTableAverage{290,12}-dataTableAverage{285,12});
        SplitLap59_25 = timeSecToStr2(dataTableAverage{295,12}-dataTableAverage{290,12});
        SplitLap60_25 = timeSecToStr2(dataTableAverage{300,12}-dataTableAverage{295,12});


        SplitLap1_50 = timeSecToStr2(dataTableAverage{10,12});
        SplitLap2_50 = timeSecToStr2(dataTableAverage{20,12}-dataTableAverage{10,12});
        SplitLap3_50 = timeSecToStr2(dataTableAverage{30,12}-dataTableAverage{20,12});
        SplitLap4_50 = timeSecToStr2(dataTableAverage{40,12}-dataTableAverage{30,12});
        SplitLap5_50 = timeSecToStr2(dataTableAverage{50,12}-dataTableAverage{40,12});
        SplitLap6_50 = timeSecToStr2(dataTableAverage{60,12}-dataTableAverage{50,12});
        SplitLap7_50 = timeSecToStr2(dataTableAverage{70,12}-dataTableAverage{60,12});
        SplitLap8_50 = timeSecToStr2(dataTableAverage{80,12}-dataTableAverage{70,12});
        SplitLap9_50 = timeSecToStr2(dataTableAverage{90,12}-dataTableAverage{80,12});
        SplitLap10_50 = timeSecToStr2(dataTableAverage{100,12}-dataTableAverage{90,12});
        SplitLap11_50 = timeSecToStr2(dataTableAverage{110,12}-dataTableAverage{100,12});
        SplitLap12_50 = timeSecToStr2(dataTableAverage{120,12}-dataTableAverage{110,12});
        SplitLap13_50 = timeSecToStr2(dataTableAverage{130,12}-dataTableAverage{120,12});
        SplitLap14_50 = timeSecToStr2(dataTableAverage{140,12}-dataTableAverage{130,12});
        SplitLap15_50 = timeSecToStr2(dataTableAverage{150,12}-dataTableAverage{140,12});
        SplitLap16_50 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{150,12});
        SplitLap17_50 = timeSecToStr2(dataTableAverage{170,12}-dataTableAverage{160,12});
        SplitLap18_50 = timeSecToStr2(dataTableAverage{180,12}-dataTableAverage{170,12});
        SplitLap19_50 = timeSecToStr2(dataTableAverage{190,12}-dataTableAverage{180,12});
        SplitLap20_50 = timeSecToStr2(dataTableAverage{200,12}-dataTableAverage{190,12});
        SplitLap21_50 = timeSecToStr2(dataTableAverage{210,12}-dataTableAverage{200,12});
        SplitLap22_50 = timeSecToStr2(dataTableAverage{220,12}-dataTableAverage{210,12});
        SplitLap23_50 = timeSecToStr2(dataTableAverage{230,12}-dataTableAverage{220,12});
        SplitLap24_50 = timeSecToStr2(dataTableAverage{240,12}-dataTableAverage{230,12});
        SplitLap25_50 = timeSecToStr2(dataTableAverage{250,12}-dataTableAverage{240,12});
        SplitLap26_50 = timeSecToStr2(dataTableAverage{260,12}-dataTableAverage{250,12});
        SplitLap27_50 = timeSecToStr2(dataTableAverage{270,12}-dataTableAverage{260,12});
        SplitLap28_50 = timeSecToStr2(dataTableAverage{280,12}-dataTableAverage{270,12});
        SplitLap29_50 = timeSecToStr2(dataTableAverage{290,12}-dataTableAverage{280,12});
        SplitLap30_50 = timeSecToStr2(dataTableAverage{300,12}-dataTableAverage{290,12});


        SplitLap1_100 = timeSecToStr2(dataTableAverage{20,12});
        SplitLap2_100 = timeSecToStr2(dataTableAverage{40,12}-dataTableAverage{20,12});
        SplitLap3_100 = timeSecToStr2(dataTableAverage{60,12}-dataTableAverage{40,12});
        SplitLap4_100 = timeSecToStr2(dataTableAverage{80,12}-dataTableAverage{60,12});
        SplitLap5_100 = timeSecToStr2(dataTableAverage{100,12}-dataTableAverage{80,12});
        SplitLap6_100 = timeSecToStr2(dataTableAverage{120,12}-dataTableAverage{100,12});
        SplitLap7_100 = timeSecToStr2(dataTableAverage{140,12}-dataTableAverage{120,12});
        SplitLap8_100 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{140,12});
        SplitLap9_100 = timeSecToStr2(dataTableAverage{180,12}-dataTableAverage{160,12});
        SplitLap10_100 = timeSecToStr2(dataTableAverage{200,12}-dataTableAverage{180,12});
        SplitLap11_100 = timeSecToStr2(dataTableAverage{220,12}-dataTableAverage{200,12});
        SplitLap12_100 = timeSecToStr2(dataTableAverage{240,12}-dataTableAverage{220,12});
        SplitLap13_100 = timeSecToStr2(dataTableAverage{260,12}-dataTableAverage{240,12});
        SplitLap14_100 = timeSecToStr2(dataTableAverage{280,12}-dataTableAverage{260,12});
        SplitLap15_100 = timeSecToStr2(dataTableAverage{300,12}-dataTableAverage{280,12});


        SplitLap1_200 = timeSecToStr2(dataTableAverage{40,12});
        SplitLap2_200 = timeSecToStr2(dataTableAverage{80,12}-dataTableAverage{40,12});
        SplitLap3_200 = timeSecToStr2(dataTableAverage{120,12}-dataTableAverage{80,12});
        SplitLap4_200 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{120,12});
        SplitLap5_200 = timeSecToStr2(dataTableAverage{200,12}-dataTableAverage{160,12});
        SplitLap6_200 = timeSecToStr2(dataTableAverage{240,12}-dataTableAverage{200,12});
        SplitLap7_200 = timeSecToStr2(dataTableAverage{280,12}-dataTableAverage{140,12});


        SplitLap1_500 = timeSecToStr2(dataTableAverage{100,12});
        SplitLap2_500 = timeSecToStr2(dataTableAverage{200,12}-dataTableAverage{100,12});
        SplitLap3_500 = timeSecToStr2(dataTableAverage{300,12}-dataTableAverage{200,12});


        StartTime = dataToStr(DiveT15,2);
        bestStartTime = [bestStartTime DiveT15];
        Time25m = Split25m;
        best25m = [best25m dataTableAverage{5,12}];

        valFinishTime = dataTableAverage{end,12} - dataTableAverage{end-1,12};
        FinishTime = timeSecToStr2(valFinishTime);
        bestFinish = [bestFinish valFinishTime];
        RT = dataTableSkillVAL{1,22};
        BOAll = dataTableSkillVAL{1,24};
        BOKick_Start = KicksNb(1,1);
        BOTime_Start = BOAll(1,2);
        BODist_Start = BOAll(1,3);
        BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

        interpolationBODist_Start = 0;
        interpolationBOTime_Start = 0;
    end;


    LapDist = [25 50 75 100 125 150 175 200 225 250 275 300 325 350 375 400 ...
        425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800 ...
        825 850 875 900 925 950 975 1000 1025 1050 1075 1100 1125 1150 1175 1200 ...
        1225 1250 1275 1300 1325 1350 1375 1400 1425 1450 1475 1500];
    KeyDist = [25 50 75 100 125 150 175 200 225 250 275 300 325 350 375 400 ...
        425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800 ...
        825 850 875 900 925 950 975 1000 1025 1050 1075 1100 1125 1150 1175 1200 ...
        1225 1250 1275 1300 1325 1350 1375 1400 1425 1450 1475 1500];
    
    bestBlock = [bestBlock RT];
    RT = timeSecToStr2(RT);
    
    NbLap = RaceDist./Course;
    isInterpolatedTurn = [];
    bestTurnRace = [];
    zoneSC = 5;
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        locTurnData = [32 40 48 56 64 72 80 88 96 104 112 120 128 136 144 ...
            152 160 169 176 184 192 200 208 216 224 232 240 248 256 264 ...
            272 280 288 296 304 312 320 328 336 344 352 360 368 376 384 ...
            392 400 408 416 424 432 440 448 456 464 472 480 498 506 514];

        for lapEC = 1:NbLap-1;
            turnTXT = dataTableSkill{locTurnData(lapEC),3};
            index = strfind(turnTXT, '/');
            inTime = turnTXT(1:index(1)-1);
            outTime = turnTXT(index(1)+1:index(2)-1);
            totTime = turnTXT(index(2)+2:end);

            index1 = strfind(inTime, ' ');
            index2 = strfind(inTime, 's');
            index3 = strfind(inTime, '!');
            if isempty(index3) == 0;
                interpolationTurnIn(lapEC) = 1;
            else;
                interpolationTurnIn(lapEC) = 0;
            end;
            %time in sec            
            index = [index1 index2 index3];
            if isempty(index) == 0;
                inTime(index) = [];
            end;
            inTime = str2num(inTime);

            index1 = strfind(outTime, ' ');
            index2 = strfind(outTime, 's');
            index3 = strfind(outTime, '!');
            if isempty(index3) == 0;
                interpolationTurnOut(lapEC) = 1;
            else;
                interpolationTurnOut(lapEC) = 0;
            end;
            %time in sec            
            index = [index1 index2 index3];
            if isempty(index) == 0;
                outTime(index) = [];
            end;
            outTime = str2num(outTime);

            index1 = strfind(totTime, ' ');
            index2 = strfind(totTime, 's');
            index3 = strfind(totTime, '!');
            if isempty(index3) == 0;
                interpolationTurnTot(lapEC) = 1;
            else;
                interpolationTurnTot(lapEC) = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                totTime(index) = [];
            end;
            totTime = str2num(totTime);
 
            bestTurnRace = [bestTurnRace totTime];
            bestTurnIn = [bestTurnIn inTime];
            bestTurnOut = [bestTurnOut outTime];
            
            if interpolationTurnIn(lapEC) == 1;
                if outTime < 10 & totTime < 10;
                    %3 digits text
                    eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(inTime,2) ' '''' ' !' '''' '];']);
                else;
                    %4 digits text
                    eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(inTime,2) ' '''' '!' '''' '];']);
                end;
            else;
                if outTime < 10 & totTime < 10;
                    %3 digits text
                    eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(inTime,2) ' '''' '  ' '''' '];']);
                else;
                    %4 digits text
                    eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(inTime,2) ' '''' ' ' '''' '];']);
                end;
            end;
            if interpolationTurnOut(lapEC) == 1;
                if outTime < 10 & totTime < 10;
                    %3 digits text
                    eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(outTime,2) ' '''' ' !' '''' '];']);
                else;
                    %4 digits text
                    eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(outTime,2) ' '''' '!' '''' '];']);
                end;
            else;
                if outTime < 10 & totTime < 10;
                    %3 digits text
                    eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(outTime,2) ' '''' '  ' '''' '];']);
                else;
                    %4 digits text
                    eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(outTime,2) ' '''' ' ' '''' '];']);
                end;
            end;
            if interpolationTurnTot(lapEC) == 1;
                if outTime < 10 & totTime < 10;
                    %3 digits text
                    eval(['TurnTime' num2str(lapEC) ' = [dataToStr(totTime,2) ' '''' ' !' '''' '];']);
                else;
                    %4 digits text
                    eval(['TurnTime' num2str(lapEC) ' = [dataToStr(totTime,2) ' '''' '!' '''' '];']);
                end;
            else;
                if outTime < 10 & totTime < 10;
                    %3 digits text
                    eval(['TurnTime' num2str(lapEC) ' = [dataToStr(totTime,2) ' '''' '  ' '''' '];']);
                else;
                    %4 digits text
                    eval(['TurnTime' num2str(lapEC) ' = [dataToStr(totTime,2) ' '''' ' ' '''' '];']);
                end;
            end;
            
            BOKick_Turn = dataTableSkill{35,3};
            index = strfind(BOKick_Turn, ' ');
            BOKick_Turn = str2num(BOKick_Turn(1:index(1)));

            BOTime_Turn = dataTableSkill{37,3};
            index1 = strfind(BOTime_Turn, ' ');
            index2 = strfind(BOTime_Turn, 's');
            index3 = strfind(BOTime_Turn, '!');
            if isempty(index3) == 0;
                interpolationBOTime_Turn(lapEC) = 1;
            else;
                interpolationBOTime_Turn(lapEC) = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                BOTime_Turn(index) = [];
            end;
            BOTime_Turn = str2num(BOTime_Turn);

            BODist_Turn = dataTableSkill{36,3};
            index1 = strfind(BODist_Turn, ' ');
            index2 = strfind(BODist_Turn, 'm');
            index3 = strfind(BODist_Turn, '!');
            if isempty(index3) == 0;
                interpolationBODist_Turn(lapEC) = 1;
            else;
                interpolationBODist_Turn(lapEC) = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                BODist_Turn(index) = [];
            end;
            BODist_Turn = str2num(BODist_Turn);

            BOAllINI = [BOAllINI; [BOTime_Turn BODist_Turn BOKick_Turn]];
        end;

        BOAvKick_Turn = dataTableSkill{27,3};
        index = strfind(BOAvKick_Turn, ' ');
        BOAvKick_Turn = str2num(BOAvKick_Turn(1:index(1)));

        BOAvTime_Turn = dataTableSkill{29,3};
        index1 = strfind(BOAvTime_Turn, ' ');
        index2 = strfind(BOAvTime_Turn, 's');
        index3 = strfind(BOAvTime_Turn, '!');
        if isempty(index3) == 0;
            interpolationBOAvTime_Turn = 1;
        else;
            interpolationBOAvTime_Turn = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BOAvTime_Turn(index) = [];
        end;
        BOAvTime_Turn = str2num(BOAvTime_Turn);

        BOAvDist_Turn = dataTableSkill{28,3};
        index1 = strfind(BOAvDist_Turn, ' ');
        index2 = strfind(BOAvDist_Turn, 'm');
        index3 = strfind(BOAvDist_Turn, '!');
        if isempty(index3) == 0;
            interpolationBOAvDist_Turn= 1;
        else;
            interpolationBOAvDist_Turn = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BOAvDist_Turn(index) = [];
        end;
        BOAvDist_Turn = str2num(BOAvDist_Turn);
        BOAvINI = [BOAvTime_Turn BOAvDist_Turn BOAvKick_Turn];

        AvturnTXT = dataTableSkill{26,3};
        index = strfind(AvturnTXT, '/');
        AvinTime = AvturnTXT(1:index(1)-2);
        AvoutTime = AvturnTXT(index(1)+2:index(2)-2);
        AvtotTime = AvturnTXT(index(2)+2:end-2);

        index1 = strfind(AvinTime, ' ');
        index2 = strfind(AvinTime, 's');
        index3 = strfind(AvinTime, '!');
        if isempty(index3) == 0;
            interpolationAvTurnIn(lapEC) = 1;
        else;
            interpolationAvTurnIn(lapEC) = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            AvinTime(index) = [];
        end;
        AvinTime = str2num(AvinTime);

        index1 = strfind(AvoutTime, ' ');
        index2 = strfind(AvoutTime, 's');
        index3 = strfind(AvoutTime, '!');
        if isempty(index3) == 0;
            interpolationAvTurnOut(lapEC) = 1;
        else;
            interpolationAvTurnOut(lapEC) = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            AvoutTime(index) = [];
        end;
        AvoutTime = str2num(AvoutTime);

        index1 = strfind(AvtotTime, ' ');
        index2 = strfind(AvtotTime, 's');
        index3 = strfind(AvtotTime, '!');
        if isempty(index3) == 0;
            interpolationAvTurnTot(lapEC) = 1;
        else;
            interpolationAvTurnTot(lapEC) = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            AvtotTime(index) = [];
        end;
        AvtotTime = str2num(AvtotTime);

        if isempty(find(interpolationAvTurnIn) == 1);
            %no interpolation
            if AvoutTime < 10 & AvtotTime < 10;
                %3 digits text
                TurnTimein_Average = [timeSecToStr2(AvinTime) '  '];
            else;
                %4 digits text
                TurnTimein_Average = [timeSecToStr2(AvinTime) ' '];
            end;
        else;
            if AvoutTime < 10 & AvtotTime < 10;
                %3 digits text
                TurnTimein_Average = [timeSecToStr2(AvinTime) ' !'];
            else;
                %4 digits text
                TurnTimein_Average = [timeSecToStr2(AvinTime) '!'];
            end;
        end;
        if isempty(find(interpolationAvTurnOut) == 1);
            %no interpolation
            if AvoutTime < 10 & AvtotTime < 10;
                %3 digits text
                TurnTimeout_Average = [timeSecToStr2(AvoutTime) '  '];
            else;
                %4 digits text
                TurnTimeout_Average = [timeSecToStr2(AvoutTime) ' '];
            end;
        else;
            if AvoutTime < 10 & AvtotTime < 10;
                %3 digits text
                TurnTimeout_Average = [timeSecToStr2(AvoutTime) ' !'];
            else;
                %4 digits text
                TurnTimeout_Average = [timeSecToStr2(AvoutTime) '!'];
            end;
        end;
        if isempty(find(interpolationAvTurnTot) == 1);
            %no interpolation
            if AvoutTime < 10 & AvtotTime < 10;
                %3 digits text
                TurnTime_Average = [timeSecToStr2(AvtotTime) '  '];
            else;
                %4 digits text
                TurnTime_Average = [timeSecToStr2(AvtotTime) ' '];
            end;
        else;
            if AvoutTime < 10 & AvtotTime < 10;
                %3 digits text
                TurnTime_Average = [timeSecToStr2(AvtotTime) ' !'];
            else;
                %4 digits text
                TurnTime_Average = [timeSecToStr2(AvtotTime) '!'];
            end;
        end;
        bestTurnAv = [bestTurnAv AvtotTime];
        Turn_TimeALL = sum(bestTurnTot);

    elseif strcmpi(answerReport, 'SP2') == 1;

        turnTimeALL = dataTableSkillVAL{1,2};
        turnTimeInALL = dataTableSkillVAL{1,3};
        turnTimeOutALL = dataTableSkillVAL{1,4};
        
        for lapEC = 1:NbLap-1;        
            turnTimeEC = turnTimeALL(lapEC);
            turnTimeInEC = turnTimeInALL(lapEC);
            turnTimeOutEC = turnTimeOutALL(lapEC);
            bestTurnTot = [bestTurnTot turnTimeEC];
            bestTurnIn = [bestTurnIn turnTimeInEC];
            bestTurnOut = [bestTurnOut turnTimeOutEC];
            
            if turnTimeOutEC < 10 &  turnTimeEC < 10;
                %3 digits text
                eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(turnTimeInEC,2) ' '''' '  ' '''' '];']);
            else;
                %4 digits text
                eval(['TurnTime' num2str(lapEC) 'in = [dataToStr(turnTimeInEC,2) ' '''' ' ' '''' '];']);
            end;
            if turnTimeOutEC < 10 &  turnTimeEC < 10;
                %3 digits text
                eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(turnTimeOutEC,2) ' '''' '  ' '''' '];']);
            else;
                %4 digits text
                eval(['TurnTime' num2str(lapEC) 'out = [dataToStr(turnTimeOutEC,2) ' '''' ' ' '''' '];']);
            end;
            if turnTimeOutEC < 10 &  turnTimeEC < 10;
                %3 digits text
                eval(['TurnTime' num2str(lapEC) ' = [dataToStr(turnTimeEC,2) ' '''' '  ' '''' '];']);
            else;
                %4 digits text
                eval(['TurnTime' num2str(lapEC) ' = [dataToStr(turnTimeEC,2) ' '''' ' ' '''' '];']);
            end;
            
            BOKick_Turn = KicksNb(1,lapEC+1);
            %---400m take col = 12 for long interval splits
            BOTime_Turn = BOAll(lapEC+1,2) - dataTableAverage{(zoneSC*lapEC),12};
            BODist_Turn = BOAll(lapEC+1,3) - (lapEC*Course);
            BOAllINI = [BOAllINI; [BOTime_Turn BODist_Turn BOKick_Turn]];

            interpolationTurnIn(lapEC) = 0;
            interpolationTurnOut(lapEC) = 0;
            interpolationTurnTot(lapEC) = 0;
            interpolationBOTime_Turn(lapEC) = 0;
            interpolationBODist_Turn(lapEC) = 0;
        end;
        BOAvINI = [mean(BOAllINI(2:end,1)) mean(BOAllINI(2:end,2)) mean(BOAllINI(2:end,3))];

        interpolationAvTurnIn = 0;
        interpolationAvTurnOut = 0;
        interpolationAvTurnTot = 0;
        interpolationBOAvDist_Turn = 0;
        interpolationBOAvTime_Turn = 0;
            
        AvTurnIn = dataTableSkillVAL{1,11};
        AvTurnOut = dataTableSkillVAL{1,12};
        AvTurnTime = dataTableSkillVAL{1,13};
        bestTurnAv = [bestTurnAv AvTurnTime];
        if AvTurnOut < 10 & AvTurnTime < 10;
            %3 digits text
            TurnTimein_Average = [timeSecToStr2(AvTurnIn) '  '];
        else;
            %4 digits text
            TurnTimein_Average = [timeSecToStr2(AvTurnIn) ' '];
        end;
        if AvTurnOut < 10 & AvTurnTime < 10;
            %3 digits text
            TurnTimeout_Average = [timeSecToStr2(AvTurnOut) '  '];
        else;
            %4 digits text
            TurnTimeout_Average = [timeSecToStr2(AvTurnOut) ' '];
        end;
        if AvTurnOut < 10 & AvTurnTime < 10;
            %3 digits text
            TurnTime_Average = [timeSecToStr2(AvTurnTime) '  '];
        else;
            %4 digits text
            TurnTime_Average = [timeSecToStr2(AvTurnTime) ' '];
        end;
        
        Turn_TimeALL = sum(bestTurnTot);
    end;
    
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        valSkillTime = dataTableSkill{10,3};
        index1 = strfind(valSkillTime, ' ');
        index2 = strfind(valSkillTime, 's');
        index3 = strfind(valSkillTime, '!');
        if isempty(index3) == 0;
            interpolationSkillTime = 1;
        else;
            interpolationSkillTime = 0;
        end;

        if isempty(index2) == 1;
            %time in min
            index1 = strfind(valSkillTime, ':');
            minuteVal = valSkillTime(1:index1-1);
            secondVal = valSkillTime(index1+1:end);
            valSkillTime = str2num(minuteVal)*60 + str2num(secondVal);
            valFreeSwimTime = dataTablePacing(end,colinterest_Splits) - valSkillTime;
        else;
            %time in sec            
            index = [index1 index2 index3];
            if isempty(index) == 0;
                valSkillTime(index) = [];
            end;
            valSkillTime = str2num(valSkillTime);
            valFreeSwimTime = dataTablePacing(end,colinterest_Splits) - valSkillTime;
        end;
    
    elseif strcmpi(answerReport, 'SP2') == 1;
        valSkillTime = DiveT15 + sum(turnTimeALL) + valFinishTime;
        valFreeSwimTime = dataTableAverage{end,12} - valSkillTime;
        interpolationSkillTime = 0;
    end;
    bestFreeSwimTime = [bestFreeSwimTime valFreeSwimTime];

    SkillTime = timeSecToStr2(roundn(valSkillTime,-2));
    FreeSwimTime = timeSecToStr2(roundn(valFreeSwimTime,-2));
    if interpolationSkillTime == 1;
        SkillTime = [SkillTime ' !'];
        FreeSwimTime = [FreeSwimTime ' !'];
    else;
%         SkillTime = [SkillTime '  '];
%         FreeSwimTime = [FreeSwimTime '  '];
    end;
    bestSkillTime = [bestSkillTime valSkillTime];



    %---Get SR, SC, breath and DPS
    lapLim = Course:Course:RaceDist;
    if Course == 25;
        if RaceDist == 50;
            dataZone(1,:) = [0 15];
            dataZone(2,:) = [15 25];
            dataZone(3,:) = [25 35];
            dataZone(4,:) = [35 45];
            dataZone(5,:) = [45 50];

        elseif RaceDist == 100;
            dataZone(1,:) = [0 15];
            dataZone(2,:) = [15 20];
            dataZone(3,:) = [20 25];
            dataZone(4,:) = [25 35];
            dataZone(5,:) = [35 45];
            dataZone(6,:) = [45 50];
            dataZone(7,:) = [50 60];
            dataZone(8,:) = [60 70];
            dataZone(9,:) = [70 75];
            dataZone(10,:) = [75 85];
            dataZone(11,:) = [85 95];
            dataZone(12,:) = [95 100];

        elseif RaceDist == 150;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];

        elseif RaceDist == 200;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];

        elseif RaceDist == 400;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];
            dataZone(9,:) = [200 225];
            dataZone(10,:) = [225 250];
            dataZone(11,:) = [250 275];
            dataZone(12,:) = [275 300];
            dataZone(13,:) = [300 325];
            dataZone(14,:) = [325 350];
            dataZone(15,:) = [350 375];
            dataZone(16,:) = [375 400];

        elseif RaceDist == 800;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];
            dataZone(9,:) = [200 225];
            dataZone(10,:) = [225 250];
            dataZone(11,:) = [250 275];
            dataZone(12,:) = [275 300];
            dataZone(13,:) = [300 325];
            dataZone(14,:) = [325 350];
            dataZone(15,:) = [350 375];
            dataZone(16,:) = [375 400];
            dataZone(17,:) = [400 425];
            dataZone(18,:) = [425 450];
            dataZone(19,:) = [450 475];
            dataZone(20,:) = [475 500];
            dataZone(21,:) = [500 525];
            dataZone(22,:) = [525 550];
            dataZone(23,:) = [550 575];
            dataZone(24,:) = [575 600];
            dataZone(25,:) = [600 625];
            dataZone(26,:) = [625 650];
            dataZone(27,:) = [650 675];
            dataZone(28,:) = [675 700];
            dataZone(29,:) = [700 725];
            dataZone(30,:) = [725 750];
            dataZone(31,:) = [750 775];
            dataZone(32,:) = [775 800];

        elseif RaceDist == 1500;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];
            dataZone(9,:) = [200 225];
            dataZone(10,:) = [225 250];
            dataZone(11,:) = [250 275];
            dataZone(12,:) = [275 300];
            dataZone(13,:) = [300 325];
            dataZone(14,:) = [325 350];
            dataZone(15,:) = [350 375];
            dataZone(16,:) = [375 400];
            dataZone(17,:) = [400 425];
            dataZone(18,:) = [425 450];
            dataZone(19,:) = [450 475];
            dataZone(20,:) = [475 500];
            dataZone(21,:) = [500 525];
            dataZone(22,:) = [525 550];
            dataZone(23,:) = [550 575];
            dataZone(24,:) = [575 600];
            dataZone(25,:) = [600 625];
            dataZone(26,:) = [625 650];
            dataZone(27,:) = [650 675];
            dataZone(28,:) = [675 700];
            dataZone(29,:) = [700 725];
            dataZone(30,:) = [725 750];
            dataZone(31,:) = [750 775];
            dataZone(32,:) = [775 800];
            dataZone(33,:) = [800 825];
            dataZone(34,:) = [825 850];
            dataZone(35,:) = [850 875];
            dataZone(36,:) = [875 900];
            dataZone(37,:) = [900 925];
            dataZone(38,:) = [925 950];
            dataZone(39,:) = [950 975];
            dataZone(40,:) = [975 1000];
            dataZone(41,:) = [1000 1025];
            dataZone(42,:) = [1025 1050];
            dataZone(43,:) = [1050 1075];
            dataZone(44,:) = [1075 1100];
            dataZone(45,:) = [1100 1125];
            dataZone(46,:) = [1125 1150];
            dataZone(47,:) = [1150 1175];
            dataZone(48,:) = [1175 1200];
            dataZone(49,:) = [1200 1225];
            dataZone(50,:) = [1225 1250];
            dataZone(51,:) = [1250 1275];
            dataZone(52,:) = [1275 1300];
            dataZone(53,:) = [1300 1325];
            dataZone(54,:) = [1325 1350];
            dataZone(55,:) = [1350 1375];
            dataZone(56,:) = [1375 1400];
            dataZone(57,:) = [1400 1425];
            dataZone(58,:) = [1425 1450];
            dataZone(59,:) = [1450 1475];
            dataZone(60,:) = [1475 1500];
        end;
    elseif Course == 50;
        if RaceDist == 50;
            dataZone(1,:) = [0 15];
            dataZone(2,:) = [15 25];
            dataZone(3,:) = [25 35];
            dataZone(4,:) = [35 45];
            dataZone(5,:) = [45 50];

        elseif RaceDist == 100;
            dataZone(1,:) = [0 15];
            dataZone(2,:) = [15 25];
            dataZone(3,:) = [25 35];
            dataZone(4,:) = [35 45];
            dataZone(5,:) = [45 50];
            dataZone(6,:) = [50 65];
            dataZone(7,:) = [65 75];
            dataZone(8,:) = [75 85];
            dataZone(9,:) = [85 95];
            dataZone(10,:) = [95 100];

        elseif RaceDist == 150;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];

        elseif RaceDist == 200;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];

        elseif RaceDist == 400;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];
            dataZone(9,:) = [200 225];
            dataZone(10,:) = [225 250];
            dataZone(11,:) = [250 275];
            dataZone(12,:) = [275 300];
            dataZone(13,:) = [300 325];
            dataZone(14,:) = [325 350];
            dataZone(15,:) = [350 375];
            dataZone(16,:) = [375 400];

        elseif RaceDist == 800;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];
            dataZone(9,:) = [200 225];
            dataZone(10,:) = [225 250];
            dataZone(11,:) = [250 275];
            dataZone(12,:) = [275 300];
            dataZone(13,:) = [300 325];
            dataZone(14,:) = [325 350];
            dataZone(15,:) = [350 375];
            dataZone(16,:) = [375 400];
            dataZone(17,:) = [400 425];
            dataZone(18,:) = [425 450];
            dataZone(19,:) = [450 475];
            dataZone(20,:) = [475 500];
            dataZone(21,:) = [500 525];
            dataZone(22,:) = [525 550];
            dataZone(23,:) = [550 575];
            dataZone(24,:) = [575 600];
            dataZone(25,:) = [600 625];
            dataZone(26,:) = [625 650];
            dataZone(27,:) = [650 675];
            dataZone(28,:) = [675 700];
            dataZone(29,:) = [700 725];
            dataZone(30,:) = [725 750];
            dataZone(31,:) = [750 775];
            dataZone(32,:) = [775 800];

        elseif RaceDist == 1500;
            dataZone(1,:) = [0 25];
            dataZone(2,:) = [25 50];
            dataZone(3,:) = [50 75];
            dataZone(4,:) = [75 100];
            dataZone(5,:) = [100 125];
            dataZone(6,:) = [125 150];
            dataZone(7,:) = [150 175];
            dataZone(8,:) = [175 200];
            dataZone(9,:) = [200 225];
            dataZone(10,:) = [225 250];
            dataZone(11,:) = [250 275];
            dataZone(12,:) = [275 300];
            dataZone(13,:) = [300 325];
            dataZone(14,:) = [325 350];
            dataZone(15,:) = [350 375];
            dataZone(16,:) = [375 400];
            dataZone(17,:) = [400 425];
            dataZone(18,:) = [425 450];
            dataZone(19,:) = [450 475];
            dataZone(20,:) = [475 500];
            dataZone(21,:) = [500 525];
            dataZone(22,:) = [525 550];
            dataZone(23,:) = [550 575];
            dataZone(24,:) = [575 600];
            dataZone(25,:) = [600 625];
            dataZone(26,:) = [625 650];
            dataZone(27,:) = [650 675];
            dataZone(28,:) = [675 700];
            dataZone(29,:) = [700 725];
            dataZone(30,:) = [725 750];
            dataZone(31,:) = [750 775];
            dataZone(32,:) = [775 800];
            dataZone(33,:) = [800 825];
            dataZone(34,:) = [825 850];
            dataZone(35,:) = [850 875];
            dataZone(36,:) = [875 900];
            dataZone(37,:) = [900 925];
            dataZone(38,:) = [925 950];
            dataZone(39,:) = [950 975];
            dataZone(40,:) = [975 1000];
            dataZone(41,:) = [1000 1025];
            dataZone(42,:) = [1025 1050];
            dataZone(43,:) = [1050 1075];
            dataZone(44,:) = [1075 1100];
            dataZone(45,:) = [1100 1125];
            dataZone(46,:) = [1125 1150];
            dataZone(47,:) = [1150 1175];
            dataZone(48,:) = [1175 1200];
            dataZone(49,:) = [1200 1225];
            dataZone(50,:) = [1225 1250];
            dataZone(51,:) = [1250 1275];
            dataZone(52,:) = [1275 1300];
            dataZone(53,:) = [1300 1325];
            dataZone(54,:) = [1325 1350];
            dataZone(55,:) = [1350 1375];
            dataZone(56,:) = [1375 1400];
            dataZone(57,:) = [1400 1425];
            dataZone(58,:) = [1425 1450];
            dataZone(59,:) = [1450 1475];
            dataZone(60,:) = [1475 1500];
        end;
    end;
    nbZones = length(dataZone(:,1));

    %Breath 1500m, long intervals take col=3
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 ...
            165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 ...
            245 250 255 260 265 270 275 280 285 290 295 300];
    for iter = 1:length(validIndex);
        valEC = dataTableBreath(validIndex(iter), 3);
        valEC = roundn(valEC,0);
        if isempty(valEC) == 1 | isnan(valEC) == 1;
            ValEC = '0';
        else;
            ValEC = dataToStr(valEC,0);
        end;
        eval(['Breath' num2str(KeyDist(iter)) 'm = ValEC;']);
    end;
    BreathSum = sum(dataTableBreath(:,1));
    if BreathSum == 0
        BreathTot = '0';
    else;
        BreathTot = num2str(BreathSum);
    end;


    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;       
%         VelLap = [];
%         interpVel = 0;
%         validIndex = [5 10 15 20 25 30 35 40];
%         %400 so take col 7 for the speed
%         colinterest_Speed = 7;
%         colinterest_SpeedInterp = 8;
%         for iter = 1:length(validIndex);
%             valEC = dataTablePacing(validIndex(iter), colinterest_Speed);
%             if isempty(valEC) == 1 | isnan(valEC) == 1;
%                 ValEC = ' ';
%             else;
%                 VelLap = [VelLap valEC];
%             end;
%         end;
%         VelAverage = dataToStr(mean(VelLap),2);
        VelAverage = databaseCurrent{raceECmain-2,32};

    elseif strcmpi(answerReport, 'SP2') == 1;
        %200m race so take col 4 for the speed
%         VelLap = [];
%         interpVel = 0;
%         validIndex = [5 10 15 20 25 30 35 40];
%         for iter = 1:length(dataTableAverage(:,1));
%             valEC = dataTableAverage{iter,4};
%             if isempty(valEC) == 1 | isnan(valEC) == 1;
%                 ValEC = ' ';
%             else;
%                 VelLap = [VelLap valEC];
%             end;
%         end;
%         a = dataToStr(mean(VelLap),2)
        VelAverage = databaseCurrent{raceECmain-2,32};
    end;
    bestVelocity = [bestVelocity str2num(databaseCurrent{raceECmain-2,32})];


    DPSTOT = [];
    iter = 1;
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        %it's a 1500 so take col = 7 for long intervals
        colinterest_DPS = 7;
        colinterest_DPSInterp = 8;

        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 ...
            165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 ...
            245 250 255 260 265 270 275 280 285 290 295 300];

        for iter = 1:length(validIndex);
            valEC = dataTableStroke(validIndex(iter), colinterest_DPS);
            if isempty(valEC) == 1 | isnan(valEC) == 1;
                ValEC = '         ';
            else;
                DPSTOT = [DPSTOT valEC];
                if dataTableStroke(validIndex(iter), colinterest_DPSInterp) == 1;
                    ValEC = [dataToStr(valEC,2) ' !'];
                else;
                    ValEC = [dataToStr(valEC,2) '  '];
                end;
            end;
            eval(['DPS' num2str(KeyDist(iter)) 'm = ValEC;']);
        end;
%         DPSAverage = [dataToStr(mean(DPSTOT),2) '  '];
        DPSAverage = [databaseCurrent{raceECmain-2,34} '  '];
    
    elseif strcmpi(answerReport, 'SP2') == 1;
        %it's a 1500 so take col = 10 for short intervals
        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 ...
            165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 ...
            245 250 255 260 265 270 275 280 285 290 295 300];

        for iter = 1:length(validIndex);
            eval(['valEC = dataTableAverage{' num2str(validIndex(iter)) ',10};']);
            if isempty(valEC) == 1;
                ValEC = '         ';
            else;
                DPSTOT = [DPSTOT valEC];
                ValEC = [dataToStr(valEC,2) '  '];
            end;
            eval(['DPS' num2str(KeyDist(iter)) 'm = ValEC;']);
        end;
        DPSAverage = [databaseCurrent{raceECmain-2,34} '  '];
    end;
    
    SRTOT = [];
    iter = 1;
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        
        %It's a 1500m so take col = 3 for long intervals
        colinterest_SR = 3;
        colinterest_SRInterp = 4;

        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 ...
            165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 ...
            245 250 255 260 265 270 275 280 285 290 295 300];

        for iter = 1:length(validIndex);
            valEC = dataTableStroke(validIndex(iter), colinterest_SR);
            if isempty(valEC) == 1 | isnan(valEC) == 1;
                ValEC = '         ';
            else;
                SRTOT = [SRTOT valEC];
                if dataTableStroke(validIndex(iter), colinterest_SRInterp) == 1;
                    ValEC = [dataToStr(valEC,1) ' !'];
                else;
                    ValEC = [dataToStr(valEC,1) '  '];
                end;
            end;
            eval(['SR' num2str(KeyDist(iter)) 'm = ValEC;']);
        end;
%         SRAverage = [dataToStr(mean(SRTOT),1) '  '];
        SRAverage = [databaseCurrent{raceECmain-2,33} '  '];

    elseif strcmpi(answerReport, 'SP2') == 1;
        %It's a 1500m so take col = 7 for long intervals
        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 ...
            165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 ...
            245 250 255 260 265 270 275 280 285 290 295 300];

        for iter = 1:length(validIndex);
            eval(['valEC = dataTableAverage{' num2str(validIndex(iter)) ',7};']);
            if isempty(valEC) == 1;
                ValEC = '         ';
            else;
                SRTOT = [SRTOT valEC];
                ValEC = [dataToStr(valEC,1) '  '];
            end;
            eval(['SR' num2str(KeyDist(iter)) 'm = ValEC;']);
        end;
        SRAverage = [databaseCurrent{raceECmain-2,33} '  '];
    end;

    NbLap = (RaceDist./Course);
    keyDist = Course:Course:(NbLap*Course);
    if Source == 1 | Source == 3;
        %It's a 1500m so take col = 11 for long intervals
        colinterest_SC = 11;

        indexLapINI = 1;
        for lapEC = 1:NbLap;
            indexLapEND = find(dataTableRefDist == LapDist(lapEC));
            valStrokes = dataTableStroke(indexLapINI:indexLapEND, colinterest_SC);
            indexNAN = find(isnan(valStrokes) == 1);
            valStrokes(indexNAN) = [];
            Stroke_Count(lapEC) = sum(valStrokes);

            indexLapINI = indexLapEND + 1;
        end;
    elseif Source == 2;
        %It's a 1500m so take col = 16 for long intervals
        indexLapINI = 1;
        for lapEC = 1:NbLap;
            indexLapEND = find(dataTableRefDist == keyDist(lapEC));
            valStrokes = dataTableAverage(indexLapINI:indexLapEND,16);
            valStrokes = cell2mat(valStrokes);
            indexNAN = find(isnan(valStrokes) == 1);
            valStrokes(indexNAN) = [];
            Stroke_Count(lapEC) = sum(valStrokes);

            indexLapINI = indexLapEND + 1;
        end;
    end;


    txt = AthletenameFull;
    if length(txt) >= 14;
        index = strfind(txt, ' ');
        txt = [txt(1) '.' txt(index+1:end)];
    end;
    txtTitle1_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-120, shiftRight, 15], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font2, 'String', txt);
    set(txtTitle1_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = {[num2str(RaceDist) 'm ' StrokeType]; RelayType};
    if strcmpi(StrokeType, 'Breaststroke') == 1;
        fontEC = font4-1;
    else;
        fontEC = font4;
    end;
    txtTitle2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-145, shiftRight, 15], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', fontEC, 'String', txt);
    set(txtTitle2_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Stage;
    txtTitle3_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-160, shiftRight, 15], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtTitle3_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = MeetShort;
    txtTitle4_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-175, shiftRight, 15], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtTitle4_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = RaceDate;
    lispace = strfind(txt, ' ');
    if isempty(lispace) == 0;
        txt = txt(lispace(end)+1:end);
    end;
    txtTitle5_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-190, shiftRight, 15], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.7 0.88 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtTitle5_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txtCol2A_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-230, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2A_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if Source == 1;
        txt = 'Sparta 1';
    elseif Source == 2;
        txt = 'Sparta 2';
    elseif Source == 3;
        txt = 'GreenEye';
    end;
    txtCol2B_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-255, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2B_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txtCol2C_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-275, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Full');
    set(txtCol2C_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txtCol1d_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-310, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol1d_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = RaceTime;
    txtCol2E_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-335, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2E_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2E_pdfStore{raceECmain-2,1} = txtCol2E_pdf;
   
    txt = SkillTime;
    txtCol2F_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-355, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2F_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2F_pdfStore{raceECmain-2,1} = txtCol2F_pdf;

    txt = FreeSwimTime;
    txtCol2G_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-375, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2G_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2G_pdfStore{raceECmain-2,1} = txtCol2G_pdf;

    txt = VelAverage;
    txtCol2H_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-395, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2H_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2H_pdfStore{raceECmain-2,1} = txtCol2H_pdf;

    txt = RT;
    txtCol2I_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-415, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2I_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2I_pdfStore{raceECmain-2,1} = txtCol2I_pdf;

    txt = StartTime;
    txtCol2J_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-435, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2J_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2J_pdfStore{raceECmain-2,1} = txtCol2J_pdf;

    if interpolationBODist_Start == 1;
        txtDist = [dataToStr(BOAllINI(1,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(1,2), 1) ' '];
    end;
    if interpolationBOTime_Start == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(1,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(1,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(1,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2J2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-450, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2J2_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2J2_pdfStore{raceECmain-2,1} = txtCol2J2_pdf;
    
    txt = Time25m;
    txtCol2K_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-470, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2K_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2K_pdfStore{raceECmain-2,1} = txtCol2K_pdf;

    txt = [' ' TurnTimein_Average TurnTimeout_Average TurnTime_Average];
    txtCol2Sh_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-490, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sh_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2h_pdfStore{raceECmain-2,1} = txtCol2Sh_pdf;

    if interpolationBOAvDist_Turn == 1;
        txtDist = [dataToStr(BOAvINI(1,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAvINI(1,2), 1) ' '];
    end;
    if interpolationBOAvTime_Turn == 1;
        txtTime = [timeSecToStr2(roundn(BOAvINI(1,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAvINI(1,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAvINI(1,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2h2_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-505, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2h2_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2h2_pdfStore{raceECmain-2,1} = txtCol2S2h2_pdf;

    txt = FinishTime;
    txtCol2L_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-525, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2L_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2L_pdfStore{raceECmain-2,1} = txtCol2L_pdf;



    txtCol2m_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-560, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2m_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split25m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-585, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split50m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-605, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split75m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-625, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split100m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-645, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split125m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-665, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split150m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-685, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split175m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-705, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split200m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-725, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split225m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-745, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split250m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-765, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split275m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-785, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split300m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-805, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split325m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-825, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split350m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-845, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size(4)-845, 1, 755], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;


    txt = Split375m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos1, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split400m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos2, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split425m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos3, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split450m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos4, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split475m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos5, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split500m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos6, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split525m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos7, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split550m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos8, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split575m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos9, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split600m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos10, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split625m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos11, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split650m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos12, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split675m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos13, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split700m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos14, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split725m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos15, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split750m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos16, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split775m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos17, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split800m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos18, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split825m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos19, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split850m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos20, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split875m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos21, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split900m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos22, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split925m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos23, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split950m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos24, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split975m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos25, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1000m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos26, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1025m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos27, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1050m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos28, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1075m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos29, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1100m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos30, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1125m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos31, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1150m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos32, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1175m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos33, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1200m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos34, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1225m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos35, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1250m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos36, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1275m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos37, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1300m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos38, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1325m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos39, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1350m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos40, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1375m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos41, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1400m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos42, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size2(4)-pos42, 1, pos42], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = Split1425m;
    txtCol2N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos43, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1450m;
    txtCol2N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos44, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1475m;
    txtCol2N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos45, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = Split1500m;
    txtCol2N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos46, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');






    txtCol2o_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos47, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_25;
    txtCol2P_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos49, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2P_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_25;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos50, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_25;
    txtCol2R_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos51, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2R_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_25;
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos52, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_25;
    txtCol2T_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos53, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2T_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_25;
    txtCol2U_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos54, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2U_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_25;
    txtCol2V_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos55, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap8_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos56, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap9_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos57, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap10_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos58, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap11_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos59, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap12_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos60, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap13_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos61, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap14_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos62, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap15_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos63, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap16_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos64, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap17_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos65, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap18_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos66, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap19_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos67, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap20_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos68, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap21_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos69, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap22_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos70, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap23_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos71, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap24_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos72, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap25_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos73, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap26_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos74, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap27_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos75, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap28_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos76, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap29_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos77, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap30_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos78, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap31_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos79, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap32_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos80, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap33_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos81, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap34_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos82, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap35_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos83, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap36_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos84, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap37_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos85, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size3(4)-pos85, 1, pos85], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;
    
    txt = SplitLap38_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos86, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap39_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos87, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap40_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos88, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap41_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos89, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap42_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos90, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap43_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos91, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap44_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos92, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap45_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos93, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap46_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos94, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap47_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos95, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap48_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos96, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap49_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos97, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap50_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos98, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap51_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos99, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap52_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos100, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap53_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos101, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap54_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos102, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap55_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos103, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap56_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos104, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap57_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos105, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap58_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos106, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap59_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos107, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap60_25;
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos108, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    





    txtCol2r_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos109, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos111, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos112, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos113, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos114, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos115, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos116, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos117, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap8_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos118, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap9_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos119, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap10_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos120, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap11_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos121, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap12_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos122, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap13_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos123, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap14_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos124, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap15_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos125, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap16_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos126, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap17_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos127, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap18_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos128, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap19_50;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos129, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size4(4)-pos129, 1, pos129], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = SplitLap20_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos130, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap21_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos131, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap22_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos132, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap23_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos133, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap24_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos134, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap25_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos135, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap26_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos136, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap27_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos137, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap28_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos138, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap29_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos139, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap30_50;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos140, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');







    txtCol2r_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos141, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos143, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos144, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap3_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos145, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap4_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos146, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos147, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos148, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos149, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap8_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos150, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap9_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos151, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap10_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos152, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap11_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos153, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap12_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos154, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap13_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos155, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap14_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos156, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap15_100;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos157, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');






    txtCol2r_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos158, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos160, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos161, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap3_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos162, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap4_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos163, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos164, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos165, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_200;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos166, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');



    txtCol2r_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos167, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap1_500;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos169, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap2_500;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos170, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap3_500;
    txtCol2Q_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos171, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size5(4)-pos171, 1, pos171], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;





    txtCol2r_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos172, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(1));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos174, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(2));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos175, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(3));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos176, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(4));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos177, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(5));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos178, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(6));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos179, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(7));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos180, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(8));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos181, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(9));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos182, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(10));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos183, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(11));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos184, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(12));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos185, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(13));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos186, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(14));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos187, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(15));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos188, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(16));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos189, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(17));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos190, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(18));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos191, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(19));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos192, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(20));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos193, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(21));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos194, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(22));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos195, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(23));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos196, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(24));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos197, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(25));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos198, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(26));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos199, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(27));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos200, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(28));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos201, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(29));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos202, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(30));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos203, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(31));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos204, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(32));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos205, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(33));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos206, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(34));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos207, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(35));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos208, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(36));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos209, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(37));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos210, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(38));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos211, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(39));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos212, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(40));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos213, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(41));
    txtCol2S_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos214, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size6(4)-pos214, 1, pos214], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = num2str(Stroke_Count(42));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos215, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(43));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos216, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(44));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos217, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(45));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos218, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(46));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos219, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(47));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos220, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(48));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos221, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(49));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos222, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(50));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos223, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(51));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos224, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(52));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos225, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(53));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos226, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(54));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos227, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(55));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos228, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(56));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos229, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(57));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos230, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(58));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos231, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(59));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos232, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(60));
    txtCol2S_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos233, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 








    txtCol2r_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos234, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    storeDist = [];
    storeTime = [];

    txt = [' ' TurnTime1in TurnTime1out TurnTime1];
    txtCol2Sa_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos236, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sa_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(2,2)];
    storeTime = [storeTime BOAllINI(2,1)];
    if interpolationBODist_Turn(1) == 1;
        txtDist = [dataToStr(BOAllINI(2,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(2,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(1) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(2,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(2,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(2,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2a_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos237, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2a_pdfStore{raceECmain-2,1} = txtCol2S2a_pdf;


    txt = [' ' TurnTime2in TurnTime2out TurnTime2];
    txtCol2Sb_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos238, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sb_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(3,2)];
    storeTime = [storeTime BOAllINI(3,1)];
    if interpolationBODist_Turn(2) == 1;
        txtDist = [dataToStr(BOAllINI(3,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(3,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(2) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(3,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(3,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(3,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2b_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos239, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2b_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2b_pdfStore{raceECmain-2,1} = txtCol2S2b_pdf;

    txt = [' ' TurnTime3in TurnTime3out TurnTime3];
    txtCol2Sc_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos240, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sc_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(4,2)];
    storeTime = [storeTime BOAllINI(4,1)];
    if interpolationBODist_Turn(3) == 1;
        txtDist = [dataToStr(BOAllINI(4,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(4,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(3) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(4,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(4,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(4,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2c_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos241, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2c_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2c_pdfStore{raceECmain-2,1} = txtCol2S2c_pdf;

    txt = [' ' TurnTime4in TurnTime4out TurnTime4];
    txtCol2Sd_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos242, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sd_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(5,2)];
    storeTime = [storeTime BOAllINI(5,1)];
    if interpolationBODist_Turn(4) == 1;
        txtDist = [dataToStr(BOAllINI(5,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(5,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(4) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(5,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(5,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(5,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2d_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos243, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2d_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2d_pdfStore{raceECmain-2,1} = txtCol2S2d_pdf;

    txt = [' ' TurnTime5in TurnTime5out TurnTime5];
    txtCol2Se_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos244, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Se_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    storeDist = [storeDist BOAllINI(6,2)];
    storeTime = [storeTime BOAllINI(6,1)];
    if interpolationBODist_Turn(5) == 1;
        txtDist = [dataToStr(BOAllINI(6,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(6,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(5) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(6,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(6,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(6,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2e_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos245, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2e_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2e_pdfStore{raceECmain-2,1} = txtCol2S2e_pdf;

    txt = [' ' TurnTime6in TurnTime6out TurnTime6];
    txtCol2Sf_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos246, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sf_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    storeDist = [storeDist BOAllINI(7,2)];
    storeTime = [storeTime BOAllINI(7,1)];
    if interpolationBODist_Turn(6) == 1;
        txtDist = [dataToStr(BOAllINI(7,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(7,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(6) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(7,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(7,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(7,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2f_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos247, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2f_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2f_pdfStore{raceECmain-2,1} = txtCol2S2f_pdf;

    txt = [' ' TurnTime7in TurnTime7out TurnTime7];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos248, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(8,2)];
    storeTime = [storeTime BOAllINI(8,1)];
    if interpolationBODist_Turn(7) == 1;
        txtDist = [dataToStr(BOAllINI(8,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(8,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(7) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(8,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(8,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(8,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos249, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;


    txt = [' ' TurnTime8in TurnTime8out TurnTime8];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos250, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(9,2)];
    storeTime = [storeTime BOAllINI(9,1)];
    if interpolationBODist_Turn(8) == 1;
        txtDist = [dataToStr(BOAllINI(9,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(9,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(8) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(9,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(9,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(9,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos251, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime9in TurnTime9out TurnTime9];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos252, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(10,2)];
    storeTime = [storeTime BOAllINI(10,1)];
    if interpolationBODist_Turn(9) == 1;
        txtDist = [dataToStr(BOAllINI(10,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(10,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(9) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(10,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(10,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(10,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos253, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime10in TurnTime10out TurnTime10];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos254, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(11,2)];
    storeTime = [storeTime BOAllINI(11,1)];
    if interpolationBODist_Turn(10) == 1;
        txtDist = [dataToStr(BOAllINI(11,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(11,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(10) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(11,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(11,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(11,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos255, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime11in TurnTime11out TurnTime11];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos256, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(12,2)];
    storeTime = [storeTime BOAllINI(12,1)];
    if interpolationBODist_Turn(11) == 1;
        txtDist = [dataToStr(BOAllINI(12,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(12,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(11) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(12,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(12,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(12,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos257, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime12in TurnTime12out TurnTime12];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos258, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(13,2)];
    storeTime = [storeTime BOAllINI(13,1)];
    if interpolationBODist_Turn(12) == 1;
        txtDist = [dataToStr(BOAllINI(13,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(13,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(12) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(13,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(13,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(13,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos259, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime13in TurnTime13out TurnTime13];
    txtCol2Sg_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos260, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(14,2)];
    storeTime = [storeTime BOAllINI(14,1)];
    if interpolationBODist_Turn(13) == 1;
        txtDist = [dataToStr(BOAllINI(14,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(14,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(13) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(14,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(14,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(14,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos261, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size7(4)-pos261, 1, pos261], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;


    txt = [' ' TurnTime14in TurnTime14out TurnTime14];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos262, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(15,2)];
    storeTime = [storeTime BOAllINI(15,1)];
    if interpolationBODist_Turn(14) == 1;
        txtDist = [dataToStr(BOAllINI(15,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(15,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(14) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(15,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(15,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(15,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos263, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime15in TurnTime15out TurnTime15];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos264, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(16,2)];
    storeTime = [storeTime BOAllINI(16,1)];
    if interpolationBODist_Turn(15) == 1;
        txtDist = [dataToStr(BOAllINI(16,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(16,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(15) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(16,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(16,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(16,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos265, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime16in TurnTime16out TurnTime16];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos266, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(17,2)];
    storeTime = [storeTime BOAllINI(17,1)];
    if interpolationBODist_Turn(16) == 1;
        txtDist = [dataToStr(BOAllINI(17,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(17,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(16) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(17,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(17,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(17,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos267, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime17in TurnTime17out TurnTime17];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos268, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(18,2)];
    storeTime = [storeTime BOAllINI(18,1)];
    if interpolationBODist_Turn(17) == 1;
        txtDist = [dataToStr(BOAllINI(18,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(18,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(17) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(18,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(18,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(18,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos269, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime18in TurnTime18out TurnTime18];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos270, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(19,2)];
    storeTime = [storeTime BOAllINI(19,1)];
    if interpolationBODist_Turn(18) == 1;
        txtDist = [dataToStr(BOAllINI(19,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(19,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(18) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(19,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(19,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(19,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos271, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime19in TurnTime19out TurnTime19];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos272, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(20,2)];
    storeTime = [storeTime BOAllINI(20,1)];
    if interpolationBODist_Turn(19) == 1;
        txtDist = [dataToStr(BOAllINI(20,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(20,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(19) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(20,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(20,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(20,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos273, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime20in TurnTime20out TurnTime20];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos274, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(21,2)];
    storeTime = [storeTime BOAllINI(21,1)];
    if interpolationBODist_Turn(20) == 1;
        txtDist = [dataToStr(BOAllINI(21,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(21,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(20) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(21,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(21,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(21,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos275, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime21in TurnTime21out TurnTime21];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos276, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(22,2)];
    storeTime = [storeTime BOAllINI(22,1)];
    if interpolationBODist_Turn(21) == 1;
        txtDist = [dataToStr(BOAllINI(22,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(22,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(21) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(22,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(22,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(22,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos277, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime22in TurnTime22out TurnTime22];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos278, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(23,2)];
    storeTime = [storeTime BOAllINI(23,1)];
    if interpolationBODist_Turn(22) == 1;
        txtDist = [dataToStr(BOAllINI(23,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(23,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(22) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(23,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(23,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(23,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos279, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime23in TurnTime23out TurnTime23];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos280, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(24,2)];
    storeTime = [storeTime BOAllINI(24,1)];
    if interpolationBODist_Turn(23) == 1;
        txtDist = [dataToStr(BOAllINI(24,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(24,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(23) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(24,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(24,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(24,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos281, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime24in TurnTime24out TurnTime24];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos282, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(25,2)];
    storeTime = [storeTime BOAllINI(25,1)];
    if interpolationBODist_Turn(24) == 1;
        txtDist = [dataToStr(BOAllINI(25,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(25,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(24) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(25,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(25,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(25,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos283, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime25in TurnTime25out TurnTime25];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos284, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(26,2)];
    storeTime = [storeTime BOAllINI(26,1)];
    if interpolationBODist_Turn(25) == 1;
        txtDist = [dataToStr(BOAllINI(26,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(26,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(25) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(26,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(26,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(26,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos285, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime26in TurnTime26out TurnTime26];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos286, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(27,2)];
    storeTime = [storeTime BOAllINI(27,1)];
    if interpolationBODist_Turn(26) == 1;
        txtDist = [dataToStr(BOAllINI(27,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(27,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(26) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(27,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(27,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(27,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos287, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime27in TurnTime27out TurnTime27];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos288, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(28,2)];
    storeTime = [storeTime BOAllINI(28,1)];
    if interpolationBODist_Turn(27) == 1;
        txtDist = [dataToStr(BOAllINI(28,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(28,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(27) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(28,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(28,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(28,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos289, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime28in TurnTime28out TurnTime28];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos290, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(29,2)];
    storeTime = [storeTime BOAllINI(29,1)];
    if interpolationBODist_Turn(28) == 1;
        txtDist = [dataToStr(BOAllINI(29,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(29,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(28) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(29,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(29,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(29,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos291, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime29in TurnTime29out TurnTime29];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos292, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(30,2)];
    storeTime = [storeTime BOAllINI(30,1)];
    if interpolationBODist_Turn(29) == 1;
        txtDist = [dataToStr(BOAllINI(30,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(30,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(29) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(30,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(30,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(30,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos293, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime30in TurnTime30out TurnTime30];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos294, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(31,2)];
    storeTime = [storeTime BOAllINI(31,1)];
    if interpolationBODist_Turn(30) == 1;
        txtDist = [dataToStr(BOAllINI(31,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(31,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(30) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(31,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(31,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(31,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos295, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime31in TurnTime31out TurnTime31];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos296, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(32,2)];
    storeTime = [storeTime BOAllINI(32,1)];
    if interpolationBODist_Turn(31) == 1;
        txtDist = [dataToStr(BOAllINI(32,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(32,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(31) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(32,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(32,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(32,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos297, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;


    txt = [' ' TurnTime32in TurnTime32out TurnTime32];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos298, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(33,2)];
    storeTime = [storeTime BOAllINI(33,1)];
    if interpolationBODist_Turn(32) == 1;
        txtDist = [dataToStr(BOAllINI(33,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(33,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(32) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(33,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(33,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(33,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos299, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime33in TurnTime33out TurnTime33];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos300, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(34,2)];
    storeTime = [storeTime BOAllINI(34,1)];
    if interpolationBODist_Turn(33) == 1;
        txtDist = [dataToStr(BOAllINI(34,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(34,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(33) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(34,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(34,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(34,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos301, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;


    txt = [' ' TurnTime34in TurnTime34out TurnTime34];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos302, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(35,2)];
    storeTime = [storeTime BOAllINI(35,1)];
    if interpolationBODist_Turn(34) == 1;
        txtDist = [dataToStr(BOAllINI(35,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(35,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(34) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(35,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(35,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(35,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos303, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime35in TurnTime35out TurnTime35];
    txtCol2Sg_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos304, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(36,2)];
    storeTime = [storeTime BOAllINI(36,1)];
    if interpolationBODist_Turn(35) == 1;
        txtDist = [dataToStr(BOAllINI(36,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(36,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(35) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(36,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(36,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(36,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size8(4)-pos305, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource7, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size8(4)-pos305, 1, pos305], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = [' ' TurnTime36in TurnTime36out TurnTime36];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos306, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(37,2)];
    storeTime = [storeTime BOAllINI(37,1)];
    if interpolationBODist_Turn(36) == 1;
        txtDist = [dataToStr(BOAllINI(37,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(37,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(36) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(37,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(37,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(37,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos307, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime37in TurnTime37out TurnTime37];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos308, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(38,2)];
    storeTime = [storeTime BOAllINI(38,1)];
    if interpolationBODist_Turn(37) == 1;
        txtDist = [dataToStr(BOAllINI(38,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(38,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(37) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(38,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(38,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(38,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos309, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime38in TurnTime38out TurnTime38];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos310, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(39,2)];
    storeTime = [storeTime BOAllINI(39,1)];
    if interpolationBODist_Turn(38) == 1;
        txtDist = [dataToStr(BOAllINI(39,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(39,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(38) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(39,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(39,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(39,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos311, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime39in TurnTime39out TurnTime39];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos312, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(40,2)];
    storeTime = [storeTime BOAllINI(40,1)];
    if interpolationBODist_Turn(39) == 1;
        txtDist = [dataToStr(BOAllINI(40,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(40,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(39) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(40,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(40,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(40,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos313, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime40in TurnTime40out TurnTime40];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos314, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(41,2)];
    storeTime = [storeTime BOAllINI(41,1)];
    if interpolationBODist_Turn(40) == 1;
        txtDist = [dataToStr(BOAllINI(41,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(41,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(40) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(41,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(41,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(41,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos315, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime41in TurnTime41out TurnTime41];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos316, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(42,2)];
    storeTime = [storeTime BOAllINI(42,1)];
    if interpolationBODist_Turn(41) == 1;
        txtDist = [dataToStr(BOAllINI(42,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(42,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(41) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(42,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(42,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(42,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos317, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime42in TurnTime42out TurnTime42];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos318, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(43,2)];
    storeTime = [storeTime BOAllINI(43,1)];
    if interpolationBODist_Turn(42) == 1;
        txtDist = [dataToStr(BOAllINI(43,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(43,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(42) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(43,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(43,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(43,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos319, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime43in TurnTime43out TurnTime43];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos320, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(44,2)];
    storeTime = [storeTime BOAllINI(44,1)];
    if interpolationBODist_Turn(43) == 1;
        txtDist = [dataToStr(BOAllINI(44,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(44,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(43) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(44,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(44,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(44,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos321, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime44in TurnTime44out TurnTime44];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos322, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(45,2)];
    storeTime = [storeTime BOAllINI(45,1)];
    if interpolationBODist_Turn(44) == 1;
        txtDist = [dataToStr(BOAllINI(45,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(45,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(44) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(45,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(45,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(45,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos323, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime45in TurnTime45out TurnTime45];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos324, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(46,2)];
    storeTime = [storeTime BOAllINI(46,1)];
    if interpolationBODist_Turn(45) == 1;
        txtDist = [dataToStr(BOAllINI(46,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(46,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(45) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(46,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(46,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(46,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos325, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime46in TurnTime46out TurnTime46];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos326, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(47,2)];
    storeTime = [storeTime BOAllINI(47,1)];
    if interpolationBODist_Turn(46) == 1;
        txtDist = [dataToStr(BOAllINI(47,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(47,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(46) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(47,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(47,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(47,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos327, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime47in TurnTime47out TurnTime47];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos328, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(48,2)];
    storeTime = [storeTime BOAllINI(48,1)];
    if interpolationBODist_Turn(47) == 1;
        txtDist = [dataToStr(BOAllINI(48,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(48,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(47) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(48,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(48,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(48,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos329, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime48in TurnTime48out TurnTime48];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos330, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(49,2)];
    storeTime = [storeTime BOAllINI(49,1)];
    if interpolationBODist_Turn(48) == 1;
        txtDist = [dataToStr(BOAllINI(49,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(49,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(48) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(49,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(49,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(49,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos331, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime49in TurnTime49out TurnTime49];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos332, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(50,2)];
    storeTime = [storeTime BOAllINI(50,1)];
    if interpolationBODist_Turn(49) == 1;
        txtDist = [dataToStr(BOAllINI(50,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(50,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(49) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(50,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(50,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(50,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos333, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime50in TurnTime50out TurnTime50];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos334, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(51,2)];
    storeTime = [storeTime BOAllINI(51,1)];
    if interpolationBODist_Turn(50) == 1;
        txtDist = [dataToStr(BOAllINI(51,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(51,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(50) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(51,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(51,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(51,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos335, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime51in TurnTime51out TurnTime51];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos336, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(52,2)];
    storeTime = [storeTime BOAllINI(52,1)];
    if interpolationBODist_Turn(51) == 1;
        txtDist = [dataToStr(BOAllINI(52,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(52,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(51) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(52,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(52,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(52,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos337, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime52in TurnTime52out TurnTime52];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos338, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(53,2)];
    storeTime = [storeTime BOAllINI(53,1)];
    if interpolationBODist_Turn(52) == 1;
        txtDist = [dataToStr(BOAllINI(53,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(53,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(52) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(53,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(53,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(53,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos339, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime53in TurnTime53out TurnTime53];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos340, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(54,2)];
    storeTime = [storeTime BOAllINI(54,1)];
    if interpolationBODist_Turn(53) == 1;
        txtDist = [dataToStr(BOAllINI(54,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(54,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(53) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(54,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(54,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(54,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos341, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime54in TurnTime54out TurnTime54];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos342, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(55,2)];
    storeTime = [storeTime BOAllINI(55,1)];
    if interpolationBODist_Turn(54) == 1;
        txtDist = [dataToStr(BOAllINI(55,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(55,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(54) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(55,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(55,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(55,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos343, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime55in TurnTime55out TurnTime55];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos344, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(56,2)];
    storeTime = [storeTime BOAllINI(56,1)];
    if interpolationBODist_Turn(55) == 1;
        txtDist = [dataToStr(BOAllINI(56,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(56,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(55) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(56,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(56,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(56,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos345, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime56in TurnTime56out TurnTime56];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos346, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(57,2)];
    storeTime = [storeTime BOAllINI(57,1)];
    if interpolationBODist_Turn(56) == 1;
        txtDist = [dataToStr(BOAllINI(57,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(57,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(56) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(57,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(57,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(57,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos347, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime57in TurnTime57out TurnTime57];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos348, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(58,2)];
    storeTime = [storeTime BOAllINI(58,1)];
    if interpolationBODist_Turn(57) == 1;
        txtDist = [dataToStr(BOAllINI(58,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(58,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(57) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(58,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(58,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(58,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos349, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime58in TurnTime58out TurnTime58];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos350, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(59,2)];
    storeTime = [storeTime BOAllINI(59,1)];
    if interpolationBODist_Turn(58) == 1;
        txtDist = [dataToStr(BOAllINI(59,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(59,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(58) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(59,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(59,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(59,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos351, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime59in TurnTime59out TurnTime59];
    txtCol2Sg_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos352, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    storeDist = [storeDist BOAllINI(60,2)];
    storeTime = [storeTime BOAllINI(60,1)];
    if interpolationBODist_Turn(59) == 1;
        txtDist = [dataToStr(BOAllINI(60,2), 1) '!'];
    else;
        txtDist = [dataToStr(BOAllINI(60,2), 1) ' '];
    end;
    if interpolationBOTime_Turn(59) == 1;
        txtTime = [timeSecToStr2(roundn(BOAllINI(60,1),-2)) '!'];
    else;
        txtTime = [timeSecToStr2(roundn(BOAllINI(60,1),-2)) ' '];
    end;
    txtKick = dataToStr(BOAllINI(60,3),0);
    txt = ['[' txtDist ' / ' txtTime ' / ' txtKick ']'];
    txtCol2S2g_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos353, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;





    txtCol1t_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos354, shiftRight, 33], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR25m ' ' DPS25m ' ' Breath25m];
    txtCol2U_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos356, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2U_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR50m ' ' DPS50m ' ' Breath50m];
    txtCol2V_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos357, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR75m ' ' DPS75m ' ' Breath75m];
    txtCol2W_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos358, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR100m ' ' DPS100m ' ' Breath100m];
    txtCol2X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos359, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR125m ' ' DPS125m ' ' Breath125m];
    txtCol2X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos360, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR150m ' ' DPS150m ' ' Breath150m];
    txtCol2X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos361, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR175m ' ' DPS175m ' ' Breath175m];
    txtCol2X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos362, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR200m ' ' DPS200m ' ' Breath200m];
    txtCol2X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos363, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR225m ' ' DPS225m ' ' Breath225m];
    txtCol2X_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size9(4)-pos364, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource8, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size9(4)-pos364, 1, pos364], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = ['  ' SR250m ' ' DPS250m ' ' Breath250m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos365, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR275m ' ' DPS275m ' ' Breath275m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos366, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR300m ' ' DPS300m ' ' Breath300m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos367, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR325m ' ' DPS325m ' ' Breath325m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos368, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR350m ' ' DPS350m ' ' Breath350m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos369, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR375m ' ' DPS375m ' ' Breath375m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos370, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR400m ' ' DPS400m ' ' Breath400m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos371, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

   txt = ['  ' SR425m ' ' DPS425m ' ' Breath425m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos372, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR450m ' ' DPS450m ' ' Breath450m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos373, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR475m ' ' DPS475m ' ' Breath475m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos374, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR500m ' ' DPS500m ' ' Breath500m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos375, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR525m ' ' DPS525m ' ' Breath525m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos376, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR550m ' ' DPS550m ' ' Breath550m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos377, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR575m ' ' DPS575m ' ' Breath575m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos378, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR600m ' ' DPS600m ' ' Breath600m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos379, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR625m ' ' DPS625m ' ' Breath625m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos380, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR650m ' ' DPS650m ' ' Breath650m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos381, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR675m ' ' DPS675m ' ' Breath675m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos382, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR700m ' ' DPS700m ' ' Breath700m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos383, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR725m ' ' DPS725m ' ' Breath725m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos384, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR750m ' ' DPS750m ' ' Breath750m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos385, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR775m ' ' DPS775m ' ' Breath775m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos386, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR800m ' ' DPS800m ' ' Breath800m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos387, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR825m ' ' DPS825m ' ' Breath825m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos388, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR850m ' ' DPS850m ' ' Breath850m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos389, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR875m ' ' DPS875m ' ' Breath875m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos390, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR900m ' ' DPS900m ' ' Breath900m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos391, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR925m ' ' DPS925m ' ' Breath925m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos392, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR950m ' ' DPS950m ' ' Breath950m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos393, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR975m ' ' DPS975m ' ' Breath975m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos394, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1000m ' ' DPS1000m ' ' Breath1000m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos395, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1025m ' ' DPS1025m ' ' Breath1025m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos396, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1050m ' ' DPS1050m ' ' Breath1050m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos397, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1075m ' ' DPS1075m ' ' Breath1075m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos398, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1100m ' ' DPS1100m ' ' Breath1100m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos399, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1125m ' ' DPS1125m ' ' Breath1125m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos400, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1150m ' ' DPS1150m ' ' Breath1150m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos401, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1175m ' ' DPS1175m ' ' Breath1175m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos402, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1200m ' ' DPS1200m ' ' Breath1200m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos403, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1225m ' ' DPS1225m ' ' Breath1225m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos404, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1250m ' ' DPS1250m ' ' Breath1250m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos405, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1275m ' ' DPS1275m ' ' Breath1275m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos406, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1300m ' ' DPS1300m ' ' Breath1300m];
    txtCol2X_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size10(4)-pos407, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource9, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size10(4)-pos407, 1, pos407], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = ['  ' SR1325m ' ' DPS1325m ' ' Breath1325m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos408, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1350m ' ' DPS1350m ' ' Breath1350m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos409, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1375m ' ' DPS1375m ' ' Breath1375m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos410, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1400m ' ' DPS1400m ' ' Breath1400m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos411, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1425m ' ' DPS1425m ' ' Breath1425m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos412, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1450m ' ' DPS1450m ' ' Breath1450m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos413, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1475m ' ' DPS1475m ' ' Breath1475m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos414, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR1500m ' ' DPS1500m ' ' Breath1500m];
    txtCol2X_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos415, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if length(BreathTot) == 3;
        txt = [' ' SRAverage ' ' DPSAverage ' ' BreathTot];
    else;
        txt = ['  ' SRAverage ' ' DPSAverage ' ' BreathTot];
    end;
    txtCol2Y_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size11(4)-pos416, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    if strcmpi(source, 'display') == 1;
        txtBlack_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size11(4)-pos416, 1, pos416-90], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        txtBlack_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [150+(shiftRight*(raceECmain-2)), panel_size11(4)-pos416, 1, pos416], 'HorizontalAlignment', 'left', ...
                'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
                'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;
end;

if length(bestRaceTime) > 1;
    [bestVal, bestIndex] = min(bestRaceTime);
    set(txtCol2E_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestSkillTime) > 1;
    [bestVal, bestIndex] = min(bestSkillTime);
    set(txtCol2F_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestFreeSwimTime) > 1;
    [bestVal, bestIndex] = min(bestFreeSwimTime);
    set(txtCol2G_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestVelocity) > 1;
    [bestVal, bestIndex] = max(bestVelocity);
    set(txtCol2H_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestBlock) > 1;
    [bestVal, bestIndex] = min(bestBlock);
    set(txtCol2I_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestStartTime) > 1;
    [bestVal, bestIndex] = min(bestStartTime);
    set(txtCol2J_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
    set(txtCol2J2_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(best25m) > 1;
    [bestVal, bestIndex] = min(best25m);
    set(txtCol2K_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestFinish) > 1;
    [bestVal, bestIndex] = min(bestFinish);
    set(txtCol2L_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;
if length(bestTurnAv) > 1;
    [bestVal, bestIndex] = min(bestTurnAv);
    set(txtCol2S2h_pdfStore{bestIndex,1}, 'Backgroundcolor', [0.9 0.8 0.1]);
    set(txtCol2S2h2_pdfStore{bestIndex(1),1}, 'Backgroundcolor', [0.9 0.8 0.1]);
end;

if strcmpi(lower(Gender), 'female') == 1;
    if Course == 25;
        titletxt = ['Women_' num2str(RaceDist) StrokeShort '_SCM'];
    else;
        titletxt = ['Women_' num2str(RaceDist) StrokeShort '_LCM'];
    end;
else;
    if Course == 25;
        titletxt = ['Men_' num2str(RaceDist) StrokeShort '_SCM'];
    else;
        titletxt = ['Men_' num2str(RaceDist) StrokeShort '_LCM'];
    end;
end;
txtTitle_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-25, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font1, 'String', titletxt);
set(txtTitle_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    txtBlack_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size11(4)-pos416, window_size(3)-60, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    txtBlack_pdf = uicontrol('parent', figSource10, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size11(4)-pos416, window_size(3)-60, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
end;

handles2.filename = filename;
handles2.hdef = hdef;
handles2.RaceDist = LapDist(end);
guidata(handles2.hdef, handles2);

close(hWait)
