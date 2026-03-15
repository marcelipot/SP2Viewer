function [] = trendorder_analyser(varargin);


handles = guidata(gcf);

handles.Fluctrendlineorder_analyser = get(handles.trendorderPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
