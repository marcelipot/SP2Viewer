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
colorrow(15,:) = [0.75 0.75 0.75];
colorrow(16,:) = [0.9 0.9 0.9];
colorrow(17,:) = [0.75 0.75 0.75];
colorrow(18,:) = [1 0.9 0.70];
colorrow(19,:) = [0.9 0.9 0.9];
colorrow(20,:) = [0.75 0.75 0.75];
colorrow(21,:) = [0.9 0.9 0.9];
colorrow(22,:) = [0.75 0.75 0.75];
colorrow(23,:) = [0.9 0.9 0.9];
colorrow(24,:) = [0.75 0.75 0.75];
colorrow(25,:) = [0.9 0.9 0.9];
colorrow(26,:) = [0.75 0.75 0.75];

formatlist{1} = 'char';
formatlist{2} = 'char';
edittablelist(1) = false;
edittablelist(2) = false;
for i = 1:nbRaces;
    formatlist{i+2} = 'numeric';
    edittablelist(i+2) = false;
end;

PosINI = get(handles.SummaryData_table_analyser, 'Position');
posCorr = PosINI;
PosINI = PosINI(3);
posCorr(3) = PosINI - handles.diffPosSummaryTable;
set(handles.SummaryData_table_analyser, 'Position', posCorr);

set(handles.SummaryData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
    'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
    'rowstriping', 'on');
pos = get(handles.SummaryData_table_analyser, 'position');
PixelTot = pos(3);
PixelSwimmers = (PixelTot - 100 - 150)./nbRaces;
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
set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
% set(handles.SummaryData_table_analyser, 'Units', 'normalized');


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

for mainIter = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
%     UID = RaceUID{mainIter-2};
%     li = findstr(UID, '-');
%     UID(li) = '_';
%     UID = ['A' UID 'A'];
    
    Source = databaseCurrent{mainIter-2,58};
%     dataTableRefDist = [5:5:RaceDist]';
    if Source == 1 | Source == 3;
        metaData_PDF = databaseCurrent{mainIter-2,67};
        dataTablePacing = databaseCurrent{mainIter-2,68};
        dataTableBreath = databaseCurrent{mainIter-2,69};
        dataTableStroke = databaseCurrent{mainIter-2,70};
        dataTableSkill = databaseCurrent{mainIter-2,71};
        if isnan(dataTablePacing(end,1)) == 1;
            %race time missing
            racetimemissing = databaseCurrent{mainIter-2,14};
            index1 = strfind(racetimemissing, ' ');
            index2 = strfind(racetimemissing, 's');
            index3 = strfind(racetimemissing, '!');
            index = [index1 index2 index3];
            if isempty(index) == 0;
                racetimemissing(index) = [];
            end;
            dataTablePacing(end,1) = str2num(racetimemissing);
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
        TTtxt = timeSecToStr(dataTablePacing(end,colinterest_Splits));
    else;
        colinterest_Splits = 11;
        TTtxt = timeSecToStr(dataTableAverage{end,colinterest_Splits});
    end;
    dataTableSummary{6,mainIter} = TTtxt;
    KicksNb = databaseCurrent{mainIter-2,64};
    


    %--------------------------------Summary-------------------------------
    NbLap = RaceDist./Course;
    if strcmpi(answerReport, 'SP1') == 1 | strcmpi(answerReport, 'GE') == 1;
        RT = dataTableSkill{16,3};
        index = strfind(RT, ' ');
        RT = str2num(RT(1:index(1)-1));

        colinterest_SplitsInterp = 4;

        DiveT15 = dataTableSkill{15,3};
        index = strfind(DiveT15, ' ');
        DiveT15 = str2num(DiveT15(1:index(1)-1));
        STtxt = timeSecToStr(DiveT15);
        if dataTablePacing(3,colinterest_SplitsInterp) == 1;
            STtxt = [STtxt ' !'];
        end;

        valFinishTime = dataTableSkill{end-1,3};
        index = strfind(valFinishTime, ' ');
        valFinishTime = str2num(valFinishTime(1:index(1)-1));
        TLtxt = timeSecToStr(valFinishTime);

        BOKick_Start = dataTableSkill{21,3};
        index = strfind(BOKick_Start, ' ');
        BOKick_Start = str2num(BOKick_Start(1:index(1)));
    
        BOTime_Start = dataTableSkill{23,3};
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
    
        BODist_Start = dataTableSkill{22,3};
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

        valSkillTime = dataTableSkill{10,3};
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
        valFreeSwimTime = dataTablePacing(end,colinterest_Splits) - valSkillTime;

    elseif strcmpi(answerReport, 'SP2') == 1;
        turnTimeALL = dataTableSkillVAL{1,2};
        RT = dataTableSkillVAL{1,22};

        DiveT15 = dataTableSkillVAL{1,5};
        STtxt = timeSecToStr(DiveT15);

        valFinishTime = dataTableAverage{end,12} - dataTableAverage{end-1,12};
        TLtxt = timeSecToStr(valFinishTime);

        BOAll = dataTableSkillVAL{1,24};
        BOKick_Start = KicksNb(1,1);
        BOTime_Start = BOAll(1,2);
        BODist_Start = BOAll(1,3);
        BOAllINI = [BOTime_Start BODist_Start BOKick_Start];

        TTTurn = sum(turnTimeALL);
        TTtxt = timeSecToStr(TTTurn);
        
        valSkillTime = DiveT15 + sum(turnTimeALL) + valFinishTime;
        valFreeSwimTime = dataTableAverage{end,12} - valSkillTime;
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
                valSR = dataTableStroke(:, 1);
            elseif strcmpi(answerReport, 'SP2') == 1;
                valSR = dataTableAverage(:,5);
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
                valDPS = dataTableStroke(:, 5);
            elseif strcmpi(answerReport, 'SP2') == 1;
                valDPS = dataTableAverage(:,8);
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
        valSN = dataTableStroke(:,9);
    elseif strcmpi(answerReport, 'SP2') == 1;
        valSN = cell2mat(dataTableAverage(:,14));
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
        splitAll = dataTablePacing(:,colinterest_Splits);
    elseif strcmpi(answerReport, 'SP2') == 1;
        splitAll = cell2mat(dataTableAverage(:,colinterest_Splits));
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

handles.colorrowSummary = colorrow;
handles.dataTableSummary = dataTableSummary;

set(handles.StrokeData_table_analyser, 'Visible', 'off');
set(handles.SkillData_table_analyser, 'Visible', 'off');
set(handles.PacingData_table_analyser, 'Visible', 'off');
set(handles.SummaryData_table_analyser, 'data', dataTableSummary, 'backgroundcolor', colorrow);

table_extent = get(handles.SummaryData_table_analyser, 'Extent');
table_position = get(handles.SummaryData_table_analyser, 'Position');
pos_cor = table_position;
if table_extent(4) < table_position(4);
    
    if Extent == 0;
        %Add 5% to give space for the slider bar at the bottom
        offset = 18;
        pos_cor(2) = (handles.TopINI_SummaryTable*PosFig(4))-table_extent(4)-offset;
        pos_cor(4) = table_extent(4)+offset;
    else;
        pos_cor(2) = (handles.TopINI_SummaryTable*PosFig(4))-table_extent(4);
        pos_cor(4) = table_extent(4);
    end;
    
elseif table_extent(4) >= table_position(4);
    if table_position(2) < (0.0069*PosFig(4));
        pos_cor(2) = (0.0069*PosFig(4))+1;
        pos_cor(4) = (handles.TopINI_SummaryTable*PosFig(4))+1;
        
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
        set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
    else;
        if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
            pos_cor(2) = (0.0069*PosFig(4))+1;
            pos_cor(4) = (handles.TopINI_SummaryTable*PosFig(4))+1;
            
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
            set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
        else;
            if Extent == 0;
                offset = 18;
                pos_cor(2) = (handles.TopINI_SummaryTable*PosFig(4))-table_extent(4)+1-offset;
                pos_cor(4) = table_extent(4)+offset;
            else;
                pos_cor(2) = (handles.TopINI_SummaryTable*PosFig(4))-table_extent(4);
                pos_cor(4) = table_extent(4);
            end;
        end;
    end;
end;

if Extent == 1;
    if table_extent(3) > table_position(3);
        pos_cor(3) = table_extent(3);
    end;
end;
set(handles.SummaryData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
set(handles.SummaryData_table_analyser, 'Units', 'normalized');

PosEND = get(handles.SummaryData_table_analyser, 'Position');
PosEND = PosEND(3);
handles.diffPosSummaryTable = PosEND - handles.PosINI_SummaryTable;


% %Age Group (based on DOB and race date)
% index = strfind(dataEC.date, '-');
% RaceDate = datetime(str2num(dataEC.date(1:index(1)-1)), str2num(dataEC.date(index(1)+1:index(2)-1)), str2num(dataEC.date(index(2)+1:end)));
% index = strfind(DOB, '/');
% DOBDate = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
% dateDiff(1) = DOBDate;
% dateDiff(2) = RaceDate;
% D = caldiff(dateDiff, {'years','months','days'});
% [AgeDOB(1), AgeDOB(2), AgeDOB(3)] = split(D, {'years','months','days'});
% 
% YearEve = [dataEC.date(1:4) '-12-31'];
% index = strfind(YearEve, '-');
% dateDiff(2) = datetime(str2num(YearEve(1:index(1)-1)), str2num(YearEve(index(1)+1:index(2)-1)), str2num(YearEve(index(2)+1:end)));
% D = caldiff(dateDiff, {'years','months','days'});
% [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});
% if AgeYear(1) <= 13;
%     AgeGroupVal = '13y & under';
% elseif AgeYear(1) == 14;
%     AgeGroupVal = '14y';
% elseif AgeYear(1) == 15;
%     AgeGroupVal = '15y';
% elseif AgeYear(1) == 16;
%     AgeGroupVal = '16y';
% elseif AgeYear(1) == 17;
%     AgeGroupVal = '17y';
% elseif AgeYear(1) == 18; 
%     AgeGroupVal = '18y';
% else;
%     AgeGroupVal = 'Open';
% end;



