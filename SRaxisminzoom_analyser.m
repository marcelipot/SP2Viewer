function [] = SRaxisminzoom_analyser(varargin);


handles = guidata(gcf);

valYRightmin = get(handles.Edit_YRightmin_analyser, 'String');

if handles.CurrentstatusSR == 0;
    errordlg('Option not available. SR not displayed', 'Error');
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYLRightmin));
    return;
end;

li = findstr(valYRightmin, ',');
if isempty(li) == 0;
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

li = findstr(valYRightmin, ';');
if isempty(li) == 0;
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

li = findstr(valYRightmin, ' ');
if isempty(li) == 0;
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

numyrightmin = str2num(valYRightmin);

if isempty(numyrightmin) == 1;
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

eval(['graph1Pacing_maxYRight = handles.S1.axesGraphPacing_maxYRight;']);
if numyrightmin > roundn(graph1Pacing_maxYRight,-2);
    errordlg(['Enter a value < ' num2str(roundn(graph1Pacing_maxYRight,-2))], 'Error');
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

if numyrightmin < 0;
    errordlg('Enter a value >= 0', 'Error');
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

if numyrightmin >= handles.CurrentvalueYRightmax;
    errordlg(['Enter a value < ' num2str(handles.CurrentvalueYRightmax)], 'Error');
    set(handles.Edit_YRightmin_analyser, 'String', num2str(handles.CurrentvalueYRightmin));
    return;
end;

numYrightmin = roundn(numyrightmin,-2);

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

    eval(['LimGraphStroke = handles.RacesDB.' UID '.LimGraphStroke;']);
    eval(['LimGraphBreath = handles.RacesDB.' UID '.LimGraphBreath;']);
    eval(['maxSR = handles.RacesDB.' UID '.graph1Pacing_maxYRight;']);
    eval(['minSR = handles.RacesDB.' UID '.graph1Pacing_minYRight;']);
    eval(['GraphDistance = handles.RacesDB.' UID '.graph1PacingGraphDistance;']);
    
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    yyaxis(axesGraphPacing, 'right');
    ylim(axesGraphPacing, [numyrightmin handles.CurrentvalueYRightmax]);
   
    if handles.CurrentstatusBreath == 1;
        set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'YData', [numyrightmin numyrightmin+((handles.CurrentvalueYRightmax-numyrightmin).*0.15)]);
    end;

    eval(['Splittext = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    if handles.CurrentstatusSR == 1;
        for lap = 1:NbLap;
            posSplits = get(Splittext(lap), 'position');
            posSplits(2) = ((handles.CurrentvalueYRightmax-numyrightmin)./2)+numyrightmin;
            set(Splittext(lap), 'Position', posSplits);
        end;
    end;
end;
handles.CurrentvalueYRightmin = numyrightmin;

guidata(handles.hf_w1_welcome, handles);
