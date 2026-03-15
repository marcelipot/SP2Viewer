function [] = DPSaxismaxzoom_analyser(varargin);


handles = guidata(gcf);

valYLeftmax = get(handles.Edit_YLeftmax_analyser, 'String');

if handles.CurrentstatusDPS == 0;
    errordlg('Option not available. DPS not displayed', 'Error');
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

li = findstr(valYLeftmax, ',');
if isempty(li) == 0;
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

li = findstr(valYLeftmax, ';');
if isempty(li) == 0;
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

li = findstr(valYLeftmax, ' ');
if isempty(li) == 0;
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

numyleftmax = str2num(valYLeftmax);

if isempty(numyleftmax) == 1;
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

eval(['graph1Pacing_maxYLeft = handles.S1.axesGraphPacing_maxYLeft;']);
% eval(['graph1Pacing_minYLeft = handles.S1.axesGraphPacing_minYLeft;']);
if numyleftmax > roundn(graph1Pacing_maxYLeft,-2);
    errordlg(['Enter a value <= ' num2str(roundn(graph1Pacing_maxYLeft,-2))], 'Error');
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

if numyleftmax < 0;
    errordlg('Enter a value > 0', 'Error');
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

if numyleftmax <= handles.CurrentvalueYLeftmin;
    errordlg(['Enter a value > ' num2str(handles.CurrentvalueYLeftmin)], 'Error');
    set(handles.Edit_YLeftmax_analyser, 'String', num2str(handles.CurrentvalueYLeftmax));
    return;
end;

numyleftmax = roundn(numyleftmax,-2);

nbRaces = length(handles.filelistAdded);
for race = 1:nbRaces;
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    yyaxis(axesGraphPacing, 'left');
    ylim(axesGraphPacing, [handles.CurrentvalueYLeftmin numyleftmax]);
end;
handles.CurrentvalueYLeftmax = numyleftmax;

guidata(handles.hf_w1_welcome, handles);
