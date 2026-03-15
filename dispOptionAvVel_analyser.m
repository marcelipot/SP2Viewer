function [] = dispOptionAvVel_analyser(varargin);


handles = guidata(gcf);

handles.FlucDispOtionAvVel_analyser = get(handles.dispOptionAvVelPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
