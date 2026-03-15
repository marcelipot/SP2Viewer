function [] = flucVelToggle_analyser(varargin);


handles = guidata(gcf);


%---Remove tooltip
% handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
% drawnow;


origin = 'Velocity';
delete_allaxes_analyser;
handles.VelGraphAct = 3;

set(handles.panelgraph_pacing_analyser, 'Visible', 'off');
set(handles.txtdata_analyser, 'Visible', 'off');
set(handles.DPS_check_analyser, 'Visible', 'off');
set(handles.SR_check_analyser, 'Visible', 'off');
set(handles.Breath_check_analyser, 'Visible', 'off');
set(handles.Splits_check_analyser, 'Visible', 'off');
set(handles.txtxaxis_analyser, 'Visible', 'off');
set(handles.Distance_check_analyser, 'Visible', 'off');
set(handles.Time_check_analyser, 'Visible', 'off');
set(handles.Smooth_check_analyser, 'Visible', 'off');
set(handles.panelzoom_pacing_analyser, 'Visible', 'off');

set(handles.txtmin_analyser, 'Visible', 'off');
set(handles.txtmax_analyser, 'Visible', 'off');
set(handles.txtxaxiszoom_analyser, 'Visible', 'off');
set(handles.txtDPSaxiszoom_analyser, 'Visible', 'off');
set(handles.txtSRaxiszoom_analyser, 'Visible', 'off');
set(handles.Edit_Xmin_analyser, 'Visible', 'off');
set(handles.Edit_YLeftmin_analyser, 'Visible', 'off');
set(handles.Edit_YRightmin_analyser, 'Visible', 'off');
set(handles.Edit_Xmax_analyser, 'Visible', 'off');
set(handles.Edit_YLeftmax_analyser, 'Visible', 'off');
set(handles.Edit_YRightmax_analyser, 'Visible', 'off');
set(handles.zoom_reset_analyser, 'Visible', 'off');

set(handles.displaypanel_distribution_analyser, 'Visible', 'off');
set(handles.displaypanel_fluctuation_analyser, 'Visible', 'on');



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


NbLapTOT = [];
for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    try;
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    catch;
        eval(['NbLap = handles.RacesDB.' UID '.nbLap;']);
    end;
    NbLapTOT = [NbLapTOT NbLap];
end;
NbLapTOT = sum(NbLapTOT) + nbRaces;
lapTOTEC = 1;


maxXaxeTOT = 0;
minYaxeTOT = 100000;
maxYaxeTOT = 0;
for race = 1:nbRaces;
    
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];


    FigPos = handles.FigPos;
    offsetLeftXtitle = 185./FigPos(3);
    offsetBottomXtitle = 5./FigPos(4);
    widthXtitle = 855./FigPos(3);
    heightXtitle = 20./FigPos(4);
    offsetLeftColBar = 195./FigPos(3);
    widthColBar = 835./FigPos(3);

    if nbRaces == 1;
        offsetbottom = handles.GraphPosA1(2).*720;
        TopPointY = handles.GraphPosA1(4).*720;
        
        offsetleftA = 185./FigPos(3);
        widthA = 20./FigPos(3);
        offsetleftB = 1035./FigPos(3);
        widthB = 20./FigPos(3);
        
        offsetBottomColBar = 615./FigPos(4);
        heightColBar = 20./FigPos(4);
        fontsizecolbar = 12;
        fontsizesplits = 12;
        
    elseif nbRaces == 2;
        if race == 1;
            offsetbottom = handles.GraphPosB2(2).*720;

            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosB1(2).*720)+(handles.GraphPosB1(4).*720);
        end;
        
        offsetBottomColBar = 615./FigPos(4);
        heightColBar = 20./FigPos(4);
        fontsizecolbar = 12;
        fontsizesplits = 12;
        
    elseif nbRaces == 3;
        if race == 1;
            offsetbottom = handles.GraphPosC3(2).*720;
            
            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosC1(2).*720)+(handles.GraphPosC1(4).*720);
        end;
        
        offsetBottomColBar = 615./FigPos(4);
        heightColBar = 18./FigPos(4);
        fontsizecolbar = 11;
        fontsizesplits = 10;
        
    elseif nbRaces == 4;
        if race == 1;
            offsetbottom = handles.GraphPosD4(2).*720;
            
            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosD1(2).*720)+(handles.GraphPosD1(4).*720);
        end;
        
        offsetBottomColBar = 615./FigPos(4);
        heightColBar = 15./FigPos(4);
        fontsizecolbar = 11;
        fontsizesplits = 9;
        
    elseif nbRaces == 5;
        if race == 1;
            offsetbottom = handles.GraphPosE5(2).*720;
            
            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosE1(2).*720)+(handles.GraphPosE1(4).*720);
        end;
        
        offsetBottomColBar = 615./FigPos(4);
        heightColBar = 12./FigPos(4);
        fontsizecolbar = 10;
        fontsizesplits = 9;
        
    elseif nbRaces == 6;
        if race == 1;
            offsetbottom = handles.GraphPosF6(2).*720;
            
            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosF1(2).*720)+(handles.GraphPosF1(4).*720);
        end;
        
        offsetBottomColBar = 630./FigPos(4);
        heightColBar = 10./FigPos(4);
        fontsizecolbar = 9;
        fontsizesplits = 9;
        
    elseif nbRaces == 7;
        if race == 1;
            offsetbottom = handles.GraphPosG7(2).*720;
            
            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosG1(2).*720)+(handles.GraphPosG1(4).*720);
        end;
        
        offsetBottomColBar = 630./FigPos(4);
        heightColBar = 10./FigPos(4);
        fontsizecolbar = 9;
        fontsizesplits = 9;
        
    elseif nbRaces == 8;
        if race == 1;
            offsetbottom = handles.GraphPosH8(2).*720;
            
            offsetleftA = 185./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1035./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (handles.GraphPosH1(2).*720)+(handles.GraphPosH1(4).*720);
        end;
        
        offsetBottomColBar = 630./FigPos(4);
        heightColBar = 10./FigPos(4);
        fontsizecolbar = 9;
        fontsizesplits = 9;
    end;

    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Stroke_Velocity = handles.RacesDB.' UID '.Stroke_Velocity;']);
    eval(['Stroke_VelocityMin = handles.RacesDB.' UID '.Stroke_VelocityMin;']);
    eval(['Stroke_VelocityMax = handles.RacesDB.' UID '.Stroke_VelocityMax;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    
    
    nLap = length(Stroke_VelocityMin(:,1));
    if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
        %remove first 2 and last 2 strokes
        for lapEC = 1:nLap;
            index = find(Stroke_VelocityMin(lapEC,:) ~= 0);
            if rem(length(index), 2) == 1;
                %odd count of stroke (remove 3 strokes)
                remStroke = 2;
            else;
                remStroke = 1;
            end;

            Stroke_Frame(lapEC, 1:2) = 0;
            Stroke_Frame(lapEC, index(end)-remStroke+1:index(end)+1) = 0;

            Stroke_VelocityMin(lapEC, 1:2) = 0;
            Stroke_VelocityMin(lapEC, index(end)-remStroke:index(end)) = 0;
    
            Stroke_VelocityMax(lapEC, 1:2) = 0;
            Stroke_VelocityMax(lapEC, index(end)-remStroke:index(end)) = 0;
    
            Stroke_Velocity(lapEC, 1:2) = 0;
            Stroke_Velocity(lapEC, index(end)-remStroke:index(end)) = 0;
        end;
    
        %calculate value per cycle rather than per stroke
        Cycle_Frame = [];
        Cycle_VelocityMin = [];
        Cycle_VelocityMax = [];
        Cycle_Velocity = [];
        for lapEC = 1:nLap;

            Stroke_VelocityMinLap = Stroke_VelocityMin(lapEC,:);
            index = find(Stroke_VelocityMinLap == 0);
            Stroke_VelocityMinLap(index) = [];

            Stroke_VelocityMaxLap = Stroke_VelocityMax(lapEC,:);
            index = find(Stroke_VelocityMaxLap == 0);
            Stroke_VelocityMaxLap(index) = [];
            
            Stroke_VelocityLap = Stroke_Velocity(lapEC,:);
            index = find(Stroke_VelocityLap == 0);
            Stroke_VelocityLap(index) = [];
            
            Stroke_FrameLap = Stroke_Frame(lapEC,:);
            index = find(Stroke_FrameLap == 0);
            Stroke_FrameLap(index) = [];
            Cycle_Frame(lapEC,1) = Stroke_FrameLap(1);

            if isempty(Stroke_VelocityMinLap) == 1
                nbStroke = 0;
            else;
                nbStroke = length(Stroke_VelocityMinLap ~= 0);
            end;
            iter = 1;
            if nbStroke > 1;
                for strokeEC = 1:2:nbStroke;
                    if Stroke_VelocityMinLap(1,strokeEC) ~= 0;
                        Cycle_Frame(lapEC,iter+1) = Stroke_FrameLap(1, strokeEC+2);
                        Cycle_VelocityMin(lapEC,iter) = min(Stroke_VelocityMinLap(1,strokeEC:strokeEC+1));
                        Cycle_VelocityMax(lapEC,iter) = max(Stroke_VelocityMaxLap(1,strokeEC:strokeEC+1));
                        Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityLap(1,strokeEC:strokeEC+1));
                        iter = iter + 1;
                    end;
                end;
                index = find(Cycle_VelocityMin(lapEC,:) ~= 0);
                dataMin = Cycle_VelocityMin(lapEC,index);
                index = find(Cycle_VelocityMax(lapEC,:) ~= 0);
                dataMax = Cycle_VelocityMax(lapEC,index);
            
                currentMin = min(dataMin);
                currentMax = max(dataMax);
                if currentMin < minYaxeTOT;
                    minYaxeTOT = currentMin;
                end;
                if currentMax > maxYaxeTOT;
                    maxYaxeTOT = currentMax;
                end;
            else;
                Cycle_Frame(lapEC,1) = NaN;
                Cycle_VelocityMin(lapEC,1) = NaN;
                Cycle_VelocityMax(lapEC,1) = NaN;
                Cycle_Velocity(lapEC,1) = NaN;
            end;
        end;

    elseif strcmpi(lower(StrokeType), 'butterfly') | strcmpi(lower(StrokeType), 'breaststroke');
        %remove first and last strokes
        for lapEC = 1:nLap;
            index = find(Stroke_VelocityMin(lapEC,:) ~= 0);
    
            Stroke_Frame(lapEC, 1) = 0;
            Stroke_Frame(lapEC, index(end):index(end)+1) = 0;

            Stroke_VelocityMin(lapEC, 1) = 0;
            Stroke_VelocityMin(lapEC, index(end)-1:index(end)) = 0;
    
            Stroke_VelocityMax(lapEC, 1) = 0;
            Stroke_VelocityMax(lapEC, index(end)-1:index(end)) = 0;
    
            Stroke_Velocity(lapEC, 1) = 0;
            Stroke_Velocity(lapEC, index(end)-1:index(end)) = 0;
        end;

        %calculate value per cycle rather than per stroke (just remove the
        %0)
        Cycle_Frame = [];
        Cycle_VelocityMin = [];
        Cycle_VelocityMax = [];
        Cycle_Velocity = [];
        for lapEC = 1:nLap;
            Stroke_VelocityMinLap = Stroke_VelocityMin(lapEC,:);

            index = find(Stroke_VelocityMinLap == 0);
            Stroke_VelocityMinLap(index) = [];

            Stroke_VelocityMaxLap = Stroke_VelocityMax(lapEC,:);
            index = find(Stroke_VelocityMaxLap == 0);
            Stroke_VelocityMaxLap(index) = [];
            
            Stroke_VelocityLap = Stroke_Velocity(lapEC,:);
            index = find(Stroke_VelocityLap == 0);
            Stroke_VelocityLap(index) = [];
            
            Stroke_FrameLap = Stroke_Frame(lapEC,:);
            index = find(Stroke_FrameLap == 0);
            Stroke_FrameLap(index) = [];
            Cycle_Frame(lapEC,1) = Stroke_FrameLap(1);

            if isempty(Stroke_VelocityMinLap) == 1
                nbStroke = 0;
            else;
                nbStroke = length(Stroke_VelocityMinLap ~= 0);
            end;
            iter = 1;
            if nbStroke > 1;
                for strokeEC = 1:nbStroke;
                    if Stroke_VelocityMin(lapEC,strokeEC) ~= 0;
                        Cycle_Frame(lapEC,iter+1) = Stroke_FrameLap(1, strokeEC+1);
                        Cycle_VelocityMin(lapEC,iter) = Stroke_VelocityMin(lapEC,strokeEC);
                        Cycle_VelocityMax(lapEC,iter) = Stroke_VelocityMax(lapEC,strokeEC);
                        Cycle_Velocity(lapEC,iter) = Stroke_Velocity(lapEC,strokeEC);
                        iter = iter + 1;
                    end;
                end;
                index = find(Cycle_VelocityMin(lapEC,:) ~= 0);
                dataMin = Cycle_VelocityMin(lapEC,index);
                index = find(Cycle_VelocityMax(lapEC,:) ~= 0);
                dataMax = Cycle_VelocityMax(lapEC,index);
            
                currentMin = min(dataMin);
                currentMax = max(dataMax);
                if currentMin < minYaxeTOT;
                    minYaxeTOT = currentMin;
                end;
                if currentMax > maxYaxeTOT;
                    maxYaxeTOT = currentMax;
                end;
    
                currentCycle = length(dataMax);
                if currentCycle > maxXaxeTOT;
                    maxXaxeTOT = currentCycle;
                end;
            else
                Cycle_Frame(lapEC,1) = NaN;
                Cycle_VelocityMin(lapEC,1) = NaN;
                Cycle_VelocityMax(lapEC,1) = NaN;
                Cycle_Velocity(lapEC,1) = NaN;
            end;
        end;
    else;
        caseStroke = [];
        for lapEC = 1:nLap;
            if Course == 50;
                if RaceDist == 150;
                    if lapEC == 1 | lapEC == 3;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 2;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                elseif RaceDist == 200;
                    if lapEC == 1 | lapEC == 3;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 2 | lapEC == 4;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                elseif RaceDist == 400;
                    if lapEC == 1 | lapEC == 2 | lapEC == 5 | lapEC == 6;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 3 | lapEC == 4 | lapEC == 7 | lapEC == 8;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                end;
            elseif Course == 25;
                if RaceDist == 100;
                    if lapEC == 1 | lapEC == 3;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 2 | lapEC == 4;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                elseif RaceDist == 150;
                    if lapEC == 1 | lapEC == 2 | lapEC == 5 | lapEC == 6;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 3 | lapEC == 4;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                elseif RaceDist == 200;
                    if lapEC == 1 | lapEC == 2 | lapEC == 5 | lapEC == 6;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 3 | lapEC == 4 | lapEC == 7 | lapEC == 8;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                elseif RaceDist == 400;
                    if lapEC == 1 | lapEC == 2 | lapEC == 3 | lapEC == 4 | lapEC == 9 | lapEC == 10 | lapEC == 11 | lapEC == 12;
                        %BF and BR
                        caseStroke(lapEC) = 1;
                    elseif lapEC == 5 | lapEC == 6 | lapEC == 7 | lapEC == 8 | lapEC == 13 | lapEC == 14 | lapEC == 15 | lapEC == 16;
                        %BK and FS
                        caseStroke(lapEC) = 2;
                    end;
                end;
            end;
        end;

        for lapEC = 1:nLap;
            if caseStroke(lapEC) == 1;
                %remove first and last strokes
                index = find(Stroke_VelocityMin(lapEC,:) ~= 0);
        
                Stroke_Frame(lapEC, 1) = 0;
                Stroke_Frame(lapEC, index(end):index(end)+1) = 0;
    
                Stroke_VelocityMin(lapEC, 1) = 0;
                Stroke_VelocityMin(lapEC, index(end)-1:index(end)) = 0;
        
                Stroke_VelocityMax(lapEC, 1) = 0;
                Stroke_VelocityMax(lapEC, index(end)-1:index(end)) = 0;
        
                Stroke_Velocity(lapEC, 1) = 0;
                Stroke_Velocity(lapEC, index(end)-1:index(end)) = 0;
            else;
                %remove first 2 and last 2 strokes
                index = find(Stroke_VelocityMin(lapEC,:) ~= 0);
                if rem(length(index), 2) == 1;
                    %odd count of stroke (remove 3 strokes)
                    remStroke = 2;
                else;
                    remStroke = 1;
                end;
    
                Stroke_Frame(lapEC, 1:2) = 0;
                Stroke_Frame(lapEC, index(end)-remStroke+1:index(end)+1) = 0;
    
                Stroke_VelocityMin(lapEC, 1:2) = 0;
                Stroke_VelocityMin(lapEC, index(end)-remStroke:index(end)) = 0;
        
                Stroke_VelocityMax(lapEC, 1:2) = 0;
                Stroke_VelocityMax(lapEC, index(end)-remStroke:index(end)) = 0;
        
                Stroke_Velocity(lapEC, 1:2) = 0;
                Stroke_Velocity(lapEC, index(end)-remStroke:index(end)) = 0;
            end;
        end;

        
        Cycle_Frame = [];
        Cycle_VelocityMin = [];
        Cycle_VelocityMax = [];
        Cycle_Velocity = [];
        for lapEC = 1:nLap;
            if caseStroke(lapEC) == 1;
                %calculate value per cycle rather than per stroke (just remove the
                %0)
                Stroke_VelocityMinLap = Stroke_VelocityMin(lapEC,:);
                index = find(Stroke_VelocityMinLap == 0);
                Stroke_VelocityMinLap(index) = [];
    
                Stroke_VelocityMaxLap = Stroke_VelocityMax(lapEC,:);
                index = find(Stroke_VelocityMaxLap == 0);
                Stroke_VelocityMaxLap(index) = [];
                
                Stroke_VelocityLap = Stroke_Velocity(lapEC,:);
                index = find(Stroke_VelocityLap == 0);
                Stroke_VelocityLap(index) = [];
                
                Stroke_FrameLap = Stroke_Frame(lapEC,:);
                index = find(Stroke_FrameLap == 0);
                Stroke_FrameLap(index) = [];
                Cycle_Frame(lapEC,1) = Stroke_FrameLap(1);
    
                if isempty(Stroke_VelocityMinLap) == 1
                    nbStroke = 0;
                else;
                    nbStroke = length(Stroke_VelocityMinLap ~= 0);
                end;
                iter = 1;

                if nbStroke > 1;
                    for strokeEC = 1:nbStroke;
                        if Stroke_VelocityMin(lapEC,strokeEC) ~= 0;
                            Cycle_Frame(lapEC,iter+1) = Stroke_FrameLap(1, strokeEC+1);
                            Cycle_VelocityMin(lapEC,iter) = Stroke_VelocityMin(lapEC,strokeEC);
                            Cycle_VelocityMax(lapEC,iter) = Stroke_VelocityMax(lapEC,strokeEC);
                            Cycle_Velocity(lapEC,iter) = Stroke_Velocity(lapEC,strokeEC);
                            iter = iter + 1;
                        end;
                    end;
                    index = find(Cycle_VelocityMin(lapEC,:) ~= 0);
                    dataMin = Cycle_VelocityMin(lapEC,index);
                    index = find(Cycle_VelocityMax(lapEC,:) ~= 0);
                    dataMax = Cycle_VelocityMax(lapEC,index);
                
                    currentMin = min(dataMin);
                    currentMax = max(dataMax);
                    if currentMin < minYaxeTOT;
                        minYaxeTOT = currentMin;
                    end;
                    if currentMax > maxYaxeTOT;
                        maxYaxeTOT = currentMax;
                    end;
        
                    currentCycle = length(dataMax);
                    if currentCycle > maxXaxeTOT;
                        maxXaxeTOT = currentCycle;
                    end;
                else
                    Cycle_Frame(lapEC,1) = NaN;
                    Cycle_VelocityMin(lapEC,1) = NaN;
                    Cycle_VelocityMax(lapEC,1) = NaN;
                    Cycle_Velocity(lapEC,1) = NaN;
                end;
            else;
                %calculate value per cycle rather than per stroke
                Stroke_VelocityMinLap = Stroke_VelocityMin(lapEC,:);
                index = find(Stroke_VelocityMinLap == 0);
                Stroke_VelocityMinLap(index) = [];
    
                Stroke_VelocityMaxLap = Stroke_VelocityMax(lapEC,:);
                index = find(Stroke_VelocityMaxLap == 0);
                Stroke_VelocityMaxLap(index) = [];
                
                Stroke_VelocityLap = Stroke_Velocity(lapEC,:);
                index = find(Stroke_VelocityLap == 0);
                Stroke_VelocityLap(index) = [];
                
                Stroke_FrameLap = Stroke_Frame(lapEC,:);
                index = find(Stroke_FrameLap == 0);
                Stroke_FrameLap(index) = [];
                Cycle_Frame(lapEC,1) = Stroke_FrameLap(1);
    
                if isempty(Stroke_VelocityMinLap) == 1
                    nbStroke = 0;
                else;
                    nbStroke = length(Stroke_VelocityMinLap ~= 0);
                end;
                iter = 1;
                if nbStroke > 1;
                    for strokeEC = 1:2:nbStroke;
                        if Stroke_VelocityMinLap(1,strokeEC) ~= 0;
                            Cycle_Frame(lapEC,iter+1) = Stroke_FrameLap(1, strokeEC+2);
                            Cycle_VelocityMin(lapEC,iter) = min(Stroke_VelocityMinLap(1,strokeEC:strokeEC+1));
                            Cycle_VelocityMax(lapEC,iter) = max(Stroke_VelocityMaxLap(1,strokeEC:strokeEC+1));
                            Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityLap(1,strokeEC:strokeEC+1));
                            iter = iter + 1;
                        end;
                    end;
        
                    index = find(Cycle_VelocityMin(lapEC,:) ~= 0);
                    dataMin = Cycle_VelocityMin(lapEC,index);
                    index = find(Cycle_VelocityMax(lapEC,:) ~= 0);
                    dataMax = Cycle_VelocityMax(lapEC,index);
                
                    currentMin = min(dataMin);
                    currentMax = max(dataMax);
                    if currentMin < minYaxeTOT;
                        minYaxeTOT = currentMin;
                    end;
                    if currentMax > maxYaxeTOT;
                        maxYaxeTOT = currentMax;
                    end;
                else;
                    Cycle_Frame(lapEC,1) = NaN;
                    Cycle_VelocityMin(lapEC,1) = NaN;
                    Cycle_VelocityMax(lapEC,1) = NaN;
                    Cycle_Velocity(lapEC,1) = NaN;
                end;
            end;
        end;
    end;

    eval(['dataRace' num2str(race) '.Cycle_Frame = Cycle_Frame;']);
    eval(['dataRace' num2str(race) '.Cycle_VelocityMin = Cycle_VelocityMin;']);
    eval(['dataRace' num2str(race) '.Cycle_VelocityMax = Cycle_VelocityMax;']);
    eval(['dataRace' num2str(race) '.Cycle_Velocity = Cycle_Velocity;']);
end;
minYaxeTOT = roundn(minYaxeTOT, -2);
maxYaxeTOT = roundn(maxYaxeTOT, -2);
yminVelAxe = roundn(minYaxeTOT - 0.05*minYaxeTOT, -2);
ymaxVelAxe = roundn(maxYaxeTOT + 0.05*maxYaxeTOT, -2);


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
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
    eval(['Breath_Frames = handles.RacesDB.' UID '.Breath_Frames;']);

    eval(['Cycle_Frame = dataRace' num2str(race) '.Cycle_Frame;']);
    eval(['Cycle_VelocityMin = dataRace' num2str(race) '.Cycle_VelocityMin;']);
    eval(['Cycle_VelocityMax = dataRace' num2str(race) '.Cycle_VelocityMax;']);
    eval(['Cycle_Velocity = dataRace' num2str(race) '.Cycle_Velocity;']);

    dispOptionAvVel = handles.FlucDispOtionAvVel_analyser;
    dispOptionMaxVel = handles.FlucDispOtionMaxVel_analyser;
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

    eval(['posEC = handles.GraphPos' letter num2str(race) ';']);
    posEC(1) = posEC(1)+0.005;
    posEC(3) = posEC(3)+0.03;

    axesflucVelEC_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
        'Position', posEC, 'Visible', 'off');
    if ispc == 1;
        toolbar = axtoolbar(axesflucVelEC_analyser, 'datacursor');
    end;
    hold on;
    %----


    %---Add red lines for each cycle (removing first and last of each lap)
    iter = 1;
    ymaxVel = 0;
    yminVel = 100000;
    
    if dispOptionMaxVel == 1 | dispOptionMaxVel == 3;
        visibleOption = 'on';
    else;
        visibleOption = 'off';
    end;
    
    for lapEC = 1:nLap;
        
        %add first cycle that I removed (just for display)
        midwhite = minYaxeTOT+((maxYaxeTOT-minYaxeTOT)/2);
        topwhite = midwhite + ((maxYaxeTOT-minYaxeTOT)/10);
        bottomwhite = midwhite - ((maxYaxeTOT-minYaxeTOT)/10);
        emptyIterStroke = [emptyIterStroke iter];
        if Source == 2;
            line(axesflucVelEC_analyser, [iter iter], [bottomwhite topwhite], 'Color', [1 1 1], 'Linestyle', ':', 'Visible', visibleOption);
        end;

        iter = iter + 1;
        for ptEC = 1:length(Cycle_VelocityMin(lapEC,:));
            ptECmin = Cycle_VelocityMin(lapEC,ptEC);
            ptECmax = Cycle_VelocityMax(lapEC,ptEC);
            if ptECmin ~= 0;
                if Source == 2;
                    line(axesflucVelEC_analyser, [iter iter], [ptECmin ptECmax], 'Color', [1 0 0], 'Linestyle', '--', 'Visible', visibleOption);
                end;
                iter = iter + 1;                    
            end;
        end;

        %add last cycle that I removed (just for display)
        emptyIterStroke = [emptyIterStroke iter];
        line(axesflucVelEC_analyser, [iter iter], [bottomwhite topwhite], 'Color', [1 1 1], 'Linestyle', ':', 'Visible', visibleOption);

        iter = iter + 1;
    end;
    %----


    %---Create a dot for the mean for each cycle
    iter = 1;
    if dispOptionAvVel == 1 | dispOptionAvVel == 3;
        visibleOption = 'on';
    else;
        visibleOption = 'off';
    end;
    for lapEC = 1:nLap;
        countemptyStroke = 0;
        for ptEC = 1:length(Cycle_Velocity(lapEC,:))+2;
            ptEC = ptEC - countemptyStroke;
            if ptEC > length(Cycle_Velocity(1,:));
                ptECmean = 0;
            else;
                ptECmean = Cycle_Velocity(lapEC,ptEC);
            end;
            if ptECmean ~= 0;
                if isempty(find(emptyIterStroke == iter)) == 1;
                    frameLimInf = Cycle_Frame(lapEC,ptEC);
                    frameLimSup = Cycle_Frame(lapEC,ptEC+1);
                    index = find(Breath_Frames >= frameLimInf & Breath_Frames < frameLimSup);
                    if isempty(index) == 1;
                        %no breath
                        plot(axesflucVelEC_analyser, iter, ptECmean, 'o', 'Color', [1 1 0], 'Visible', visibleOption);
                    else;
                        %Breath in the cycle
                        plot(axesflucVelEC_analyser, iter, ptECmean, 'o', 'Color', [0 1 1], 'Visible', visibleOption);
                    end;
                else;
                    countemptyStroke = countemptyStroke + 1;
                end;
                iter = iter + 1;
            end;
        end;
    end;
    %----


    %---Create bars for each laps and display splits
    nbCycleTot = [];
    for lapEC = 0:nLap;
        if lapEC ~= 0;
            nbCycle = length(find(Cycle_VelocityMin(lapEC,:) ~= 0)) + 2; %add 2 empty cycles per lap
            nbCycleTot = [nbCycleTot nbCycle];
        end;
    end;
    cycleIniAxe = 1;
    cycleEndAxe = nbCycleTot;
    nbCycleTot = [];
    for lapEC = 0:nLap;
        if lapEC == 0
            line(axesflucVelEC_analyser, [0.5 0.5], [yminVelAxe maxYaxeTOT], 'Color', [0.5 0.5 0.5], 'Linestyle', '-', 'LineWidth', 2);
        else;
            nbCycle = length(find(Cycle_VelocityMin(lapEC,:) ~= 0)) + 2; %add 2 empty cycles per lap
            nbCycleTot = [nbCycleTot nbCycle];
            line(axesflucVelEC_analyser, [sum(nbCycleTot)+0.5 sum(nbCycleTot)+0.5], [yminVelAxe maxYaxeTOT], 'Color', [0.5 0.5 0.5], 'Linestyle', '-', 'LineWidth', 2);
        end;

        if nbRaces <= 2;
            vertPos = 'bottom';
        elseif nbRaces > 2 & nbRaces <= 6;
            vertPos = 'middle';
        else;
            vertPos = 'top';
        end;
        if Course == 50;
            if RaceDist == 1500;
                if rem(lapEC,2) == 0;
                    %display only even lap (each 100)
                    if lapEC == 1;
                        valSplitLap = SplitsAll(lapEC+1,2);
                        valSplitCum = SplitsAll(lapEC+1,2);
                    elseif lapEC == 0;
            
                    else;
                        valSplitLap = SplitsAll(lapEC+1,2)-SplitsAll(lapEC-1,2);
                        valSplitCum = SplitsAll(lapEC+1,2);
                    end;
                    if lapEC ~= 0;
                        dispText{1} = [num2str(valSplitLap) ' s'];
                        dispText{2} = timeSecToStr(valSplitCum);
%                         if sum(nbCycleTot) >= cycleIniAxe & sum(nbCycleTot) <= cycleEndAxe;
                            text(axesflucVelEC_analyser, sum(nbCycleTot)+0.5, maxYaxeTOT, dispText, 'VerticalAlignment', vertPos, ...
                                'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 8, 'color', [1 1 1]);
%                         end;
                    end;
                end;
            else;
                if lapEC == 1;
                    valSplitLap = SplitsAll(lapEC+1,2);
                    valSplitCum = SplitsAll(lapEC+1,2);
                elseif lapEC == 0;
        
                else;
                    valSplitLap = SplitsAll(lapEC+1,2)-SplitsAll(lapEC,2);
                    valSplitCum = SplitsAll(lapEC+1,2);
                end;
                if lapEC ~= 0;
                    dispText{1} = [num2str(valSplitLap) ' s'];
                    dispText{2} = timeSecToStr(valSplitCum);
%                     if sum(nbCycleTot) >= cycleIniAxe & sum(nbCycleTot) <= cycleEndAxe;
                        text(axesflucVelEC_analyser, sum(nbCycleTot)+0.5, maxYaxeTOT, dispText, 'VerticalAlignment', vertPos, ...
                            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 8, 'color', [1 1 1]);
%                     end;
                end;
            end;
        else
            if RaceDist == 1500;
                keyLap = [4 8 12 16 20 24 28 32 36 40 44 48 52 56 60];
                if isempty(find(keyLap == lapEC)) == 0;
                    %display only even lap (each 100)
                    if lapEC == 1;
                        valSplitLap = SplitsAll(lapEC+1,2);
                        valSplitCum = SplitsAll(lapEC+1,2);
                    elseif lapEC == 0;
            
                    else;
                        valSplitLap = SplitsAll(lapEC+1,2)-SplitsAll(lapEC-3,2);
                        valSplitCum = SplitsAll(lapEC+1,2);
                    end;
                    if lapEC ~= 0;
                        dispText{1} = [num2str(valSplitLap) ' s'];
                        dispText{2} = timeSecToStr(valSplitCum);
%                         if sum(nbCycleTot) >= cycleIniAxe & sum(nbCycleTot) <= cycleEndAxe;
                            text(axesflucVelEC_analyser, sum(nbCycleTot)+0.5, maxYaxeTOT, dispText, 'VerticalAlignment', vertPos, ...
                                'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 8, 'color', [1 1 1]);
%                         end;
                    end;
                end;
            elseif RaceDist == 800;
                keyLap = [2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60];
                if isempty(find(keyLap == lapEC)) == 0;
                    %display only even lap (each 50)
                    if lapEC == 1;
                        valSplitLap = SplitsAll(lapEC+1,2);
                        valSplitCum = SplitsAll(lapEC+1,2);
                    elseif lapEC == 0;
            
                    else;
                        valSplitLap = SplitsAll(lapEC+1,2)-SplitsAll(lapEC-1,2);
                        valSplitCum = SplitsAll(lapEC+1,2);
                    end;
                    if lapEC ~= 0;
                        dispText{1} = [num2str(valSplitLap) ' s'];
                        dispText{2} = timeSecToStr(valSplitCum);
%                         if sum(nbCycleTot) >= cycleIniAxe & sum(nbCycleTot) <= cycleEndAxe;
                            text(axesflucVelEC_analyser, sum(nbCycleTot)+0.5, maxYaxeTOT, dispText, 'VerticalAlignment', vertPos, ...
                                'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 8, 'color', [1 1 1]);
%                         end;
                    end;
                end;
            else;
                if lapEC == 1;
                    valSplitLap = SplitsAll(lapEC+1,2);
                    valSplitCum = SplitsAll(lapEC+1,2);
                elseif lapEC == 0;
        
                else;
                    valSplitLap = SplitsAll(lapEC+1,2)-SplitsAll(lapEC,2);
                    valSplitCum = SplitsAll(lapEC+1,2);
                end;
                if lapEC ~= 0;
                    dispText{1} = [num2str(valSplitLap) ' s'];
                    dispText{2} = timeSecToStr(valSplitCum);
%                     if sum(nbCycleTot) >= cycleIniAxe & sum(nbCycleTot) <= cycleEndAxe;
                        text(axesflucVelEC_analyser, sum(nbCycleTot)+0.5, maxYaxeTOT, dispText, 'VerticalAlignment', vertPos, ...
                            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 8, 'color', [1 1 1]);
%                     end;
                end;
            end;
        end;
    end;
    %----


    %---Create trend lines per lap for min and max
    lineOrder = handles.Fluctrendlineorder_analyser;
    cycleIni = 2;
    cycleEnd = nbCycleTot(1)-1;

    if dispOptionMaxVel == 2 | dispOptionMaxVel == 3;
        visibleOption = 'on';
    else;
        visibleOption = 'off';
    end;
    for lapEC = 1:nLap;

        index = find(Cycle_VelocityMin(lapEC,:) ~= 0);
        dataMin = Cycle_VelocityMin(lapEC,index);
        index = find(Cycle_VelocityMax(lapEC,:) ~= 0);
        dataMax = Cycle_VelocityMax(lapEC,index);

        pMin = [];
        yValminFit = [];

        if isnan(dataMin) == 0 & length(dataMin) ~= 1;
            if length(dataMin) == lineOrder;
                pMin = polyfit(cycleIni:cycleEnd,dataMin,lineOrder-1);
            else;
                pMin = polyfit(cycleIni:cycleEnd,dataMin,lineOrder);
            end;
            yValminFit = polyval(pMin, cycleIni:cycleEnd);
            plot(axesflucVelEC_analyser, cycleIni:cycleEnd, yValminFit, 'b-', 'Visible', visibleOption);     
    
            pMax = [];
            yValmaxFit = [];
            if length(dataMax) == lineOrder;
                pMax = polyfit(cycleIni:cycleEnd,dataMax,lineOrder-1);
            else;
                pMax = polyfit(cycleIni:cycleEnd,dataMax,lineOrder);
            end;
            yValmaxFit = polyval(pMax, cycleIni:cycleEnd); 
            plot(axesflucVelEC_analyser, cycleIni:cycleEnd, yValmaxFit, 'b-', 'Visible', visibleOption);  
        end;

        cycleIni = cycleEnd+2;
        if lapEC ~= nLap;
            cycleEnd = cycleIni + nbCycleTot(lapEC+1) - 2;
        end;
        cycleIni = cycleIni+1;
    end;
    %----
    

    %---Create trend lines per lap for averages
    cycleIni = 2;
    cycleEnd = nbCycleTot(1)-1;

    if dispOptionAvVel == 2 | dispOptionAvVel == 3;
        visibleOption = 'on';
    else;
        visibleOption = 'off';
    end;
    for lapEC = 1:nLap;
        index = find(Cycle_Velocity(lapEC,:) ~= 0);
        dataAverage = Cycle_Velocity(lapEC,index);
        pAverage = [];
        yValaverageFit = [];

        if isnan(dataAverage) == 0 & length(dataAverage) ~= 1;
            if length(dataAverage) == lineOrder;
                pAverage = polyfit(cycleIni:cycleEnd,dataAverage,lineOrder-1);
            else;
                pAverage = polyfit(cycleIni:cycleEnd,dataAverage,lineOrder);
            end;
            yValaverageFit = polyval(pAverage, cycleIni:cycleEnd);
            plot(axesflucVelEC_analyser, cycleIni:cycleEnd, yValaverageFit, 'g-', 'Visible', visibleOption);     
        end;

        cycleIni = cycleEnd+2;
        if lapEC ~= nLap;
            cycleEnd = cycleIni + nbCycleTot(lapEC+1) - 2;
        end;
        cycleIni = cycleIni+1;
    end;
    %----


    %---Modify axes limits and labels
    cycleIniAxe = 1;
    cycleEndAxe = sum(nbCycleTot);

    xlim(axesflucVelEC_analyser, [cycleIniAxe-1 cycleEndAxe+0.5]);
    ylim(axesflucVelEC_analyser, [yminVelAxe ymaxVelAxe]);
    if RaceDist <= 200;
        stepX = 2;
    elseif RaceDist == 400;
        stepX = 5;
    elseif RaceDist == 800;
        stepX = 8;
    elseif RaceDist == 1500;
        stepX = 10;
    end;
    xtickVAL = 1:stepX:cycleEnd;
    for valEC = 1:length(xtickVAL);
        xtickTXT{valEC} = num2str(xtickVAL(valEC));
    end;

    if nbRaces == 1  | nbRaces == 2;
        nbSteps = 10;
    elseif nbRaces == 3 | nbRaces == 4;
        nbSteps = 8;
    elseif nbRaces == 5 | nbRaces == 6;
        nbSteps = 6;
    elseif nbRaces == 7 | nbRaces == 8;
        nbSteps = 4;
    end;
    stepY = roundn((maxYaxeTOT-minYaxeTOT)./nbSteps,-2);
    if stepY == 0;
        stepY = roundn((maxYaxeTOT-minYaxeTOT)./nbSteps,-3);
        if stepY == 0;
            stepY = roundn((maxYaxeTOT-minYaxeTOT)./nbSteps,-4);
            if stepY == 0;
                stepY = roundn((maxYaxeTOT-minYaxeTOT)./nbSteps,-5);
            end;
        end;
    end;
    ytickVAL = minYaxeTOT:stepY:maxYaxeTOT;
    for valEC = 1:length(ytickVAL);
        ytickTXT{valEC} = num2str(ytickVAL(valEC));
    end;

    set(axesflucVelEC_analyser, 'Visible', 'on', 'color', [0 0 0], ...
        'xcolor', [1 1 1], 'xtick', xtickVAL, 'xticklabel', xtickTXT, ...
        'ycolor', [1 1 1], 'ytick', ytickVAL, 'yticklabel', ytickTXT);
    %----


    %---Create graph title
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
    gtitflucVelEC = title(axesflucVelEC_analyser, str, ...
        'color', [1 1 1], 'Visible', 'on');

    hold off;
    %----


    %---Create main titles and legends
    if race == 1;
        %Create main axes titles
        axesXTitleflucVel = axes('parent', handles.hf_w1_welcome, 'Position', [offsetLeftXtitle, offsetBottomXtitle, widthXtitle, heightXtitle], 'units', 'Normalized', ...
            'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
            'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
        xlim(axesXTitleflucVel, [0 1]);
        ylim(axesXTitleflucVel, [0 1]);
        XTitle = text(0.5, 0.5, 'Cycles', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'parent', axesXTitleflucVel, 'visible', 'on');
        set(axesXTitleflucVel, 'units', 'Normalized');
        handles.axesXTitleflucVel = axesXTitleflucVel;
        
        axesYTitleflucVel = axes('parent', handles.hf_w1_welcome, 'Position', [offsetleftA, offsetbottom./FigPos(4), widthA, (TopPointY-offsetbottom)./FigPos(4)], 'units', 'Normalized', ...
            'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
            'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
        xlim(axesYTitleflucVel, [0 1]);
        ylim(axesYTitleflucVel, [0 1]);
        YTitle = text(0.5, 0.5, 'Speed (m/s)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'rotation', 90, 'parent', axesYTitleflucVel, 'visible', 'on');
        set(axesYTitleflucVel, 'units', 'Normalized');
        set(axesYTitleflucVel, 'visible', 'on');
        handles.axesYTitleflucVel = axesYTitleflucVel;

        %create top legend
        topAxePos = get(axesflucVelEC_analyser, 'position');
        leftPos = topAxePos(1)-0.03;
        bottomPos = (topAxePos(2)+topAxePos(4)) + 0.035;
        widthPos = topAxePos(3) + 0.04;
        if nbRaces == 1 | nbRaces == 2;
            heightPos = 0.1;
        elseif nbRaces == 3 | nbRaces == 4;
            heightPos = 0.085;
        elseif nbRaces == 5;
            heightPos = 0.06;
        elseif nbRaces == 6;
            heightPos = 0.05;
        elseif nbRaces == 7;
            heightPos = 0.065;
        elseif nbRaces == 8;
            heightPos = 0.055;
        end;
        axesLegendflucVel = axes('parent', handles.hf_w1_welcome, 'Position', [leftPos bottomPos widthPos heightPos], 'units', 'Normalized', ...
            'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
            'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
        xlim(axesLegendflucVel, [0 1]);
        ylim(axesLegendflucVel, [0 1]);

        hold on;
        text(0, 0.5, 'Legend:', 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        line(axesLegendflucVel, [0.1 0.1], [0.1 0.8], 'Color', [0.5 0.5 0.5], 'Linestyle', '-', 'LineWidth', 2);
        text(0.11, 0.5, {'Start/End';'Laps'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        line(axesLegendflucVel, [0.2 0.2], [0.1 0.8], 'Color', [1 0 0], 'Linestyle', '--');
        text(0.21, 0.5, {'Velocity range';'(per cycle)'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        line(axesLegendflucVel, [0.335 0.335], [0.1 0.8], 'Color', [1 1 1], 'Linestyle', ':');
        text(0.345, 0.5, {'Deleted cycle';'(first & last of each lap)'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        plot(axesLegendflucVel, 0.52, 0.5, 'o', 'Color', [1 1 0]);
        text(0.53, 0.5, {'Average Speed';'(No breath)'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        plot(axesLegendflucVel, 0.65, 0.5, 'o', 'Color', [0 1 1]);
        text(0.66, 0.5, {'Average Speed';'(Breath)'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        line(axesLegendflucVel, [0.8 0.8], [0.1 0.8], 'Color', [0 0 1], 'Linestyle', '-');
        text(0.81, 0.5, {'Speed trend lines';'(min & max)'}, 'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
            'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 9, 'color', [1 1 1], 'parent', axesLegendflucVel, 'visible', 'on');

        hold off;

        handles.axesLegendflucVel = axesLegendflucVel;
    end;
    %----
    

    %---Save data for deletion
    eval(['handles.axesflucVel' num2str(race) '_analyser = axesflucVelEC_analyser;']);
    eval(['handles.gtitflucVel' num2str(race) '_analyser = gtitflucVelEC;']);
    %----

end;

set(handles.displaylapfromEDIT_analyser, 'String', '1');
set(handles.displaylaptoEDIT_analyser, 'String', num2str(nLap));
% set(handles.trendorderPOP_analyser, 'Value', 1);
handles.FlucDisplayLapIni_analyser = 1;
handles.FlucDisplayLapEnd_analyser = nLap;
handles.FlucDisplaynLap_analyser = nLap;

guidata(handles.hf_w1_welcome, handles);    





