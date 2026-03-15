if isempty(handles.filelistAdded) == 1;
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(handles, 'RacesDB') == 0;
    errorwindow = errordlg('Update data display', 'Error');
    if ispc == 1;
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    Fig.Visible = 'on';
    return;
end;

if handles.updatedfiles == 1;
    errorwindow = errordlg('Update data display', 'Error');
    if ispc == 1;
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    return;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ispc == 1;
    MDIR = getenv('USERPROFILE');
elseif ismac == 1;
    MDIR = '/Applications/SP2Viewer';
end;

RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
RaceUID = [];
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
end;

if strcmpi(origin, 'save');
    [filename, pathname] = uiputfile({'*.bmp', 'Image File'}, 'Save Graph As', handles.lastPath_analyser);
    if isempty(pathname) == 1;
        return;
    end;
    if pathname == 0;
        return;
    end;
    handles.lastPath_analyser = pathname;
end;
nbRaces = length(handles.filelistAdded);
if handles.CurrentvalueRace == 1;
    selectrace = 1:nbRaces;
else;
    selectrace = handles.CurrentvalueRace-1;
end;

for i = 1:length(selectrace);
    raceEC = selectrace(i);
    handles.TurnDisplaySelect(raceEC) = handles.CurrentvalueTurn;
end;
raceEC = [];

FigPos = [50 50 1280 720];
Fig = figure('position', FigPos, 'units', 'pixels', 'color', [0 0 0], 'Visible', 'off', ...
    'MenuBar', 'none', 'NumberTitle', 'off');
set(Fig, 'Name', 'FullScreen Display: Skill graph');

colorrow = [];
if handles.CurrentstatusOverlayYes == 1;
    if nbRaces == 1;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [340, 30, 600, 600], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 668 1280 52];
        elseif ismac == 1;
           posTable = [1 650 1280 70];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
    elseif nbRaces == 2;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [340, 20, 600, 600], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 651 1280 69];
        elseif ismac == 1;
            posTable = [1 632 1280 88];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
    elseif nbRaces == 3;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [340, 15, 600, 600], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 634 1280 86];
        elseif ismac == 1;
            posTable = [1 614 1280 106];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
    elseif nbRaces == 4;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [350, 15, 580, 580], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        posTable = [1 617 1280 103];
        if ispc == 1;
            posTable = [1 617 1280 103];
        elseif ismac == 1;
            posTable = [1 597 1280 120];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
    elseif nbRaces == 5;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [360, 15, 560, 560], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 600 1280 120];
        elseif ismac == 1;
            posTable = [1 582 1280 138];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
    elseif nbRaces == 6;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [365, 15, 550, 550], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 582 1280 138];
        elseif ismac == 1;
            posTable = [1 564 1280 156];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        colorrow(8,:) = [0.75 0.75 0.75];
    elseif nbRaces == 7;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [370, 5, 540, 540], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 565 1280 155];
        elseif ismac == 1;
            posTable = [1 548 1280 172];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        colorrow(8,:) = [0.75 0.75 0.75];
        colorrow(9,:) = [0.9 0.9 0.9];
    elseif nbRaces == 8;
        axesskillOverlay = axes('parent', Fig, 'units', 'pixels', 'Position', [375, 1, 530, 530], 'Visible', 'on');
        set(axesskillOverlay, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 549 1280 171];
        elseif ismac == 1;
            posTable = [1 530 1280 190];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        colorrow(8,:) = [0.75 0.75 0.75];
        colorrow(9,:) = [0.9 0.9 0.9];
        colorrow(10,:) = [0.75 0.75 0.75];
    end;
    fullscreenOffset = -0.4;
end;

if handles.CurrentstatusOverlayNo == 1;
    if nbRaces == 1;
        axesskillA1 = axes('parent', Fig, 'units', 'pixels', 'Position', [335, 20, 610, 610], 'Visible', 'on');
        set(axesskillA1, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 668 1280 52];
        elseif ismac == 1;
           posTable = [1 650 1280 70];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        fullscreenOffset = -0.5;
    elseif nbRaces == 2;
        axesskillB1 = axes('parent', Fig, 'units', 'pixels', 'Position', [10, 15, 600, 600], 'Visible', 'on');
        axesskillB2 = axes('parent', Fig, 'units', 'pixels', 'Position', [660, 15, 600, 600], 'Visible', 'on');
        set(axesskillB1, 'units', 'Normalized');
        set(axesskillB2, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 651 1280 69];
        elseif ismac == 1;
            posTable = [1 632 1280 88];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        fullscreenOffset = -0.5;
    elseif nbRaces == 3;
        axesskillC1 = axes('parent', Fig, 'units', 'pixels', 'Position', [10, 120, 420, 420], 'Visible', 'on');
        axesskillC2 = axes('parent', Fig, 'units', 'pixels', 'Position', [435, 120, 420, 420], 'Visible', 'on');
        axesskillC3 = axes('parent', Fig, 'units', 'pixels', 'Position', [860, 120, 420, 420], 'Visible', 'on');
        set(axesskillC1, 'units', 'Normalized');
        set(axesskillC2, 'units', 'Normalized');
        set(axesskillC3, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 634 1280 86];
        elseif ismac == 1;
            posTable = [1 614 1280 106];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        fullscreenOffset = -0.4;
    elseif nbRaces == 4;
        axesskillD1 = axes('parent', Fig, 'units', 'pixels', 'Position', [43, 15, 300, 300], 'Visible', 'on');
        axesskillD3 = axes('parent', Fig, 'units', 'pixels', 'Position', [625, 15, 300, 300], 'Visible', 'on');
        if ispc == 1;
            axesskillD2 = axes('parent', Fig, 'units', 'pixels', 'Position', [352, 295, 300, 300], 'Visible', 'on');
            axesskillD4 = axes('parent', Fig, 'units', 'pixels', 'Position', [940, 295, 300, 300], 'Visible', 'on');
        elseif ismac == 1;
            axesskillD2 = axes('parent', Fig, 'units', 'pixels', 'Position', [352, 285, 300, 300], 'Visible', 'on');
            axesskillD4 = axes('parent', Fig, 'units', 'pixels', 'Position', [940, 285, 300, 300], 'Visible', 'on');
        end;
        set(axesskillD1, 'units', 'Normalized');
        set(axesskillD2, 'units', 'Normalized');
        set(axesskillD3, 'units', 'Normalized');
        set(axesskillD4, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 617 1280 103];
        elseif ismac == 1;
            posTable = [1 597 1280 120];
        end;
        fontTable = 9;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        fullscreenOffset = -0.3;
    elseif nbRaces == 5;
        if ispc == 1;
            axesskillE1 = axes('parent', Fig, 'units', 'pixels', 'Position', [45, 290, 280, 280], 'Visible', 'on');
            axesskillE3 = axes('parent', Fig, 'units', 'pixels', 'Position', [505, 290, 280, 280], 'Visible', 'on');
            axesskillE5 = axes('parent', Fig, 'units', 'pixels', 'Position', [955, 290, 280, 280], 'Visible', 'on');
        elseif ismac == 1;
            axesskillE1 = axes('parent', Fig, 'units', 'pixels', 'Position', [45, 280, 280, 280], 'Visible', 'on');
            axesskillE3 = axes('parent', Fig, 'units', 'pixels', 'Position', [505, 280, 280, 280], 'Visible', 'on');
            axesskillE5 = axes('parent', Fig, 'units', 'pixels', 'Position', [955, 280, 280, 280], 'Visible', 'on');
        end;
        axesskillE2 = axes('parent', Fig, 'units', 'pixels', 'Position', [280, 15, 280, 280], 'Visible', 'on');
        axesskillE4 = axes('parent', Fig, 'units', 'pixels', 'Position', [720, 15, 280, 280], 'Visible', 'on');
        set(axesskillE1, 'units', 'Normalized');
        set(axesskillE2, 'units', 'Normalized');
        set(axesskillE3, 'units', 'Normalized');
        set(axesskillE4, 'units', 'Normalized');
        set(axesskillE5, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 600 1280 120];
        elseif ismac == 1;
            posTable = [1 582 1280 138];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        fullscreenOffset = -0.3;
    elseif nbRaces == 6;
        axesskillF1 = axes('parent', Fig, 'units', 'pixels', 'Position', [45, 15, 250, 250], 'Visible', 'on');
        axesskillF3 = axes('parent', Fig, 'units', 'pixels', 'Position', [425, 15, 250, 250], 'Visible', 'on');
        axesskillF5 = axes('parent', Fig, 'units', 'pixels', 'Position', [825, 15, 250, 250], 'Visible', 'on');
        if ispc == 1;
            axesskillF2 = axes('parent', Fig, 'units', 'pixels', 'Position', [195, 300, 250, 250], 'Visible', 'on');
            axesskillF4 = axes('parent', Fig, 'units', 'pixels', 'Position', [595, 300, 250, 250], 'Visible', 'on');
            axesskillF6 = axes('parent', Fig, 'units', 'pixels', 'Position', [995, 300, 250, 250], 'Visible', 'on');
        elseif ismac ==1;
            axesskillF2 = axes('parent', Fig, 'units', 'pixels', 'Position', [195, 290, 250, 250], 'Visible', 'on');
            axesskillF4 = axes('parent', Fig, 'units', 'pixels', 'Position', [595, 290, 250, 250], 'Visible', 'on');
            axesskillF6 = axes('parent', Fig, 'units', 'pixels', 'Position', [995, 290, 250, 250], 'Visible', 'on');
        end;
        set(axesskillF1, 'units', 'Normalized');
        set(axesskillF2, 'units', 'Normalized');
        set(axesskillF3, 'units', 'Normalized');
        set(axesskillF4, 'units', 'Normalized');
        set(axesskillF5, 'units', 'Normalized');
        set(axesskillF6, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 582 1280 138];
        elseif ismac == 1;
            posTable = [1 564 1280 156];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        colorrow(8,:) = [0.75 0.75 0.75];
        fullscreenOffset = -0.3;
    elseif nbRaces == 7;
        if ispc == 1;
            axesskillG1 = axes('parent', Fig, 'units', 'pixels', 'Position', [40, 300, 240, 240], 'Visible', 'on');
            axesskillG3 = axes('parent', Fig, 'units', 'pixels', 'Position', [360, 300, 240, 240], 'Visible', 'on');
            axesskillG5 = axes('parent', Fig, 'units', 'pixels', 'Position', [680, 300, 240, 240], 'Visible', 'on');
            axesskillG7 = axes('parent', Fig, 'units', 'pixels', 'Position', [1000, 300, 240, 240], 'Visible', 'on');
        elseif ismac == 1;
            axesskillG1 = axes('parent', Fig, 'units', 'pixels', 'Position', [40, 290, 240, 240], 'Visible', 'on');
            axesskillG3 = axes('parent', Fig, 'units', 'pixels', 'Position', [360, 290, 240, 240], 'Visible', 'on');
            axesskillG5 = axes('parent', Fig, 'units', 'pixels', 'Position', [680, 290, 240, 240], 'Visible', 'on');
            axesskillG7 = axes('parent', Fig, 'units', 'pixels', 'Position', [1000, 290, 240, 240], 'Visible', 'on');
        end;
        axesskillG2 = axes('parent', Fig, 'units', 'pixels', 'Position', [200, 15, 240, 240], 'Visible', 'on');
        axesskillG4 = axes('parent', Fig, 'units', 'pixels', 'Position', [520, 15, 240, 240], 'Visible', 'on');
        axesskillG6 = axes('parent', Fig, 'units', 'pixels', 'Position', [840, 15, 240, 240], 'Visible', 'on');
        set(axesskillG1, 'units', 'Normalized');
        set(axesskillG2, 'units', 'Normalized');
        set(axesskillG3, 'units', 'Normalized');
        set(axesskillG4, 'units', 'Normalized');
        set(axesskillG5, 'units', 'Normalized');
        set(axesskillG6, 'units', 'Normalized');
        set(axesskillG7, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 565 1280 155];
        elseif ismac == 1;
            posTable = [1 548 1280 172];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        colorrow(8,:) = [0.75 0.75 0.75];
        colorrow(9,:) = [0.9 0.9 0.9];
        fullscreenOffset = -0.3;
    elseif nbRaces == 8;
        if ispc == 1;
            axesskillH1 = axes('parent', Fig, 'units', 'pixels', 'Position', [40, 280, 240, 240], 'Visible', 'on');
            axesskillH3 = axes('parent', Fig, 'units', 'pixels', 'Position', [360, 280, 240, 240], 'Visible', 'on');
            axesskillH5 = axes('parent', Fig, 'units', 'pixels', 'Position', [680, 280, 240, 240], 'Visible', 'on');
            axesskillH7 = axes('parent', Fig, 'units', 'pixels', 'Position', [1000, 280, 240, 240], 'Visible', 'on');
        elseif ismac == 1;
            axesskillH1 = axes('parent', Fig, 'units', 'pixels', 'Position', [40, 270, 240, 240], 'Visible', 'on');
            axesskillH3 = axes('parent', Fig, 'units', 'pixels', 'Position', [360, 270, 240, 240], 'Visible', 'on');
            axesskillH5 = axes('parent', Fig, 'units', 'pixels', 'Position', [680, 270, 240, 240], 'Visible', 'on');
            axesskillH7 = axes('parent', Fig, 'units', 'pixels', 'Position', [1000, 270, 240, 240], 'Visible', 'on');
        end;
        axesskillH2 = axes('parent', Fig, 'units', 'pixels', 'Position', [40, 10, 240, 240], 'Visible', 'on');
        axesskillH4 = axes('parent', Fig, 'units', 'pixels', 'Position', [360, 10, 240, 240], 'Visible', 'on');
        axesskillH6 = axes('parent', Fig, 'units', 'pixels', 'Position', [680, 10, 240, 240], 'Visible', 'on');
        axesskillH8 = axes('parent', Fig, 'units', 'pixels', 'Position', [1000, 10, 240, 240], 'Visible', 'on');
        set(axesskillH1, 'units', 'Normalized');
        set(axesskillH2, 'units', 'Normalized');
        set(axesskillH3, 'units', 'Normalized');
        set(axesskillH4, 'units', 'Normalized');
        set(axesskillH5, 'units', 'Normalized');
        set(axesskillH6, 'units', 'Normalized');
        set(axesskillH7, 'units', 'Normalized');
        set(axesskillH8, 'units', 'Normalized');
        if ispc == 1;
            posTable = [1 549 1280 171];
        elseif ismac == 1;
            posTable = [1 530 1280 190];
        end;
        fontTable = 8;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [1 0.9 0.60];
        colorrow(3,:) = [0.9 0.9 0.9];
        colorrow(4,:) = [0.75 0.75 0.75];
        colorrow(5,:) = [0.9 0.9 0.9];
        colorrow(6,:) = [0.75 0.75 0.75];
        colorrow(7,:) = [0.9 0.9 0.9];
        colorrow(8,:) = [0.75 0.75 0.75];
        colorrow(9,:) = [0.9 0.9 0.9];
        colorrow(10,:) = [0.75 0.75 0.75];
        fullscreenOffset = -0.3;
    end;
end;    

storeTitle = [];
ScoreSpider = [];

dataSkills = {};
formatlist = 'char';
edittablelist = false;

if handles.CurrentstatusOverlayNo == 1;
    for race = 1:nbRaces;
        UID = RaceUID{race};
        li = findstr(UID, '-');
        UID(li) = '_';
        UID = ['A' UID 'A'];
        eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
        eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
        eval(['Year = handles.RacesDB.' UID '.Year;']);
        eval(['Meet = handles.RacesDB.' UID '.Meet;']);
        eval(['Stage = handles.RacesDB.' UID '.Stage;']);
        eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
        eval(['Gender = handles.RacesDB.' UID '.Gender;']);

        graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage];
        storeTitle{race} = graphTitle;
        
        idx = isstrprop(Meet,'upper');
        MeetShort = Meet(idx);
        if strcmpi(Stage, 'SemiFinal');
            StageShort = 'SF';
        elseif strcmpi(Stage, 'Semi-final');
            StageShort = 'SF';
        else;
            StageShort = Stage;
        end;
        YearShort = Year(3:4);
        graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '                                                               '];
        storeTitle2{race} = graphTitle2;
    end;
    
    for race = 1:nbRaces;
        try;
            if nbRaces == 1;
                Kletter = 'A';
            elseif nbRaces == 2;
                Kletter = 'B';
            elseif nbRaces == 3;
                Kletter = 'C';
            elseif nbRaces == 4;
                Kletter = 'D';
            elseif nbRaces == 5;
                Kletter = 'E';
            elseif nbRaces == 6;
                Kletter = 'F';
            elseif nbRaces == 7;
                Kletter = 'G';
            elseif nbRaces == 8;
                Kletter = 'H';
            end;
            eval(['axesEC = axesskill' Kletter num2str(race) ';']);
        end;
        
        UID = RaceUID{race};
        li = findstr(UID, '-');
        UID(li) = '_';
        UID = ['A' UID 'A'];
        eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
        eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
        eval(['Year = handles.RacesDB.' UID '.Year;']);
        eval(['Meet = handles.RacesDB.' UID '.Meet;']);
        eval(['Stage = handles.RacesDB.' UID '.Stage;']);
        eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
        eval(['Gender = handles.RacesDB.' UID '.Gender;']);
    
        graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage];
%         storeTitle{race} = graphTitle;

        if nbRaces >= 5;
            graphTitle = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage]};
        end;
% 
%         idx = isstrprop(Meet,'upper');
%         MeetShort = Meet(idx);
%         if strcmpi(Stage, 'SemiFinal');
%             StageShort = 'SF';
%         elseif strcmpi(Stage, 'Semi-final');
%             StageShort = 'SF';
%         else;
%             StageShort = Stage;
%         end;
%         YearShort = Year(3:4);
%         graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '                                                               '];
%         storeTitle2{race} = graphTitle2;
% 
%         if nbRaces >= 5;
%             graphTitle = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage]};
%         end;

        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
        eval(['RT = handles.RacesDB.' UID '.RT;']);
        eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
        eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTime;']);
        eval(['DiveT15 = handles.RacesDB.' UID '.DiveT15;']);
        eval(['ApproachEff = handles.RacesDB.' UID '.ApproachEff;']);
        ApproachEffTurn = ApproachEff(1:end-1);
        ApproachEffLast = ApproachEff(end);
        eval(['ApproachSpeed2CycleAll = handles.RacesDB.' UID '.ApproachSpeed2CycleAll;']);
        ApproachSpeed2CycleAllTurn = ApproachSpeed2CycleAll(1:end-1);
        ApproachSpeed2CycleLast = ApproachSpeed2CycleAll(end);
        eval(['ApproachSpeedLastCycleAll = handles.RacesDB.' UID '.ApproachSpeedLastCycleAll;']);
        ApproachSpeedLastCycleAllTurn = ApproachSpeedLastCycleAll(1:end-1);
        ApproachSpeedLastCycleLast = ApproachSpeedLastCycleAll(end);
        eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
        BOAllTime = BOAll(:,2);
        BOAllDistance = BOAll(:,3);
        eval(['BOEff = handles.RacesDB.' UID '.BOEff;']);
        eval(['BOEffCorr = handles.RacesDB.' UID '.BOEffCorr;']);
        BOEffStart = BOEff(1);
        BOEffTurn = BOEff(2:end);
        BOEffCorrStart = BOEffCorr(1);
        BOEffCorrTurn = BOEffCorr(2:end);
        eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
        eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
        eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
        eval(['TurnTime = handles.RacesDB.' UID '.Turn_Time;']);
        eval(['Course = handles.RacesDB.' UID '.Course;']);

        reference_spiderscore;
        calculate_spiderscore;
        
        if nbRaces == 1;
            fontsizetitle = 12;
            fontgraphaxe = 9;
            fontgraphlabel = 12;
            markersize = 8;
        elseif nbRaces == 2;
            fontsizetitle = 12;
            fontgraphaxe = 9;
            fontgraphlabel = 11;
            markersize = 8;
        elseif nbRaces == 3 | nbRaces == 4;
            fontsizetitle = 8;
            fontgraphaxe = 9;
            fontgraphlabel = 9;
            markersize = 7;
        elseif nbRaces == 5;
            fontsizetitle = 9;
            fontgraphaxe = 7;
            fontgraphlabel = 8;
            markersize = 6;
        elseif nbRaces == 6;
            fontsizetitle = 9;
            fontgraphaxe = 7;
            fontgraphlabel = 8;
            markersize = 5;
        else;
            fontsizetitle = 6;
            fontgraphaxe = 6;
            fontgraphlabel = 6;
            markersize = 4;
        end;
        
        try;
            toolbar = axtoolbar(axesEC, 'default');
            toolbar.Visible = 'on';
        end;
        
        dataEC = [];
        dataEC.StartRT = roundn(RT, -2);
        dataEC.StartKicks = KicksNb(1);
        dataEC.StartTime = roundn(DiveT15, -2);
        dataEC.StartBODist = roundn(BOAllDistance(1), -2);
        dataEC.StartBOEff = [roundn(VelBeforeBO(1),-2); roundn(VelAfterBO(1),-2)];
        dataEC.StartEntry = 0; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        dataEC.StartUWS = 0; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if NbLap == 1;
            DataToPlot = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                ScoreSpider.LastApp(race,1)];
            DataToTitle = [RT ScoreRaw.StartFlyDist(race,1) ScoreRaw.StartUWS(race,1) ScoreRaw.StartBO(race,1) ...
                ScoreRaw.LastApp(race,1)];
            
            DataToPlot(DataToPlot < 0) = 0;
            DataToPlot(DataToPlot > 10) = 10;
            LimSpider = [0 0 0 0 0; 10 10 10 10 10];
            axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills'; ...
                'Finish Skills'};
            dataEC.LastApp = [roundn(mean(ApproachSpeed2CycleLast),-2); roundn(mean(ApproachSpeedLastCycleLast),-2)];
                    
        else;
            if handles.CurrentvalueTurn == 1;
                %average value
                DataToPlot = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                    ScoreSpider.TurnApproachMean(race,1) ScoreSpider.TurnBOMean(race,1)];
                DataToTitle = [RT ScoreRaw.StartFlyDist(race,1) ScoreRaw.StartUWS(race,1) ScoreRaw.StartBO(race,1) ...
                    ScoreRaw.TurnApproachMean(race,1) ScoreRaw.TurnBOMean(race,1)];

                DataToPlot(DataToPlot < 0) = 0;
                DataToPlot(DataToPlot > 10) = 10;
                LimSpider = [0 0 0 0 0 0; 10 10 10 10 10 10];
                axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills'; ...
                    'Av. App. Skills'; 'Av. BO Skills'};

                dataEC.TurnTime = roundn(mean(TurnTime),-2);
                dataEC.TurnAppEff = [roundn(mean(ApproachSpeed2CycleAllTurn),-2); roundn(mean(ApproachSpeedLastCycleAllTurn),-2)];
                dataEC.TurnGlideWall = [roundn(mean(GlideLastStroke(3,1:end-1)),-2); roundn(mean(GlideLastStroke(4,1:end-1)),-2)];
                dataEC.TurnKicks = roundn(mean(KicksNb(2:end)),-1);
                BODist = BOAllDistance(2:end);
                BODistCorr = [];
                poolDist = Course:Course:RaceDist;
                for k = 1:length(BODist);
                    BODistCorr = [BODistCorr BODist(k)-poolDist(k)];
                end;
                dataEC.TurnBODist = roundn(mean(BODistCorr),-2);
                dataEC.TurnBOEff = [roundn(mean(VelBeforeBO),-2); roundn(mean(VelAfterBO),-2)];

            else;
                %A turn
                turnEC = handles.CurrentvalueTurn - 1;

                DataToPlot = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                    ScoreSpider.TurnApproach(race,turnEC) ScoreSpider.TurnBO(race,turnEC)];
                DataToTitle = [RT ScoreRaw.StartFlyDist(race,1) ScoreRaw.StartUWS(race,1) ScoreRaw.StartBO(race,1) ...
                    ScoreRaw.TurnApproach(race,turnEC) ScoreRaw.TurnBO(race,turnEC)];

                DataToPlot(DataToPlot < 0) = 0;
                DataToPlot(DataToPlot > 10) = 10;
                LimSpider = [0 0 0 0 0 0; 10 10 10 10 10 10];
                axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills'; ...
                    ['App. Skills Turn ' num2str(turnEC)]; ['BO Skills Turn ' num2str(turnEC)]};

                dataEC.TurnTime = roundn(TurnTime(turnEC),-2);
                dataEC.TurnAppEff = [roundn(ApproachSpeed2CycleAllTurn(turnEC),-2); roundn(ApproachSpeedLastCycleAllTurn(turnEC),-2)];
                dataEC.TurnGlideWall = [roundn(GlideLastStroke(3,turnEC),-2); roundn(GlideLastStroke(4,turnEC),-2)];
                dataEC.TurnKicks = roundn(KicksNb(turnEC+1),-1);
                BODist = BOAllDistance(turnEC+1);
                BODistCorr = BODist - (Course.*turnEC);
                dataEC.TurnBODist = roundn(BODistCorr,-2);
                dataEC.TurnBOEff = [roundn(VelBeforeBO(turnEC),-2); roundn(VelAfterBO(turnEC),-2)];

            end;
        end;
        Fig.CurrentAxes = axesEC; cla;
        if nbRaces > 4;
            axesinterval = 2;
        else;
            axesinterval = 5;
        end;
        spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', fullscreenOffset, 'Races', nbRaces, ...
            'axetoplot', axesEC, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
            'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0.5, ...
            'color', [0 0 1], 'AxesFontSize', fontgraphaxe, 'markersize', markersize, ...
            'LabelFontSize', fontgraphlabel);
        
        gtitleskill(race) = title(axesEC, graphTitle, 'color', [1 1 1], 'Visible', 'on', 'FontName', 'Antiqua', ...
            'FontSize', fontsizetitle, 'FontWeight', 'Bold');
        
        eval(['S' num2str(race) ' = dataEC;']);
    end;
end;



if handles.CurrentstatusOverlayYes == 1;
    storeTitle = [];
    ScoreSpider.TurnApproach = [];
    ScoreSpider.TurnBO = [];
    ScoreSpider = [];
    DiveRTtot = [];
    DiveFlyDisttot = [];
    DiveUWStot = [];
    DiveBOtot = [];
    LastApptot = [];
    TurnApptot = [];
    TurnBOtot = [];
    axesEC = axesskillOverlay;
    
    nbRaces = length(handles.filelistAdded);
    for race = 1:nbRaces;
        UID = RaceUID{race};
        li = findstr(UID, '-');
        UID(li) = '_';
        UID = ['A' UID 'A'];
        
        eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
        eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
        eval(['Year = handles.RacesDB.' UID '.Year;']);
        eval(['Meet = handles.RacesDB.' UID '.Meet;']);
        eval(['Stage = handles.RacesDB.' UID '.Stage;']);
        eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
        eval(['Gender = handles.RacesDB.' UID '.Gender;']);
        eval(['Course = handles.RacesDB.' UID '.Course;']);
        graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage];
        storeTitle{race} = graphTitle;
        
        idx = isstrprop(Meet,'upper');
        MeetShort = Meet(idx);
        if strcmpi(Stage, 'SemiFinal');
            StageShort = 'SF';
        elseif strcmpi(Stage, 'Semi-final');
            StageShort = 'SF';
        else;
            StageShort = Stage;
        end;
        YearShort = Year(3:4);
        graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '                                                               '];
        graphTitle3 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
        storeTitle2{race} = graphTitle2;
        storeTitle3{race} = graphTitle3;

        if nbRaces >= 5;
            graphTitle = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage]};
        end;
        
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
        eval(['RT = handles.RacesDB.' UID '.RT;']);
        eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
        eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTime;']);
        eval(['DiveT15 = handles.RacesDB.' UID '.DiveT15;']);
        eval(['ApproachEff = handles.RacesDB.' UID '.ApproachEff;']);
        ApproachEffTurn = ApproachEff(1:end-1);
        ApproachEffLast = ApproachEff(end);
        eval(['ApproachSpeed2CycleAll = handles.RacesDB.' UID '.ApproachSpeed2CycleAll;']);
        ApproachSpeed2CycleAllTurn = ApproachSpeed2CycleAll(1:end-1);
            ApproachSpeed2CycleLast = ApproachSpeed2CycleAll(end);
        eval(['ApproachSpeedLastCycleAll = handles.RacesDB.' UID '.ApproachSpeedLastCycleAll;']);
        ApproachSpeedLastCycleAllTurn = ApproachSpeedLastCycleAll(1:end-1);
        ApproachSpeedLastCycleLast = ApproachSpeedLastCycleAll(end);
        eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
        BOAllTime = BOAll(:,2);
        BOAllDistance = BOAll(:,3);
        eval(['BOEff = handles.RacesDB.' UID '.BOEff;']);
        BOEffStart = BOEff(1);
        BOEffTurn = BOEff(2:end);
        eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
        eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
        eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
        eval(['TurnTime = handles.RacesDB.' UID '.Turn_Time;']);
    
        dataEC.StartRT = roundn(RT, -2);
        dataEC.StartKicks = KicksNb(1);
        dataEC.StartTime = roundn(DiveT15, -2);
        dataEC.StartBODist = roundn(BOAllDistance(1), -2);
        dataEC.StartBOEff = [roundn(VelBeforeBO(1),-2); roundn(VelAfterBO(1),-2)];
        dataEC.StartEntry = 0; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        dataEC.StartUWS = 0; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if NbLap > 1;
            li = find(selectrace == race);
            if isempty(li) == 0;
                if handles.CurrentvalueTurn == 1;
                    dataEC.TurnTime = roundn(mean(TurnTime),-2);
                    dataEC.TurnAppEff = [roundn(mean(ApproachSpeed2CycleAllTurn),-2); roundn(mean(ApproachSpeedLastCycleAllTurn),-2)];
                    dataEC.TurnGlideWall = [roundn(mean(GlideLastStroke(3,1:end-1)),-2); roundn(mean(GlideLastStroke(4,1:end-1)),-2)];
                    dataEC.TurnKicks = roundn(mean(KicksNb(2:end)),-1);
                    BODist = BOAllDistance(2:end);
                    BODistCorr = [];
                    poolDist = Course:Course:RaceDist;
                    for k = 1:length(BODist);
                        BODistCorr = [BODistCorr BODist(k)-poolDist(k)];
                    end;
                    dataEC.TurnBODist = roundn(mean(BODistCorr),-2);
                    dataEC.TurnBOEff = [roundn(mean(VelBeforeBO),-2); roundn(mean(VelAfterBO),-2)];
                else;
                    turnEC = handles.CurrentvalueTurn - 1;
                    dataEC.TurnTime = roundn(TurnTime(turnEC),-2);
                    dataEC.TurnAppEff = [roundn(ApproachSpeed2CycleAllTurn(turnEC),-2); roundn(ApproachSpeedLastCycleAllTurn(turnEC),-2)];
                    dataEC.TurnGlideWall = [roundn(GlideLastStroke(3,turnEC),-2); roundn(GlideLastStroke(4,turnEC),-2)];
                    dataEC.TurnKicks = roundn(KicksNb(turnEC+1),-1);
                    BODist = BOAllDistance(turnEC+1);
                    BODistCorr = BODist - (Course.*turnEC);
                    dataEC.TurnBODist = roundn(BODistCorr,-2);
                    dataEC.TurnBOEff = [roundn(VelBeforeBO(turnEC),-2); roundn(VelAfterBO(turnEC),-2)]; 
                end;
            else;
                dataEC.TurnTime = roundn(mean(TurnTime),-2);
                dataEC.TurnAppEff = [roundn(mean(ApproachSpeed2CycleAllTurn),-2); roundn(mean(ApproachSpeedLastCycleAllTurn),-2)];
                dataEC.TurnGlideWall = [roundn(mean(GlideLastStroke(3,1:end-1)),-2); roundn(mean(GlideLastStroke(4,1:end-1)),-2)];
                dataEC.TurnKicks = roundn(mean(KicksNb(2:end)),-1);
                BODist = BOAllDistance(2:end);
                BODistCorr = [];
                poolDist = Course:Course:RaceDist;
                for k = 1:length(BODist);
                    BODistCorr = [BODistCorr BODist(k)-poolDist(k)];
                end;
                dataEC.TurnBODist = roundn(mean(BODistCorr),-2);
                dataEC.TurnBOEff = [roundn(mean(VelBeforeBO),-2); roundn(mean(VelAfterBO),-2)];
            end;
            
        end;
    
        reference_spiderscore;
        calculate_spiderscore;
    
        DiveRTtot(race,1) = RT;
        DiveFlyDisttot(race,1) = ScoreRaw.StartFlyDist(race,1);
        DiveUWStot(race,1) = ScoreRaw.StartUWS(race,1);
        DiveBOtot(race,1) = ScoreRaw.StartBO(race,1);
        if NbLap == 1;
            LastApptot(race,1) = ScoreRaw.LastApp(race,1);
        else;
            li = find(selectrace == race);
            if isempty(li) == 0;
                if handles.CurrentvalueTurn == 1;
                    TurnApptot(race,1) = ScoreRaw.TurnApproachMean(race,1);
                    TurnBOtot(race,1) = ScoreRaw.TurnBOMean(race,1);
                else;
                    turnEC = handles.CurrentvalueTurn - 1;
                    TurnApptot(race,1) = ScoreRaw.TurnApproach(race,turnEC);
                    TurnBOtot(race,1) = ScoreRaw.TurnBO(race,turnEC);
                end;
            else;
                TurnApptot(race,1) = ScoreRaw.TurnApproachMean(race,1);
                TurnBOtot(race,1) = ScoreRaw.TurnBOMean(race,1);
            end;
        end;
        
        eval(['S' num2str(race) ' = dataEC;']);
    end;
    
    fontsizetitle = 12;
    fontgraphaxe = 9;
    markersize = 8;
    colorsinput = [1 0 0; 0.4 0.9 0.5; 0.7 0.2 1; 0.1 0.8 1; ...
        0.8 0.8 0.1; 0.6 0.1 0.2; 0.4 0.5 0.1; 0.5 0.5 0.5];
    if nbRaces == 1;
        fontgraphlabel = 12;
    elseif nbRaces == 2;
        fontgraphlabel = 12;
    elseif nbRaces == 3 | nbRaces == 4;
        fontgraphlabel = 10;
    elseif nbRaces == 5 |nbRaces == 6;
        fontgraphlabel = 9;
    else;
        fontgraphlabel = 8;
    end;

    try;
        toolbar = axtoolbar(axesEC, 'default');
        toolbar.Visible = 'on';
    end;
    DataToPlot = [];
    
    if NbLap == 1;
        for race = 1:nbRaces;
            DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ScoreSpider.LastApp(race,1)];
            DataToPlot(DataToPlot < 0) = 0;
            DataToPlot(DataToPlot > 10) = 10;

            DataToPlot = [DataToPlot; DataToPlotEC];
        end;
        try;
            DataToTitle = [DiveRTtot(:,1) DiveFlyDisttot(:,1) DiveUWStot(:,1) DiveBOtot(:,1) LastApptot(:,1)];
        catch;
            DataToTitle = [DiveRTtot(2:end,1) DiveFlyDisttot(2:end,1) DiveUWStot(2:end,1) DiveBOtot(2:end,1) LastApptot(2:end,1)];            
        end;

        LimSpider = [0 0 0 0 0; 10 10 10 10 10];
        axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills'; 'Finish Skills'};

        if nbRaces > 4;
            axesinterval = 2;
        else;
            axesinterval = 5;
        end;
        spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', fullscreenOffset, 'Races', nbRaces, ...
            'axetoplot', axesEC, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
            'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0, ...
            'color', colorsinput(1:nbRaces,:), 'AxesFontSize', fontgraphaxe, 'markersize', markersize, ...
            'LabelFontSize', fontgraphlabel);

    elseif NbLap == 2;

        for race = 1:nbRaces;
            DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                ScoreSpider.TurnApproachBest(race,1) ScoreSpider.TurnBOBest(race,1)];
            DataToPlot(DataToPlot < 0) = 0;
            DataToPlot(DataToPlot > 10) = 10;

            DataToPlot = [DataToPlot; DataToPlotEC];
        end;
        DataToTitle = [DiveRTtot(:,1) DiveFlyDisttot(:,1) DiveUWStot(:,1) DiveBOtot(:,1) TurnApptot(:,1) TurnBOtot(:,1)];

        LimSpider = [0 0 0 0 0 0; 10 10 10 10 10 10];
        axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills'; 'App. Skills'; 'BO Skills'};

        if nbRaces > 4;
            axesinterval = 2;
        else;
            axesinterval = 5;
        end;
        spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', fullscreenOffset, 'Races', nbRaces, ...
            'axetoplot', axesEC, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
            'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0, ...
            'color', colorsinput(1:nbRaces,:), 'AxesFontSize', fontgraphaxe, 'markersize', markersize, ...
            'LabelFontSize', fontgraphlabel);

    else;

        for race = 1:nbRaces;
            liRace = find(selectrace == race);
            if isempty(liRace) == 0;
                if handles.CurrentvalueTurn == 1;
                    DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                        mean(ScoreSpider.TurnApproachMean(race,:)) mean(ScoreSpider.TurnBOMean(race,:))];
                else;
                    turnEC = handles.CurrentvalueTurn - 1;
                    DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                        ScoreSpider.TurnApproach(race,turnEC) ScoreSpider.TurnBO(race,turnEC)];
                end;
            else;
                if isfield(handles, 'DataToPlot_SkillOverlay') == 1;
                    TurnPrevApp = handles.DataToPlot_SkillOverlay(race,5);
                    TurnPrevBO = handles.DataToPlot_SkillOverlay(race,6);
                    DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                        TurnPrevApp TurnPrevBO];
                else;
                    DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                        mean(ScoreSpider.TurnApproachMean(race,:)) mean(ScoreSpider.TurnBOMean(race,:))];
                end;
            end;
            DataToPlotEC(DataToPlotEC < 0) = 0;
            DataToPlotEC(DataToPlotEC > 10) = 10;

            DataToPlot = [DataToPlot; DataToPlotEC];
        end;
        DataToTitle = [DiveRTtot(:,1) DiveFlyDisttot(:,1) DiveUWStot(:,1) DiveBOtot(:,1) TurnApptot(:,1) TurnBOtot(:,1)];

        LimSpider = [0 0 0 0 0 0; 10 10 10 10 10 10];
        axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills'; ...
            'App. Skills'; 'BO Skills'};

        if nbRaces > 4;
            axesinterval = 2;
        else;
            axesinterval = 5;
        end;
        spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', 0, 'Races', nbRaces, ...
            'axetoplot', axesEC, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
            'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0, ...
            'color', colorsinput(1:nbRaces,:), 'AxesFontSize', fontgraphaxe, 'markersize', markersize, ...
            'LabelFontSize', fontgraphlabel);
    end;
    
    gtitleskill = title(axesEC, 'Overlayed Comparison', 'color', [1 1 1], 'Visible', 'on', 'FontName', 'Antiqua', ...
        'FontSize', fontsizetitle, 'FontWeight', 'Bold');
    legGraph = legend(axesEC, storeTitle3, 'FontName', 'Antiqua', ...
        'FontAngle', 'italic', 'FontSize', 8, 'TextColor', [1 1 1]);
    set(legGraph, 'units', 'normalized');
    set(legGraph, 'position', [0.75 0.65 0.15 0.05]);    
end;


colWidth = {};
colWidth{1,1} = 200;
colWidth{1,2} = 60;
colWidth{1,3} = 60;
colWidth{1,4} = 60;
colWidth{1,5} = 90;
colWidth{1,6} = 100;
colWidth{1,7} = 60;
colWidth{1,8} = 110;
colWidth{1,9} = 60;
colWidth{1,10} = 100;
colWidth{1,11} = 130;
colWidth{1,12} = 60;
colWidth{1,13} = 80;
colWidth{1,14} = 95;
Data_table = uitable('parent', Fig, 'Visible', 'on', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', fontTable, ...
    'position', posTable, 'ColumnEditable', edittablelist, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');

dataSkills = [];
for race = 1:nbRaces;
    eval(['dataEC = S' num2str(race) ';']);
    dataSkills{race+2,1} = storeTitle2{race};
    txtEC = timeSecToStr(dataEC.StartTime);
    dataSkills{race+2,2} = txtEC(1:end-2);
    txtEC = dataToStr(dataEC.StartEntry,2);
    dataSkills{race+2,3} = txtEC;
    txtEC = timeSecToStr(dataEC.StartRT);
    dataSkills{race+2,4} = txtEC(1:end-2);
    txtEC = dataToStr(dataEC.StartBODist,1);
    dataSkills{race+2,5} = txtEC;
    txtEC = [dataToStr(dataEC.StartBOEff(1,1),2) ' / ' dataToStr(dataEC.StartBOEff(2,1),2)];
    dataSkills{race+2,6} = txtEC;
    txtEC = dataToStr(dataEC.StartKicks,0);
    dataSkills{race+2,7} = txtEC;
    txtEC = dataToStr(dataEC.StartUWS,2);
    dataSkills{race+2,8} = txtEC;
    
    if NbLap > 1;
        txtEC = timeSecToStr(dataEC.TurnTime(1));
        dataSkills{race+2,9} = txtEC(1:end-2);
        txtEC = [dataToStr(dataEC.TurnAppEff(1,1),2) ' / ' dataToStr(dataEC.TurnAppEff(2,1),2)];
        dataSkills{race+2,10} = txtEC;
        txtEC = [dataToStr(dataEC.TurnGlideWall(1,1)) ' / ' dataToStr(dataEC.TurnGlideWall(2,1))];
        dataSkills{race+2,11} = txtEC;
        txtEC = dataToStr(dataEC.TurnKicks(1),0);
        dataSkills{race+2,12} = txtEC;
        txtEC = dataToStr(dataEC.TurnBODist(1),1);
        dataSkills{race+2,13} = txtEC;
        txtEC = [dataToStr(dataEC.TurnBOEff(1,1),2) ' / ' dataToStr(dataEC.TurnBOEff(2,1),2)];
        dataSkills{race+2,14} = txtEC;
    end;
end;
dataSkills{1,6} = 'START';
dataSkills{1,11} = 'TURN';
dataSkills{2,2} = 'Time (s)';
dataSkills{2,3} = 'Entry (m)';
dataSkills{2,4} = 'Block (s)';
dataSkills{2,5} = 'BO Dist (m)';
dataSkills{2,6} = 'BO Skill (m/s)';
dataSkills{2,7} = 'Kicks';
dataSkills{2,8} = 'UW Skill (m/s)';
dataSkills{2,9} = 'Time (s)';
dataSkills{2,10} = 'App Skill (m/s)';
dataSkills{2,11} = 'Glide Wall (m & s)';
dataSkills{2,12} = 'Kicks';
dataSkills{2,13} = 'BO Dist (m)';
dataSkills{2,14} = 'BO Skill (m/s)';

set(Data_table, 'data', dataSkills, 'backgroundcolor', colorrow, 'ColumnWidth', colWidth);
set(Data_table, 'Units', 'normalized');
% s = uistyle('HorizontalAlignment','center');
% addStyle(Data_table, s, 'table', '');

% Fig.Visible = 'on';
if strcmpi(origin, 'save');
    Fig.Visible = 'off';
    Fig.InvertHardcopy = 'off';
    if ispc == 1;
        if isfile([pathname '\' filename]) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' pathname '\' filename];
            [status, cmdout] = system(command);
        end;
        saveas(Fig, [pathname '\' filename]);
    elseif ismac == 1;
        if isfile([pathname '/' filename]) == 1;
            command = ['rm -rf ' pathname '/' filename];
            [status, cmdout] = system(command);
        end;
        saveas(Fig, [pathname '/' filename]);
    end;
    clear_figures;
else;
    resolution = get(0,'ScreenSize');
    if length(resolution(:,1)) > 1;
        FigPos = [resolution(2,1) resolution(2,2) FigPos(3) FigPos(4)];
        set(Fig, 'position', FigPos);
            
        set(Fig, 'units', 'Normalized');
        posNorm = get(Fig, 'Position');
        set(Fig, 'position', [posNorm(1) posNorm(2) 1 1], 'SizeChangedFcn', {@resizefullscreenSkill, Data_table, fontTable});
        
    else;
        set(Fig, 'units', 'Normalized', 'SizeChangedFcn', {@resizefullscreenSkill, Data_table, fontTable});
    end;
    if ispc == 1;
        jFrame = get(handle(Fig), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    Fig.Visible = 'on';
end;
