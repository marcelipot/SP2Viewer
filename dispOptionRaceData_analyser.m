function [] = dispOptionRaceData_analyser(varargin);


handles = guidata(gcf);

handles.DistriOptionRaceData_analyser = get(handles.dispOptionRaceDataPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
