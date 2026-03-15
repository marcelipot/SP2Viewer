function [] = checkbelowAgeProfile_benchmark(varargin);


handles = guidata(gcf);

if handles.selectAgeLimProfile_benchmark == 1;
    set(handles.belowAgeProfile_benchmark, 'Value', 1);
end;
set(handles.strictAgeProfile_benchmark, 'Value', 0);
handles.selectAgeLimProfile_benchmark = 2;
guidata(handles.hf_w1_welcome, handles);
