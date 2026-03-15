function [] = popSwimmerRanking_benchmark(varargin);



handles = guidata(gcf);

valEC = get(handles.SelectAthleteRanking_benchmark, 'Value');
if valEC == 1;
    stringEC = get(handles.SelectAthleteRanking_benchmark, 'String');
    if strcmpi(stringEC{1}, 'All Swimmers');
        set(handles.SelectPBRanking_benchmark, 'Value', 3, 'enable', 'on');
    else;
        set(handles.SelectPBRanking_benchmark, 'Value', 3, 'enable', 'off');
    end;
else;
    set(handles.SelectPBRanking_benchmark, 'Value', 3, 'enable', 'off');
end;
% 
% 
% 
%                                 
% guidata(handles.hf_w1_welcome, handles);
