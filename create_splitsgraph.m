% FigPos = handles.FigPos;
% 
% pos = [70./FigPos(3), 10./FigPos(4), 1000./FigPos(3), 600./FigPos(4)];
% handles.axesskilloverlay_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
%     'Position', pos, 'Visible', 'off');

RaceUID = [];
nbRaces = length(handles.filelistAdded);
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


origin = 'graph';
create_pacingtableINI;
dataMatCumSplitsPacing = [];
dataMatSplitsPacing = [];
for raceEC = 1:nbRaces;
    eval(['dataTableAverage = dataTableAverage_Race' num2str(raceEC) ';']);

    Source = handles.databaseCurrent_analyser{raceEC,58};

    handles.storeTitle = storeTitle;
    handles.storeTitleBis = storeTitleBis;
    handles.storeTitle2 = storeTitle2;
    keyLapDist = Course:Course:RaceDist;
    NbLap = RaceDist./Course;
    keyIntervalDist = 5:5:RaceDist;
    if Source == 1 | Source == 3;
        CumSplitsPacing = dataTableAverage(:,1);
        isNewLap = 1;
        for Miter = 1:length(CumSplitsPacing);
            if raceEC == 1;
                dataMatCumSplitsPacing(Miter, 1) = keyIntervalDist(Miter);
            end;
            if isempty(dataTableAverage(Miter,2));
                    %speed val is empty no split;
                dataMatCumSplitsPacing(Miter,raceEC+1) = NaN;
                dataMatSplitsPacing(Miter,raceEC+1) = NaN;
            else;
                dataMatCumSplitsPacing(Miter,raceEC+1) = CumSplitsPacing(Miter,1);
                if isNewLap == 1;
                    %first split of the lap
                    dataMatSplitsPacing(Miter,raceEC+1) = dataMatCumSplitsPacing(Miter,raceEC+1);
                else;
                    dataMatSplitsPacing(Miter,raceEC+1) = dataMatCumSplitsPacing(Miter,raceEC+1) - dataMatCumSplitsPacing(Miter-1,raceEC+1);
                end;
            end;
    
            index = find(keyLapDist == keyIntervalDist(Miter));
            if isempty(index) == 0;
                %end of lap
                isNewLap = 1;
            else;
                isNewLap = 0;
            end;
        end;
    elseif Source == 2;
        CumSplitsPacing = dataTableAverage(:,11);
        isNewLap = 1;
        for Miter = 1:length(CumSplitsPacing);
            if raceEC == 1;
                dataMatCumSplitsPacing(Miter, 1) = keyIntervalDist(Miter);
            end;
            if isempty(dataTableAverage{Miter,2});
                    %speed val is empty no split;
                dataMatCumSplitsPacing(Miter,raceEC+1) = NaN;
                dataMatSplitsPacing(Miter,raceEC+1) = NaN;
            else;
                dataMatCumSplitsPacing(Miter,raceEC+1) = CumSplitsPacing{Miter,1};
                if isNewLap == 1;
                    %first split of the lap
                    dataMatSplitsPacing(Miter,raceEC+1) = dataMatCumSplitsPacing(Miter,raceEC+1);
                else;
                    dataMatSplitsPacing(Miter,raceEC+1) = dataMatCumSplitsPacing(Miter,raceEC+1) - dataMatCumSplitsPacing(Miter-1,raceEC+1);
                end;
            end;
    
            index = find(keyLapDist == keyIntervalDist(Miter));
            if isempty(index) == 0;
                %end of lap
                isNewLap = 1;
            else;
                isNewLap = 0;
            end;
        end;
    end;
end;
handles.dataMatCumSplitsPacing = dataMatCumSplitsPacing;
handles.dataMatSplitsPacing = dataMatSplitsPacing;
dataMatCumSplitsPacingFullRace = dataMatCumSplitsPacing;
dataMatSplitsPacingFullRace = dataMatSplitsPacing;
handles.dataMatSplitsPacingFullRace = dataMatSplitsPacingFullRace;




handles.CurrentvalueDistSplitsPacing = 1;
handles.CurrentvalueRaceLapPacing = 1;

splitsPacingConversion;

if handles.CurrentvalueRaceLapPacing == 1;
    DistIni = DistSplits;
    DistEnd = RaceDist;
else;
    DistIni = (Course.*(handles.CurrentvalueRaceLapPacing-2)) + DistSplits;
    DistEnd = Course.*(handles.CurrentvalueRaceLapPacing-1);
end;
keyDist = DistIni:DistSplits:DistEnd;
keyDistFullRace = DistSplits:DistSplits:RaceDist;

%trim splits matices
li = [];
dataMatSplitsPacingTRIM = [];
for split = 1:length(keyDist);
    li(split) = find(dataMatCumSplitsPacing(:,1) == keyDist(split));
end;

dataMatCumSplitsPacingTRIM = dataMatCumSplitsPacing(li,:);
dataMatSplitsPacingTRIM(:,1) = dataMatCumSplitsPacingTRIM(:,1);

li = [];
dataMatSplitsPacingTRIMFullRace = [];
for split = 1:length(keyDistFullRace);
    li(split) = find(dataMatCumSplitsPacingFullRace(:,1) == keyDistFullRace(split));
end;
dataMatCumSplitsPacingTRIMFullRace = dataMatCumSplitsPacingFullRace(li,:);
dataMatSplitsPacingTRIMFullRace(:,1) = dataMatCumSplitsPacingTRIMFullRace(:,1);

if handles.CurrentvalueRaceLapPacing == 1;
    for race = 1:nbRaces;
        dataMatSplitsPacingTRIM(:,race+1) = [dataMatCumSplitsPacingTRIM(1,race+1); diff(dataMatCumSplitsPacingTRIM(:,race+1))];
    end;
    for race = 1:nbRaces;
        dataMatSplitsPacingTRIMFullRace(:,race+1) = [dataMatCumSplitsPacingTRIMFullRace(1,race+1); diff(dataMatCumSplitsPacingTRIMFullRace(:,race+1))];
    end;
else;
	lapEC = handles.CurrentvalueRaceLapPacing-1;
    for race = 1:nbRaces;
        if lapEC == 1;
            LapTime = 0;
        else;
            eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
            LapTime = SplitsAll(lapEC-1,2);
        end;
        dataMatSplitsPacingTRIM(:,race+1) = [dataMatCumSplitsPacingTRIM(1,race+1)-LapTime; diff(dataMatCumSplitsPacingTRIM(:,race+1))];
        dataMatSplitsPacingTRIMFullRace(:,race+1) = [dataMatCumSplitsPacingTRIMFullRace(1,race+1); diff(dataMatCumSplitsPacingTRIMFullRace(:,race+1))];
    end;
end;

if handles.CurrentvalueRaceLapPacing == 1;
    lapDist = Course:Course:RaceDist;
    nbLap = RaceDist./Course;
else;
    lapDist = Course:Course:DistEnd;
    nbLap = 1;
end;

if DistSplits < 25;
    linan = find(isnan(dataMatSplitsPacing(:,2)) == 1);
    keep = [];
    iter = 1;
    for i = 1:length(linan);
        if dataMatSplitsPacing(linan(i),1) >= Course;
            keep(iter) = linan(i);
            iter = iter + 1;
        end;
    end;

    for lap = 2:nbLap;
        liInf = find(dataMatSplitsPacing(:,1) == lapDist(lap-1));
        liSup = find(dataMatSplitsPacing(:,1) == lapDist(lap));
        li = find(keep >= liInf & keep <= liSup);
        
        if isempty(li) == 0;
            keepLap = keep(li(end));
            distmax = dataMatSplitsPacing(keepLap,1);
        else;
            distmax = lapDist(lap);
        end;
        
        lidistmax = find(dataMatSplitsPacingTRIM(:,1) == distmax);
        if isempty(lidistmax) == 1;
            distmax = distmax + 5;
            lidistmax = find(dataMatSplitsPacingTRIM(:,1) == distmax);
        end;
        dataMatSplitsPacingTRIM(lidistmax,2:end) = NaN;
    end;
end;

%---convert to Percentage
dataMatSplitsPacingTRIMPerc = dataMatSplitsPacingTRIM(:,1);
for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    raceTime = SplitsAll(end,2);
    
    for split = 1:length(dataMatSplitsPacingTRIM(:,1));
        splitEC = dataMatSplitsPacingTRIM(split,race+1);
        if isnan(splitEC) == 1;
            dataMatSplitsPacingTRIMPerc(split, race+1) = NaN;
        else;
            dataMatSplitsPacingTRIMPerc(split, race+1) = (splitEC./raceTime).*100;
        end;
    end;
end;
handles.dataMatSplitsPacingTRIMPerc = dataMatSplitsPacingTRIMPerc;

dataMatCumSplitsPacingTRIMPerc = dataMatCumSplitsPacingTRIM(:,1);
for race = 1:nbRaces;

    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);
    raceTime = SplitsAll(end,2);
    
    for split = 1:length(dataMatCumSplitsPacingTRIM(:,1));
        splitEC = dataMatCumSplitsPacingTRIM(split,race+1);
        if isnan(splitEC) == 1;
            dataMatCumSplitsPacingTRIMPerc(split, race+1) = NaN;
        else;
            dataMatCumSplitsPacingTRIMPerc(split, race+1) = (splitEC./raceTime).*100;
        end;
    end;
end;
handles.dataMatCumSplitsPacingTRIMPerc = dataMatCumSplitsPacingTRIMPerc;

dataMatSplitsPacingTRIMFullRacePerc = dataMatSplitsPacingTRIMFullRace(:,1);
for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);
    raceTime = SplitsAll(end,2);
    
    for split = 1:length(dataMatSplitsPacingTRIMFullRace(:,1));
        splitEC = dataMatSplitsPacingTRIMFullRace(split,race+1);
        if isnan(splitEC) == 1;
            dataMatSplitsPacingTRIMFullRacePerc(split, race+1) = NaN;
        else;
            dataMatSplitsPacingTRIMFullRacePerc(split, race+1) = (splitEC./raceTime).*100;
        end;
    end;
end;

handles.dataMatSplitsPacingTRIMFullRace = dataMatSplitsPacingTRIMFullRace;
handles.dataMatSplitsPacingTRIMFullRacePerc = dataMatSplitsPacingTRIMFullRacePerc;


if handles.CurrentvalueSplits1D == 1;
    create_splitsgraph1D;
end;

if handles.CurrentvalueSplits2D == 1;
    create_splitsgraph2D;
end;

if handles.CurrentvalueSplits3D == 1;
    create_splitsgraph3D;
end;

listLapRace = [];
for lap = 1:NbLap+1;
    if lap == 1;
        listLapRace{lap} = 'Race';
    else;
        listLapRace{lap} = ['Lap ' num2str(lap-1)];
    end;
end;

if handles.CurrentvalueSplits1D == 1;
    handles.listLapRace = listLapRace;
    set(handles.popupRaceLap_analyser, 'String', listLapRace, 'Value', handles.CurrentvalueRaceLapPacing);
end;
if handles.CurrentvalueSplits1D == 2;
    handles.listLapRace = listLapRace;
    set(handles.popupRaceLap_analyser, 'String', listLapRace, 'Value', handles.CurrentvalueRaceLapPacing);
end;
if handles.CurrentvalueSplits3D == 1;
    handles.listLapRace = {'Race'; 'Lap'};
    set(handles.popupRaceLap_analyser, 'String', listLapRace, 'Value', handles.CurrentvalueRaceLapPacing);
end;

if handles.CurrentvalueRaceLapPacing == 1;
    if Course == 50;
        if RaceDist == 50;
            listDistSplits = {'5'; '10'; '25'};
        elseif RaceDist == 100;
            listDistSplits = {'5'; '10'; '25'; '50'};
        elseif RaceDist == 150;
            listDistSplits = {'10'; '25'; '50'};
        elseif RaceDist == 200
            listDistSplits = {'10'; '25'; '50'; '100'};
        elseif RaceDist == 400;
            listDistSplits = {'25'; '50'; '100'; '200'};
        elseif RaceDist == 800;
            listDistSplits = {'25'; '50'; '100'; '200'; '400'};
        elseif RaceDist == 1500
            listDistSplits = {'50'; '100'; '200'; '500'};
        end;
    else;
        if RaceDist == 50;
            listDistSplits = {'5'; '25'};
        elseif RaceDist == 100;
            listDistSplits = {'5'; '25'; '50'};
        elseif RaceDist == 150;
            listDistSplits = {'25'; '50'};
        elseif RaceDist == 200;
            listDistSplits = {'25'; '50'; '100'};
        elseif RaceDist == 400;
            listDistSplits = {'25'; '50'; '100'; '200'};
        elseif RaceDist == 800;
            listDistSplits = {'25'; '50'; '100'; '200'; '400'};
        elseif RaceDist == 1500
            listDistSplits = {'50'; '100'; '200'; '500'};
        end;
    end;
else;
    if Course == 25;
        listDistSplits = {'5'};
    else;
        listDistSplits = {'5'; '10'; '25'};
    end;
end;
set(handles.popupDistrance_analyser, 'String', listDistSplits, 'Value', handles.CurrentvalueDistSplitsPacing);

guidata(handles.hf_w1_welcome, handles);




% gtitleskill = title(axesEC, 'Overlayed Comparison', 'color', [1 1 1], 'Visible', 'on', 'FontName', 'Antiqua', ...
%     'FontSize', fontsizetitle, 'FontWeight', 'Bold');
% legGraph = legend(axesEC, storeTitle3, 'FontName', 'Antiqua', ...
%     'FontAngle', 'italic', 'FontSize', 8, 'TextColor', [1 1 1]);
% set(legGraph, 'units', 'normalized');
% set(legGraph, 'position', [0.58 0.78 0.15 0.05]);   
% handles.legGraphskill = legGraph;