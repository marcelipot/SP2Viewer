function [] = clickdownaction(varargin)


handles = guidata(gcf);
pt = get(gcf, 'CurrentPoint');
page_actu = get(handles.txtpage, 'String');

handles.TooltipMain.activestatus = 0;
% set(handles.TooltipMain.disptext, 'Visible', 'off');
drawnow;

if strcmpi(page_actu, 'Welcome') == 1;
    %Welcome page
    welcome_main_down;
    

elseif strcmpi(page_actu, 'Analyser_main') == 1;
    %tracking main page
    analyser_main_down;
    
elseif strcmpi(page_actu, 'Database_main') == 1;
    %tracking main page
    database_main_down;
    
elseif strcmpi(page_actu, 'Player_main') == 1;
    %calibration main Page
    player_main_down;

elseif strcmpi(page_actu, 'Benchmark_main') == 1;
    %benchmark main Page
    benchmark_main_down;
    
end;

guidata(handles.hf_w1_welcome, handles);
drawnow;

