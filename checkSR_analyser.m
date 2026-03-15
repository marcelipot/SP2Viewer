function [] = checkSR_analyser(varargin);


handles = guidata(gcf);

NewstatusSR = get(handles.SR_check_analyser, 'Value');
nbRaces = length(handles.filelistAdded);
eval(['axesYRightTitle = handles.S1.axesGraphPacingYRightTitle;']);
eval(['YRightTitletxt = handles.S1.axesGraphPacingYRightTitletxt;']);

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

if NewstatusSR == 1;
    set(axesYRightTitle, 'Visible', 'on');
    set(YRightTitletxt, 'Visible', 'on');

    set(handles.Edit_YRightmin_analyser, 'String', num2str(roundn(handles.CurrentvalueYRightmin,-1)));
    set(handles.Edit_YRightmax_analyser, 'String', num2str(roundn(handles.CurrentvalueYRightmax,-1)));
else;
    set(axesYRightTitle, 'Visible', 'off');
    set(YRightTitletxt, 'Visible', 'off');

    set(handles.Edit_YRightmin_analyser, 'String', '');
    set(handles.Edit_YRightmax_analyser, 'String', '');
end;

for race = 1:nbRaces;

    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['GraphDistance = handles.RacesDB.' UID '.graph1PacingGraphDistance;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['LimGraphStroke = handles.RacesDB.' UID '.LimGraphStroke;']);
    eval(['LimGraphBreath = handles.RacesDB.' UID '.LimGraphBreath;']);
    eval(['maxSR = handles.RacesDB.' UID '.graph1Pacing_maxYRight;']);
    eval(['minSR = handles.RacesDB.' UID '.graph1Pacing_minYRight;']);
    
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    eval(['yrightlabel = handles.S' num2str(race) '.axesGraphPacing_yrightlabel;']);
    eval(['yrightlabeltxt = handles.S' num2str(race) '.axesGraphPacing_yrightlabeltxt;']);
    eval(['Splittext = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1;']);

    yyaxis(axesGraphPacing, 'right');
    if NewstatusSR == 1;
        set(GraphDistance(1:LimGraphStroke), 'Visible', 'on');
        set(axesGraphPacing, 'ytick', yrightlabel, 'yticklabel', yrightlabeltxt, 'ycolor', [1 1 1]);
        ylim(axesGraphPacing, [handles.CurrentvalueYRightmin handles.CurrentvalueYRightmax]);

        for lap = 1:NbLap;
            posSplits = get(Splittext(lap), 'position');
            posSplits(2) = ((handles.CurrentvalueYRightmax-handles.CurrentvalueYRightmin)./2)+handles.CurrentvalueYRightmin;
            set(Splittext(lap), 'Position', posSplits);
        end;
        set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'YData', [handles.CurrentvalueYRightmin handles.CurrentvalueYRightmin+((handles.CurrentvalueYRightmax-handles.CurrentvalueYRightmin).*0.15)]);
        
    else;
        set(GraphDistance(1:LimGraphStroke), 'Visible', 'off');
        set(axesGraphPacing, 'ytick', [], 'yticklabel', [], 'ycolor', [1 1 1]);
        ylim(axesGraphPacing, [0 handles.CurrentvalueYRightmaxSave]);
        
        for lap = 1:NbLap;
            posSplits = get(Splittext(lap), 'position');
            posSplits(2) = handles.CurrentvalueYRightmaxSave./2;
            set(Splittext(lap), 'Position', posSplits);
        end;
        set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'YData', [0 ((handles.CurrentvalueYRightmax-0).*0.15)]);
    end;
    
end;

handles.CurrentstatusSR = NewstatusSR;

guidata(handles.hf_w1_welcome, handles);