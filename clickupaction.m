function [] = clickupaction(varargin)

handles = guidata(gcf);
pt = get(gcf, 'CurrentPoint');

try;
    page_actu = get(handles.txtpage, 'String');
catch
    return
end;

if strcmpi(page_actu, 'Welcome') == 1;
    %Welcome page
    welcome_main_up;
    

elseif strcmpi(page_actu, 'Analyser_main') == 1;
    %analyser main page
    analyser_main_up;
    
elseif strcmpi(page_actu, 'Database_main') == 1;
    %database main page
    database_main_up;
    set(handles.hf_w1_welcome, 'SizeChangedFcn', '');
    
elseif strcmpi(page_actu, 'Player_main') == 1;
    %calibration main Page
    player_main_up;
    set(handles.hf_w1_welcome, 'SizeChangedFcn', '');

elseif strcmpi(page_actu, 'Benchmark_main') == 1;
    %benchmark main Page
    benchmark_main_up;
    set(handles.hf_w1_welcome, 'SizeChangedFcn', '');
    
end;


try;
guidata(handles.hf_w1_welcome, handles);
end;



