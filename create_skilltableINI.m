RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
% RaceUID = [];
% 
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
set(gcf, 'units', 'pixels');
PosFig = get(gcf, 'Position');
set(gcf, 'units', 'normalized');

databaseCurrent = handles.databaseCurrent_analyser;

colorrow(1,:) = [1 0.9 0.1];
colorrow(2,:) = [0.9 0.9 0.9];
colorrow(3,:) = [0.75 0.75 0.75];
colorrow(4,:) = [0.9 0.9 0.9];
colorrow(5,:) = [0.75 0.75 0.75];
colorrow(6,:) = [0.9 0.9 0.9];
colorrow(7,:) = [1 1 1];
colorrow(8,:) = [1 0.9 0.1];
colorrow(9,:) = [1 0.9 0.70];
colorrow(10,:) = [0.9 0.9 0.9];
colorrow(11,:) = [0.75 0.75 0.75];
colorrow(12,:) = [0.9 0.9 0.9];
colorrow(13,:) = [0.75 0.75 0.75];
colorrow(14,:) = [1 0.9 0.70];
colorrow(15,:) = [0.9 0.9 0.9];
colorrow(16,:) = [0.75 0.75 0.75];
colorrow(17,:) = [0.9 0.9 0.9];
colorrow(18,:) = [0.75 0.75 0.75];
colorrow(19,:) = [0.9 0.9 0.9];
colorrow(20,:) = [0.75 0.75 0.75];
colorrow(21,:) = [0.9 0.9 0.9];
colorrow(22,:) = [0.75 0.75 0.75];
colorrow(23,:) = [0.9 0.9 0.9];
colorrow(24,:) = [0.75 0.75 0.75];
colorrow(25,:) = [1 0.9 0.70];
colorrow(26,:) = [0.9 0.9 0.9];
colorrow(27,:) = [0.75 0.75 0.75];
colorrow(28,:) = [0.9 0.9 0.9];
colorrow(29,:) = [0.75 0.75 0.75];
colorrow(30,:) = [0.9 0.9 0.9];

formatlist{1} = 'char';
formatlist{2} = 'char';
edittablelist(1) = false;
edittablelist(2) = false;
for i = 1:nbRaces;
    formatlist{i+2} = 'numeric';
    edittablelist(i+2) = false;
end;

if strcmpi(origin, 'table') == 1;
    PosINI = get(handles.SkillData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosSkillTable;
    set(handles.SkillData_table_analyser, 'Position', posCorr);

    set(handles.SkillData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.SkillData_table_analyser, 'position');
    
    PixelTot = pos(3);
    PixelSwimmers = floor((PixelTot - 100 - 150)./nbRaces);
    if PixelSwimmers < 200;
        PixelSwimmers = 200;
        Extent = 0;
    else;
        Extent = 1;
    end;
    ColWidth = {100 150};
    for i = 3:nbRaces+2;
        ColWidth{i} = PixelSwimmers;
    end;
    set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
end;


% set(handles.SkillData_table_analyser, 'Units', 'normalized');


dataTableSkill = {};
dataTableSkill{1,2} = 'Metadata';
dataTableSkill{8,2} = 'Skills';

dataTableSkill{9,1} = 'Totals';
dataTableSkill{10,2} = 'Skill Time';
dataTableSkill{11,2} = 'Tot underwater Dist';
dataTableSkill{12,2} = 'Tot underwater Time';
dataTableSkill{13,2} = 'Tot Turns (In/Out/Tot)';

dataTableSkill{14,1} = 'Start';
dataTableSkill{15,2} = 'Start Time';
dataTableSkill{16,2} = 'Reaction Time';
dataTableSkill{17,2} = 'Entry Distance';
dataTableSkill{18,2} = 'Unverwater Distance';
dataTableSkill{19,2} = 'Unverwater Time';
dataTableSkill{20,2} = 'Unverwater Speed';
dataTableSkill{21,2} = 'Underwater Kicks';
dataTableSkill{22,2} = 'Breakout Distance';
dataTableSkill{23,2} = 'Breakout Time';
dataTableSkill{24,2} = 'Breakout Skill';

dataTableSkill{25,1} = 'Turns Averages';
dataTableSkill{26,2} = 'Av Times (In/Out/Tot)';
dataTableSkill{27,2} = 'Av Kicks';
dataTableSkill{28,2} = 'Av Breakout Distance';
dataTableSkill{29,2} = 'Av Breakout Time';
dataTableSkill{30,2} = 'Av Breakout Skill';


% Turn_TimeALL = [];
% Turn_TimeInALL = [];
% Turn_TimeOutALL = [];
for i = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
%     UID = RaceUID{i-2};
%     li = findstr(UID, '-');
%     UID(li) = '_';
%     UID = ['A' UID 'A'];
    mainIter = i;
    
    Source = databaseCurrent{mainIter-2,58};
%     dataTableRefDist = [5:5:RaceDist]';
    if Source == 1 | Source == 3;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverage = databaseCurrent{mainIter-2,68};
        dataTableBreath = databaseCurrent{mainIter-2,69};
        dataTableStrokeData = databaseCurrent{mainIter-2,70};
        dataTableSkillVAL = databaseCurrent{mainIter-2,71};
        if isnan(dataTableAverage(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTableAverage(end,1) = str2num(racetimemissing);
        end;
    
    elseif Source == 2;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverage = databaseCurrent{mainIter-2,68};
        dataTableBreath = databaseCurrent{mainIter-2,69};
        dataTableSkillVAL = databaseCurrent{mainIter-2,70};
        dataTableSkillTXT = databaseCurrent{mainIter-2,71};
    end;
    if Source == 1;
        answerReport = 'SP1';
        dataTableSkill{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        answerReport = 'SP2';
        dataTableSkill{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        answerReport = 'GE';
        dataTableSkill{7,mainIter} = 'GreenEye';
    end;
    
    
    %---Metadata
    relayExist = databaseCurrent{mainIter-2,11};
    if isempty(strfind(relayExist, 'Relay')) == 0;
        isRelay = 1;
    else;
        isRelay = 0;
    end;
    if isRelay == 1;
        relayLeg = databaseCurrent{mainIter-2,11};
        index1 = strfind(relayLeg, '(');
        index2 = strfind(relayLeg, ')');
        relayLeg = relayLeg(index1+1:index2-1);
        RelayType = [databaseCurrent{mainIter-2,53} ' (' relayLeg ')'];
    else;
        RelayType = 'Individual';
    end;
    valRelay = databaseCurrent{mainIter-2,11};
    detailRelay = databaseCurrent{mainIter-2,53};

    AthletenameFull = databaseCurrent{mainIter-2,2};
    index = strfind(AthletenameFull, ' ');
    Athletename = [AthletenameFull(index(end)+1:end) AthletenameFull(1)];
    eval(['dataTableSkill{2,' num2str(mainIter) '} = Athletename;']);
    
    Meet = databaseCurrent{mainIter-2,7};
    Stage = databaseCurrent{mainIter-2,6};
    Year = databaseCurrent{mainIter-2,8};
    StrokeType = databaseCurrent{mainIter-2,4};
    RaceDist = str2num(databaseCurrent{mainIter-2,3});
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSkill{3,' num2str(mainIter) '} = str;']);  
    Course = str2num(databaseCurrent{mainIter-2,10});

    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableSkill{5,' num2str(mainIter) '} = str;']);
    
%     eval(['splitAll = handles.RacesDB.' UID '.splitAll;']);
    if Source == 1 | Source == 3;
        colinterest_Splits = 2;
        TTtxt = timeSecToStr(dataTableAverage(end,colinterest_Splits));
        splitAll = dataTableAverage(:,colinterest_Splits);
    else;
        colinterest_Splits = 12;
        TTtxt = timeSecToStr(dataTableAverage{end,colinterest_Splits});
        splitAll = cell2mat(dataTableAverage(:,colinterest_Splits));
    end;
    dataTableSkill{6,mainIter} = TTtxt;


    %--------------------------------Skills--------------------------------
    NbLap = RaceDist./Course;
    if i == 3;
        lineEC = 31;
        for lap = 1:NbLap-1;
            dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];

            dataTableSkill{lineEC+1,2} = 'Times (In/Out/Tot)';
            dataTableSkill{lineEC+2,2} = 'Approach Skill';
            dataTableSkill{lineEC+3,2} = 'Glide-Wall (Dist/Time)';
            dataTableSkill{lineEC+4,2} = 'Underwater Kicks';
            dataTableSkill{lineEC+5,2} = 'Breakout Distance';
            dataTableSkill{lineEC+6,2} = 'Breakout Time';
            dataTableSkill{lineEC+7,2} = 'Breakout skill';

            colorrow(lineEC,:) = [1 0.9 0.70];
            colorrow(lineEC+1,:) = [0.9 0.9 0.9];
            colorrow(lineEC+2,:) = [0.75 0.75 0.75];
            colorrow(lineEC+3,:) = [0.9 0.9 0.9];
            colorrow(lineEC+4,:) = [0.75 0.75 0.75];
            colorrow(lineEC+5,:) = [0.9 0.9 0.9];
            colorrow(lineEC+6,:) = [0.75 0.75 0.75];
            colorrow(lineEC+7,:) = [0.9 0.9 0.9];

            lineEC = lineEC + 8;
        end;

        dataTableSkill{lineEC,1} = 'Finish';
        dataTableSkill{lineEC+1,2} = 'Last 5m Time';
        dataTableSkill{lineEC+2,2} = 'Glide-Wall (Dist/Time)';
        colorrow(lineEC,:) = [1 0.9 0.70];
        colorrow(lineEC+1,:) = [0.9 0.9 0.9];
        colorrow(lineEC+2,:) = [0.75 0.75 0.75];
    end;

    %%%Totals
    
    if Source == 1 | Source == 3;
        for lineEC = 10:length(dataTableSkill(:,1));
            dataTableSkill{lineEC,mainIter} = dataTableSkillVAL{lineEC,3};
        end;
    else;
        colinterest_Splits = 11;
        splitAll = cell2mat(dataTableAverage(:,colinterest_Splits));

        BOAll = dataTableSkillVAL{1,24};
        dataTableSkill{10,i} = timeSecToStr(dataTableSkillVAL{1,1}); %skill time
        dataTableSkill{11,i} = 'na'; %Total underwater Distance
        dataTableSkill{12,i} = 'na'; %Total underwater Time
        dataTableSkill{13,i} = [timeSecToStr(sum(dataTableSkillVAL{1,3})) '  /  ' ...
            timeSecToStr(sum(dataTableSkillVAL{1,4})) '  /  ' ...
            timeSecToStr(sum(dataTableSkillVAL{1,2}))]; %Sum Turn times
        dataTableSkill{15,i} = timeSecToStr(dataTableSkillVAL{1,5}); %Start time
        dataTableSkill{16,i} = timeSecToStr(dataTableSkillVAL{1,22}); %RT
        if isempty(databaseCurrent{mainIter-2,24}) == 1;
            dataTableSkill{17,i} = 'na';    %Entry Distance
            dataTableSkill{18,i} = 'na';    %Unverwater Distance
            dataTableSkill{19,i} = 'na';    %Unverwater Time
            dataTableSkill{20,i} = 'na';    %Unverwater Speed
        else;
            dataTableSkill{17,i} = [dataToStr(dataTableSkillVAL{1,33}, 2) ' m'];     %Entry Distance
            dataTableSkill{18,i} = [dataToStr(dataTableSkillVAL{1,34}, 2) ' m'];     %Unverwater Distance
            dataTableSkill{19,i} = timeSecToStr(dataTableSkillVAL{1,35});            %Unverwater Time
            dataTableSkill{20,i} = [dataToStr(dataTableSkillVAL{1,32}, 2) ' m/s'];   %Unverwater Speed
        end;
        KicksNb = databaseCurrent{mainIter-2,64};
        dataTableSkill{21,i} = [num2str(KicksNb(1)) ' Kicks'];
        
        BOdisttxt = dataToStr(BOAll(1,3),1);
        dataTableSkill{22,i} = [BOdisttxt ' m'];
        BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
        dataTableSkill{23,i} = BOTimetxt;
        BOEfftxt = dataToStr(dataTableSkillVAL{1,8}, 1);
        VelBeforetxt = dataToStr(dataTableSkillVAL{1,9}, 2);
        VelAftertxt = dataToStr(dataTableSkillVAL{1,10}, 2);
        dataTableSkill{24,i} = [BOEfftxt ' %  /  ' VelBeforetxt ' m/s  /  ' VelAftertxt ' m/s'];
        
        %%%%Turns averages
        if NbLap == 1;
            dataTableSkill{26,i} = '  -  /  -  /  -  ';
            dataTableSkill{27,i} = '  -  ';
            dataTableSkill{28,i} = '  -  ';
            dataTableSkill{29,i} = '  -  ';
            dataTableSkill{30,i} = '  -  ';
        else;
            AvTurnIn = dataTableSkillVAL{1,11};
            AvTurnOut = dataTableSkillVAL{1,12};
            AvTurnTime = dataTableSkillVAL{1,13};
%             AvTurnInALL(:,:,i-2) = AvTurnIn;
%             AvTurnOutALL(:,:,i-2) = AvTurnOut;
%             AvTurnTimeALL(:,:,i-2) = AvTurnTime;
            AvTurnIntxt = timeSecToStr(roundn(AvTurnIn,-2));
            AvTurnOuttxt = timeSecToStr(roundn(AvTurnOut,-2));
            AvTurnTimetxt = timeSecToStr(roundn(AvTurnTime,-2));    
            dataTableSkill{26,i} = [AvTurnIntxt '  /  ' AvTurnOuttxt '  /  ' AvTurnTimetxt];
    
            AvKicksNb = roundn(mean(KicksNb(2:end)),-2);
            AvKicksNbtxt = dataToStr(AvKicksNb,1);
            dataTableSkill{27,i} = [AvKicksNbtxt ' Kicks'];
    
            BOTurn = [];
            for lap = 2:NbLap;
                BO = BOAll(lap,3);
                BO = BO - ((lap-1).*Course);
                BOTurn = [BOTurn BO];
            end;
            AvBODistTurn = roundn(mean(BOTurn),-2);
            AvBODistTurntxt = dataToStr(AvBODistTurn,1);
            dataTableSkill{28,i} = [AvBODistTurntxt ' m'];
    
            BOTurn = [];
            if Course == 50;
                keyDistRow = 10:10:(NbLap.*10);
            else;
                keyDistRow = 5:5:(NbLap.*5);
            end;

            for lap = 2:NbLap;
                BO = BOAll(lap,2);
                BO = BO - splitAll(keyDistRow(lap-1),1);
                BOTurn = [BOTurn BO];
            end;
            AvBOTimeTurn = roundn(mean(BOTurn),-2);
            AvBOTimeTurntxt = timeSecToStr(AvBOTimeTurn);
            dataTableSkill{29,i} = AvBOTimeTurntxt;

            BOEffTurn = dataTableSkillVAL{1,17};
            BOEffTurntxt = dataToStr(BOEffTurn,1);
            VelBefTurn = dataTableSkillVAL{1,18};
            VelBefTurntxt = dataToStr(VelBefTurn,2);
            VelAftTurn = dataTableSkillVAL{1,19};
            VelAftTurntxt = dataToStr(VelAftTurn,2);
            dataTableSkill{30,i} = [BOEffTurntxt ' %  /  ' VelBefTurntxt ' m/s  /  ' VelAftTurntxt ' m/s'];            
        end;

        %%%%Turn Details
        if NbLap ~= 1;
            lineEC = 31;
            Turn_TimeIn = dataTableSkillVAL{1,3};
            Turn_TimeOut = dataTableSkillVAL{1,4};
            Turn_Time = dataTableSkillVAL{1,2};
            for lap = 1:NbLap-1;
                dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];
    
                Turn_TimeIntxt = timeSecToStr(roundn(Turn_TimeIn(lap),-2));
                Turn_TimeOuttxt = timeSecToStr(roundn(Turn_TimeOut(lap),-2));
                Turn_Timetxt = timeSecToStr(roundn(Turn_Time(lap),-2));
                dataTableSkill{lineEC+1,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
            
                ApproachEff = dataTableSkillVAL{1,28};
                Approach2CycleAll = dataTableSkillVAL{1,29};
                ApproachLastCycleAll = dataTableSkillVAL{1,30};
                ApproachEffTurn = roundn(ApproachEff(lap).*100,-2);
                ApproachEffTurntxt = dataToStr(ApproachEffTurn,1);
                Approach2CycleAlltxt = dataToStr(Approach2CycleAll(lap),2);
                ApproachLastCycleAlltxt = dataToStr(ApproachLastCycleAll(lap),2);
                if Source == 1 | Source == 3;
                    dataTableSkill{lineEC+2,i} = [' na  /  na  /  na '];
                elseif Source == 2;
                    dataTableSkill{lineEC+2,i} = [ApproachEffTurntxt ' %  /  ' Approach2CycleAlltxt ' m/s  /  ' ApproachLastCycleAlltxt ' m/s'];
                end;
    
                GlideLastStroke = dataTableSkillVAL{1,31};
                GlideLastStrokeDist = roundn(GlideLastStroke(3,lap),-2);
                GlideLastStrokeTime = roundn(GlideLastStroke(4,lap),-2);
                GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
                GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
                if Source == 1 | Source == 3;
                    dataTableSkill{lineEC+3,i} =  [' na  /  na '];
                elseif Source == 2;
                    dataTableSkill{lineEC+3,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
                end;
                
                KicksNbtxt = dataToStr(KicksNb(lap+1),0);
                dataTableSkill{lineEC+4,i} = [KicksNbtxt ' Kicks'];
    
                BO = BOAll(lap+1,3);
                BO = roundn(BO - (lap.*Course),-2);
                BOdisttxt = dataToStr(BO,1);
                dataTableSkill{lineEC+5,i} = [BOdisttxt ' m'];

                BO = BOAll(lap+1,2);
                BO = BO - splitAll(keyDistRow(lap),1);
                BOtimetxt = timeSecToStr(BO);
                dataTableSkill{lineEC+6,i} = BOtimetxt;
                    
                BOEffTurn = dataTableSkillVAL{1,25};
                VelAfterBO = dataTableSkillVAL{1,26};
                VelBeforeBO = dataTableSkillVAL{1,27};
                BOEffTurntxt = dataToStr(BOEffTurn(lap).*100,1);
                
                VelAfterBOtxt = dataToStr(VelAfterBO(lap),2);
                VelBeforeBOtxt = dataToStr(VelBeforeBO(lap),2);
                dataTableSkill{lineEC+7,i} = [BOEffTurntxt ' %  /  ' VelBeforeBOtxt ' m/s  /  ' VelAfterBOtxt ' m/s'];
                
                lineEC = lineEC + 8;
            end;
        end;
    
        Last5m = dataTableSkillVAL{1,20};%%%%%%%%%%%%%%%%%%%%%
        Last5mtxt = timeSecToStr(Last5m);
        dataTableSkill{lineEC+1,i} = Last5mtxt;
        
        if NbLap == 1;
            GlideLastStroke = dataTableSkillVAL{1,31};
        end;
        GlideLastStrokeDist = roundn(GlideLastStroke(3,end),-2);
        GlideLastStrokeTime = roundn(GlideLastStroke(4,end),-2);
        GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
        GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
        dataTableSkill{lineEC+2,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
    end;
end;

handles.dataTableSkill = dataTableSkill;
handles.colorrowSkill = colorrow;

if strcmpi(origin, 'table') == 1;
    set(handles.StrokeData_table_analyser, 'Visible', 'off');
    set(handles.SkillData_table_analyser, 'data', dataTableSkill, 'backgroundcolor', colorrow);
    set(handles.PacingData_table_analyser, 'Visible', 'off');
    set(handles.SummaryData_table_analyser, 'Visible', 'off');

    table_extent = get(handles.SkillData_table_analyser, 'Extent');
    table_position = get(handles.SkillData_table_analyser, 'Position');
    pos_cor = table_position;
    if table_extent(4) < table_position(4);

        if Extent == 0;
            %Add 5% to give space for the slider bar at the bottom
            offset = 18;
            pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)-offset;
            pos_cor(4) = table_extent(4)+offset;
        else;
            pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)+1;
            pos_cor(4) = table_extent(4)+1;
        end;

    elseif table_extent(4) >= table_position(4);
        if table_position(2) < (0.0069*PosFig(4));
            pos_cor(2) = (0.0069*PosFig(4))+1;
            pos_cor(4) = (handles.TopINI_SkillTable*PosFig(4))+1;

            offset = 18;
            PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
            if PixelSwimmers < 200;
                PixelSwimmers = 200;
                Extent = 0;
            else;
                Extent = 1;
            end;
            ColWidth = {100 150};
            for i = 3:nbRaces+2;
                ColWidth{i} = PixelSwimmers;
            end;
            set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
        else;
            if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                pos_cor(2) = (0.0069*PosFig(4))+1;
                pos_cor(4) = (handles.TopINI_SkillTable*PosFig(4))+1;

                offset = 18;
                PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
                if PixelSwimmers < 200;
                    PixelSwimmers = 200;
                    Extent = 0;
                else;
                    Extent = 1;
                end;
                ColWidth = {100 150};
                for i = 3:nbRaces+2;
                    ColWidth{i} = PixelSwimmers;
                end;
                set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                if Extent == 0;
                    %Add 5% to give space for the slider bar at the bottom
                    offset = 18;
                    pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)-offset;
                    pos_cor(4) = table_extent(4)+offset;
                else;
                    pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)+1;
                    pos_cor(4) = table_extent(4)+1;
                end;
            end;
        end;
    end;

    if Extent == 1;
        if table_extent(3) > table_position(3);
            pos_cor(3) = table_extent(3)+1;
        end;
    end;
    set(handles.SkillData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
    set(handles.SkillData_table_analyser, 'Units', 'normalized');

    PosEND = get(handles.SkillData_table_analyser, 'Position');
    PosEND = PosEND(3);
    handles.diffPosSkillTable = PosEND - handles.PosINI_SkillTable;
end;
    
