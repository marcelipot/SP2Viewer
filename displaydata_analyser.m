function [] = displaydata_analyser(varargin);


handles = guidata(gcf);


%---Remove tooltip
handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
drawnow;

if isempty(handles.filelistAdded) == 1;
    return;
end;



%-------------------------------load data----------------------------------
if isfield(handles, 'current_toggle') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        StatusEC = get(handles.AminationStatus_analyser, 'String');
        if strcmpi(StatusEC, 'Play');
            set(handles.AminationStatus_analyser, 'String', 'DisplayData');
            return;
        end;
    end;
end;

if ispc == 1
    MDIR = getenv('USERPROFILE');
elseif ismac == 1;
    MDIR = '/Applications/SP2Viewer';
end;
RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
RaceUID = [];
clear_figures;


% waitbar(0.01, hwait, ['Fetching data... 1%']);
origin = 'display';
delete_allaxes_analyser;


if ispc == 1;
    fontEC = 14;
elseif ismac == 1;
    fontEC = 16;
end;



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

window_size = floor([(resolution(1)-300)./2 (resolution(2)-100)./2 300 100]);
window_size(1) = window_size(1) + offsetLeft;
window_size(2) = window_size(2) + offsetBottom;
% resolution = get(0,'ScreenSize');
% resolution = resolution(1,3:4);
% pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
    'color', [0 0 0], 'units', 'pixels','position', window_size,'windowstyle','modal', ...
    'Name', 'Loading', 'NumberTitle', 'off');
h1 = uicontrol('parent', h, 'style', 'text', ...
    'string', 'Downloading your data ...', 'units', 'pixels', ...
    'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
    'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
    'FontWeight', 'Bold', 'Fontsize', fontEC);
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame = get(handle(h), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;
drawnow;


try;
    set(handles.boxpanel_analyser, 'Visible', 'off');
    clear handles.boxpanel;
end;
% try;
%     set(handles.legGraph, 'Visible', 'off');
%     delete(handles.legGraph)
% end;
handles.RacesDB = [];


fileSP2viewerDBpacing = [];
loadsuccess = [];
for raceEC = 1:nbRaces;
    fileEC = handles.filelistAdded{raceEC};
    proceed = 1;
    iter = 1;
    while proceed == 1;
        raceCHECK = handles.uidDB{iter,2};
        if strcmpi(fileEC, raceCHECK) == 1;
            RaceUID{raceEC} = handles.uidDB{iter,1};
            proceed = 0;
        else;
            iter = iter + 1;
        end;
    end;
    
    UID = handles.uidDB{iter,1};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    Meet = handles.uidDB{iter,8};
    Year = handles.uidDB{iter,9};
    loadTrialsAWS;
    if isempty(filenameDBoutTemp) == 0;
        fileSP2viewerDBpacing{raceEC} = filenameDBoutTemp;
    else;
        fileSP2viewerDBpacing{raceEC} = filenameDBoutDB;
    end;
end;

try;
    close(h);
end;

index = find(loadsuccess == 0);
if isempty(index) == 1;
    handles.fileSP2viewerDBpacing = fileSP2viewerDBpacing;
    
    
    %%%create the summary table
    set(handles.insVelToggle_analyser, 'Visible', 'off');
    set(handles.predVelToggle_analyser, 'Visible', 'off');
    set(handles.flucVelToggle_analyser, 'Visible', 'off');
    set(handles.panelgraph_pacing_analyser, 'Visible', 'off');
    set(handles.panelzoom_pacing_analyser, 'Visible', 'off');
    set(handles.panelgraph_skills1_analyser, 'Visible', 'off');
    set(handles.panelgraph_splits_analyser, 'Visible', 'off');
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
    set(handles.displaypanel_fluctuation_analyser, 'Visible', 'off');
    set(handles.displaypanel_distribution_analyser, 'Visible', 'off');
    handles.actionplay_analyser = 0;

    create_summarytableINI;

    handles.current_toggle = 'Data';
    handles.current_panel = 'Summary';
    
    
    % waitbar(1, hwait, ['Fetching data... 100%']);
    
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 1);
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    
    set(handles.SummaryData_Panel_analyser, 'Visible', 'on', 'Value', 1);
    set(handles.StrokeData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.PacingData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillsData_Panel_analyser, 'Visible', 'on', 'Value', 0);
    %%%
    
    handles.UpdateListGraphPacing = 1;
    handles.UpdateListGraphSkill = 1;
    handles.UpdateListGraphSkillOverlay = 1;
    handles.updatedfiles = 0;
    handles.nbRacesEC = nbRaces;
    handles.animationsplitsTimeEC = 1;

    handles.DistriRefVel_analyser = 2;
    handles.DistriLegSelect_analyser = 1;
    set(handles.dispOptionrefVelPOP_analyser, 'Value', 2);
%     if RaceDist == 50 | RaceDist == 100;
        handles.DistriZoneVel_analyser = 1;
        set(handles.dispOptionzoneVelPOP_analyser, 'Value', 1);
%     elseif RaceDist == 150 | RaceDist == 200 | RaceDist == 400;
%         handles.DistriZoneVel_analyser = 2;
%         set(handles.dispOptionzoneVelPOP_analyser, 'Value', 2);
%     else;
%         handles.DistriZoneVel_analyser = 3;
%         set(handles.dispOptionzoneVelPOP_analyser, 'Value', 3);
%     end;
    if RaceDist == 150;
        handles.DistriLegSelect_analyser = 1;
        handles.dispOptionlegSelectLIST_analyser = {'All';'Backstroke';'Breaststroke';'Freestyle'};
        set(handles.dispOptionlegSelectPOP_analyser, 'Value', 1, 'String', handles.dispOptionlegSelectLIST_analyser);
    else;
        if strcmpi(StrokeType, 'Medley');
            handles.dispOptionlegSelectLIST_analyser = {'All';'Butterfly';'Backstroke';'Breaststroke';'Freestyle'};
            set(handles.dispOptionlegSelectPOP_analyser, 'Value', 1, 'String', handles.dispOptionlegSelectLIST_analyser);
        else;
            handles.dispOptionlegSelectLIST_analyser = {'All'};
            set(handles.dispOptionlegSelectPOP_analyser, 'Value', 1, 'String', handles.dispOptionlegSelectLIST_analyser);
        end;
    end;
    handles.DistriOptionGraphLine_analyser = 1;
    set(handles.dispOptiongraphLinePOP_analyser, 'Value', 1);
    handles.DistriOptionRaceData_analyser = 1;
    set(handles.dispOptionRaceDataPOP_analyser, 'Value', 1);
    handles.DistriDispDistri_analyser = 1;
    set(handles.distriDispPOP_analyser, 'Value', 1);
end;
set(handles.Save_button_analyser, 'cdata', imresize(handles.icones.saveTab_offb, [40 40]))


guidata(handles.hf_w1_welcome, handles);
