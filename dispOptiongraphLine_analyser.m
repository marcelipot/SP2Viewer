function [] = dispOptiongraphLine_analyser(varargin);


handles = guidata(gcf);

handles.DistriOptionGraphLine_analyser = get(handles.dispOptiongraphLinePOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
