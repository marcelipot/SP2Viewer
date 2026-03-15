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

    PosINI = get(handles.StrokeData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosStrokeTable;
    set(handles.StrokeData_table_analyser, 'Position', posCorr);

    set(handles.StrokeData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.StrokeData_table_analyser, 'position');
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
    set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
%     set(handles.StrokeData_table_analyser, 'Units', 'normalized');
end;

dataTableStroke = {};
dataTableStroke{1,2} = 'Metadata';
dataTableStroke{8,2} = 'Stroke Management';
dataTableStroke{9,1} = 'SR / SL / Stroke';

SectionSRALL = [];
SectionSDALL = [];
SectionVelALL = [];
SectionSRALLbis = [];
SectionSDALLbis = [];
SectionVelALLbis = [];

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
        colorrow(9,:) = [1 0.9 0.70];
        lineEC = 10;
        for lap = 1:NbLap;
            dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-Last arm entry';

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];

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

                lineEC = lineEC + 11;
            end;
        end;
    end;

    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistanceINI;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocityINI;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
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
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            li_strokeExtra = li_strokeExtra(end);

                            strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (10*framerate);
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
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_stroke(end);

                                strokeList = [strokeList li_strokeExtra];

                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (10*framerate);
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
    
    
        %calculate DPS per sections
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
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            li_strokeExtra = li_strokeExtra(end);

                            strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (10*framerate);
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
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(end);

                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (10*framerate);
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

                eval(['SectionSDPDF = handles.RacesDB.' UID '.SectionSD;']);
                eval(['SectionSRPDF = handles.RacesDB.' UID '.SectionSR;']);
                eval(['SecSectionNbPDF = handles.RacesDB.' UID '.SectionNb;']);


            end;
        elseif Source == 3;
            eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
            eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
            eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
            eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);

            eval(['SectionSDPDF = handles.RacesDB.' UID '.SectionSD;']);
            eval(['SectionSRPDF = handles.RacesDB.' UID '.SectionSR;']);
            eval(['SecSectionNbPDF = handles.RacesDB.' UID '.SectionNb;']);
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

    
    SectionSRALL(:,:,i-2) = SectionSR;
    SectionSDALL(:,:,i-2) = SectionSD;
%     SectionVelALL(:,:,i-2) = SectionVel;
    if isempty(SectionSRbis) == 0;
        SectionSRALLbis(:,:,i-2) = SectionSRbis;
        SectionSDALLbis(:,:,i-2) = SectionSDbis;
%         SectionVelALLbis(:,:,i-2) = SectionVelbis;
    end;

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

handles.dataTableStroke = dataTableStroke;
handles.colorrowStroke = colorrow;

if strcmpi(origin, 'table');
    set(handles.StrokeData_table_analyser, 'data', dataTableStroke, 'backgroundcolor', colorrow); %'RowName', rowNameList,
    set(handles.SkillData_table_analyser, 'Visible', 'off');
    set(handles.PacingData_table_analyser, 'Visible', 'off');
    set(handles.SummaryData_table_analyser, 'Visible', 'off');
    
    table_extent = get(handles.StrokeData_table_analyser, 'Extent');
    table_position = get(handles.StrokeData_table_analyser, 'Position');
    pos_cor = table_position;
    if table_extent(4) < table_position(4);

        if Extent == 0;
            %Add 5% to give space for the slider bar at the bottom
            offset = 18;
            pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)-offset;
            pos_cor(4) = table_extent(4)+offset;
        else;
            pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)+1;
            pos_cor(4) = table_extent(4)+1;
        end;

    elseif table_extent(4) >= table_position(4);
        if table_position(2) < (0.0069*PosFig(4));
            pos_cor(2) = (0.0069*PosFig(4))+1;
            pos_cor(4) = (handles.TopINI_StrokeTable*PosFig(4))+1;

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
            set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
        else;
            if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                pos_cor(2) = (0.0069*PosFig(4))+1;
                pos_cor(4) = (handles.TopINI_StrokeTable*PosFig(4))+1;

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
                set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                if Extent == 0;
                    %Add 5% to give space for the slider bar at the bottom
                    offset = 18;
                    pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)-offset;
                    pos_cor(4) = table_extent(4)+offset;
                else;
                    pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)+1;
                    pos_cor(4) = table_extent(4)+1;
                end;
            end;
        end;
    end;

    if Extent == 1;
        if table_extent(3) > table_position(3);
            pos_cor(3) = table_extent(3);
        end;
    end;
    set(handles.StrokeData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
    set(handles.StrokeData_table_analyser, 'Units', 'normalized');

    PosEND = get(handles.StrokeData_table_analyser, 'Position');
    PosEND = PosEND(3);
    handles.diffPosStrokeTable = PosEND - handles.PosINI_StrokeTable;
end;



