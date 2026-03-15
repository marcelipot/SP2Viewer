function [] = dispOptionRefVel_analyser(varargin);


handles = guidata(gcf);

handles.DistriRefVel_analyser = get(handles.dispOptionrefVelPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
