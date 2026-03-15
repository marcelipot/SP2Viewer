strAthlete = get(handles2.SearchAthleteProfile_select, 'String');
selvalAthlete = get(handles2.SelectAthleteProfile_select, 'Value');
selstrAthlete = get(handles2.SelectAthleteProfile_select, 'String');
valName = 0;
if isempty(strAthlete) == 1;
    %no name search
    if selvalAthlete ~= 1;
        %swimmer selected
        valName = 1;
    end;
else;
    if iscell(selstrAthlete) == 1;        
        valName = 1;
    end;
end;

% valDistance = get(handles2.SelectDistanceProfile_benchmark, 'Value');
% valStroke = get(handles2.SelectStrokeProfile_benchmark, 'Value');
% valPool = get(handles2.SelectPoolProfile_benchmark, 'Value');
if valName == 1;
    
    % handles2.SelectPerfProfile_benchmark
    databaseCurrent = handles2.FullDB(2:end,:);

    %Find name
    valAthlete = get(handles2.SelectAthleteProfile_select, 'Value');
    if isempty(databaseCurrent) == 0;
        likeepName = [];
        classifier = databaseCurrent(:,2);

        SearchName = handles2.AthleteNamesListDispProfile(valAthlete);
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
        SearchDistance = handles2.Distance;
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
        SearchStroke = handles2.Stroke;
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
        SearchPool = handles2.Pool;
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
    %RelayType
%     databaseCurrent
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%     
    
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
% ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    source = handles2.source;
    if strcmpi(source, 'Season') == 1;
        valPB = get(handles2.SelectPerfProfile_select, 'value');
        if length(SeasonEC) == 9;
            %specific season selected
            handles2.SelectPerfProfileList_select = {'Performance';'PB';'SB'};
            set(handles2.SelectPerfProfile_select, 'value', valPB, 'String', handles2.SelectPerfProfileList_select);

            index = strfind(SeasonEC, '-');
            dateini = SeasonEC(1:index-1);
            dateend = dateini;
            proceed = 1;
        else;
            %No season
            index = strfind(SeasonEC, 'cycle');
            if isempty(index) == 1;
                %no season selected
                handles2.SelectPerfProfileList_select = {'Performance';'PB';'SB'};
                set(handles2.SelectPerfProfile_select, 'value', valPB, 'String', handles2.SelectPerfProfileList_select);
                proceed = 0;
            else;
                %Cycle selected
                handles2.SelectPerfProfileList_select = {'Performance';'PB';'CB'};
                set(handles2.SelectPerfProfile_select, 'value', valPB, 'String', handles2.SelectPerfProfileList_select);

                OGyears = [2016 2021 2024 2028 2032 2036];
                index = strfind(SeasonEC, ' ');
                dateini = SeasonEC(index(1)+1:index(2)-1);
                diffyear = abs(OGyears - (str2num(dateini)-4));

                [minval, minloc] = min(diffyear);
                dateini = num2str(OGyears(minloc));
                dateend = num2str(str2num(SeasonEC(index(1)+1:index(2)-1))-1);
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
            listRaces{2,1} = 'SB';
            listRaces{3,1} = 'PB';
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
                
                listRaces{li+1,1} = ['----  ' yearRef '  ----'];
                if strcmpi(relay, 'Flat');
                    listRaces{li+2,1} = [name '_' dist stroke '_' stage '_' meet yearRef];
                else;
                    listRaces{li+2,1} = [name '_' dist stroke '_' stage '(R.L1)_' meet yearRef];
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
                    
                    if strcmpi(relay, 'Flat');
                        listRaces{iter,1} = [name '_' dist stroke '_' stage '_' meet year];
                    else;
                        listRaces{iter,1} = [name '_' dist stroke '_' stage '(R.L1)_' meet year];
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
                    
                    if strcmpi(relay, 'Flat');
                        listRaces{iter+1,1} = [name '_' dist stroke '_' stage '_' meet yearRef];
                    else;
                        listRaces{iter+1,1} = [name '_' dist stroke '_' stage '(R.L1)_' meet yearRef];
                    end;
                    
                    iter = iter + 2;
                end;
            end;
        end;
        handles2.SelectPerfProfileList_select = listRaces;
        set(handles2.SelectPerfProfile_select, 'String', handles2.SelectPerfProfileList_select, 'value', 1);
    end;

else;
    handles2.SelectPerfProfileList_select = {'Race';'PB';'SB'};
    set(handles2.SelectPerfProfile_select, 'String', handles2.SelectPerfProfileList_select, 'value', 1);
end;

