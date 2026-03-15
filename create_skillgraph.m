RaceUID = [];
nbRaces = length(handles.filelistAdded);
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

% nbRaces = length(handles.filelistAdded);
if strcmpi(origin, 'UpdateSkills');
    listrace = selectrace;
    nbRaces = handles.nbRacesEC;
else;
    if isfield(handles, 'nbRacesEC') == 1;
        firstrace = 1;
        nbRaces = handles.nbRacesEC;
        listrace = 1:nbRaces;
    else;
        nbRaces = 8;
        listrace = 1:nbRaces;
    end;
end;


if isfield(handles, 'CurrentvalueRace') == 0;
    handles.CurrentvalueRace = 1;
end;
if handles.CurrentvalueRace == 1;
    selectrace = 1:nbRaces;
else;
    selectrace = handles.CurrentvalueRace-1;
end;
if isfield(handles, 'CurrentvalueTurn') == 0;
    handles.CurrentvalueTurn = 1;
end;
% for i = 1:length(selectrace);
%     raceEC = selectrace(i);
%     handles.TurnDisplaySelect(raceEC) = handles.CurrentvalueTurn;
% end;
for i = 1:length(listrace);
    raceEC = listrace(i);
    handles.TurnDisplaySelect(raceEC) = handles.CurrentvalueTurn;
end;
raceEC = [];
storeTitle = [];
ScoreSpider = [];

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
    handles.storeTitle = storeTitle;
    handles.storeTitle2 = storeTitle2;
    
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
            eval(['axesEC = handles.axesskill' Kletter num2str(race) '_analyser;']);
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
        eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
        eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);

        if strcmpi(detailRelay, 'None');
            graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage];
        else;
            graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage '-' detailRelay ' ' valRelay];
        end;
%         storeTitle{race} = graphTitle;

        if nbRaces >= 5;
            if strcmpi(detailRelay, 'None');
                graphTitle = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year '-' Stage]};
            else;
                graphTitle = {[Athletename '  ' num2str(RaceDist) 'm-' StrokeType]; [Meet Year]; [Stage '-' detailRelay ' ' valRelay]};
            end;
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
        YearShort = Year(3:4);

        if strcmpi(detailRelay, 'None')
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '                                                               '];
            graphTitle3 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
        else;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' ' valRelay '                                  '];
            graphTitle3 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' ' valRelay];
        end;
        storeTitle2{race} = graphTitle2;
        storeTitle3{race} = graphTitle3;

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
        eval(['StartUWVelocity = handles.RacesDB.' UID '.StartUWVelocity;']);
        eval(['StartEntryDist = handles.RacesDB.' UID '.StartEntryDist;']);
        eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
        eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);

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
        
%         toolbar = axtoolbar(axesEC, 'default');
%         toolbar.Visible = 'on';
        
        dataEC = [];
        dataEC.StartRT = roundn(RT, -2);
        dataEC.StartKicks = KicksNb(1);
        dataEC.StartTime = roundn(DiveT15, -2);
        dataEC.StartBODist = roundn(BOAllDistance(1), -2);
        dataEC.StartBOEff = [roundn(VelBeforeBO(1),-2); roundn(VelAfterBO(1),-2)];
        dataEC.StartEntry = StartEntryDist;
        dataEC.StartUWS = StartUWVelocity;

        if NbLap == 1;
            DataToPlot = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                ScoreSpider.LastApp(race,1)];
            DataToTitle = [RT ScoreRaw.StartFlyDist(race,1) ScoreRaw.StartUWS(race,1) ScoreRaw.StartBOCorr(race,1) ...
                ScoreRaw.LastApp(race,1)];
            
            DataToPlot(DataToPlot < 0) = 0;
            DataToPlot(DataToPlot > 10) = 10;
            LimSpider = [0 0 0 0 0; 10 10 10 10 10];
            axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills (Adj)'; ...
                'Finish Skills'};
            dataEC.LastApp = [roundn(mean(ApproachSpeed2CycleLast),-2); roundn(mean(ApproachSpeedLastCycleLast),-2)];
                    
        else;
            if handles.CurrentvalueTurn == 1;

                %average value
                DataToPlot = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                    ScoreSpider.TurnApproachMean(race,1) ScoreSpider.TurnBOMean(race,1)];
                DataToTitle = [RT ScoreRaw.StartFlyDist(race,1) ScoreRaw.StartUWS(race,1) ScoreRaw.StartBOCorr(race,1) ...
                    ScoreRaw.TurnApproachMean(race,1) ScoreRaw.TurnBOMeanCorr(race,1)];

                DataToPlot(DataToPlot < 0) = 0;
                DataToPlot(DataToPlot > 10) = 10;
                LimSpider = [0 0 0 0 0 0; 10 10 10 10 10 10];
                axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills (Adj)'; ...
                    'Av. App. Skills'; 'Av. BO Skills (Adj)'};

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

                DataToTitle = [RT ScoreRaw.StartFlyDist(race,1) ScoreRaw.StartUWS(race,1) ScoreRaw.StartBOCorr(race,1) ...
                    ScoreRaw.TurnApproach(race,turnEC) ScoreRaw.TurnBO(race,turnEC)];

                DataToPlot(DataToPlot < 0) = 0;
                DataToPlot(DataToPlot > 10) = 10;
                LimSpider = [0 0 0 0 0 0; 10 10 10 10 10 10];
                axesLabel = {'RT'; 'Entry Dist'; 'UW Skills'; 'BO Skills (Adj)'; ...
                    ['App. Skills Turn ' num2str(turnEC)]; ['BO Skills Turn ' num2str(turnEC) ' (Adj)']};

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
        
        liRace = find(listrace == race);
        if isempty(liRace) == 0;
            handles.hf_w1_welcome.CurrentAxes = axesEC; cla;
            
            if nbRaces > 4;
                axesinterval = 2;
            else;
                axesinterval = 5;
            end;

            spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', 0, 'Races', nbRaces, ...
                'axetoplot', axesEC, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
                'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0.5, ...
                'color', [0 0 1], 'AxesFontSize', fontgraphaxe, 'markersize', markersize, ...
                'LabelFontSize', fontgraphlabel);

            gtitleskill(race) = title(axesEC, graphTitle, 'color', [1 1 1], 'Visible', 'on', 'FontName', 'Antiqua', ...
                'FontSize', fontsizetitle, 'FontWeight', 'Bold');
            postitle = get(gtitleskill(race), 'position');
            if nbRaces >= 2;
                postitle(2) = postitle(2) + (0.1*postitle(2));
            end;
            set(gtitleskill(race), 'position', postitle);
            
%             eval(['handles.axesskill' Kletter num2str(race) '_analyser = axesEC;']);
        end;
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
    axesEC = handles.axesskilloverlay_analyser;
    
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
        eval(['Course = handles.RacesDB.' UID '.Course;']);
        eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
        eval(['Gender = handles.RacesDB.' UID '.Gender;']);
        eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
        eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);

        if strcmpi(detailRelay, 'None');
            graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage];
        else;
            graphTitle = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage '-' detailRelay ' ' valRelay];
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

        if strcmpi(detailRelay, 'None')
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '                                                               '];
            graphTitle3 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
        else;
            graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' ' valRelay '                                  '];
            graphTitle3 = [Athletename ' ' MeetShort YearShort ' ' StageShort '-' detailRelay ' ' valRelay];
        end;
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
        eval(['BOEffCorr = handles.RacesDB.' UID '.BOEffCorr;']);
        BOEffStart = BOEff(1);
        BOEffTurn = BOEff(2:end);
        BOEffCorrStart = BOEffCorr(1);
        BOEffCorrTurn = BOEffCorr(2:end);
        eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
        eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
        eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
        eval(['TurnTime = handles.RacesDB.' UID '.Turn_Time;']);
        eval(['StartUWVelocity = handles.RacesDB.' UID '.StartUWVelocity;']);
        eval(['StartEntryDist = handles.RacesDB.' UID '.StartEntryDist;']);
        
        dataEC.StartRT = roundn(RT, -2);
        dataEC.StartKicks = KicksNb(1);
        dataEC.StartTime = roundn(DiveT15, -2);
        dataEC.StartBODist = roundn(BOAllDistance(1), -2);
        dataEC.StartBOEff = [roundn(VelBeforeBO(1),-2); roundn(VelAfterBO(1),-2)];
        dataEC.StartEntry = StartEntryDist;
        dataEC.StartUWS = StartUWVelocity;
        if NbLap > 1;
            liRace = find(selectrace == race);
            if isempty(liRace) == 0;
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
            liRace = find(selectrace == race);
            if isempty(liRace) == 0;
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

%     toolbar = axtoolbar(axesEC, 'default');
%     toolbar.Visible = 'on';
    DataToPlot = [];
    
    if NbLap == 1;
        for race = 1:nbRaces;
            DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ScoreSpider.LastApp(race,1)];
            DataToPlotEC(DataToPlotEC < 0) = 0;
            DataToPlotEC(DataToPlotEC > 10) = 10;

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
        spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', 0, 'Races', nbRaces, ...
            'axetoplot', axesEC, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
            'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0, ...
            'color', colorsinput(1:nbRaces,:), 'AxesFontSize', fontgraphaxe, 'markersize', markersize, ...
            'LabelFontSize', fontgraphlabel);

    elseif NbLap == 2;

        for race = 1:nbRaces;
            DataToPlotEC = [ScoreSpider.StartRT(race,1) ScoreSpider.StartFlyDist(race,1) ScoreSpider.StartUWS(race,1) ScoreSpider.StartBO(race,1) ...
                ScoreSpider.TurnApproachBest(race,1) ScoreSpider.TurnBOBest(race,1)];
            DataToPlotEC(DataToPlotEC < 0) = 0;
            DataToPlotEC(DataToPlotEC > 10) = 10;

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

        spider_plot(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', 0, 'Races', nbRaces, ...
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
        
        handles.DataToPlot_SkillOverlay = DataToPlot;
    end;
    
    gtitleskill = title(axesEC, 'Overlayed Comparison', 'color', [1 1 1], 'Visible', 'on', 'FontName', 'Antiqua', ...
        'FontSize', fontsizetitle, 'FontWeight', 'Bold');
    legGraph = legend(axesEC, storeTitle3, 'FontName', 'Antiqua', ...
        'FontAngle', 'italic', 'FontSize', 8, 'TextColor', [1 1 1]);
    set(legGraph, 'units', 'normalized');
    set(legGraph, 'position', [0.58 0.78 0.15 0.05]);   
    handles.legGraphskill = legGraph;
end;


if handles.CurrentstatusOverlayYes == 1;
    for race = 1:nbRaces;
        eval(['datapanel.R' num2str(race) ' = S' num2str(race) ';']);
    end;
elseif handles.CurrentstatusOverlayNo == 1;
    for raceTot = 1:length(listrace);
        race = listrace(raceTot);
        eval(['datapanel.R' num2str(race) ' = S' num2str(race) ';']);
    end;
end;

set(handles.hf_w1_welcome, 'units', 'pixels');
posfig = get(handles.hf_w1_welcome, 'position');
set(handles.hf_w1_welcome, 'units', 'normalized');
if nbRaces == 8;
    pheightmin = (20./720).*posfig(4);
    pheightmax = (190./720).*posfig(4);
else;
    pheightmin = (20./720).*posfig(4);
    pheightmax = (205./720).*posfig(4);
end;

if strcmpi(origin, 'UpdateSkills');
    for raceTot = 1:length(listrace);
        race = listrace(raceTot);
        eval(['dataEC = datapanel.R' num2str(race) ';']);
        txtEC = timeSecToStr(dataEC.TurnTime);
        set(handles.UIskillpanel.txt_TimeVALturn{race}, 'String', txtEC);
        txtEC = [dataToStr(dataEC.TurnAppEff(1),2) ' / ' dataToStr(dataEC.TurnAppEff(2),2) ' m/s'];
        set(handles.UIskillpanel.txt_AppSkillVALturn{race}, 'String', txtEC);
        txtEC = [dataToStr(dataEC.TurnGlideWall(1),2) ' m / ' dataToStr(dataEC.TurnGlideWall(2),2) ' s'];
        set(handles.UIskillpanel.txt_GlideWallVALturn{race}, 'String', txtEC);
        txtEC = [dataToStr(dataEC.TurnKicks(1),0) ' Kicks'];
        set(handles.UIskillpanel.txt_UWKVALturn{race}, 'String', txtEC);
        txtEC = [dataToStr(dataEC.TurnBODist(1),1) ' m'];
        set(handles.UIskillpanel.txt_BODistVALturn{race}, 'String', txtEC);
        txtEC = [dataToStr(dataEC.TurnBOEff(1),2) ' / ' dataToStr(dataEC.TurnBOEff(2),2) ' m/s'];
        set(handles.UIskillpanel.txt_BOSkillVALturn{race}, 'String', txtEC);
        set(handles.boxpanel_analyser, 'Visible', 'on');
    end;
else;
    set(handles.axesgraph2_analyser, 'units', 'pixels');
    posBox = get(handles.axesgraph2_analyser, 'Position');
    [box, UIskillpanel] = create_skilldatapanel(posBox, datapanel, pheightmin, pheightmax, storeTitle2, NbLap, handles.hf_w1_welcome);
    handles.boxpanel_analyser = box;
    handles.UIskillpanel = UIskillpanel;
    set(box, 'Visible', 'on', 'units', 'normalized');
end;
% clc;


%     waitbar(0.99, hwait, ['Rendering... 99%']);
if handles.CurrentstatusOverlayNo == 1;
    if nbRaces == 1;
        set(handles.axesskillA1_analyser, 'Visible', 'on');
    elseif nbRaces == 2;
        set(handles.axesskillB1_analyser, 'Visible', 'on');
        set(handles.axesskillB2_analyser, 'Visible', 'on');
    elseif nbRaces == 3;
        set(handles.axesskillC1_analyser, 'Visible', 'on');
        set(handles.axesskillC2_analyser, 'Visible', 'on');
        set(handles.axesskillC3_analyser, 'Visible', 'on');
    elseif nbRaces == 4;
        set(handles.axesskillD1_analyser, 'Visible', 'on');
        set(handles.axesskillD2_analyser, 'Visible', 'on');
        set(handles.axesskillD3_analyser, 'Visible', 'on');
        set(handles.axesskillD4_analyser, 'Visible', 'on');
    elseif nbRaces == 5;
        set(handles.axesskillE1_analyser, 'Visible', 'on');
        set(handles.axesskillE2_analyser, 'Visible', 'on');
        set(handles.axesskillE3_analyser, 'Visible', 'on');
        set(handles.axesskillE4_analyser, 'Visible', 'on');
        set(handles.axesskillE5_analyser, 'Visible', 'on');
    elseif nbRaces == 6;
        set(handles.axesskillF1_analyser, 'Visible', 'on');
        set(handles.axesskillF2_analyser, 'Visible', 'on');
        set(handles.axesskillF3_analyser, 'Visible', 'on');
        set(handles.axesskillF4_analyser, 'Visible', 'on');
        set(handles.axesskillF5_analyser, 'Visible', 'on');
        set(handles.axesskillF6_analyser, 'Visible', 'on');
    elseif nbRaces == 7;
        set(handles.axesskillG1_analyser, 'Visible', 'on');
        set(handles.axesskillG2_analyser, 'Visible', 'on');
        set(handles.axesskillG3_analyser, 'Visible', 'on');
        set(handles.axesskillG4_analyser, 'Visible', 'on');
        set(handles.axesskillG5_analyser, 'Visible', 'on');
        set(handles.axesskillG6_analyser, 'Visible', 'on');
        set(handles.axesskillG7_analyser, 'Visible', 'on');
    elseif nbRaces == 8;
        set(handles.axesskillH1_analyser, 'Visible', 'on');
        set(handles.axesskillH2_analyser, 'Visible', 'on');
        set(handles.axesskillH3_analyser, 'Visible', 'on');
        set(handles.axesskillH4_analyser, 'Visible', 'on');
        set(handles.axesskillH5_analyser, 'Visible', 'on');
        set(handles.axesskillH6_analyser, 'Visible', 'on');
        set(handles.axesskillH7_analyser, 'Visible', 'on');
        set(handles.axesskillH8_analyser, 'Visible', 'on');
    end;
end;

if handles.CurrentstatusOverlayYes == 1;
    set(handles.axesskilloverlay_analyser, 'Visible', 'on');
end;

handles.axesGraphSkill_Titles = gtitleskill;

handles.listgraphraceselect = [];
if nbRaces == 1;
    handles.listgraphraceselect = storeTitle;
    statusRace = 'off';
else;
    handles.listgraphraceselect{1} = 'All';
    for race = 1:nbRaces;
        handles.listgraphraceselect{race+1} = storeTitle{race};
    end;
    statusRace = 'on';
end;

handles.listgraphturnselect = [];
if NbLap == 1;
    handles.listgraphturnselect = 'None';
    statusTurn = 'off';
elseif NbLap == 2;
    handles.listgraphturnselect{1} = 'Turn 1';
    statusTurn = 'off';
else;
    handles.listgraphturnselect{1} = 'Average';
    for lap = 2:NbLap;
        handles.listgraphturnselect{lap} = ['Turn ' num2str(lap-1)];
    end;
    statusTurn = 'on';
end;


set(handles.selectrace_pop_analyser, 'String', handles.listgraphraceselect, 'enable', statusRace);
set(handles.selectturn_pop_analyser, 'String', handles.listgraphturnselect, 'enable', statusTurn);
nbRaces = length(handles.filelistAdded);


% set(handles.selectrace_pop_analyser, 'String', handles.listgraphraceselect, 'enable', statusRace, 'value', 1);
% set(handles.selectturn_pop_analyser, 'String', handles.listgraphturnselect, 'enable', statusTurn, 'value', 1);
% handles.CurrentvalueTurn = 1;
% handles.CurrentvalueRace = 1;
% scoreN = roundn((race+1)/(nbRaces+2),-2);
% scoreT = roundn((race+1)/(nbRaces+2)*100,0);
% waitbar(scoreN, hwait, ['Rendering...  ' num2str(scoreT) '%']);
% 
% handles.output = hObject;
% guidata(hObject, handles);