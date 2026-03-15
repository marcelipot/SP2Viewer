function [] = displaylapfrom_analyser(varargin);


handles = guidata(gcf);

lapIni = get(handles.displaylapfromEDIT_analyser, 'String');
lapEnd = get(handles.displaylaptoEDIT_analyser, 'String');

li = findstr(lapIni, ',');
if isempty(li) == 0;
    set(handles.displaylapfromEDIT_analyser, 'String', '1');
    return;
end;

li = findstr(lapIni, ';');
if isempty(li) == 0;
    set(handles.displaylapfromEDIT_analyser, 'String', '1');
    return;
end;

li = findstr(lapIni, ' ');
if isempty(li) == 0;
    set(handles.displaylapfromEDIT_analyser, 'String', '1');
    return;
end;

lapIni = str2num(lapIni);

if isempty(lapIni) == 1;
    set(handles.displaylapfromEDIT_analyser, 'String', '1');
    return;
end;

if lapIni <= 0;
    errordlg('Enter a value > 0', 'Error');
    set(handles.displaylapfromEDIT_analyser, 'String', '1');
    return;
end;

if lapIni > str2num(lapEnd);
    errordlg(['Enter a value <= ' num2str(handles.FlucDisplayLapEnd_analyser)], 'Error');
    set(handles.displaylapfromEDIT_analyser, 'String', '1');
    return;
end;

handles.FlucDisplayLapIni_analyser = lapIni;

guidata(handles.hf_w1_welcome, handles);
