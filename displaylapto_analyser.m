function [] = displaylapto_analyser(varargin);


handles = guidata(gcf);

lapIni = get(handles.displaylapfromEDIT_analyser, 'String');
lapEnd = get(handles.displaylaptoEDIT_analyser, 'String');

li = findstr(lapEnd, ',');
if isempty(li) == 0;
    set(handles.displaylaptoEDIT_analyser, 'String', num2str(handles.FlucDisplayLapEnd_analyser));
    return;
end;

li = findstr(lapEnd, ';');
if isempty(li) == 0;
    set(handles.displaylaptoEDIT_analyser, 'String', num2str(handles.FlucDisplayLapEnd_analyser));
    return;
end;

li = findstr(lapEnd, ' ');
if isempty(li) == 0;
    set(handles.displaylaptoEDIT_analyser, 'String', num2str(handles.FlucDisplayLapEnd_analyser));
    return;
end;

lapEnd = str2num(lapEnd);

if isempty(lapEnd) == 1;
    set(handles.displaylaptoEDIT_analyser, 'String', num2str(handles.FlucDisplayLapEnd_analyser));
    return;
end;

if lapEnd > handles.FlucDisplaynLap_analyser;
    errordlg(['Enter a value <= ' num2str(handles.FlucDisplaynLap_analyser)], 'Error');
    set(handles.displaylaptoEDIT_analyser, 'String', num2str(handles.FlucDisplayLapEnd_analyser));
    return;
end;

if lapEnd < str2num(lapIni);
    errordlg(['Enter a value >= ' num2str(lapIni)], 'Error');
    set(handles.displaylaptoEDIT_analyser, 'String', num2str(handles.FlucDisplayLapEnd_analyser));
    return;
end;

handles.FlucDisplayLapEnd_analyser = lapEnd;

guidata(handles.hf_w1_welcome, handles);
