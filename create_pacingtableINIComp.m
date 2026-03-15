% RacesTOT = length(handles.uidDB(:,1));
% nbRaces = length(handles.filelistAdded);
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
% set(gcf, 'units', 'pixels');
% PosFig = get(gcf, 'Position');
% set(gcf, 'units', 'normalized');

if strcmpi(origin, 'table') == 1;
    colorrow(1,:) = [1 0.9 0.1];
    colorrow(2,:) = [0.9 0.9 0.9];
    colorrow(3,:) = [0.75 0.75 0.75];
    colorrow(4,:) = [0.9 0.9 0.9];
    colorrow(5,:) = [0.75 0.75 0.75];
    colorrow(6,:) = [0.9 0.9 0.9];
    colorrow(7,:) = [1 1 1];
    colorrow(8,:) = [1 0.9 0.1];

    formatlist{1} = 'char';
    formatlist{2} = 'char';
    edittablelist(1) = false;
    edittablelist(2) = false;
    for i = 1:nbRaces;
        formatlist{i+2} = 'numeric';
        edittablelist(i+2) = false;
    end;
    
    PosINI = get(handles.PacingData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosPacingTable;
    set(handles.PacingData_table_analyser, 'Position', posCorr);

    set(handles.PacingData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.PacingData_table_analyser, 'position');
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
    set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
%     set(handles.PacingData_table_analyser, 'Units', 'normalized');
end;

dataTablePacing = {};
dataTablePacing{1,2} = 'Metadata';
dataTablePacing{8,2} = 'Pacing';
dataTablePacing{9,1} = 'Splits / Cumul';
dataTablePacing{9,2} = ' / Speed';
dataMatSplitsPacing = [];
dataMatCumSplitsPacing = [];

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

    if Source == 1;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP1']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(SplitsAll(end,2)) '  -  SP1']};
    elseif Source == 2;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP2']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(SplitsAll(end,2)) '  -  SP2']};
    elseif Source == 3;
        graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-GE']};
        graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(SplitsAll(end,2)) '  -  GE']};
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
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);    
    if i == 3;
        colorrow(9,:) = [1 0.9 0.70];
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
                
                dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
                dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
                dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
                dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
                dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];
                colorrow(lineEC+6,:) = [0.75 0.75 0.75];

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
                
                dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
                dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
                dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
                dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
                dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
                dataMatSplitsPacing(lineECmat+5, 1) = (Course*(lap-1)) + 30;
                dataMatSplitsPacing(lineECmat+6, 1) = (Course*(lap-1)) + 35;
                dataMatSplitsPacing(lineECmat+7, 1) = (Course*(lap-1)) + 40;
                dataMatSplitsPacing(lineECmat+8, 1) = (Course*(lap-1)) + 45;
                dataMatSplitsPacing(lineECmat+9, 1) = (Course*(lap-1)) + 50;

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];
                colorrow(lineEC+6,:) = [0.75 0.75 0.75];
                colorrow(lineEC+7,:) = [0.9 0.9 0.9];
                colorrow(lineEC+8,:) = [0.75 0.75 0.75];
                colorrow(lineEC+9,:) = [0.9 0.9 0.9];
                colorrow(lineEC+10,:) = [0.75 0.75 0.75];
                colorrow(lineEC+11,:) = [0.9 0.9 0.9];

                lineEC = lineEC + 12;
                lineECmat = lineECmat + 10;
            end;
        end;
    end;
    if i == 3;
        dataMatCumSplitsPacing = dataMatSplitsPacing;
    end;

    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistanceINI;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocityINI;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Stroke_Time = handles.RacesDB.' UID '.Stroke_Time;']);
    
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

                eval(['SectionCumTimePDF = handles.RacesDB.' UID '.SectionCumTime;']);
                eval(['SectionSplitTimePDF = handles.RacesDB.' UID '.SectionSplitTime;']);
                eval(['SectionVelPDF = handles.RacesDB.' UID '.SectionVel;']);

            end;
        elseif Source == 3;
            eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
            eval(['SectionCumTime = handles.RacesDB.' UID '.SectionCumTime;']);
            eval(['SectionSplitTime = handles.RacesDB.' UID '.SectionSplitTime;']);
            eval(['SectionVel = handles.RacesDB.' UID '.SectionVel;']);

            eval(['SectionCumTimePDF = handles.RacesDB.' UID '.SectionCumTime;']);
            eval(['SectionSplitTimePDF = handles.RacesDB.' UID '.SectionSplitTime;']);
            eval(['SectionVelPDF = handles.RacesDB.' UID '.SectionVel;']);
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

    lineEC = 11;
    for lap = 1:NbLap;
        countInterpVel = 0;
        countInterpSplit = 0;
        DistZoneEC = 5 + ((lap-1)*Course);
        BODistLap = BOAll(lap,3);

        addline = 0;
        for zoneEC = 1:4;
            AddInterpolationtxt = '';
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
                            BOTime = BOAll(lap,2);
                            refSplit = SectionCumTime(lap,zoneEC) - BOTime;
                            SectionSplitTime(lap,zoneEC) = refSplit;
                            STtxt = timeSecToStr(refSplit);
                            if isInterpolatedBO(lap,1) == 1;
                                AddInterpolationtxt = [' !'];
                            else;
                                AddInterpolationtxt = '';
                            end;
                        else;
                            STtxt = timeSecToStr(refSplit);
                            SectionSplitTime(lap,zoneEC) = refSplit;
                        end;
                        countInterpSplit = 0;
                    end;
                end;
            end;
            if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
            else;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
            end;

            eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        end;


        if Course == 50;
            for zoneEC = 5:9;
                AddInterpolationtxt = '';
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
                                BOTime = BOAll(lap,2);
                                refSplit = SectionCumTime(lap,zoneEC) - BOTime;
                                SectionSplitTime(lap,zoneEC) = refSplit;
                                STtxt = timeSecToStr(refSplit);
                                if isInterpolatedBO(lap,1) == 1;
                                    AddInterpolationtxt = [' !'];
                                else;
                                    AddInterpolationtxt = '';
                                end;
                            else;
                                STtxt = timeSecToStr(refSplit);
                                SectionSplitTime(lap,zoneEC) = refSplit;
                            end;
                            countInterpSplit = 0;
                        end;
                    end;
                end;
                if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
                    data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
                else;
                    data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
                end;
                eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
                DistZoneEC = DistZoneEC + 5;
                addline = addline + 1;
            end;

            zoneEC = 10; %45-last arm entry 
            AddInterpolationtxt = '';
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
            AddInterpolationtxt = '';
            if Source == 3;
                AddInterpolationtxt = ' !';
            end;
            eval(['data = handles.RacesDB.' UID '.Last5m;']);
            dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,9) + data);
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            STtxt = timeSecToStr(data);
            CTtxt = timeSecToStr(SplitsAll(lap,2));
            SectionSplitTime(lap,zoneEC) = data;

            if Source == 2;
                VELtxt = [dataToStr(SectionVel(lap,10),2) ' m/s'];
            else;
                VELtxt = '  -  ';
            end;
            if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
            else;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
            end;
            eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            lineEC = lineEC + addline + 2;

        else;
            
            zoneEC = 5; %45-last arm entry 
            AddInterpolationtxt = '';
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
            AddInterpolationtxt = '';
            if Source == 3;
                AddInterpolationtxt = ' !';
            end;
            dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,4) + data);
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            STtxt = timeSecToStr(data);
            CTtxt = timeSecToStr(SplitsAll(lap,2));
            SectionSplitTime(lap,zoneEC) = data;

            CTtxt = timeSecToStr(SplitsAll(lap,2));

            if Source == 2;
                VELtxt = [dataToStr(SectionVel(lap,5),2) ' m/s'];
            else;
                VELtxt = '  -  ';
            end;
            if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
            else;
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
            end;
            eval(['dataTablePacing{' num2str(lineEC+addline) ',' num2str(i) '} = data;']);
            lineEC = lineEC + addline + 2;
        end;

%         if Course == 50;
%             lineEC = lineEC + 12;
%         else;
%             lineEC = lineEC + 7;
%         end;
    end;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    SectionCumTimeMat = SectionCumTime;
    SectionCumTimeMat(:,end) = SplitsAll(:,2);
    SectionSplitTimeMat = SectionSplitTime;
    SectionSplitTimeMat(:,end) = SectionCumTimeMat(:,end) - SectionCumTimeMat(:,end-1);
    
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


    eval(['handles.SplitsAllR' num2str(i-2) ' = SplitsAll;']);
    eval(['handles.SourceR' num2str(i-2) ' = Source;']); 
    eval(['handles.BOAllR' num2str(i-2) ' = BOAll;']);
% end;

if strcmpi(origin, 'table') == 1;
    handles.dataTablePacing = dataTablePacing;
    handles.colorrowPacing = colorrow;

    set(handles.StrokeData_table_analyser, 'Visible', 'off');
    set(handles.SkillData_table_analyser, 'Visible', 'off');
    set(handles.PacingData_table_analyser, 'data', dataTablePacing, 'backgroundcolor', colorrow);
    set(handles.SummaryData_table_analyser, 'Visible', 'off');
    
    table_extent = get(handles.PacingData_table_analyser, 'Extent');
    table_position = get(handles.PacingData_table_analyser, 'Position');
    pos_cor = table_position;
    if table_extent(4) < table_position(4);
        
        if Extent == 0;
            %Add 5% to give space for the slider bar at the bottom
            offset = 18;
            pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)-offset;
            pos_cor(4) = table_extent(4)+offset;
        else;
            pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)+1;
            pos_cor(4) = table_extent(4)+1;
        end;
        
    elseif table_extent(4) >= table_position(4);
        if table_position(2) < (0.0069*PosFig(4));
            pos_cor(2) = (0.0069*PosFig(4))+1;
            pos_cor(4) = (handles.TopINI_PacingTable*PosFig(4))+1;
            
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
            set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
        else;
            if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                pos_cor(2) = (0.0069*PosFig(4))+1;
                pos_cor(4) = (handles.TopINI_PacingTable*PosFig(4))+1;
                
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
                set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                if Extent == 0;
                    %Add 5% to give space for the slider bar at the bottom
                    offset = 18;
                    pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)-offset;
                    pos_cor(4) = table_extent(4)+offset;
                else;
                    pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)+1;
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
    set(handles.PacingData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
    set(handles.PacingData_table_analyser, 'Units', 'normalized');
    
    PosEND = get(handles.PacingData_table_analyser, 'Position');
    PosEND = PosEND(3);
    handles.diffPosPacingTable = PosEND - handles.PosINI_PacingTable;
end;

