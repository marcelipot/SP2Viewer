function [] = deleteSearchList_select(varargin);


handles2 = guidata(gcf);

set(handles2.selectSearchGender_select, 'Value', 1);
set(handles2.selectSearchStroke_select, 'Value', 1);
set(handles2.selectSearchDistance_select, 'Value', 1);
set(handles2.selectSearchCourse_select, 'Value', 1);
set(handles2.selectSearchSeason_select, 'Value', 1);
set(handles2.selectSearchPB_select, 'Value', 1);
set(handles2.selectSearchCountry_select, 'Value', 1);
set(handles2.selectSearchRelay_select, 'Value', 1);


for raceEC = 1:20;
    eval(['selectECRace_select = handles2.select' num2str(raceEC) 'Race_select;']);
    eval(['txtRaceECMeet_select = handles2.txtRace' num2str(raceEC) 'Meet_select;']);
    eval(['txtRaceECYear_select = handles2.txtRace' num2str(raceEC) 'Year_select;']);
    eval(['txtRaceECStage_select = handles2.txtRace' num2str(raceEC) 'Stage_select;']);
    eval(['txtRaceECRelay_select = handles2.txtRace' num2str(raceEC) 'Relay_select;']);
    eval(['txtRaceECTime_select = handles2.txtRace' num2str(raceEC) 'Time_select;']);
    eval(['txtRaceECSystem_select = handles2.txtRace' num2str(raceEC) 'System_select;']);

    set(selectECRace_select, 'Visible', 'off', 'Value', 0, 'String', '');
    set(txtRaceECMeet_select, 'Visible', 'off', 'String', '');
    set(txtRaceECYear_select, 'Visible', 'off', 'String', '');
    set(txtRaceECStage_select, 'Visible', 'off', 'String', '');
    set(txtRaceECRelay_select, 'Visible', 'off', 'String', '');
    set(txtRaceECTime_select, 'Visible', 'off', 'String', '');
    set(txtRaceECSystem_select, 'Visible', 'off', 'String', '');
end;