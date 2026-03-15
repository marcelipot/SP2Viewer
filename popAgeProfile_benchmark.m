function [] = popAgeProfile_benchmark(varargin);


handles = guidata(gcf);

valAge = get(handles.SelectAgeProfile_benchmark, 'Value');

if valAge > 2;
    handles.selectAgeLimProfile_benchmark = 1;
    handles.selectAgeRulesProfile_benchmark = 2;
    set(handles.strictAgeProfile_benchmark, 'Value', 1, 'enable', 'on');
    set(handles.belowAgeProfile_benchmark, 'Value', 0, 'enable', 'on');
    set(handles.salRulesProfile_benchmark, 'enable', 'on', 'value', 1);
    set(handles.finaRulesProfile_benchmark, 'enable', 'on', 'value', 0);
else;
    handles.selectAgeLimProfile_benchmark = 0;
    handles.selectAgeRulesProfile_benchmark = 0;
    set(handles.strictAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.belowAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.salRulesProfile_benchmark,  'enable', 'off');
    set(handles.finaRulesProfile_benchmark, 'enable', 'off');
end;
guidata(handles.hf_w1_welcome, handles);
