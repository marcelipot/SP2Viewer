
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


MaxLeft = 0;
MinLeft = 1000000;
MaxRight = 0;
MinRight = 1000000;
for race = 1:nbRaces;
    
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['graph1Pacing_maxYLeft = handles.RacesDB.' UID '.graph1Pacing_maxYLeft;']);
    eval(['graph1Pacing_minYLeft = handles.RacesDB.' UID '.graph1Pacing_minYLeft;']);
    eval(['graph1Pacing_maxYRight = handles.RacesDB.' UID '.graph1Pacing_maxYRight;']);
    eval(['graph1Pacing_minYRight = handles.RacesDB.' UID '.graph1Pacing_minYRight;']);
    
    if MaxLeft < graph1Pacing_maxYLeft;
        MaxLeft = graph1Pacing_maxYLeft;
    end;
    if MinLeft > graph1Pacing_minYLeft;
        MinLeft = graph1Pacing_minYLeft;
    end;
    if MaxRight < graph1Pacing_maxYRight;
        MaxRight = graph1Pacing_maxYRight;
    end;
    if MinRight > graph1Pacing_minYRight;
        MinRight = graph1Pacing_minYRight;
    end;
    
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
        
end;
graph1Pacing_maxYLeft = MaxLeft;
graph1Pacing_minYLeft = MinLeft;
graph1Pacing_maxYRight = MaxRight;
graph1Pacing_minYRight = MinRight;

RangeLeft = graph1Pacing_maxYLeft - graph1Pacing_minYLeft;
TickSpaceLeft = roundn((RangeLeft./5),-1);
if TickSpaceLeft == 0;
    TickSpaceLeft = roundn((RangeLeft./5),-2);
    if TickSpaceLeft == 0;
        TickSpaceLeft = roundn((RangeLeft./5),-3);
        if TickSpaceLeft == 0;
            TickSpaceLeft = roundn((RangeLeft./5),-4);
            if TickSpaceLeft == 0;
                TickSpaceLeft = roundn((RangeLeft./5),-5);
            end;
        end;
    end;
end;
RangeRight = graph1Pacing_maxYRight - graph1Pacing_minYRight;
TickSpaceRight = roundn((RangeRight./5),0);
if TickSpaceRight == 0;
    TickSpaceRight = 0.1;
end;

colormap(handles.hf_w1_welcome, 'parula');
colorrange = 'parula';
colorvalue = colormap(colorrange);

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
    
    eval(['Velocity = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['Time = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Distance = handles.RacesDB.' UID '.Stroke_Distance;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Breath_Frame = handles.RacesDB.' UID '.Breath_Frames;']);
    try;
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    catch;
        eval(['NbLap = handles.RacesDB.' UID '.nbLap;']);
    end;
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['LimGraphStroke = handles.RacesDB.' UID '.LimGraphStroke;']);
    eval(['LimGraphBreath = handles.RacesDB.' UID '.LimGraphBreath;']);
    eval(['axesGraphPacing = handles.RacesDB.' UID '.graph1PacingAxes;']);
    eval(['axesGraphlineMain = handles.RacesDB.' UID '.graph1_lineMain;']);
    eval(['axesGraphlineMainTrend = handles.RacesDB.' UID '.graph1_lineMainTrend;']);
    if isgraphics(axesGraphPacing) == 0;
%         filename = handles.fileSP2viewerDBpacing{race};
%         eval(['load(filename, ' '''' 'graph1PacingAxes' '''' ', ' '''' 'graph1_Distance' '''' ', ' '''' 'graph1_gtit' '''' ', ' '''' 'axescolbar' '''' ', ' '''' 'colbar' '''' ');']);
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            filenameDBout = [MDIR '\SP2viewer\RaceDB\Temp\' UID '.mat'];
        elseif ismac == 1;
            filenameDBout = ['/Applications/SP2Viewer/RaceDB/Temp/' UID '.mat'];
        end;
        eval(['load(filenameDBout, ' '''' 'graph1PacingAxes' '''' ', ' '''' 'graph1_Distance' '''' ', ' '''' 'graph1_gtit' '''' ', ' '''' 'axescolbar' '''' ', ' '''' 'colbar' '''' ');']);

        eval(['handles.RacesDB.' UID '.graph1PacingAxes = graph1PacingAxes;']);
        eval(['handles.RacesDB.' UID '.graph1PacingGraphDistance = graph1_Distance;']);
        GraphDistance = graph1_Distance;     
        eval(['handles.RacesDB.' UID '.graph1PacingTitle = graph1_gtit;']);
        eval(['handles.RacesDB.' UID '.graph1Pacingaxescolbar = axescolbar;']);
        eval(['handles.RacesDB.' UID '.graph1Pacingcolbar = colbar;']);
        axesGraphPacing = graph1PacingAxes;
        graph1PacingTitle = graph1_gtit;
    else;
        eval(['graph1PacingTitle = handles.RacesDB.' UID '.graph1PacingTitle;']);
        eval(['GraphDistance = handles.RacesDB.' UID '.graph1PacingGraphDistance;']);
    end;
    
    try;
        eval(['SplitTxtPos1 = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1;']);
        eval(['SplitTxtPos2 = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos2;']);
        eval(['SplitTxtPos3 = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos3;']);
        eval(['SplitTxtPos4 = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos4;']);
        set(SplitTxtPos1, 'Visible', 'off');
        set(SplitTxtPos2, 'Visible', 'off');
        set(SplitTxtPos3, 'Visible', 'off');
        set(SplitTxtPos4, 'Visible', 'off');
    end;
    
    set(axesGraphPacing, 'parent', handles.hf_w1_welcome);
    if nbRaces == 1;
        eval(['GraphPosEC = handles.GraphPosA' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        if RaceDist == 800;
            yfontsize = 10;
        elseif RaceDist == 1500;
            yfontsize = 8;
        else;
            yfontsize = 12;
        end;
        
    elseif nbRaces == 2;
        eval(['GraphPosEC = handles.GraphPosB' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        if RaceDist == 1500;
            yfontsize = 8;
        else;
            yfontsize = 10;
        end;
        
    elseif nbRaces == 3;
        eval(['GraphPosEC = handles.GraphPosC' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        yfontsize = 8;
        
    elseif nbRaces == 4;
        eval(['GraphPosEC = handles.GraphPosD' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        yfontsize = 7;
        
    elseif nbRaces == 5;
        eval(['GraphPosEC = handles.GraphPosE' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        yfontsize = 6;
        
    elseif nbRaces == 6;
        eval(['GraphPosEC = handles.GraphPosF' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        yfontsize = 6;
        
    elseif nbRaces == 7;
        eval(['GraphPosEC = handles.GraphPosG' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        yfontsize = 6;
        
    elseif nbRaces == 8;
        eval(['GraphPosEC = handles.GraphPosH' num2str(race) ';']);
        set(axesGraphPacing, 'Units', 'normalized', 'Position', GraphPosEC);
        yfontsize = 6;

    end;
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %---Display graph elements
%     toolbar = axtoolbar(axesGraphPacing, 'default');
%     toolbar.Visible = 'on';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %---threshold values for velocity
    reference_velocitythreshold;
    ran = thresTopDisp - thresBottomDisp;
    min_val = thresBottomDisp;
    max_val = thresTopDisp;
    
    colorrange = 'parula';
    
    tickSpeed = [thresBottomDisp:0.2:thresTopDisp];
    tickColor = (tickSpeed-min_val)/ran;
    tickSpeedTXT = [];
    for i = 1:length(tickSpeed);
        tickSpeedTXT{i} = num2str(tickSpeed(i));
    end;
    
    refdist = 50;
    if RaceDist < 200;
        for lap = 1:NbLap;
            if lap == 1;
                if Course == 50
                    xtickDistance = [0 15 25 35 45];
                    iter = 6;
                else;
                    xtickDistance = [0 15 20];
                    iter = 4;
                end;
            else;
                lapdist = Course.*(lap-1);
                if Course == 50;
                    xtickDistance(iter:iter+5) = [lapdist lapdist+10 lapdist+15 lapdist+25 lapdist+35 lapdist+45];
                    iter = iter + 6;
                else;
                    xtickDistance(iter:iter+2) = [lapdist lapdist+10 lapdist+20];
                    iter = iter + 3;
                end;
            end;
        end;
        xtickDistance(end+1) = RaceDist;
    else;
        xtickDistance = [0:25:RaceDist];
    end;    
    xtickDistanceConvert = [];
    xticklabelDistance = [];
    
    lap = 1;
    for kdist = 1:length(xtickDistance);
        if kdist == 1;
            xtickDistanceConvert = 0;
            xticklabelDistance{kdist} = '0';
        else;
            if xtickDistance(kdist) == (lap*Course);
                xtickDistanceConvert = [xtickDistanceConvert SplitsAll(lap+1,3)];
                xticklabelDistance{kdist} = num2str(SplitsAll(lap+1,1));
                lap = lap + 1;
            else;
                [~,minloc] = min(abs(Distance-xtickDistance(kdist)));
                xtickDistanceConvert = [xtickDistanceConvert minloc(1)];
                xticklabelDistance{kdist} = num2str(xtickDistance(kdist));
            end;
        end;
    end;
    
    %Xaxis
    keyDist = [0:Course:RaceDist];
    xticklabelTime = [];
    for Dist = 1:length(xtickDistance);
        DistEC = xtickDistance(Dist);
        if DistEC == 0;
            xticklabelTime{1} = '0';
        else;
            likey = keyDist(keyDist == DistEC);
            if isempty(likey) == 1;
                [~, locmin] = min(abs(Distance - DistEC));
                timeTXT = timeSecToStr(Time(locmin(1)));
                if strcmpi(timeTXT(end), 's') == 1;
                    timeTXT = timeTXT(1:end-2);
                end;
                xticklabelTime{Dist} = timeTXT;
            else;
                liSplit = find(SplitsAll(:,1) == DistEC);
                timeTXT = timeSecToStr(SplitsAll(liSplit,2));
                if strcmpi(timeTXT(end), 's') == 1;
                    timeTXT = timeTXT(1:end-2);
                end;
                xticklabelTime{Dist} = timeTXT;
            end;
        end;
    end;
    
    if get(handles.Distance_check_analyser, 'value') == 1;
        xlim(axesGraphPacing, [0 xtickDistanceConvert(end)]);
        set(axesGraphPacing, 'xtick', xtickDistanceConvert, 'xticklabel', xticklabelDistance, 'xcolor', [1 1 1], 'visible', 'on');
    end;
    if get(handles.Time_check_analyser, 'value') == 1;
        xlim(axesGraphPacing, [0 xtickDistanceConvert(end)]);
        set(axesGraphPacing, 'xtick', xtickDistanceConvert, 'xticklabel', xticklabelTime, 'xcolor', [1 1 1], 'visible', 'on');
    end;
    
    %YLeft axis
    yyaxis(axesGraphPacing, 'left');
    
    rangeY = [0:TickSpaceLeft:graph1Pacing_maxYLeft+0.1];
    if get(handles.DPS_check_analyser, 'value') == 1;
        ylim(axesGraphPacing, [0 graph1Pacing_maxYLeft+0.1]);
    else;
        ylim(axesGraphPacing, [0 0.5]);
    end;
    li = find(rangeY >= graph1Pacing_minYLeft);

    yleftlabel = [rangeY(li(1)):TickSpaceLeft:rangeY(li(end))];
    yleftlabeltxt = [];
    for i = 1:length(yleftlabel);
        yleftlabeltxt{i,1} = num2str(yleftlabel(i));
    end;
    set(axesGraphPacing, 'ytick', yleftlabel, 'yticklabel', yleftlabeltxt, 'ycolor', [1 1 1], 'Visible', 'on');    
    set(axesGraphPacing, 'color', [0 0 0], 'fontsize', yfontsize);

    
    %YRight axis
    yyaxis(axesGraphPacing, 'right');
    
    maxYRightaxis = graph1Pacing_maxYRight;
    minYRightaxis = 0;
    refmax = ((maxYRightaxis-minYRightaxis)./2) + minYRightaxis;
    ylim(axesGraphPacing, [minYRightaxis maxYRightaxis]);
    
    rangeY = [0:TickSpaceRight:graph1Pacing_maxYRight+2];
    li = find(rangeY >= graph1Pacing_minYRight);
    yrightlabel = [rangeY(li(1)):TickSpaceRight:rangeY(li(end))];
    yrightlabeltxt = [];
    for i = 1:length(yrightlabel);
        yrightlabeltxt{i,1} = num2str(yrightlabel(i));
    end;
    if handles.CurrentstatusSR == 1;
        set(axesGraphPacing, 'ytick', yrightlabel, 'yticklabel', yrightlabeltxt, 'ycolor', [1 1 1], 'visible', 'on');
    else;
        set(axesGraphPacing, 'ytick', [], 'yticklabel', [], 'ycolor', [1 1 1], 'visible', 'on');
    end;
    
    
    axeschildren = allchild(axesGraphPacing);
%     set(axesGraphPacing, 'Visible', 'on');
    if handles.CurrentstatusSmooth == 0;
        if rem(length(axeschildren), 2) == 1;
            set(axeschildren(1:2:end), 'visible', 'on');
            set(axeschildren(2:2:end), 'visible', 'off');
        else;
            set(axeschildren(1:2:end), 'visible', 'off');
            set(axeschildren(2:2:end), 'visible', 'on');
        end;
    else;
        if rem(length(axeschildren), 2) == 1;
            set(axeschildren(1:2:end), 'visible', 'off');
            set(axeschildren(2:2:end), 'visible', 'on');
        else;
            set(axeschildren(1:2:end), 'visible', 'on');
            set(axeschildren(2:2:end), 'visible', 'off');
        end;
    end;
    set(graph1PacingTitle, 'visible', 'on');
    
    set(GraphDistance, 'Visible', 'off');
    if handles.CurrentstatusSR == 1;
        set(GraphDistance(1:LimGraphStroke), 'Visible', 'on');
    else;
        set(GraphDistance(1:LimGraphStroke), 'Visible', 'off');
    end;

    if handles.CurrentstatusBreath == 1;
        if isempty(LimGraphBreath) == 0;
            if handles.CurrentstatusSR == 1;
                set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'Visible', 'on', 'YData', [handles.CurrentvalueYRightmin handles.CurrentvalueYRightmin+((handles.CurrentvalueYRightmax-handles.CurrentvalueYRightmin).*0.15)]);
            else;
                set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'Visible', 'on', 'YData', [0 ((handles.CurrentvalueYRightmax-0).*0.15)]);
            end;
        end;
    end;
    
    for lap = 2:NbLap+1;
        hold on;
        li = SplitsAll(lap,3);
        splits = timeSecToStr(roundn(SplitsAll(lap,2),-2));
        if lap ~= 2;
            splitslap = SplitsAll(lap,2) - SplitsAll(lap-1,2);
            splitslapTXT = timeSecToStr(roundn(splitslap,-2));
            if nbRaces <= 5
                txtsplit = [splitslapTXT '  /  ' splits];
            else;
                txtsplit = {splitslapTXT; splits};
            end;
            graph1_textPos1(lap-1) = text(li, refmax, txtsplit, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar                                                             , 'color', [1 0 0], 'rotation', 90, 'parent',                                                                                         axesGraphPacing, 'visible', 'on');
        else;
            graph1_textPos1(lap-1) = text(li, refmax, splits, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar, 'color', [1 0 0], 'rotation', 90, 'parent', axesGraphPacing, 'visible', 'on');
        end;
        line(li, [0 graph1Pacing_maxYRight+5], 'Color', [1 0 0], 'LineWidth', 4, 'parent', axesGraphPacing, 'visible', 'on');
    end;
    if get(handles.Splits_check_analyser, 'value') == 1;
        set(graph1_textPos1, 'Visible', 'on');
    else;
        set(graph1_textPos1, 'Visible', 'off');
    end;    
    
    eval(['handles.S' num2str(race) '.axesGraphPacing = axesGraphPacing;']);    
    eval(['handles.S' num2str(race) '.axesGraphPacingTitle = graph1PacingTitle;']);
    eval(['handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1 = graph1_textPos1;']);

    eval(['handles.S' num2str(race) '.axesGraphPacing_xtickDistanceConvert = xtickDistanceConvert;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_xticklabelDistance = xticklabelDistance;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_xticklabelTime = xticklabelTime;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_yleftlabel = yleftlabel;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_yleftlabeltxt = yleftlabeltxt;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_yrightlabel = yrightlabel;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_yrightlabeltxt = yrightlabeltxt;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_maxYLeft = graph1Pacing_maxYLeft;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_maxYRight = graph1Pacing_maxYRight;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_minYLeft = graph1Pacing_minYLeft;']);
    eval(['handles.S' num2str(race) '.axesGraphPacing_minYRight = graph1Pacing_minYRight;']);
    
    clear axesGraphPacing;
    clear graph1PacingTitle;
end;    

UID = RaceUID{1};
li = findstr(UID, '-');
UID(li) = '_';
UID = ['A' UID 'A'];
eval(['axescolbar = handles.RacesDB.' UID '.graph1Pacingaxescolbar;']);
eval(['colbar = handles.RacesDB.' UID '.graph1Pacingcolbar;']);
handles.S1.graph1Pacingaxescolbar = axescolbar;
handles.S1.graph1Pacingcolbar = colbar;
        
poscolbar = [offsetLeftColBar, offsetBottomColBar, widthColBar, heightColBar];

set(axescolbar, 'parent', handles.hf_w1_welcome, 'units', 'normalized');
set(axescolbar, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], ...
    'Visible', 'on', 'Fontsize', fontsizecolbar, 'color', [0 0 0]);
set(colbar, 'position', poscolbar, 'Visible', 'on', 'FontSize', fontsizecolbar);

axesXTitle = axes('parent', handles.hf_w1_welcome, 'Position', [offsetLeftXtitle, offsetBottomXtitle, widthXtitle, heightXtitle], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesXTitle, [0 1]);
ylim(axesXTitle, [0 1]);
if get(handles.Distance_check_analyser, 'value') == 1;
    XTitle = text(0.5, 0.5, 'Distance (m)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
end;
if get(handles.Time_check_analyser, 'value') == 1;
    XTitle = text(0.5, 0.5, 'Time', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
end;
set(axesXTitle, 'units', 'Normalized');
eval(['handles.S1.axesGraphPacingXTitle = axesXTitle;']);
eval(['handles.S1.axesGraphPacingXTitletxt = XTitle;']);

axesYLeftTitle = axes('parent', handles.hf_w1_welcome, 'Position', [offsetleftA, offsetbottom./FigPos(4), widthA, (TopPointY-offsetbottom)./FigPos(4)], 'units', 'Normalized', ...
    'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesYLeftTitle, [0 1]);
ylim(axesYLeftTitle, [0 1]);
YLeftTitle = text(0.5, 0.5, 'DPS', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'rotation', 90, 'parent', axesYLeftTitle, 'visible', 'off');
set(axesYLeftTitle, 'units', 'Normalized');
if get(handles.DPS_check_analyser, 'value') == 1;
    set(axesYLeftTitle, 'visible', 'on');
    set(YLeftTitle, 'visible', 'on');
end;
eval(['handles.S1.axesGraphPacingYLeftTitle = axesYLeftTitle;']);
eval(['handles.S1.axesGraphPacingYLeftTitletxt = YLeftTitle;']);

axesYRightTitle = axes('parent', handles.hf_w1_welcome, 'Position', [offsetleftB, offsetbottom./FigPos(4), widthB, (TopPointY-offsetbottom)./FigPos(4)], 'units', 'Normalized', ...
    'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesYRightTitle, [0 1]);
ylim(axesYRightTitle, [0 1]);
YRightTitle = text(0.5, 0.5, 'Stroke Rate', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'rotation', 270, 'parent', axesYRightTitle, 'visible', 'off');
set(axesYRightTitle, 'units', 'Normalized');
if get(handles.SR_check_analyser, 'value') == 1;
    set(axesYRightTitle, 'visible', 'on');
    set(YRightTitle, 'visible', 'on');
end;
eval(['handles.S1.axesGraphPacingYRightTitle = axesYRightTitle;']);
eval(['handles.S1.axesGraphPacingYRightTitletxt = YRightTitle;']);

handles.CurrentvalueXmin = 0;
handles.CurrentvalueXmax = SplitsAll(end,1);
handles.CurrentvalueYLeftmin = 0;
handles.CurrentvalueYLeftmax = roundn(graph1Pacing_maxYLeft,-2);
handles.CurrentvalueYRightmin = 0;
handles.CurrentvalueYRightmax = roundn(graph1Pacing_maxYRight,-1);
handles.CurrentvalueXminSave = 0;
handles.CurrentvalueXmaxSave = SplitsAll(end,1);
handles.CurrentvalueYLeftminSave = 0;
handles.CurrentvalueYLeftmaxSave = roundn(graph1Pacing_maxYLeft,-2);
handles.CurrentvalueYRightminSave = 0;
handles.CurrentvalueYRightmaxSave = roundn(graph1Pacing_maxYRight,-1);
if get(handles.Distance_check_analyser, 'value') == 1;
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
    set(handles.Edit_Xmax_analyser, 'String', num2str(handles.CurrentvalueXmax));
else;
    set(handles.Edit_Xmin_analyser, 'String', '');
    set(handles.Edit_Xmax_analyser, 'String', '');
end;
if get(handles.DPS_check_analyser, 'value') == 1;
    set(handles.Edit_YLeftmin_analyser, 'String', '0');
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(roundn(handles.CurrentvalueYLeftmax,-2)));
else;
    set(handles.Edit_YLeftmin_analyser, 'String', '');
    set(handles.Edit_YLeftmax_analyser, 'String', '');
end;
if get(handles.SR_check_analyser, 'value') == 1;
    set(handles.Edit_YRightmin_analyser, 'String', '0');
    set(handles.Edit_YRightmax_analyser, 'String', num2str(roundn(handles.CurrentvalueYRightmax,-1)));
else;
    set(handles.Edit_YRightmin_analyser, 'String', '');
    set(handles.Edit_YRightmax_analyser, 'String', '');
end;

clear axescolbar;
clear colbar;
clear axesXTitle;
clear axesYLeftTitle;
clear axesYRightTitle;
