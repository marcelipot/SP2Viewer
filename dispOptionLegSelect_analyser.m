function [] = dispOptionLegSelect_analyser(varargin);


handles = guidata(gcf);

handles.DistriLegSelect_analyser = get(handles.dispOptionlegSelectPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
