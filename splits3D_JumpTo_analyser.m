function [] = splits3D_JumpTo_analyser(varargin);


handles = guidata(gcf);

StatusEC = get(handles.AminationStatus_analyser, 'String');
if strcmpi(StatusEC, 'Play') == 1;
    %Video is running... just stop it
    axes(handles.Play_button_analyser); imshow(handles.icones.play_offb);

end;

NewFrame = get(handles.JumptoEDIT_analyser, 'String');

li = findstr(NewFrame, ',');
if isempty(li) == 0;
    set(handles.JumptoEDIT_analyser, 'String', '');
    return;
end;

li = findstr(NewFrame, ';');
if isempty(li) == 0;
    set(handles.JumptoEDIT_analyser, 'String', '');
    return;
end;

li = findstr(NewFrame, ' ');
if isempty(li) == 0;
    set(handles.JumptoEDIT_analyser, 'String', '');
    return;
end;

RaceDist = str2num(handles.RaceDistList{1});
if str2num(NewFrame) > RaceDist;
    set(handles.JumptoEDIT_analyser, 'String', '');
    return;
end;

if str2num(NewFrame) < 0;
    set(handles.JumptoEDIT_analyser, 'String', '');
    return;
end;
NewFrame = str2num(NewFrame);

handles.CurrentvalueRaceLapPacing = get(handles.popupRaceLap_analyser, 'value');
handles.CurrentvalueDistSplitsPacing = get(handles.popupDistrance_analyser, 'value');
handles.CurrentSplitsTimePacing = get(handles.splitsTime_check_analyser, 'Value');
handles.CurrentSplitsPercentagePacing = get(handles.splitsPercentage_check_analyser, 'Value');
handles.CurrentSplitsOffPacing = get(handles.splitsOff_check_analyser, 'Value');
handles.CurrentvalueSplitsPacing = get(handles.showsplits_check_analyser, 'Value');

[nbFrameMax, ~] = size(handles.DistanceMain);
RaceDist = str2num(handles.RaceDistList{1});
DistLap = handles.DistLap;
TimeMain = handles.TimeMain;
DistanceMain = handles.DistanceMain;
VelocityMain = handles.VelocityMain;
VelocityMainTrend = handles.VelocityMainTrend;
storeTitle2 = handles.storeTitle2;
storeName = handles.storeName;
laneOrder = handles.laneOrder;
posY = handles.posY;
DistanceMain_Interp = handles.DistanceMain_Interp;
VelocityMain_Interp = handles.VelocityMain_Interp;
VelocityMainTrend_Interp = handles.VelocityMainTrend_Interp;
dataMatSplitsPacingFullRacePerc = handles.dataMatSplitsPacingTRIMFullRacePerc;
dataMatSplitsPacingFullRace = handles.dataMatSplitsPacingTRIMFullRace;
nbRaces = length(handles.filelistAdded);
Course = handles.CourseList{1};
nbLap = RaceDist./Course;
FrameRate = handles.FrameRate;

LocMin = 100000000000;
for race = 1:nbRaces
    [~, LocMinEC] = min(abs(DistanceMain_Interp(:,race)-NewFrame));
    if LocMinEC(1) < LocMin;
        LocMin = LocMinEC(1);
    end;
end;
handles.animationsplitsTimeEC = LocMin;

%---get the current position and velocity
for race = 1:nbRaces;
    laneRaceEC = find(laneOrder(:,2) == race);
    laneOrder(laneRaceEC,3) = DistanceMain_Interp(handles.animationsplitsTimeEC,race);
%     laneOrder(laneRaceEC,4) = VelocityMain_Interp(handles.animationsplitsTimeEC,race);
    laneOrder(laneRaceEC,4) = VelocityMainTrend_Interp(handles.animationsplitsTimeEC,race);
end;

if handles.CurrentvalueRaceLapPacing == 1;
    radiusx = 0.011*RaceDist;
    if RaceDist == 50;
        factorY = 8;
    elseif RaceDist == 100;
        factorY = 15;
    elseif RaceDist == 150;
        factorY = 22;
    elseif RaceDist == 200;
        factorY = 30;
    elseif RaceDist == 400;
        factorY = 45;
    elseif RaceDist == 800;
        factorY = 100;
    elseif RaceDist == 1500;
        factorY = 200;
    end;
else;
    radiusx = 0.011*50;
    if RaceDist <= 800;
        factorY = 8;
    else;
        factorY = 10;
    end;
end;
radiusy = 0.015*11;
colorsinput = [1 0 0; 0.4 0.9 0.5; 0.7 0.2 1; 0.1 0.8 1; ...
        0.8 0.8 0.1; 0.6 0.1 0.2; 0.4 0.5 0.1; 0.5 0.5 0.5];
colorsDarkinput = [0.65 0 0; 0.2 0.4 0.2; 0.4 0.1 0.5; 0.05 0.5 0.4; ...
        0.4 0.4 0.5; 0.35 0.05 0.1; 0.18 0.23 0.05; 0.25 0.25 0.25];

CurrentTime = TimeMain(handles.animationsplitsTimeEC,1);
CurrentTimeTXT = timeSecToStr(CurrentTime);
set(handles.DispTimeAnimation_analyser, 'String', CurrentTimeTXT);

handles.hf_w1_welcome.CurrentAxes = handles.axessplits_analyser;
hold on;
UWPiece = handles.UWPiece;


for race = 1:nbRaces;
    eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
    eval(['BOAll = handles.BOAllR' num2str(race) ';']);
    RaceTime = SplitsAll(end,2);
    laneRaceEC = find(laneOrder(:,2) == race);

    eval(['vectorDistanceUW = handles.vectorDistanceUW_L' num2str(race) ';']);
    eval(['vectorDistanceAW = handles.vectorDistanceAW_L' num2str(race) ';']);

    lilim = floor((RaceTime-15)*FrameRate);
    if mod(lilim, 1) == 0;
        lilim = lilim-1;
    end;

    liNonNan = find(isnan(DistanceMain(lilim:end,race)) == 0); 
    liNonNan = liNonNan(end) + lilim - 1;
    RaceTimeCorr = TimeMain(liNonNan, race);

    if handles.CurrentSplitsOffPacing == 0;
        try;
            eval(['DispSplitsSec = handles.DispSplitsSec_L' num2str(race) ';']);
            eval(['DispSplitsLine = handles.DispSplitsLine_L' num2str(race) ';']);
            delete(DispSplitsSec);
            delete(DispSplitsLine);
        end;
    end;

    if CurrentTime <= RaceTimeCorr;
        %if the race is still running

        %---get graph element for that lane and delete
        eval(['circleMain = handles.circleMain_L' num2str(race) ';']);
        eval(['racetitle = handles.racetitle_L' num2str(race) ';']);
        delete(circleMain);
        delete(racetitle);
        try;
            eval(['lineMainAW = handles.lineMainAW_L' num2str(race) ';']);
            delete(lineMainAW);
        end;
        try;
            eval(['lineMainUW = handles.lineMainUW_L' num2str(race) ';']);
            delete(lineMainUW);
        end;        
        %---

        %---data
        dataLineX = [0 laneOrder(laneRaceEC,3)];
        dataLineY = [posY(laneOrder(laneRaceEC,1)) posY((laneOrder(laneRaceEC,1)))];
        dataCircleX = laneOrder(laneRaceEC, 3);
        dataCircleY = posY(laneOrder(laneRaceEC,1));
        %---    

        %---Draw new elements
        if CurrentTime <= BOAll(1,2)-1;
            lineMainUW = line(handles.axessplits_analyser, [0 vectorDistanceUW(handles.animationsplitsTimeEC)], ...
                dataLineY, 'linewidth', 4, 'linestyle', ':', 'color', colorsDarkinput(race,:));
            eval(['handles.lineMainUW_L' num2str(race) ' = lineMainUW;']);

            lineMainAW = [];
        else;
            dataPlotY = ones(handles.animationsplitsTimeEC,1).*dataLineY(1);
            lineMainAW = plot(handles.axessplits_analyser, vectorDistanceAW(1:handles.animationsplitsTimeEC), ...
                 dataPlotY, 'linewidth', 6, 'color', colorsinput(race,:), 'linestyle', ':');
            eval(['handles.lineMainAW_L' num2str(race) ' = lineMainAW;']);

            lineMainUW = plot(handles.axessplits_analyser, vectorDistanceUW(1:handles.animationsplitsTimeEC), ...
                 dataPlotY, 'linewidth', 4, 'color', colorsDarkinput(race,:), 'linestyle', ':');
            eval(['handles.lineMainUW_L' num2str(race) ' = lineMainUW;']);
        end;

        circleMain = circle(dataCircleX, dataCircleY, radiusx, radiusy, ...
            colorsinput(race,:), handles.axessplits_analyser);

        %Texts: Name, velocity and position
        if roundn(CurrentTime,-2) == roundn(RaceTimeCorr,-2);

            nameAthlete = storeName{race};
            textDisplay = {nameAthlete};            
            racetitleEC = text(dataCircleX+(factorY.*radiusy), dataCircleY, textDisplay, 'horizontalalignment', 'Left', 'verticalalignment', 'middle', ...
                'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'Normalized', 'Fontsize', 0.022, 'color', colorsinput(race,:), ...
                'Clipping', 'on', 'parent', handles.axessplits_analyser, 'visible', 'on');
        else;
            nameAthlete = ['  ' storeName{race}];
            if isnan(vectorDistanceAW(handles.animationsplitsTimeEC)) == 0;
                speed = [dataToStr(laneOrder(laneRaceEC,4),2) ' m/s'];
                position = [dataToStr(laneOrder(laneRaceEC,3),2) ' m'];
            else;
                speed = '';
                position = '';
            end;
            textDisplay = {position; nameAthlete; speed};

            racetitleEC = text(dataCircleX+(factorY.*radiusy), dataCircleY, textDisplay, 'horizontalalignment', 'Left', 'verticalalignment', 'middle', ...
                'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'Normalized', 'Fontsize', 0.022, 'color', [1 1 1], ...
                'Clipping', 'on', 'parent', handles.axessplits_analyser, 'visible', 'on');
        end;
        %---

        %---save other data
        eval(['handles.circleMain_L' num2str(race) ' = circleMain;']);
        eval(['handles.racetitle_L' num2str(race) ' = racetitleEC;']);
        %---

    else;
        %---Race is finished
        dataLineX = [0 laneOrder(laneRaceEC,3)];
        dataLineY = [posY(laneOrder(laneRaceEC,1)) posY((laneOrder(laneRaceEC,1)))];
        dataCircleX = laneOrder(laneRaceEC, 3);
        dataCircleY = posY(laneOrder(laneRaceEC,1));
        if CurrentTime+(1/FrameRate) == RaceTimeCorr;
            eval(['racetitle = handles.racetitle_L' num2str(race) ';']);
            delete(racetitle);

            nameAthlete = storeName{race};
            textDisplay = {nameAthlete};

            racetitleEC = text(dataCircleX+(factorY.*radiusy), dataCircleY, textDisplay, 'horizontalalignment', 'Left', 'verticalalignment', 'middle', ...
                'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'Normalized', 'Fontsize', 0.022, 'color', colorsinput(race,1), ...
                'Clipping', 'on', 'parent', handles.axessplits_analyser, 'visible', 'on');

            eval(['handles.FinalTimetitle_L' num2str(race) ' = FinalTimetitle;']);
            eval(['handles.racetitle_L' num2str(race) ' = racetitleEC;']);
        end;
    end;

    %---Display splits
    DispSplits = handles.DispSplits;
    if handles.CurrentvalueSplitsPacing == 1;
        set(DispSplits, 'Visible', 'on');
    else;
        set(DispSplits, 'Visible', 'off');
    end;
    %---    


    %---Display Key distances/Times/Percentages
    DispSplitsSec = [];
    DispSplitsLine = [];
    if handles.CurrentSplitsTimePacing == 1;
        iter = 1;
        for split = 1:length(dataMatSplitsPacingFullRace(:,1));
            DistSplit = dataMatSplitsPacingFullRace(split,1);
            if dataCircleX >= DistSplit;
                TimeSplit = dataMatSplitsPacingFullRace(split,race+1);
                if isnan(TimeSplit) == 0;
                    SplitsTXT = timeSecToStr(roundn(TimeSplit,-2));

                    DispSplitsSecEC = text(DistSplit, dataCircleY, SplitsTXT, 'horizontalalignment', 'center', ...
                        'verticalalignment', 'Bottom', 'FontWeight', 'bold', 'FontName', 'Antiqua', ...
                        'FontUnits', 'normalized', 'Fontsize', 0.022, 'color', [0.85 0.85 0.85], 'rotation', 270, ...
                        'parent', handles.axessplits_analyser, 'visible', 'on', 'Clipping', 'on');

                    DispSplitsLineEC = line(handles.axessplits_analyser, [DistSplit DistSplit], ...
                        [dataCircleY-0.5 dataCircleY+0.5], 'linewidth', 2, 'linestyle', ':', ...
                        'color', [0.85 0.85 0.85],'Visible', 'on');

                    DispSplitsSec(iter) = DispSplitsSecEC;
                    DispSplitsLine(iter) = DispSplitsLineEC;
                    iter = iter + 1;
                end;
            end;
        end;
    end;
    if handles.CurrentSplitsPercentagePacing == 1;
        iter = 1;
        for split = 1:length(dataMatSplitsPacingFullRacePerc(:,1));
            DistSplit = dataMatSplitsPacingFullRacePerc(split,1);
            if dataCircleX >= DistSplit;
                TimeSplit = dataMatSplitsPacingFullRacePerc(split,race+1);
                if isnan(TimeSplit) == 0;
                    SplitsTXT = [dataToStr(TimeSplit,2) '%'];
                    DispSplitsSecEC = text(DistSplit, dataCircleY, SplitsTXT, 'horizontalalignment', 'center', ...
                        'verticalalignment', 'Bottom', 'FontUnits', 'normalized', ...
                        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 0.022, 'color', [0.85 0.85 0.85], ...
                        'rotation', 270, 'parent', handles.axessplits_analyser, 'visible', 'on', 'Clipping', 'on');
%                     set(DispSplitsSec(iter), 'fontunits', 'Normalized');

                    DispSplitsLineEC = line(handles.axessplits_analyser, [DistSplit DistSplit], ...
                        [dataCircleY-0.5 dataCircleY+0.5], 'linewidth', 2, 'linestyle', ':', ...
                        'color', [0.85 0.85 0.85], 'Visible', 'on');

                    DispSplitsSec(iter) = DispSplitsSecEC;
                    DispSplitsLine(iter) = DispSplitsLineEC;
                    iter = iter + 1;
                end;
            end;
        end;
    end;
    eval(['handles.DispSplitsSec_L' num2str(race) ' = DispSplitsSec;']);
    eval(['handles.DispSplitsLine_L' num2str(race) ' = DispSplitsLine;']);
    %---

end;

%---adjust xlim
if handles.CurrentvalueRaceLapPacing == 1;
    xlim(handles.axessplits_analyser, [0 RaceDist+(0.05.*RaceDist)]);
else;
    %find leader
    leaderPos = max(laneOrder(:,3));
    if leaderPos >= 35;
        limInf = leaderPos - 35;
        limSup = limInf + 50;
        if limSup > RaceDist+(0.05.*50);
            limSup = RaceDist + (0.05.*50);
            limInf = limSup - 50;
        end;
    else;
        limInf = 0;
        limSup = 50;
    end;
    xlim(handles.axessplits_analyser, [limInf limSup]);
end;

set(handles.JumptoEDIT_analyser, 'String', '');

set(handles.AminationStatus_analyser, 'String', 'JumpTo');
guidata(handles.hf_w1_welcome, handles);

