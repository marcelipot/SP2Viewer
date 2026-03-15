function [] = addRaceList_benchmark(varargin);


handles = guidata(gcf);

if isempty(handles.AthleteRacelistDisp_benchmark);
    return;
end;
if strcmpi(handles.AthleteRacelistDisp_benchmark, 'No Selection');
    return;
end;

if length(handles.filelistAddedCustom_benchmark) == 10;
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

fileNum = get(handles.AthleteRace_list_benchmark, 'Value');
if isempty(handles.filelistAddedCustom_benchmark) == 1;
    li = 1;
else;
    li = length(handles.filelistAddedCustom_benchmark) + 1;
end;

try;
    a = returnEmpty;
catch;
    returnEmpty = 0;
end;
for i = 1:length(fileNum);

    databaseCurrentSave = handles.databaseCurrent;
    fileEC = handles.AthleteRacelistDisp_benchmark{fileNum(i)};
    getRaceID_benchmark;

    if returnEmpty == 1;
        return;
    end;

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

        if isempty(handles.filelistAddedCustom_benchmark) == 0;
            for i = 1:length(handles.filelistAddedCustom_benchmark);
                liexist = strcmpi(handles.filelistAddedCustom_benchmark{i}, fileEC);
            end;
        else;
            liexist = 0;
        end;

        if liexist == 0;
            %new race to add
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
            
            if length(handles.filelistAddedCustom_benchmark) >= 1;
                if isempty(handles.RaceDistListCustom_benchmark{1}) == 0;
                    refli = 1;
                else;
                    if isempty(handles.RaceDistListCustom_benchmark{2}) == 0;
                        refli = 2;
                    else;
                        if isempty(handles.RaceDistListCustom_benchmark{3}) == 0;
                            refli = 3;
                        else;
                            if isempty(handles.RaceDistListCustom_benchmark{4}) == 0;
                                refli = 4;
                            else;
                                if isempty(handles.RaceDistListCustom_benchmark{5}) == 0;
                                    refli = 5;
                                else;
                                    if isempty(handles.RaceDistListCustom_benchmark{6}) == 0;
                                        refli = 6;
                                    else;
                                        if isempty(handles.RaceDistListCustom_benchmark{7}) == 0;
                                            refli = 7;
                                        else;
                                            if isempty(handles.RaceDistListCustom_benchmark{8}) == 0;
                                                refli = 8;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                
                if strcmpi(RaceDistEC, handles.RaceDistListCustom_benchmark{refli}) == 0;
                    herror = errordlg('Races must be of the same distance', 'Error');
                    if ispc == 1;
                        MDIR = getenv('USERPROFILE');
                        jFrame=get(handle(herror), 'javaframe');
                        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                        jFrame.setFigureIcon(jicon);
                        clc;
                    end;
                    return;
                end;
                if strcmpi(StrokeEC, handles.StrokeListCustom_benchmark{refli}) == 0;
                    herror = errordlg('Races must be of the same stroke', 'Error');
                    if ispc == 1;
                        MDIR = getenv('USERPROFILE');
                        jFrame=get(handle(herror), 'javaframe');
                        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                        jFrame.setFigureIcon(jicon);
                        clc;
                    end;
                    return;
                end;
                
                if strcmpi(GenderEC, handles.GenderListCustom_benchmark{refli}) == 0;
                    herror = errordlg('Races must be of the same gender', 'Error');
                    if ispc == 1;
                        MDIR = getenv('USERPROFILE');
                        jFrame=get(handle(herror), 'javaframe');
                        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                        jFrame.setFigureIcon(jicon);
                        clc;
                    end;
                    return;
                end;
                CourseEC = num2str(CourseEC);
                if strcmpi(CourseEC, handles.CourseListCustom_benchmark{refli}) == 0;
                    herror = errordlg('Cannot process LCM and SCM races together', 'Error');
                    if ispc == 1;
                        MDIR = getenv('USERPROFILE');
                        jFrame=get(handle(herror), 'javaframe');
                        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                        jFrame.setFigureIcon(jicon);
                        clc;
                    end;
                    return;
                end;
            else;
                CourseEC = num2str(CourseEC);
            end;
            handles.RaceDistListCustom_benchmark{length(handles.filelistAddedCustom_benchmark)+1,1} = RaceDistEC;
            handles.StrokeListCustom_benchmark{length(handles.filelistAddedCustom_benchmark)+1,1} = StrokeEC;
            handles.GenderListCustom_benchmark{length(handles.filelistAddedCustom_benchmark)+1,1} = GenderEC;
            handles.CourseListCustom_benchmark{length(handles.filelistAddedCustom_benchmark)+1,1} = CourseEC;
            
            handles.filelistAddedCustom_benchmark{li} = fileEC;
            handles.filelistAddedDispCustom_benchmark{li} = fileECnew;
            li = length(handles.filelistAddedCustom_benchmark) + 1;
    %         drawnow;
    %         handles.updatedfiles = 1;
            if isempty(databaseCurrentSave) == 0;
                databaseCurrentNew = databaseCurrent;
                databaseCurrent = databaseCurrentSave;
                databaseCurrent(length(databaseCurrent(:,1))+1,1:end-1) = databaseCurrentNew;
                col = length(databaseCurrent(1,:));
            else;
                col = length(databaseCurrent(1,:)) + 1;
            end;
        else;
            databaseCurrent = databaseCurrentSave;
        end;

        %Age
        databaseCurrent2 = databaseCurrent;
        if isempty(databaseCurrent) == 0;
            likeepAgeGroup = [];
            AgeGroup = handles.AgeGroup;
            classifierMeetID = databaseCurrent(:,36);
            classifierDOB = databaseCurrent(:,13);
            databaseCurrent = databaseCurrent(:,1:length(handles.FullDB(1,:)));
            colTOT = length(databaseCurrent(1,:))+1;

            likeepAgeGroup = [];
            MatAge = [];
            for iterAge = 1:length(classifierMeetID);
                MeetID = classifierMeetID{iterAge};
                eval(['MeetBegDate = AgeGroup.' MeetID ';']);
                DOB = classifierDOB{iterAge,1};
        
                index = strfind(DOB, '/');
                dateDiff(1) = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
                index = strfind(MeetBegDate, '-');
                dateDiff(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), str2num(MeetBegDate(index(1)+1:index(2)-1)), str2num(MeetBegDate(index(2)+1:end)));
                D = caldiff(dateDiff, {'years','months','days'});
        
                [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});
                MatAge(iterAge,1) = AgeYear(1);
                databaseCurrent{iterAge,colTOT} = AgeYear(1);
            end;
        else;
            MatAge = [];
        end;        
        sourceRankings = 'new';
        sourceRankingsCustom = '';
        returnval = 0;
        valDataset = 2;
        valPB = 1;
        databaseCurrentName = [];
        SearchPool = databaseCurrent{1,10};

        sort_ranking_benchmark;
%         databaseCurrent = databaseCurrent(:,1:end-1);
        handles.existRankings = 1;
    end;
    handles.databaseCurrent = databaseCurrent;
    handles.databaseCurrentSort = databaseCurrentSort;
    handles.MatAge = MatAge;
end;

guidata(handles.hf_w1_welcome, handles);


