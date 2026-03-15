function [] = validateSearchList_select(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);

handles2 = guidata(gcf);

selectedRaces = [];
for raceEC = 1:20;
    eval(['selectECRace_select = handles2.select' num2str(raceEC) 'Race_select;']);
    valEC = get(selectECRace_select, 'Value');

    if valEC == 1;
        selectedRaces = [selectedRaces raceEC];
    end;
end;
handles2.selectedRaces = selectedRaces;

if isempty(handles2.selectedRaces) == 1;
    errordlg('At leat 1 race needs to be selected', 'Error');
    return;
end;

if length(handles2.selectedRaces) + handles2.currentRaceCount > 10;
    handles2.selectedRaces = [];
    errordlg(['Only ' num2str(10-handles2.currentRaceCount) ' other races can be added to this comparison template'], 'Error');
    return;
end;

handles2.sourceResume = 'validate';
guidata(gcf, handles2);

uiresume(gcf);
