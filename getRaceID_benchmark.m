databaseCurrent = handles.FullDB(2:end,:);



indexSB = strfind(fileEC, 'SB');
indexCB = strfind(fileEC, 'CB');
indexPB = strfind(fileEC, 'PB');

if isempty(indexSB) == 0 | isempty(indexCB) == 0 | isempty(indexPB) == 0;
    %load PB, CB, SB

    %need to find the race first
    returnEmpty = 0;
    handles2 = create_eventSelect_benchmark;
    if isempty(handles2) == 1;
        databaseCurrent = [];
        returnEmpty = 1;
        return;
    end;
    if isempty(handles2.SelectedStroke) == 1;
        databaseCurrent = [];
        returnEmpty = 1;
        return;
    end;
    SearchStroke = handles2.SelectedStroke;
    if strcmpi(SearchStroke, 'IM') == 1
        SearchStroke = 'Medley';
    end;
    SearchDistance = handles2.SelectedDistance;
    index = strfind(SearchDistance, 'm');
    SearchDistance = SearchDistance(1:index-1);
    SearchPool = handles2.SelectedPool;
    SearchRelay = handles2.SelectedRelay;
    valAthlete = get(handles.AthleteName_list_benchmark, 'Value');
    SearchName = handles.AthleteNamelistDisp_benchmark(valAthlete);

%     databaseCurrent = handles.FullDB(2:end,:);

    %Find name
    if isempty(databaseCurrent) == 0;
        likeepName = [];
        classifier = databaseCurrent(:,2);
        if strcmpi(SearchName, 'Athlete Name') ~= 1;
            lisearch = strfind(lower(classifier), lower(SearchName));
            likeepName = find(~cellfun('isempty', lisearch));
            if isempty(likeepName) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepName,:);
            end;
        else;
            databaseCurrent = [];
        end;
    end;

    %Distance
    if isempty(databaseCurrent) == 0;
        likeepDistance = [];
        classifier = databaseCurrent(:,3);
        lisearch = strcmpi(lower(classifier), lower(SearchDistance));
        likeepDistance = find(lisearch == 1);
        if isempty(likeepDistance) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepDistance,:);
        end;
    end;

    %Stroke
    if isempty(databaseCurrent) == 0;
        likeepStroke = [];
        classifier = databaseCurrent(:,4);
        lisearch = strcmpi(lower(classifier), lower(SearchStroke));
        likeepStroke = find(lisearch == 1);
        if isempty(likeepStroke) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepStroke,:);
        end;
    end;
    
    %Pool
    if isempty(databaseCurrent) == 0;
        likeepPoolType = [];
        classifier = databaseCurrent(:,10);
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

    %Relay
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        classifier = databaseCurrent(:,11);
        if strcmpi(SearchRelay, 'Flat') == 1;
            SearchRaceType = 'Flat';
        else;
            SearchRaceType = 'Relay';
        end;
        lisearch = strfind(lower(classifier), lower(SearchRaceType));
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType1 = find(lisearch == 1);
        if strcmpi(SearchRelay, 'Flat') == 1;
            SearchRaceType = '(L.1)';

            lisearch = strfind(lower(classifier), lower(SearchRaceType));
            emptyIndex = cellfun('isempty', lisearch);
            lisearch(emptyIndex) = {0};
            lisearch = cell2mat(lisearch);
            likeepRaceType2 = find(lisearch == 1);
            likeepRaceType = [likeepRaceType1 likeepRaceType2];
        else;
            likeepRaceType = likeepRaceType1;
        end;
        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;

    %RelayType
    SearchRelayType = [];
    if strcmpi(SearchRelay, 'Flat') == 0;

        indexStroke = strfind(SearchRelay, 'FS');
        athleteGender = databaseCurrent(1,5);
        if isempty(indexStroke) == 1;
            %IM relay
            SearchRelayType = 'IM';
        else;
            %FS relay
            SearchRelayType = 'FS';
        end;
        if isempty(databaseCurrent) == 0;
            likeepRelayType = [];
            classifier = databaseCurrent(:,53);
            lisearch = strfind(lower(classifier), lower(SearchRelayType));
            emptyIndex = find(~cellfun(@isempty, lisearch));
            lisearch(emptyIndex) = {1};
            lisearch = cell2mat(lisearch);
            likeepRelayType = find(lisearch == 1);
            if isempty(likeepRelayType) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepRelayType,:);
            end;
        end;
    end;
    listSeason = get(handles.AthleteRace_list_benchmark, 'String');
    valSeason = get(handles.AthleteRace_list_benchmark, 'Value');
    SeasonEC = listSeason{valSeason};
    
    indexCB = strfind(SeasonEC, 'CB');
    indexPB = strfind(SeasonEC, 'PB');
    indexSB = strfind(SeasonEC, 'SB');
    if isempty(indexCB) == 0;
        %Cycle selected
        OGyears = [2016 2021 2024 2028 2032 2036];
        index = strfind(SeasonEC, ' ');
        dateini = SeasonEC(index(2)+1:index(2)+4);
        diffyear = abs(OGyears - (str2num(dateini)-4));

        [minval, minloc] = min(diffyear);
        dateini = num2str(OGyears(minloc));
        if strcmpi(SeasonEC(index(1)+1:index(2)-1), 'Paris') == 1;
            dateend = str2num(dateini) + 3;
        elseif strcmpi(SeasonEC(index(1)+1:index(2)-1), 'Tokyo') == 1;
            dateend = str2num(dateini) + 5;
        else;
            dateend = str2num(dateini) + 4;
        end;
        dateend = num2str(dateend);
        proceed = 1;
    elseif isempty(indexSB) == 0;
        %SB selected
        index = strfind(SeasonEC, '-');
        dateini = SeasonEC(index+1:end);
        dateend = dateini;
        proceed = 1;
    elseif isempty(indexPB) == 0;
        %PB selected
        proceed = 0;
    end;

    if isempty(databaseCurrent) == 0;
        if proceed == 1;
            %Year
            likeepSeason = [];
            classifierMeetID = databaseCurrent(:,36);
    
            rawini = 1;
    
            BenchmarkEvents = handles.BenchmarkEvents;
            seasonMin = BenchmarkEvents{1,1};
            seasonMin = str2num(seasonMin(7:end));
            seasonMax = BenchmarkEvents{end,1};
            seasonMax = str2num(seasonMax(7:end));
            if str2num(dateini) < seasonMin;
                rawini = 1;
            elseif str2num(dateini) > seasonMax;
                rawini = length(BenchmarkEvents(:,1));
            else;
                for i = 1:length(BenchmarkEvents(:,1));
                    index = strfind(BenchmarkEvents{i,1}, dateini);
                    if isempty(index) == 0;
                        rawini = i;
                    end;
                end;
            end;
    
            if str2num(dateend) < seasonMin;
                rawend = 1;
            elseif str2num(dateend) > seasonMax;
                rawend = length(BenchmarkEvents(:,1));
            else;
                for i = 1:length(BenchmarkEvents(:,1));
                    index = strfind(BenchmarkEvents{i,1}, dateend);
                    if isempty(index) == 0;
                        rawend = i;
                    end;
                end;
            end;
            dateini = BenchmarkEvents{rawini,2}; %beginning of season
            index = strfind(dateini, '-');
            dateDiffLow(1) = datetime(str2num(dateini(1:index(1)-1)), str2num(dateini(index(1)+1:index(2)-1)), str2num(dateini(index(2)+1:end)));
    
            dateend = BenchmarkEvents{rawend,3}; %end of season
            index = strfind(dateend, '-');
            dateDiffHigh(1) = datetime(str2num(dateend(1:index(1)-1)), str2num(dateend(index(1)+1:index(2)-1)), str2num(dateend(index(2)+1:end)));

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
        end;
    
        if isempty(databaseCurrent) == 0;
            classifier = databaseCurrent(:,14);
            classifierName = databaseCurrent(:,2);
            colsource = 'RaceTime';
            [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
            databaseCurrent = databaseCurrent(likeepPBs,:);
        end;
    end;

else;
    %specific race selected
    index = strfind(fileEC, '_');
    index2 = strfind(fileEC, ' ');
    SearchStroke = fileEC(index(1)-2:index(1)-1);
    if strcmpi(SearchStroke, 'BF');
        SearchStroke = 'Butterfly';
    elseif strcmpi(SearchStroke, 'BK');
        SearchStroke = 'Backstroke';
    elseif strcmpi(SearchStroke, 'BR');
        SearchStroke = 'Breaststroke';
    elseif strcmpi(SearchStroke, 'FS');
        SearchStroke = 'Freestyle';
    elseif strcmpi(SearchStroke, 'IM');
        SearchStroke = 'Medley';
    end;
    SearchDistance = fileEC(1:index(1)-3);

    valAthlete = get(handles.AthleteName_list_benchmark, 'Value');
    SearchName = handles.AthleteNamelistDisp_benchmark(valAthlete);
    
    SearchRound = fileEC(index(1)+1:index2(1)-1);
    if strcmpi(SearchRound, 'SF');
        SearchRound = 'SemiFinal';
    end;

    indexB = strfind(SearchRound, '(R');
    if isempty(indexB) == 0;
        SearchRaceType = 'Relay';
        SearchRelayType = SearchRound(indexB+3:end-1);
        SearchRound = SearchRound(1:indexB-1);
    else;
        SearchRaceType = 'Flat';
        SearchRelayType = '';
    end;

    fileNum = get(handles.AthleteRace_list_benchmark, 'Value');
    racelist = get(handles.AthleteRace_list_benchmark, 'String');
    proceed = 1;
    iter = 1;
    while proceed == 1;
        checkRace = racelist{fileNum-iter};
        findmeet = strfind(checkRace, ' -- ');
        if isempty(findmeet) == 0;
            proceed = 0;
        else;
            iter = iter + 1;
        end;
    end;
    SearchMeet = checkRace(findmeet+5:end);

    proceed = 1;
    iter = 1;
    while proceed == 1;
        checkRace = racelist{fileNum-iter};
        findyear = strfind(checkRace, '----');
        if isempty(findyear) == 0;
            proceed = 0;
        else;
            iter = iter + 1;
        end;
    end;
    checkYear = strfind(checkRace, '20');
    SearchYear = checkRace(checkYear:checkYear+3);

    %name
    if isempty(databaseCurrent) == 0;
        likeepName = [];
        classifier = databaseCurrent(:,2);
        if strcmpi(SearchName, 'Athlete Name') ~= 1;
            lisearch = strfind(lower(classifier), lower(SearchName));
            likeepName = find(~cellfun('isempty', lisearch));
            if isempty(likeepName) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepName,:);
            end;
        else;
            databaseCurrent = [];
        end;
    end;
    %distance
    if isempty(databaseCurrent) == 0;
        likeepDistance = [];
        classifier = databaseCurrent(:,3);
        lisearch = strcmpi(lower(classifier), lower(SearchDistance));
        likeepDistance = find(lisearch == 1);
        if isempty(likeepDistance) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepDistance,:);
        end;
    end;
    %Stroke
    if isempty(databaseCurrent) == 0;
        likeepStroke = [];
        classifier = databaseCurrent(:,4);
        lisearch = strcmpi(lower(classifier), lower(SearchStroke));
        likeepStroke = find(lisearch == 1);
        if isempty(likeepStroke) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepStroke,:);
        end;
    end;


    %Relay
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        classifier = databaseCurrent(:,11);
        lisearch = strfind(lower(classifier), lower(SearchRaceType)); %search for flat or relay
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType = find(lisearch == 1);
        if strcmpi(lower(SearchRaceType),'relay');
            if isempty(likeepRaceType) == 1;
                %search now for flat (L.1)
                lisearch = strfind(classifier, '(L.1)');
                emptyIndex = cellfun('isempty', lisearch);
                lisearch(emptyIndex) = {0};
                lisearch = cell2mat(lisearch);
                likeepRaceType = find(lisearch ~= 0);
            end;
        else;
            if isempty(likeepRaceType) == 0;
                %search now for flat (L.1)
                lisearch = strfind(classifier, '(L.1)');
                emptyIndex = cellfun('isempty', lisearch);
                lisearch(emptyIndex) = {0};
                lisearch = cell2mat(lisearch);

                for check = 1:length(likeepRaceType);
                    poscheck = likeepRaceType(check);
                    if lisearch(poscheck) ~= 0;
                        %dont keep it
                        likeepRaceType(check) = -1;
                    end;
                end;
                index = find(likeepRaceType == -1);
                if isempty(index) == 0;
                    likeepRaceType(index) = [];
                end;
%                 likeepRaceType = likeepRaceType(find(lisearch == 0));
            end;
        end;
        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;

    %Round
    if isempty(databaseCurrent) == 0;
        likeepRound = [];
        classifier = databaseCurrent(:,6);
        if strcmpi(SearchRound, 'SemiFinal') == 1;
            lisearch = strfind(lower(classifier), lower('SemiFinal'));
            emptyIndex = cellfun('isempty', lisearch);
            lisearch(emptyIndex) = {0};
            lisearch1 = cell2mat(lisearch);

            clear lisearch;
            lisearch = strfind(lower(classifier), lower('Semi-Final'));
            emptyIndex = cellfun('isempty', lisearch);
            lisearch(emptyIndex) = {0};
            lisearch2 = cell2mat(lisearch);

            clear lisearch;
            lisearch = [];
            for i = 1:length(lisearch1);
                if lisearch1(i,1) == 1 | lisearch2(i,1) == 1;
                    lisearch(i,1) = 1;
                else;
                    lisearch(i,1) = 0;
                end;
            end;
        else;
            lisearch = strfind(lower(classifier), lower(SearchRound));
            emptyIndex = cellfun('isempty', lisearch);
            lisearch(emptyIndex) = {0};
            lisearch = cell2mat(lisearch);
        end;

        likeepRound = find(lisearch == 1);
        if isempty(likeepRound) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRound,:);
        end;
    end;

    %RelayType
    if isempty(SearchRelayType) == 0;
        if isempty(databaseCurrent) == 0;
            likeepRelayType = [];
            classifier = databaseCurrent(:,53);
            lisearch = strfind(lower(classifier), lower(SearchRelayType));
            emptyIndex = cellfun('isempty', lisearch);
            lisearch(emptyIndex) = {0};
            lisearch = cell2mat(lisearch);
            likeepRelayType = find(lisearch == 1);
            if isempty(likeepRelayType) == 1;
                databaseCurrent = [];
            else;
                databaseCurrent = databaseCurrent(likeepRelayType,:);
            end;
        end;
    end;

    % %Pool type
    % if isempty(databaseCurrent) == 0;
    %     likeepPool = [];
    %     classifier = databaseCurrent(:,10);
    %     SearchPool = handles.SelectPoolProfileList_benchmark(valPool);
    %     if strcmpi(SearchPool, 'LCM');
    %         SearchPool = '50';
    %     elseif strcmpi(SearchPool, 'SCM');
    %         SearchPool = '25';
    %     end;
    %     lisearch = strcmpi(lower(classifier), lower(SearchPool));
    %     likeepPool = find(lisearch == 1);
    %     if isempty(likeepPool) == 1;
    %         databaseCurrent = [];
    %     else;
    %         databaseCurrent = databaseCurrent(likeepPool,:);
    %     end;
    % end;
    
    %Round type
%     if isempty(databaseCurrent) == 0;
%         likeepRound = [];
%         classifier = databaseCurrent(:,6);
%         lisearch = strcmpi(lower(classifier), lower(SearchRound));
%         likeepRound = find(lisearch == 1);
%         if isempty(likeepRound) == 1;
%             databaseCurrent = [];
%         else;
%             databaseCurrent = databaseCurrent(likeepRound,:);
%         end;
%     end;

    %Meet
    if isempty(databaseCurrent) == 0;
        likeepMeet = [];
        classifier = databaseCurrent(:,7);
        lisearch = strcmpi(lower(classifier), lower(SearchMeet));
        likeepMeet = find(lisearch == 1);
        if isempty(likeepMeet) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepMeet,:);
        end;
    end;

    %Year
    if isempty(databaseCurrent) == 0;
        likeepYear = [];
        classifier = databaseCurrent(:,8);
        lisearch = strcmpi(lower(classifier), lower(SearchYear));
        likeepYear = find(lisearch == 1);
        if isempty(likeepYear) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepYear,:);
        end;
    end;
end;

if isempty(databaseCurrent) == 1;
    if ismac == 1;
        errorwindow = errordlg('No entry found for that selection', 'Error');
    elseif ispc == 1;
        MDIR = getenv('USERPROFILE');
        errorwindow = errordlg('No entry found for that selection', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    returnEmpty = 1;
    return;
end;