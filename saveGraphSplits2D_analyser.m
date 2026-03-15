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


FigPos = [50 50 1280 720];
Fig = figure('position', FigPos, 'units', 'pixels', 'color', [0 0 0], 'Visible', 'off', ...
    'MenuBar', 'none', 'NumberTitle', 'off');
set(Fig, 'Name', 'FullScreen Display: Pacing color-graph');

GraphPos = [100./FigPos(3), 50./FigPos(4), 1180./FigPos(3), 620./FigPos(4)];
axessplits_analyser = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPos, 'Visible', 'on');
set(axessplits_analyser, 'units', 'Normalized');


dataMatCumSplitsPacing = handles.dataMatCumSplitsPacing;
dataMatSplitsPacing = handles.dataMatSplitsPacing;
dataMatCumSplitsPacingFullRace = handles.dataMatCumSplitsPacing;
dataMatSplitsPacingFullRace = handles.dataMatSplitsPacing;
dataMatSplitsPacingTRIMPerc = handles.dataMatSplitsPacingTRIMPerc;

RaceDist = str2num(handles.RaceDistList{1});
nbRaces = length(handles.filelistAdded);
Course = handles.CourseList{1};
NbLap = RaceDist./Course;

if isempty(handles.CurrentvalueDistSplitsPacing) == 1;
    if RaceDist <= 100;
        DistSplits = 5;
    elseif RaceDist > 100 & RaceDist <= 400;
        if Course == 25;
            DistSplits = 25;
        else;
            DistSplits = 10;
        end;
    elseif RaceDist > 400 & RaceDist <= 800;
        DistSplits = 25;
    elseif RaceDist > 800;
        DistSplits = 50;
    end;
else;
    if handles.CurrentvalueRaceLapPacing == 1;
        %full race
        if Course == 25;
            if RaceDist <= 100;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 5;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 50;
                end;
            elseif RaceDist > 100 & RaceDist <= 200;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                end;
            elseif RaceDist > 200 & RaceDist <= 800;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 5;
                    DistSplits = 400;
                end;
            elseif RaceDist > 800
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 500;
                end;
            end;
            
        else;
            if RaceDist <= 100;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 5;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 10;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 50;
                end;
            elseif RaceDist > 100 & RaceDist <= 200;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 10;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 5;
                    DistSplits = 200;
                end;
            elseif RaceDist > 200 & RaceDist <= 800;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 5;
                    DistSplits = 400;
                end;
            elseif RaceDist > 800
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 500;
                end;
            end;
        end;
    else;
        %Lap
        if Course == 25;
            if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 5;
            elseif handles.CurrentvalueDistSplitsPacing == 2;
                DistSplits = 25;
            end;
        else;
            if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 5;
            elseif handles.CurrentvalueDistSplitsPacing == 2;
                DistSplits = 10;
            elseif handles.CurrentvalueDistSplitsPacing == 3;
                DistSplits = 25;
            end;
        end;
    end;
end;


if handles.CurrentvalueRaceLapPacing == 1;
    DistIni = DistSplits;
    DistEnd = RaceDist;
else;
    DistIni = (str2num(Course).*(handles.CurrentvalueRaceLapPacing-2)) + DistSplits;
    DistEnd = str2num(Course).*(handles.CurrentvalueRaceLapPacing-1);
end;
keyDist = DistIni:DistSplits:DistEnd;
keyDistFullRace = DistSplits:DistSplits:RaceDist;

%trim splits matices
li = [];
dataMatSplitsPacingTRIM = [];
for split = 1:length(keyDist);
    li(split) = find(dataMatCumSplitsPacing(:,1) == keyDist(split));
end;
dataMatCumSplitsPacingTRIM = dataMatCumSplitsPacing(li,:);
dataMatSplitsPacingTRIM(:,1) = dataMatCumSplitsPacingTRIM(:,1);

li = [];
dataMatSplitsPacingTRIMFullRace = [];
for split = 1:length(keyDistFullRace);
    li(split) = find(dataMatCumSplitsPacingFullRace(:,1) == keyDistFullRace(split));
end;
dataMatCumSplitsPacingTRIMFullRace = dataMatCumSplitsPacingFullRace(li,:);
dataMatSplitsPacingTRIMFullRace(:,1) = dataMatCumSplitsPacingTRIMFullRace(:,1);

if handles.CurrentvalueRaceLapPacing == 1;
    for race = 1:nbRaces;
        dataMatSplitsPacingTRIM(:,race+1) = [dataMatCumSplitsPacingTRIM(1,race+1); diff(dataMatCumSplitsPacingTRIM(:,race+1))];
    end;
    for race = 1:nbRaces;
        dataMatSplitsPacingTRIMFullRace(:,race+1) = [dataMatCumSplitsPacingTRIMFullRace(1,race+1); diff(dataMatCumSplitsPacingTRIMFullRace(:,race+1))];
    end;
else;
	lapEC = handles.CurrentvalueRaceLapPacing-1;
    for race = 1:nbRaces;
        if lapEC == 1;
            LapTime = 0;
        else;
            UID = RaceUID{race};
            li = findstr(UID, '-');
            UID(li) = '_';
            UID = ['A' UID 'A'];
            
            eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
            SplitsAll = SplitsAll(2:end,:);
            LapTime = SplitsAll(lapEC-1,2);
        end;
        dataMatSplitsPacingTRIM(:,race+1) = [dataMatCumSplitsPacingTRIM(1,race+1)-LapTime; diff(dataMatCumSplitsPacingTRIM(:,race+1))];
        dataMatSplitsPacingTRIMFullRace(:,race+1) = [dataMatCumSplitsPacingTRIMFullRace(1,race+1); diff(dataMatCumSplitsPacingTRIMFullRace(:,race+1))];
    end;
end;


if RaceDist == 50;
    lineWidthWhite = 1.25;
    if handles.CurrentvalueRaceLapPacing == 1;
        if handles.CurrentvalueDistSplitsPacing == 1;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 2;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 3;
            FontSizeAxe = 0.025;
        end;
    else;
        FontSizeAxe = 0.025;
    end;
elseif RaceDist == 100;
    lineWidthWhite = 1.25;
    if handles.CurrentvalueRaceLapPacing == 1;
        if handles.CurrentvalueDistSplitsPacing == 1;
            FontSizeAxe = 0.02;
        elseif handles.CurrentvalueDistSplitsPacing == 2;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 3;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 4;
            FontSizeAxe = 0.025;
        end;
    else;
        FontSizeAxe = 0.025;
    end;
elseif RaceDist == 200;
    lineWidthWhite = 1;
    if handles.CurrentvalueRaceLapPacing == 1;
        if handles.CurrentvalueDistSplitsPacing == 1;
            FontSizeAxe = 0.018;
        elseif handles.CurrentvalueDistSplitsPacing == 2;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 3;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 4;
            FontSizeAxe = 0.025;
        end;
    else;
        FontSizeAxe = 0.025;
    end;
elseif RaceDist == 400;
    lineWidthWhite = 0.75;
    if handles.CurrentvalueRaceLapPacing == 1;
        if handles.CurrentvalueDistSplitsPacing == 1;
            FontSizeAxe = 0.02;
        elseif handles.CurrentvalueDistSplitsPacing == 2;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 3;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 4;
            FontSizeAxe = 0.025;
        end;
    else;
        FontSizeAxe = 0.025;
    end;
elseif RaceDist == 800;
    lineWidthWhite = 0.75;
    if handles.CurrentvalueRaceLapPacing == 1;
        if handles.CurrentvalueDistSplitsPacing == 1;
            FontSizeAxe = 0.0125;
        elseif handles.CurrentvalueDistSplitsPacing == 2;
            FontSizeAxe = 0.02;
        elseif handles.CurrentvalueDistSplitsPacing == 3;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 4;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 5;
            FontSizeAxe = 0.025;
        end;
    else;
        FontSizeAxe = 0.025;
    end;
elseif RaceDist == 1500;
    lineWidthWhite = 0.75;
    if handles.CurrentvalueRaceLapPacing == 1;
        if handles.CurrentvalueDistSplitsPacing == 1;
            FontSizeAxe = 0.0125;
        elseif handles.CurrentvalueDistSplitsPacing == 2;
            FontSizeAxe = 0.02;
        elseif handles.CurrentvalueDistSplitsPacing == 3;
            FontSizeAxe = 0.025;
        elseif handles.CurrentvalueDistSplitsPacing == 4;
            FontSizeAxe = 0.025;
        end;
    else;
        FontSizeAxe = 0.025;
    end;
end;

minY = 10000;
maxY = 0;

%find  min and max in Time/Perc
if handles.CurrentSplitsTimePacing == 1;
    for race = 1:nbRaces;
        linan = find(isnan(dataMatSplitsPacingTRIM(:,race+1)) == 1);
    %     linan = sort([linan; linan+1]);
        linanOpp = [];
        for lineMat = 1:length(dataMatSplitsPacingTRIM(:,1));
            li = find(linan == lineMat);
            if  isempty(li) == 1;
                linanOpp = [linanOpp; lineMat];
            end;
        end;
        minEC = min(dataMatSplitsPacingTRIM(linanOpp,race+1));

        if minEC < minY;
            minY = minEC;
        end;
        maxEC = max(dataMatSplitsPacingTRIM(linanOpp,race+1));
        if maxEC > maxY;
            maxY = maxEC;
        end;
    end;
end;
if handles.CurrentSplitsPercentagePacing == 1;
    for race = 1:nbRaces;
        linan = find(isnan(dataMatSplitsPacingTRIMPerc(:,race+1)) == 1);
    %     linan = sort([linan; linan+1]);
        linanOpp = [];
        for lineMat = 1:length(dataMatSplitsPacingTRIMPerc(:,1));
            li = find(linan == lineMat);
            if  isempty(li) == 1;
                linanOpp = [linanOpp; lineMat];
            end;
        end;
        minEC = min(dataMatSplitsPacingTRIMPerc(linanOpp,race+1));

        if minEC < minY;
            minY = minEC;
        end;
        maxEC = max(dataMatSplitsPacingTRIMPerc(linanOpp,race+1));
        if maxEC > maxY;
            maxY = maxEC;
        end;
    end;
end;

offset = 0.1.*(maxY - minY);
minY = minY-offset;
minYCorrected = minY-(3.*offset);
maxY = maxY+offset;
if minY < 0;
    maxY = maxY + minY;
    minY = 0;
end;
try
    toolbar = axtoolbar(axessplits_analyser, 'datacursor');
end;

if handles.CurrentSplitsTimePacing == 1;
    plot(axessplits_analyser, dataMatSplitsPacingTRIM(:,1), dataMatSplitsPacingTRIM(:,2:end), 'linewidth', 2);
end;
if handles.CurrentSplitsPercentagePacing == 1;
    plot(axessplits_analyser, dataMatSplitsPacingTRIMPerc(:,1), dataMatSplitsPacingTRIMPerc(:,2:end), 'linewidth', 2);
end;


rangeTime = maxY-minY;
if rangeTime <= 0.5;
    jump = 0.02;
elseif rangeTime > 0.5 & rangeTime <= 1;
    jump = 0.06;
elseif rangeTime > 1 & rangeTime <= 2.5;
    jump = 0.1;
elseif rangeTime > 2.5 & rangeTime <= 3;
    jump = 0.15;
elseif rangeTime > 3 & rangeTime <= 4;
    jump = 0.2;
elseif rangeTime > 4 & rangeTime <= 5;
    jump = 0.25;
elseif rangeTime > 5 & rangeTime <= 6;
    jump = 0.3;
elseif rangeTime > 6 & rangeTime <= 7;
    jump = 0.35;
elseif rangeTime > 7 & rangeTime <= 8;
    jump = 0.4;
elseif rangeTime > 8 & rangeTime <= 9;
    jump = 0.45;
elseif rangeTime > 9 & rangeTime <= 10;
    jump = 0.5;
elseif rangeTime > 10 & rangeTime <= 20;
    jump = 1;
else
    jump = 2;
end;
tickTime = roundn([minY:jump:maxY],-2);
tickColor = (tickTime-minY)/rangeTime;
tickTimeTXT = [];
for i = 1:length(tickTime);
    TXT = timeSecToStr(tickTime(i));
    tickTimeTXT{i} = TXT;
end;

for split = 1:length(dataMatSplitsPacingTRIM(:,1));
    posx = dataMatSplitsPacingTRIM(split,1);
    line(axessplits_analyser, [posx posx], [minY maxY], 'linewidth', lineWidthWhite, 'linestyle', '--', 'color', [0.8 0.8 0.8]);
end;

xticklabelValue = [];
% xticklabelValue{1} = [num2str(DistIni-DistSplits) '-' num2str(DistIni)];
for i = 1:length(dataMatSplitsPacingTRIM(:,1));
    if i == 1;
        xticklabelValue{i} = [num2str(DistIni-DistSplits) '-' num2str(dataMatSplitsPacingTRIM(i,1))];
    else;
        xticklabelValue{i} = [num2str(dataMatSplitsPacingTRIM(i-1,1)) '-' num2str(dataMatSplitsPacingTRIM(i,1))];
    end;
end;

ytickValue = minY:jump:maxY;
yticklabelValue = [];
for i = 1:length(ytickValue);
    val = roundn(ytickValue(i),-2);
    if handles.CurrentSplitsTimePacing == 1;
        TXT = timeSecToStr(val);
        if strcmpi(TXT(end), 's');
            yticklabelValue{i} = TXT(1:end-2);
        else;
            yticklabelValue{i} = TXT;
        end;
    end;
    if handles.CurrentSplitsPercentagePacing == 1;
        TXT = dataToStr(val,2);
        yticklabelValue{i} = TXT;
    end;
end;

if handles.CurrentvalueRaceLapPacing == 1;
    xlim(axessplits_analyser, [0 keyDist(end)+DistSplits]);
else;
    xlim(axessplits_analyser, [DistIni-DistSplits DistEnd+DistSplits]);
end;
ylim(axessplits_analyser, [minY maxY]);

offsetLeftXtitle = 60./FigPos(3);
offsetBottomXtitle = 5./FigPos(4);
widthXtitle = 1220./FigPos(3);
heightXtitle = 20./FigPos(4);

set(axessplits_analyser, 'Visible', 'on', 'color', [0 0 0], ...
    'xcolor', [1 1 1], 'xtick', dataMatSplitsPacingTRIM(:,1), 'xticklabel', xticklabelValue, ...
    'ycolor', [1 1 1], 'ytick', ytickValue, 'yticklabel', yticklabelValue);

axesXTitle = axes('parent', Fig, 'Position', [offsetLeftXtitle, offsetBottomXtitle, widthXtitle, heightXtitle], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesXTitle, [0 1]);
ylim(axesXTitle, [0 1]);
XTitle = text(0.5, 0.5, 'Distance (m)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'normalized', 'Fontsize', 0.667, ...
    'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
set(XTitle, 'units', 'Normalized');
axesXTitleSplits = axesXTitle;
set(XTitle, 'FontUnits', 'Points');
YFontSize = get(XTitle, 'FontSize');
set(XTitle, 'FontUnits', 'Normalized');

offsetLeftYtitle = 5./FigPos(3);
offsetBottomYtitle = 50./FigPos(4);
widthYtitle = 20./FigPos(3);
heightYtitle = 620./FigPos(4);
axesYTitle = axes('parent', Fig, 'Position', [offsetLeftYtitle, offsetBottomYtitle, widthYtitle, heightYtitle], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesYTitle, [0 1]);
ylim(axesYTitle, [0 1]);
if handles.CurrentSplitsTimePacing == 1;
    txtYtitle = 'Time';
end;
if handles.CurrentSplitsPercentagePacing == 1;
    txtYtitle = 'Percentage (of race time)';
end;
YTitle = text(0.5, 0.5, txtYtitle, 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', YFontSize, ...
    'color', [1 1 1], 'rotation', 90, 'parent', axesYTitle, 'visible', 'on');
set(axesYTitle, 'units', 'Normalized');
axesYTitleSplits = axesYTitle;

storeTitle = handles.storeTitle2;
maxsizetitle = 0;
for i = 1:length(storeTitle);
    titleEC = storeTitle{i};
    if length(titleEC) > maxsizetitle;
        maxsizetitle = length(titleEC);
    end;
end;
for i = 1:length(storeTitle);
    titleEC = storeTitle{i};

    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);
    if handles.CurrentvalueRaceLapPacing == 1;
       TXTsplitcum = timeSecToStr(roundn(SplitsAll(end,2),-2));
    else;
        if ischar(Course) == 1;
            Course = str2num(Course);
        end;
        if RaceDist/Course == length(SplitsAll(:,1));
            if lapEC == 1;
                TXTsplitcum = timeSecToStr(roundn(SplitsAll(lapEC,2),-2));
            else;
                TXTsplitcum = timeSecToStr(roundn(SplitsAll(lapEC,2)-SplitsAll(lapEC-1,2),-2));
            end;
        else;
            if lapEC == 1;
                TXTsplitcum = timeSecToStr(roundn(SplitsAll(lapEC+1,2),-2));
            else;
                TXTsplitcum = timeSecToStr(roundn(SplitsAll(lapEC+1,2)-SplitsAll(lapEC,2),-2));
            end;
        end;
    end;
    nbspace = maxsizetitle - length(titleEC) + 2;
    for j = 1:nbspace;
        titleEC = [titleEC ' '];
    end;
    storeTitle{i} = [titleEC TXTsplitcum];
end;
legGraph = legend(axessplits_analyser, storeTitle, 'FontName', 'Antiqua', ...
    'FontAngle', 'italic', 'FontSize', 10, 'TextColor', [1 1 1], 'Location', 'Best');
set(legGraph, 'units', 'normalized');

set(axessplits_analyser, 'fontunits', 'normalized', 'FontSize', FontSizeAxe);

if handles.CurrentvalueSplitsPacing == 1;
    toolbar.Visible = 'on';
end;

axesFigTitle = axes('parent', Fig, 'Position', [offsetLeftXtitle, 680./FigPos(4), widthXtitle, 30./FigPos(4);], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesFigTitle, [0 1]);
ylim(axesFigTitle, [0 1]);
FigTitle = text(0.5, 0.5, 'Pacing Strategy', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'normalized', 'Fontsize', 0.69, ...
    'color', [1 1 1], 'parent', axesFigTitle, 'visible', 'on');
set(FigTitle, 'units', 'Normalized');

Fig.Visible = 'on';
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
