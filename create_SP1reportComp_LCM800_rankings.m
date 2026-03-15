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
%     window_size = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 825]);
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
        'position', [1, resolution(2)-(0.1*resolution(2))-3190+10, 1200, 3190+10], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, resolution(2)-3190, 1200, 3190+10];
    handles2.panel_size = get(handles2.panelMain, 'Position');
    
    handles2.sliderRight = uicontrol('parent', hdef, 'Style', 'Slider', 'Visible', 'on', ...
        'Units', 'Pixels', 'Position', [1180 1 20 resolution(2)-(0.1*resolution(2))-1],...
        'min', 0, 'max', 1, 'callback', @sliderRight_report, 'Value', 1, ...
        'sliderstep', [1 1]);
    set(handles2.sliderRight, 'fontunits', 'normalized', 'units', 'normalized');
    
    handles2.save_button_report = uicontrol('parent', handles2.panelMain, 'Style', 'Pushbutton', ...
        'Visible', 'on', 'units', 'pixels', ...
        'position', [970 panel_size(4)-70 200 30], 'callback', @savedata_report_benchmark, ...
        'BackgroundColor', [0.9 0.9 0.9], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', ...
        'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Export to JPG');
    set(handles2.save_button_report, 'fontunits', 'normalized', 'Units', 'Normalized');

    set(hdef, 'WindowScrollWheelFcn', @scrollSP1report);
else;
    handles2.panelMain = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
        'position', [1, 1, 1200, 1125], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(handles2.panelMain, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size = [1, resolution(2)-825, 1200, 825];
    handles2.panel_size = get(handles2.panelMain, 'Position');
end;

txtTitle_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, panel_size(4)-65, 600, 20], 'HorizontalAlignment', 'left', ...
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
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BO Dist / BO Time / Kicks]');
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
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50 m SPLITS');
set(txtCol1M_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-585, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-605, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-625, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-645, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-665, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-685, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-705, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-725, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-745, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-765, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-785, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-805, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size(4)-825, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    figSource = handles2.panelMain;
    pos1 = 845;
    pos2 = 865;
    pos3 = 885;
    pos4 = 920;
    pos5 = 917;
    pos6 = 945;
    pos7 = 965;
    pos8 = 985;
    pos9 = 1005;
    pos10 = 1025;
    pos11 = 1045;
    pos12 = 1065;
    pos13 = 1085;
    pos14 = 1105;
    pos15 = 1125;
    pos16 = 1145;
    pos17 = 1165;
    pos18 = 1185;
    pos19 = 1205;
    pos20 = 1225;
    pos21 = 1245;
    pos22 = 1280;
    pos23 = 1277;
    pos24 = 1305;
    pos25 = 1325;
    pos26 = 1345;
    pos27 = 1365;
    pos28 = 1385;
    pos29 = 1405;
    pos30 = 1425;
    pos31 = 1445;
    pos32 = 1480;
    pos33 = 1477;
    pos34 = 1505;
    pos35 = 1525;
    pos36 = 1545;
    pos37 = 1565;
    pos38 = 1600;
    pos39 = 1597;
    pos40 = 1625;
    pos41 = 1645;
    pos42 = 1665;
    pos43 = 1685;
    panel_size2 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size(4)-825, 1, 735], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos1 = 20;
    pos2 = 40;
    pos3 = 60;
    pos4 = 95;
    pos5 = 92;
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
    pos22 = 455;
    pos23 = 452;
    pos24 = 480;
    pos25 = 500;
    pos26 = 520;
    pos27 = 540;
    pos28 = 560;
    pos29 = 580;
    pos30 = 600;
    pos31 = 620;
    pos32 = 655;
    pos33 = 652;
    pos34 = 680;
    pos35 = 700;
    pos36 = 720;
    pos37 = 740;
    pos38 = 775;
    pos39 = 772;
    pos40 = 800;
    pos41 = 820;
    pos42 = 840;
    pos43 = 860;

    window_size2 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 860]);
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
        'position', [1, 1, 1200, 860], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain2, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size2 = [1, 10, 1200, 860];
    figSource = panelMain2;
end;

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos1, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos2, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos3, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '800 m');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txtCol1o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos4, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos5, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos6, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --          50');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos7, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos8, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         150');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos9, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos10, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         250');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos11, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos12, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         350');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos13, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos14, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         450');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos15, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos16, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         550');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos17, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos18, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         650');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos19, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos20, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         750');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos21, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');





txtCol1o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos22, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos23, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos24, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --         100');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos25, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos26, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         300');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos27, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos28, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         500');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos29, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos30, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         700');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos31, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');




txtCol1o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos32, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos33, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200 m TIMES');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos34, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --          200');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos35, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --          400');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos36, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --          600');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos37, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --          800');
set(txtCol1N_pdf, 'fontunits', 'normalized', 'units', 'normalized');



txtCol1o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size2(4)-pos38, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1O_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos39, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'STROKE COUNTS');
set(txtCol1O_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1P_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos40, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 1');
set(txtCol1P_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos41, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 2');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos42, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 3');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size2(4)-pos43, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 4');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    figSource = handles2.panelMain;
    figSource2 = handles2.panelMain;
    pos44 = 1705;
    pos45 = 1725;
    pos46 = 1745;
    pos47 = 1765;
    pos48 = 1785;
    pos49 = 1805;
    pos50 = 1825;
    pos51 = 1845;
    pos52 = 1865;
    pos53 = 1885;
    pos54 = 1905;
    pos55 = 1925;
    pos56 = 1960;
    pos57 = 1957;
    pos58 = 1990;
    pos59 = 2005;
    pos60 = 2025;
    pos61 = 2040;
    pos62 = 2060;
    pos63 = 2075;
    pos64 = 2095;
    pos65 = 2110;
    pos66 = 2130;
    pos67 = 2145;
    pos68 = 2165;
    pos69 = 2180;
    pos70 = 2200;
    pos71 = 2215;
    pos72 = 2235;
    pos73 = 2250;
    pos74 = 2270;
    pos75 = 2285;
    pos76 = 2300;
    pos77 = 2315;
    pos78 = 2335;
    pos79 = 2350;
    pos80 = 2370;
    pos81 = 2385;
    pos82 = 2405;
    pos83 = 2420;
    pos84 = 2440;
    pos85 = 2455;
    pos86 = 2475;
    pos87 = 2490;
    pos88 = 2525;
    pos89 = 2522;
    pos90 = 2550;
    panel_size3 = panel_size;
else;
    txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size2(4)-pos43, 1, pos43], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos44 = 20;
    pos45 = 40;
    pos46 = 60;
    pos47 = 80;
    pos48 = 100;
    pos49 = 120;
    pos50 = 140;
    pos51 = 160;
    pos52 = 180;
    pos53 = 200;
    pos54 = 220;
    pos55 = 240;
    pos56 = 275;
    pos57 = 272;
    pos58 = 300;
    pos59 = 315;
    pos60 = 340;
    pos61 = 355;
    pos62 = 375;
    pos63 = 390;
    pos64 = 410;
    pos65 = 425;
    pos66 = 445;
    pos67 = 460;
    pos68 = 480;
    pos69 = 495;
    pos70 = 515;
    pos71 = 530;
    pos72 = 550;
    pos73 = 565;
    pos74 = 585;
    pos75 = 600;
    pos76 = 615;
    pos77 = 630;
    pos78 = 650;
    pos79 = 665;
    pos80 = 680;
    pos81 = 695;
    pos82 = 720;
    pos83 = 735;
    pos84 = 755;
    pos85 = 770;
    pos86 = 790;
    pos87 = 805;
    pos88 = 840;
    pos89 = 837;
    pos90 = 865;

    window_size3 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 865]);
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
        'position', [1, 1, 1200, 865], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain3, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size3 = [1, 10, 1200, 865];
    figSource2 = panelMain3;
end;

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos44, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 5');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos45, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 6');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos46, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 7');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos47, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 8');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos48, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 9');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos49, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 10');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos50, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 11');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos51, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 12');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos52, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 13');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos53, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 14');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos54, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 15');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Q_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos55, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Lap 16');
set(txtCol1Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');





txtCol1r_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size3(4)-pos56, 120, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
txtCol1R_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos57, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'TURNS [in out turn (s)]');
set(txtCol1R_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos58, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 1');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2a_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos59, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos60, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 2');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2b_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos61, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2b_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos62, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 3');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2c_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos63, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2c_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos64, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 4');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2d_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos65, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2d_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos66, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 5');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2e_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos67, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2e_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos68, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 6');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2f_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos69, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2f_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos70, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 7');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos71, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos72, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 8');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2h_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos73, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2h_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos74, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 9');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2i_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos75, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2i_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos76, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 10');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2j_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos77, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2j_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos78, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 11');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2k_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos79, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2k_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos80, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 12');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2l_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos81, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2l_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos82, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 13');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2m_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos83, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2m_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos84, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 14');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2n_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos85, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2n_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos86, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', 'Turn 15');
set(txtCol1S_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1S2o_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos87, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-2, 'String', '[BODist / BOTime / Kicks]');
set(txtCol1S2o_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1t_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, panel_size3(4)-pos88, 120, 32], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1T_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos89, 115, 30], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', {'STROKES'; '[SR DPS Breath]'});
set(txtCol1T_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1U_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size3(4)-pos90, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '0             --           25');
set(txtCol1U_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    figSource = handles2.panelMain;
    figSource2 = handles2.panelMain;
    figSource3 = handles2.panelMain;
    pos91 = 2570;
    pos92 = 2590;
    pos93 = 2610;
    pos94 = 2630;
    pos95 = 2650;
    pos96 = 2670;
    pos97 = 2690;
    pos98 = 2710;
    pos99 = 2730;
    pos100 = 2750;
    pos101 = 2770;
    pos102 = 2790;
    pos103 = 2810;
    pos104 = 2830;
    pos105 = 2850;
    pos106 = 2870;
    pos107 = 2890;
    pos108 = 2910;
    pos109 = 2930;
    pos110 = 2950;
    pos111 = 2970;
    pos112 = 2990;
    pos113 = 3010;
    pos114 = 3030;
    pos115 = 3050;
    pos116 = 3070;
    pos117 = 3090;
    pos118 = 3110;
    pos119 = 3130;
    pos120 = 3150;
    pos121 = 3170;
    pos122 = 3190;
    panel_size4 = panel_size;
else;

    txtBlack_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size3(4)-pos90, 1, pos90], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    pos91 = 20;
    pos92 = 40;
    pos93 = 60;
    pos94 = 80;
    pos95 = 100;
    pos96 = 120;
    pos97 = 140;
    pos98 = 160;
    pos99 = 180;
    pos100 = 200;
    pos101 = 220;
    pos102 = 240;
    pos103 = 260;
    pos104 = 280;
    pos105 = 300;
    pos106 = 320;
    pos107 = 340;
    pos108 = 360;
    pos109 = 380;
    pos110 = 400;
    pos111 = 420;
    pos112 = 440;
    pos113 = 460;
    pos114 = 480;
    pos115 = 500;
    pos116 = 520;
    pos117 = 540;
    pos118 = 560;
    pos119 = 560;
    pos120 = 580;
    pos121 = 600;
    pos122 = 620;

    window_size4 = floor([(resolution(1)-1200)./2 0.05*resolution(2) 1200 620+20]);
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
        'position', [1, 1, 1200, 620+20], ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'BorderType', 'none');
    set(panelMain4, 'fontunits', 'normalized', 'units', 'normalized');
    panel_size4 = [1, 10, 1200, 620+20];
    figSource3 = panelMain4;
end;

txtCol1V_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos91, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '25           --           50');
set(txtCol1V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1X_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos92, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '50           --           75');
set(txtCol1X_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos93, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '75           --         100');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos94, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '100         --         125');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos95, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '125         --         150');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos96, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '150         --         175');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos97, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '175         --         200');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos98, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '200         --         225');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos99, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '225         --         250');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos100, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '250         --         275');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos101, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '275         --         300');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos102, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '300         --         325');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos103, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '325         --         350');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos104, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '350         --         375');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos105, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '375         --         400');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos106, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '400         --         425');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos107, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '425         --         450');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos108, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '450         --         475');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos109, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '475         --         500');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos110, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '500         --         525');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos111, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '525         --         550');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos112, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '550         --         575');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos113, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '575         --         600');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos114, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '600         --         625');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos115, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '625         --         650');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos116, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '650         --         675');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos117, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '675         --         700');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos118, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '700         --         725');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos119, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '725         --         750');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos120, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '750         --         775');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txtCol1Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos121, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Normal', 'Fontsize', font4, 'String', '775         --         800');
set(txtCol1Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');

txt = 'Averages / Totals';
txtCol1Z_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [35, panel_size4(4)-pos122, 115, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'Fontsize', font4, 'String', txt, 'FontWeight', 'bold');
set(txtCol1Z_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size4(4)-pos122, 1, pos122-90], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [150, panel_size4(4)-pos122, 1, pos122], 'HorizontalAlignment', 'left', ...
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
        %its a 800m so that long intervals col = 3
        colinterest_Splits = 3;
        colinterest_SplitsInterp = 4;
        if dataTablePacing(3,colinterest_SplitsInterp) == 1;
            Split15m = [timeSecToStr2(dataTablePacing(3,colinterest_Splits)) ' !'];
        else;
            Split15m = timeSecToStr2(dataTablePacing(3,colinterest_Splits));
        end;

        if dataTablePacing(5,colinterest_SplitsInterp) == 1;
            Split25m = [timeSecToStr2(dataTablePacing(5,colinterest_Splits)) ' !'];
        else;
            Split25m = timeSecToStr2(dataTablePacing(5,colinterest_Splits));
        end;
        best25m = [best25m dataTablePacing(5,colinterest_Splits)];
           
        Split50m = timeSecToStr2(dataTablePacing(10,colinterest_Splits));
    
        if dataTablePacing(15,colinterest_SplitsInterp) == 1;
            Split75m = [timeSecToStr2(dataTablePacing(15,colinterest_Splits)) ' !'];
        else;
            Split75m = timeSecToStr2(dataTablePacing(15,colinterest_Splits));
        end;

        Split100m = timeSecToStr2(dataTablePacing(20,colinterest_Splits));
        
        if dataTablePacing(20,colinterest_SplitsInterp) == 1;
            Split125m = [timeSecToStr2(dataTablePacing(25,colinterest_Splits)) ' !'];
        else;
            Split125m = timeSecToStr2(dataTablePacing(25,colinterest_Splits));
        end;
        
        Split150m = timeSecToStr2(dataTablePacing(30,colinterest_Splits));
        
        if dataTablePacing(25,colinterest_SplitsInterp) == 1;
            Split175m = [timeSecToStr2(dataTablePacing(35,colinterest_Splits)) ' !'];
        else;
            Split175m = timeSecToStr2(dataTablePacing(35,colinterest_Splits));
        end;

        Split200m = timeSecToStr2(dataTablePacing(40,colinterest_Splits));
        
        if dataTablePacing(30,colinterest_SplitsInterp) == 1;
            Split225m = [timeSecToStr2(dataTablePacing(45,colinterest_Splits)) ' !'];
        else;
            Split225m = timeSecToStr2(dataTablePacing(45,colinterest_Splits));
        end;

        Split250m = timeSecToStr2(dataTablePacing(50,colinterest_Splits));

        if dataTablePacing(35,colinterest_SplitsInterp) == 1;
            Split275m = [timeSecToStr2(dataTablePacing(55,colinterest_Splits)) ' !'];
        else;
            Split275m = timeSecToStr2(dataTablePacing(55,colinterest_Splits));
        end;

        Split300m = timeSecToStr2(dataTablePacing(60,colinterest_Splits));

        if dataTablePacing(40,colinterest_SplitsInterp) == 1;
            Split325m = [timeSecToStr2(dataTablePacing(65,colinterest_Splits)) ' !'];
        else;
            Split325m = timeSecToStr2(dataTablePacing(65,colinterest_Splits));
        end;

        Split350m = [timeSecToStr2(dataTablePacing(70,colinterest_Splits)) '  '];

        if dataTablePacing(45,colinterest_SplitsInterp) == 1;
            Split375m = [timeSecToStr2(dataTablePacing(75,colinterest_Splits)) ' !'];
        else;
            Split375m = timeSecToStr2(dataTablePacing(75,colinterest_Splits));
        end;

        Split400m = timeSecToStr2(dataTablePacing(80,colinterest_Splits));

        if dataTablePacing(50,colinterest_SplitsInterp) == 1;
            Split425m = [timeSecToStr2(dataTablePacing(85,colinterest_Splits)) ' !'];
        else;
            Split425m = timeSecToStr2(dataTablePacing(85,colinterest_Splits));
        end;

        Split450m = timeSecToStr2(dataTablePacing(90,colinterest_Splits));

        if dataTablePacing(55,colinterest_SplitsInterp) == 1;
            Split475m = [timeSecToStr2(dataTablePacing(95,colinterest_Splits)) ' !'];
        else;
            Split475m = timeSecToStr2(dataTablePacing(95,colinterest_Splits));
        end;

        Split500m = timeSecToStr2(dataTablePacing(100,colinterest_Splits));

        if dataTablePacing(60,colinterest_SplitsInterp) == 1;
            Split525m = [timeSecToStr2(dataTablePacing(105,colinterest_Splits)) ' !'];
        else;
            Split525m = timeSecToStr2(dataTablePacing(105,colinterest_Splits));
        end;

        Split550m = timeSecToStr2(dataTablePacing(110,colinterest_Splits));

        if dataTablePacing(65,colinterest_SplitsInterp) == 1;
            Split575m = [timeSecToStr2(dataTablePacing(115,colinterest_Splits)) ' !'];
        else;
            Split575m = timeSecToStr2(dataTablePacing(115,colinterest_Splits));
        end;

        Split600m = timeSecToStr2(dataTablePacing(120,colinterest_Splits));

        if dataTablePacing(70,colinterest_SplitsInterp) == 1;
            Split625m = [timeSecToStr2(dataTablePacing(125,colinterest_Splits)) ' !'];
        else;
            Split625m = timeSecToStr2(dataTablePacing(125,colinterest_Splits));
        end;

        Split650m = [timeSecToStr2(dataTablePacing(130,colinterest_Splits)) '  '];

        if dataTablePacing(75,colinterest_SplitsInterp) == 1;
            Split675m = [timeSecToStr2(dataTablePacing(135,colinterest_Splits)) ' !'];
        else;
            Split675m = timeSecToStr2(dataTablePacing(135,colinterest_Splits));
        end;

        Split700m = timeSecToStr2(dataTablePacing(140,colinterest_Splits));

        if dataTablePacing(80,colinterest_SplitsInterp) == 1;
            Split725m = [timeSecToStr2(dataTablePacing(145,colinterest_Splits)) ' !'];
        else;
            Split725m = timeSecToStr2(dataTablePacing(145,colinterest_Splits));
        end;

        Split750m = timeSecToStr2(dataTablePacing(150,colinterest_Splits));

        if dataTablePacing(16,colinterest_SplitsInterp) == 1;
            Split775m = [timeSecToStr2(dataTablePacing(155,colinterest_Splits)) ' !'];
        else;
            Split775m = timeSecToStr2(dataTablePacing(155,colinterest_Splits));
        end;

        Split800m = timeSecToStr2(dataTablePacing(160,colinterest_Splits));

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
        SplitLap3_100 = timeSecToStr2(dataTablePacing(60,colinterest_Splits) - dataTablePacing(30,colinterest_Splits));
        SplitLap4_100 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(60,colinterest_Splits));
        SplitLap5_100 = timeSecToStr2(dataTablePacing(100,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap6_100 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(100,colinterest_Splits));
        SplitLap7_100 = timeSecToStr2(dataTablePacing(140,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
        SplitLap8_100 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(140,colinterest_Splits));
        
        SplitLap1_200 = timeSecToStr2(dataTablePacing(40,colinterest_Splits));
        SplitLap2_200 = timeSecToStr2(dataTablePacing(80,colinterest_Splits) - dataTablePacing(40,colinterest_Splits));
        SplitLap3_200 = timeSecToStr2(dataTablePacing(120,colinterest_Splits) - dataTablePacing(80,colinterest_Splits));
        SplitLap4_200 = timeSecToStr2(dataTablePacing(160,colinterest_Splits) - dataTablePacing(120,colinterest_Splits));
    
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

    
    LapDist = [50 100 150 200 250 300 350 400 ...
        450 500 550 600 650 700 750 800];
    KeyDist = [25 50 75 100 125 150 175 200 225 250 275 300 325 350 375 400 ...
        425 450 475 500 525 550 575 600 625 650 675 700 725 750 775 800];
    
    bestBlock = [bestBlock RT];
    RT = timeSecToStr2(RT);
    
    NbLap = RaceDist./Course;
    isInterpolatedTurn = [];
    bestTurnRace = [];
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        locTurnData = [32 40 48 56 64 72 80 88 96 104 112 120 128 136 144];
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
            %---800m take col = 12 for long interval splits
            BOTime_Turn = BOAll(lapEC+1,2) - dataTableAverage{(10*lapEC),12};
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

    %Breath 800m, long intervals take col=3
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
%         validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
%             85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
%         %800 so take col 7 for the speed
%         colinterest_Speed = 7;
%         colinterest_SpeedInterp = 8;
%         for iter = 1:length(validIndex);
%             valEC = dataTablePacing(validIndex(iter),colinterest_Speed);
%             if isempty(valEC) == 1 | isnan(valEC) == 1;
%                 ValEC = ' ';
%             else;
%                 VelLap = [VelLap valEC];
%             end;
%         end;
%         VelAverage = dataToStr(mean(VelLap),2);
        VelAverage = databaseCurrent{raceECmain-2,32};
        
    elseif strcmpi(answerReport, 'SP2') == 1;
%         %800m race so take col 4 for the speed
%         VelLap = [];
%         interpVel = 0;
%         validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
%             85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
%         for iter = 1:length(dataTableAverage(:,1));
%             valEC = dataTableAverage{iter,4};
%             if isempty(valEC) == 1 | isnan(valEC) == 1;
%                 ValEC = ' ';
%             else;
%                 VelLap = [VelLap valEC];
%             end;
%         end;
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
    
    txt = Split50m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-585, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split100m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-605, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split150m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-625, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split200m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-645, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split250m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-665, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split300m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-685, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split350m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-705, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split400m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-725, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split450m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-745, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split500m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-765, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split550m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-785, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split600m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-805, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split650m;
    txtCol2N_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size(4)-825, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size(4)-825, 1, 735], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = Split700m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos1, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split750m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos2, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = Split800m;
    txtCol2N_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos3, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2N_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    
    
    txtCol2o_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos4, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2o_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_50;
    txtCol2P_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos6, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2P_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos7, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos8, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos9, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap5_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos10, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap6_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos11, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap7_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos12, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap8_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos13, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap9_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos14, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap10_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos15, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap11_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos16, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap12_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos17, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap13_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos18, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap14_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos19, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap15_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos20, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap16_50;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos21, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    
    
    

    
    txtCol2r_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos22, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos24, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos25, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos26, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos27, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap5_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos28, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap6_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos29, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap7_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos30, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap8_100;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos31, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    
    
    
    txtCol2r_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos32, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap1_200;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos34, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap2_200;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos35, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap3_200;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos36, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = SplitLap4_200;
    txtCol2Q_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos37, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Q_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    
    
    txtCol2r_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos38, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(1));
    txtCol2S_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos40, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(2));
    txtCol2S_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos41, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(3));
    txtCol2S_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos42, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = num2str(Stroke_Count(4));
    txtCol2S_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size2(4)-pos43, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size2(4)-pos43, 1, pos43], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = num2str(Stroke_Count(5));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos44, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(6));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos45, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(7));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos46, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(8));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos47, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(9));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos48, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(10));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos49, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(11));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos50, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(12));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos51, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(13));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos52, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(14));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos53, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(15));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos54, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    txt = num2str(Stroke_Count(16));
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos55, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized'); 
    
    
    
    
    
    txtCol2r_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos56, shiftRight, 30], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol2r_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    storeDist = [];
    storeTime = [];

    txt = [' ' TurnTime1in TurnTime1out TurnTime1];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos58, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2a_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos59, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2a_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2a_pdfStore{raceECmain-2,1} = txtCol2S2a_pdf;

    txt = [' ' TurnTime2in TurnTime2out TurnTime2];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos60, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2b_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos61, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2b_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2b_pdfStore{raceECmain-2,1} = txtCol2S2b_pdf;

    txt = [' ' TurnTime3in TurnTime3out TurnTime3];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos62, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2c_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos63, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2c_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2c_pdfStore{raceECmain-2,1} = txtCol2S2c_pdf;

    txt = [' ' TurnTime4in TurnTime4out TurnTime4];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos64, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2d_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos65, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2d_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2d_pdfStore{raceECmain-2,1} = txtCol2S2d_pdf;

    txt = [' ' TurnTime5in TurnTime5out TurnTime5];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos66, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2e_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos67, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2e_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2e_pdfStore{raceECmain-2,1} = txtCol2S2e_pdf;

    txt = [' ' TurnTime6in TurnTime6out TurnTime6];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos68, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2f_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos69, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2f_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2f_pdfStore{raceECmain-2,1} = txtCol2S2f_pdf;

    txt = [' ' TurnTime7in TurnTime7out TurnTime7];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos70, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos71, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime8in TurnTime8out TurnTime8];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos72, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos73, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime9in TurnTime9out TurnTime9];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos74, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos75, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime10in TurnTime10out TurnTime10];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos76, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos77, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime11in TurnTime11out TurnTime11];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos78, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos79, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime12in TurnTime12out TurnTime12];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos80, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos81, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;
    
    txt = [' ' TurnTime13in TurnTime13out TurnTime13];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos82, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    

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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos83, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime14in TurnTime14out TurnTime14];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos84, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos85, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;

    txt = [' ' TurnTime15in TurnTime15out TurnTime15];
    txtCol2S_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos86, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2S_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
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
    txtCol2S2g_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos87, shiftRight, 20], 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'FontAngle', 'Italic', 'Fontsize', font4-1, 'String', txt);
    set(txtCol2S2g_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    txtCol2S2g_pdfStore{raceECmain-2,1} = txtCol2S2g_pdf;



    
    txtCol1t_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos88, shiftRight, 32], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0.87 0.93 0.93], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtCol1t_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR25m ' ' DPS25m ' ' Breath25m];
    txtCol2U_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size3(4)-pos90, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2U_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    if strcmpi(source, 'display') == 1;

    else;
        txtBlack_pdf = uicontrol('parent', figSource2, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size3(4)-pos90, 1, pos90], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    end;

    txt = ['  ' SR50m ' ' DPS50m ' ' Breath50m];
    txtCol2V_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos91, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2V_pdf, 'fontunits', 'normalized', 'units', 'normalized');

    txt = ['  ' SR75m ' ' DPS75m ' ' Breath75m];
    txtCol2W_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos92, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2W_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR100m ' ' DPS100m ' ' Breath100m];
    txtCol2X_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos93, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2X_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR125m ' ' DPS125m ' ' Breath125m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos94, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR150m ' ' DPS150m ' ' Breath150m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos95, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR175m ' ' DPS175m ' ' Breath175m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos96, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR200m ' ' DPS200m ' ' Breath200m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos97, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR225m ' ' DPS225m ' ' Breath225m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos98, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR250m ' ' DPS250m ' ' Breath250m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos99, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR275m ' ' DPS275m ' ' Breath275m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos100, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR300m ' ' DPS300m ' ' Breath300m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos101, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR325m ' ' DPS325m ' ' Breath325m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos102, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR350m ' ' DPS350m ' ' Breath350m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos103, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR375m ' ' DPS375m ' ' Breath375m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos104, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR400m ' ' DPS400m ' ' Breath400m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos105, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
   
    txt = ['  ' SR425m ' ' DPS425m ' ' Breath425m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos106, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR450m ' ' DPS450m ' ' Breath450m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos107, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR475m ' ' DPS475m ' ' Breath475m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos108, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR500m ' ' DPS500m ' ' Breath500m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos109, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR525m ' ' DPS525m ' ' Breath525m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos110, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR550m ' ' DPS550m ' ' Breath550m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos111, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR575m ' ' DPS575m ' ' Breath575m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos112, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR600m ' ' DPS600m ' ' Breath600m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos113, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR625m ' ' DPS625m ' ' Breath625m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos114, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR650m ' ' DPS650m ' ' Breath650m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos115, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR675m ' ' DPS675m ' ' Breath675m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos116, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR700m ' ' DPS700m ' ' Breath700m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos117, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR725m ' ' DPS725m ' ' Breath725m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos118, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR750m ' ' DPS750m ' ' Breath750m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos119, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR775m ' ' DPS775m ' ' Breath775m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos120, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    
    txt = ['  ' SR800m ' ' DPS800m ' ' Breath800m];
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos121, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');
        
   
    if length(BreathTot) == 3;
        txt = [' ' SRAverage ' ' DPSAverage ' ' BreathTot];
    else;
        txt = ['  ' SRAverage ' ' DPSAverage ' ' BreathTot];
    end;
    txtCol2Y_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [151+(shiftRight*(raceECmain-3)), panel_size4(4)-pos122, shiftRight, 20], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Bold', 'Fontsize', font4, 'String', txt);
    set(txtCol2Y_pdf, 'fontunits', 'normalized', 'units', 'normalized');


    if strcmpi(source, 'display') == 1;
        txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size(4)-pos122, 1, pos122-90], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
            'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
        set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
    else;
        txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
            'position', [150+(shiftRight*(raceECmain-2)), panel_size4(4)-pos122, 1, pos122], 'HorizontalAlignment', 'left', ...
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
    'position', [40, panel_size(4)-45, 600, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
    'FontWeight', 'Bold', 'Fontsize', font1, 'String', titletxt);
set(txtTitle_pdf, 'fontunits', 'normalized', 'units', 'normalized');

if strcmpi(source, 'display') == 1;
    txtBlack_pdf = uicontrol('parent', handles2.panelMain, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size(4)-pos122, window_size(3)-60, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
else;
    txtBlack_pdf = uicontrol('parent', figSource3, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [30, panel_size4(4)-pos122, window_size(3)-60, 1], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [0 0 0], 'FontName', 'Arial', ...
        'FontWeight', 'Normal', 'Fontsize', font4, 'String', '');
    set(txtBlack_pdf, 'fontunits', 'normalized', 'units', 'normalized');
end;

handles2.filename = filename;
handles2.hdef = hdef;
handles2.RaceDist = LapDist(end);
guidata(handles2.hdef, handles2);
