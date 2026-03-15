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
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['dataTableSummary{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSummary{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTableSummary{4,' num2str(i) '} = str;']);
    
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableSummary{5,' num2str(i) '} = str;']);

    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableSummary{6,i} = TTtxt;

    if Source == 1;
        dataTableSummary{7,i} = 'Sparta 1';
    elseif Source == 2;
        dataTableSummary{7,i} = 'Sparta 2';
    elseif Source == 3;
        dataTableSummary{7,i} = 'GreenEye';
    end;


    %--------------------------------Summary-------------------------------
    try;
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    catch;
        eval(['NbLap = handles.RacesDB.' UID '.nbLap;']);
    end;
    
    check_interpolation_skills;


    eval(['ST = handles.RacesDB.' UID '.DiveT15INI;']);
    if isInterpolatedDive == 0;
        %no interpolation
        STtxt = timeSecToStr(ST);
    else;
        %interpolation
        STtxt = [timeSecToStr(ST) ' !'];
    end;
    eval(['dataTableSummary{10,' num2str(i) '} = STtxt;']);
    
    eval(['TL = handles.RacesDB.' UID '.Last5mINI;']);
    if isInterpolatedFinish == 0;
        %no interpolation
        TLtxt = timeSecToStr(TL);
    else;
        %Interpolation
        TLtxt = [timeSecToStr(TL) ' !'];
    end;
    eval(['dataTableSummary{11,' num2str(i) '} = TLtxt;']);
    
    if NbLap == 1;
        dataTableSummary{12,i} = ['  -  '];
    else;
        eval(['TurnsTotal = handles.RacesDB.' UID '.TurnsTotalINI;']);
        TT = TurnsTotal(:,3);
        TTtxt = timeSecToStr(TT);
        dataTableSummary{12,i} = TTtxt;
    end;
    
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTimeINI;']);
    if isInterpolatedSkills == 0;
        %no interpolation
        TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
    else;
        %interpolation
        TotalSkillTimetxt = [timeSecToStr(TotalSkillTime) ' !'];
    end;
    dataTableSummary{13,i} = TotalSkillTimetxt;

    eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    SRMOut = [];
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
    
    eval(['SLEC = handles.RacesDB.' UID '.Stroke_DistanceINI;']);
    SLMOut = [];

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
    dataTableSummary{15,i} = [SRMOuttxt ' str/min' '   ' SLMOuttxt ' m' '   ' SNMOuttxt ' str'];
    
    if NbLap == 1
        dataTableSummary{16,i} = ['  -  /  -  /  -  '];
    else;
        SRMBacktxt = dataToStr(SRMBack,1);
        SLMBacktxt = dataToStr(SLMBack,2);
        SNMBacktxt = num2str(SNMBack);

        dataTableSummary{16,i} = [SRMBacktxt ' str/min' '   ' SLMBacktxt ' m' '   ' SNMBacktxt ' str'];
    end;
    
    if NbLap == 1;
        dataTableSummary{17,i} = ['  -  /  -  /  -  '];
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
        dataTableSummary{17,i} = [diffSRMtxt ' str/min' '   ' diffSLMtxt ' m' '   ' diffStrtxt ' str'];
    end;
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);

    RTtxt = timeSecToStr(roundn(RT,-2));
    if NbLap == 1;
        SplitEnd = SplitsAll(end,2);
        SplitEndtxt = timeSecToStr(SplitEnd);
        
        dataTableSummary{19,i} =  [SplitEndtxt ' (100 %)'];
        dataTableSummary{20,i} =  '-';
        dataTableSummary{21,i} =  '-';
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
        dataTableSummary{19,i} =  [SplitMidtxt ' (' num2str(SplitMidPtxt) ' %)'];
        dataTableSummary{20,i} =  [SplitEndtxt ' (' num2str(SplitEndPtxt) ' %)'];
        
        DropOfftxt = num2str(DropOff);
        if DropOff > 0;
            DropOfftxt = ['+' DropOfftxt ' s'];
        elseif DropOff < 0;
            DropOfftxt = ['-' DropOfftxt(2:end) ' s'];
        else;
            DropOfftxt = ['=' DropOfftxt ' s'];
        end;
        dataTableSummary{21,i} =  DropOfftxt;
    end;
    
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    dataTableSummary{22,2} = 'Block';
    dataTableSummary{22,i} = RTtxt;
    if RaceDist == 50;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 24;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;
            
            limli_Summary = 23;
        end;

    elseif RaceDist == 100;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '75m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 24;
        end;
        
    elseif RaceDist == 150;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '75m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            dataTableSummary{27,2} = '125m';
            dataTOTtxt = timeSecToStr(SplitsAll(5,2));
            datatxt = timeSecToStr(SplitsAll(5,2)-SplitsAll(4,2));
            dataTableSummary{27,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{28,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2)-SplitsAll(5,2));
            dataTableSummary{28,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 28;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 25;
        end;
        
    elseif RaceDist == 200;
        if Course == 25;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(2,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2)-SplitsAll(4,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2)-SplitsAll(6,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;
        
    elseif RaceDist == 400;
        if Course == 25;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(SplitsAll(4,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(4,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(SplitsAll(12,2));
            datatxt = timeSecToStr(SplitsAll(12,2) - SplitsAll(8,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(12,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2) - SplitsAll(2,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2) - SplitsAll(4,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(6,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;

    elseif RaceDist == 800;
        if Course == 25;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(SplitsAll(8,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(SplitsAll(24,2));
            datatxt = timeSecToStr(SplitsAll(24,2) - SplitsAll(16,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(32,2));
            datatxt = timeSecToStr(SplitsAll(32,2) - SplitsAll(24,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(SplitsAll(4,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(4,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(SplitsAll(12,2));
            datatxt = timeSecToStr(SplitsAll(12,2) - SplitsAll(8,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(12,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;

    elseif RaceDist == 1500;
        if Course == 25;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(SplitsAll(16,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(32,2));
            datatxt = timeSecToStr(SplitsAll(32,2) - SplitsAll(16,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(SplitsAll(48,2));
            datatxt = timeSecToStr(SplitsAll(48,2) - SplitsAll(32,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(SplitsAll(60,2));
            datatxt = timeSecToStr(SplitsAll(60,2) - SplitsAll(48,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(SplitsAll(8,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(SplitsAll(24,2));
            datatxt = timeSecToStr(SplitsAll(24,2) - SplitsAll(16,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(SplitsAll(30,2));
            datatxt = timeSecToStr(SplitsAll(30,2) - SplitsAll(24,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;
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
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['framerate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['dataTableStroke{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    RaceDist = roundn(RaceDist,0);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['dataTableStroke{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTableStroke{4,' num2str(i) '} = str;']);

    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableStroke{5,' num2str(i) '} = str;']);

    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableStroke{6,i} = TTtxt;

    if Source == 1;
        dataTableStroke{7,i} = 'Sparta 1';
    elseif Source == 2;
        dataTableStroke{7,i} = 'Sparta 2';
    elseif Source == 3;
        dataTableStroke{7,i} = 'GreenEye';
    end;

    if Source == 1 | Source == 3;
        eval(['isInterpolatedVel = handles.RacesDB.' UID '.isInterpolatedVel;']);
        eval(['isInterpolatedSplits = handles.RacesDB.' UID '.isInterpolatedSplits;']);
        eval(['isInterpolatedSR = handles.RacesDB.' UID '.isInterpolatedSR;']);
        eval(['isInterpolatedSD = handles.RacesDB.' UID '.isInterpolatedSD;']);
    else;
        isInterpolatedVel = [];
        isInterpolatedSplits = [];
        isInterpolatedSR = [];
        isInterpolatedSD = [];
    end;

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
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['SDEC = handles.RacesDB.' UID '.Stroke_DistanceINI;']);
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
                dataTableStroke{lineEC+5,2} = '20m-Last arm entry';

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
                dataTableStroke{lineEC+10,2} = '45m-Last arm entry';

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
    
    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistanceINI;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['StrokeEC = handles.RacesDB.' UID '.RawStroke;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    %     eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);
    if Source == 1 | Source == 3;
        isInterpolatedBO = BOAll(:,4);
        BOAll = BOAll(:,1:3);
    else;
        isInterpolatedBO = zeros(NbLap,1);
    end;

    lengthdata = [length(DistanceEC) length(VelocityEC) length(TimeEC)];
    if isempty(find(diff(lengthdata) ~= 0)) == 0;
        [minVal, minLoc] = min(lengthdata);
        if minLoc == 1;
            %Adjust Vel and Time
            VelocityEC = VelocityEC(1:length(DistanceEC));
            TimeEC = TimeEC(1:length(DistanceEC));
        elseif minLoc == 2;
            %Adjust Dist and Time
            DistanceEC = DistanceEC(1:length(VelocityEC));
            TimeEC = TimeEC(1:length(VelocityEC));
        elseif minLoc == 3;
            %Adjust Dist and Vel
            DistanceEC = DistanceEC(1:length(TimeEC));
            VelocityEC = VelocityEC(1:length(TimeEC));
        end;
    end;

    nbZones = Course./5;
    if Source == 2;
        %calculate SR per sections
        %find legs if IM
        if strcmpi(lower(StrokeType), 'medley');
            if Course == 25;
                if RaceDist == 100;
                    legsIM = [1;2;3;4];
                elseif RaceDist == 150;
                    legsIM = [[1 2]; [3 4]; [5 6]];
                elseif RaceDist == 200;
                    legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
                elseif RaceDist == 400;
                    legsIM = [[1 2 3 4]; [5 6 7 8]; [9 10 11 12]; [13 14 15 16]];
                end;
            elseif Course == 50;
                if RaceDist == 150;
                    legsIM = [1; 2; 3];
                elseif RaceDist == 200;
                    legsIM = [1; 2; 3; 4];
                elseif RaceDist == 400;
                    legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
                end;
            end;
        else;
            legsIM = [];
        end;
    
        %restructure Stroke_Frame
        Stroke_FrameRestruc = [];
        for lapEC = 1:NbLap;
            indexZero = find(Stroke_Frame(lapEC,:) ~= 0);
            Stroke_FrameRestruc = [Stroke_FrameRestruc Stroke_Frame(lapEC, indexZero)];
        end;
    
        lapLim = Course:Course:RaceDist;
        lapEC = 1;
        updateLap = 0;
        SectionSR = [];
        SectionSD = [];
        SectionNb = [];

        if Course == 25;
    
        elseif Course == 50;

            dataZone = [];
            totZone = NbLap.*(Course./5);
            distIni = 0;
            jumDist = 5;
            for zEC = 1:totZone;
                dataZone(zEC,:) = [distIni distIni+5];
                distIni = distIni + 5;
            end;
            zoneSR = 1;
            
            for zoneEC = 1:totZone;
    
                SREC = [];
                searchExtraStroke = [];
                zone_dist_ini = dataZone(zoneEC,1);
                zone_dist_end = dataZone(zoneEC,2);
    
                indexLap = find(lapLim == zone_dist_ini);
                if zone_dist_ini == 0;
                    %zone beginning is 0
                    zone_frame_ini = 1;
                
                else;
                    if isempty(indexLap) == 0;
                        %Zone beginning is matching with a lap
                        zone_frame_ini = SplitsAll(indexLap,3);
                
                    else;
                        %Zone beginning is mid-pool
                        [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                        zone_frame_ini = minLoc(1);
                    end;
                end;
    
                indexLap = find(lapLim == zone_dist_end);
                if isempty(indexLap) == 0;
                    %Last zone for a lap, remove 2m
                    updateLap = 1;
                end;

                if zone_dist_end == 0;
                    %zone end is 0
                    zone_frame_end = 1;
                else;
                    if isempty(indexLap) == 0;
                        %Zone end is matching with a lap
                        zone_frame_end = SplitsAll(indexLap,3);
    
                    else;
                        %Zone end is mid-pool
                        [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                        zone_frame_end = minLoc(1);
                    end;
                end;
                
                if isempty(indexLap) == 0;
                    %last zone of the lap: take the previous zone to look
                    %for other strokes
                    searchExtraStroke = 'pre';
                    updateLap = 1;
                else;
                    %other zones: take the next zone to look
                    %for other strokes
                    searchExtraStroke = 'post';
                end;
                
                li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);
    
                strokeList = Stroke_FrameRestruc(1,li_stroke);
                strokeCount = length(strokeList);
                SectionNb(lapEC,zoneSR) = strokeCount;
    
                if strokeCount < 2;
                    %no stroke rate if count if 1
                    SREC = [];
    
                else;
                    if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                        if rem(strokeCount,2) == 1;
                            %odd stroke count: no need for another stroke
                            
                        else;
                            %even stroke count: add another stroke to get a
                            %full cycle
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(end);
    
                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
    
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(1);
    
                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;
    
                        for strokeEC = 2:length(strokeList);
                            durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                            SREC(strokeEC-1) = 60/durationStroke;
                            SREC(strokeEC-1) = SREC(strokeEC-1)./2;
                        end;
                        SREC = mean(SREC);
    
                    elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
                        for strokeEC = 2:length(strokeList);
                            durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                            SREC(strokeEC-1) = 60/durationStroke;
                        end;
                        SREC = mean(SREC);
    
                    elseif strcmpi(lower(StrokeType), 'medley');
                        [li, co] = find(legsIM == lapEC);
                        if li == 1 | li == 3;
                            %butterfly and breaststroke legs
                            for strokeEC = 2:length(strokeList);
                                durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                                SREC(strokeEC-1) = 60/durationStroke;
                            end;
                            SREC = mean(SREC);
                        else;
                            %backstroke and freestyle legs
                            if rem(strokeCount,2) == 1;
                            %odd stroke count: no need for another stroke
                            
                            else;
                                %even stroke count: add another stroke to get a
                                %full cycle
                                if strcmpi(searchExtraStroke, 'pre');
                                    %look for stroke in the 5s leading to the
                                    %zone
                                    zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                    zone_frame_endExtra = strokeList(1) - 1;
                                    
                                    %take the last stroke available
                                    li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                    li_strokeExtra = li_stroke(end);
    
                                    strokeList = [strokeList li_strokeExtra];
    
                                elseif strcmpi(searchExtraStroke, 'post');
                                    %look for stroke in the 5s leading to the
                                    %zone
                                    zone_frame_endExtra = zone_frame_end + (5*framerate);
                                    zone_frame_iniExtra = strokeList(end) + 1;
    
                                    %take the first stroke available
                                    li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                    li_strokeExtra = li_stroke(1);
    
                                    strokeList = [strokeList li_strokeExtra];
                                end;
                            end;
    
                            for strokeEC = 2:length(strokeList);
                                durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                                SREC(strokeEC-1) = 60/durationStroke;
                                SREC(strokeEC-1) = SREC(strokeEC-1)./2;
                            end;
                            SREC = mean(SREC);
    
                        end;
                    end;
                    SectionSR(lapEC,zoneSR) = SREC;
                end;
                zoneSR = zoneSR + 1;

                if updateLap == 1;
                    updateLap = 0;
                    lapEC = lapEC + 1;
                    zoneSR = 1;
                end;
            end;
        end;
    
    
        %calculate DPS per sections
        if Course == 25;
    
        elseif Course == 50;
            lapEC = 1;
            updateLap = 0;
            SectionSD = [];
            zoneSD = 1;

            for zoneEC = 1:totZone;

                DPSEC = [];
                searchExtraStroke = [];
                zone_dist_ini = dataZone(zoneEC,1);
                zone_dist_end = dataZone(zoneEC,2);
    
                indexLap = find(lapLim == zone_dist_ini);
                if zone_dist_ini == 0;
                    %zone beginning is 0
                    zone_frame_ini = 1;
                
                else;
                    if isempty(indexLap) == 0;
                        %Zone beginning is matching with a lap
                        zone_frame_ini = SplitsAll(indexLap,3);
                
                    else;
                        %Zone beginning is mid-pool
                        [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                        zone_frame_ini = minLoc(1);
                    end;
                end;
                
                indexLap = find(lapLim == zone_dist_end);
                if isempty(indexLap) == 0;
                    %Last zone for a lap, remove 2m
                    zone_dist_end = zone_dist_end-2;
                    updateLap = 1;
                end;
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_frame_end = minLoc(1);
                
                if isempty(indexLap) == 0;
                    %last zone of the lap: take the previous zone to look
                    %for other strokes
                    searchExtraStroke = 'pre';
                    updateLap = 1;
                else;
                    %other zones: take the next zone to look
                    %for other strokes
                    searchExtraStroke = 'post';
                end;
                
                li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);
    
                strokeList = Stroke_FrameRestruc(1,li_stroke);
                strokeCount = length(strokeList);
    
                if strokeCount < 2;
                    %no stroke rate if count if 1
                    DPSEC = [];
    
                else;
                    if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                        if rem(strokeCount,2) == 1;
                            %odd stroke count: no need for another stroke
                            
                        else;
                            %even stroke count: add another stroke to get a
                            %full cycle
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(end);
    
                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
    
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(1);
    
                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;
    
                        for strokeEC = 2:length(strokeList);
                            distanceStroke(strokeEC) = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                            DPSEC(strokeEC-1) = distanceStroke(strokeEC).*2;
                        end;
                        DPSEC = mean(DPSEC);
    
                    elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
                        for strokeEC = 2:length(strokeList);
                            distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                            DPSEC(strokeEC-1) = distanceStroke;
                        end;
                        DPSEC = mean(DPSEC);
    
                    elseif strcmpi(lower(StrokeType), 'medley');
                        [li, co] = find(legsIM == lapEC);
                        if li == 1 | li == 3;
                            %butterfly and breaststroke legs
                            for strokeEC = 2:length(strokeList);
                                distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                                DPSEC(strokeEC-1) = distanceStroke;
                            end;
                            DPSEC = mean(DPSEC);
    
                        else;
                            %backstroke and freestyle legs
                            if rem(strokeCount,2) == 1;
                                %odd stroke count: no need for another stroke
                                
                            else;
                                %even stroke count: add another stroke to get a
                                %full cycle
                                if strcmpi(searchExtraStroke, 'pre');
                                    %look for stroke in the 5s leading to the
                                    %zone
                                    zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                    zone_frame_endExtra = strokeList(1) - 1;
                                    
                                    %take the last stroke available
                                    li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                    li_strokeExtra = li_strokeExtra(end);
    
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                    
                                elseif strcmpi(searchExtraStroke, 'post');
                                    %look for stroke in the 5s leading to the
                                    %zone
                                    zone_frame_endExtra = zone_frame_end + (5*framerate);
                                    zone_frame_iniExtra = strokeList(end) + 1;
    
                                    %take the first stroke available
                                    li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                    li_strokeExtra = li_strokeExtra(1);
    
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
    
                            for strokeEC = 2:length(strokeList);
                                distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                                DPSEC(strokeEC-1) = distanceStroke.*2;
                            end;
                            DPSEC = mean(DPSEC);
                        end;
                    end;
    
                    SectionSD(lapEC,zoneSD) = DPSEC;
                    
                end;
                zoneSD = zoneSD + 1;

                if updateLap == 1;
                    updateLap = 0;
                    lapEC = lapEC + 1;
                    zoneSD = 1;
                end;
            end;
        end;
        SectionSDbis = SectionSD;
        SectionSRbis = SectionSR;
        SectionNbbis = SectionNb;

    else;
        
        %load the Section data
%         eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
%         eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
%         eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);

        %fill the gap to get 5m segment
        if Source == 1;
            if RaceDist <= 100;
                eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
                eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
                eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
                eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);
            else;
                eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
                eval(['SectionSD = handles.RacesDB.' UID '.SectionSDbis;']);
                eval(['SectionSR = handles.RacesDB.' UID '.SectionSRbis;']);
                eval(['SectionNb = handles.RacesDB.' UID '.SectionNbbis;']);
            end;
        elseif Source == 3;
            eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
            eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
            eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
            eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);
        end;

        for lap = 1:NbLap
            index = find(SectionSD(lap,:) == 0);
            SectionSD(lap,index) = NaN;

            index = find(SectionSR(lap,:) == 0);
            SectionSR(lap,index) = NaN;

            index = find(SectionNb(lap,:) == 0);
            SectionNb(lap,index) = NaN;
        end;
        SectionSDbis = SectionSD;
        SectionSRbis = SectionSR;
        SectionNbbis = SectionNb;
    end;

    SectionSD = roundn(SectionSD,-2);
    SectionSR = roundn(SectionSR,-1);
    SectionNb = roundn(SectionNb,0);
    SectionSDbis = roundn(SectionSDbis,-2);
    SectionSRbis = roundn(SectionSRbis,-2);
    SectionNbbis = roundn(SectionNbbis,0);

    lineEC = 11;
    for lap = 1:NbLap;
        countInterpSR = 0;
        countInterpSD = 0;
        countInterpNb = 0;

        DistZoneEC = 5 + ((lap-1)*Course);
        BODistLap = BOAll(lap,3);

        addline = 0;
        firstLapZone = 1;
        for zoneEC = 1:4;
            interpZone = 0;

            if (SectionSR(lap,zoneEC)) == 0;
                SRtxt = '  -  ';
            else;
                if isnan((SectionSR(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        SRtxt = '  -  ';
%                     elseif BODistLap+2 > DistZoneEC
%                         SRtxt = '  -  ';
                    else;
                        index = find(isnan(SectionSR(lap,:)) == 0);
                        if isempty(index) == 1;
                            SRtxt = '  -  ';
                        else;
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));    
                            refSR = SectionSR(lap,indexRef);
                            SectionSR(lap,zoneEC) = refSR;
                            isInterpolatedSR(lap,zoneEC) = 1;
                            SRtxt = [dataToStr(refSR,1) ' str/min'];
                            interpZone = 1;
                            countInterpSR = countInterpSR + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        SRtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        SRtxt = '  -  ';
                    else;
                        if Source == 1 | Source == 3;
                            if isInterpolatedSR(lap,zoneEC) == 1;
                                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                                interpZone = 1;
                            else;
                                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                            end;
                        else;
                            SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                        end;
                        countInterpSR = 0;
                    end;
                end;
            end;

            if (SectionSD(lap,zoneEC)) == 0;
                SDtxt = '  -  ';
            else;
                if isnan((SectionSD(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        SDtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        SDtxt = '  -  ';
                    else;
                        index = find(isnan(SectionSD(lap,:)) == 0);
                        if isempty(index) == 1;
                            SDtxt = '  -  ';
                        else;
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));    
                            refSD = SectionSD(lap,indexRef);
                            SectionSD(lap,zoneEC) = refSD;
                            isInterpolatedSD(lap,zoneEC) = 1;
                            SDtxt = [dataToStr(refSD,2) ' m'];
                            interpZone = 1;
                            countInterpSD = countInterpSD + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        SDtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        SDtxt = '  -  ';
                    else;
                        if Source == 1 | Source == 3;
                            if isInterpolatedSD(lap,zoneEC) == 1;
                                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                                interpZone = 1;
                            else;
                                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                            end;
                        else;
                            SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                        end;
                        countInterpSD = 0;
                    end;
                end;
            end;
            
            if (SectionNb(lap,zoneEC)) == 0;
                Nbtxt = '  -  ';
            else;
                if isnan((SectionNb(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        Nbtxt = '  -  ';
                    else;
                        index = find(isnan(SectionNb(lap,:)) == 0);
                        if isempty(index) == 1;
                            Nbtxt = '  -  ';
                        else;
                            
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));
                            strokeTot = SectionNb(lap,indexRef);
                            
                            proceed = 1;
                            zoneProcess = indexRef;
                            distRef = 5;
                            refStroke = NaN(1,indexRef);
                            diffRounding = 0;
                            while proceed == 1;

                                if zoneProcess == zoneEC;
                                    indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                                    refStrokebis = refStroke(1,indexNAN);
                                    refStroke(1,zoneProcess) = strokeTot - sum(refStrokebis);
                                else;
                                    refSD = SectionSD(lap,zoneProcess);
                                    proceedSD = 1;
                                    iter = 1;
                                    iterPlus = 0;
                                    iterMinus = 0;
                                    while proceedSD == 1;
                                        if zoneProcess-iter > 0;
                                            if isnan(refSD) == 1;
                                                refSD = SectionSD(lap,zoneProcess-iter);
                                            end;
                                        else;
                                            iterMinus = 1;
                                        end;
                                        if zoneProcess+iter <= length(SectionSD(lap,:));
                                            if isnan(refSD) == 1;
                                                refSD = SectionSD(lap,zoneProcess+iter);
                                            end;
                                        else;
                                            iterPlus = 1;
                                        end;

                                        if isnan(refSD) == 0;
                                            proceedSD = 0;
                                        else;
                                            if iterMinus == 1 & iterPlus == 1;
                                                proceedSD = 0;
                                                indexNaNSD = find(isnan(SectionSD(lap,:)) == 0);
                                                refSD = mean(SectionSD(lap,indexNaNSD));
                                            end;
                                        end;
                                        iter = iter + 1;
                                    end;

                                    if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                                        refSD = refSD./2;
                                    elseif strcmpi(lower(StrokeType), 'Butterfly') | strcmpi(lower(StrokeType), 'breaststroke');
                                        %no changes
                                    else;
                                        [legLapIM, colLapIM] = find(legsIM == lap);
                                        if legLapIM == 1 | legLapIM == 3;
                                            refSD = refSD./2;
                                        else;
                                            %no changes
                                        end;
                                    end;
                                    remSD = mod(refSD,1);
                                    refSD = floor(refSD) + ceil(remSD.*10)./10;
                                    
                                    if zoneProcess == nbZones;
                                        valStroke = (distRef-1.5)./refSD;
                                        %remove 1.5m off the last zone
                                    else;
                                        valStroke = distRef./refSD;
                                    end;
                                    
                                    if diffRounding >= 0.9;
                                        valStrokeRound = ceil(valStroke);
                                    elseif diffRounding <= -0.9;
                                        valStrokeRound = floor(valStroke);
                                    else;
                                        valStrokeRound = roundn(valStroke,0);
                                    end;                                    
                                    refStroke(1,zoneProcess) = valStrokeRound;
                                    diffRounding = diffRounding + (valStroke-valStrokeRound);
                                end;
                                zoneProcess = zoneProcess - 1;
                                if zoneProcess < zoneEC;
                                    proceed = 0;
                                end;
                            end;

                            indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                            refStroke = refStroke(1,indexNAN);
                            SectionNb(lap,zoneEC:indexRef) = refStroke;
                            refNb = SectionNb(lap,zoneEC);
                            Nbtxt = [dataToStr(refNb,0) ' str'];

                            countInterpNb = countInterpNb + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        Nbtxt = '  -  ';
                    else;
%                         Nbtxt = timeSecToStr(SectionNb(lap,zoneEC));
                        refNb = SectionNb(lap,zoneEC)./(countInterpNb+1);
                        refNb = roundn(refNb,0);
                        Nbtxt = [dataToStr(refNb,0) ' str'];
                        countInterpNb = 0;
                    end;
                end;
            end;

            if interpZone == 1;
                data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
            else;
                if Source == 3;
                    if isempty(strfind(SRtxt, '-')) == 0 & isempty(strfind(SDtxt, '-')) == 0 & isempty(strfind(Nbtxt, '-')) == 1;
                        data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
                    else;
                        data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                    end;
                else;
                    data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                end;
            end;

            eval(['dataTableStroke{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        end;
  
        if Course == 50;
            for zoneEC = 5:9;
                interpZone = 0;
    
                if (SectionSR(lap,zoneEC)) == 0;
                    SRtxt = '  -  ';
                else;
                    if isnan((SectionSR(lap,zoneEC))) == 1;
                        if BODistLap > DistZoneEC;
                            SRtxt = '  -  ';
    %                     elseif BODistLap+2 > DistZoneEC
    %                         SRtxt = '  -  ';
                        else;
                            index = find(isnan(SectionSR(lap,:)) == 0);
                            if isempty(index) == 1;
                                SRtxt = '  -  ';
                            else;
                                indexFirst = find(index >= zoneEC);
                                indexRef = index(indexFirst(1));    
                                refSR = SectionSR(lap,indexRef);
                                SectionSR(lap,zoneEC) = refSR;
                                isInterpolatedSR(lap,zoneEC) = 1;
                                SRtxt = [dataToStr(refSR,1) ' str/min'];
                                interpZone = 1;
                                countInterpSR = countInterpSR + 1;
                            end;
                        end;
                    else;
                        if BODistLap > DistZoneEC;
                            SRtxt = '  -  ';
                        elseif BODistLap+2 > DistZoneEC
                            SRtxt = '  -  ';
                        else;
                            if Source == 1 | Source == 3;
                                if isInterpolatedSR(lap,zoneEC) == 1;
                                    SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                                    interpZone = 1;
                                else;
                                    SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                                end;
                            else;
                                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                            end;
                            countInterpSR = 0;
                        end;
                    end;
                end;
    
                if (SectionSD(lap,zoneEC)) == 0;
                    SDtxt = '  -  ';
                else;
                    if isnan((SectionSD(lap,zoneEC))) == 1;
                        if BODistLap > DistZoneEC;
                            SDtxt = '  -  ';
                        elseif BODistLap+2 > DistZoneEC
                            SDtxt = '  -  ';
                        else;
                            index = find(isnan(SectionSD(lap,:)) == 0);
                            if isempty(index) == 1;
                                SDtxt = '  -  ';
                            else;
                                indexFirst = find(index >= zoneEC);
                                indexRef = index(indexFirst(1));    
                                refSD = SectionSD(lap,indexRef);
                                SectionSD(lap,zoneEC) = refSD;
                                isInterpolatedSD(lap,zoneEC) = 1;
                                SDtxt = [dataToStr(refSD,2) ' m'];
                                interpZone = 1;
                                countInterpSD = countInterpSD + 1;
                            end;
                        end;
                    else;
                        if BODistLap > DistZoneEC;
                            SDtxt = '  -  ';
                        elseif BODistLap+2 > DistZoneEC
                            SDtxt = '  -  ';
                        else;
                            if Source == 1 | Source == 3;
                                if isInterpolatedSD(lap,zoneEC) == 1;
                                    SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                                    interpZone = 1;
                                else;
                                    SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                                end;
                            else;
                                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                            end;
                            countInterpSD = 0;
                        end;
                    end;
                end;
                
                if (SectionNb(lap,zoneEC)) == 0;
                    Nbtxt = '  -  ';
                else;
                    if isnan((SectionNb(lap,zoneEC))) == 1;
                        if BODistLap > DistZoneEC;
                            Nbtxt = '  -  ';
                        else;
                            index = find(isnan(SectionNb(lap,:)) == 0);
                            if isempty(index) == 1;
                                Nbtxt = '  -  ';
                            else;
                                
                                indexFirst = find(index >= zoneEC);
                                indexRef = index(indexFirst(1));
                                strokeTot = SectionNb(lap,indexRef);
                                
                                proceed = 1;
                                zoneProcess = indexRef;
                                distRef = 5;
                                refStroke = NaN(1,indexRef);
                                diffRounding = 0;
                                while proceed == 1;
    
                                    if zoneProcess == zoneEC;
                                        indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                                        refStrokebis = refStroke(1,indexNAN);
                                        refStroke(1,zoneProcess) = strokeTot - sum(refStrokebis);
                                    else;
                                        refSD = SectionSD(lap,zoneProcess);
                                        proceedSD = 1;
                                        iter = 1;
                                        iterPlus = 0;
                                        iterMinus = 0;
                                        while proceedSD == 1;
                                            if zoneProcess-iter > 0;
                                                if isnan(refSD) == 1;
                                                    refSD = SectionSD(lap,zoneProcess-iter);
                                                end;
                                            else;
                                                iterMinus = 1;
                                            end;
                                            if zoneProcess+iter <= length(SectionSD(lap,:));
                                                if isnan(refSD) == 1;
                                                    refSD = SectionSD(lap,zoneProcess+iter);
                                                end;
                                            else;
                                                iterPlus = 1;
                                            end;
    
                                            if isnan(refSD) == 0;
                                                proceedSD = 0;
                                            else;
                                                if iterMinus == 1 & iterPlus == 1;
                                                    proceedSD = 0;
                                                    indexNaNSD = find(isnan(SectionSD(lap,:)) == 0);
                                                    refSD = mean(SectionSD(lap,indexNaNSD));
                                                end;
                                            end;
                                            iter = iter + 1;
                                        end;
    
                                        if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                                            refSD = refSD./2;
                                        elseif strcmpi(lower(StrokeType), 'Butterfly') | strcmpi(lower(StrokeType), 'breaststroke');
                                            %no changes
                                        else;
                                            [legLapIM, colLapIM] = find(legsIM == lap);
                                            if legLapIM == 1 | legLapIM == 3;
                                                refSD = refSD./2;
                                            else;
                                                %no changes
                                            end;
                                        end;
                                        refSDIni = refSD;
                                        remSD = mod(refSD,1);
                                        refSD = floor(refSD) + ceil(remSD.*10)./10;
                                        if zoneProcess == nbZones;
                                            valStroke = (distRef-1.5)./refSD;
                                            %remove 1.5m off the last zone
                                        else;
                                            valStroke = distRef./refSD;
                                        end;
    
                                        if diffRounding >= 0.9;
                                            valStrokeRound = ceil(valStroke);
                                        elseif diffRounding <= -0.9;
                                            valStrokeRound = floor(valStroke);
                                        else;
                                            valStrokeRound = roundn(valStroke,0);
                                        end;                                    
                                        refStroke(1,zoneProcess) = valStrokeRound;
    
                                        diffRounding = diffRounding + (valStroke-valStrokeRound);
                                    end;
                                    zoneProcess = zoneProcess - 1;
                                    if zoneProcess < zoneEC;
                                        proceed = 0;
                                    end;
                                end;
    
                                indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                                refStroke = refStroke(1,indexNAN);
                                SectionNb(lap,zoneEC:indexRef) = refStroke;
                                refNb = SectionNb(lap,zoneEC);
                                Nbtxt = [dataToStr(refNb,0) ' str'];
    
                                countInterpNb = countInterpNb + 1;
                            end;
                        end;
                    else;
                        if BODistLap > DistZoneEC;
                            Nbtxt = '  -  ';
                        else;
    %                         Nbtxt = timeSecToStr(SectionNb(lap,zoneEC));
                            refNb = SectionNb(lap,zoneEC)./(countInterpNb+1);
                            refNb = roundn(refNb,0);
                            Nbtxt = [dataToStr(refNb,0) ' str'];
                            countInterpNb = 0;
                        end;
                    end;
                end;
    
                if interpZone == 1;
                    data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
                else;
                    if Source == 3;
                        if isempty(strfind(SRtxt, '-')) == 0 & isempty(strfind(SDtxt, '-')) == 0 & isempty(strfind(Nbtxt, '-')) == 1;
                            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
                        else;
                            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                        end;
                    else;
                        data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                    end;
                end;
    
                eval(['dataTableStroke{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;

            zoneEC = 10; %45-last arm entry
            interpZone = 0;
%             if Source == 1;
%                 addline = addline + 1;
            if Source == 3;
                Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
                data = ['  -    /    -    /    ' Nbtxt ' !'];
                eval(['dataTableStroke{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            else;
                if isnan(SectionSR(lap,zoneEC)) == 1;
                    SRtxt = '  -  ';
                else;
                    SRtxt = [dataToStr(SectionSR(lap,zoneEC),1)  ' str/min'];
                end;
                if isnan(SectionSD(lap,zoneEC)) == 1;
                    SDtxt = '  -  ';
                else;
                    SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                end;
                if isnan(SectionNb(lap,zoneEC)) == 1;
                    Nbtxt = '  -  ';
                else;
                    Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
                end;
                data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];

                eval(['dataTableStroke{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;

            lineEC = lineEC + addline + 1;

        else;
            
            zoneEC = 5; %20-last arm entry 
            interpZone = 0;
%             if Source == 1;
%                 addline = addline + 1;
            if Source == 3;
                Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
                data = ['  -    /    -    /    ' Nbtxt ' !'];
                eval(['dataTableStroke{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            else;
                if isnan(SectionSR(lap,zoneEC)) == 1;
                    SRtxt = '  -  ';
                else;
                    SRtxt = [dataToStr(SectionSR(lap,zoneEC),1)  ' str/min'];
                end;
                if isnan(SectionSD(lap,zoneEC)) == 1;
                    SDtxt = '  -  ';
                else;
                    SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                end;
                if isnan(SectionNb(lap,zoneEC)) == 1;
                    Nbtxt = '  -  ';
                else;
                    Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
                end;
                data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];

                eval(['dataTableStroke{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;
            lineEC = lineEC + addline + 1;
        end;
    end;
end;
if Course == 50;
    limli_Stroke = lineEC - 11 + 9;
else;
    limli_Stroke = lineEC - 6 + 4;
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
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['framerate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['dataTablePacing{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    RaceDist = roundn(RaceDist,0);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['dataTablePacing{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTablePacing{4,' num2str(i) '} = str;']);
    
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTablePacing{5,' num2str(i) '} = str;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTablePacing{6,i} = TTtxt;

    if Source == 1;
        dataTablePacing{7,i} = 'Sparta 1';
    elseif Source == 2;
        dataTablePacing{7,i} = 'Sparta 2';
    elseif Source == 3;
        dataTablePacing{7,i} = 'GreenEye';
    end;

    if Source == 1 | Source == 3;
        eval(['isInterpolatedVel = handles.RacesDB.' UID '.isInterpolatedVel;']);
        eval(['isInterpolatedSplits = handles.RacesDB.' UID '.isInterpolatedSplits;']);
        eval(['isInterpolatedSR = handles.RacesDB.' UID '.isInterpolatedSR;']);
        eval(['isInterpolatedSD = handles.RacesDB.' UID '.isInterpolatedSD;']);
    else;
        isInterpolatedVel = [];
        isInterpolatedSplits = [];
        isInterpolatedSR = [];
        isInterpolatedSD = [];
    end;

    graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]};
    graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; timeSecToStr(SplitsAll(end,2))};
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
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);    
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
                dataTablePacing{lineEC+5,2} = ['20m-Last arm entry'];
                dataTablePacing{lineEC+6,2} = 'Last 5m';
                
                colorrowPacing(lineEC) = rgb_val(255,230,153);
                colorrowPacing(lineEC+1) = rgb_val(230,230,230);
                colorrowPacing(lineEC+2) = rgb_val(192,192,192);
                colorrowPacing(lineEC+3) = rgb_val(230,230,230);
                colorrowPacing(lineEC+4) = rgb_val(192,192,192);
                colorrowPacing(lineEC+5) = rgb_val(230,230,230);
                colorrowPacing(lineEC+6) = rgb_val(192,192,192);

                lineEC = lineEC + 7;
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
                dataTablePacing{lineEC+10,2} = ['45m-Last arm entry'];
                dataTablePacing{lineEC+11,2} = 'Last 5m';

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
                colorrowPacing(lineEC+11) = rgb_val(230,230,230);

                lineEC = lineEC + 12;
                lineECmat = lineECmat + 10;
            end;
        end;
    end;

    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistanceINI;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
%     eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);
    if Source == 1 | Source == 3;
        isInterpolatedBO = BOAll(:,4);
        BOAll = BOAll(:,1:3);
    else;
        isInterpolatedBO = zeros(NbLap,1);
    end;

    lengthdata = [length(DistanceEC) length(VelocityEC) length(TimeEC)];
    if isempty(find(diff(lengthdata) ~= 0)) == 0;
        [minVal, minLoc] = min(lengthdata);
        if minLoc == 1;
            %Adjust Vel and Time
            VelocityEC = VelocityEC(1:length(DistanceEC));
            TimeEC = TimeEC(1:length(DistanceEC));
        elseif minLoc == 2;
            %Adjust Dist and Time
            DistanceEC = DistanceEC(1:length(VelocityEC));
            TimeEC = TimeEC(1:length(VelocityEC));
        elseif minLoc == 3;
            %Adjust Dist and Vel
            DistanceEC = DistanceEC(1:length(TimeEC));
            VelocityEC = VelocityEC(1:length(TimeEC));
        end;
    end;

    if Course == 25;
        nbzone = 5;
    else;
        nbzone = 10;
    end;

    if Source == 2;

        lapLim = Course:Course:RaceDist;
        lapEC = 1;
        updateLap = 0;
        SectionVel = [];
        if Course == 25;
    
        elseif Course == 50;
            
            dataZone = [];
            totZone = NbLap.*(Course./5);
            distIni = 0;
            jumDist = 5;
            for zEC = 1:totZone;
                dataZone(zEC,:) = [distIni distIni+5];
                distIni = distIni + 5;
            end;
            zoneVel = 1;

            for zoneEC = 1:totZone;
    
                zone_dist_ini = dataZone(zoneEC,1);
                zone_dist_end = dataZone(zoneEC,2);
    
                indexLap = find(lapLim == zone_dist_end);
                if isempty(indexLap) == 0;
                    %Last zone for a lap, remove 2m
                    zone_dist_end = zone_dist_end-2;
                    updateLap = 1;
                end;

                if BOAll(lapEC,3) > zone_dist_end;
                    %BO happened in the following zone
                    VelEC = NaN;
    
                elseif BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
                    %BO happened in this zone
                    distBO2End = zone_dist_end-BOAll(lapEC,3);
                    if distBO2End <= 2;
                        %Less than 2m to end of zone
                        VelEC = NaN;
    
                    else;
                        %more than 2m to calculate the speed
                        zone_dist_ini = BOAll(lapEC,3);
                        zone_time_ini = BOAll(lapEC,2);
    
                        [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                        zone_time_end = TimeEC(minLoc(1));
    
                        VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
                    end;
                else;
                    %BO happened before
                    [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                    zone_time_ini = TimeEC(minLoc(1));
    
                    [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                    zone_time_end = TimeEC(minLoc(1));
                    VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
                end;
                SectionVel(lapEC,zoneVel) = VelEC;
                zoneVel = zoneVel + 1;

                if updateLap == 1;
                    updateLap = 0;
                    lapEC = lapEC + 1;
                    zoneVel = 1;
                end;
            end;
        end;

        for lap = 1:NbLap;
            liSplitEnd = SplitsAll(lap,3);
            liStrokeLap = Stroke_Frame(lap,:);
            liInterest = find(liStrokeLap ~= 0);
            liStrokeLap = liStrokeLap(liInterest);
            
            keydist = (lap-1).*Course;
            DistIni = keydist;
            
            for zone = 1:nbzone;
                DistEnd = DistIni + 5;
                diffIni = abs(DistanceEC - DistIni);
                [~, liIni] = min(diffIni);
                if zone == nbzone;
                    linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                    linan = linan + liIni - 1;
                    liEnd = linan(end);
                else;
                    diffEnd = abs(DistanceEC - DistEnd);
                    [~, liEnd] = min(diffEnd);
                end;
    
                if BOAll(lap,1) >= liEnd;
                    SectionSplitTime(lap,zone) = NaN;
                    SectionCumTime(lap,zone) = NaN;
                else;
                    if BOAll(lap,1) > liIni;
                        liIni = BOAll(lap,1) + 1;
                    end;
                    
                    interest = VelocityEC(liIni:liEnd);
                    linonnan = find(isnan(interest) == 0);
                    interest = interest(linonnan);
                    SectionSplitTime(lap,zone) = TimeEC(liEnd) - TimeEC(liIni);
                    SectionCumTime(lap,zone) = TimeEC(liEnd) - TimeEC(1);
                end;     
                DistIni = DistEnd;
            end;
            liSplitIni = SplitsAll(lap,3) + 1;
        end;
        for lap = 1:NbLap
            index = find(SectionVel(lap,:) == 0);
            SectionVel(lap,index) = NaN;

            index = find(SectionCumTime(lap,:) == 0);
            SectionCumTime(lap,index) = NaN;

            index = find(SectionSplitTime(lap,:) == 0);
            SectionSplitTime(lap,index) = NaN;
        end;

        SectionVelbis = SectionVel;
        SectionCumTimebis = SectionCumTime;
        SectionSplitTimebis = SectionSplitTime;

    else;
        
        %load the Section data
%         eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
%         eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
%         eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);

        %fill the gap to get 5m segment
        if Source == 1;
            if RaceDist <= 100;
                eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
                eval(['SectionCumTime = handles.RacesDB.' UID '.SectionCumTime;']);
                eval(['SectionSplitTime = handles.RacesDB.' UID '.SectionSplitTime;']);
                eval(['SectionVel = handles.RacesDB.' UID '.SectionVel;']);
            else;
                eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
                eval(['SectionCumTime = handles.RacesDB.' UID '.SectionCumTimebis;']);
                eval(['SectionSplitTime = handles.RacesDB.' UID '.SectionSplitTimebis;']);
                eval(['SectionVel = handles.RacesDB.' UID '.SectionVelbis;']);
            end;
        elseif Source == 3;
            eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
            eval(['SectionCumTime = handles.RacesDB.' UID '.SectionCumTime;']);
            eval(['SectionSplitTime = handles.RacesDB.' UID '.SectionSplitTime;']);
            eval(['SectionVel = handles.RacesDB.' UID '.SectionVel;']);
        end;

        for lap = 1:NbLap
            index = find(SectionVel(lap,:) == 0);
            SectionVel(lap,index) = NaN;

            index = find(SectionCumTime(lap,:) == 0);
            SectionCumTime(lap,index) = NaN;

            index = find(SectionSplitTime(lap,:) == 0);
            SectionSplitTime(lap,index) = NaN;
        end;
        SectionVelbis = SectionVel;
        SectionCumTimebis = SectionCumTime;
        SectionSplitTimebis = SectionSplitTime;
    end;

    SectionVel = roundn(SectionVel,-2);
    SectionCumTime = roundn(SectionCumTime,-2);
    SectionSplitTime = roundn(SectionSplitTime,-2);
    SectionVelbis = roundn(SectionVelbis,-2);
    SectionCumTimebis = roundn(SectionCumTimebis,-2);
    SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
   
    SectionCumTimeMat = SectionCumTime;
    SectionCumTimeMat(:,end) = SplitsAll(:,2);
    SectionSplitTimeMat = SectionSplitTime;
    SectionSplitTimeMat(:,end) = SectionCumTimeMat(:,end) - SectionCumTimeMat(:,end-1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dataMatSplitsPacing(:,i-1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
    dataMatCumSplitsPacing(:,i-1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);

    dataMatSplitsPacingbis = [];
    dataMatCumSplitsPacingbis = [];
    if isempty(SectionVelbis) == 0;
        SectionVelbis = roundn(SectionVelbis,-2);
        SectionCumTimebis = roundn(SectionCumTimebis,-2);
        SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
        
        SectionCumTimeMatbis = SectionCumTimebis;
        SectionCumTimeMatbis(:,end) = SplitsAll(:,2);
        SectionSplitTimeMatbis = SectionSplitTimebis;
        SectionSplitTimeMatbis(:,end) = SectionCumTimeMatbis(:,end) - SectionCumTimeMatbis(:,end-1);

        dataMatSplitsPacingbis(:,i-1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
        dataMatCumSplitsPacingbis(:,i-1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
        dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    lineEC = 11;
    for lap = 1:NbLap;
        countInterpVel = 0;
        countInterpSplit = 0;
        DistZoneEC = 5 + ((lap-1)*Course);
        BODistLap = BOAll(lap,3);

        addline = 0;
        for zoneEC = 1:4;
            if (SectionVel(lap,zoneEC)) == 0;
                VELtxt = [];
            else;
                if isnan((SectionVel(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        VELtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        VELtxt = '  -  ';
                    else;
                        index = find(isnan(SectionVel(lap,:)) == 0);
                        if isempty(index) == 1;
                            VELtxt = '  -  ';
                        else;
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));    
                            refVel = SectionVel(lap,indexRef);
                            SectionVel(lap,zoneEC) = refVel;
                            isInterpolatedVel(lap,zoneEC) = 1;
                            VELtxt = [dataToStr(refVel,2) ' m/s !'];
                            countInterpVel = countInterpVel + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        VELtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        VELtxt = '  -  ';
                    else;
                        if Source == 1 | Source == 3;
                            if isInterpolatedSplits(lap,zoneEC) == 1;
                                VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s !'];
                            else;
                                VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
                            end;
                        else;
                            VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
                        end;
                        countInterpVel = 0;
                    end;
                end;
            end;

            if (SectionSplitTime(lap,zoneEC)) == 0;
                CTtxt = '  -  ';
                STtxt = '  -  ';
            else;
                if isnan((SectionSplitTime(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        CTtxt = '  -  ';
                        STtxt = '  -  ';
                    else;
                        index = find(isnan(SectionSplitTime(lap,:)) == 0);
                        if isempty(index) == 1;
                            CTtxt = '  -  ';
                            STtxt = '  -  ';
                        else;
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));
                            if indexFirst(1) == 1;
                                indexRefPrev = 0;
                            else;
                                indexRefPrev = index(indexFirst(1)-1);
                            end;
                            jumpZones = indexRef - indexRefPrev;

                            refSplit = SectionSplitTime(lap,indexRef)./jumpZones;
                            refSplit = roundn(refSplit,-2);
                            refSplitCum = SectionCumTime(lap,indexRef) - refSplit;
                            SectionSplitTime(lap,zoneEC) = refSplit;
                            SectionCumTime(lap,zoneEC) = refSplitCum;
                            isInterpolatedSplits(lap,zoneEC) = 1;
    
                            CTtxt = timeSecToStr(refSplitCum);
                            STtxt = timeSecToStr(refSplit);
                            countInterpSplit = countInterpSplit + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        CTtxt = '  -  ';
                        STtxt = '  -  ';
                    else;
                        CTtxt = timeSecToStr(SectionCumTime(lap,zoneEC));
                        refSplit = SectionSplitTime(lap,zoneEC)./(countInterpSplit+1);
                        refSplit = roundn(refSplit,-2);
                        if lap == 1
                            addlaptime = 0;
                        else;
                            addlaptime = SplitsAll(lap-1,2);
                        end;
                        if refSplit+addlaptime == SectionCumTime(lap,zoneEC);
                            %case: for SP1 and GE on the BO segment
                            %Check if BO is known to recalculate it
                            if isInterpolatedBO(lap,1) == 1;
                                STtxt = '  -  ';
                            else;
                                BOTime = BOAll(lap,2);
                                refSplit = SectionCumTime(lap,zoneEC) - BOTime;
                                STtxt = timeSecToStr(refSplit);
                            end;
                        else;
                            STtxt = timeSecToStr(refSplit);
                        end;
                        countInterpSplit = 0;
                    end;
                end;
            end;
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];

            eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        end;


        if Course == 50;
            for zoneEC = 5:9;
                if (SectionVel(lap,zoneEC)) == 0;
                    VELtxt = [];
                else;
                    if isnan((SectionVel(lap,zoneEC))) == 1;
                        if BODistLap > DistZoneEC;
                            VELtxt = '  -  ';
                        elseif BODistLap+2 > DistZoneEC
                            VELtxt = '  -  ';
                        else;
                            index = find(isnan(SectionVel(lap,:)) == 0);
                            if isempty(index) == 1;
                                VELtxt = '  -  ';
                            else;
                                indexFirst = find(index >= zoneEC);
                                indexRef = index(indexFirst(1));    
                                refVel = SectionVel(lap,indexRef);
                                SectionVel(lap,zoneEC) = refVel;
                                isInterpolatedVel(lap,zoneEC) = 1;
                                VELtxt = [dataToStr(refVel,2) ' m/s !'];
                                countInterpVel = countInterpVel + 1;
                            end;
                        end;
                    else;
                        if BODistLap > DistZoneEC;
                            VELtxt = '  -  ';
                        elseif BODistLap+2 > DistZoneEC
                            VELtxt = '  -  ';
                        else;
                            if Source == 1 | Source == 3;
                                if isInterpolatedSplits(lap,zoneEC) == 1;
                                    VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s !'];
                                else;
                                    VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
                                end;
                            else;
                                VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
                            end;
                            countInterpVel = 0;
                        end;
                    end;
                end;
    
                if (SectionSplitTime(lap,zoneEC)) == 0;
                    CTtxt = '  -  ';
                    STtxt = '  -  ';
                else;
                    if isnan((SectionSplitTime(lap,zoneEC))) == 1;
                        if BODistLap >= DistZoneEC;
                            CTtxt = '  -  ';
                            STtxt = '  -  ';
                        else;
                            index = find(isnan(SectionSplitTime(lap,:)) == 0);
                            if isempty(index) == 1;
                                CTtxt = '  -  ';
                                STtxt = '  -  ';
                            else;
                                indexFirst = find(index >= zoneEC);
                                indexRef = index(indexFirst(1));
                                if indexFirst(1) == 1;
                                    indexRefPrev = 0;
                                else;
                                    indexRefPrev = index(indexFirst(1)-1);
                                end;
                                jumpZones = indexRef - indexRefPrev;
    
                                refSplit = SectionSplitTime(lap,indexRef)./jumpZones;
                                refSplit = roundn(refSplit,-2);
                                refSplitCum = SectionCumTime(lap,indexRef) - refSplit;
                                SectionSplitTime(lap,zoneEC) = refSplit;
                                SectionCumTime(lap,zoneEC) = refSplitCum;
                                isInterpolatedSplits(lap,zoneEC) = 1;
        
                                CTtxt = timeSecToStr(refSplitCum);
                                STtxt = timeSecToStr(refSplit);
                                countInterpSplit = countInterpSplit + 1;
                            end;
                        end;
                    else;
                        if BODistLap > DistZoneEC;
                            CTtxt = '  -  ';
                            STtxt = '  -  ';
                        else;
                            CTtxt = timeSecToStr(SectionCumTime(lap,zoneEC));
                            refSplit = SectionSplitTime(lap,zoneEC)./(countInterpSplit+1);
                            refSplit = roundn(refSplit,-2);

                            
                            if lap == 1
                                addlaptime = 0;
                            else;
                                addlaptime = SplitsAll(lap-1,2);
                            end;

                            if refSplit+addlaptime == SectionCumTime(lap,zoneEC);
                                %case: for SP1 and GE on the BO segment
                                %Check if BO is known to recalculate it
                                if isInterpolatedBO(lap,1) == 1;
                                    STtxt = '  -  ';
                                else;
                                    BOTime = BOAll(lap,2);
                                    refSplit = SectionCumTime(lap,zoneEC) - BOTime;
                                    STtxt = timeSecToStr(refSplit);
                                end;
                            else;
                                STtxt = timeSecToStr(refSplit);
                            end;
                            countInterpSplit = 0;
                        end;
                    end;
                end;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
                eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;

            zoneEC = 10; %45-last arm entry 
            if Source == 1 | Source == 3; %nothing
                data = ['  -    /    -    /    -  '];
                eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            else;
                if (SectionVel(lap,10)) == 0;
                    data = ['  -    /    -    /    -  '];
                else;
                    VELtxt = dataToStr(SectionVel(lap,10),2);
                    CTtxt = timeSecToStr(SectionCumTime(lap,9)+SectionSplitTime(lap,10));
                    STtxt = timeSecToStr(SectionSplitTime(lap,10));
                    data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
                end;
                eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;

            %Last 5m
            eval(['data = handles.RacesDB.' UID '.Last5m;']);
            dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,9) + data);
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            datatxt = num2str(roundn(data, -2));
            while length(datatxt) < 4;
                if length(datatxt) == 1;
                    datatxt = [datatxt '.0'];
                else;
                    datatxt = [datatxt '0'];
                end;
            end;
            CTtxt = timeSecToStr(SplitsAll(lap,2));

            if Source == 2;
                VELtxt = [dataToStr(SectionVel(lap,10),2) ' m/s'];
            else;
                VELtxt = '  -  ';
            end;
            data = [datatxt ' s  /  ' CTtxt '  /  ' VELtxt];
            eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            lineEC = lineEC + addline + 2;

        else;
            
            zoneEC = 5; %45-last arm entry 
            if Source == 1 | Source == 3; %nothing
                data = ['  -    /    -    /    -  '];
                eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            else;
                if (SectionVel(lap,5)) == 0;
                    data = ['  -    /    -    /    -  '];
                else;
                    VELtxt = dataToStr(SectionVel(lap,5),2);
                    CTtxt = timeSecToStr(SectionCumTime(lap,4)+SectionSplitTime(lap,5));
                    STtxt = timeSecToStr(SectionSplitTime(lap,5));
                    data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
                end;
                eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;

            %Last 5m
            eval(['data = handles.RacesDB.' UID '.Last5m;']);
            dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,4) + data);
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            datatxt = num2str(roundn(data, -2));
            while length(datatxt) < 4;
                if length(datatxt) == 1;
                    datatxt = [datatxt '.0'];
                else;
                    datatxt = [datatxt '0'];
                end;
            end;
            CTtxt = timeSecToStr(SplitsAll(lap,2));

            if Source == 2;
                VELtxt = [dataToStr(SectionVel(lap,5),2) ' m/s'];
            else;
                VELtxt = '  -  ';
            end;
            data = [datatxt ' s  /  ' CTtxt '  /  ' VELtxt];
            eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            lineEC = lineEC + addline + 2;
        end;
        
%         if Course == 50;
%             lineEC = lineEC + 12;
%         else;
%             lineEC = lineEC + 7;
%         end;
    end;
end;
if Course == 50;
    limli_Pacing = lineEC - 12 + 10;
else;
    limli_Pacing = lineEC - 7 + 5;
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
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['framerate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['dataTableSkill{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSkill{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTableSkill{4,' num2str(i) '} = str;']);
    
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    if strcmpi(detailRelay, 'None') == 1;
        str = Stage;
    else;
        str = [Stage ' - ' detailRelay ' ' valRelay];
    end;
    eval(['dataTableSkill{5,' num2str(i) '} = str;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableSkill{6,i} = TTtxt;

    if Source == 1;
        dataTableSkill{7,i} = 'Sparta 1';
    elseif Source == 2;
        dataTableSkill{7,i} = 'Sparta 2';
    elseif Source == 3;
        dataTableSkill{7,i} = 'GreenEye';
    end;

    %--------------------------------Skills--------------------------------
    try;
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    catch;
        eval(['NbLap = handles.RacesDB.' UID '.nbLap;']);
    end;
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
        eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
        
        %Start interpolation
        indexDive = find(RaceLocation(:,5) == 15); 
        if isnan(RaceLocation(indexDive,3)) == 1;
            isInterpolatedDive = 1;
        else;
            isInterpolatedDive = 0;
        end;
        
        %Turns interpolation
        isInterpolatedTurns = zeros(NbLap-1,3);
        for lap = 1:NbLap-1;
            if Source == 1;
                %reverse the distance for each lap
                if rem(lap,2) == 1;
                    %odd laps
                    index50 = find(RaceLocation(:,5) == Course);
                    index50 = index50((lap+1)/2);
                    TurnLocation = RaceLocation(index50-2:index50+2,:);
                    indexIn = find(TurnLocation(:,5) == Course-5);
                    indexOut = find(TurnLocation(:,5) == Course-10); 
                    if isnan(TurnLocation(indexIn,3)) == 1;
                        isInterpolatedTurns(lap,1) = 1;
                        isInterpolatedTurns(lap,3) = 1; 
                    end;
                    if isnan(TurnLocation(indexOut,3)) == 1;
                        isInterpolatedTurns(lap,2) = 1;
                        isInterpolatedTurns(lap,3) = 1;
                    end;
                else;
                    %even laps
                    index0 = find(RaceLocation(:,5) == 0);
                    index0 = index0((lap/2)+1);
                    TurnLocation = RaceLocation(index0-2:index0+2,:);
                    indexIn = find(TurnLocation(:,5) == 5);
                    indexOut = find(TurnLocation(:,5) == 10); 
                    if isnan(TurnLocation(indexIn,3)) == 1;
                        isInterpolatedTurns(lap,1) = 1;
                        isInterpolatedTurns(lap,3) = 1; 
                    end;
                    if isnan(TurnLocation(indexOut,3)) == 1;
                        isInterpolatedTurns(lap,2) = 1;
                        isInterpolatedTurns(lap,3) = 1;
                    end;
                end;
                
            elseif Source == 3;
                %cumulative distance
                TurinDist = (lap*Course) - 5;
                TurOutDist = (lap*Course) + 10;
                indexIn = find(RaceLocation(:,5) == TurinDist);
                indexOut = find(RaceLocation(:,5) == TurOutDist); 
                if isnan(RaceLocation(indexIn,3)) == 1;
                    isInterpolatedTurns(lap,1) = 1;
                    isInterpolatedTurns(lap,3) = 1; 
                end;
                if isnan(RaceLocation(indexOut,3)) == 1;
                    isInterpolatedTurns(lap,2) = 1;
                    isInterpolatedTurns(lap,3) = 1;
                end;
            end;
        end;

        %Finish interpolation
        if Source == 1;
            if RaceDist == 50 | RaceDist == 150;
                indexFinish = find(RaceLocation(:,5) == Course-5); 
                indexFinish = indexFinish(end);
            else;
                indexFinish = find(RaceLocation(:,5) == 5); 
                indexFinish = indexFinish(end);
            end;
        elseif Source == 3;
            indexFinish = find(RaceLocation(:,5) == RaceDist-5); 
        end;
        if isnan(RaceLocation(indexFinish,3)) == 1;
            isInterpolatedFinish = 1;
        else;
            isInterpolatedFinish = 0;
        end;

        if isInterpolatedDive == 0 & isempty(find(isInterpolatedTurns) == 1) == 1 & isInterpolatedFinish == 0;
            isInterpolatedSkills = 0;
        else;
            isInterpolatedSkills = 1;
        end;
    else;
        RaceLocation = [];
        isInterpolatedDive = 0;
        isInterpolatedFinish = 0;
        isInterpolatedTurns = zeros(NbLap-1,3);
        isInterpolatedSkills = 0;
    end;


    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTimeINI;']);
    TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
    if isInterpolatedSkills == 0;
        %no interpolation
        dataTableSkill{10,i} = TotalSkillTimetxt;
    else;
        %interpolation
        dataTableSkill{10,i} = [TotalSkillTimetxt ' !'];
    end;

    dataTableSkill{11,i} = 'na'; %Total underwater Distance
    dataTableSkill{12,i} = 'na'; %Total underwater Time
    
    eval(['Turn_Time = handles.RacesDB.' UID '.Turn_TimeINI;']);
    eval(['Turn_TimeIn = handles.RacesDB.' UID '.Turn_TimeInINI;']);
    eval(['Turn_TimeOut = handles.RacesDB.' UID '.Turn_TimeOutINI;']);

    Turn_TimeALL(:,:,i-2) = Turn_Time;
    Turn_TimeInALL(:,:,i-2) = Turn_TimeIn;
    Turn_TimeOutALL(:,:,i-2) = Turn_TimeOut;
    Turn_Timetxt = timeSecToStr(roundn(sum(Turn_Time),-2));
    Turn_TimeIntxt = timeSecToStr(roundn(sum(Turn_TimeIn),-2));
    Turn_TimeOuttxt = timeSecToStr(roundn(sum(Turn_TimeOut),-2));
    if isempty(find(isInterpolatedTurns == 1)) == 1;
        %no interpolation
        dataTableSkill{13,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
    else;
        %interpolation
        dataTableSkill{13,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt ' !'];
    end;
    
    %%%%Start
    SplitsAll = SplitsAll(2:end,:);

    eval(['DiveT15 = handles.RacesDB.' UID '.DiveT15INI;']);
    DiveT15txt = timeSecToStr(roundn(DiveT15,-2));
    if isInterpolatedDive == 0;
        dataTableSkill{15,i} = DiveT15txt;
    else;
        dataTableSkill{15,i} = [DiveT15txt ' !'];
    end;
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    RTtxt = timeSecToStr(roundn(RT,-2));
    dataTableSkill{16,i} = RTtxt;
    
    eval(['StartUWVelocity = handles.RacesDB.' UID '.StartUWVelocity;']);
    eval(['StartEntryDist = handles.RacesDB.' UID '.StartEntryDist;']);
    eval(['StartUWDist = handles.RacesDB.' UID '.StartUWDist;']);
    eval(['StartUWTime = handles.RacesDB.' UID '.StartUWTime;']);
    if isempty(StartUWVelocity) == 1;
        dataTableSkill{17,i} = 'na';    %Entry Distance
        dataTableSkill{18,i} = 'na';    %Unverwater Distance
        dataTableSkill{19,i} = 'na';    %Unverwater Time
        dataTableSkill{20,i} = 'na';    %Unverwater Speed
    else;
        dataTableSkill{17,i} = [dataToStr(StartEntryDist, 2) ' m'];     %Entry Distance
        dataTableSkill{18,i} = [dataToStr(StartUWDist, 2) ' m'];        %Unverwater Distance
        dataTableSkill{19,i} = timeSecToStr(StartUWTime);               %Unverwater Time
        dataTableSkill{20,i} = [dataToStr(StartUWVelocity, 2) ' m/s'];  %Unverwater Speed
    end;
    
    eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
    dataTableSkill{21,i} = [num2str(KicksNb(1)) ' Kicks'];
    
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);
    if Source == 1 | Source == 3;
        isInterpolatedBO = BOAll(:,4);
        BOAll = BOAll(:,1:3);
    else;
        isInterpolatedBO = zeros(NbLap,1);
    end;
    BOdisttxt = dataToStr(BOAll(1,3),1);
    if isInterpolatedBO(1) == 0;
        dataTableSkill{22,i} = [BOdisttxt ' m'];
        BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
        dataTableSkill{23,i} = BOTimetxt;
    else;
        dataTableSkill{22,i} = [BOdisttxt ' m !'];
        BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
        dataTableSkill{23,i} = [BOTimetxt ' !'];
    end;
    
    eval(['BOEff = handles.RacesDB.' UID '.BOEff;']);
    eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
    eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
    BOEfftxt = dataToStr(BOEff(1,1).*100,1);
    VelAftertxt = dataToStr(VelAfterBO(1,1),2);
    VelBeforetxt = dataToStr(VelBeforeBO(1,1),2);
    if Source == 1 | Source == 3;
        dataTableSkill{24,i} = [' na  /  na  /  na '];
    elseif Source == 2;
        dataTableSkill{24,i} = [BOEfftxt ' %  /  ' VelBeforetxt ' m/s  /  ' VelAftertxt ' m/s'];
    end;
    
    %%%%Turns averages
    if NbLap == 1;
        dataTableSkill{26,i} = '  -  /  -  /  -  ';
        dataTableSkill{27,i} = '  -  ';
        dataTableSkill{28,i} = '  -  ';
        dataTableSkill{29,i} = '  -  ';
        dataTableSkill{30,i} = '  -  ';
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
        if isempty(find(isInterpolatedTurns == 1)) == 1;
            %no interpolation
            dataTableSkill{26,i} = [AvTurnIntxt '  /  ' AvTurnOuttxt '  /  ' AvTurnTimetxt];
        else;
            dataTableSkill{26,i} = [AvTurnIntxt '  /  ' AvTurnOuttxt '  /  ' AvTurnTimetxt ' !'];
        end;

        AvKicksNb = roundn(mean(KicksNb(2:end)),-2);
        AvKicksNbtxt = dataToStr(AvKicksNb,0);
        dataTableSkill{27,i} = [AvKicksNbtxt ' Kicks'];

        BOTurn = [];
        for lap = 2:NbLap;
            BO = BOAll(lap,3);
            BO = BO - ((lap-1).*Course);
            BOTurn = [BOTurn BO];
        end;
        AvBODistTurn = roundn(mean(BOTurn),-2);
        AvBODistTurntxt = dataToStr(AvBODistTurn,1);
        if isempty(find(isInterpolatedBO(2:end) == 1)) == 1;
            %no interpolation
            dataTableSkill{28,i} = [AvBODistTurntxt ' m'];
        else;
            %interpolation
            dataTableSkill{28,i} = [AvBODistTurntxt ' m !'];
        end;

        BOTurn = [];
        for lap = 2:NbLap;
            BO = BOAll(lap,2);
            BO = BO - SplitsAll(lap-1,2);
            BOTurn = [BOTurn BO];
        end;
        AvBOTimeTurn = roundn(mean(BOTurn),-2);
        AvBOTimeTurntxt = timeSecToStr(AvBOTimeTurn);
        if isempty(find(isInterpolatedBO(2:end) == 1)) == 1;
            %no interpolation
            dataTableSkill{29,i} = AvBOTimeTurntxt;
        else;
            %interpolation
            dataTableSkill{29,i} = [AvBOTimeTurntxt ' !'];
        end;

        eval(['BOEffTurn = handles.RacesDB.' UID '.BOEff(2:end);']);
        BOEffTurn = roundn(mean(BOEffTurn).*100,-2);
        BOEffTurntxt = dataToStr(BOEffTurn,1);
        VelBefTurn = roundn(mean(VelBeforeBO(2:end)),-2);
        VelBefTurntxt = dataToStr(VelBefTurn,2);
        VelAftTurn = roundn(mean(VelAfterBO(2:end)),-2);
        VelAftTurntxt = dataToStr(VelAftTurn,2);
        if Source == 1 | Source == 3;
            dataTableSkill{30,i} = [' na  /  na  /  na '];
        elseif Source == 2;
            dataTableSkill{30,i} = [BOEffTurntxt ' %  /  ' VelBefTurntxt ' m/s  /  ' VelAftTurntxt ' m/s'];
        end;
    end;
    
    %%%%Turn Details
    if NbLap ~= 1;
        lineEC = 31;
        for lap = 1:NbLap-1;
            dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];

            Turn_TimeIntxt = timeSecToStr(roundn(Turn_TimeIn(lap),-2));
            Turn_TimeOuttxt = timeSecToStr(roundn(Turn_TimeOut(lap),-2));
            Turn_Timetxt = timeSecToStr(roundn(Turn_Time(lap),-2));
            if isempty(find(isInterpolatedTurns(lap,:) == 1)) == 1;
                %no interpolation
                dataTableSkill{lineEC+1,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
            else;
                %interpolation
                dataTableSkill{lineEC+1,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt ' !'];
            end;

            eval(['ApproachEff = handles.RacesDB.' UID '.ApproachEff;']);
            eval(['Approach2CycleAll = handles.RacesDB.' UID '.ApproachSpeed2CycleAll;']);
            eval(['ApproachLastCycleAll = handles.RacesDB.' UID '.ApproachSpeedLastCycleAll;']);
            ApproachEffTurn = roundn(ApproachEff(lap).*100,-2);
            ApproachEffTurntxt = dataToStr(ApproachEffTurn,1);
            Approach2CycleAlltxt = dataToStr(Approach2CycleAll(lap),2);
            ApproachLastCycleAlltxt = dataToStr(ApproachLastCycleAll(lap),2);
            if Source == 1 | Source == 3;
                dataTableSkill{lineEC+2,i} = [' na  /  na  /  na '];
            elseif Source == 2;
                dataTableSkill{lineEC+2,i} = [ApproachEffTurntxt ' %  /  ' Approach2CycleAlltxt ' m/s  /  ' ApproachLastCycleAlltxt ' m/s'];
            end;

            eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
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
            if isInterpolatedBO(lap+1) == 0;
                %no interpolation
                dataTableSkill{lineEC+5,i} = [BOdisttxt ' m'];
            else;
                %Interpolation
                dataTableSkill{lineEC+5,i} = [BOdisttxt ' m !'];
            end;
            BO = BOAll(lap+1,2);
            BO = BO - SplitsAll(lap,2);
            BOtimetxt = timeSecToStr(BO);
            if isInterpolatedBO(lap+1) == 0;
                %no interpolation
                dataTableSkill{lineEC+6,i} = BOtimetxt;
            else;
                %Interpolation
                dataTableSkill{lineEC+6,i} = [BOtimetxt ' !'];
            end;

            eval(['BOEffTurn = handles.RacesDB.' UID '.BOEff;']);
            eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
            eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
            BOEffTurntxt = dataToStr(BOEffTurn(lap+1).*100,1);
            
            VelAfterBOtxt = dataToStr(VelAfterBO(lap+1),2);
            VelBeforeBOtxt = dataToStr(VelBeforeBO(lap+1),2);
            if Source == 1 | Source == 3;
                dataTableSkill{lineEC+7,i} = [' na  /  na  /  na '];
            elseif Source == 2;
                dataTableSkill{lineEC+7,i} = [BOEffTurntxt ' %  /  ' VelBeforeBOtxt ' m/s  /  ' VelAfterBOtxt ' m/s'];
            end;
            
            lineEC = lineEC + 8;
        end;
    end;

    eval(['Last5m = handles.RacesDB.' UID '.Last5mINI;']);
    Last5mtxt = timeSecToStr(Last5m);
    if isInterpolatedFinish == 0;
        %no interpolation
        dataTableSkill{lineEC+1,i} = Last5mtxt;
    else;
        %Interpolation
        dataTableSkill{lineEC+1,i} = [Last5mtxt ' !'];
    end;

    if NbLap == 1;
        eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
    end;
    GlideLastStrokeDist = roundn(GlideLastStroke(3,end),-2);
    GlideLastStrokeTime = roundn(GlideLastStroke(4,end),-2);
    GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
    GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
    if Source == 1 | Source == 3;
        dataTableSkill{lineEC+2,i} = [' na  /  na '];
    else;
        dataTableSkill{lineEC+2,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
    end;
end;
limli_Skill = lineEC + 2;
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
    try;
        excelRenderingTable_analyser;
    end;
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
