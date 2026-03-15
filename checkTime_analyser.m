function [] = checkTime_analyser(varargin);


handles = guidata(gcf);

if handles.CurrentstatusTime == 1;
    set(handles.Time_check_analyser, 'Value', 1);
    return;
end;

NewstatusTime = get(handles.Time_check_analyser, 'Value');
eval(['XTitle = handles.S1.axesGraphPacingXTitletxt;']);

nbRaces = length(handles.filelistAdded);
for race = 1:nbRaces;
    eval(['xtickDistanceConvert = handles.S' num2str(race) '.axesGraphPacing_xtickDistanceConvert;']);
    eval(['xticklabelTime = handles.S' num2str(race) '.axesGraphPacing_xticklabelTime;']);
    eval(['axesGraphPacing = handles.S' num2str(race) '.axesGraphPacing;']);
    if NewstatusTime == 1;
        set(handles.Distance_check_analyser, 'Value', 0);
        handles.CurrentstatusTime = 1;
        handles.CurrentstatusDistance = 0;
        
        set(axesGraphPacing, 'xtick', xtickDistanceConvert, 'xticklabel', xticklabelTime, 'xcolor', [1 1 1], 'visible', 'on');
        xlim(axesGraphPacing, [0 xtickDistanceConvert(end)]);
    end;
end;
set(XTitle, 'String', 'Time');
set(handles.Edit_Xmin_analyser, 'String', '');
set(handles.Edit_Xmax_analyser, 'String', '');


guidata(handles.hf_w1_welcome, handles);
