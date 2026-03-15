function [] = checkSmooth_analyser(varargin);


handles = guidata(gcf);

NewstatusSmooth = get(handles.Smooth_check_analyser, 'Value');
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

    eval(['axesGraphPacing = handles.RacesDB.' UID '.graph1PacingAxes;']);
    eval(['GraphDistance = handles.RacesDB.' UID '.graph1PacingGraphDistance;']);
    eval(['LimGraphStroke = handles.RacesDB.' UID '.LimGraphStroke;']);
    eval(['LimGraphBreath = handles.RacesDB.' UID '.LimGraphBreath;']);
    
    axeschildren = allchild(axesGraphPacing);
    if NewstatusSmooth == 0;
        if rem(length(axeschildren), 2) == 1;
            set(axeschildren(1:2:end), 'visible', 'on');
            set(axeschildren(2:2:end), 'visible', 'off');
        else;
            set(axeschildren(1:2:end), 'visible', 'off');
            set(axeschildren(2:2:end), 'visible', 'on');
        end;
    else;
        if rem(length(axeschildren), 2) == 1;
            set(axeschildren(1:2:end), 'visible', 'off');
            set(axeschildren(2:2:end), 'visible', 'on');
        else;
            set(axeschildren(1:2:end), 'visible', 'on');
            set(axeschildren(2:2:end), 'visible', 'off');
        end;
    end;
    
    set(GraphDistance, 'Visible', 'off');
    if handles.CurrentstatusSR == 1;
        set(GraphDistance(1:LimGraphStroke), 'Visible', 'on');
    else;
        set(GraphDistance(1:LimGraphStroke), 'Visible', 'off');
    end;
    
    if handles.CurrentstatusBreath == 1;
        if isempty(LimGraphBreath) == 0;
            set(GraphDistance(LimGraphStroke+1:LimGraphBreath), 'Visible', 'on');
        end;
    end;    
    
%     for lap = 2:NbLap+1;
%         hold on;
%         li = SplitsAll(lap,3);
%         splits = timeSecToStr(roundn(SplitsAll(lap,2),-2));
%         if lap ~= 2;
%             splitslap = SplitsAll(lap,2) - SplitsAll(lap-1,2);
%             splitslapTXT = timeSecToStr(roundn(splitslap,-2));
%             if nbRaces <= 5
%                 txtsplit = [splitslapTXT '  /  ' splits];
%             else;
%                 txtsplit = {splitslapTXT; splits};
%             end;
%             graph1_textPos1(lap-1) = text(li, refmax, txtsplit, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar                                                             , 'color', [1 0 0], 'rotation', 90, 'parent',                                                                                         axesGraphPacing, 'visible', 'on');
%         else;
%             graph1_textPos1(lap-1) = text(li, refmax, splits, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar, 'color', [1 0 0], 'rotation', 90, 'parent', axesGraphPacing, 'visible', 'on');
%         end;
%         line(li, [0 graph1Pacing_maxYRight+5], 'Color', [1 0 0], 'LineWidth', 4, 'parent', axesGraphPacing, 'visible', 'on');
%     end;
    eval(['Splittext = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1;']);
    if get(handles.Splits_check_analyser, 'value') == 1;
        set(Splittext, 'Visible', 'on');
    else;
        set(Splittext, 'Visible', 'off');
    end;
    
    
    
end;
handles.CurrentstatusSmooth = NewstatusSmooth;

guidata(handles.hf_w1_welcome, handles);