% RacesTOT = length(handles.uidDB(:,1));
% nbRaces = length(handles.filelistAdded);
% RaceUID = [];
% for raceEC = 1:nbRaces;
%     fileEC = handles.filelistAdded{raceEC};
%     proceed = 1;
%     iter = 1;
%     while proceed == 1;
%         raceCHECK = handles.uidDB{iter,2};
%         if strcmpi(fileEC, raceCHECK) == 1;
%             RaceUID{raceEC} = handles.uidDB{iter,1};
%             proceed = 0;
%         else;
%             iter = iter + 1;
%         end;
%     end;
% end;

Turn_TimeALL = [];
Turn_TimeInALL = [];
Turn_TimeOutALL = [];

RaceUID{1} = UID;
i=3;
% for i = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
    UID = RaceUID{i-2};
%     li = findstr(UID, '-');
%     UID(li) = '_';
%     UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    

    %--------------------------------Skills--------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);

    %%%Totals
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTimeINI;']);
    TotalSkillTimetxt = timeSecToStr(TotalSkillTime);

    eval(['Turn_Time = handles.RacesDB.' UID '.Turn_TimeINI;']);%%%%%%%%%%%%%%
    eval(['Turn_TimeIn = handles.RacesDB.' UID '.Turn_TimeInINI;']);%%%%%%%%%%
    eval(['Turn_TimeOut = handles.RacesDB.' UID '.Turn_TimeOutINI;']);%%%%%%%%
    
    Turn_TimeALL(:,:,i-2) = Turn_Time;
    Turn_TimeInALL(:,:,i-2) = Turn_TimeIn;
    Turn_TimeOutALL(:,:,i-2) = Turn_TimeOut;
    Turn_Timetxt = timeSecToStr(roundn(sum(Turn_Time),-2));
    Turn_TimeIntxt = timeSecToStr(roundn(sum(Turn_TimeIn),-2));
    Turn_TimeOuttxt = timeSecToStr(roundn(sum(Turn_TimeOut),-2));
    
    %%%%Start
    SplitsAll = SplitsAll(2:end,:);

    eval(['DiveT15 = handles.RacesDB.' UID '.DiveT15INI;']);%%%%%%%%%%%%%%%%%%

    DiveT15txt = timeSecToStr(roundn(DiveT15,-2));
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    RTtxt = timeSecToStr(roundn(RT,-2));
    
    eval(['StartUWVelocity = handles.RacesDB.' UID '.StartUWVelocity;']);
    eval(['StartEntryDist = handles.RacesDB.' UID '.StartEntryDist;']);
    eval(['StartUWDist = handles.RacesDB.' UID '.StartUWDist;']);
    eval(['StartUWTime = handles.RacesDB.' UID '.StartUWTime;']);
    
    eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
    
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);%%%%%%%%%%%%%%%%%%%%%%
    BOdisttxt = dataToStr(BOAll(1,3),1);
    
    BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
    
    eval(['BOEff = handles.RacesDB.' UID '.BOEff;']);
    eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
    eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
    BOEfftxt = dataToStr(BOEff(1,1).*100,1);
    VelAftertxt = dataToStr(VelAfterBO(1,1),2);
    VelBeforetxt = dataToStr(VelBeforeBO(1,1),2);
    
    %%%%Turns averages
    if NbLap == 1;

    else;
        AvTurnIn = roundn(mean(Turn_TimeIn),-2);
        AvTurnOut = roundn(mean(Turn_TimeOut),-2);
        AvTurnTime = roundn(mean(Turn_Time),-2);
        AvTurnInALL(:,:,i-2) = AvTurnIn;
        AvTurnOutALL(:,:,i-2) = AvTurnOut;
        AvTurnTimeALL(:,:,i-2) = AvTurnTime;
        AvTurnIntxt = timeSecToStr(roundn(AvTurnIn,-2));
        AvTurnOuttxt = timeSecToStr(roundn(AvTurnOut,-2));
        AvTurnTimetxt = timeSecToStr(roundn(AvTurnTime,-2));    
    
        AvKicksNb = roundn(mean(KicksNb(2:end)),-2);
        AvKicksNbtxt = dataToStr(AvKicksNb,1);
    
        BOTurn = [];
        for lap = 2:NbLap;
            BO = BOAll(lap,3);
            BO = BO - ((lap-1).*Course);
            BOTurn = [BOTurn BO];
        end;
        AvBODistTurn = roundn(mean(BOTurn),-2);
        AvBODistTurntxt = dataToStr(AvBODistTurn,1);
        
        BOTurn = [];
        for lap = 2:NbLap;
            BO = BOAll(lap,2);
            BO = BO - SplitsAll(lap-1,2);
            BOTurn = [BOTurn BO];
        end;
        AvBOTimeTurn = roundn(mean(BOTurn),-2);
        AvBOTimeTurntxt = timeSecToStr(AvBOTimeTurn);
        
        eval(['BOEffTurn = handles.RacesDB.' UID '.BOEff(2:end);']);
        BOEffTurn = roundn(mean(BOEffTurn).*100,-2);
        BOEffTurntxt = dataToStr(BOEffTurn,1);
        VelBefTurn = roundn(mean(VelBeforeBO(2:end)),-2);
        VelBefTurntxt = dataToStr(VelBefTurn,2);
        VelAftTurn = roundn(mean(VelAfterBO(2:end)),-2);
        VelAftTurntxt = dataToStr(VelAftTurn,2);
    end;
    

%     %%%%Turn Details
%     if NbLap ~= 1;
%         lineEC = 31;
%         for lap = 1:NbLap-1;
%             dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];
% 
%             Turn_TimeIntxt = timeSecToStr(roundn(Turn_TimeIn(lap),-2));
%             Turn_TimeOuttxt = timeSecToStr(roundn(Turn_TimeOut(lap),-2));
%             Turn_Timetxt = timeSecToStr(roundn(Turn_Time(lap),-2));
%             dataTableSkill{lineEC+1,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
% 
%             eval(['ApproachEff = handles.RacesDB.' UID '.ApproachEff;']);
%             eval(['Approach2CycleAll = handles.RacesDB.' UID '.ApproachSpeed2CycleAll;']);
%             eval(['ApproachLastCycleAll = handles.RacesDB.' UID '.ApproachSpeedLastCycleAll;']);
%             ApproachEffTurn = roundn(ApproachEff(lap).*100,-2);
%             ApproachEffTurntxt = dataToStr(ApproachEffTurn,1);
%             Approach2CycleAlltxt = dataToStr(Approach2CycleAll(lap),2);
%             ApproachLastCycleAlltxt = dataToStr(ApproachLastCycleAll(lap),2);
%             dataTableSkill{lineEC+2,i} = [ApproachEffTurntxt ' %  /  ' Approach2CycleAlltxt ' m/s  /  ' ApproachLastCycleAlltxt ' m/s'];
% 
%             eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
%             GlideLastStrokeDist = roundn(GlideLastStroke(3,lap),-2);
%             GlideLastStrokeTime = roundn(GlideLastStroke(4,lap),-2);
%             GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
%             GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
%             dataTableSkill{lineEC+3,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
%             
%             KicksNbtxt = dataToStr(KicksNb(lap+1),0);
%             dataTableSkill{lineEC+4,i} = [KicksNbtxt ' Kicks'];
% 
%             BO = BOAll(lap+1,3);
%             BO = roundn(BO - (lap.*Course),-2);
%             BOdisttxt = dataToStr(BO,1);
%             dataTableSkill{lineEC+5,i} = [BOdisttxt ' m'];
%             
%             BO = BOAll(lap+1,2);
%             BO = BO - SplitsAll(lap,2);
%             BOtimetxt = timeSecToStr(BO);
%             dataTableSkill{lineEC+6,i} = BOtimetxt;
% 
%             eval(['BOEffTurn = handles.RacesDB.' UID '.BOEff;']);
%             eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
%             eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
%             BOEffTurntxt = dataToStr(BOEffTurn(lap+1).*100,1);
%             
%             VelAfterBOtxt = dataToStr(VelAfterBO(lap+1),2);
%             VelBeforeBOtxt = dataToStr(VelBeforeBO(lap+1),2);
%             if Source == 1;
%                 dataTableSkill{lineEC+7,i} = 'na';
%             elseif Source == 2;
%                 dataTableSkill{lineEC+7,i} = [BOEffTurntxt ' %  /  ' VelBeforeBOtxt ' m/s  /  ' VelAfterBOtxt ' m/s'];
%             end;
%             
%             lineEC = lineEC + 8;
%         end;
%     end;

    eval(['Last5m = handles.RacesDB.' UID '.Last5mINI;']);%%%%%%%%%%%%%%%%%%%%%
    Last5mtxt = timeSecToStr(Last5m);
    
%     if NbLap == 1;
%         eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
%     end;
%     GlideLastStrokeDist = roundn(GlideLastStroke(3,end),-2);
%     GlideLastStrokeTime = roundn(GlideLastStroke(4,end),-2);
%     GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
%     GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
% end;

% if strcmpi(origin, 'table') == 1;
%     set(handles.StrokeData_table_analyser, 'Visible', 'off');
%     set(handles.SkillData_table_analyser, 'data', dataTableSkill, 'backgroundcolor', colorrow);
%     set(handles.PacingData_table_analyser, 'Visible', 'off');
%     set(handles.SummaryData_table_analyser, 'Visible', 'off');
% 
%     table_extent = get(handles.SkillData_table_analyser, 'Extent');
%     table_position = get(handles.SkillData_table_analyser, 'Position');
%     pos_cor = table_position;
%     if table_extent(4) < table_position(4);
% 
%         if Extent == 0;
%             %Add 5% to give space for the slider bar at the bottom
%             offset = 18;
%             pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)-offset;
%             pos_cor(4) = table_extent(4)+offset;
%         else;
%             pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)+1;
%             pos_cor(4) = table_extent(4)+1;
%         end;
% 
%     elseif table_extent(4) >= table_position(4);
%         if table_position(2) < (0.0069*PosFig(4));
%             pos_cor(2) = (0.0069*PosFig(4))+1;
%             pos_cor(4) = (handles.TopINI_SkillTable*PosFig(4))+1;
% 
%             offset = 18;
%             PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
%             if PixelSwimmers < 200;
%                 PixelSwimmers = 200;
%                 Extent = 0;
%             else;
%                 Extent = 1;
%             end;
%             ColWidth = {100 150};
%             for i = 3:nbRaces+2;
%                 ColWidth{i} = PixelSwimmers;
%             end;
%             set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
%         else;
%             if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
%                 pos_cor(2) = (0.0069*PosFig(4))+1;
%                 pos_cor(4) = (handles.TopINI_SkillTable*PosFig(4))+1;
% 
%                 offset = 18;
%                 PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
%                 if PixelSwimmers < 200;
%                     PixelSwimmers = 200;
%                     Extent = 0;
%                 else;
%                     Extent = 1;
%                 end;
%                 ColWidth = {100 150};
%                 for i = 3:nbRaces+2;
%                     ColWidth{i} = PixelSwimmers;
%                 end;
%                 set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
%             else;
%                 if Extent == 0;
%                     %Add 5% to give space for the slider bar at the bottom
%                     offset = 18;
%                     pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)-offset;
%                     pos_cor(4) = table_extent(4)+offset;
%                 else;
%                     pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)+1;
%                     pos_cor(4) = table_extent(4)+1;
%                 end;
%             end;
%         end;
%     end;
% 
%     if Extent == 1;
%         if table_extent(3) > table_position(3);
%             pos_cor(3) = table_extent(3)+1;
%         end;
%     end;
%     set(handles.SkillData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
%     set(handles.SkillData_table_analyser, 'Units', 'normalized');
% 
%     PosEND = get(handles.SkillData_table_analyser, 'Position');
%     PosEND = PosEND(3);
%     handles.diffPosSkillTable = PosEND - handles.PosINI_SkillTable;
% end;
    
