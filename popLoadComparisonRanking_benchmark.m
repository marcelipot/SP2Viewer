function [] = popLoadComparisonRanking_benchmark(varargin);




handles = guidata(gcf);


%identify template to delete
valEC = get(handles.LoadComparisonCustomRanking_benchmark, 'Value');
if valEC == 1;
    %Remove current template

    %Reset display
    handles.AthleteNamelistDisp_benchmark = handles.AthleteNamelist_analyser(2:end);
    set(handles.AthleteName_list_benchmark, 'String', handles.AthleteNamelistDisp_benchmark, 'Value', 1);
    set(handles.Search_athletename_benchmark, 'String', '');
    handles.AthleteRacelist_benchmark = '';
    handles.AthleteRacelistDisp_benchmark = '';
    set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
    set(handles.Search_racename_benchmark, 'String', '');
    
    handles.addPerfRanking = [];
    handles.addPerfProfile = [];
    handles.filelistAddedCustom_benchmark = [];
    handles.databaseCurrent = [];
    handles.existRankings = 0;
    handles.RaceDistListCustom_benchmark = [];
    handles.StrokeListCustom_benchmark = [];
    handles.GenderListCustom_benchmark = [];
    handles.CourseListCustom_benchmark = [];
    
    set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
    set(handles.MainRanking_benchmark, 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
    set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
    set(handles.SecondaryRanking_benchmark, 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
    
    set(handles.MainRanking_benchmark, 'Visible', 'off');
    set(handles.SecondaryRanking_benchmark, 'Visible', 'off');
    set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
    set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');

else;
    %Load a template
    comparison_templatelist = get(handles.LoadComparisonCustomRanking_benchmark, 'String');
    fileEC = comparison_templatelist{valEC};

    %Delete file
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        filenamePreferences = [MDIR '\SP2Viewer\Preferences\customComp_' fileEC '.mat'];
    elseif ismac == 1;
        filenamePreferences = ['/Applications/SP2Viewer/Preferences/customComp_' fileEC '.mat'];
    end;

    if isfile(filenamePreferences) == 0;
        errordlg('Comparison template cannot be found', 'Error');
        return;
    end;
    load(filenamePreferences);

    handles.addPerfRanking = addPerfRanking;
    handles.existRankings = existRankings;
    handles.filelistAddedCustom_benchmark = filelistAddedCustom_benchmark;
    handles.databaseCurrent = databaseCurrent;
    handles.RaceDistListCustom_benchmark = RaceDistListCustom_benchmark;
    handles.StrokeListCustom_benchmark = StrokeListCustom_benchmark;
    handles.GenderListCustom_benchmark = GenderListCustom_benchmark;
    handles.CourseListCustom_benchmark = CourseListCustom_benchmark;
    set(handles.sortOptionCustomRanking_benchmark, 'Value', sortingOption_benchmark);
    drawnow;

    databaseCurrent2 = databaseCurrent;
    if isempty(databaseCurrent) == 0;
        likeepAgeGroup = [];
        AgeGroup = handles.AgeGroup;
        classifierMeetID = databaseCurrent(:,36);
        classifierDOB = databaseCurrent(:,13);
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
        end;
    end;

    sourceRankings = 'new';
    sourceRankingsCustom = '';
    returnval = 0;
    valDataset = 2;
    valPB = 1;
    databaseCurrentName = [];
    SearchPool = databaseCurrent{1,10};
    SearchDistance = databaseCurrent{1,3};

    sort_ranking_benchmark;
    handles.existRankings = 1;
    handles.databaseCurrent = databaseCurrent;
    handles.MatAge = MatAge;

end;
guidata(handles.hf_w1_welcome, handles);



