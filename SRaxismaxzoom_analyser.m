function [] = SRaxismaxzoom_analyser(varargin);


handles = guidata(gcf);

valYRightmax = get(handles.Edit_YRightmax_analyser, 'String');

if handles.CurrentstatusSR == 0;
    errordlg('Option not available. SR not displayed', 'Error');
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYLRightmax));
    return;
end;

li = findstr(valYRightmax, ',');
if isempty(li) == 0;
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

li = findstr(valYRightmax, ';');
if isempty(li) == 0;
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

li = findstr(valYRightmax, ' ');
if isempty(li) == 0;
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

numyrightmax = str2num(valYRightmax);

if isempty(numyrightmax) == 1;
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

eval(['graph1Pacing_maxYRight = handles.S1.axesGraphPacing_maxYRight;']);
if numyrightmax > roundn(graph1Pacing_maxYRight,-2);
    errordlg(['Enter a value <= ' num2str(roundn(graph1Pacing_maxYRight,-2))], 'Error');
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

if numyrightmax < 0;
    errordlg('Enter a value > 0', 'Error');
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

if numyrightmax <= handles.CurrentvalueYRightmin;
    errordlg(['Enter a value > ' num2str(handles.CurrentvalueYRightmin)], 'Error');
    set(handles.Edit_YRightmax_analyser, 'String', num2str(handles.CurrentvalueYRightmax));
    return;
end;

numYrightmax = roundn(numyrightmax,-2);

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
    
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    
    eval(['GraphDistance = handles.RacesDB.' UID '.graph1PacingGraphDistance;']);
    eval(['LimGraphStroke = handles.RacesDB.' UID '.LimGraphStroke;']);
    eval(['LimGraphBreath = handles.RacesDB.' UID '.LimGraphBreath;']);
    
    yyaxis(axesGraphPacing, 'right');
    ylim(axesGraphPacing, [handles.CurrentvalueYRightmin numyrightmax]);

    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Splittext = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    if handles.CurrentstatusSR == 1;
        for lap = 1:NbLap;
            posSplits = get(Splittext(lap), 'position');
            posSplits(2) = ((numyrightmax-handles.CurrentvalueYRightmin)./2)+handles.CurrentvalueYRightmin;
            set(Splittext(lap), 'Position', posSplits);
        end;
    end;
    set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'YData', [handles.CurrentvalueYRightmin handles.CurrentvalueYRightmin+((numyrightmax-handles.CurrentvalueYRightmin).*0.15)]);
end;
handles.CurrentvalueYRightmax = numyrightmax;

guidata(handles.hf_w1_welcome, handles);
