databaseCurrent = FullDB(2:end,:);

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
    classifier = databaseCurrent(:,3);
    likeepDistance = [];
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
    classifier = databaseCurrent(:,10);
    if strcmpi(SearchPool, 'SCM') | strcmpi(SearchPool, '25');
        SearchPool = '25';
    elseif strcmpi(SearchPool, 'LCM') | strcmpi(SearchPool, '50');
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

%System
if isempty(databaseCurrent) == 0;
    if SearchSparta > 2;
        likeepSparta = [];
        classifier = databaseCurrent(:,58);
        likeepSparta = find([classifier{:}] == SearchSparta-2); %strcmpi(lower(classifier), lower(SearchCountry));
        if isempty(likeepSparta) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepSparta,:);
        end;
    end;
end;

    
%Relay
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

%Season
if length(SeasonEC) == 9;
    %specific season selected
    handles2.SelectPerfProfileList_select = {'Performance';'PB';'SB'};
    set(handles2.SelectPerfProfile_select, 'value', 1, 'String', handles2.SelectPerfProfileList_select);

    index = strfind(SeasonEC, '-');
    dateini = SeasonEC(index+1:end);
    dateend = dateini;
    proceed = 1;
else;
    %No season
    index = strfind(SeasonEC, 'cycle');
    if isempty(index) == 1;
        %no season selected.
        currentDate = datetime("today");
        for seasonEC = 1:length(handles2.BenchmarkEvents(:,1));
            dateINI = datetime(handles2.BenchmarkEvents(seasonEC,2), 'InputFormat', 'yyyy-MM-dd');
            dateEND = datetime(handles2.BenchmarkEvents(seasonEC,3), 'InputFormat', 'yyyy-MM-dd');
            if currentDate >= dateINI & currentDate <= dateEND;
                %this is the current season
                yearEC = year(dateINI);
                handles2.raw_SeasonInterest = seasonEC;
            end;
        end;
        handles2.SelectPerfProfileList_select = {'Performance';'PB'; ['SB ' num2str(yearEC-1) '-' num2str(yearEC)]; ['SB ' num2str(yearEC) '-' num2str(yearEC+1)]};
        set(handles2.SelectPerfProfile_select, 'value', 1, 'String', handles2.SelectPerfProfileList_select);
        proceed = 0;
    else;
        %Cycle selected
        handles2.SelectPerfProfileList_select = {'Performance';'PB';'CB'};
        set(handles2.SelectPerfProfile_select, 'value', 1, 'String', handles2.SelectPerfProfileList_select);

        OGyears = [2016 2021 2024 2028 2032 2036];
        index = strfind(SeasonEC, ' ');
        dateini = SeasonEC(index(1)+1:index(2)-1);
        diffyear = abs(OGyears - (str2num(dateini)-4));

        [minval, minloc] = min(diffyear);
        dateini = num2str(OGyears(minloc));
        dateend = num2str(OGyears(minloc+1));
%         dateend = num2str(str2num(SeasonEC(index(1)+1:index(2)-1))-1);
        proceed = 1;
    end;
end;

if proceed == 1;
    %Year
    likeepSeason = [];
    classifierMeetID = databaseCurrent(:,36);

    rawini = 1;

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
        eval(['MeetBegDate = handles2.AgeGroup.' MeetID ';']);

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

if isempty(databaseCurrent) == 1;
    set(handles2.SelectPerfProfile_select, 'String', 'None', 'value', 1);
else;

    classifier = databaseCurrent(:,8);
    timeEC = [];
    for i = 1:length(databaseCurrent(:,1));
        val = classifier{i,1};
        yearEC(i,1) = str2num(val);
    end;
    classifier = yearEC;
    [output, index] = sort(classifier, 'Descend');
    databaseCurrent = databaseCurrent(index,:);

    listRaces = {};
    if strcmpi(source, 'Season');
        listRaces{1,1} = 'Race';
        if rawini ~= rawend;
            listRaces{2,1} = 'CB';
        else;
            listRaces{2,1} = 'SB';
        end;
    else;
        listRaces{1,1} = 'Race';
        currentDate = datetime("today");
        for seasonEC = 1:length(handles2.BenchmarkEvents(:,1));
            dateINI = datetime(handles2.BenchmarkEvents(seasonEC,2), 'InputFormat', 'yyyy-MM-dd');
            dateEND = datetime(handles2.BenchmarkEvents(seasonEC,3), 'InputFormat', 'yyyy-MM-dd');
            if currentDate >= dateINI & currentDate <= dateEND;
                %this is the current season
                yearEC = year(dateINI);
                handles2.raw_SeasonInterest = seasonEC;
            end;
        end;
        listRaces{2,1} = ['SB ' num2str(yearEC-1) '-' num2str(yearEC)];
        listRaces{3,1} = ['SB ' num2str(yearEC) '-' num2str(yearEC+1)];
        listRaces{4,1} = 'PB';
    end;

    for i = 1:length(databaseCurrent(:,1));
        li = length(listRaces(:,1));
        if i == 1;
            yearRef = databaseCurrent{i,8};

            name = databaseCurrent{i,2};
            dist = databaseCurrent{i,3};
            stroke = databaseCurrent{i,4};
            stage = databaseCurrent{i,6};
            meet = databaseCurrent{i,7};
            relay = databaseCurrent(i,11);
            relayType = databaseCurrent{i,53};
            raceTime = databaseCurrent{i,14};

            listRaces{li+1,1} = ['----  ' yearRef '  ----'];
            if strcmpi(relay, 'Flat');
                listRaces{li+2,1} = [name '_' dist stroke '_' stage '_' meet yearRef '      ' raceTime];
            else;
                listRaces{li+2,1} = [name '_' dist stroke '_' stage '(R.L1)_' meet yearRef '      ' raceTime];
            end;

            iter = li+3;
        else;
            year = databaseCurrent{i,8};
            if strcmpi(yearRef, year) == 1;
                name = databaseCurrent{i,2};
                dist = databaseCurrent{i,3};
                stroke = databaseCurrent{i,4};
                stage = databaseCurrent{i,6};
                meet = databaseCurrent{i,7};
                relay = databaseCurrent(i,11);
                relayType = databaseCurrent{i,53};
                raceTime = databaseCurrent{i,14};

                if strcmpi(relay, 'Flat');
                    listRaces{iter,1} = [name '_' dist stroke '_' stage '_' meet year '      ' raceTime];
                else;
                    listRaces{iter,1} = [name '_' dist stroke '_' stage '(R.L1)_' meet year '      ' raceTime];
                end;

                iter = iter + 1;
            else;
                yearRef = year;
                listRaces{iter,1} = ['----  ' yearRef '  ----'];
                name = databaseCurrent{i,2};
                dist = databaseCurrent{i,3};
                stroke = databaseCurrent{i,4};
                stage = databaseCurrent{i,6};
                meet = databaseCurrent{i,7};
                relay = databaseCurrent(i,11);
                relayType = databaseCurrent{i,53};
                raceTime = databaseCurrent{i,14};
                if strcmpi(relay, 'Flat');
                    listRaces{iter+1,1} = [name '_' dist stroke '_' stage '_' meet yearRef '      ' raceTime];
                else;
                    listRaces{iter+1,1} = [name '_' dist stroke '_' stage '(R.L1)_' meet yearRef '      ' raceTime];
                end;

                iter = iter + 2;
            end;
        end;
    end;
    handles2.SelectPerfProfileList_select = listRaces;
    set(handles2.SelectPerfProfile_select, 'String', handles2.SelectPerfProfileList_select, 'value', 1);
end;


