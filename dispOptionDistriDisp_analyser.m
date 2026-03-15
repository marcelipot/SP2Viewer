function [] = dispOptionDistriDisp_analyser(varargin);


handles = guidata(gcf);

handles.DistriDispDistri_analyser = get(handles.distriDispPOP_analyser, 'Value');

guidata(handles.hf_w1_welcome, handles);
