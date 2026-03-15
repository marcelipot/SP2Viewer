function [] = checkSplits_analyser(varargin);


handles = guidata(gcf);

NewstatusSplits = get(handles.Splits_check_analyser, 'Value');
nbRaces = length(handles.filelistAdded);


for race = 1:nbRaces;
    eval(['Splittext = handles.S' num2str(race) '.axesGraphPacingSplitTxtPos1;']);
    if NewstatusSplits == 1;
        set(Splittext, 'Visible', 'on');
    else;
        set(Splittext, 'Visible', 'off');
    end;
end;

handles.CurrentstatusSplits = NewstatusSplits;

guidata(handles.hf_w1_welcome, handles);