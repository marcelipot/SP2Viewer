function [] = checkBreath_analyser(varargin);


handles = guidata(gcf);

NewstatusBreath = get(handles.Breath_check_analyser, 'Value');
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

for race = 1:nbRaces;
    
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    eval(['GraphDistance = handles.RacesDB.' UID '.graph1PacingGraphDistance;']);
    eval(['LimGraphStroke = handles.RacesDB.' UID '.LimGraphStroke;']);
    eval(['LimGraphBreath = handles.RacesDB.' UID '.LimGraphBreath;']);
    eval(['maxSR = handles.RacesDB.' UID '.graph1Pacing_maxYRight;']);
    eval(['minSR = handles.RacesDB.' UID '.graph1Pacing_minYRight;']);

    if isempty(LimGraphBreath) == 0;
        if NewstatusBreath == 1;
            set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'YData', [handles.CurrentvalueYRightmin handles.CurrentvalueYRightmin+((handles.CurrentvalueYRightmax-handles.CurrentvalueYRightmin).*0.15)]);
            set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'Visible', 'on');
        else;
            set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'YData', [handles.CurrentvalueYRightmin handles.CurrentvalueYRightmin+((handles.CurrentvalueYRightmax-handles.CurrentvalueYRightmin).*0.15)]);
            set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'Visible', 'off');
        end;
    end;
end;
handles.CurrentstatusBreath = NewstatusBreath;

guidata(handles.hf_w1_welcome, handles);