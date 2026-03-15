if isempty(handles.filelistAdded) == 1;
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(handles, 'RacesDB') == 0;
    herror = errordlg('Update data display', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(herror);
    return;
end;

if handles.updatedfiles == 1;
    herror = errordlg('Update data display', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(herror);
    return;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
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
databaseCurrent = handles.databaseCurrent_analyser;

if ispc == 1;
    [filename, pathname] = uiputfile({'*.xlsx', 'Excel File'}, 'Save Tables As', handles.lastPath_analyser);
    if isempty(pathname) == 1;
        return;
    end;
    handles.lastPath_analyser = pathname;
elseif ismac == 1;
    [filename, pathname] = uiputfile({'*.xls', 'Excel File'}, 'Save Tables As', handles.lastPath_analyser);
    if isempty(pathname) == 1;
        return;
    end;
    handles.lastPath_analyser = pathname;
end;


if isempty(pathname) == 0;

%--------------------------Create summary table----------------------------
%--------------------------------------------------------------------------
dataTableSummary = {};
dataTableSummary{1,2} = 'Metadata';
dataTableSummary{8,2} = 'Summary';

dataTableSummary{9,1} = 'Skills';
dataTableSummary{14,1} = 'SR / SL / Stroke';
dataTableSummary{18,1} = 'Splits';
        
dataTableSummary{10,2} = 'Start Time';
dataTableSummary{11,2} = 'Finish Time';
dataTableSummary{12,2} = 'Tot Turn';
dataTableSummary{13,2} = 'Tot Skill';
dataTableSummary{15,2} = 'Out';
dataTableSummary{16,2} = 'Back';
dataTableSummary{17,2} = 'Drop Off';
dataTableSummary{19,2} = 'Out';
dataTableSummary{20,2} = 'Back';
dataTableSummary{21,2} = 'Drop Off';

rgb_val = @(r,g,b) r*1+g*256+b*256^2;
colorrowSummary(1) = rgb_val(255,230,26); %44
colorrowSummary(2) = rgb_val(230,230,230); %15
colorrowSummary(3) = rgb_val(192,192,192); %16
colorrowSummary(4) = rgb_val(230,230,230);
colorrowSummary(5) = rgb_val(192,192,192);
colorrowSummary(6) = rgb_val(230,230,230);
colorrowSummary(7) = rgb_val(255,255,255); %2
colorrowSummary(8) = rgb_val(255,230,26);
colorrowSummary(9) = rgb_val(255,230,179); %40
colorrowSummary(10) = rgb_val(230,230,230);
colorrowSummary(11) = rgb_val(192,192,192);
colorrowSummary(12) = rgb_val(230,230,230);
colorrowSummary(13) = rgb_val(192,192,192);
colorrowSummary(14) = rgb_val(255,230,179);
colorrowSummary(15) = rgb_val(230,230,230);
colorrowSummary(16) = rgb_val(192,192,192);
colorrowSummary(17) = rgb_val(230,230,230);
colorrowSummary(18) = rgb_val(255,230,179);
colorrowSummary(19) = rgb_val(230,230,230);
colorrowSummary(20) = rgb_val(192,192,192);
colorrowSummary(21) = rgb_val(230,230,230);
colorrowSummary(22) = rgb_val(192,192,192);
colorrowSummary(23) = rgb_val(230,230,230);
colorrowSummary(24) = rgb_val(192,192,192);
colorrowSummary(25) = rgb_val(230,230,230);
colorrowSummary(26) = rgb_val(192,192,192);
colorrowSummary(27) = rgb_val(230,230,230);
colorrowSummary(28) = rgb_val(192,192,192);
colorrowSummary(29) = rgb_val(230,230,230);
colorrowSummary(30) = rgb_val(192,192,192);
colorrowSummary(31) = rgb_val(230,230,230);
colorrowSummary(32) = rgb_val(192,192,192);
colorrowSummary(33) = rgb_val(230,230,230);
colorrowSummary(34) = rgb_val(192,192,192);
colorrowSummary(35) = rgb_val(230,230,230);
colorrowSummary(36) = rgb_val(192,192,192);
colorrowSummary(37) = rgb_val(230,230,230);
colorrowSummary(38) = rgb_val(192,192,192);
colorrowSummary(39) = rgb_val(230,230,230);
colorrowSummary(40) = rgb_val(192,192,192);
colorrowSummary(41) = rgb_val(230,230,230);
colorrowSummary(42) = rgb_val(192,192,192);
colorrowSummary(43) = rgb_val(230,230,230);
colorrowSummary(44) = rgb_val(192,192,192);
colorrowSummary(45) = rgb_val(230,230,230);
colorrowSummary(46) = rgb_val(192,192,192);
colorrowSummary(47) = rgb_val(230,230,230);
colorrowSummary(48) = rgb_val(192,192,192);
colorrowSummary(49) = rgb_val(230,230,230);
colorrowSummary(50) = rgb_val(192,192,192);
colorrowSummary(51) = rgb_val(230,230,230);
colorrowSummary(52) = rgb_val(192,192,192);
colorrowSummary(53) = rgb_val(230,230,230);
colorrowSummary(54) = rgb_val(192,192,192);
colorrowSummary(55) = rgb_val(230,230,230);
colorrowSummary(56) = rgb_val(192,192,192);
colorrowSummary(57) = rgb_val(230,230,230);
colorrowSummary(58) = rgb_val(192,192,192);
colorrowSummary(59) = rgb_val(230,230,230);
colorrowSummary(60) = rgb_val(192,192,192);


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
        dataTablePacingData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableStrokeData = databaseCurrent{mainIter-2,70};
        dataTableSkillData = databaseCurrent{mainIter-2,71};
        if isnan(dataTablePacingData(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTablePacingData(end,1) = str2num(racetimemissing);
        end;
    
    elseif Source == 2;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableSkillVALData = databaseCurrent{mainIter-2,70};
        dataTableSkillTXTData = databaseCurrent{mainIter-2,71};
    end;
    if Source == 1;
        answerReport = 'SP1';
        dataTableSummary{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        answerReport = 'SP2';
        dataTableSummary{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        answerReport = 'GE';
        dataTableSummary{7,mainIter} = 'GreenEye';
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
    eval(['dataTableSummary{2,' num2str(mainIter) '} = Athletename;']);
    
    Meet = databaseCurrent{mainIter-2,7};
    Stage = databaseCurrent{mainIter-2,6};
    Year = databaseCurrent{mainIter-2,8};
    StrokeType = databaseCurrent{mainIter-2,4};
    RaceDist = str2num(databaseCurrent{mainIter-2,3});
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSummary{3,' num2str(mainIter) '} = str;']);  
    Course = str2num(databaseCurrent{mainIter-2,10});

    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableSummary{5,' num2str(mainIter) '} = str;']);
    
%     eval(['splitAll = handles.RacesDB.' UID '.splitAll;']);
    if Source == 1 | Source == 3;
        colinterest_Splits = 1;
        TTtxt = timeSecToStr(dataTablePacingData(end,colinterest_Splits));
    else;
        colinterest_Splits = 11;
        TTtxt = timeSecToStr(dataTableAverageData{end,colinterest_Splits});
    end;
    dataTableSummary{6,mainIter} = TTtxt;
    KicksNb = databaseCurrent{mainIter-2,64};


    %--------------------------------Summary-------------------------------
    NbLap = RaceDist./Course;
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        RT = dataTableSkillData{16,3};
        index = strfind(RT, ' ');
        RT = str2num(RT(1:index(1)-1));

        colinterest_SplitsInterp = 4;

        DiveT15 = dataTableSkillData{15,3};
        index = strfind(DiveT15, ' ');
        DiveT15 = str2num(DiveT15(1:index(1)-1));
        STtxt = timeSecToStr(DiveT15);
        if dataTablePacingData(3,colinterest_SplitsInterp) == 1;
            STtxt = [STtxt ' !'];
        end;

        valFinishTime = dataTableSkillData{32,3};
        index = strfind(valFinishTime, ' ');
        valFinishTime = str2num(valFinishTime(1:index(1)-1));
        TLtxt = timeSecToStr(valFinishTime);

        BOKick_Start = dataTableSkillData{21,3};
        index = strfind(BOKick_Start, ' ');
        BOKick_Start = str2num(BOKick_Start(1:index(1)));
    
        BOTime_Start = dataTableSkillData{23,3};
        index1 = strfind(BOTime_Start, ' ');
        index2 = strfind(BOTime_Start, 's');
        index3 = strfind(BOTime_Start, '!');
        if isempty(index3) == 0;
            interpolationBOTime_Start = 1;
        else;
            interpolationBOTime_Start = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BOTime_Start(index) = [];
        end;
        BOTime_Start = str2num(BOTime_Start);
    
        BODist_Start = dataTableSkillData{22,3};
        index1 = strfind(BODist_Start, ' ');
        index2 = strfind(BODist_Start, 'm');
        index3 = strfind(BODist_Start, '!');
        if isempty(index3) == 0;
            interpolationBODist_Start = 1;
        else;
            interpolationBODist_Start = 0;
        end;
        index = [index1 index2 index3];
        if isempty(index) == 0;
            BODist_Start(index) = [];
        end;
        BODist_Start = str2num(BODist_Start);
        BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

        if NbLap == 1;
            TTtxt = ['  -  '];
        else;

            AvturnTXT = dataTableSkill{26,3};
            index = strfind(AvturnTXT, '/');
            AvinTime = AvturnTXT(1:index(1)-2);
            AvoutTime = AvturnTXT(index(1)+2:index(2)-2);
            AvtotTime = AvturnTXT(index(2)+2:end-2);

            index1 = strfind(AvtotTime, ' ');
            index2 = strfind(AvtotTime, 's');
            index3 = strfind(AvtotTime, '!');
            if isempty(index3) == 0;
                interpolationAvTurnTot = 1;
            else;
                interpolationAvTurnTot = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                AvtotTime(index) = [];
            end;

            TTTurn = dataTableSkill{13,3};
            index = strfind(TTTurn, '/');
            TTTurn = TTTurn(index(end)+3:end);
            indexCheck = strfind(TTTurn, ':');
            if isempty(indexCheck) == 1;
                %Time is in sec
                index1 = strfind(TTTurn, ' ');
                index2 = strfind(TTTurn, 's');
                index3 = strfind(TTTurn, '!');
                if isempty(index3) == 0;
                    interpolationTTTurn = 1;
                else;
                    interpolationTTTurn = 0;
                end;
                index = [index1 index2 index3];
                if isempty(index) == 0;
                    TTTurn(index) = [];
                end;
                TTTurn = str2num(TTTurn);
            else;
                %Time is in minutes
                index1 = strfind(TTTurn, ':');
                index2 = strfind(TTTurn, '.');
                index3 = strfind(TTTurn, ' ');
                index4 = strfind(TTTurn, '!');
        
                if isempty(index4) == 0;
                    interpolationTTTurn = 1;
                else;
                    interpolationTTTurn = 0;
                end;
        
                index = [index3 index4];
                if isempty(index) == 0;
                    TTTurn(index) = [];
                end;
        
                minuVal = 60.*str2num(TTTurn(1:index1-1));
                if isempty(index4) == 1
                    secoVal = str2num(TTTurn(index1+1:end));
                else;
                    secoVal = str2num(TTTurn(index1+1:index3-1));
                end;
                TTTurn = minuVal + secoVal;
            end;
            if isempty(find(interpolationAvTurnTot) == 1);
                %no interpolation
                TTtxt = [timeSecToStr(TTTurn)];
            else;
                TTtxt = [timeSecToStr(TTTurn) ' !'];
            end;
        end;

        valSkillTime = dataTableSkillData{10,3};
        indexCheck = strfind(valSkillTime, ':');
        if isempty(indexCheck) == 1;
            %Time is in sec
            index1 = strfind(valSkillTime, ' ');
            index2 = strfind(valSkillTime, 's');
            index3 = strfind(valSkillTime, '!');
            if isempty(index3) == 0;
                interpolationSkillTime = 1;
            else;
                interpolationSkillTime = 0;
            end;
            index = [index1 index2 index3];
            if isempty(index) == 0;
                valSkillTime(index) = [];
            end;
            valSkillTime = str2num(valSkillTime);
        else;
            %Time is in minutes
            index1 = strfind(valSkillTime, ':');
            index2 = strfind(valSkillTime, '.');
            index3 = strfind(valSkillTime, ' ');
            index4 = strfind(valSkillTime, '!');
    
            if isempty(index4) == 0;
                interpolationSkillTime = 1;
            else;
                interpolationSkillTime = 0;
            end;
    
            index = [index3 index4];
            if isempty(index) == 0;
                valSkillTime(index) = [];
            end;
    
            minuVal = 60.*str2num(valSkillTime(1:index1-1));
            if isempty(index4) == 1
                secoVal = str2num(valSkillTime(index1+1:end));
            else;
                secoVal = str2num(valSkillTime(index1+1:index3-1));
            end;
            valSkillTime = minuVal + secoVal;
        end;
        valFreeSwimTime = dataTablePacingData(end,colinterest_Splits) - valSkillTime;

    elseif strcmpi(answerReport, 'SP2') == 1;
        turnTimeALL = dataTableSkillVALData{1,2};
        RT = dataTableSkillVALData{1,22};

        DiveT15 = dataTableSkillVALData{1,5};
        STtxt = timeSecToStr(DiveT15);

        valFinishTime = dataTableAverageData{end,12} - dataTableAverageData{end-1,12};
        TLtxt = timeSecToStr(valFinishTime);

        BOAll = dataTableSkillVALData{1,24};
        BOKick_Start = KicksNb(1,1);
        BOTime_Start = BOAll(1,2);
        BODist_Start = BOAll(1,3);
        BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

        TTTurn = sum(turnTimeALL);
        TTtxt = timeSecToStr(TTTurn);
        
        valSkillTime = DiveT15 + sum(turnTimeALL) + valFinishTime;
        valFreeSwimTime = dataTableAverageData{end,12} - valSkillTime;
        interpolationSkillTime = 0;

    end;
    dataTableSummary{10,mainIter} = STtxt;
    dataTableSummary{11,mainIter} = TLtxt;
    if Course == 50;
        if RaceDist == 50;
            dataTableSummary{12,mainIter} = '  -  ';
        else;
            dataTableSummary{12,mainIter} = TTtxt;
        end;
    else;
        dataTableSummary{12,mainIter} = TTtxt;
    end;

    SkillTime = timeSecToStr2(roundn(valSkillTime,-2));
    FreeSwimTime = timeSecToStr2(roundn(valFreeSwimTime,-2));
    if interpolationSkillTime == 1;
        TotalSkillTimetxt = [SkillTime ' !'];
        FreeSwimTime = [FreeSwimTime ' !'];
    else;
        TotalSkillTimetxt = SkillTime;
        FreeSwimTime = [FreeSwimTime '  '];
    end;
    dataTableSummary{13,mainIter} = TotalSkillTimetxt;



    if Course == 50
        if RaceDist == 50;
            if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
                valSR = dataTableStrokeData(:, 1);
            elseif strcmpi(answerReport, 'SP2') == 1;
                valSR = dataTableAverageData(:,5);
                valSRmat = [];
                for valEC = 1:length(valSR);
                    if isempty(valSR{valEC,1}) == 1;
                        valSRmat(valEC,1) = NaN;
                    else;
                        valSRmat(valEC,1) = valSR{valEC,1};
                    end;
                end;
                valSR = valSRmat;
            end;
            caseSR = 1;
        else;
            avSRlap = databaseCurrent{mainIter-2,49};
            caseSR = 2;
        end;
    else;
        avSRlap = databaseCurrent{mainIter-2,49};
        caseSR = 2;
    end;
    if caseSR == 1;
        SRhalf = valSR(1:5,1);
        index = find(isnan(SRhalf) == 0);
        SRhalf = SRhalf(index,1);
        SRMOut = roundn(mean(SRhalf),-1);
        
        SRhalf = valSR(6:10,1);
        index = find(isnan(SRhalf) == 0);
        SRhalf = SRhalf(index,1);
        SRMBack = roundn(mean(SRhalf),-1);
        
    elseif caseSR == 2;
        SRMOut = avSRlap(1:(NbLap./2));
        SRMOut = roundn(mean(SRMOut),-1);
    
        SRMBack = avSRlap((NbLap./2)+1:end);
        SRMBack = roundn(mean(SRMBack),-1);
    end;
    
    
    
    if Course == 50
        if RaceDist == 50;
            if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
                valDPS = dataTableStrokeData(:, 5);
            elseif strcmpi(answerReport, 'SP2') == 1;
                valDPS = dataTableAverageData(:,8);
                valDPSmat = [];
                for valEC = 1:length(valDPS);
                    if isempty(valDPS{valEC,1}) == 1;
                        valDPSmat(valEC,1) = NaN;
                    else;
                        valDPSmat(valEC,1) = valDPS{valEC,1};
                    end;
                end;
                valDPS = valDPSmat;
            end;
            caseDPS = 1;
        else;
            avDPSlap = databaseCurrent{mainIter-2,50};
            caseDPS = 2;
        end;
    else;
        avDPSlap = databaseCurrent{mainIter-2,50};
        caseDPS = 2;
    end;
    if caseDPS == 1;
        DPShalf = valDPS(1:5,1);
        index = find(isnan(DPShalf) == 0);
        DPShalf = DPShalf(index,1);
        SLMOut = roundn(mean(DPShalf),-1);
        
        DPShalf = valDPS(6:10,1);
        index = find(isnan(DPShalf) == 0);
        DPShalf = DPShalf(index,1);
        SLMBack = roundn(mean(DPShalf),-1);
        
    elseif caseSR == 2;
        DPSMOut = avDPSlap(1:(NbLap./2));
        SLMOut = roundn(mean(DPSMOut),-1);
    
        DPSMBack = avDPSlap((NbLap./2)+1:end);
        SLMBack = roundn(mean(DPSMBack),-1);
    end;

    

    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        valSN = dataTableStrokeData(:,9);
    elseif strcmpi(answerReport, 'SP2') == 1;
        valSN = cell2mat(dataTableAverageData(:,14));
    end;

    if Course == 50;
        posHalf = (NbLap/2).*10;
    else;
        posHalf = (NbLap/2).*5;
    end;
    SNhalf = valSN(1:posHalf,1);
    index = find(isnan(SNhalf) == 0);
    SNhalf = SNhalf(index,1);
    SNMOut = sum(SNhalf);
    
    SNhalf = valSN(posHalf+1:end,1);
    index = find(isnan(SNhalf) == 0);
    SNhalf = SNhalf(index,1);
    SNMBack = sum(SNhalf);
    

    SRMOuttxt = dataToStr(SRMOut,1);
    SLMOuttxt = dataToStr(SLMOut,2);
    SNMOuttxt = num2str(SNMOut);
    dataTableSummary{15,mainIter} = [SRMOuttxt ' str/min' '   ' SLMOuttxt ' m' '   ' SNMOuttxt ' str'];
    if NbLap == 1
        dataTableSummary{16,mainIter} = ['  -  /  -  /  -  '];
    else;
        SRMBacktxt = dataToStr(SRMBack,1);
        SLMBacktxt = dataToStr(SLMBack,2);
        SNMBacktxt = num2str(SNMBack);
        dataTableSummary{16,mainIter} = [SRMBacktxt ' str/min' '   ' SLMBacktxt ' m' '   ' SNMBacktxt ' str'];
    end;
    
    if NbLap == 1;
        dataTableSummary{17,mainIter} = ['  -  /  -  /  -  '];
    else;
        diffSRMtxt = dataToStr(SRMBack-SRMOut,1);
        if (SRMBack-SRMOut) < 0;
            diffSRMtxt = ['-' diffSRMtxt(2:end)];
        elseif (SRMBack-SRMOut) > 0;
            diffSRMtxt = ['+' diffSRMtxt];
        else;
            diffSRMtxt = ['=' diffSRMtxt];
        end;
        diffSLMtxt = dataToStr(SLMBack-SLMOut,2);
        if (SLMBack-SLMOut) < 0;
            diffSLMtxt = ['-' diffSLMtxt(2:end)];
        elseif (SRMBack-SRMOut) > 0;
            diffSLMtxt = ['+' diffSLMtxt];
        else;
            diffSLMtxt = ['=' diffSLMtxt];
        end;

        diffStrtxt = num2str(SNMBack-SNMOut);
        if roundn((SNMBack-SNMOut),0) < 0;
            diffStrtxt = ['-' diffStrtxt(2:end)];
        elseif roundn((SNMBack-SNMOut),0) > 0;
            diffStrtxt = ['+' diffStrtxt];
        else;
            diffStrtxt = ['=' diffStrtxt];
        end;
        dataTableSummary{17,mainIter} = [diffSRMtxt ' str/min' '   ' diffSLMtxt ' m' '   ' diffStrtxt ' str'];
    end;

    
    RTtxt = timeSecToStr(roundn(RT,-2));
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        splitAll = dataTablePacingData(:,colinterest_Splits);
    elseif strcmpi(answerReport, 'SP2') == 1;
        splitAll = cell2mat(dataTableAverageData(:,colinterest_Splits));
    end;
    if NbLap == 1;
        SplitEnd = splitAll(end,1);
        SplitEndtxt = timeSecToStr(SplitEnd);
        
        dataTableSummary{19,mainIter} =  [SplitEndtxt ' (100 %)'];
        dataTableSummary{20,mainIter} =  '-';
        dataTableSummary{21,mainIter} =  '-';
    else;
        SplitMid = splitAll(posHalf,1);
        SplitEnd = splitAll(end,1) - SplitMid;
        SplitMidP = roundn((SplitMid/splitAll(end,1)*100), -2);
        SplitEndP = roundn((SplitEnd/splitAll(end,1)*100), -2);
        DropOff = SplitEnd - SplitMid;
        
        SplitMidtxt = timeSecToStr(SplitMid);
        SplitEndtxt = timeSecToStr(SplitEnd);
        SplitMidPtxt = dataToStr(SplitMidP,2);
        SplitEndPtxt = dataToStr(SplitEndP,2);
        dataTableSummary{19,mainIter} =  [SplitMidtxt ' (' num2str(SplitMidPtxt) ' %)'];
        dataTableSummary{20,mainIter} =  [SplitEndtxt ' (' num2str(SplitEndPtxt) ' %)'];
        
        DropOfftxt = num2str(DropOff);
        if DropOff > 0;
            DropOfftxt = ['+' DropOfftxt ' s'];
        elseif DropOff < 0;
            DropOfftxt = ['-' DropOfftxt(2:end) ' s'];
        else;
            DropOfftxt = ['=' DropOfftxt ' s'];
        end;
        dataTableSummary{21,mainIter} =  DropOfftxt;
    end;

    dataTableSummary{22,2} = 'Block';
    dataTableSummary{22,mainIter} = RTtxt;
    if RaceDist == 50;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(splitAll(5,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(splitAll(10,1));
            datatxt = timeSecToStr(splitAll(10,1)-splitAll(5,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(splitAll(10,1));
            dataTableSummary{23,mainIter} = datatxt;
        end;
    elseif RaceDist == 100;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(splitAll(5,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(splitAll(10,1));
            datatxt = timeSecToStr(splitAll(10,1)-splitAll(5,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '75m';
            dataTOTtxt = timeSecToStr(splitAll(15,1));
            datatxt = timeSecToStr(splitAll(15,1)-splitAll(10,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '100m';
            dataTOTtxt = timeSecToStr(splitAll(20,1));
            datatxt = timeSecToStr(splitAll(20,1)-splitAll(15,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(splitAll(10,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(splitAll(20,1));
            datatxt = timeSecToStr(splitAll(20,1)-splitAll(10,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
        
    elseif RaceDist == 150;
        if Course == 25;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(splitAll(10,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(splitAll(20,1));
            datatxt = timeSecToStr(splitAll(20,1)-splitAll(10,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(splitAll(30,1));
            datatxt = timeSecToStr(splitAll(30,1)-splitAll(20,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(splitAll(10,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(splitAll(20,1));
            datatxt = timeSecToStr(splitAll(20,1)-splitAll(10,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(splitAll(30,1));
            datatxt = timeSecToStr(splitAll(30,1)-splitAll(20,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
        
    elseif RaceDist == 200;
        if Course == 25;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(splitAll(10,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(splitAll(20,1));
            datatxt = timeSecToStr(splitAll(20,1)-splitAll(10,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(splitAll(30,1));
            datatxt = timeSecToStr(splitAll(30,1)-splitAll(20,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(splitAll(40,1));
            datatxt = timeSecToStr(splitAll(40,1)-splitAll(30,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];

        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(splitAll(10,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(splitAll(20,1));
            datatxt = timeSecToStr(splitAll(20,1)-splitAll(10,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(splitAll(30,1));
            datatxt = timeSecToStr(splitAll(30,1)-splitAll(20,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(splitAll(40,1));
            datatxt = timeSecToStr(splitAll(40,1)-splitAll(30,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
        
    elseif RaceDist == 400;
        if Course == 25;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(splitAll(20,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(splitAll(40,1));
            datatxt = timeSecToStr(splitAll(40,1) - splitAll(20,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(splitAll(60,1));
            datatxt = timeSecToStr(splitAll(60,1) - splitAll(40,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(splitAll(80,1));
            datatxt = timeSecToStr(splitAll(80,1) - splitAll(60,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];

        else;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(splitAll(20,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(splitAll(40,1));
            datatxt = timeSecToStr(splitAll(40,1) - splitAll(20,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(splitAll(60,1));
            datatxt = timeSecToStr(splitAll(60,1) - splitAll(40,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(splitAll(80,1));
            datatxt = timeSecToStr(splitAll(80,1) - splitAll(60,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;

    elseif RaceDist == 800;
        if Course == 25;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(splitAll(40,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(splitAll(80,1));
            datatxt = timeSecToStr(splitAll(80,1) - splitAll(40,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(splitAll(120,1));
            datatxt = timeSecToStr(splitAll(120,1) - splitAll(80,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(splitAll(160,1));
            datatxt = timeSecToStr(splitAll(160,1) - splitAll(120,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(splitAll(40,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(splitAll(80,1));
            datatxt = timeSecToStr(splitAll(80,1) - splitAll(40,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(splitAll(120,1));
            datatxt = timeSecToStr(splitAll(120,1) - splitAll(80,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(splitAll(160,1));
            datatxt = timeSecToStr(splitAll(160,1) - splitAll(120,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;

    elseif RaceDist == 1500;
        if Course == 25;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(splitAll(80,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(splitAll(160,1));
            datatxt = timeSecToStr(splitAll(160,1) - splitAll(80,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(splitAll(240,1));
            datatxt = timeSecToStr(splitAll(240,1) - splitAll(160,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(splitAll(300,1));
            datatxt = timeSecToStr(splitAll(300,1) - splitAll(240,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(splitAll(80,1));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(splitAll(160,1));
            datatxt = timeSecToStr(splitAll(160,1) - splitAll(80,1));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(splitAll(240,1));
            datatxt = timeSecToStr(splitAll(240,1) - splitAll(160,1));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(splitAll(300,1));
            datatxt = timeSecToStr(splitAll(300,1) - splitAll(240,1));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
    end;
end;
if RaceDist == 50;
    if Course == 25;
        limli_Summary = 24;
    else;
        limli_Summary = 23;
    end;

elseif RaceDist == 100;
    if Course == 25;
        limli_Summary = 26;
    else;
        limli_Summary = 24;
    end;
    
elseif RaceDist == 150;
    if Course == 25;
        limli_Summary = 28;
    else;
        limli_Summary = 25;
    end;
    
elseif RaceDist == 200;
    if Course == 25;
        limli_Summary = 26;
    else;
        limli_Summary = 26;
    end;
    
elseif RaceDist == 400;
    if Course == 25;
        limli_Summary = 26;
    else;
        limli_Summary = 26;
    end;

elseif RaceDist == 800;
    if Course == 25;
        limli_Summary = 26;
    else;
        limli_Summary = 26;
    end;

elseif RaceDist == 1500;
    if Course == 25;
        limli_Summary = 26;
    else;
        limli_Summary = 26;
    end;
end;
colorrowSummary = colorrowSummary(1:limli_Summary);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%---------------------------Create stroke table----------------------------
%--------------------------------------------------------------------------
colorrowStroke(1) = rgb_val(255,230,26);
colorrowStroke(2) = rgb_val(230,230,230);
colorrowStroke(3) = rgb_val(192,192,192);
colorrowStroke(4) = rgb_val(230,230,230);
colorrowStroke(5) = rgb_val(192,192,192);
colorrowStroke(6) = rgb_val(230,230,230);
colorrowStroke(7) = rgb_val(255,255,255);
colorrowStroke(8) = rgb_val(255,230,26);

dataTableStroke = {};
dataTableStroke{1,2} = 'Metadata';
dataTableStroke{8,2} = 'Stroke Management';
dataTableStroke{9,1} = 'SR / SL / Stroke';

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
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableStrokeData = databaseCurrent{mainIter-2,70};
        dataTableSkillData = databaseCurrent{mainIter-2,71};
        if isnan(dataTableAverageData(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTableAverageData(end,1) = str2num(racetimemissing);
        end;
    
    elseif Source == 2;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableSkillVALData = databaseCurrent{mainIter-2,70};
        dataTableSkillTXTData = databaseCurrent{mainIter-2,71};
    end;
    if Source == 1;
        answerReport = 'SP1';
        dataTableStroke{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        answerReport = 'SP2';
        dataTableStroke{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        answerReport = 'GE';
        dataTableStroke{7,mainIter} = 'GreenEye';
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
    eval(['dataTableStroke{2,' num2str(mainIter) '} = Athletename;']);
    
    Meet = databaseCurrent{mainIter-2,7};
    Stage = databaseCurrent{mainIter-2,6};
    Year = databaseCurrent{mainIter-2,8};
    StrokeType = databaseCurrent{mainIter-2,4};
    RaceDist = str2num(databaseCurrent{mainIter-2,3});
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableStroke{3,' num2str(mainIter) '} = str;']);  
    Course = str2num(databaseCurrent{mainIter-2,10});

    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableStroke{5,' num2str(mainIter) '} = str;']);
    
%     eval(['splitAll = handles.RacesDB.' UID '.splitAll;']);
    if Source == 1 | Source == 3;
        colinterest_Splits = 2;
        TTtxt = timeSecToStr(dataTableAverageData(end,colinterest_Splits));
        splitAll = dataTableAverageData(:,colinterest_Splits);
    else;
        colinterest_Splits = 12;
        TTtxt = timeSecToStr(dataTableAverageData{end,colinterest_Splits});
        splitAll = cell2mat(dataTableAverageData(:,colinterest_Splits));
    end;
    dataTableStroke{6,mainIter} = TTtxt;

    idx = isstrprop(Meet,'upper');
    MeetShort = Meet(idx);
    if strcmpi(Stage, 'Semi-Final');
        StageShort = 'SF';
    elseif strcmpi(Stage, 'Semi-final');
        StageShort = 'SF';
    else;
        StageShort = Stage;
    end;
    YearShort = Year(3:4);
    graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
    storeTitle2{i-2} = graphTitle2;
    

    %---------------------------------Stroke-------------------------------
    NbLap = RaceDist./Course;
    if i == 3;
        colorrowStroke(9) = rgb_val(255,230,179);
        lineEC = 10;
        for lap = 1:NbLap;
            dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-25m';

                colorrowStroke(lineEC) = rgb_val(255,230,153);
                colorrowStroke(lineEC+1) = rgb_val(230,230,230);
                colorrowStroke(lineEC+2) = rgb_val(192,192,192);
                colorrowStroke(lineEC+3) = rgb_val(230,230,230);
                colorrowStroke(lineEC+4) = rgb_val(192,192,192);
                colorrowStroke(lineEC+5) = rgb_val(230,230,230);

                lineEC = lineEC + 6;
            else;
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-25m';
                dataTableStroke{lineEC+6,2} = '25m-30m';
                dataTableStroke{lineEC+7,2} = '30m-35m';
                dataTableStroke{lineEC+8,2} = '35m-40m';
                dataTableStroke{lineEC+9,2} = '40m-45m';
                dataTableStroke{lineEC+10,2} = '45m-50m';

                colorrowStroke(lineEC) = rgb_val(255,230,153);
                colorrowStroke(lineEC+1) = rgb_val(230,230,230);
                colorrowStroke(lineEC+2) = rgb_val(192,192,192);
                colorrowStroke(lineEC+3) = rgb_val(230,230,230);
                colorrowStroke(lineEC+4) = rgb_val(192,192,192);
                colorrowStroke(lineEC+5) = rgb_val(230,230,230);
                colorrowStroke(lineEC+6) = rgb_val(192,192,192);
                colorrowStroke(lineEC+7) = rgb_val(230,230,230);
                colorrowStroke(lineEC+8) = rgb_val(192,192,192);
                colorrowStroke(lineEC+9) = rgb_val(230,230,230);
                colorrowStroke(lineEC+10) = rgb_val(192,192,192);

                lineEC = lineEC + 11;
            end;
        end;
    end;

    lineEC = 10;
    keyDist = Course:Course:RaceDist;
    dataTableRefDist = [5:5:RaceDist]';

    if Source == 1 | Source == 3;
        colinterest_Splits = 1;
        colinterest_SplitsInterp = 4;

        colinterest_Speed = 5;
        colinterest_SpeedInterp = 4; %use split interpolation
        
        colinterest_DPS = 5;
        colinterest_DPSInterp = 8;

        colinterest_SR = 1;
        colinterest_SRInterp = 4;

        colinterest_Nb = 9;

    elseif Source == 2;
        colinterest_Splits = 11;
        colinterest_SplitsInterp = [];

        colinterest_Speed = 2;
        colinterest_SpeedInterp = [];

        colinterest_DPS = 8;
        colinterest_DPSInterp = [];

        colinterest_SR = 5;
        colinterest_SRInterp = [];

        colinterest_Nb = 14;
    end;

    addLap = 0;
    lastIterValid = 0;
    for iter = 1:length(dataTableAverageData(:,1));
        
        if Source == 1 | Source == 3;
            if isnan(dataTableStrokeData(iter,colinterest_DPS)) == 1 | dataTableStrokeData(iter,colinterest_DPS) == 0;
                SDtxt = '  -  ';
            else;
                if dataTableStrokeData(iter,colinterest_DPSInterp) == 1;
                    SDtxt = [dataToStr(dataTableStrokeData(iter,colinterest_DPS),2) ' m !'];
                else;
                    SDtxt = [dataToStr(dataTableStrokeData(iter,colinterest_DPS),2) ' m  '];
                end;
            end;

            if isnan(dataTableStrokeData(iter,colinterest_SR)) == 1 | dataTableStrokeData(iter,colinterest_SR) == 0;
                SRtxt = '  -  ';
            else;
                if dataTableStrokeData(iter,colinterest_SRInterp) == 1;
                    SRtxt = [dataToStr(dataTableStrokeData(iter,colinterest_SR),1) ' str/min !'];
                else;
                    SRtxt = [dataToStr(dataTableStrokeData(iter,colinterest_SR),1) ' str/min  '];
                end;
            end;

            if isnan(dataTableStrokeData(iter,colinterest_Nb)) == 1 | dataTableStrokeData(iter,colinterest_Nb) == 0;
                Nbtxt = '  -  ';
            else;
                Nbtxt = [dataToStr(dataTableStrokeData(iter,colinterest_Nb),0) ' str'];
            end;

        elseif Source == 2;   
            if isempty(dataTableAverageData{iter,colinterest_DPS}) == 1;
                SDtxt = '  -  ';
            else;
                if isnan(dataTableAverageData{iter,colinterest_DPS}) == 1 | dataTableAverageData{iter,colinterest_DPS} == 0;
                    SDtxt = '  -  ';
                else;
                    SDtxt = [dataToStr(dataTableAverageData{iter,colinterest_DPS},2) ' m  '];
                end;
            end;

            if isempty(dataTableAverageData{iter,colinterest_SR}) == 1;
                SRtxt = '  -  ';
            else;
                if isnan(dataTableAverageData{iter,colinterest_SR}) == 1 | dataTableAverageData{iter,colinterest_SR} == 0;
                    SRtxt = '  -  ';
                else;
                    SRtxt = [dataToStr(dataTableAverageData{iter,colinterest_SR},1) ' str/min  '];
                end;
            end;

            if isempty(dataTableAverageData{iter,colinterest_Nb}) == 1;
                Nbtxt = '  -  ';
            else;
                if isnan(dataTableAverageData{iter,colinterest_Nb}) == 1 | dataTableAverageData{iter,colinterest_Nb} == 0;
                    Nbtxt = '  -  ';
                else;
                    Nbtxt = [dataToStr(dataTableAverageData{iter,colinterest_Nb},0) ' str'];
                end;
            end;
        end;

%         if strcmpi(STtxt, '  -  ') == 1;
%             data = [SRtxt '  /  ' CTtxt '  /    -  '];
%         else;
            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
%         end;
        eval(['dataTableStroke{' num2str(lineEC+iter+addLap) ',' num2str(i) '} = data;']);

        index = find(keyDist == dataTableRefDist(iter));
        if isempty(index) == 0;
            addLap = addLap + 1;
        end;
    end;
end;
if Course == 50;
    limli_Stroke = length(dataTableStroke); % lineEC - 11 + 9;
else;
    limli_Stroke = length(dataTableStroke); % lineEC - 6 + 4;
end;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------



%---------------------------Create pacing table----------------------------
%--------------------------------------------------------------------------
dataTablePacing = {};
dataTablePacing{1,2} = 'Metadata';
dataTablePacing{8,2} = 'Pacing';
dataTablePacing{9,1} = 'Splits / Cumul';
dataTablePacing{9,2} = ' / Speed';

colorrowPacing(1) = rgb_val(255,230,26);
colorrowPacing(2) = rgb_val(230,230,230);
colorrowPacing(3) = rgb_val(192,192,192);
colorrowPacing(4) = rgb_val(230,230,230);
colorrowPacing(5) = rgb_val(192,192,192);
colorrowPacing(6) = rgb_val(230,230,230);
colorrowPacing(7) = rgb_val(255,255,255);
colorrowPacing(8) = rgb_val(255,230,26);

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
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableStrokeData = databaseCurrent{mainIter-2,70};
        dataTableSkillData = databaseCurrent{mainIter-2,71};
        if isnan(dataTableAverageData(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTableAverageData(end,1) = str2num(racetimemissing);
        end;
    
    elseif Source == 2;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableSkillVALData = databaseCurrent{mainIter-2,70};
        dataTableSkillTXTData = databaseCurrent{mainIter-2,71};
    end;
    if Source == 1;
        answerReport = 'SP1';
        dataTablePacing{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        answerReport = 'SP2';
        dataTablePacing{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        answerReport = 'GE';
        dataTablePacing{7,mainIter} = 'GreenEye';
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
    eval(['dataTablePacing{2,' num2str(mainIter) '} = Athletename;']);
    
    Meet = databaseCurrent{mainIter-2,7};
    Stage = databaseCurrent{mainIter-2,6};
    Year = databaseCurrent{mainIter-2,8};
    StrokeType = databaseCurrent{mainIter-2,4};
    RaceDist = str2num(databaseCurrent{mainIter-2,3});
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTablePacing{3,' num2str(mainIter) '} = str;']);  
    Course = str2num(databaseCurrent{mainIter-2,10});

    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTablePacing{5,' num2str(mainIter) '} = str;']);
    
%     eval(['splitAll = handles.RacesDB.' UID '.splitAll;']);
    if Source == 1 | Source == 3;
        colinterest_Splits = 2;
        TTtxt = timeSecToStr(dataTableAverageData(end,colinterest_Splits));
        splitAll = dataTableAverageData(:,colinterest_Splits);
    else;
        colinterest_Splits = 12;
        TTtxt = timeSecToStr(dataTableAverageData{end,colinterest_Splits});
        splitAll = cell2mat(dataTableAverageData(:,colinterest_Splits));
    end;
    dataTablePacing{6,mainIter} = TTtxt;

    if Source == 1;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP1']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(splitAll(end,1)) '  -  SP1']};
    elseif Source == 2;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP2']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(splitAll(end,1)) '  -  SP2']};
    elseif Source == 3;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-GE']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(splitAll(end,1)) '  -  GE']};
    end;
    storeTitle{i-2} = graphTitle;
    storeTitleBis{i-2} = graphTitleBis;

    idx = isstrprop(Meet,'upper');
    MeetShort = Meet(idx);
    if strcmpi(Stage, 'Semi-Final');
        StageShort = 'SF';
    elseif strcmpi(Stage, 'Semi-final');
        StageShort = 'SF';
    else;
        StageShort = Stage;
    end;
    YearShort = Year(3:4);
    graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
    storeTitle2{i-2} = graphTitle2;


    
    %---------------------------------Pacing-------------------------------
    NbLap = RaceDist./Course;
    if i == 3;
        colorrowPacing(9) = rgb_val(255,230,179);
        lineEC = 10;
        lineECmat = 1;
        for lap = 1:NbLap;
            dataTablePacing{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = '20m-25m';
                
%                 dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
%                 dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
%                 dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
%                 dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
%                 dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;

                colorrowPacing(lineEC) = rgb_val(255,230,153);
                colorrowPacing(lineEC+1) = rgb_val(230,230,230);
                colorrowPacing(lineEC+2) = rgb_val(192,192,192);
                colorrowPacing(lineEC+3) = rgb_val(230,230,230);
                colorrowPacing(lineEC+4) = rgb_val(192,192,192);
                colorrowPacing(lineEC+5) = rgb_val(230,230,230);

                lineEC = lineEC + 6;
                lineECmat = lineECmat + 5;
            else;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = '20m-25m';
                dataTablePacing{lineEC+6,2} = '25m-30m';
                dataTablePacing{lineEC+7,2} = '30m-35m';
                dataTablePacing{lineEC+8,2} = '35m-40m';
                dataTablePacing{lineEC+9,2} = '40m-45m';
                dataTablePacing{lineEC+10,2} = '45m-50m';
                
%                 dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
%                 dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
%                 dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
%                 dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
%                 dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
%                 dataMatSplitsPacing(lineECmat+5, 1) = (Course*(lap-1)) + 30;
%                 dataMatSplitsPacing(lineECmat+6, 1) = (Course*(lap-1)) + 35;
%                 dataMatSplitsPacing(lineECmat+7, 1) = (Course*(lap-1)) + 40;
%                 dataMatSplitsPacing(lineECmat+8, 1) = (Course*(lap-1)) + 45;
%                 dataMatSplitsPacing(lineECmat+9, 1) = (Course*(lap-1)) + 50;

                colorrowPacing(lineEC) = rgb_val(255,230,153);
                colorrowPacing(lineEC+1) = rgb_val(230,230,230);
                colorrowPacing(lineEC+2) = rgb_val(192,192,192);
                colorrowPacing(lineEC+3) = rgb_val(230,230,230);
                colorrowPacing(lineEC+4) = rgb_val(192,192,192);
                colorrowPacing(lineEC+5) = rgb_val(230,230,230);
                colorrowPacing(lineEC+6) = rgb_val(192,192,192);
                colorrowPacing(lineEC+7) = rgb_val(230,230,230);
                colorrowPacing(lineEC+8) = rgb_val(192,192,192);
                colorrowPacing(lineEC+9) = rgb_val(230,230,230);
                colorrowPacing(lineEC+10) = rgb_val(192,192,192);

                lineEC = lineEC + 11;
                lineECmat = lineECmat + 10;
            end;
        end;
    end;

    lineEC = 10;
    keyDist = Course:Course:RaceDist;
    dataTableRefDist = [5:5:RaceDist]';

    if Source == 1 | Source == 3;
        colinterest_Splits = 1;
        colinterest_SplitsInterp = 4;

        colinterest_Speed = 5;
        colinterest_SpeedInterp = 4; %use split interpolation
        
        colinterest_DPS = 5;
        colinterest_DPSInterp = 8;

        colinterest_SR = 1;
        colinterest_SRInterp = 4;
    elseif Source == 2;
        colinterest_Splits = 11;
        colinterest_SplitsInterp = [];

        colinterest_Speed = 2;
        colinterest_SpeedInterp = [];

        colinterest_DPS = 8;
        colinterest_DPSInterp = [];

        colinterest_SR = 5;
        colinterest_SRInterp = [];
    end;

    addLap = 0;
    lastIterValid = 0;
    for iter = 1:length(dataTableAverageData(:,1));
        
        if Source == 1 | Source == 3;
            if isnan(dataTableAverageData(iter,colinterest_Speed)) == 1 | dataTableAverageData(iter,colinterest_Speed) == 0;
                VELtxt = '  -  ';
            else;
                if dataTableAverageData(iter,colinterest_SpeedInterp) == 1;
                    VELtxt = [dataToStr(dataTableAverageData(iter,colinterest_Speed),2) ' m/s !'];
                else;
                    VELtxt = [dataToStr(dataTableAverageData(iter,colinterest_Speed),2) ' m/s  '];
                end;
            end;

            if isnan(dataTableAverageData(iter,colinterest_Splits)) == 1 | dataTableAverageData(iter,colinterest_Splits) == 0;
                STtxt = '  -  ';
                CTtxt = '  -  ';
            else;
                if dataTableAverageData(iter,colinterest_SplitsInterp) == 1;
                    if dataTableAverageData(iter,colinterest_Splits) < 60;
                        CTtxt = [timeSecToStr2(dataTableAverageData(iter,colinterest_Splits)) 's !'];
                    else;
                        CTtxt = [timeSecToStr2(dataTableAverageData(iter,colinterest_Splits)) '  !'];
                    end;
                else;
                    if dataTableAverageData(iter,colinterest_Splits) < 60;
                        CTtxt = [timeSecToStr2(dataTableAverageData(iter,colinterest_Splits)) 's  '];
                    else;
                        CTtxt = [timeSecToStr2(dataTableAverageData(iter,colinterest_Splits)) '   '];
                    end;
                end;
                if lastIterValid == 0;
                    splitTime = dataTableAverageData(iter,colinterest_Splits);
                else;
                    splitTime = dataTableAverageData(iter,colinterest_Splits) - dataTableAverageData(lastIterValid,colinterest_Splits);
                end;
                if dataTableAverageData(iter,colinterest_SplitsInterp) == 1;
                    if splitTime < 60;
                        STtxt = [timeSecToStr2(splitTime) 's !'];
                    else;
                        STtxt = [timeSecToStr2(splitTime) '  !'];
                    end;
                else;
                    if splitTime < 60;
                        STtxt = [timeSecToStr2(splitTime) 's  '];
                    else;
                        STtxt = [timeSecToStr2(splitTime) '   '];
                    end;
                end;
                lastIterValid = iter;
            end;

              
        elseif Source == 2;   
            if isempty(dataTableAverageData{iter,colinterest_Speed}) == 1;
                VELtxt = '  -  ';
            else;
                if isnan(dataTableAverageData{iter,colinterest_Speed}) == 1 | dataTableAverageData{iter,colinterest_Speed} == 0;
                    VELtxt = '  -  ';
                else;
                    VELtxt = [dataToStr(dataTableAverageData{iter,colinterest_Speed},2) ' m/s  '];
                end;
            end;

            if isempty(dataTableAverageData{iter,colinterest_Splits}) == 1;
                STtxt = '  -  ';
                CTtxt = '  -  ';
            else;
                if isnan(dataTableAverageData{iter,colinterest_Splits}) == 1 | dataTableAverageData{iter,colinterest_Splits} == 0;
                    STtxt = '  -  ';
                    CTtxt = '  -  ';
                else;
                    if dataTableAverageData{iter,colinterest_Splits} < 60;
                        CTtxt = [timeSecToStr2(dataTableAverageData{iter,colinterest_Splits}) 's  '];
                    else;
                        CTtxt = [timeSecToStr2(dataTableAverageData{iter,colinterest_Splits}) '   '];
                    end;
                    if lastIterValid == 0;
                        splitTime = dataTableAverageData{iter,colinterest_Splits};
                    else;
                        splitTime = dataTableAverageData{iter,colinterest_Splits} - dataTableAverageData{lastIterValid,colinterest_Splits};
                    end;
                    if splitTime < 60;
                        STtxt = [timeSecToStr2(splitTime) 's  '];
                    else;
                        STtxt = [timeSecToStr2(splitTime) '   ']; 
                    end;
                    lastIterValid = iter;
                end;
            end;
            
        end;
        if strcmpi(STtxt, '  -  ') == 1;
            data = [STtxt '  /  ' CTtxt '  /    -  '];
        else;
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
        end;
        eval(['dataTablePacing{' num2str(lineEC+iter+addLap) ',' num2str(i) '} = data;']);

        index = find(keyDist == dataTableRefDist(iter));
        if isempty(index) == 0;
            addLap = addLap + 1;
        end;
    end;
end;
if Course == 50;
    limli_Pacing = length(dataTablePacing); %lineEC - 12 + 10;
else;
    limli_Pacing = length(dataTablePacing); %lineEC - 7 + 5;
end;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------





%---------------------------Create skills table----------------------------
%--------------------------------------------------------------------------
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
dataTableSkill{18,2} = 'Underwater Distance';
dataTableSkill{19,2} = 'Underwater Time';
dataTableSkill{20,2} = 'Underwater Speed';
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

colorrowSkill(1) = rgb_val(255,230,26);
colorrowSkill(2) = rgb_val(230,230,230);
colorrowSkill(3) = rgb_val(192,192,192);
colorrowSkill(4) = rgb_val(230,230,230);
colorrowSkill(5) = rgb_val(192,192,192);
colorrowSkill(6) = rgb_val(230,230,230);
colorrowSkill(7) = rgb_val(255,255,255);
colorrowSkill(8) = rgb_val(255,230,26);
colorrowSkill(9) = rgb_val(255,230,179);
colorrowSkill(10) = rgb_val(230,230,230);
colorrowSkill(11) = rgb_val(192,192,192);
colorrowSkill(12) = rgb_val(230,230,230);
colorrowSkill(13) = rgb_val(192,192,192);
colorrowSkill(14) = rgb_val(255,230,179);
colorrowSkill(15) = rgb_val(230,230,230);
colorrowSkill(16) = rgb_val(192,192,192);
colorrowSkill(17) = rgb_val(230,230,230);
colorrowSkill(18) = rgb_val(192,192,192);
colorrowSkill(19) = rgb_val(230,230,230);
colorrowSkill(20) = rgb_val(192,192,192);
colorrowSkill(21) = rgb_val(230,230,230);
colorrowSkill(22) = rgb_val(192,192,192);
colorrowSkill(23) = rgb_val(230,230,230);
colorrowSkill(24) = rgb_val(192,192,192);
colorrowSkill(25) = rgb_val(255,230,179);
colorrowSkill(26) = rgb_val(230,230,230);
colorrowSkill(27) = rgb_val(192,192,192);
colorrowSkill(28) = rgb_val(230,230,230);
colorrowSkill(29) = rgb_val(192,192,192);
colorrowSkill(30) = rgb_val(230,230,230);

Turn_TimeALL = [];
Turn_TimeInALL = [];
Turn_TimeOutALL = [];
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
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableStrokeData = databaseCurrent{mainIter-2,70};
        dataTableSkillVALData = databaseCurrent{mainIter-2,71};
        if isnan(dataTableAverageData(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTableAverageData(end,1) = str2num(racetimemissing);
        end;
    
    elseif Source == 2;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTableAverageData = databaseCurrent{mainIter-2,68};
        dataTableBreathData = databaseCurrent{mainIter-2,69};
        dataTableSkillVALData = databaseCurrent{mainIter-2,70};
        dataTableSkillTXTData = databaseCurrent{mainIter-2,71};
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
        TTtxt = timeSecToStr(dataTableAverageData(end,colinterest_Splits));
        splitAll = dataTableAverageData(:,colinterest_Splits);
    else;
        colinterest_Splits = 12;
        TTtxt = timeSecToStr(dataTableAverageData{end,colinterest_Splits});
        splitAll = cell2mat(dataTableAverageData(:,colinterest_Splits));
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

            colorrowSkill(lineEC) = rgb_val(255,230,179);
            colorrowSkill(lineEC+1) = rgb_val(230,230,230);
            colorrowSkill(lineEC+2) = rgb_val(192,192,192);
            colorrowSkill(lineEC+3) = rgb_val(230,230,230);
            colorrowSkill(lineEC+4) = rgb_val(192,192,192);
            colorrowSkill(lineEC+5) = rgb_val(230,230,230);
            colorrowSkill(lineEC+6) = rgb_val(192,192,192);
            colorrowSkill(lineEC+7) = rgb_val(230,230,230);

            lineEC = lineEC + 8;
        end;

        dataTableSkill{lineEC,1} = 'Finish';
        dataTableSkill{lineEC+1,2} = 'Last 5m Time';
        dataTableSkill{lineEC+2,2} = 'Glide-Wall (Dist/Time)';
        colorrowSkill(lineEC) = rgb_val(255,230,179);
        colorrowSkill(lineEC+1) = rgb_val(230,230,230);
        colorrowSkill(lineEC+2) = rgb_val(192,192,192);
    end;

    %%%Totals
    
    if Source == 1 | Source == 3;
        for lineEC = 10:length(dataTableSkill(:,1));
            dataTableSkill{lineEC,mainIter} = dataTableSkillVALData{lineEC,3};
        end;
    else;
        colinterest_Splits = 11;
        splitAll = cell2mat(dataTableAverageData(:,colinterest_Splits));

        BOAll = dataTableSkillVALData{1,24};
        dataTableSkill{10,i} = timeSecToStr(dataTableSkillVALData{1,1}); %skill time
        dataTableSkill{11,i} = 'na'; %Total underwater Distance
        dataTableSkill{12,i} = 'na'; %Total underwater Time
        dataTableSkill{13,i} = [timeSecToStr(sum(dataTableSkillVALData{1,3})) '  /  ' ...
            timeSecToStr(sum(dataTableSkillVALData{1,4})) '  /  ' ...
            timeSecToStr(sum(dataTableSkillVALData{1,2}))]; %Sum Turn times
        dataTableSkill{15,i} = timeSecToStr(dataTableSkillVALData{1,5}); %Start time
        dataTableSkill{16,i} = timeSecToStr(dataTableSkillVALData{1,22}); %RT
        if isempty(databaseCurrent{mainIter-2,24}) == 1;
            dataTableSkill{17,i} = 'na';    %Entry Distance
            dataTableSkill{18,i} = 'na';    %Unverwater Distance
            dataTableSkill{19,i} = 'na';    %Unverwater Time
            dataTableSkill{20,i} = 'na';    %Unverwater Speed
        else;
            dataTableSkill{17,i} = [dataToStr(dataTableSkillVALData{1,33}, 2) ' m'];     %Entry Distance
            dataTableSkill{18,i} = [dataToStr(dataTableSkillVALData{1,34}, 2) ' m'];     %Unverwater Distance
            dataTableSkill{19,i} = timeSecToStr(dataTableSkillVALData{1,35});            %Unverwater Time
            dataTableSkill{20,i} = [dataToStr(dataTableSkillVALData{1,32}, 2) ' m/s'];   %Unverwater Speed
        end;
        KicksNb = databaseCurrent{mainIter-2,64};
        dataTableSkill{21,i} = [num2str(KicksNb(1)) ' Kicks'];
        
        BOdisttxt = dataToStr(BOAll(1,3),1);
        dataTableSkill{22,i} = [BOdisttxt ' m'];
        BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
        dataTableSkill{23,i} = BOTimetxt;

        BOEfftxt = dataToStr(dataTableSkillVALData{1,8}, 1);
        VelBeforetxt = dataToStr(dataTableSkillVALData{1,9}, 2);
        VelAftertxt = dataToStr(dataTableSkillVALData{1,10}, 2);
        dataTableSkill{24,i} = [BOEfftxt ' %  /  ' VelBeforetxt ' m/s  /  ' VelAftertxt ' m/s'];
        
        %%%%Turns averages
        if NbLap == 1;
            dataTableSkill{26,i} = '  -  /  -  /  -  ';
            dataTableSkill{27,i} = '  -  ';
            dataTableSkill{28,i} = '  -  ';
            dataTableSkill{29,i} = '  -  ';
            dataTableSkill{30,i} = '  -  ';
        else;
            AvTurnIn = dataTableSkillVALData{1,11};
            AvTurnOut = dataTableSkillVALData{1,12};
            AvTurnTime = dataTableSkillVALData{1,13};
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

            BOEffTurn = dataTableSkillVALData{1,17};
            BOEffTurntxt = dataToStr(BOEffTurn,1);
            VelBefTurn = dataTableSkillVALData{1,18};
            VelBefTurntxt = dataToStr(VelBefTurn,2);
            VelAftTurn = dataTableSkillVALData{1,19};
            VelAftTurntxt = dataToStr(VelAftTurn,2);
            dataTableSkill{30,i} = [BOEffTurntxt ' %  /  ' VelBefTurntxt ' m/s  /  ' VelAftTurntxt ' m/s'];            
        end;

        %%%%Turn Details
        if NbLap ~= 1;
            lineEC = 31;
            Turn_TimeIn = dataTableSkillVALData{1,3};
            Turn_TimeOut = dataTableSkillVALData{1,4};
            Turn_Time = dataTableSkillVALData{1,2};
            for lap = 1:NbLap-1;
                dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];
    
                Turn_TimeIntxt = timeSecToStr(roundn(Turn_TimeIn(lap),-2));
                Turn_TimeOuttxt = timeSecToStr(roundn(Turn_TimeOut(lap),-2));
                Turn_Timetxt = timeSecToStr(roundn(Turn_Time(lap),-2));
                dataTableSkill{lineEC+1,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
            
                ApproachEff = dataTableSkillVALData{1,28};
                Approach2CycleAll = dataTableSkillVALData{1,29};
                ApproachLastCycleAll = dataTableSkillVALData{1,30};
                ApproachEffTurn = roundn(ApproachEff(lap).*100,-2);
                ApproachEffTurntxt = dataToStr(ApproachEffTurn,1);
                Approach2CycleAlltxt = dataToStr(Approach2CycleAll(lap),2);
                ApproachLastCycleAlltxt = dataToStr(ApproachLastCycleAll(lap),2);
                if Source == 1 | Source == 3;
                    dataTableSkill{lineEC+2,i} = [' na  /  na  /  na '];
                elseif Source == 2;
                    dataTableSkill{lineEC+2,i} = [ApproachEffTurntxt ' %  /  ' Approach2CycleAlltxt ' m/s  /  ' ApproachLastCycleAlltxt ' m/s'];
                end;
    
                GlideLastStroke = dataTableSkillVALData{1,31};
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
                    
                BOEffTurn = dataTableSkillVALData{1,25};
                VelAfterBO = dataTableSkillVALData{1,26};
                VelBeforeBO = dataTableSkillVALData{1,27};
                BOEffTurntxt = dataToStr(BOEffTurn(lap).*100,1);
                
                VelAfterBOtxt = dataToStr(VelAfterBO(lap),2);
                VelBeforeBOtxt = dataToStr(VelBeforeBO(lap),2);
                dataTableSkill{lineEC+7,i} = [BOEffTurntxt ' %  /  ' VelBeforeBOtxt ' m/s  /  ' VelAfterBOtxt ' m/s'];
                
                lineEC = lineEC + 8;
            end;
        end;
    
        Last5m = dataTableSkillVALData{1,20};%%%%%%%%%%%%%%%%%%%%%
        Last5mtxt = timeSecToStr(Last5m);
        dataTableSkill{lineEC+1,i} = Last5mtxt;
        
        if NbLap == 1;
            GlideLastStroke = dataTableSkillVALData{1,31};
        end;
        GlideLastStrokeDist = roundn(GlideLastStroke(3,end),-2);
        GlideLastStrokeTime = roundn(GlideLastStroke(4,end),-2);
        GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
        GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
        dataTableSkill{lineEC+2,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
    end;
end;
limli_Skill = lineEC;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------



if ispc == 1;
    if isfile([pathname filename]) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' pathname filename];
        [status, cmdout] = system(command);
    end;
            
    exportstatusSheet1 = xlswrite([pathname filename], dataTableSummary, 1);
    exportstatusSheet2 = xlswrite([pathname filename], dataTableStroke, 2);
    exportstatusSheet3 = xlswrite([pathname filename], dataTablePacing, 3);
    exportstatusSheet4 = xlswrite([pathname filename], dataTableSkill, 4);
    clc;

    source = 'analyser';
%     try;
        excelRenderingTable_analyser;
%     end;
else;
    
    if isfile([pathname filename]) == 1;
        command = ['rm -rf ' pathname filename];
        [status, cmdout] = system(command);
    end;
    
    %---add the path to java
    javaaddpath('poi-3.8-20120326.jar');
    javaaddpath('poi-ooxml-3.8-20120326.jar');
    javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('xmlbeans-2.3.0.jar');
    javaaddpath('dom4j-1.6.1.jar');
    javaaddpath('stax-api-1.0.1.jar');
    
    sheetName1 = 'Summary';
    startRange1 = 'A1';
    xlwrite([pathname filename], dataTableSummary, sheetName1, startRange1);
    
    sheetName2 = 'Stroke';
    startRange2 = 'A1';
    xlwrite([pathname filename], dataTableStroke, sheetName2, startRange2);
    
    sheetName3 = 'Pacing';
    startRange3 = 'A1';
    xlwrite([pathname filename], dataTablePacing, sheetName3, startRange3);
    
    sheetName4 = 'Skill';
    startRange4 = 'A1';
    xlwrite([pathname filename], dataTableSkill, sheetName4, startRange4);
    clc;
end;
 

end;
