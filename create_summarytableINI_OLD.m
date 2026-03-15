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
set(gcf, 'units', 'pixels');
PosFig = get(gcf, 'Position');
set(gcf, 'units', 'normalized');

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
    UID = RaceUID{mainIter-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['dataTableSummary{2,' num2str(mainIter) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSummary{3,' num2str(mainIter) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);

    str = [Meet '-' num2str(Year)];
    eval(['dataTableSummary{4,' num2str(mainIter) '} = str;']);

    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableSummary{5,' num2str(mainIter) '} = str;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableSummary{6,mainIter} = TTtxt;

    if Source == 1;
        dataTableSummary{7,mainIter} = 'Sparta 1';
    elseif Source == 2;
        dataTableSummary{7,mainIter} = 'Sparta 2';
    elseif Source == 3;
        dataTableSummary{7,mainIter} = 'GreenEye';
    end;


    %--------------------------------Summary-------------------------------
    try;
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    catch;
        eval(['NbLap = handles.RacesDB.' UID '.nbLap;']);
    end;

    check_interpolation_skills;
    if Source == 2;
        create_Averagetable_SPReportSingle;
    else;
        eval(['SectionVel = handles.RacesDB.' UID '.SectionVel;']);
        eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
        eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
    end;

    eval(['ST = handles.RacesDB.' UID '.DiveT15INI;']);
    if isInterpolatedDive == 0;
        %no interpolation
        STtxt = timeSecToStr(ST);
    else;
        %interpolation
        STtxt = [timeSecToStr(ST) ' !'];
    end;
    eval(['dataTableSummary{10,' num2str(mainIter) '} = STtxt;']);
    
    eval(['TL = handles.RacesDB.' UID '.Last5mINI;']); 
    if isInterpolatedFinish == 0;
        %no interpolation
        TLtxt = timeSecToStr(TL);
    else;
        %Interpolation
        TLtxt = [timeSecToStr(TL) ' !'];
    end;
    eval(['dataTableSummary{11,' num2str(mainIter) '} = TLtxt;']);

    if NbLap == 1;
        dataTableSummary{12,mainIter} = ['  -  '];
    else;
        eval(['TurnsTotal = handles.RacesDB.' UID '.TurnsTotalINI;']);
        TT = TurnsTotal(:,3);
        TTtxt = timeSecToStr(TT);
        dataTableSummary{12,mainIter} = TTtxt;
    end;
  
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTimeINI;']);
    if isInterpolatedSkills == 0;
        %no interpolation
        TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
    else;
        %interpolation
        TotalSkillTimetxt = [timeSecToStr(TotalSkillTime) ' !'];
    end;
    dataTableSummary{13,mainIter} = TotalSkillTimetxt;

%     eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    SRMOut = [];

    SREC = [];
    iter = 1;
    lapEC = 1;
    colEC = 3;
    if Source == 2;
        for rowEC = 1:length(dataTableAverage(:,1));
            valEC = dataTableAverage{rowEC,colEC};
            if isempty(valEC) == 0;
                SREC(lapEC,iter) = valEC;
            end;
    
            txtLap = dataTableAverage{rowEC,1};
            index1 = strfind(txtLap, '-');
            index2 = strfind(txtLap, 'm');
            lapCheck = str2num(txtLap(index1+1:index2-1));
            if lapCheck == Course*lapEC;
                lapEC = lapEC + 1;
                iter = 1;
            else;
                iter = iter + 1;
            end;        
        end;
    else;
        SREC = SectionSR;
    end;

    if NbLap == 1;
        li = find(SREC(1, :) ~= 0);

        SRECreduced = SREC(1, li);
        liNaN = find(isnan(SRECreduced) == 0);
        SRECreduced = SRECreduced(liNaN);

        SRMOut = roundn(mean(SRECreduced),-1);
    else;
        for lap = 1:NbLap/2;
            li = find(SREC(lap, :) ~= 0);

            SRECreduced = SREC(1, li);
            liNaN = find(isnan(SRECreduced) == 0);
            SRECreduced = SRECreduced(liNaN);

            SRMOut = roundn([SRMOut mean(SRECreduced)],-1);
        end;
        SRMOut = mean(SRMOut);

        SRMBack = [];
        for lap = (NbLap/2)+1:NbLap;
            li = find(SREC(lap, :) ~= 0);

            SRECreduced = SREC(1, li);
            liNaN = find(isnan(SRECreduced) == 0);
            SRECreduced = SRECreduced(liNaN);

            SRMBack = roundn([SRMBack mean(SRECreduced)],-1);
        end;
        SRMBack = mean(SRMBack);
    end;
    
%     eval(['SLEC = handles.RacesDB.' UID '.Stroke_DistanceINI;']);
    SLMOut = [];

    SLEC = [];
    iter = 1;
    lapEC = 1;
    colEC = 4;
    if Source == 2;
        for rowEC = 1:length(dataTableAverage(:,1));
            valEC = dataTableAverage{rowEC,colEC};
            if isempty(valEC) == 0;
                SLEC(lapEC,iter) = valEC;
            end;
    
            txtLap = dataTableAverage{rowEC,1};
            index1 = strfind(txtLap, '-');
            index2 = strfind(txtLap, 'm');
            lapCheck = str2num(txtLap(index1+1:index2-1));
            if lapCheck == Course*lapEC;
                lapEC = lapEC + 1;
                iter = 1;
            else;
                iter = iter + 1;
            end;        
        end;
    else;
        SLEC = SectionSD;
    end;

    if NbLap == 1;
        li = find(SLEC(1, :) ~= 0);
        SLECreduced = SLEC(1, li);
        liNaN = find(isnan(SLECreduced) == 0);
        SLECreduced = SLECreduced(liNaN);

        SLMOut = roundn(mean(SLECreduced),-2);
    else;
        for lap = 1:NbLap/2;
            li = find(SLEC(lap, :) ~= 0);

            SLECreduced = SLEC(lap, li);
            liNaN = find(isnan(SLECreduced) == 0);
            SLECreduced = SLECreduced(liNaN);

            SLMOut = roundn([SLMOut mean(SLECreduced)],-2);
        end;
        SLMOut = roundn(mean(SLMOut), -2);
        
        SLMBack = [];
        for lap = (NbLap/2)+1:NbLap;
            li = find(SLEC(lap, :) ~= 0);

            SLECreduced = SLEC(lap, li);
            liNaN = find(isnan(SLECreduced) == 0);
            SLECreduced = SLECreduced(liNaN);

            SLMBack = roundn([SLMBack mean(SLECreduced)],-2);
        end;
        SLMBack = roundn(mean(SLMBack), -2);
    end;
    
    eval(['SNEC = handles.RacesDB.' UID '.Stroke_Count;']);
    if NbLap == 1;
        li = find(SNEC(1, :) ~= 0);
        SNMOut = roundn(mean(SNEC(1, li)),-1);
    else;
        SNMOut = [];
        for lap = 1:NbLap/2;
            SNMOut = [SNMOut SNEC(lap)];
        end;
        SNMOut = sum(SNMOut);

        SNMBack = [];
        for lap = (NbLap/2)+1:NbLap;
            SNMBack = [SNMBack SNEC(lap)];
        end;
        SNMBack = sum(SNMBack);
    end;

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
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);

    RTtxt = timeSecToStr(roundn(RT,-2));
    if NbLap == 1;
        SplitEnd = SplitsAll(end,2);
        SplitEndtxt = timeSecToStr(SplitEnd);
        
        dataTableSummary{19,mainIter} =  [SplitEndtxt ' (100 %)'];
        dataTableSummary{20,mainIter} =  '-';
        dataTableSummary{21,mainIter} =  '-';
    else;
        SplitMid = SplitsAll(NbLap./2,2);
        SplitEnd = SplitsAll(NbLap,2) - SplitMid;
        SplitMidP = roundn((SplitMid/SplitsAll(NbLap,2)*100), -2);
        SplitEndP = roundn((SplitEnd/SplitsAll(NbLap,2)*100), -2);
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
    
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    dataTableSummary{22,2} = 'Block';
    dataTableSummary{22,mainIter} = RTtxt;
    if RaceDist == 50;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,mainIter} = datatxt;
        end;
    elseif RaceDist == 100;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '75m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
        
    elseif RaceDist == 150;
        if Course == 25;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(2,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2)-SplitsAll(4,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
        
    elseif RaceDist == 200;
        if Course == 25;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(2,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2)-SplitsAll(4,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2)-SplitsAll(6,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];

        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;
        
    elseif RaceDist == 400;
        if Course == 25;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(SplitsAll(4,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(4,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(SplitsAll(12,2));
            datatxt = timeSecToStr(SplitsAll(12,2) - SplitsAll(8,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];

        else;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2) - SplitsAll(2,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2) - SplitsAll(4,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(6,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;

    elseif RaceDist == 800;
        if Course == 25;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(SplitsAll(8,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(SplitsAll(24,2));
            datatxt = timeSecToStr(SplitsAll(24,2) - SplitsAll(16,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(32,2));
            datatxt = timeSecToStr(SplitsAll(32,2) - SplitsAll(24,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(SplitsAll(4,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(4,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(SplitsAll(12,2));
            datatxt = timeSecToStr(SplitsAll(12,2) - SplitsAll(8,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(12,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        end;

    elseif RaceDist == 1500;
        if Course == 25;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(SplitsAll(16,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(32,2));
            datatxt = timeSecToStr(SplitsAll(32,2) - SplitsAll(16,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(SplitsAll(48,2));
            datatxt = timeSecToStr(SplitsAll(48,2) - SplitsAll(32,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(SplitsAll(60,2));
            datatxt = timeSecToStr(SplitsAll(60,2) - SplitsAll(48,2));
            dataTableSummary{26,mainIter} = [datatxt '  /  ' dataTOTtxt];
        else;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(SplitsAll(8,2));
            dataTableSummary{23,mainIter} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{24,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(SplitsAll(24,2));
            datatxt = timeSecToStr(SplitsAll(24,2) - SplitsAll(16,2));
            dataTableSummary{25,mainIter} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(SplitsAll(30,2));
            datatxt = timeSecToStr(SplitsAll(30,2) - SplitsAll(24,2));
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



