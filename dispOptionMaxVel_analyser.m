function [] = dispOptionMaxVel_analyser(varargin);


handles = guidata(gcf);

handles.FlucDispOtionMaxVel_analyser = get(handles.dispOptionMaxVelPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
