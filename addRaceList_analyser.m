function [] = addRaceList_analyser(varargin);


handles = guidata(gcf);


if isfield(handles, 'current_toggle') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        StatusEC = get(handles.AminationStatus_analyser, 'String');
        if strcmpi(StatusEC, 'Play');
            set(handles.AminationStatus_analyser, 'String', 'Other');
            return;
        end;
    end;
end;

%     drawnow;
if isempty(handles.AthleteRacelistDisp_analyser);
    return;
end;

if length(handles.filelistAdded) == 8;
    herror = errordlg('Maximum reached', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    return;
end;

fileNum = get(handles.AthleteRace_list_analyser, 'Value');
if isempty(handles.filelistAdded) == 1;
    li = 1;
else;
    li = length(handles.filelistAdded) + 1;
end;

for i = 1:length(fileNum);
    
    fileEC = handles.AthleteRacelistDisp_analyser{fileNum(i)};
    getRaceID_analyser;

    if isempty(databaseCurrent) == 0;
        indexCB = strfind(fileEC, 'CB');
        indexSB = strfind(fileEC, 'SB');
        indexPB = strfind(fileEC, 'PB');
        if isempty(indexCB) ~= 0 | isempty(indexPB) ~= 0 | isempty(indexSB) ~= 0;
            yearRef = databaseCurrent{1,8};
            meetRef = databaseCurrent{1,7};
            name = databaseCurrent{1,2};
            dist = databaseCurrent{1,3};
            stroke = databaseCurrent{1,4};
            stage = databaseCurrent{1,6};
            relay = databaseCurrent(1,11);
            relayType = databaseCurrent{1,53};
            if strcmpi(relay, 'Flat');
                fileEC = [name '_' dist stroke '_' stage '_' meetRef yearRef];
            else;
                fileEC = [name '_' dist stroke '_' stage '(R-' relayType ')_' meetRef yearRef];
            end;
        end;
        fileECnew = fileEC;

        lisearch = strfind(handles.uidDB(:,1), databaseCurrent{1,1});
        likeepName = find(~cellfun('isempty', lisearch));
        fileEC = handles.uidDB{likeepName,2};
      
        if isempty(handles.filelistAdded) == 0;
            for i = 1:length(handles.filelistAdded);
                liexist = strcmpi(handles.filelistAdded{i}, fileEC);
                if liexist == 1;
                    return;
                end;
            end;
        end;
        
        proceed = 1;
        iter = 1;
        while proceed == 1;
            raceCHECK = handles.uidDB{iter,2};
            if strcmpi(fileEC, raceCHECK) == 1;
                itersave = iter;
                proceed = 0;
            else;
                iter = iter + 1;
            end;
        end;
        RaceDistEC = handles.uidDB{itersave,4};
        StrokeEC = handles.uidDB{itersave,5};
        GenderEC = handles.uidDB{itersave,10};        
        CourseEC = handles.uidDB{itersave,11};
        
        if length(handles.filelistAdded) >= 1;
            if isempty(handles.RaceDistList{1}) == 0;
                refli = 1;
            else;
                if isempty(handles.RaceDistList{2}) == 0;
                    refli = 2;
                else;
                    if isempty(handles.RaceDistList{3}) == 0;
                        refli = 3;
                    else;
                        if isempty(handles.RaceDistList{4}) == 0;
                            refli = 4;
                        else;
                            if isempty(handles.RaceDistList{5}) == 0;
                                refli = 5;
                            else;
                                if isempty(handles.RaceDistList{6}) == 0;
                                    refli = 6;
                                else;
                                    if isempty(handles.RaceDistList{7}) == 0;
                                        refli = 7;
                                    else;
                                        if isempty(handles.RaceDistList{8}) == 0;
                                            refli = 8;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
                    
            if strcmpi(RaceDistEC, handles.RaceDistList{refli}) == 0;
                herror = errordlg('Races must be of the same distance', 'Error');
                if ispc == 1;
                    MDIR = getenv('USERPROFILE');
                    jFrame=get(handle(herror), 'javaframe');
                    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                    jFrame.setFigureIcon(jicon);
                    clc;
                end;
                set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
                handles.updatedfiles = 1;
                return;
            end;
            if strcmpi(StrokeEC, handles.StrokeList{refli}) == 0;
                herror = errordlg('Races must be of the same stroke', 'Error');
                if ispc == 1;
                    MDIR = getenv('USERPROFILE');
                    jFrame=get(handle(herror), 'javaframe');
                    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                    jFrame.setFigureIcon(jicon);
                    clc;
                end;
                set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
                handles.updatedfiles = 1;
                return;
            end;
            
            if strcmpi(GenderEC, handles.GenderList{refli}) == 0;
                herror = errordlg('Races must be of the same gender', 'Error');
                if ispc == 1;
                    MDIR = getenv('USERPROFILE');
                    jFrame=get(handle(herror), 'javaframe');
                    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                    jFrame.setFigureIcon(jicon);
                    clc;
                end;
                set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
                handles.updatedfiles = 1;
                return;
            end;
            CourseEC = num2str(CourseEC);
            if strcmpi(CourseEC, handles.CourseList{refli}) == 0;
                herror = errordlg('Cannot process LCM and SCM races together', 'Error');
                if ispc == 1;
                    MDIR = getenv('USERPROFILE');
                    jFrame=get(handle(herror), 'javaframe');
                    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                    jFrame.setFigureIcon(jicon);
                    clc;
                end;
                set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
                handles.updatedfiles = 1;
                return;
            end;
        else;
            CourseEC = num2str(CourseEC);
        end;
        
        
        handles.RaceDistList{length(handles.filelistAdded)+1,1} = RaceDistEC;
        handles.StrokeList{length(handles.filelistAdded)+1,1} = StrokeEC;
        handles.GenderList{length(handles.filelistAdded)+1,1} = GenderEC;
        handles.CourseList{length(handles.filelistAdded)+1,1} = CourseEC;
        for dataEC = 1:length(databaseCurrent);
            handles.databaseCurrent_analyser{li,dataEC} = databaseCurrent{1,dataEC};
        end;

        handles.filelistAdded{li} = fileEC;
        handles.filelistAddedDisp{li} = fileECnew;
        li = length(handles.filelistAdded) + 1;


        %---Remove graph elements
        origin = 'addrace';
        delete_allaxes_analyser;
        reset_screen_analyser;
        set(handles.DataPanel_toggle_analyser, 'Value', 0);
        set(handles.PacingDisplay_toggle_analyser, 'Value', 0);
        set(handles.SkillDisplay_toggle_analyser, 'Value', 0);
        set(handles.SplitsDisplay_toggle_analyser, 'Value', 0);
        set(handles.SummaryData_Panel_analyser, 'Visible', 'off', 'Value', 1);
        set(handles.StrokeData_Panel_analyser, 'Visible', 'off', 'Value', 0);
        set(handles.PacingData_Panel_analyser, 'Visible', 'off', 'Value', 0);
        set(handles.SkillsData_Panel_analyser, 'Visible', 'off', 'Value', 0);
        drawnow;
    
        set(handles.FileAdded_list_analyser, 'String', handles.filelistAdded, 'Value', length(handles.filelistAdded));
        handles.updatedfiles = 1;
    end;
end;

guidata(handles.hf_w1_welcome, handles);
