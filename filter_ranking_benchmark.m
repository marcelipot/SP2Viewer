
valGender = get(handles.SelectGenderRanking_benchmark, 'value');
valStroke = get(handles.SelectStrokeRanking_benchmark, 'value');
valDistance = get(handles.SelectDistanceRanking_benchmark, 'value');
valPool = get(handles.SelectPoolRanking_benchmark, 'value');
valCategory = get(handles.SelectCategoryRanking_benchmark, 'value');
valAge = get(handles.SelectAgeRanking_benchmark, 'value');
valDataset = get(handles.SelectDatasetRanking_benchmark, 'value');
valPB = get(handles.SelectPBRanking_benchmark, 'value');
valCountry = get(handles.SelectCountryRanking_benchmark, 'value');
valMeet = get(handles.SelectMeetRanking_benchmark, 'value');
valRound = get(handles.SelectRoundRanking_benchmark, 'value');
valType = get(handles.SelectTypeRanking_benchmark, 'value');
valSeason = get(handles.SelectSeasonRanking_benchmark, 'value');
valSparta = get(handles.SelectSpartaRanking_benchmark, 'value');
valAthlete = get(handles.SelectAthleteRanking_benchmark, 'value');
valAthleteAdd = get(handles.SelectAddAthleteRanking_benchmark, 'value');
returnval = 0;

MDIR = getenv('USERPROFILE');
if valDataset == 5 | valDataset == 6;
    if valSparta == 2 | valSparta == 3 | valSparta == 4;
        if ismac == 1;
            if valDataset == 5;
                warnwindow = warndlg('SP1 & GE data doesnt allow an accurate calculation of the speed decay', 'Warning');
            elseif valDataset == 6;
                warnwindow = warndlg('SP1 & GE data doesnt allow an accurate calculation of the decay index', 'Warning');
            end;
        elseif ispc == 1;
            MDIR = getenv('USERPROFILE');
            if valDataset == 5;
                warnwindow = warndlg('SP1 & GE data doesnt allow an accurate calculation of the speed decay', 'Warning');
            elseif valDataset == 6;
                warnwindow = warndlg('SP1 & GE data doesnt allow an accurate calculation of the decay index', 'Warning');
            end;
            jFrame = get(handle(warnwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        waitfor(warnwindow);
    end;
end;

if valGender == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a gender', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a gender', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valStroke == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a stroke', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a sotrke', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valDistance == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a distance', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a distance', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valPool == 1;
    valPool = 2;
    set(handles.SelectPoolRanking_benchmark, 'value', valPool);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a pool type', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a pool type', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valCategory == 1;
    valCategory = 2;
    set(handles.SelectCategoryRanking_benchmark, 'value', valCategory);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a category', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a category', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valAge == 1;
    valAge = 2;
    set(handles.SelectAgeRanking_benchmark, 'value', valAge);
%     if ismac == 1;
%         errorwindow = errordlg('Please select an age group', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select an age group', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valDataset == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a dataset', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a dataset', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valPB == 1;
    valPB = 2;
    set(handles.SelectPBRanking_benchmark, 'value', valPB);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a performance', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a performance', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valSeason == 1;
    valSeason = 2;
    set(handles.SelectSeasonRanking_benchmark, 'value', valSeason);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a season', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a season', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valCountry == 1;
    valCountry = 2;
    set(handles.SelectCountryRanking_benchmark, 'value', valCountry);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a country', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a country', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valMeet == 1;
    valMeet = 2;
    set(handles.SelectMeetRanking_benchmark, 'value', valMeet);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a championship', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a championship', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valRound == 1;
    valRound = 2;
    set(handles.SelectRoundRanking_benchmark, 'value', valRound);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a round', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a round', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;
if valSparta == 1;
    valSparta = 2;
    set(handles.SelectSpartaRanking_benchmark, 'value', valSparta);
%     if ismac == 1;
%         errorwindow = errordlg('Please select a system', 'Error');
%     elseif ispc == 1;
%         errorwindow = errordlg('Please select a system', 'Error');
%         jFrame = get(handle(errorwindow), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     returnval = 1;
%     return;
end;


databaseCurrent = handles.FullDB(2:end,:);

%Gender
if isempty(databaseCurrent) == 0;
    likeepGender = [];
    classifier = databaseCurrent(:,5);
    SearchGender = handles.SelectGenderRankingList_benchmark{valGender};

    lisearch = strcmpi(lower(classifier), lower(SearchGender));
    likeepGender = find(lisearch == 1);
    if isempty(likeepGender) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepGender,:);
    end;
end;

%Stroke
if isempty(databaseCurrent) == 0;
    likeepStroke = [];
    classifier = databaseCurrent(:,4);
    SearchStroke = handles.SelectStrokeRankingList_benchmark{valStroke};
    lisearch = strcmpi(lower(classifier), lower(SearchStroke));
    likeepStroke = find(lisearch == 1);
    if isempty(likeepStroke) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepStroke,:);
    end;
end;

%Distance
if isempty(databaseCurrent) == 0;
    likeepDistance = [];
    classifier = databaseCurrent(:,3);
    SearchDistance = handles.SelectDistanceRankingList_benchmark{valDistance};
    SearchDistance = SearchDistance(1:end-1);

    lisearch = strcmpi(lower(classifier), lower(SearchDistance));
    likeepDistance = find(lisearch == 1);
    if isempty(likeepDistance) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepDistance,:);
    end;
end;

%Pool
if isempty(databaseCurrent) == 0;
    likeepPoolType = [];
    classifier = databaseCurrent(:,10);
    SearchPool = handles.SelectPoolRankingList_benchmark{valPool};
    if strcmpi(SearchPool, 'SCM');
        SearchPool = '25';
    else;
        SearchPool = '50';
    end;    
    lisearch = strcmpi(lower(classifier), lower(SearchPool));
    likeepPool = find(lisearch == 1);
    if isempty(likeepPool) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepPool,:);
    end;
end;


%Category
if isempty(databaseCurrent) == 0;
    likeepCategory = [];
    classifier = databaseCurrent(:,12);
    SearchCategory = handles.SelectCategoryRankingList_benchmark{valCategory};
    lisearch = strcmpi(lower(classifier), lower(SearchCategory));
    likeepCategory = find(lisearch == 1);
    if isempty(likeepCategory) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepCategory,:);
    end;
end;

%swimmer
if isempty(databaseCurrent) == 0;
    likeepSwimmer = [];
    classifier = databaseCurrent(:,2);
    AthleteGendersListCurrent = get(handles.SelectAthleteRanking_benchmark, 'String');
    SearchAthlete = AthleteGendersListCurrent{valAthlete};   
    if strcmpi(SearchAthlete, 'All swimmers') ~= 1 & strcmpi(SearchAthlete, 'None') ~= 1;
        lisearch = strfind(lower(classifier), lower(SearchAthlete));
        likeepAthlete = find(~cellfun('isempty', lisearch));
        if isempty(likeepAthlete) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepAthlete,:);
        end;
    end;
end;


%System
if valSparta > 2;
    if isempty(databaseCurrent) == 0;
        likeepSparta = [];
        classifier = databaseCurrent(:,58);
        if valSparta == 3;
            SearchSparta = 3;
        elseif valSparta == 4;
            SearchSparta = 1;
        elseif valSparta == 5;
            SearchSparta = 2;
        end;
        likeepSparta = find([classifier{:}] == SearchSparta); %strcmpi(lower(classifier), lower(SearchCountry));
        if isempty(likeepSparta) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepSparta,:);
        end;
    end;
else;
    SearchSparta = 0;
end;


%Season
SearchSeason = [];
BenchmarkEvents = handles.BenchmarkEvents;
if isempty(databaseCurrent) == 0;
    if valSeason > 3;
        SearchSeason = handles.SelectSeasonRankingList_benchmark{valSeason};
        index1 = strfind(SearchSeason, 'Paris');
        index2 = strfind(SearchSeason, 'Tokyo');
        index3 = strfind(SearchSeason, 'LA');
        raw = 0;

        clear dateDiffLow;
        clear dateDiffHigh;
        proceedsearch = 1;
        if isempty(index1) == 0;
            %Paris Cycle
            %include 2021 - 2022 - 2023 and 2024
            date2021 = BenchmarkEvents{5,2}; %beginning of 2021
            index = strfind(date2021, '-');
            dateDiffLow(1) = datetime(str2num(date2021(1:index(1)-1)), str2num(date2021(index(1)+1:index(2)-1)), str2num(date2021(index(2)+1:end)));

            date2024 = BenchmarkEvents{7,3}; %end of 2024
            index = strfind(date2024, '-');
            dateDiffHigh(1) = datetime(str2num(date2024(1:index(1)-1)), str2num(date2024(index(1)+1:index(2)-1)), str2num(date2024(index(2)+1:end)));
            proceedsearch = 0;
            raw = 1;
        end;
        if isempty(index2) == 0;
            %Tokyo Cycle
            %include 2017 - 2018 - 2019 - 2020 and 2021
            date2018 = BenchmarkEvents{1,2}; %beginning of 2017
            index = strfind(date2018, '-');
            dateDiffLow(1) = datetime(str2num(date2018(1:index(1)-1)), str2num(date2018(index(1)+1:index(2)-1)), str2num(date2018(index(2)+1:end)));

            date2021 = BenchmarkEvents{4,3}; %end of 2024
            index = strfind(date2021, '-');
            dateDiffHigh(1) = datetime(str2num(date2021(1:index(1)-1)), str2num(date2021(index(1)+1:index(2)-1)), str2num(date2021(index(2)+1:end)));
            proceedsearch = 0;
            raw = 1;
        end;
        if isempty(index3) == 0;
            %LA Cycle
            %include 2024 - 2025 - 2026 - 2028
            date2024 = BenchmarkEvents{8,2}; %beginning of 2025
            index = strfind(date2024, '-');
            dateDiffLow(1) = datetime(str2num(date2024(1:index(1)-1)), str2num(date2024(index(1)+1:index(2)-1)), str2num(date2024(index(2)+1:end)));

            date2028 = BenchmarkEvents{11,3}; %end of 2028
            index = strfind(date2028, '-');
            dateDiffHigh(1) = datetime(str2num(date2028(1:index(1)-1)), str2num(date2028(index(1)+1:index(2)-1)), str2num(date2028(index(2)+1:end)));
            proceedsearch = 0;
            raw = 1;
        end;

        if proceedsearch == 1;
            %Single Season
            index = strfind(SearchSeason, '-');
            dateini = SearchSeason(index+1:end);
            for i = 1:length(BenchmarkEvents(:,1));
                index = strfind(BenchmarkEvents{i,1}, dateini);
                if isempty(index) == 0;
                    raw = i;
                end;
            end;
            if raw ~= 0;
                dateini = BenchmarkEvents{raw,2}; %beginning of season
                index = strfind(dateini, '-');
                dateDiffLow(1) = datetime(str2num(dateini(1:index(1)-1)), str2num(dateini(index(1)+1:index(2)-1)), str2num(dateini(index(2)+1:end)));

                dateend = BenchmarkEvents{raw,3}; %end of season
                index = strfind(dateend, '-');
                dateDiffHigh(1) = datetime(str2num(dateend(1:index(1)-1)), str2num(dateend(index(1)+1:index(2)-1)), str2num(dateend(index(2)+1:end)));
            end;
        end;
        if raw ~= 0;
            likeepSeason = [];

            classifierMeetID = databaseCurrent(:,36);
            for i = 1:length(databaseCurrent(:,1));
                MeetID = classifierMeetID{i};
                eval(['MeetBegDate = handles.AgeGroup.' MeetID ';']);
                index = strfind(MeetBegDate, '-');
                dateDiffLow(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), str2num(MeetBegDate(index(1)+1:index(2)-1)), str2num(MeetBegDate(index(2)+1:end)));
                dateDiffHigh(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), str2num(MeetBegDate(index(1)+1:index(2)-1)), str2num(MeetBegDate(index(2)+1:end)));

                DLow = split(caldiff(dateDiffLow, 'days'), 'days');
                DHigh = split(caldiff(dateDiffHigh, 'days'), 'days');

                if DLow > 0 & DHigh <= 0;
                    likeepSeason = [likeepSeason i];
                end;
            end;
            if isempty(likeepSeason) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepSeason,:);
            end;
        else;
            databaseCurrent = [];
        end;
    else;
        SearchSeason = 'Season';
    end;
end;

%Age
databaseCurrent2 = databaseCurrent;
if isempty(databaseCurrent) == 0;
    likeepAgeGroup = [];
    AgeGroup = handles.AgeGroup;
    classifierMeetID = databaseCurrent(:,36);
    classifierDOB = databaseCurrent(:,13);
    likeepAgeGroup = [];
    MatAge = [];
    MatAge2 = [];
    col = length(databaseCurrent(1,:)) + 1;

    for i = 1:length(classifierMeetID);

        MeetID = classifierMeetID{i};
        eval(['MeetBegDate = AgeGroup.' MeetID ';']);
        DOB = classifierDOB{i,1};

        index = strfind(DOB, '/');
        dateDiff(1) = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
        index = strfind(MeetBegDate, '-');
        dateDiff(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), str2num(MeetBegDate(index(1)+1:index(2)-1)), str2num(MeetBegDate(index(2)+1:end)));
        D = caldiff(dateDiff, {'years','months','days'});
    
        [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});
        MatAge(i,1) = AgeYear(1);
        MatAge2(i,1) = AgeYear(1);
        databaseCurrent{i,col} = AgeYear(1);

        if get(handles.salRulesRanking_benchmark, 'Value') == 1;
            %First day of the meet to calculate the age
            if handles.selectAgeLimRanking_benchmark == 1;
                if AgeYear(1) < 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 14 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 15 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 16 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 17 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 18 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                end;
            elseif handles.selectAgeLimRanking_benchmark == 2;
                if AgeYear(1) < 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 14 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 15 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 16 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 17 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 18 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                end;
            end;
        else;
            %End of year rule
            index = strfind(MeetBegDate, '-');
            dateDiff(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), 12, 31);
            D = caldiff(dateDiff, {'years','months','days'});
            AgeYear = [];
            [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});

            if handles.selectAgeLimRanking_benchmark == 1;
                if AgeYear(1) == 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 15 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 16 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 17 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 18 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) == 19 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                end;
            elseif handles.selectAgeLimRanking_benchmark == 2;
                if AgeYear(1) == 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 15 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 16 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 17 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 18 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                elseif AgeYear(1) <= 19 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                end;
            end;
        end;
    end;
    if isempty(databaseCurrent) == 0;
        if valAge > 2;
            if isempty(likeepAgeGroup) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepAgeGroup,:);
                MatAge = MatAge(likeepAgeGroup, 1);
            end;
        end;
    end;
end;

%name
databaseCurrentName = [];
if isempty(handles.addPerfRanking) == 1;
    if isempty(databaseCurrent2) == 0;
        likeepName = [];
        classifier = databaseCurrent2(:,2);
        
%         AthleteNamesAddListDispRanking = get();
        SearchName = handles.AthleteNamesAddListDispRanking(valAthleteAdd);
        if strcmpi(SearchName, 'Athlete Name') ~= 1;
            lisearch = strfind(lower(classifier), lower(SearchName));
            likeepName = find(~cellfun('isempty', lisearch));
            if isempty(likeepName) == 1;
                databaseCurrentName = [];
            else;
                databaseCurrentName = databaseCurrent2(likeepName,:);
                MatAgeName = MatAge2(likeepName,:);
            end;
        else;
            databaseCurrentName = [];
        end;
    else;
        databaseCurrentName = [];
    end;
else;
    %find the race in database main
    likeepName = [];
    classifier = databaseCurrent2(:,2);
    SearchName = handles.AthleteNamesAddListDispRanking(valAthleteAdd);
%     SearchSeason
    if strcmpi(SearchName, 'Athlete Name') ~= 1;
        searchInfo{1,1} = SearchName;
        searchInfo{2,1} = SearchDistance;
        searchInfo{3,1} = SearchStroke;
        searchInfo{4,1} = SearchPool;
        searchInfo{5,1} = handles.SearchPerfSelectRanking;
        searchInfo{6,1} = SearchSeason;
        searchInfo{7,1} = SearchSparta;
        try;
            searchInfo{8,1} = handles2.yearPerf;
        end;
        
        try; 
            [databaseCurrentName, MatAgeName] = getDatabaseSelect(handles.FullDB, searchInfo, handles.AgeGroup, ...
                handles.BenchmarkEvents, SeasonEC);
        catch;
            databaseCurrentName = [];
        end;
    else;
        databaseCurrentName = [];
    end;
end;
if isempty(databaseCurrentName) == 1;
    %clear the name
    set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'Value', 1);
    set(handles.SearchAddAthleteRanking_benchmark, 'String', '');
end;


%Country
if valCountry > 2;
    if isempty(databaseCurrent) == 0;
        likeepCountry = [];
        classifier = databaseCurrent(:,35);
        if valCountry == 3;
            SearchCountry = 'AUS';
        elseif valCountry == 4;
            SearchCountry = 'INTER';
        end;
        lisearch = strcmpi(lower(classifier), lower(SearchCountry));
        likeepCountry = find(lisearch == 1);
        if isempty(likeepCountry) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepCountry,:);
            MatAge = MatAge(likeepCountry, 1);
        end;
    end;
end;

%Meet
if valMeet > 2;
    if isempty(databaseCurrent) == 0;
        likeepMeet = [];
        classifier = databaseCurrent(:,36);
        SearchMeet = handles.SelectMeetNumberRankingList_benchmark{valMeet,1};

        lisearch = strcmpi(classifier, SearchMeet);
        likeepMeet = find(lisearch == 1);
        if isempty(likeepMeet) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepMeet,:);
            MatAge = MatAge(likeepMeet, 1);
        end;
    end;
end;


%Round
if valRound > 2;
    if isempty(databaseCurrent) == 0;
        likeepRound = [];
        classifier = databaseCurrent(:,6);
        SearchRound = handles.SelectRoundRankingList_benchmark{valRound,1};
        if strcmpi(SearchRound, 'SemiFinal');
            SearchRound = 'Semi Final';
        elseif strcmpi(SearchRound, 'Semi-Final');
            SearchRound = 'Semi Final';
        elseif strcmpi(SearchRound, 'Heats');
            SearchRound = 'Heat';
        elseif strcmpi(SearchRound, 'SwimOff');
            SearchRound = 'Swim Off';
        elseif strcmpi(SearchRound, 'Swim-Off');
            SearchRound = 'Swim Off';
        elseif strcmpi(SearchRound, 'TimeTrial');
            SearchRound = 'Time Trial';
        elseif strcmpi(SearchRound, 'Time-Trial');
            SearchRound = 'Time Trial';
        elseif strcmpi(SearchRound, 'BFinal');
            SearchRound = 'B Final';
        elseif strcmpi(SearchRound, 'FinalB');
            SearchRound = 'B Final';
        elseif strcmpi(SearchRound, 'Final B');
            SearchRound = 'B Final';
        elseif strcmpi(SearchRound, 'CFinal');
            SearchRound = 'C Final';
        elseif strcmpi(SearchRound, 'FinalC');
            SearchRound = 'C Final';
        elseif strcmpi(SearchRound, 'Final C');
            SearchRound = 'C Final';
        elseif strcmpi(SearchRound, 'Other1');
            SearchRound = 'Other 1';
        elseif strcmpi(SearchRound, 'Other2');
            SearchRound = 'Other 2';
        elseif strcmpi(SearchRound, 'SkinsR1');
            SearchRound = 'Skins R1';
        elseif strcmpi(SearchRound, 'SkinsR2');
            SearchRound = 'Skins R2';
        elseif strcmpi(SearchRound, 'SkinsR3');
            SearchRound = 'Skins R3';
        end;
        if strcmpi(SearchRound, 'Final');
            lisearch = strcmpi(classifier, 'Final') | strcmpi(classifier, 'FinalA');
        else;
            lisearch = strcmpi(classifier, SearchRound);
        end;
        likeepRound = find(lisearch == 1);
        if isempty(likeepRound) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRound,:);
            MatAge = MatAge(likeepRound, 1);
        end;
    end;
end;

%Type
if valType > 2;
    if isempty(databaseCurrent) == 0;
        likeepType = [];
        classifier = databaseCurrent(:,11);
        if valType == 3;
            SearchType = 'Flat';
            lisearch = strcmpi(classifier, SearchType);
            likeepType = find(lisearch == 1);
            if isempty(likeepType) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepType,:);
                MatAge = MatAge(likeepType, 1);
            end;
        elseif valType == 4;
            SearchType = 'Flat(L.1)';
            lisearch = strcmpi(classifier, SearchType);
            likeepType = find(lisearch == 1);
            if isempty(likeepType) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepType,:);
                MatAge = MatAge(likeepType, 1);
            end;
        elseif valType == 5;
            SearchRaceType = 'Relay';
            lisearch = strfind(lower(classifier), lower(SearchRaceType));
            emptyIndex = cellfun('isempty', lisearch);
            lisearch(emptyIndex) = {0};
            lisearch = cell2mat(lisearch);
            likeepType = find(lisearch == 1);
            if isempty(likeepType) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepType,:);
                MatAge = MatAge(likeepType, 1);
            end;
        end;        
    end;
else;
    %Race Type
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        classifier = databaseCurrent(:,11);
        SearchRaceType = 'Flat';
        lisearch = strfind(lower(classifier), lower(SearchRaceType));
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType1 = find(lisearch == 1);
        SearchRaceType = '(L.1)';
        lisearch = strfind(lower(classifier), lower(SearchRaceType));
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType2 = find(lisearch == 1);
        likeepRaceType = [likeepRaceType1 likeepRaceType2];
        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;
end;
if isempty(databaseCurrent) == 1;
%     errordlg('Impossible to find any races matching your selection', 'Error');
%     return;
else;
    classifier = databaseCurrent(:,11);
end;