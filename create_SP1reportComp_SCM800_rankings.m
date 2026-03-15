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
        'position', [1, resolution(2)-(0.1*resolution(2))-5220, 1200, 5200], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, resolution(2)-5200, 1200, 5200];
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
    pos19 = 1240;
    pos20 = 1237;
    pos21 = 1270;
    pos22 = 1290;
    pos23 = 1310;
    pos24 = 1330;
    pos25 = 1350;
    pos26 = 1370;
    pos27 = 1390;
    pos28 = 1410;
    pos29 = 1430;
    pos30 = 1450;
    pos31 = 1470;
    pos32 = 1490;
    pos33 = 1510;
    pos34 = 1530;
    pos35 = 1550;
    pos36 = 1570;
    pos37 = 1590;
    pos38 = 1610;
    pos39 = 1630;
    pos40 = 1650;
    pos41 = 1670;
    pos42 = 1690;

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
    pos19 = 395;
    pos20 = 392;
    pos21 = 425;
    pos22 = 445;
    pos23 = 465;
    pos24 = 485;
    pos25 = 505;
    pos26 = 525;
    pos27 = 545;
    pos28 = 565;
    pos29 = 585;
    pos30 = 605;
    pos31 = 625;
    pos32 = 645;
    pos33 = 665;
    pos34 = 685;
    pos35 = 705;
    pos36 = 725;
    pos37 = 745;
    pos38 = 765;
    pos39 = 785;
    pos40 = 805;
    pos41 = 825;
    pos42 = 845;

   
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



txtCol1o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos19, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos20, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos21, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --          25');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos22, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25           --          50');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos23, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --          75');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos24, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75           --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos25, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         125');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos26, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125         --         150');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos27, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         175');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos28, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos29, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         225');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos30, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225         --         250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos31, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         275');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos32, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos33, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         325');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos34, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325         --         350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos35, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         375');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos36, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos37, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         425');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos38, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425         --         450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos39, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         475');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos40, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos41, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         525');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos42, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525         --         550');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource2 = handles2.panelMain;

    pos43 = 1710;
    pos44 = 1730;
    pos45 = 1750;
    pos46 = 1770;
    pos47 = 1790;
    pos48 = 1810;
    pos49 = 1830;
    pos50 = 1850;
    pos51 = 1870;
    pos52 = 1890;
    pos53 = 1925;
    pos54 = 1922;
    pos55 = 1955;
    pos56 = 1975;
    pos57 = 1995;
    pos58 = 2015;
    pos59 = 2035;
    pos60 = 2055;
    pos61 = 2075;
    pos62 = 2095;
    pos63 = 2115;
    pos64 = 2135;
    pos65 = 2155;
    pos66 = 2175;
    pos67 = 2195;
    pos68 = 2215;
    pos69 = 2235;
    pos70 = 2255;
    pos71 = 2290;
    pos72 = 2287;
    pos73 = 2320;
    pos74 = 2340;
    pos75 = 2360;
    pos76 = 2380;
    pos77 = 2400;
    pos78 = 2420;
    pos79 = 2440;
    pos80 = 2460;
    pos81 = 2495;
    pos82 = 2492;
    pos83 = 2525;
    pos84 = 2545;
%     pos85 = 2565;

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
    pos47 = 100;
    pos48 = 120;
    pos49 = 140;
    pos50 = 160;
    pos51 = 180;
    pos52 = 200;
    pos53 = 235;
    pos54 = 232;
    pos55 = 260;
    pos56 = 280;
    pos57 = 300;
    pos58 = 320;
    pos59 = 340;
    pos60 = 360;
    pos61 = 380;
    pos62 = 400;
    pos63 = 420;
    pos64 = 440;
    pos65 = 460;
    pos66 = 480;
    pos67 = 500;
    pos68 = 520;
    pos69 = 540;
    pos70 = 560;
    pos71 = 595;
    pos72 = 592;
    pos73 = 625;
    pos74 = 645;
    pos75 = 665;
    pos76 = 685;
    pos77 = 705;
    pos78 = 725;
    pos79 = 745;
    pos80 = 765;
    pos81 = 800;
    pos82 = 797;
    pos83 = 830;
    pos84 = 850;
%     pos85 = 870;


    window_size3 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos84]);
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
        'position', [1, 1, 1200, pos84], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain3, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size3 = [1, 10, 1200, pos84];
    figSource2 = panelMain3;
end;

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos43, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         575');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos44, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos45, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         625');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos46, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625         --         650');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos47, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         675');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos48, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos49, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         725');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos50, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725         --         750');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos51, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         775');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos52, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');







txtCol1o_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size3(4)-pos53, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos54, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos55, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --          50');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos56, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos57, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         150');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos58, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos59, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos60, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos61, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos62, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos63, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos64, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos65, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         550');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos66, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos67, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         650');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos68, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos69, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         750');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos70, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');





txtCol1o_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size3(4)-pos71, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos72, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos73, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos74, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos75, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos76, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos77, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos78, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos79, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos80, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txtCol1o_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size3(4)-pos81, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos82, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos83, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos84, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource3 = handles2.panelMain;

%no pos85... missed it
    pos86 = 2565;
    pos87 = 2585;
    pos88 = 2620;
    pos89 = 2617;
    pos90 = 2650;
    pos91 = 2670;
    pos92 = 2705;
    pos93 = 2702;
    pos94 = 2735;
    pos95 = 2755;
    pos96 = 2775;
    pos97 = 2795;
    pos98 = 2815;
    pos99 = 2835;
    pos100 = 2855;
    pos101 = 2875;
    pos102 = 2895;
    pos103 = 2915;
    pos104 = 2935;
    pos105 = 2955;
    pos106 = 2975;
    pos107 = 2995;
    pos108 = 3015;
    pos109 = 3035;
    pos110 = 3055;
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
    pos126 = 3390;
    pos127 = 3387;
    pos128 = 3420;
    pos129 = 3435;


    

    panel_size4 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size3(4)-pos84, 1, pos84], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');


%no pos85... missed it
    pos86 = 20;
    pos87 = 40;
    pos88 = 75;
    pos89 = 72;
    pos90 = 105;
    pos91 = 125;
    pos92 = 160;
    pos93 = 157;
    pos94 = 190;
    pos95 = 210;
    pos96 = 230;
    pos97 = 250;
    pos98 = 270;
    pos99 = 290;
    pos100 = 310;
    pos101 = 330;
    pos102 = 350;
    pos103 = 370;
    pos104 = 390;
    pos105 = 410;
    pos106 = 430;
    pos107 = 450;
    pos108 = 470;
    pos109 = 490;
    pos110 = 510;
    pos111 = 530;
    pos112 = 550;
    pos113 = 570;
    pos114 = 590;
    pos115 = 610;
    pos116 = 630;
    pos117 = 650;
    pos118 = 670;
    pos119 = 690;
    pos120 = 710;
    pos121 = 730;
    pos122 = 750;
    pos123 = 770;
    pos124 = 790;
    pos125 = 810;
    pos126 = 845;
    pos127 = 842;
    pos128 = 875;
    pos129 = 890;

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
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos87, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');





txtCol1o_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size4(4)-pos88, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos89, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos90, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos91, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');









txtCol1o_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size4(4)-pos92, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos93, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'STROKE COUNTS');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1P_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos94, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 1');
set(txtCol1P_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos95, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 2');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos96, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 3');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos97, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 4');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos98, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 5');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos99, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 6');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos100, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 7');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos101, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 8');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos102, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 9');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos103, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 10');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos104, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 11');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos105, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 12');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos106, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 13');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos107, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 14');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos108, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 15');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos109, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 16');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos110, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 17');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos111, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 18');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos112, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 19');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos113, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 20');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos114, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 21');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos115, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 22');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos116, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 23');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos117, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 24');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos118, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 25');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos119, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 26');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos120, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 27');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos121, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 28');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos122, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 29');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos123, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 30');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos124, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 31');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos125, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 32');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');









txtCol1r_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size4(4)-pos126, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1R_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos127, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'TURNS [in out turn (s)]');
set(txtCol1R_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sa_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos128, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 1');
set(txtCol1Sa_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2a_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos129, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    figSource4 = handles2.panelMain;


    pos130 = 3455;
    pos131 = 3470;
    pos132 = 3490;
    pos133 = 3505;
    pos134 = 3525;
    pos135 = 3540;
    pos136 = 3560;
    pos137 = 3575;
    pos138 = 3595;
    pos139 = 3610;
    pos140 = 3630;
    pos141 = 3645;
    pos142 = 3665;
    pos143 = 3680;
    pos144 = 3700;
    pos145 = 3715;
    pos146 = 3735;
    pos147 = 3750;
    pos148 = 3770;
    pos149 = 3785;
    pos150 = 3805;
    pos151 = 3820;
    pos152 = 3840;
    pos153 = 3855;
    pos154 = 3875;
    pos155 = 3890;
    pos156 = 3910;
    pos157 = 3925;
    pos158 = 3945;
    pos159 = 3960;
    pos160 = 3980;
    pos161 = 3995;
    pos162 = 4015;
    pos163 = 4030;
    pos164 = 4050;
    pos165 = 4065;
    pos166 = 4085;
    pos167 = 4100;
    pos168 = 4120;
    pos169 = 4135;
    pos170 = 4155;
    pos171 = 4170;
    pos172 = 4190;
    pos173 = 4205;
   

    panel_size5 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size4(4)-pos129, 1, pos129], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    pos130 = 20;
    pos131 = 35;
    pos132 = 55;
    pos133 = 70;
    pos134 = 90;
    pos135 = 105;
    pos136 = 125;
    pos137 = 140;
    pos138 = 160;
    pos139 = 175;
    pos140 = 195;
    pos141 = 210;
    pos142 = 230;
    pos143 = 245;
    pos144 = 265;
    pos145 = 280;
    pos146 = 300;
    pos147 = 315;
    pos148 = 335;
    pos149 = 350;
    pos150 = 370;
    pos151 = 385;
    pos152 = 405;
    pos153 = 420;
    pos154 = 440;
    pos155 = 455;
    pos156 = 475;
    pos157 = 480;
    pos158 = 500;
    pos159 = 515;
    pos160 = 535;
    pos161 = 550;
    pos162 = 570;
    pos163 = 585;
    pos164 = 605;
    pos165 = 620;
    pos166 = 640;
    pos167 = 655;
    pos168 = 675;
    pos169 = 690;
    pos170 = 705;
    pos171 = 725;
    pos172 = 740;
    pos173 = 755;

    window_size5 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos173]);
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
        'position', [1, 1, 1200, pos173], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain5, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size5 = [1, 10, 1200, pos173];
    figSource4 = panelMain5;
end;

txtCol1Sb_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos130, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 2');
set(txtCol1Sb_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2b_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos131, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sc_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos132, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 3');
set(txtCol1Sc_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2c_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos133, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2c_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sd_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos134, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 4');
set(txtCol1Sd_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2d_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos135, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2d_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Se_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos136, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 5');
set(txtCol1Se_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2e_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos137, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2e_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sf_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos138, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 6');
set(txtCol1Sf_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2f_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos139, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2f_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos140, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 7');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos141, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos142, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 8');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos143, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos144, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 9');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos145, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos146, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 10');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos147, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos148, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 11');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos149, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos150, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 12');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos151, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos152, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 13');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos153, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos154, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 14');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos155, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos156, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 15');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos157, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos158, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 16');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos159, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos160, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 17');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos161, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos162, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 18');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos163, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos164, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 19');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos165, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos166, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 20');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos167, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos168, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 21');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos169, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos170, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 22');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos171, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos172, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 23');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size5(4)-pos173, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource5 = handles2.panelMain;

    
    pos174 = 4225;
    pos175 = 4240;
    pos176 = 4260;
    pos177 = 4275;
    pos178 = 4295;
    pos179 = 4310;
    pos180 = 4330;
    pos181 = 4345;
    pos182 = 4365;
    pos183 = 4380;
    pos184 = 4400;
    pos185 = 4415;
    pos186 = 4435;
    pos187 = 4450;
    pos188 = 4470;
    pos189 = 4485;
    pos190 = 4520;
    pos191 = 4517;
    pos192 = 4550;
    pos193 = 4570;
    pos194 = 4590;
    pos195 = 4610;
    pos196 = 4630;
    pos197 = 4650;
    pos198 = 4670;
    pos199 = 4690;
    pos200 = 4710;
    pos201 = 4730;
    pos202 = 4750;
    pos203 = 4770;
    pos204 = 4790;
    pos205 = 4810;
    pos206 = 4830;
    pos207 = 4850;
    pos208 = 4870;
    pos209 = 4890;
    pos210 = 4910;
    pos211 = 4930;
    pos212 = 4950;
    pos213 = 4970;
    pos214 = 4990;

    panel_size6 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size5(4)-pos173, 1, pos173], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    pos174 = 20;
    pos175 = 35;
    pos176 = 55;
    pos177 = 70;
    pos178 = 90;
    pos179 = 105;
    pos180 = 125;
    pos181 = 140;
    pos182 = 160;
    pos183 = 175;
    pos184 = 195;
    pos185 = 210;
    pos186 = 230;
    pos187 = 245;
    pos188 = 265;
    pos189 = 280;
    pos190 = 315;
    pos191 = 312;
    pos192 = 345;
    pos193 = 365;
    pos194 = 385;
    pos195 = 405;
    pos196 = 425;
    pos197 = 445;
    pos198 = 465;
    pos199 = 485;
    pos200 = 505;
    pos201 = 525;
    pos202 = 545;
    pos203 = 565;
    pos204 = 585;
    pos205 = 605;
    pos206 = 625;
    pos207 = 645;
    pos208 = 665;
    pos209 = 685;
    pos210 = 705;
    pos211 = 725;
    pos212 = 745;
    pos213 = 765;
    pos214 = 785;

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


txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos174, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 24');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos175, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos176, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 25');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos177, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos178, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 26');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos179, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos180, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 27');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos181, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos182, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 28');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos183, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos184, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 29');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos185, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos186, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 30');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos187, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos188, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 31');
set(txtCol1Sg_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos189, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');








txtCol1t_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size6(4)-pos190, 120, 32], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1T_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos191, 115, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', {'STROKES'; '[SR DPS Breath]'});
set(txtCol1T_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1U_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos192, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --           25');
set(txtCol1U_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1V_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos193, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25           --           50');
set(txtCol1V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos194, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --           75');
set(txtCol1X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos195, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75           --         100');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos196, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         125');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos197, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125         --         150');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos198, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         175');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos199, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175         --         200');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos200, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         225');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos201, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225         --         250');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos202, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         275');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos203, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275         --         300');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos204, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         325');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos205, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325         --         350');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos206, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         375');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos207, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375         --         400');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos208, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         425');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos209, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425         --         450');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos210, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         475');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos211, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475         --         500');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos212, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         525');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos213, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525         --         550');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size6(4)-pos214, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         575');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');


if strcmpi(source, 'display') == 1;
    figSource6 = handles2.panelMain;

    
    pos215 = 5010;
    pos216 = 5030;
    pos217 = 5050;
    pos218 = 5070;
    pos219 = 5090;
    pos220 = 5110;
    pos221 = 5130;
    pos222 = 5150;
    pos223 = 5170;
    pos224 = 5190;


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

    window_size7 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 pos224+10]);
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
        'position', [1, 1, 1200, pos224+10], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain7, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size7 = [1, 10, 1200, pos224+10];
    figSource6 = panelMain7;
end;

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos215, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575         --         600');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos216, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         625');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos217, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625         --         650');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos218, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         675');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos219, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675         --         700');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos220, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         725');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos221, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725         --         750');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos222, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         775');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos223, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775         --         800');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');


txt = 'Averages / Totals';
txtCol1Z_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size7(4)-pos224, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'Fontsize', font4, 'String', txt, 'FontWeight', 'bold');
set(txtCol1Z_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size7(4)-pos224, 1, pos224-90], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size7(4)-pos224, 1, pos224], 'HorizontalAlignment', 'left', ...
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


        SplitLap1_100 = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
        SplitLap2_100 = timeSecToStr2(dataTablePacing(40,colinterest_Splits) - dataTablePacing(20,colinterest_Splits));
        SplitLap3_100 = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap4_100 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
        SplitLap5_100 = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap6_100 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
        SplitLap7_100 = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
        SplitLap8_100 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));

        
        SplitLap1_200 = timeSecToStr2(dataTablePacing(40,colinterest_Splits));
        SplitLap2_200 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap3_200 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap4_200 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));

        SplitLap1_400 = timeSecToStr2(dataTablePacing(80,colinterest_Splits));
        SplitLap2_400 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));


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

        
        bestRaceTime = [bestRaceTime dataTableAverage{160,12}];
        RaceTime = Split800m;
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


        SplitLap1_100 = timeSecToStr2(dataTableAverage{20,12});
        SplitLap2_100 = timeSecToStr2(dataTableAverage{40,12}-dataTableAverage{20,12});
        SplitLap3_100 = timeSecToStr2(dataTableAverage{60,12}-dataTableAverage{40,12});
        SplitLap4_100 = timeSecToStr2(dataTableAverage{80,12}-dataTableAverage{60,12});
        SplitLap5_100 = timeSecToStr2(dataTableAverage{100,12}-dataTableAverage{80,12});
        SplitLap6_100 = timeSecToStr2(dataTableAverage{120,12}-dataTableAverage{100,12});
        SplitLap7_100 = timeSecToStr2(dataTableAverage{140,12}-dataTableAverage{120,12});
        SplitLap8_100 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{140,12});


        SplitLap1_200 = timeSecToStr2(dataTableAverage{40,12});
        SplitLap2_200 = timeSecToStr2(dataTableAverage{80,12}-dataTableAverage{40,12});
        SplitLap3_200 = timeSecToStr2(dataTableAverage{120,12}-dataTableAverage{80,12});
        SplitLap4_200 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{120,12});


        SplitLap1_400 = timeSecToStr2(dataTableAverage{80,12});
        SplitLap2_400 = timeSecToStr2(dataTableAverage{160,12}-dataTableAverage{80,12});


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
        425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800];
    KeyDist = [25 50 75 100 125 150 175 200 225 250 275 300 325 350 375 400 ...
        425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800];
    
    bestBlock = [bestBlock RT];
    RT = timeSecToStr2(RT);
    
    NbLap = RaceDist./Course;
    isInterpolatedTurn = [];
    bestTurnRace = [];
    zoneSC = 5;
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        locTurnData = [32 40 48 56 64 72 80 88 96 104 112 120 128 136 144 ...
            152 160 169 176 184 192 200 208 216 224 232 240 248 256];
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

    %Breath 400m, long intervals take col=3
    validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
        85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
        %it's a 800 so take col = 7 for long intervals
        colinterest_DPS = 7;
        colinterest_DPSInterp = 8;

        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
        %it's a 800 so take col = 10 for short intervals
        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
        
        %It's a 800m so take col = 3 for long intervals
        colinterest_SR = 3;
        colinterest_SRInterp = 4;

        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
        %It's a 800m so take col = 7 for long intervals
        validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
            85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
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
        %It's a 800m so take col = 11 for long intervals
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
        %It's a 800m so take col = 16 for long intervals
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




    txtCol2o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos19, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_25;
    txtCol2P_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos21, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2P_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_25;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos22, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_25;
    txtCol2R_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos23, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2R_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_25;
    txtCol2S_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos24, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_25;
    txtCol2T_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos25, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2T_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_25;
    txtCol2U_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos26, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2U_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_25;
    txtCol2V_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos27, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap8_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos28, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap9_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos29, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap10_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos30, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap11_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos31, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap12_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos32, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap13_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos33, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap14_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos34, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap15_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos35, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap16_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos36, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap17_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos37, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap18_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos38, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap19_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos39, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap20_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos40, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap21_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos41, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap22_25;
    txtCol2W_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos42, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size2(4)-pos42, 1, pos42], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = SplitLap23_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos43, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap24_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos44, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap25_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos45, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap26_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos46, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap27_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos47, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap28_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos48, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap29_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos49, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap30_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos50, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap31_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos51, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap32_25;
    txtCol2W_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos52, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    
    
    





    txtCol2r_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos53, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos55, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos56, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos57, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos58, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos59, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos60, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos61, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap8_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos62, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap9_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos63, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap10_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos64, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap11_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos65, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap12_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos66, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap13_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos67, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap14_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos68, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap15_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos69, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap16_50;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos70, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');








    txtCol2r_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos71, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos73, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos74, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap3_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos75, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap4_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos76, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap5_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos77, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap6_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos78, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap7_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos79, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap8_100;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos80, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');






    txtCol2r_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos81, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_200;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos83, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_200;
    txtCol2Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos84, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size3(4)-pos84, 1, pos84], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = SplitLap3_200;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos86, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap4_200;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos87, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');



    txtCol2r_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos88, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap1_400;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos90, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = SplitLap2_400;
    txtCol2Q_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos91, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');






    txtCol2r_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos92, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(1));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos94, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(2));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos95, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(3));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos96, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(4));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos97, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(5));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos98, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(6));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos99, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(7));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos100, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(8));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos101, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(9));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos102, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(10));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos103, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(11));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos104, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(12));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos105, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(13));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos106, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(14));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos107, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(15));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos108, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(16));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos109, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(17));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos110, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(18));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos111, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(19));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos112, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(20));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos113, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(21));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos114, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(22));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos115, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(23));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos116, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(24));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos117, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(25));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos118, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(26));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos119, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(27));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos120, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(28));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos121, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(29));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos122, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(30));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos123, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(31));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos124, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 

    txt = num2str(Stroke_Count(32));
    txtCol2S_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos125, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 






    txtCol2r_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos126, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    storeDist = [];
    storeTime = [];

    txt = [' ' TurnTime1in TurnTime1out TurnTime1];
    txtCol2Sa_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos128, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2a_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos129, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2a_pdfStore{raceECmain-2,1} = txtCol2S2a_pdf;


    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size4(4)-pos129, 1, pos129], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = [' ' TurnTime2in TurnTime2out TurnTime2];
    txtCol2Sb_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos130, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2b_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos131, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2b_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2b_pdfStore{raceECmain-2,1} = txtCol2S2b_pdf;

    txt = [' ' TurnTime3in TurnTime3out TurnTime3];
    txtCol2Sc_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos132, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2c_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos133, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2c_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2c_pdfStore{raceECmain-2,1} = txtCol2S2c_pdf;

    txt = [' ' TurnTime4in TurnTime4out TurnTime4];
    txtCol2Sd_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos134, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2d_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos135, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2d_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2d_pdfStore{raceECmain-2,1} = txtCol2S2d_pdf;

    txt = [' ' TurnTime5in TurnTime5out TurnTime5];
    txtCol2Se_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos136, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2e_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos137, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2e_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2e_pdfStore{raceECmain-2,1} = txtCol2S2e_pdf;

    txt = [' ' TurnTime6in TurnTime6out TurnTime6];
    txtCol2Sf_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos138, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2f_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos139, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2f_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2f_pdfStore{raceECmain-2,1} = txtCol2S2f_pdf;

    txt = [' ' TurnTime7in TurnTime7out TurnTime7];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos140, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos141, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;


    txt = [' ' TurnTime8in TurnTime8out TurnTime8];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos142, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos143, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime9in TurnTime9out TurnTime9];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos144, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos145, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime10in TurnTime10out TurnTime10];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos146, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos147, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime11in TurnTime11out TurnTime11];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos148, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos149, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime12in TurnTime12out TurnTime12];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos150, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos151, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime13in TurnTime13out TurnTime13];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos152, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos153, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime14in TurnTime14out TurnTime14];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos154, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos155, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime15in TurnTime15out TurnTime15];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos156, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos157, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime16in TurnTime16out TurnTime16];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos158, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos159, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime17in TurnTime17out TurnTime17];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos160, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos161, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime18in TurnTime18out TurnTime18];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos162, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos163, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime19in TurnTime19out TurnTime19];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos164, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos165, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime20in TurnTime20out TurnTime20];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos166, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos167, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime21in TurnTime21out TurnTime21];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos168, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos169, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime22in TurnTime22out TurnTime22];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos170, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos171, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime23in TurnTime23out TurnTime23];
    txtCol2Sg_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos172, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size5(4)-pos173, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource4, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size5(4)-pos173, 1, pos173], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = [' ' TurnTime24in TurnTime24out TurnTime24];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos174, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos175, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime25in TurnTime25out TurnTime25];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos176, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos177, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime26in TurnTime26out TurnTime26];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos178, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos179, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime27in TurnTime27out TurnTime27];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos180, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos181, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime28in TurnTime28out TurnTime28];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos182, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos183, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime29in TurnTime29out TurnTime29];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos184, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos185, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime30in TurnTime30out TurnTime30];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos186, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos187, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime31in TurnTime31out TurnTime31];
    txtCol2Sg_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos188, shiftRight, 20], 'HorizontalAlignment', 'center', ...
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
    txtCol2S2g_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos189, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;








    txtCol1t_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos190, shiftRight, 33], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR25m ' ' DPS25m ' ' Breath25m];
    txtCol2U_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos192, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2U_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR50m ' ' DPS50m ' ' Breath50m];
    txtCol2V_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos193, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR75m ' ' DPS75m ' ' Breath75m];
    txtCol2W_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos194, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR100m ' ' DPS100m ' ' Breath100m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos195, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR125m ' ' DPS125m ' ' Breath125m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos196, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR150m ' ' DPS150m ' ' Breath150m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos197, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR175m ' ' DPS175m ' ' Breath175m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos198, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR200m ' ' DPS200m ' ' Breath200m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos199, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR225m ' ' DPS225m ' ' Breath225m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos200, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR250m ' ' DPS250m ' ' Breath250m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos201, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR275m ' ' DPS275m ' ' Breath275m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos202, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR300m ' ' DPS300m ' ' Breath300m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos203, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR325m ' ' DPS325m ' ' Breath325m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos204, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR350m ' ' DPS350m ' ' Breath350m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos205, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR375m ' ' DPS375m ' ' Breath375m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos206, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR400m ' ' DPS400m ' ' Breath400m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos207, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

   txt = ['  ' SR425m ' ' DPS425m ' ' Breath425m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos208, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR450m ' ' DPS450m ' ' Breath450m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos209, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR475m ' ' DPS475m ' ' Breath475m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos210, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR500m ' ' DPS500m ' ' Breath500m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos211, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR525m ' ' DPS525m ' ' Breath525m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos212, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR550m ' ' DPS550m ' ' Breath550m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos213, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR575m ' ' DPS575m ' ' Breath575m];
    txtCol2X_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size6(4)-pos214, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource5, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size6(4)-pos214, 1, pos214], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = ['  ' SR600m ' ' DPS600m ' ' Breath600m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos215, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR625m ' ' DPS625m ' ' Breath625m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos216, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR650m ' ' DPS650m ' ' Breath650m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos217, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR675m ' ' DPS675m ' ' Breath675m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos218, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR700m ' ' DPS700m ' ' Breath700m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos219, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR725m ' ' DPS725m ' ' Breath725m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos220, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR750m ' ' DPS750m ' ' Breath750m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos221, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR775m ' ' DPS775m ' ' Breath775m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos222, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR800m ' ' DPS800m ' ' Breath800m];
    txtCol2X_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos223, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    if length(BreathTot) == 3;
        txt = [' ' SRAverage ' ' DPSAverage ' ' BreathTot];
    else;
        txt = ['  ' SRAverage ' ' DPSAverage ' ' BreathTot];
    end;
    txtCol2Y_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size7(4)-pos224, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    if strcmpi(source, 'display') == 1;
        txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size7(4)-pos224, 1, pos224-90], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
                'position', [150+(shiftRight*(raceECmain-2)), panel_size7(4)-pos224, 1, pos224], 'HorizontalAlignment', 'left', ...
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
    txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size7(4)-pos224, window_size(3)-60, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    txtBlack_pdf = uicontrol('parent', figSource6, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size7(4)-pos224, window_size(3)-60, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
end;

handles2.filename = filename;
handles2.hdef = hdef;
handles2.RaceDist = LapDist(end);
guidata(handles2.hdef, handles2);
