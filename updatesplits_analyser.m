function [] = updatesplits_analyser(varargin);


handles = guidata(gcf);

StatusEC = get(handles.AminationStatus_analyser, 'String');
if strcmpi(StatusEC, 'Play');
    set(handles.AminationStatus_analyser, 'String', 'UpdateAnimation');
    return;
end;

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

origin = 'splitsUpdate';
delete_allaxes_analyser;
% drawnow;
handles.CurrentvalueRaceLapPacing = get(handles.popupRaceLap_analyser, 'value');
handles.CurrentvalueDistSplitsPacing = get(handles.popupDistrance_analyser, 'value');
handles.CurrentSplitsTimePacing = get(handles.splitsTime_check_analyser, 'Value');
handles.CurrentSplitsPercentagePacing = get(handles.splitsPercentage_check_analyser, 'Value');
handles.CurrentSplitsOffPacing = get(handles.splitsOff_check_analyser, 'Value');
handles.CurrentvalueSplitsPacing = get(handles.showsplits_check_analyser, 'Value');

dataMatCumSplitsPacing = handles.dataMatCumSplitsPacing;
dataMatSplitsPacing = handles.dataMatSplitsPacing;
dataMatCumSplitsPacingFullRace = handles.dataMatCumSplitsPacing;
dataMatSplitsPacingFullRace = handles.dataMatSplitsPacing;

RaceDist = str2num(handles.RaceDistList{1});
nbRaces = length(handles.filelistAdded);
Course = handles.CourseList{1};
NbLap = RaceDist./Course;

handles.CurrentvalueRaceLapPacing = get(handles.popupRaceLap_analyser, 'value');
handles.CurrentvalueDistSplitsPacing = get(handles.popupDistrance_analyser, 'value');


Course = str2num(Course);
if isempty(handles.CurrentvalueDistSplitsPacing) == 1;
    if Course == 25;
        if RaceDist == 50;
            handles.CurrentvalueDistSplitsPacing = 1; %5m
            DistSplits = 5;
        elseif RaceDist == 100;
            handles.CurrentvalueDistSplitsPacing = 1; %5m
            DistSplits = 5;
        elseif RaceDist == 150;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 25;
        elseif RaceDist == 200;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 25;
        elseif RaceDist == 400;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 25;
        elseif RaceDist == 800;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 25;
        elseif RaceDist == 1500;
            handles.CurrentvalueDistSplitsPacing = 1; %50m
            DistSplits = 50;   
        end;
    else;
        if RaceDist == 50;
            handles.CurrentvalueDistSplitsPacing = 1; %5m
            DistSplits = 5;
        elseif RaceDist == 100;
            handles.CurrentvalueDistSplitsPacing = 1; %5m
            DistSplits = 5;
        elseif RaceDist == 150;
            handles.CurrentvalueDistSplitsPacing = 1; %10m
            DistSplits = 10;
        elseif RaceDist == 200;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 10;
        elseif RaceDist == 400;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 25;
        elseif RaceDist == 800;
            handles.CurrentvalueDistSplitsPacing = 1; %25m
            DistSplits = 25;
        elseif RaceDist == 1500;
            handles.CurrentvalueDistSplitsPacing = 1; %50m
            DistSplits = 50;   
        end;
    end;
else;
    if handles.CurrentvalueRaceLapPacing == 1;
        %full race
        if RaceDist == 50;
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 5;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 25;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 5;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 10;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 25;
                end;
            end;
        elseif RaceDist == 100;
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 5;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 50;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 5;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 10;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 50;
                end;
            end;
        elseif RaceDist == 150;
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 10;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 50;
                end;
            end;
        elseif RaceDist == 200;
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 10;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 100;
                end;
            end;
        elseif RaceDist == 400;
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                end;
            end;
        elseif RaceDist == 800
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 5;
                    DistSplits = 400;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 25;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 5;
                    DistSplits = 400;
                end;
            end;
        elseif RaceDist == 1500;
            if Course == 25;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 500;
                end;
            else;
                if handles.CurrentvalueDistSplitsPacing == 1;
                    DistSplits = 50;
                elseif handles.CurrentvalueDistSplitsPacing == 2;
                    DistSplits = 100;
                elseif handles.CurrentvalueDistSplitsPacing == 3;
                    DistSplits = 200;
                elseif handles.CurrentvalueDistSplitsPacing == 4;
                    DistSplits = 500;
                end;
            end;
        end;
    else;
        %Lap
        if Course == 25;
            if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 5;
            end;
        else;
            if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 5;
            elseif handles.CurrentvalueDistSplitsPacing == 2;
                DistSplits = 10;
            elseif handles.CurrentvalueDistSplitsPacing == 3;
                DistSplits = 25;
            end;
        end;
    end;
end;

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
        if dataMatSplitsPacing(linan(i),1) >= 50;
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
    eval(['Source = handles.RacesDB.' UID '.Source;']);
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
    eval(['Source = handles.RacesDB.' UID '.Source;']);
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
    listLapRace = [];

    for lap = 1:floor(RaceDist./Course)+1;
        if lap == 1;
            listLapRace{lap} = 'Race';
        else;
            listLapRace{lap} = ['Lap ' num2str(lap-1)];
        end;
    end;
end;

if handles.CurrentvalueSplits2D == 1;
    create_splitsgraph2D;
    listLapRace = [];

    for lap = 1:floor(RaceDist./Course)+1;
        if lap == 1;
            listLapRace{lap} = 'Race';
        else;
            listLapRace{lap} = ['Lap ' num2str(lap-1)];
        end;
    end;
end;

if handles.CurrentvalueSplits3D == 1;
    create_splitsgraph3D;
    listLapRace = {'Race'; 'Lap'};
end;

set(handles.popupRaceLap_analyser, 'String', listLapRace, 'Value', handles.CurrentvalueRaceLapPacing);

guidata(handles.hf_w1_welcome, handles);
