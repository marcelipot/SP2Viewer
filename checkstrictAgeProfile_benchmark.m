function [] = checkstrictAgeProfile_benchmark(varargin);


handles = guidata(gcf);

if handles.selectAgeLimProfile_benchmark == 2;
    set(handles.strictAgeProfile_benchmark, 'Value', 1);
end;
set(handles.belowAgeProfile_benchmark, 'Value', 0);
handles.selectAgeLimProfile_benchmark = 1;
guidata(handles.hf_w1_welcome, handles);
