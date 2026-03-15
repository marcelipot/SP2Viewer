
set(handles.splits1D_check_analyser, 'Value', 0);
set(handles.splits2D_check_analyser, 'Value', 0);
handles.CurrentvalueSplits1D = 0;
handles.CurrentvalueSplits2D = 0;
handles.CurrentvalueSplits3D = 1;

origin = 'splits';
delete_allaxes_analyser;

set(allchild(handles.Precedentchap_button_analyser), 'Visible', 'on');
set(handles.Precedentchap_button_analyser, 'XTick', [], 'YTick', []);
set(allchild(handles.Precedentimage_button_analyser), 'Visible', 'on');
set(handles.Precedentimage_button_analyser, 'XTick', [], 'YTick', []);
set(allchild(handles.Stop_button_analyser), 'Visible', 'on');
set(handles.Stop_button_analyser, 'XTick', [], 'YTick', []);
set(allchild(handles.Play_button_analyser), 'Visible', 'on');
set(handles.Play_button_analyser, 'XTick', [], 'YTick', []);
set(allchild(handles.Suivantimage_button_analyser), 'Visible', 'on');
set(handles.Suivantimage_button_analyser, 'XTick', [], 'YTick', []);
set(allchild(handles.Suivantchap_button_analyser), 'Visible', 'on');
set(handles.Suivantchap_button_analyser, 'XTick', [], 'YTick', []);
uistack(handles.Precedentchap_button_analyser, 'top');
uistack(handles.Precedentimage_button_analyser, 'top');
uistack(handles.Stop_button_analyser, 'top');
uistack(handles.Play_button_analyser, 'top');
uistack(handles.Suivantimage_button_analyser, 'top');
uistack(handles.Suivantchap_button_analyser, 'top');
set(handles.JumptoTXT_analyser, 'Visible', 'on');
set(handles.JumptoEDIT_analyser, 'Visible', 'on', 'String', '');
set(handles.DispTimeAnimation_analyser, 'Visible', 'on');
set(handles.panellanes3D_splits_analyser, 'Visible', 'on');
set(handles.txtLane1Name_analyser, 'String', '-----');
set(handles.txtLane2Name_analyser, 'String', '-----');
set(handles.txtLane3Name_analyser, 'String', '-----');
set(handles.txtLane4Name_analyser, 'String', '-----');
set(handles.txtLane5Name_analyser, 'String', '-----');
set(handles.txtLane6Name_analyser, 'String', '-----');
set(handles.txtLane7Name_analyser, 'String', '-----');
set(handles.txtLane8Name_analyser, 'String', '-----');
axes(handles.Play_button_analyser); imshow(handles.icones.play_offb);

if isfield(handles, 'animationsplitsTimeEC') == 0;
    handles.animationsplitsTimeEC = 1;
end;

dataMatSplitsPacingFullRace = handles.dataMatSplitsPacingFullRace;
%---convert to Percentage
dataMatSplitsPacingFullRacePerc = dataMatSplitsPacingFullRace(:,1);
for race = 1:nbRaces;
    eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
    raceTime = SplitsAll(end,2);
    
    for split = 1:length(dataMatSplitsPacingFullRace(:,1));
        splitEC = dataMatSplitsPacingFullRace(split,race+1);
        if isnan(splitEC) == 1;
            dataMatSplitsPacingFullRacePerc(split, race+1) = NaN;
        else;
            dataMatSplitsPacingFullRacePerc(split, race+1) = (splitEC./raceTime).*100;
        end;
    end;
end;
handles.dataMatSplitsPacingFullRacePerc = dataMatSplitsPacingFullRacePerc;

if isempty(handles.RaceDistList{1}) == 0;
    refli = 1;
else;
    if isempty(handles.RaceDistList{2}) == 0;
        refli = 2;
    else;
        if isempty(handles.RaceDistList{3}) == 0;
            refli = 3;
        else;
            if isempty(handles.RaceDistList{4}) == 0;
                refli = 4;
            else;
                if isempty(handles.RaceDistList{5}) == 0;
                    refli = 5;
                else;
                    if isempty(handles.RaceDistList{6}) == 0;
                        refli = 6;
                    else;
                        if isempty(handles.RaceDistList{7}) == 0;
                            refli = 7;
                        else;
                            if isempty(handles.RaceDistList{8}) == 0;
                                refli = 8;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
RaceDist = str2num(handles.RaceDistList{refli});
nbRaces = length(handles.filelistAdded);
Course = str2num(handles.CourseList{refli});
nbLap = RaceDist./Course;

if Course == 50;
    if RaceDist <= 100;
        DistSplits = 5;
    elseif RaceDist > 100 & RaceDist <= 400;
        DistSplits = 10;
    elseif RaceDist > 400 & RaceDist <= 800;
        DistSplits = 25;
    elseif RaceDist > 800;
        DistSplits = 50;
    end;
else;
    if RaceDist < 200;
        DistSplits = 5;
    elseif RaceDist >= 200 & RaceDist <= 800;
        DistSplits = 25;
    elseif RaceDist > 800;
        DistSplits = 50;
    end;
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

TimeMain = [];
DistanceMain = [];
VelocityMain = [];
UWPiece = [];
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
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    
    eval(['Velocity = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['VelocityTrend = handles.RacesDB.' UID '.RawVelocityTrend;']);
    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['Time = handles.RacesDB.' UID '.RawTime;']);
    
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);

    eval(['handles.SplitsAllR' num2str(race) ' = SplitsAll;']);
    RaceTimes(race,1) = SplitsAll(end,2);
    
    Distance = Distance(1,:);
    Distance(1,1) = 0;
    for lap = 2:nbLap+1;
        Distance(1, SplitsAll(lap,3)) = SplitsAll(lap,1);
    end;
    
    liNan = find(isnan(Distance) == 1);
    listrow = 1:length(Distance);
    listrow(liNan) = [];
    liNonNan = listrow;
    li = find(diff(liNan) ~= 1);
    if isempty(li);
        UWPiece(1,1:2,race) = [1 liNan(end)];
    else;
        UWPiece(1,1:2,race) = [1 li(1)+1];
    end;
    for lap = 2:nbLap+1;
        if lap ~= nbLap+1;
            checkliNonNan = liNonNan - SplitsAll(lap,3);
            liTarget = find(checkliNonNan == 0);
            NegVal = SplitsAll(lap,3) - abs(checkliNonNan(liTarget-1));
            PosVal = SplitsAll(lap,3) + abs(checkliNonNan(liTarget+1));
            UWPiece(lap,1:2,race) = [NegVal PosVal];
        end;
    end;
    if liNonNan(end) ~= length(Distance)-1;
        if isempty(lap) == 0;
            UWPiece(lap,1:2,race) = [liNonNan(end-1)+1 length(Distance)];
        end;
    end;
    
    if strcmpi(detailRelay, 'None') == 1;
        if Source == 1;
            graphTitle = [Athletename ' ' Meet Year ' ' num2str(RaceDist) 'm-' StrokeType '-' Stage ' (SP1)'];
        elseif Source == 2;
            graphTitle = [Athletename ' ' Meet Year ' ' num2str(RaceDist) 'm-' StrokeType '-' Stage ' (SP2)'];
        elseif Source == 3;
            graphTitle = [Athletename ' ' Meet Year ' ' num2str(RaceDist) 'm-' StrokeType '-' Stage ' (GE)'];
        end;
    else;
        if Source == 1;
            graphTitle = [Athletename ' ' Meet Year ' ' num2str(RaceDist) 'm-' StrokeType '-' Stage '-' detailRelay ' ' valRelay ' (SP1)'];
        elseif Source == 2;
            graphTitle = [Athletename ' ' Meet Year ' ' num2str(RaceDist) 'm-' StrokeType '-' Stage '-' detailRelay ' ' valRelay ' (SP2)'];
        elseif Source == 3;
            graphTitle = [Athletename ' ' Meet Year ' ' num2str(RaceDist) 'm-' StrokeType '-' Stage '-' detailRelay ' ' valRelay ' (GE)'];
        end;
    end;
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
    if strcmpi(detailRelay, 'None') == 1;
        if Source == 1;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort ' (SP1)'];
        elseif Source == 2;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort ' (SP2)'];
        elseif Source == 3;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort ' (GE)'];
        end;
    else;
        if Source == 1;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' (SP1)'];
        elseif Source == 2;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' (SP2)'];
        elseif Source == 3;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' (GE)'];
        end;
    end;
    storeTitle2{race} = graphTitle2;
    
    AthletenameShort = Athletename;
    if length(Athletename) > 10;
        AthletenameShort = [Athletename(1:9) Athletename(end)];
    end;
    if race ~= 1;
        proceed = 1;
        iter = 1;
        count = 2;
        while proceed == 1;
            NameEC = storeName{iter};
            li = findstr(AthletenameShort, '(');
            if isempty(li) == 1;
                AthletenameShortTest = AthletenameShort;
            else;
                AthletenameShortTest = AthletenameShort(1:end-1);
            end;
            if strcmpi(AthletenameShortTest, NameEC) == 1;
                li = findstr(AthletenameShort, '(');
                if isempty(li) == 1;
                    AthletenameShort = [AthletenameShort '(' num2str(count) ')'];
                else;
                    AthletenameShort = [AthletenameShort(1:end-1) '(' num2str(count) ')'];
                end;
                count = count + 1;
            end;
            iter = iter + 1;
            if iter == race;
                proceed = 0;
            end;
        end;
    end;
    storeName{race} = AthletenameShort;
    
    Distance(1, 1:SplitsAll(1,3)) = 0;
    if race == 1;
        TimeMain = Time';
        DistanceMain = Distance';
        VelocityMain = Velocity';
        VelocityMainTrend = VelocityTrend';
    else;
        [liMain, coMain] = size(TimeMain);
        if liMain < length(Time);
            diffli = length(Time)-liMain;
            MatNan = ones(diffli, coMain).*NaN;

            TimeMain = [TimeMain; MatNan];
            TimeMain = [TimeMain Time'];
            DistanceMain = [DistanceMain; MatNan];
            DistanceMain = [DistanceMain Distance'];
            VelocityMain = [VelocityMain; MatNan];
            VelocityMain = [VelocityMain Velocity'];
            VelocityMainTrend = [VelocityMainTrend; MatNan];
            VelocityMainTrend = [VelocityMainTrend VelocityTrend'];
        elseif liMain > length(Time);
            diffli = liMain-length(Time);
            MatNan = ones(diffli, 1).*NaN;
            
            TimeMain = [TimeMain [Time'; MatNan]];
            DistanceMain = [DistanceMain [Distance'; MatNan]];
            VelocityMain = [VelocityMain [Velocity'; MatNan]];
            VelocityMainTrend = [VelocityMainTrend [VelocityTrend'; MatNan]];
        else;
            TimeMain = [TimeMain Time'];
            DistanceMain = [DistanceMain Distance'];
            VelocityMain = [VelocityMain Velocity'];
            VelocityMainTrend = [VelocityMainTrend VelocityTrend'];
        end;
    end;
    
    eval(['DistanceMain_L' num2str(race) ' = DistanceMain;']);
end;
DistanceMain_Interp = [];
VelocityMain_Interp = [];
VelocityMainTrend_Interp = [];
for race = 1:nbRaces;
    dataInterp = naninterp(DistanceMain(:,race), 'spline');
    for lap = 2:nbLap;
        DistanceMain(SplitsAll(lap,3), race) = NaN;
    end;
    DistanceMain_Interp(:,race) = dataInterp;
    VelocityMain_Interp(:,race) = naninterp(VelocityMain(:,race), 'spline');
    VelocityMainTrend_Interp(:,race) = naninterp(VelocityMainTrend(:,race), 'spline');
end;

for race = 1:nbRaces;
    UWPieceEC = UWPiece(:,:,race);
    sectionMin = UWPieceEC(1,1);
    sectionMax = UWPieceEC(1,2);
    eval(['DistanceMain = DistanceMain_L' num2str(race) ';']);
    
    vectorDistanceAW = ones(length(DistanceMain),1).*NaN;
    vectorDistanceUW = ones(length(DistanceMain),1).*NaN;
    
    vectorDistanceUW(sectionMin:sectionMax, 1) = DistanceMain_Interp(sectionMin:sectionMax, race);
    if NbLap == 1;
        vectorDistanceAW(sectionMax+1:end, 1) = DistanceMain(sectionMax+1:end, race);
        
    else;
        for lap = 2:nbLap+1;
            sectionMin = UWPieceEC(lap,1);    
            vectorDistanceAW(sectionMax+1:sectionMin-1, 1) = DistanceMain(sectionMax+1:sectionMin-1, race);

            sectionMax = UWPieceEC(lap,2);
            vectorDistanceUW(sectionMin:sectionMax, 1) = DistanceMain_Interp(sectionMin:sectionMax, race);
        end;
    end;
    
    eval(['handles.vectorDistanceUW_L' num2str(race) ' = vectorDistanceUW;']);
    eval(['handles.vectorDistanceAW_L' num2str(race) ' = vectorDistanceAW;']);
end;

DistLap = Course:Course:RaceDist;
handles.DistLap = DistLap;
handles.TimeMain = TimeMain;
handles.DistanceMain = DistanceMain;
handles.VelocityMain = VelocityMain;
handles.VelocityMainTrend = VelocityMainTrend;
handles.storeTitle2 = storeTitle2;
handles.storeName = storeName;
handles.UWPiece = UWPiece;
handles.DistanceMain_Interp = DistanceMain_Interp;
handles.VelocityMain_Interp = VelocityMain_Interp;
handles.VelocityMainTrend_Interp = VelocityMainTrend_Interp;
handles.FrameRate = FrameRate;
create_AnimationAxe;

%Initiate stems
colorsinput = [1 0 0; 0.4 0.9 0.5; 0.7 0.2 1; 0.1 0.8 1; ...
        0.8 0.8 0.1; 0.6 0.1 0.2; 0.4 0.5 0.1; 0.5 0.5 0.5];
colorsDarkinput = [0.65 0 0; 0.2 0.4 0.2; 0.4 0.1 0.5; 0.05 0.5 0.4; ...
        0.4 0.4 0.5; 0.35 0.05 0.1; 0.18 0.23 0.05; 0.25 0.25 0.25];

laneOrder(:,1) = [4; 5; 3; 6; 2; 7; 1; 8];
laneOrder(:,2) = [NaN; NaN; NaN; NaN; NaN; NaN; NaN; NaN];
laneOrder(:,3) = [NaN; NaN; NaN; NaN; NaN; NaN; NaN; NaN];
laneOrder(:,4) = [NaN; NaN; NaN; NaN; NaN; NaN; NaN; NaN];
posY = [1.5:1:8.5];

[lanesort, index] = sort(RaceTimes);
for race = 1:nbRaces
    laneOrder(race, 2) = index(race);
    
    name = storeTitle2{index(race)};
    proceed = 1;
    while proceed == 1;
        lispecial = strfind(name, '-');
        if isempty(lispecial) == 0;
            name2 = [name(1:lispecial(1)-1) name(lispecial(1)+1:end)];
        else;
            proceed = 0;
            name2 = name;
        end;
        name = name2;
    end;

    name = storeTitle2{index(race)};

    proceed = 1;
    while proceed == 1;
        lispecial = strfind(name, ['''']);
        if isempty(lispecial) == 0;
            name2 = [name(1:lispecial(1)-1) name(lispecial(1)+1:end)];
        else;
            proceed = 0;
            name2 = name;
        end;
        name = name2;
    end;
    
    eval(['set(handles.txtLane' num2str(laneOrder(race,1)) 'Name_analyser, ' '''' 'String' '''' ', ' '''' name '''' ');']);
end;

CurrentTime = TimeMain(handles.animationsplitsTimeEC,1);
CurrentTimeTXT = timeSecToStr(CurrentTime);
set(handles.DispTimeAnimation_analyser, 'String', CurrentTimeTXT);

for race = 1:nbRaces;
    laneRaceEC = find(laneOrder(:,2) == race);
    laneOrder(laneRaceEC,3) = DistanceMain_Interp(handles.animationsplitsTimeEC,race);
%     laneOrder(laneRaceEC,4) = VelocityMain_Interp(handles.animationsplitsTimeEC,race);%%%%%%%%%%%%%%%%%%
    laneOrder(laneRaceEC,4) = VelocityMainTrend_Interp(handles.animationsplitsTimeEC,race);
end;
handles.laneOrder = laneOrder;
handles.posY = posY;

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

iterDispSplit = 1;
for race = 1:nbRaces;
    hold on;
    
    eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
    eval(['BOAll = handles.BOAllR' num2str(race) ';']);
    RaceTime = SplitsAll(end,2);
    laneRaceEC = find(laneOrder(:,2) == race);
    
    eval(['set(handles.txtLane' num2str(laneOrder(laneRaceEC,1)) '_analyser, ' ''''  'String' '''' ', [' '''' 'Lane ' num2str(laneOrder(laneRaceEC,1)) ' : ' '''' ' ' '''' timeSecToStr(RaceTime) '''' ']);'])
    
    eval(['vectorDistanceUW = handles.vectorDistanceUW_L' num2str(race) ';']);
    eval(['vectorDistanceAW = handles.vectorDistanceAW_L' num2str(race) ';']);
    
    lilim = floor((RaceTime-1)*FrameRate);
    if mod(lilim, 1) == 0;
        lilim = lilim-1;
    end;
    liNonNan = find(isnan(DistanceMain(lilim:end,race)) == 0); 
    liNonNan = liNonNan(end) + lilim - 1;
    RaceTimeCorr = TimeMain(liNonNan, race);
    
    try;
        eval(['DispSplitsSec = handles.DispSplitsSec_L' num2str(race) ';']);
        eval(['DispSplitsLine = handles.DispSplitsLine_L' num2str(race) ';']);
        delete(DispSplitsSec);
        delete(DispSplitsLine);
    end;
        
    %---Main plot
    if CurrentTime <= RaceTimeCorr;
        %if the race is still running
        
        %---get graph element for that lane and delete
        try;
            eval(['circleMain = handles.circleMain_L' num2str(race) ';']);
            eval(['racetitle = handles.racetitle_L' num2str(race) ';']);
            delete(circleMain);
            delete(racetitle);
        end;
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
                'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'Normalized', 'Fontsize', 0.022, 'color', [1 1 1], ...
                'Clipping', 'on', 'parent', handles.axessplits_analyser, 'visible', 'on');
            
            eval(['handles.FinalTimetitle_L' num2str(race) ' = FinalTimetitle;']);
            eval(['handles.racetitle_L' num2str(race) ' = racetitleEC;']);
        end;
    end;
    
    %---Create splits
    SplitsAll = SplitsAll(2:end,:);
    for lap = 1:nbLap;
        SplitsTXT = '';
        TimeCum = SplitsAll(lap, 2);
        if lap == 1;
            CumTXT = timeSecToStr(TimeCum);
            SplitsTXT = {CumTXT};
        else;
            TimeLap = TimeCum-SplitsAll(lap-1, 2);
            LapTXT = timeSecToStr(TimeLap);
            CumTXT = timeSecToStr(TimeCum);
            SplitsTXT = {LapTXT; CumTXT};
        end;

        DispSplits(iterDispSplit) = text(SplitsAll(lap,1), posY(laneOrder(laneRaceEC,1)), SplitsTXT, 'horizontalalignment', 'center', 'verticalalignment', 'Top', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'fontunits', 'normalized', 'Fontsize', 0.022, 'color', [0.85 0.85 0.85], 'rotation', 270, ...
            'Clipping', 'on', 'parent', handles.axessplits_analyser, 'visible', 'off');

        iterDispSplit = iterDispSplit + 1;
    end;
    
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
        for split = 1:length(dataMatSplitsPacingTRIMFullRace(:,1));
            DistSplit = dataMatSplitsPacingTRIMFullRace(split,1);
            if dataCircleX >= DistSplit;
                TimeSplit = dataMatSplitsPacingTRIMFullRace(split,race+1);
                if isnan(TimeSplit) == 0;
                    SplitsTXT = timeSecToStr(roundn(TimeSplit,-2));

                    DispSplitsSecEC = text(DistSplit, dataCircleY, SplitsTXT, 'horizontalalignment', 'center', ...
                        'verticalalignment', 'Bottom', 'FontWeight', 'bold', 'FontName', 'Antiqua', ...
                        'FontUnits', 'normalized', 'Fontsize', 0.022, 'color', [0.95 0.95 0.95], 'rotation', 270, ...
                        'parent', handles.axessplits_analyser, 'visible', 'on', 'Clipping', 'on');
                    
                    DispSplitsLineEC = line(handles.axessplits_analyser, [DistSplit DistSplit], ...
                        [dataCircleY-0.5 dataCircleY+0.5], 'linewidth', 2, 'linestyle', ':', ...
                        'color', [0.95 0.95 0.95],'Visible', 'on');
                   
                    DispSplitsSec(iter) = DispSplitsSecEC;
                    DispSplitsLine(iter) = DispSplitsLineEC;
                    iter = iter + 1;
                end;
            end;
        end;
    end;
    if handles.CurrentSplitsPercentagePacing == 1;
        iter = 1;
        for split = 1:length(dataMatSplitsPacingTRIMFullRacePerc(:,1));
            DistSplit = dataMatSplitsPacingTRIMFullRacePerc(split,1);
            if dataCircleX >= DistSplit;
                TimeSplit = dataMatSplitsPacingTRIMFullRacePerc(split,race+1);
                if isnan(TimeSplit) == 0;
                    SplitsTXT = [dataToStr(TimeSplit,2) '%'];
                    DispSplitsSecEC = text(DistSplit, dataCircleY, SplitsTXT, 'horizontalalignment', 'center', ...
                        'verticalalignment', 'Bottom', 'FontUnits', 'normalized', ...
                        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 0.022, 'color', [0.95 0.95 0.95], ...
                        'rotation', 270, 'parent', handles.axessplits_analyser, 'visible', 'on', 'Clipping', 'on');
                    
                    DispSplitsLineEC = line(handles.axessplits_analyser, [DistSplit DistSplit], ...
                        [dataCircleY-0.5 dataCircleY+0.5], 'linewidth', 2, 'linestyle', ':', ...
                        'color', [0.95 0.95 0.95], 'Visible', 'on');
                    
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
handles.DispSplits = DispSplits;
    
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

xticklabelValue{1} = '0';
for i = 1:length(DistLap);
    xticklabelValue{i+1} = [num2str(DistLap(i))];
end;

ytickValue = [1.5:1:8.5];
for i = 1:length(ytickValue);
    yticklabelValue{i} = ['Lane ' num2str(i)];
end;

set(handles.axessplits_analyser, 'Visible', 'on', 'color', [0 0 0], ...
    'xtick', [0 DistLap], 'xticklabel', xticklabelValue, 'xcolor', [1 1 1], ...
    'ytick', ytickValue, 'yticklabel', yticklabelValue, 'ycolor', [1 1 1], ...
    'units', 'normalized');

handles.actionplay_analyser = 0;

