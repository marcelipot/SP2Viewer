function [] = xaxisminzoom_analyser(varargin);


handles = guidata(gcf);

valXmin = get(handles.Edit_Xmin_analyser, 'String');

if handles.CurrentstatusTime == 1;
    errordlg('Option not available. Switch to Distance', 'Error');
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
    return;
end;

li = findstr(valXmin, ',');
if isempty(li) == 0;
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
    return;
end;

li = findstr(valXmin, ';');
if isempty(li) == 0;
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
    return;
end;

li = findstr(valXmin, ' ');
if isempty(li) == 0;
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
    return;
end;

numXmin = str2num(valXmin);

if isempty(numXmin) == 1;
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
    return;
end;

if numXmin < 0;
    errordlg('Enter a value >= 0', 'Error');
    set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
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

race = 1;
UID = RaceUID{race};
li = findstr(UID, '-');
UID(li) = '_';
UID = ['A' UID 'A'];
eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);

if handles.CurrentstatusDistance == 1;
    if numXmin > SplitsAll(end,1);
        errordlg(['Enter a value < ' num2str(SplitsAll(end,1))], 'Error');
        set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
        return;
    end;
end;

if handles.CurrentstatusDistance == 1;
    if numXmin >= handles.CurrentvalueXmax;
        errordlg(['Enter a value < ' num2str(handles.CurrentvalueXmax)], 'Error');
        set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
        return;
    end;
end;

for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['xtickDistanceConvert = handles.S' num2str(race) '.axesGraphPacing_xtickDistanceConvert;']);
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    
    liini = 1;
    Distance(1,1) = 0;
    for lap = 1:NbLap;
        Distance(1,SplitsAll(lap+1,3)) = lap*Course;
        liend = SplitsAll(lap+1,3);
        
        DistanceINT = Distance(liini:liend);
        DistanceINT = naninterp(DistanceINT, 'spline');
        Distance(liini:liend) = DistanceINT;

        liini = liend;
    end;

    [~,minloc] = min(abs(Distance-numXmin));
    ConvDistMin = minloc(1);
    if numXmin == 0;
        ConvDistMin = 0;
    end;
    [~,minloc] = min(abs(Distance-handles.CurrentvalueXmax));
    ConvDistMax = minloc(1);
    if handles.CurrentvalueXmax == RaceDist;
        ConvDistMax = xtickDistanceConvert(end);
    end;
    
    if ConvDistMin >= ConvDistMax;
        errordlg('X-Axis Inferior limit > X-Axis Superior limit', 'Error');
        set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
        return;
    end;
    xlim(axesGraphPacing, [ConvDistMin ConvDistMax]);
end;
handles.CurrentvalueXmin = numXmin;

guidata(handles.hf_w1_welcome, handles);
