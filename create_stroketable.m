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

formatlist{1} = 'char';
formatlist{2} = 'char';
edittablelist(1) = false;
edittablelist(2) = false;
for i = 1:nbRaces;
    formatlist{i+2} = 'numeric';
    edittablelist(i+2) = false;
end;

if strcmpi(origin, 'table') == 1;
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
end;
% set(handles.StrokeData_table_analyser, 'Units', 'normalized');

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
    eval(['dataTableStroke{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableStroke{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
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


    %---------------------------------Stroke-------------------------------
    try;
        eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    catch;
        eval(['NbLap = handles.RacesDB.' UID '.nbLap;']);
    end;
    eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['SDEC = handles.RacesDB.' UID '.Stroke_DistanceINI;']);
    if i == 3;
        if Course == 25;
            colorrow(9,:) = [1 0.9 0.70];
            lineEC = 10;
            for lap = 1:NbLap;
                dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];
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
            end;
            
        else;
            colorrow(9,:) = [1 0.9 0.70];
            lineEC = 10;
            for lap = 1:NbLap;
                dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];
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
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['StrokeEC = handles.RacesDB.' UID '.RawStroke;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);

    if strcmpi(StrokeType, 'Medley');
        if Course == 25;
            if RaceDist == 100;
                lapBFBR = [1 3];
            elseif RaceDist == 150;
                lapBFBR = [3 4];
            elseif RaceDist == 200;
                lapBFBR = [1 2 5 6];
            elseif RaceDist == 400;
                lapBFBR = [1 2 3 4 9 10 11 12];
            end;
        else;
            if RaceDist == 150;
                lapBFBR = 2;
            elseif RaceDist == 200;
                lapBFBR = [1 3];
            elseif RaceDist == 400;
                lapBFBR = [1 2 5 6];
            end;
        end;
    end;
    
    for lap = 1:NbLap;
        if Source == 1 | Source == 3;
            liSplitEnd = SplitsAll(lap,3) + 1;
        elseif Source == 2;
            liSplitEnd = SplitsAll(lap,3);
        end;
        liStrokeLap = Stroke_Frame(lap,:);
        liInterest = find(liStrokeLap ~= 0);
        liStrokeLap = liStrokeLap(liInterest);
        
        if strcmpi(StrokeType, 'Medley');
            lilap = find(lapBFBR == lap);
        end;
        
        keydist = (lap-1).*Course;
        DistIni = keydist;
        if Course == 25;
            nbzone = 5;
        else;
            nbzone = 10;
        end;
        
        for zone = 1:nbzone;
            DistEnd = DistIni + 5;

            if Source == 1 | Source == 3;
                diffIni = abs(DistanceEC - DistIni);
                [~, liIni] = min(diffIni);
            elseif Source == 2;
                liIni = find(DistanceEC > DistIni, 1);
            end;
            if zone == nbzone;

                if liSplitEnd > length(DistanceEC);
                    linan = find(isnan(DistanceEC(liIni:end)) == 0);
                else;
                    linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                end;
                linan = linan + liIni - 1;
                liEnd = linan(end);
            else;
                if Source == 1 | Source == 3;
                    diffEnd = abs(DistanceEC - DistEnd);
                    [~, liEnd] = min(diffEnd);
                elseif Source == 2;
                    liEnd = find(DistanceEC > DistEnd, 1);
                end;
            end;

            if BOAll(lap,1) > liEnd;
                SectionSR(lap,zone) = NaN;
                SectionSD(lap,zone) = NaN;
                SectionVel(lap,zone) = NaN;
                SectionSplitTime(lap,zone) = NaN;
                SectionCumTime(lap,zone) = NaN;
            else;
                if BOAll(lap,1) > liIni;
                    liIni = BOAll(lap,1) + 1;
                end;
                SectionVel(lap,zone) = mean(VelocityEC(liIni:liEnd));
                SectionSplitTime(lap,zone) = TimeEC(liEnd)- TimeEC(liIni);
                SectionCumTime(lap,zone) = TimeEC(liEnd);
                
                liStrokeSec = find(StrokeEC(liIni:liEnd) == 1);
                if isempty(liStrokeSec) == 0;
                    
                    if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
                        if length(liStrokeSec) < 1;
                            SectionSR(lap,zone) = NaN;
                            SectionSD(lap,zone) = NaN;
                            SectionNb(lap,zone) = NaN;
                            
                        elseif length(liStrokeSec) >= 1 & length(liStrokeSec) < 2;
                            liStrokeSec = liStrokeSec + liIni - 1;
                            IDstroke = [];
                            for stro = 1:length(liStrokeSec);
                                IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                            end;
                            if isempty(IDstroke) == 1;
                                %Correct -1 frame error
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro)-1)];
                                end;
                            end;

                            if zone == 1;
                                IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                            elseif zone == 10;
                                IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                            else;
                                IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                            end;
                            li = find(IDstroke > 1);
                            IDstroke = IDstroke(li);
                            SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                            SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                            SectionNb(lap,zone) = 1;
                        else;
                            liStrokeSec = liStrokeSec + liIni - 1;
                            IDstroke = [];
                            for stro = 1:length(liStrokeSec);
                                IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                            end;
                            if isempty(IDstroke) == 1;
                                %Correct -1 frame error
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro)-1)];
                                end;
                            end;

                            if IDstroke(1) == 1;
                                IDstroke = IDstroke(2:end);
                            end;
                            SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                            SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                            SectionNb(lap,zone) = length(liStrokeSec);
                        end;
                        
                    elseif strcmpi(StrokeType, 'Medley');
                        if isempty(lilap) == 1;
                            %BK and FS
                            if length(liStrokeSec) > 2;
                                liStrokeSec = liStrokeSec + liIni - 1;
                                IDstroke = [];
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                                end;
                                if isempty(IDstroke) == 1;
                                    %Correct -1 frame error
                                    for stro = 1:length(liStrokeSec);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro)-1)];
                                    end;
                                end;

                                if IDstroke(1) == 1;
                                    IDstroke = IDstroke(2:end);
                                end;
                                SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                                SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                                SectionNb(lap,zone) = length(liStrokeSec);
                            else;
                                SectionSR(lap,zone) = NaN;
                                SectionSD(lap,zone) = NaN;
                                SectionNb(lap,zone) = NaN;
                            end;
                        else;
                            %BF and BR
                            if length(liStrokeSec) < 1;
                                SectionSR(lap,zone) = NaN;
                                SectionSD(lap,zone) = NaN;
                                SectionNb(lap,zone) = NaN;

                            elseif length(liStrokeSec) >= 1 & length(liStrokeSec) < 2;
                                liStrokeSec = liStrokeSec + liIni - 1;
                                IDstroke = [];
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                                end;
                                if isempty(IDstroke) == 1;
                                    %Correct -1 frame error
                                    for stro = 1:length(liStrokeSec);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro)-1)];
                                    end;
                                end;

                                if zone == 1;
                                    IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                elseif zone == 10;
                                    IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                else;
                                    IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                end;
                                li = find(IDstroke > 1);
                                IDstroke = IDstroke(li);
                                SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                                SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                                SectionNb(lap,zone) = 1;
                            else;
                                liStrokeSec = liStrokeSec + liIni - 1;
                                IDstroke = [];
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                                end;
                                if isempty(IDstroke) == 1;
                                    %Correct -1 frame error
                                    for stro = 1:length(liStrokeSec);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro)-1)];
                                    end;
                                end;

                                if IDstroke(1) == 1;
                                    IDstroke = IDstroke(2:end);
                                end;
                                SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                                SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                                SectionNb(lap,zone) = length(liStrokeSec);
                            end;
                        end;
                        
                    else;
                        if length(liStrokeSec) > 2;
                            liStrokeSec = liStrokeSec + liIni - 1;
                            IDstroke = [];
                            for stro = 1:length(liStrokeSec);
                                IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                            end;
                            if isempty(IDstroke) == 1;
                                %Correct -1 frame error
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro)-1)];
                                end;
                            end;
                            
                            if IDstroke(1) == 1;
                                IDstroke = IDstroke(2:end);
                            end;
                            SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                            SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                            SectionNb(lap,zone) = length(liStrokeSec);
                        else;
                            SectionSR(lap,zone) = NaN;
                            SectionSD(lap,zone) = NaN;
                            SectionNb(lap,zone) = NaN;
                        end;
                    end;
                else;
                    SectionSR(lap,zone) = NaN;
                    SectionSD(lap,zone) = NaN;
                    SectionNb(lap,zone) = NaN;
                end;                                
            end;     
            DistIni = DistEnd;
        end;
        
        liSplitIni = SplitsAll(lap,3) + 1;
    end;
    
    SectionSRALL(:,:,i-2) = SectionSR;
    SectionSDALL(:,:,i-2) = SectionSD;
    SectionVelALL(:,:,i-2) = SectionVel;
    
    lineEC = 11;
    for lap = 1:NbLap;
        if isnan(SectionSR(lap,1)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,1),1);
            SDtxt = dataToStr(SectionSD(lap,1),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,1)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,2)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,2),1);
            SDtxt = dataToStr(SectionSD(lap,2),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,2)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+1) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,3)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,3),1);
            SDtxt = dataToStr(SectionSD(lap,3),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,3)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+2) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,4)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,4),1);
            SDtxt = dataToStr(SectionSD(lap,4),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,4)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+3) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,5)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,5),1);
            SDtxt = dataToStr(SectionSD(lap,5),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,5)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+4) ',' num2str(i) '} = data;']);
        
        if Course == 50;
            if isnan(SectionSR(lap,6)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,6),1);
                SDtxt = dataToStr(SectionSD(lap,6),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,6)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+5) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,7)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,7),1);
                SDtxt = dataToStr(SectionSD(lap,7),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,7)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+6) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,8)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,8),1);
                SDtxt = dataToStr(SectionSD(lap,8),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,8)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+7) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,9)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,9),1);
                SDtxt = dataToStr(SectionSD(lap,9),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,9)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+8) ',' num2str(i) '} = data;']);

            if Source == 1 | Source == 3;
                data = ['  -  /  -  /  -  '];
            elseif Source == 2;
                if isnan(SectionSR(lap,10)) == 1;
                    data = ['  -  /  -  /  -  '];
                else;
                    SRtxt = dataToStr(SectionSR(lap,10),1);
                    SDtxt = dataToStr(SectionSD(lap,10),2);
                    data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,10)) ' str'];
                end;
            end;
            eval(['dataTableStroke{' num2str(lineEC+9) ',' num2str(i) '} = data;']);
        end;
        
        if Course == 50;
            lineEC = lineEC + 11;
        else;
            lineEC = lineEC + 6;
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



