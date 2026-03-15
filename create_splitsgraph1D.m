% set(handles.hf_w1_welcome, 'units', 'pixels');
% FigPos = get(handles.hf_w1_welcome, 'Position');
% set(handles.hf_w1_welcome, 'units', 'normalized');
FigPos = handles.FigPos;

if get(handles.splitsOff_check_analyser, 'Value') == 1;
    set(handles.splitsOff_check_analyser, 'Value', 0);
    set(handles.splitsPercentage_check_analyser, 'Value', 1);
    handles.CurrentSplitsPercentagePacing = 1;
    handles.CurrentSplitsOffPacing = 0;
    handles.CurrentSplitsTimePacing = 0;
end;

if RaceDist == 50 | RaceDist == 100;
    fontsizeAxe = 0.0252;
    fontsizeCol = 10;
elseif RaceDist == 150 | RaceDist == 200;
    fontsizeAxe = 0.0252;
    fontsizeCol = 10;
elseif RaceDist == 400;
    fontsizeAxe = 0.02;
    fontsizeCol = 10;
elseif RaceDist == 800;
    fontsizeAxe = 0.02;
    fontsizeCol = 7.5;
elseif RaceDist == 1500;
    fontsizeAxe = 0.02;
    fontsizeCol = 7.5;
end;

pos = [300./FigPos(3), 50./FigPos(4), 760./FigPos(3), 530./FigPos(4)];
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
maxY = maxY+offset;
if minY < 0;
    maxY = maxY + minY;
    minY = 0;
end;
handles.axessplits_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
    'Position', pos, 'Visible', 'off', 'fontunits', 'normalized');

dataMatSplitsPacingTRIM(end+1,1) = keyDist(end)+DistSplits;
dataMatSplitsPacingTRIM(end,2:end) = NaN;
dataMatSplitsPacingTRIMPerc(end+1,1) = keyDist(end)+DistSplits;
dataMatSplitsPacingTRIMPerc(end,2:end) = NaN;
keyDist(end+1) = keyDist(end)+DistSplits;

if handles.CurrentSplitsTimePacing == 1;
    DataToPlot = [];
    Ypos = [];
    raceEC = 1;
    for race = 1:nbRaces;
        Ypos = [Ypos; raceEC; raceEC+1];
        raceEC = raceEC + 1.25;
        DataToPlot = [DataToPlot; dataMatSplitsPacingTRIM(:,race+1)'; zeros(1,length(keyDist)).*NaN];
    end;
end;
if handles.CurrentSplitsPercentagePacing == 1;
    DataToPlot = [];
    Ypos = [];
    raceEC = 1;
    for race = 1:nbRaces;
        Ypos = [Ypos; raceEC; raceEC+1];
        raceEC = raceEC + 1.25;
        DataToPlot = [DataToPlot; dataMatSplitsPacingTRIMPerc(:,race+1)'; zeros(1,length(keyDist)).*NaN];
    end;
end;

% graph_splits1D = pcolor(handles.axessplits_analyser, keyDist, Ypos, DataToPlot);   ùùùùùùùùùùùùùùùù
graph_splits1D = pcolor(handles.axessplits_analyser, keyDist, Ypos, -DataToPlot);
% c = parula;
% c = flipud(c);
% colormap(handles.hf_w1_welcome, c);
colormap(handles.hf_w1_welcome, 'parula');
% caxis([minY maxY]);  ùùùùùùùùùùùùùùùùùùùùùùùùù
caxis([-maxY -minY]);

%---Colorbar
offsetLeftXtitle = 210./FigPos(3);
offsetBottomXtitle = 5./FigPos(4);
widthColBar = 835./FigPos(3);
heightColBar = 40./FigPos(4);
widthXtitle = 855./FigPos(3);
offsetBottomColBar = 585./FigPos(4);
offsetLeftColBar = 225./FigPos(3);
heightXtitle = 20./FigPos(4);
posaxecolbar = [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.07];
poscolbar = [offsetLeftColBar, offsetBottomColBar, widthColBar, heightColBar];

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
if handles.CurrentSplitsTimePacing == 1;
    for i = 0:length(tickTime)-1;
        TXT = timeSecToStr(abs(tickTime(end-i)));
        tickTimeTXT{i+1} = TXT;
    end;
    titleColorBar = 'Time';
end;
if handles.CurrentSplitsPercentagePacing == 1;
    for i = 0:length(tickTime)-1;
        TXT = dataToStr(abs(tickTime(end-i)),2);
        tickTimeTXT{i+1} = [TXT ' %'];
    end;
    titleColorBar = 'Percentage';
end;
axescolbar = axes('parent', handles.hf_w1_welcome, 'Position', posaxecolbar, 'units', 'Normalized', ...
        'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
        'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizeCol);
colbar = colorbar(axescolbar, 'location', 'northoutside', 'Ticks', tickColor,...
         'TickLabels',tickTimeTXT, 'color', [1 1 1], 'visible', 'on');
colbar.Label.String = titleColorBar;
colbar.Label.FontUnits = 'normalized';
colbar.Label.FontSize = 2.6667;
colbar.Label.FontWeight = 'bold';
colbar.Label.FontName = 'Antiqua';
colbar.Limits = [0 1];
handles.axescolbarSplits = axescolbar;
handles.colbarSplits = colbar;
handles.axescolbar_Splits = axescolbar;
handles.colbar_Splits = colbar;

for split = 1:length(dataMatSplitsPacingTRIM(:,1));
    posx = dataMatSplitsPacingTRIM(split,1);
    line(handles.axessplits_analyser, [posx posx], [Ypos(1) Ypos(end)], 'linewidth', 1, 'linestyle', '--', 'color', [0.8 0.8 0.8]);
end;

lapDist = 0:Course:RaceDist;
for i = 1:length(lapDist);
    posx = lapDist(i) + DistSplits;
    line(handles.axessplits_analyser, [posx posx], [Ypos(1) Ypos(end)], 'linewidth', 2, 'color', [1 0 0]);
end;


xticklabelValue = [];
for i = 1:length(keyDist);
    xticklabelValue{i} = num2str(keyDist(i)-DistSplits);
end;
xlim(handles.axessplits_analyser, [keyDist(1)-2 keyDist(end)+2]);
ylim(handles.axessplits_analyser, [Ypos(1) Ypos(end)]);

for race = 1:nbRaces;
    posx = keyDist(1);
    if handles.CurrentvalueRaceLapPacing == 1;
    %all race
        if RaceDist == 50;
            if DistSplits == 5;
                offsetx = 0.9.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 10;
                offsetx = 2.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 5.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 10.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 100;
            if DistSplits == 5;
                offsetx = 0.9.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 10;
                offsetx = 1.7*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 4.5.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 9.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 150;
            if DistSplits == 10;
                offsetx = 1.7.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 4.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 8.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 16.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 32.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 200;
            if DistSplits == 10;
                offsetx = 1.7.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 4.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 8.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 16.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 32.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 400;
            if DistSplits == 10;
                offsetx = 1.6.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 4.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 8.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 16.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 32.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 800;
            if DistSplits == 25;
                offsetx = 4.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 8.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 16.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 32.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 400;
                offsetx = 64.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 1500;
            if DistSplits == 50;
                offsetx = 8.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 16.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 32.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 500;
                offsetx = 80.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        end;
    else;
    %only 1 lap
        if DistSplits == 5;
            offsetx = 0.9.*((keyDist(end)-keyDist(1))./DistSplits);
        elseif DistSplits == 10;
            offsetx = 2.*((keyDist(end)-keyDist(1))./DistSplits);
        elseif DistSplits == 25;
            offsetx = 5.*((keyDist(end)-keyDist(1))./DistSplits);
        end;
    end;
    storeTitleBis = handles.storeTitleBis;
    posy = Ypos((race*2)-1) + ((Ypos((race*2)) - Ypos((race*2)-1))./2);

    racetitleEC{race} = text(posx-offsetx, posy, storeTitleBis{race}, 'horizontalalignment', 'Left', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'Normalized', 'Fontsize', 0.0252, 'color', [1 1 1], 'parent', handles.axessplits_analyser, 'visible', 'on');
    set(racetitleEC{race}, 'units', 'Normalized');
end;
set(handles.axessplits_analyser, 'Visible', 'on', 'color', [0 0 0], ...
    'xcolor', [1 1 1], 'xtick', keyDist, 'xticklabel', xticklabelValue, ...
    'ytick', [], 'yticklabel', [], 'FontUnits', 'Normalized', 'fontsize', fontsizeAxe);

axesXTitle = axes('parent', handles.hf_w1_welcome, 'Position', [offsetLeftXtitle, offsetBottomXtitle, widthXtitle, heightXtitle], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesXTitle, [0 1]);
ylim(axesXTitle, [0 1]);
XTitle = text(0.5, 0.5, 'Distance (m)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'normalized', 'Fontsize', 0.667, ...
    'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
set(XTitle, 'units', 'Normalized');
handles.axesXTitleSplits = axesXTitle;

iter = 1;
for race = 1:nbRaces;
    posy = Ypos((race*2)-1) + ((Ypos((race*2)) - Ypos((race*2)-1))./2);
    for i = 1:length(dataMatSplitsPacingTRIM(:,1));
        if isnan(dataMatSplitsPacingTRIM(i,race+1)) ~= 1;
            posx = dataMatSplitsPacingTRIM(i,1) + ((dataMatSplitsPacingTRIM(i+1,1) - dataMatSplitsPacingTRIM(i,1))./2);
            TXTsplit = timeSecToStr(roundn(dataMatSplitsPacingTRIM(i,race+1),-2));
            TXTsplitcum = timeSecToStr(roundn(dataMatCumSplitsPacingTRIM(i,race+1),-2));
            if nbRaces <= 4;
                TXT = [TXTsplit ' / ' TXTsplitcum];
            else;
                TXT = {TXTsplit; TXTsplitcum};
            end;

            lilap = find(lapDist == (posx-DistSplits));
            if isempty(lilap) == 1;
                DispSplits(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Middle', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', handles.axessplits_analyser, 'visible', 'off');
            else;
                DispSplits(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Bottom', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', handles.axessplits_analyser, 'visible', 'off');
            end;
            set(DispSplits, 'FontUnits', 'normalized');
            iter = iter + 1;
        end;
    end;
end;

iter = 1;
for race = 1:nbRaces;
    posy = Ypos((race*2)-1) + ((Ypos((race*2)) - Ypos((race*2)-1))./2);
    for i = 1:length(dataMatSplitsPacingTRIMPerc(:,1));
        if isnan(dataMatSplitsPacingTRIMPerc(i,race+1)) ~= 1;
            posx = dataMatSplitsPacingTRIMPerc(i,1) + ((dataMatSplitsPacingTRIMPerc(i+1,1) - dataMatSplitsPacingTRIMPerc(i,1))./2);
            TXTsplit = dataToStr(dataMatSplitsPacingTRIMPerc(i,race+1),2);
            TXTsplitcum = dataToStr(dataMatCumSplitsPacingTRIMPerc(i,race+1),2);
            if strcmpi(TXTsplitcum, '10000');
                TXTsplitcum = '100';
            end;
            if nbRaces <= 4;
                TXT = [TXTsplit ' % / ' TXTsplitcum ' %'];
            else;
                TXT = {[TXTsplit ' %']; [TXTsplitcum ' %']};
            end;

            lilap = find(lapDist == (posx-DistSplits));
            if isempty(lilap) == 1;
                DispSplitsPerc(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Middle', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', handles.axessplits_analyser, 'visible', 'off');
            else;
                DispSplitsPerc(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Bottom', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', handles.axessplits_analyser, 'visible', 'off');
            end;
            set(DispSplitsPerc, 'FontUnits', 'normalized');
            iter = iter + 1;
        end;
    end;
end;

if handles.CurrentvalueSplitsPacing == 1;
    if get(handles.splitsPercentage_check_analyser, 'Value') == 1;
        set(DispSplitsPerc, 'Visible', 'on');
    end;
    if get(handles.splitsTime_check_analyser, 'Value') == 1;
        set(DispSplits, 'Visible', 'on');
    end;
end;
handles.DispSplits = DispSplits;
handles.DispSplitsPerc = DispSplitsPerc;
