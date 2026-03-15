function [] = DPSaxisminzoom_analyser(varargin);


handles = guidata(gcf);

valYLeftmin = get(handles.Edit_YLeftmin_analyser, 'String');

if handles.CurrentstatusDPS == 0;
    errordlg('Option not available. DPS not displayed', 'Error');
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

li = findstr(valYLeftmin, ',');
if isempty(li) == 0;
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

li = findstr(valYLeftmin, ';');
if isempty(li) == 0;
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

li = findstr(valYLeftmin, ' ');
if isempty(li) == 0;
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

numyleftmin = str2num(valYLeftmin);

if isempty(numyleftmin) == 1;
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

eval(['graph1Pacing_maxYLeft = handles.S1.axesGraphPacing_maxYLeft;']);
% eval(['graph1Pacing_minYLeft = handles.S1.axesGraphPacing_minYLeft;']);
if numyleftmin > roundn(graph1Pacing_maxYLeft,-2);
    errordlg(['Enter a value < ' num2str(roundn(graph1Pacing_maxYLeft,-2))], 'Error');
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

if numyleftmin < 0;
    errordlg('Enter a value >= 0', 'Error');
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

if numyleftmin >= handles.CurrentvalueYLeftmax;
    errordlg(['Enter a value < ' num2str(handles.CurrentvalueYLeftmax)], 'Error');
    set(handles.Edit_YLeftmin_analyser, 'String', num2str(handles.CurrentvalueYLeftmin));
    return;
end;

numYleftmin = roundn(numyleftmin,-2);

nbRaces = length(handles.filelistAdded);
for race = 1:nbRaces;
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    yyaxis(axesGraphPacing, 'left');
    ylim(axesGraphPacing, [numyleftmin handles.CurrentvalueYLeftmax]);
end;
handles.CurrentvalueYLeftmin = numyleftmin;

guidata(handles.hf_w1_welcome, handles);
