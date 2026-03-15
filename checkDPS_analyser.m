function [] = checkDPS_analyser(varargin);


handles = guidata(gcf);

NewstatusDPS = get(handles.DPS_check_analyser, 'Value');
nbRaces = length(handles.filelistAdded);
eval(['axesYLeftTitle = handles.S1.axesGraphPacingYLeftTitle;']);
eval(['YLeftTitletxt = handles.S1.axesGraphPacingYLeftTitletxt;']);

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

if NewstatusDPS == 1;
    set(axesYLeftTitle, 'Visible', 'on');
    set(YLeftTitletxt, 'Visible', 'on');

    set(handles.Edit_YLeftmin_analyser, 'String', num2str(roundn(handles.CurrentvalueYLeftmin,-2)));
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(roundn(handles.CurrentvalueYLeftmax,-2)));
else;
    set(axesYLeftTitle, 'Visible', 'off');
    set(YLeftTitletxt, 'Visible', 'off');

    set(handles.Edit_YLeftmin_analyser, 'String', '');
    set(handles.Edit_YLeftmax_analyser, 'String', '');
end;

for race = 1:nbRaces;

    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    eval(['graph1Pacing_maxYLeft = handles.S' num2str(race) '.axesGraphPacing_maxYLeft;']);
    eval(['yleftlabel = handles.S' num2str(race) '.axesGraphPacing_yleftlabel;']);
    eval(['yleftlabeltxt = handles.S' num2str(race) '.axesGraphPacing_yleftlabeltxt;']);

    yyaxis(axesGraphPacing, 'left');
    if get(handles.DPS_check_analyser, 'value') == 1;
        set(axesGraphPacing, 'ytick', yleftlabel, 'yticklabel', yleftlabeltxt, 'ycolor', [1 1 1]);
        ylim(axesGraphPacing, [handles.CurrentvalueYLeftmin handles.CurrentvalueYLeftmax]);
    else;
        set(axesGraphPacing, 'ytick', [], 'yticklabel', [], 'ycolor', [1 1 1]);
        ylim(axesGraphPacing, [0 0.5]);
    end;
end;

handles.CurrentstatusDPS = NewstatusDPS;

guidata(handles.hf_w1_welcome, handles);