if isempty(handles.filelistAdded) == 1;
    return;
end;

MDIR = getenv('USERPROFILE');
if isfield(handles, 'RacesDB') == 0;
    errorwindow = errordlg('Update data display', 'Error');
    if ispc == 1;
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
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

if strcmpi(origin, 'save') == 1;
    [filename, pathname] = uiputfile({'*.bmp', 'Image File'}, 'Save Graph As', handles.lastPath_analyser);
    if isempty(pathname) == 1;
        return;
    end;
    if pathname == 0;
        return;
    end;
    handles.lastPath_analyser = pathname;
end;


NbLapTOT = [];
for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    NbLapTOT = [NbLapTOT NbLap];
end;
NbLapTOT = sum(NbLapTOT) + nbRaces;
lapTOTEC = 1;


maxYaxeTOT = 0;
for race = 1:nbRaces;
    
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['SpeedDecaySprintRange = handles.RacesDB.' UID '.SpeedDecaySprintRange;']);
    eval(['SpeedDecaySemiRange = handles.RacesDB.' UID '.SpeedDecaySemiRange;']);
    eval(['SpeedDecayLongRange = handles.RacesDB.' UID '.SpeedDecayLongRange;']);
    eval(['SpeedDecaySprintMid = handles.RacesDB.' UID '.SpeedDecaySprintMid;']);
    eval(['SpeedDecaySemiMid = handles.RacesDB.' UID '.SpeedDecaySemiMid;']);
    eval(['SpeedDecayLongMid = handles.RacesDB.' UID '.SpeedDecayLongMid;']);
    eval(['SpeedDecayRef = handles.RacesDB.' UID '.SpeedDecayRef;']);

    zoneVelSprint = [-0.025 -0.05 -0.075 -0.1 -0.125 -0.15; ...
                0.025 0.05 0.075 0.1 0.125 0.15];
    zoneVelSemi = [-0.015 -0.03 -0.045 -0.06 -0.075 -0.09; ...
                0.015 0.03 0.045 0.05 0.075 0.09];
    zoneVelLong = [-0.01 -0.02 -0.03 -0.04 -0.05 -0.06; ...
                0.01 0.02 0.03 0.04 0.05 0.06];

    if handles.DistriZoneVel_analyser == 1;
        %Use Sprint zone
        if handles.DistriRefVel_analyser == 1;
            %Use mid-range for vel ref
            if strcmpi(lower(StrokeType), 'medley');
                %select the leg or all for IM races
                if handles.DistriLegSelect_analyser == 1;
                    %calculate totals to the entire race
                    refVel = mean(SpeedDecayRef);
                    SpeedDecay = mean(SpeedDecaySprintRange);
                else;
                    %select each leg individually
                    refVel = SpeedDecayRef(handles.DistriLegSelect_analyser-1, 1);
                    SpeedDecay = SpeedDecaySprintRange(handles.DistriLegSelect_analyser-1, :);
                end;
            else;
                refVel = SpeedDecayRef(1);
                SpeedDecay = SpeedDecaySprintRange;
            end;
            
        elseif handles.DistriRefVel_analyser == 2;
            %Use 50% time for vel ref
            if strcmpi(lower(StrokeType), 'medley');
                %select the leg or all for IM races
                if handles.DistriLegSelect_analyser == 1;
                    %calculate totals to the entire race
                    refVel = mean(SpeedDecayRef);
                    SpeedDecay = mean(SpeedDecaySprintMid);
                else;
                    %select each leg individually
                    refVel = SpeedDecayRef(handles.DistriLegSelect_analyser-1, 2);
                    SpeedDecay = SpeedDecaySprintMid(handles.DistriLegSelect_analyser-1, :);
                end;
            else;
                refVel = SpeedDecayRef(2);
                SpeedDecay = SpeedDecaySprintMid;
            end;
        end;
        zoneVel = zoneVelSprint;

    elseif handles.DistriZoneVel_analyser == 2;
        %Use Semi zone
        if handles.DistriRefVel_analyser == 1;
            %Use mid-range for vel ref
            if strcmpi(lower(StrokeType), 'medley');
                %select the leg or all for IM races
                if handles.DistriLegSelect_analyser == 1;
                    %calculate totals to the entire race
                    refVel = mean(SpeedDecayRef);
                    SpeedDecay = mean(SpeedDecaySemiRange);
                else;
                    %select each leg individually
                    refVel = SpeedDecayRef(handles.DistriLegSelect_analyser-1, 1);
                    SpeedDecay = SpeedDecaySemiRange(handles.DistriLegSelect_analyser-1, :);
                end;
            else;
                refVel = SpeedDecayRef(1);
                SpeedDecay = SpeedDecaySemiRange;
            end;

        elseif handles.DistriRefVel_analyser == 2;
            %Use 50% time for vel ref
            if strcmpi(lower(StrokeType), 'medley');
                %select the leg or all for IM races
                if handles.DistriLegSelect_analyser == 1;
                    %calculate totals to the entire race
                    refVel = mean(SpeedDecayRef);
                    SpeedDecay = mean(SpeedDecaySemiMid);
                else;
                    %select each leg individually
                    refVel = SpeedDecayRef(handles.DistriLegSelect_analyser-1, 2);
                    SpeedDecay = SpeedDecaySemiMid(handles.DistriLegSelect_analyser-1, :);
                end;
            else;
                refVel = SpeedDecayRef(2);
                SpeedDecay = SpeedDecaySemiMid;
            end;
        end;
        zoneVel = zoneVelSemi;

    elseif handles.DistriZoneVel_analyser == 3;
        %Use long zone
        if handles.DistriRefVel_analyser == 1;
            %Use mid-range for vel ref
            %Use mid-range for vel ref
            if strcmpi(lower(StrokeType), 'medley');
                %select the leg or all for IM races
                if handles.DistriLegSelect_analyser == 1;
                    %calculate totals to the entire race
                    refVel = mean(SpeedDecayRef);
                    SpeedDecay = mean(SpeedDecayLongRange);
                else;
                    %select each leg individually
                    refVel = SpeedDecayRef(handles.DistriLegSelect_analyser-1, 1);
                    SpeedDecay = SpeedDecayLongRange(handles.DistriLegSelect_analyser-1, :);
                end;
            else;
                refVel = SpeedDecayRef(1);
                SpeedDecay = SpeedDecayLongRange;
            end;

        elseif handles.DistriRefVel_analyser == 2;
            %Use 50% time for vel ref
            if strcmpi(lower(StrokeType), 'medley');
                %select the leg or all for IM races
                if handles.DistriLegSelect_analyser == 1;
                    %calculate totals to the entire race
                    refVel = mean(SpeedDecayRef);
                    SpeedDecay = mean(SpeedDecayLongMid);
                else;
                    %select each leg individually
                    refVel = SpeedDecayRef(handles.DistriLegSelect_analyser-1, 2);
                    SpeedDecay = SpeedDecayLongMid(handles.DistriLegSelect_analyser-1, :);
                end;
            else;
                refVel = SpeedDecayRef(2);
                SpeedDecay = SpeedDecayLongMid;
            end;
        end;
        zoneVel = zoneVelLong;
    end;

    SpeedDecaySort = [];
    SpeedDecaySort = [SpeedDecay(7) SpeedDecay(6) SpeedDecay(5) SpeedDecay(4) ...
        SpeedDecay(3) SpeedDecay(2) SpeedDecay(1) SpeedDecay(8) SpeedDecay(9) ...
        SpeedDecay(10) SpeedDecay(11) SpeedDecay(12) SpeedDecay(13) SpeedDecay(14)];

    SpeedDecayCorr = zeros(100,1);
    posIni = 1;
    sizeDataMax = 0;
    for val = 1:length(SpeedDecaySort);
        posEnd = floor(posIni + SpeedDecaySort(val).*100);
        SpeedDecayCorr(posIni:posEnd) = val;

        if sizeDataMax <= (posEnd-posIni+1);
            sizeDataMax = posEnd-posIni+1;
        end;

        posIni = posEnd + 1;
    end;
    index = find(SpeedDecayCorr == 0);
    SpeedDecayCorr(index) = SpeedDecayCorr(index-1);

    if maxYaxeTOT <= (max(max(SpeedDecaySort)).*100);
        maxYaxeTOT = (max(max(SpeedDecaySort)).*100);
    end;
    eval(['dataRace' num2str(race) '.SpeedDecayCorr = SpeedDecayCorr;']);
    eval(['dataRace' num2str(race) '.SpeedDecaySort = SpeedDecaySort;']);
    eval(['dataRace' num2str(race) '.SpeedDecay = SpeedDecay;']);
    eval(['dataRace' num2str(race) '.zoneVel = zoneVel;']);
    eval(['dataRace' num2str(race) '.refVel = refVel;']);
end;
ymaxVelAxe = roundn(maxYaxeTOT + 0.05*maxYaxeTOT, -2);

FigPos = [50 50 1280 720];
Fig = figure('position', FigPos, 'units', 'pixels', 'color', [0 0 0], 'Visible', 'on', ...
    'MenuBar', 'none', 'NumberTitle', 'off');
set(Fig, 'Name', 'FullScreen Display: Distribution Graph');

offsetLeftXTitle = 70./FigPos(3);
offsetBottomXTitle = 5./FigPos(4);
widthXTitle = 1130./FigPos(3);
heightXTitle = 20./FigPos(4);
offsetLeftColBar = 70./FigPos(3);
widthColBar = 1130./FigPos(3);
    
if nbRaces == 1;
%     posA1 = [300./FigPos(3), 60./FigPos(4), 950./FigPos(3), 600./FigPos(4)];
    posA1 = [0.07 0.07 0.85 0.80];

elseif nbRaces == 2;
%     posB1 = [300./FigPos(3), 410./FigPos(4), 950./FigPos(3), 270./FigPos(4)];
%     posB2 = [300./FigPos(3), 60./FigPos(4), 950./FigPos(3), 270./FigPos(4)];
    posB1 = [0.07 0.5 0.85 0.35];
    posB2 = [0.07 0.07 0.85 0.35];

elseif nbRaces == 3;
%     posC1 = [300./FigPos(3), 415./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
%     posC2 = [800./FigPos(3), 415./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
%     posC3 = [550./FigPos(3), 60./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
    posC1 = [0.04 0.5 0.45 0.35];
    posC2 = [0.53 0.5 0.45 0.35];
    posC3 = [0.32 0.07 0.45 0.35];

elseif nbRaces == 4;
%     posD1 = [280./FigPos(3), 415./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
%     posD2 = [800./FigPos(3), 415./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
%     posD3 = [280./FigPos(3), 60./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
%     posD4 = [800./FigPos(3), 60./FigPos(4), 450./FigPos(3), 260./FigPos(4)];
    posD1 = [0.04 0.5 0.45 0.35];
    posD2 = [0.53 0.5 0.45 0.35];
    posD3 = [0.04 0.07 0.45 0.35];
    posD4 = [0.53 0.07 0.45 0.35];

elseif nbRaces == 5;
%     posE1 = [270./FigPos(3), 415./FigPos(4), 295./FigPos(3),
%     260./FigPos(4)];
%     posE2 = [635./FigPos(3), 415./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posE3 = [980./FigPos(3), 415./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posE4 = [430./FigPos(3), 60./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posE5 = [810./FigPos(3), 60./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
    posE1 = [0.04 0.5 0.28 0.35];
    posE2 = [0.38 0.5 0.28 0.35];
    posE3 = [0.70 0.5 0.28 0.35];
    posE4 = [0.20 0.05 0.28 0.35];
    posE5 = [0.55 0.05 0.28 0.35];

elseif nbRaces == 6;
%     posF1 = [270./FigPos(3), 415./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posF2 = [635./FigPos(3), 415./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posF3 = [980./FigPos(3), 415./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posF4 = [270./FigPos(3), 60./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posF5 = [635./FigPos(3), 60./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
%     posF6 = [980./FigPos(3), 60./FigPos(4), 295./FigPos(3), 260./FigPos(4)];
    posF1 = [0.04 0.5 0.28 0.35];
    posF2 = [0.38 0.5 0.28 0.35];
    posF3 = [0.70 0.5 0.28 0.35];
    posF4 = [0.04 0.05 0.28 0.35];
    posF5 = [0.38 0.05 0.28 0.35];
    posF6 = [0.70 0.05 0.28 0.35];
    
elseif nbRaces == 7;
%     posG1 = [270./FigPos(3), 530./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posG2 = [635./FigPos(3), 530./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posG3 = [980./FigPos(3), 530./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posG4 = [270./FigPos(3), 290./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posG5 = [635./FigPos(3), 290./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posG6 = [980./FigPos(3), 290./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posG7 = [635./FigPos(3), 50./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
    posG1 = [0.04 0.65 0.28 0.2];
    posG2 = [0.38 0.65 0.28 0.2];
    posG3 = [0.70 0.65 0.28 0.2];
    posG4 = [0.04 0.35 0.28 0.2];
    posG5 = [0.38 0.35 0.28 0.2];
    posG6 = [0.70 0.35 0.28 0.2];
    posG7 = [0.38 0.05 0.28 0.2];

elseif nbRaces == 8;
%     posH1 = [270./FigPos(3), 530./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH2 = [635./FigPos(3), 530./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH3 = [980./FigPos(3), 530./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH4 = [270./FigPos(3), 290./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH5 = [635./FigPos(3), 290./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH6 = [980./FigPos(3), 290./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH7 = [430./FigPos(3), 50./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
%     posH8 = [810./FigPos(3), 50./FigPos(4), 295./FigPos(3), 160./FigPos(4)];
    posH1 = [0.04 0.65 0.28 0.2];
    posH2 = [0.38 0.65 0.28 0.2];
    posH3 = [0.70 0.65 0.28 0.2];
    posH4 = [0.04 0.35 0.28 0.2];
    posH5 = [0.38 0.35 0.28 0.2];
    posH6 = [0.70 0.35 0.28 0.2];
    posH7 = [0.25 0.05 0.28 0.2];
    posH8 = [0.60 0.05 0.28 0.2];
end;


for race = 1:nbRaces;
        
    %---Load data
    emptyIterStroke = [];
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['Gender = handles.RacesDB.' UID '.Gender;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);

    eval(['SpeedDecayCorr = dataRace' num2str(race) '.SpeedDecayCorr;']);
    eval(['SpeedDecaySort = dataRace' num2str(race) '.SpeedDecaySort;']);
    eval(['SpeedDecay = dataRace' num2str(race) '.SpeedDecay;']);
    eval(['zoneVel = dataRace' num2str(race) '.zoneVel;']);
    eval(['refVel = dataRace' num2str(race) '.refVel;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    %----


    %---Create axes and load their positions
    if nbRaces == 1;
        letter = 'A';
    elseif nbRaces == 2;
        letter = 'B';
    elseif nbRaces == 3;
        letter = 'C';
    elseif nbRaces == 4;
        letter = 'D';
    elseif nbRaces == 5;
        letter = 'E';
    elseif nbRaces == 6;
        letter = 'F';
    elseif nbRaces == 7;
        letter = 'G';
    elseif nbRaces == 8;
        letter = 'H';
    end;

    eval(['posEC = pos' letter num2str(race) ';']);
    axesdistriVelEC_analyser = axes('parent', Fig, 'units', 'normalized', ...
        'Position', posEC, 'Visible', 'on');

    hold on;
    %----

    %---Create main graph
    colorBar = [0.65 0 0; 1 0.25 0; 1 0.51 0; 1 0.81 0; 0.88 1 0; 0.06 1 0; 0.30 0.78 0.01; ...
        0.30 0.78 0.01;  0.06 1 0; 0.88 1 0; 1 0.81 0; 1 0.51 0; 1 0.25 0; 0.65 0 0];

    if handles.DistriOptionGraphLine_analyser == 1 | handles.DistriOptionGraphLine_analyser == 2;
        for val = 1:length(SpeedDecaySort);
            distEC = SpeedDecaySort(val).*100;
            bar(axesdistriVelEC_analyser, val, distEC, 'facecolor', colorBar(val,:), 'BarWidth', 1);
        end;
    end;

    if handles.DistriOptionGraphLine_analyser == 1 | handles.DistriOptionGraphLine_analyser == 3;
        h = histfit(axesdistriVelEC_analyser, SpeedDecayCorr, 14, 'normal');
        h(1).FaceColor = [1 1 1];
        h(1).EdgeColor = [1 1 1];
        h(1).FaceAlpha = 0;
        h(1).EdgeAlpha = 0;
        h(2).Color = [0 0 1];
        h(2).LineWidth = 4;
    end;

    if nbRaces == 1 | nbRaces == 2;
        fontEC1 = 12;
        fontEC2 = 10;
        fontEC3 = 8;
    elseif nbRaces == 3 | nbRaces == 4;
        fontEC1 = 11;
        fontEC2 = 9;
        fontEC3 = 7;
    elseif nbRaces == 5 | nbRaces == 6;
        fontEC1 = 11;
        fontEC2 = 9;
        fontEC3 = 7;
    elseif nbRaces == 7 | nbRaces == 8;
        fontEC1 = 11;
        fontEC2 = 9;
        fontEC3 = 7;
    end;

    dispText = {};
    line(axesdistriVelEC_analyser, [7.5 7.5], [(0.1*maxYaxeTOT) ymaxVelAxe], 'linestyle', ':', 'color', [1 0 0], 'linewidth', 3);
    dispText{1} = ['Reference Speed: ' num2str(roundn(mean(refVel),-2)) ' m/s'];
    text(axesdistriVelEC_analyser, 7.5, 0.01*maxYaxeTOT, dispText, 'VerticalAlignment', 'Bottom', ...
        'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC1, 'color', [1 0 0]);
    
    if strcmpi(lower(StrokeType), 'medley');
        %4 values (IM races)
        distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
    else;
        distriMain = SpeedDecay(1) + SpeedDecay(8);
    end;
    decayIndex = refVel.*distriMain;
    dispText{1} = ['Decay Index: ' num2str(roundn(decayIndex,-2))];
    text(axesdistriVelEC_analyser, 7.5, 0.06*maxYaxeTOT, dispText, 'VerticalAlignment', 'Bottom', ...
        'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC1, 'color', [1 0 0]);
    %----


    %---Race Data
    if handles.DistriOptionRaceData_analyser == 1;
        dispText = {};
        RaceTime = SplitsAll(end,2);
        dispText{1} = ['Race Time: ' timeSecToStr(RaceTime)];
        text(axesdistriVelEC_analyser, 0.5, maxYaxeTOT, dispText, 'VerticalAlignment', 'Top', ...
            'HorizontalAlignment', 'left', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC2, 'color', [1 1 1]);
    end;

    if handles.DistriOptionRaceData_analyser == 2;
        dispText = {};
        dispText{1} = ['Lap Times:'];
        for lapEC = 2:NbLap+1;
            LapTime = SplitsAll(lapEC,2) - SplitsAll(lapEC-1,2);
            dispText{lapEC} = ['L' num2str(lapEC-1) ': ' timeSecToStr(LapTime)];
        end;
        text(axesdistriVelEC_analyser, 1.5, maxYaxeTOT, dispText, 'VerticalAlignment', 'Top', ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC2, 'color', [1 1 1]);
    end;

    if handles.DistriOptionRaceData_analyser == 3;
        RaceTime = SplitsAll(end,2);
        dispText = {};
        dispText{1} = ['Race Time: ' timeSecToStr(RaceTime)];
        dispText{2} = [' '];
        dispText{3} = ['Lap Times:'];
        for lapEC = 2:NbLap+1;
            LapTime = SplitsAll(lapEC,2) - SplitsAll(lapEC-1,2);
            dispText{lapEC+2} = ['L' num2str(lapEC-1) ': ' timeSecToStr(LapTime) ' / ' timeSecToStr(SplitsAll(lapEC,2))];
        end;
        text(axesdistriVelEC_analyser, 1.5, maxYaxeTOT, dispText, 'VerticalAlignment', 'Top', ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC3, 'color', [1 1 1]);

    end;
    %----


    %---Distribution Display
    if handles.DistriDispDistri_analyser == 2 | handles.DistriDispDistri_analyser == 3;

        %calculate pairs of distribution
        maxPairDistri = 0;
        for zoneEC = 1:(length(SpeedDecaySort)/2);
            val1 = SpeedDecaySort(zoneEC)*100;
            val2 = SpeedDecaySort(length(SpeedDecaySort)-zoneEC+1)*100;

            if val1 == 0;
                val1 = 1000;
            end;
            if val2 == 0;
                val2 = 1000;
            end;

            if val1 == 1000 & val2 == 1000;

            else;
                ypos = min([val1 val2]) - (0.25*min([val1 val2]));
                if ypos > maxPairDistri;
                    maxPairDistri = ypos;
                end;
            end;
        end;

        val3 = 0;
        for zoneEC = 1:(length(SpeedDecaySort)/2);
            if zoneEC == 1;
                xpos1 = [7.5 8];
                xpos2 = [7.5 7];
            else;
                xpos1(2) = xpos1(2)+1;
                xpos2(2) = xpos2(2)-1;
            end;

            incY = maxPairDistri./7;
            ypos = maxPairDistri - ((zoneEC-1)*incY);
            val1 = SpeedDecaySort(xpos2(2)).*100;
            val2 = SpeedDecaySort(xpos1(2)).*100;

            if val1 == 0 & val2 == 0;

            else;
                val3 = val3+roundn(sum(val1+val2),-2);
                correctionVal = 0;

                if zoneEC == (length(SpeedDecaySort)/2);
                    if val3 ~= 100;
                        correctionVal = val3 - 100;
                        val3 = 100;
                    end;
                end;
    
                arrow([xpos1(1) ypos], [xpos1(2) ypos], 'linewidth', 2, 'EdgeColor','w','FaceColor','w','length',4, 'tipangle', 35);
                arrow([xpos2(1) ypos], [xpos2(2) ypos], 'linewidth', 2, 'EdgeColor','w','FaceColor','w','length',4, 'tipangle', 35);
    
                if ypos > val1;
                    line([xpos2(2) xpos2(2)], [val1 ypos], 'Color', [1 1 1], 'linestyle', ':');
                end;
                if ypos > val2;
                    line([xpos1(2) xpos1(2)], [val2 ypos], 'Color', [1 1 1], 'linestyle', ':');
                end;
        
                text(axesdistriVelEC_analyser, xpos1(1), ypos+(0.01*ypos), [num2str(val3) '%'], 'VerticalAlignment', 'Bottom', ...
                    'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC2, 'color', [1 1 1]);
            end;
        end;

        if handles.DistriDispDistri_analyser == 3;
            for zoneEC = 1:length(SpeedDecaySort);
                valEC = roundn(SpeedDecaySort(zoneEC).*100, -2);
                if valEC ~= 0;
                    if zoneEC == 1;
                        if SpeedDecaySort(end) ~= 0;
                            valEC = valEC - (correctionVal/2);
                        else;
                            valEC = valEC - correctionVal;
                        end;
                    end;
                    if zoneEC == length(SpeedDecaySort);
                        if SpeedDecaySort(1) ~= 0;
                            valEC = valEC - (correctionVal/2);
                        else;
                            valEC = valEC - correctionVal;
                        end;
                    end;
                    
                    text(axesdistriVelEC_analyser, zoneEC, 0, [num2str(valEC) '%'], 'VerticalAlignment', 'Bottom', ...
                        'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC2, 'color', [1 1 1]);
            
                end;
            end;
        end;
    end;
    %----


    %---Modify axes limits and labels
    xlim(axesdistriVelEC_analyser, [0 15]);
    xtickVAL = 1:14;
    
    xtickTXT{1} = ['< ' num2str(zoneVel(1,6))];
    xtickTXT{2} = [num2str(zoneVel(1,6))];
    xtickTXT{3} = [num2str(zoneVel(1,5))];
    xtickTXT{4} = [num2str(zoneVel(1,4))];
    xtickTXT{5} = [num2str(zoneVel(1,3))];
    xtickTXT{6} = [num2str(zoneVel(1,2))];
    xtickTXT{7} = [num2str(zoneVel(1,1))];
    xtickTXT{8} = [num2str(zoneVel(2,1))];
    xtickTXT{9} = [num2str(zoneVel(2,2))];
    xtickTXT{10} = [num2str(zoneVel(2,3))];
    xtickTXT{11} = [num2str(zoneVel(2,4))];
    xtickTXT{12} = [num2str(zoneVel(2,5))];
    xtickTXT{13} = [num2str(zoneVel(2,6))];
    xtickTXT{14} = ['> ' num2str(zoneVel(2,6))];
    
    ylim(axesdistriVelEC_analyser, [0 ymaxVelAxe]);

    if ymaxVelAxe <= 40;
        stepX = 5;
    elseif ymaxVelAxe > 40 & ymaxVelAxe <= 80;
        stepX = 10;
    elseif ymaxVelAxe > 80;
        stepX = 20;
    end;
    ytickVAL = 0:stepX:ymaxVelAxe;
    for valEC = 1:length(ytickVAL);
        ytickTXT{valEC} = [num2str(ytickVAL(valEC)) '%'];
    end;

    set(axesdistriVelEC_analyser, 'Visible', 'on', 'color', [0 0 0], ...
        'xcolor', [1 1 1], 'xtick', xtickVAL, 'xticklabel', xtickTXT, ...
        'ycolor', [1 1 1], 'ytick', ytickVAL, 'yticklabel', ytickTXT, 'fontsize', fontEC3);
    %----


    %---Create graph title
    if nbRaces <= 4;
        if strcmpi(detailRelay, 'None') == 1;
            if Source == 1;
                str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (SP1)'];
            elseif Source == 2;
                str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (SP2)'];
            elseif Source == 3;
                str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (GE)'];
            end;
        else;
            if Source == 1;
                str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP1)'];
            elseif Source == 2;
                str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP2)'];
            elseif Source == 3;
                str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (GE)'];
            end;
        end;
    else
        if strcmpi(detailRelay, 'None') == 1;
            if Source == 1;
                str = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage ' (SP1)']};
            elseif Source == 2;
                str = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage ' (SP2)']};
            elseif Source == 3;
                str = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage ' (GE)']};
            end;
        else;
            if Source == 1;
                str = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP1)']};
            elseif Source == 2;
                str = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP2)']};
            elseif Source == 3;
                str = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (GE)']};
            end;
            
        end;
    end;
    gtitdistriVelEC = title(axesdistriVelEC_analyser, str, ...
        'color', [1 1 1], 'Visible', 'on');

    hold off;
    %----


    %---Create main titles and legends
    %Create main axes titles
    axesXTitledistriVel = axes('parent', Fig, 'Position', [posEC(1), posEC(2)-0.05, posEC(3), 0.02], 'units', 'Normalized', ...
        'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
        'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
    xlim(axesXTitledistriVel, [0 1]);
    ylim(axesXTitledistriVel, [0 1]);
    XTitle = text(0.5, 0.5, 'Speed zone (m/s)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC3, 'color', [1 1 1], 'parent', axesXTitledistriVel, 'visible', 'on');
    set(axesXTitledistriVel, 'units', 'Normalized');
    
    if nbRaces <= 2;
        offsetX = 0.05;
    elseif nbRaces == 3 | nbRaces == 4;
        offsetX = 0.035;
    elseif nbRaces == 5 | nbRaces == 6;
        offsetX = 0.035;
    elseif nbRaces == 7 | nbRaces == 8;
        offsetX = 0.035;
    end;

    axesYTitledistriVel = axes('parent', Fig, 'Position', [posEC(1)-offsetX, posEC(2), 0.02, posEC(4)], 'units', 'Normalized', ...
        'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
        'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
    xlim(axesYTitledistriVel, [0 1]);
    ylim(axesYTitledistriVel, [0 1]);
    YTitle = text(0.5, 0.5, 'Distribution (% of freeswim time)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC3, 'color', [1 1 1], 'rotation', 90, 'parent', axesYTitledistriVel, 'visible', 'on');
    set(axesYTitledistriVel, 'units', 'Normalized');
    set(axesYTitledistriVel, 'visible', 'on');

    if race == 1;
        %create top legend
        topAxePos = get(axesdistriVelEC_analyser, 'position');
        leftPos = topAxePos(1)-0.03;
        bottomPos = (topAxePos(2)+topAxePos(4)) + 0.035;
        if nbRaces == 1 | nbRaces == 2;
            factorXLeg = 1;
            factorYLeg = 1;
        elseif nbRaces == 3 | nbRaces == 4;
            factorXLeg = 2;
            factorYLeg = 2;
        elseif nbRaces == 5 | nbRaces == 6;
            factorXLeg = 3;
            factorYLeg = 2;
        elseif nbRaces == 7 | nbRaces == 8;
            factorXLeg = 4;
            factorYLeg = 3;
        end;
        widthPos = (topAxePos(3)*factorXLeg) + 0.04;
        if nbRaces == 1 | nbRaces == 2;
            heightPos = 0.1;
        elseif nbRaces == 3 | nbRaces == 4;
            heightPos = 0.1;
        elseif nbRaces == 5;
            heightPos = 0.1;
        elseif nbRaces == 6;
            heightPos = 0.1;
        elseif nbRaces == 7;
            heightPos = 0.1;
        elseif nbRaces == 8;
            heightPos = 0.1;
        end;
        axesLegenddistriVel = axes('parent', Fig, 'Position', [leftPos bottomPos widthPos heightPos], 'units', 'Normalized', ...
            'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
            'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
        xlim(axesLegenddistriVel, [0 1]);
        ylim(axesLegenddistriVel, [0 1]);

        hold on;
        text(0, 0.5, 'Legend:', 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC2, 'color', [1 1 1], 'parent', axesLegenddistriVel, 'visible', 'on');

        rectangle(axesLegenddistriVel, 'Position', [0.1,0.1,0.01,0.7], 'FaceColor', [0.30 0.78 0.01], 'EdgeColor', [0.30 0.78 0.01], 'LineWidth', 1);
        text(0.12, 0.5, {'% of freeswim time';'spent in the speed zone'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegenddistriVel, 'visible', 'on');

        line(axesLegenddistriVel, [0.3 0.3], [0.1 0.8], 'Color', [0 0 1], 'Linestyle', '-', 'linewidth', 2);
        text(0.31, 0.5, {'Normal Distribution'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC3, 'color', [1 1 1], 'parent', axesLegenddistriVel, 'visible', 'on');

        line(axesLegenddistriVel, [0.47 0.47], [0.1 0.8], 'Color', [1 0 0], 'Linestyle', '--');
        text(0.48, 0.5, {'Reference speed'; '(mid-range speed'; 'or median speed)'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontEC3, 'color', [1 1 1], 'parent', axesLegenddistriVel, 'visible', 'on');

        hold off;
    end;
    %----
end;
set(Fig, 'units', 'normalized');


if strcmpi(origin, 'save') == 1;
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
        set(Fig, 'position', [posNorm(1) posNorm(2) 1 1]);
        
    else;
        set(Fig, 'units', 'Normalized');
    end;
    if ispc == 1;
        jFrame = get(handle(Fig), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    Fig.Visible = 'on';
    
end;

