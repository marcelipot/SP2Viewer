function [] = updateskills_analyser(varargin);


handles = guidata(gcf);


RaceUID = [];
nbRaces = length(handles.filelistAdded);
for raceEC = 1:nbRaces;
    fileEC = handles.filelistAdded{raceEC};
    proceed = 1;
    iter = 1;
    while proceed == 1;
        raceCHECK = handles.uidDB{iter,2};
        if strcmpi(fileEC, raceCHECK) == 1;
            RaceUID{raceEC} = handles.uidDB{iter,1};
            proceed = 0;
        else;
            iter = iter + 1;
        end;
    end;
end;

race = 1;
UID = RaceUID{race};
li = findstr(UID, '-');
UID(li) = '_';
UID = ['A' UID 'A'];
eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);

if NbLap <= 2;
    return;
end;

nbRaces = length(handles.filelistAdded);

if handles.CurrentvalueRace == 1;
    selectrace = 1:nbRaces;
else;
    selectrace = handles.CurrentvalueRace-1;
end;

for i = 1:length(selectrace);
    raceEC = selectrace(i);
    handles.TurnDisplaySelect(raceEC) = handles.CurrentvalueTurn;
end;
raceEC = [];

origin = 'UpdateSkills';
delete_allaxes_analyser;
create_emptyaxesSkill;
create_skillgraph;

handles.UpdateListGraphSkill = 1;
handles.UpdateListGraphSkillOverlay = 1;

guidata(handles.hf_w1_welcome, handles);
