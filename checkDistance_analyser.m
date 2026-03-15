function [] = checkDistance_analyser(varargin);


handles = guidata(gcf);

if handles.CurrentstatusDistance == 1;
    set(handles.Distance_check_analyser, 'Value', 1);
    return;
end;

NewstatusDistance = get(handles.Distance_check_analyser, 'Value');
eval(['XTitle = handles.S1.axesGraphPacingXTitletxt;']);

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

nbRaces = length(handles.filelistAdded);
for race = 1:nbRaces;

    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['xtickDistanceConvert = handles.S' num2str(race) '.axesGraphPacing_xtickDistanceConvert;']);
    eval(['xticklabelDistance = handles.S' num2str(race) '.axesGraphPacing_xticklabelDistance;']);
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    
    if NewstatusDistance == 1;
        set(handles.Time_check_analyser, 'Value', 0);
        handles.CurrentstatusDistance = 1;
        handles.CurrentstatusTime = 0;
        
        set(axesGraphPacing, 'xtick', xtickDistanceConvert, 'xticklabel', xticklabelDistance, 'xcolor', [1 1 1], 'visible', 'on');
        
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

        [~,minloc] = min(abs(Distance-handles.CurrentvalueXmin));
        ConvDistMin = minloc(1);
        if handles.CurrentvalueXmin == 0;
            ConvDistMin = 0;
        end;
        [~,minloc] = min(abs(Distance-handles.CurrentvalueXmax));
        ConvDistMax = minloc(1);
        if handles.CurrentvalueXmax == RaceDist;
            ConvDistMax = xtickDistanceConvert(end);
        end;

        xlim(axesGraphPacing, [ConvDistMin ConvDistMax]);
    end;
end;
set(XTitle, 'String', 'Distance (m)');
set(handles.Edit_Xmin_analyser, 'String', num2str(handles.CurrentvalueXmin));
set(handles.Edit_Xmax_analyser, 'String', num2str(handles.CurrentvalueXmax));

guidata(handles.hf_w1_welcome, handles);
