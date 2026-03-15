strAthlete = get(handles.AthleteName_list_analyser, 'String');
valAthlete = get(handles.AthleteName_list_analyser, 'Value');

% handles.SelectPerfProfile_benchmark
databaseCurrent = handles.FullDB(2:end,:);


%Find name
if isempty(databaseCurrent) == 0;
    likeepName = [];
    classifier = databaseCurrent(:,2);

    SearchName = handles.AthleteNamelistDisp_analyser(valAthlete);
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
    
    if isempty(databaseCurrent) == 1;
        set(handles.AthleteName_list_analyser, 'String', 'None', 'value', 1);
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
        listRaces{1,1} = '----  SB  ----';
        liEC = length(listRaces(:,1));
        iterYear = 1;
        currentYear = year(datetime("today"));
        for yearEC = -(currentYear-1):-2019;
            listRaces{iterYear+liEC,1} = ['SB ' num2str(abs(yearEC)) '-' num2str(abs(yearEC)+1)];
            iterYear = iterYear + 1;
        end;
        
        liEC = length(listRaces(:,1));
        listRaces{liEC+1,1} = '----  CB  ----';
        listRaces{liEC+2,1} = 'CB LosAngeles 2028';
        listRaces{liEC+3,1} = 'CB Paris 2024';
        listRaces{liEC+4,1} = 'CB Tokyo 2021';
        listRaces{liEC+5,1} = '----  PB  ----';
        listRaces{liEC+6,1} = 'PB';

        listRacesFinal = listRaces;
        listDates = listRaces;
        for i = 1:length(databaseCurrent(:,1));
            li = length(listRaces(:,1));
            if i == 1;
                yearRef = databaseCurrent{i,8};
                meetRef = databaseCurrent{i,7};
                name = databaseCurrent{i,2};
                dist = databaseCurrent{i,3};
                stroke = databaseCurrent{i,4};
                stage = databaseCurrent{i,6};
                relay = databaseCurrent(i,11);
                relayType = databaseCurrent{i,53};
                RaceTime = databaseCurrent{i,14};
                RaceDate = databaseCurrent{i,57};
                Source = databaseCurrent{i,58};

                listRaces{li+1,1} = ['----  ' yearRef '  ----'];
                listRaces{li+2,1} = ['  --  ' meetRef];
                listRacesFinal{li+1,1} = ['----  ' yearRef '  ----'];
                listRacesFinal{li+2,1} = 'empty';
                listDates{li+1,1} = ['----  ' yearRef '  ----'];
                listDates{li+2,1} = ['  --  ' meetRef];

                if strcmpi(lower(stroke), 'freestyle') == 1;
                    strokeshort = 'FS';
                elseif strcmpi(lower(stroke), 'butterfly') == 1;
                    strokeshort = 'BF';
                elseif strcmpi(lower(stroke), 'backstroke') == 1;
                    strokeshort = 'BK';
                elseif strcmpi(lower(stroke), 'breaststroke') == 1;
                    strokeshort = 'BR';
                elseif strcmpi(lower(stroke), 'medley') == 1;
                    strokeshort = 'IM';
                else
                    strokeshort = stroke;
                end;
                if strcmpi(lower(stage), 'semifinal');
                    stageshort = 'SF';
                elseif strcmpi(lower(stage), 'semi-final');
                    stageshort = 'SF';
                elseif strcmpi(lower(stage), 'semi final');
                    stageshort = 'SF';
                else;
                    stageshort = stage;
                end;

                if strcmpi(relay, 'Flat');
                    if Source == 3;
                        listRaces{li+3,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   GE'];
                    else;
                        listRaces{li+3,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   SP' num2str(Source)];
                    end;
                else;
                    if Source == 3;
                        listRaces{li+3,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   GE'];
                    else;
                        listRaces{li+3,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   SP' num2str(Source)];
                    end;
                end;
                listRacesFinal{li+3,1} = 'empty';
                listDates{li+3,1} = RaceDate;
                iter = li+4;
            else;
                year = databaseCurrent{i,8};
                if strcmpi(yearRef, year) == 1;
                    meet = databaseCurrent{i,7};
                    if strcmpi(meetRef, meet) == 1;
                        name = databaseCurrent{i,2};
                        dist = databaseCurrent{i,3};
                        stroke = databaseCurrent{i,4};
                        stage = databaseCurrent{i,6};
                        relay = databaseCurrent(i,11);
                        relayType = databaseCurrent{i,53};
                        RaceTime = databaseCurrent{i,14};
                        RaceDate = databaseCurrent{i,57};
                        Source = databaseCurrent{i,58};

                        if strcmpi(lower(stroke), 'freestyle') == 1;
                            strokeshort = 'FS';
                        elseif strcmpi(lower(stroke), 'butterfly') == 1;
                            strokeshort = 'BF';
                        elseif strcmpi(lower(stroke), 'backstroke') == 1;
                            strokeshort = 'BK';
                        elseif strcmpi(lower(stroke), 'breaststroke') == 1;
                            strokeshort = 'BR';
                        elseif strcmpi(lower(stroke), 'medley') == 1;
                            strokeshort = 'IM';
                        else
                            strokeshort = stroke;
                        end;
                        if strcmpi(lower(stage), 'semifinal');
                            stageshort = 'SF';
                        elseif strcmpi(lower(stage), 'semi-final');
                            stageshort = 'SF';
                        elseif strcmpi(lower(stage), 'semi final');
                            stageshort = 'SF';
                        else;
                            stageshort = stage;
                        end;

                        if strcmpi(relay, 'Flat');
                            if Source == 3;
                                listRaces{iter,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   GE'];
                            else;
                                listRaces{iter,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   SP' num2str(Source)];
                            end;
                        else;
                            if Source == 3;
                                listRaces{iter,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   GE'];
                            else;
                                listRaces{iter,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   SP' num2str(Source)];
                            end;
                        end;
                        listRacesFinal{iter,1} = 'empty';
                        listDates{iter,1} = RaceDate;

                        iter = iter + 1;
                    else;
                        meetRef = meet;
                        listRaces{iter,1} = ['  --  ' meetRef];
                        listRacesFinal{iter,1} = 'empty';
                        listDates{iter,1} = ['  --  ' meetRef];
                        name = databaseCurrent{i,2};
                        dist = databaseCurrent{i,3};
                        stroke = databaseCurrent{i,4};
                        stage = databaseCurrent{i,6};
                        relay = databaseCurrent(i,11);
                        relayType = databaseCurrent{i,53};
                        RaceTime = databaseCurrent{i,14};
                        RaceDate = databaseCurrent{i,57};
                        Source = databaseCurrent{i,58};

                        if strcmpi(lower(stroke), 'freestyle') == 1;
                            strokeshort = 'FS';
                        elseif strcmpi(lower(stroke), 'butterfly') == 1;
                            strokeshort = 'BF';
                        elseif strcmpi(lower(stroke), 'backstroke') == 1;
                            strokeshort = 'BK';
                        elseif strcmpi(lower(stroke), 'breaststroke') == 1;
                            strokeshort = 'BR';
                        elseif strcmpi(lower(stroke), 'medley') == 1;
                            strokeshort = 'IM';
                        else
                            strokeshort = stroke;
                        end;
                        if strcmpi(lower(stage), 'semifinal');
                            stageshort = 'SF';
                        elseif strcmpi(lower(stage), 'semi-final');
                            stageshort = 'SF';
                        elseif strcmpi(lower(stage), 'semi final');
                            stageshort = 'SF';
                        else;
                            stageshort = stage;
                        end;

                        if strcmpi(relay, 'Flat');
                            if Source == 3;
                                listRaces{iter+1,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   GE'];
                            else;
                                listRaces{iter+1,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   SP' num2str(Source)];
                            end;
                        else;
                            if Source == 3;
                                listRaces{iter+1,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   GE'];
                            else;
                                listRaces{iter+1,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   SP' num2str(Source)];
                            end;
                        end;
                        listRacesFinal{iter+1,1} = 'empty';
                        listDates{iter+1,1} = RaceDate;

                        iter = iter + 2;
                    end;
                    
                else;
                    yearRef = year;
                    listRaces{iter,1} = ['----  ' yearRef '  ----'];
                    listRacesFinal{iter,1} = ['----  ' yearRef '  ----'];
                    listDates{iter,1} = ['----  ' yearRef '  ----'];
                    meetRef = databaseCurrent{i,7};
                    name = databaseCurrent{i,2};
                    dist = databaseCurrent{i,3};
                    stroke = databaseCurrent{i,4};
                    stage = databaseCurrent{i,6};
                    relay = databaseCurrent(i,11);
                    relayType = databaseCurrent{i,53};
                    RaceTime = databaseCurrent{i,14};
                    RaceDate = databaseCurrent{i,57};
                    Source = databaseCurrent{i,58};
                    
                    listRaces{iter+1,1} = ['  --  ' meetRef];
                    listRacesFinal{iter+1,1} = 'empty';
                    listDates{iter+1,1} = ['  --  ' meetRef];

                    if strcmpi(lower(stroke), 'freestyle') == 1;
                        strokeshort = 'FS';
                    elseif strcmpi(lower(stroke), 'butterfly') == 1;
                        strokeshort = 'BF';
                    elseif strcmpi(lower(stroke), 'backstroke') == 1;
                        strokeshort = 'BK';
                    elseif strcmpi(lower(stroke), 'breaststroke') == 1;
                        strokeshort = 'BR';
                    elseif strcmpi(lower(stroke), 'medley') == 1;
                        strokeshort = 'IM';
                    else
                        strokeshort = stroke;
                    end;
                    if strcmpi(lower(stage), 'semifinal');
                        stageshort = 'SF';
                    elseif strcmpi(lower(stage), 'semi-final');
                        stageshort = 'SF';
                    elseif strcmpi(lower(stage), 'semi final');
                        stageshort = 'SF';
                    else;
                        stageshort = stage;
                    end;

                    if strcmpi(relay, 'Flat');
                        if Source == 3;
                            listRaces{iter+2,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   GE'];
                        else;
                            listRaces{iter+2,1} = [dist strokeshort '_' stageshort '   ' RaceTime '   SP' num2str(Source)];
                        end;
                    else;
                        if Source == 3;
                            listRaces{iter+2,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   GE'];
                        else;
                            listRaces{iter+2,1} = [dist strokeshort '_' stageshort '(R-' relayType ')   ' RaceTime '   SP' num2str(Source)];
                        end;
                    end;
                    listRacesFinal{iter+2,1} = 'empty';
                    listDates{iter+2,1} = RaceDate;

                    iter = iter + 3;
                end;
            end;
        end;

        IndexMeets = find(contains(listRaces, ' -- '));
        if length(IndexMeets) > 1;
            for i = 2:length(IndexMeets);
                checkDash = find(contains(listRaces(IndexMeets(i-1)+1), '----'));
                if isempty(checkDash) == 1;
                    lim1 = IndexMeets(i-1)+1;
                else;
                    lim1 = IndexMeets(i-1)+2;
                end;
                checkDash = find(contains(listRaces(IndexMeets(i)-1), '----'));
                if isempty(checkDash) == 1;
                    lim2 = IndexMeets(i)-1;
                else;
                    lim2 = IndexMeets(i-1)-2;
                end;
                
                raceMeet = listRaces(lim1:lim2);
                raceDate = listDates(lim1:lim2);
                checkraceMeet = find(contains(raceMeet, '--'));
                if isempty(checkraceMeet) == 0;
                    likeep = [];
                    for j = 1:length(raceMeet);
                        li = find(checkraceMeet == j);
                        if isempty(li) == 0;
                            likeep = [likeep li];
                        end;
                    end;
                    raceMeet = raceMeet(likeep);
                    raceDate = raceDate(likeep);
                end;
                
                %remove letter from relay stroke
                raceMeetFull = raceMeet;
                raceName = {};
                for raceEC = 1:length(raceMeet);
                    raceName = raceMeet{raceEC};
                    index1 = strfind(raceName, '(');
                    index2 = strfind(raceName, ')');
                    if isempty(index1) == 0 & isempty(index2) == 0;
                        for letterEC = index1+1:index2-1;
                            raceName(letterEC) = 'x';
                        end;
                    end;
                    raceMeet{raceEC,1} = raceName;
                end;
                
                Search1 = find(contains(raceMeet, '50') & contains(raceMeet, 'BF'));
                Search2 = find(contains(raceMeet, '50') & contains(raceMeet, 'BK'));
                Search3 = find(contains(raceMeet, '50') & contains(raceMeet, 'BR'));
                Search4 = find(contains(raceMeet, '50') & contains(raceMeet, 'FS'));
                %Change of double with 1500FS
                removeRaw = [];
                for checkRaw = 1:length(Search4);
                    raw2Check = raceMeet{Search4(checkRaw)};
                    searchCheck = strfind(raw2Check, '1500FS');
                    if isempty(searchCheck) == 0;
                        %Wrong distance
                        removeRaw = [removeRaw checkRaw];
                    end;
                end;
                if isempty(removeRaw) == 0;
                    Search4(removeRaw) = [];
                end;
                Search5 = find(contains(raceMeet, '50') & contains(raceMeet, 'IM'));
    
                Search6 = find(contains(raceMeet, '100') & contains(raceMeet, 'BF'));
                Search7 = find(contains(raceMeet, '100') & contains(raceMeet, 'BK'));
                Search8 = find(contains(raceMeet, '100') & contains(raceMeet, 'BR'));
                Search9 = find(contains(raceMeet, '100') & contains(raceMeet, 'FS'));
                Search10 = find(contains(raceMeet, '100') & contains(raceMeet, 'IM'));
    
                Search11 = find(contains(raceMeet, '150') & contains(raceMeet, 'BF'));               
                Search12 = find(contains(raceMeet, '150') & contains(raceMeet, 'BK'));
                Search13 = find(contains(raceMeet, '150') & contains(raceMeet, 'BR'));
                Search14 = find(contains(raceMeet, '150') & contains(raceMeet, 'FS'));
                %Change of double with 1500FS
                removeRaw = [];
                for checkRaw = 1:length(Search14);
                    raw2Check = raceMeet{Search14(checkRaw)};
                    searchCheck = strfind(raw2Check, '1500FS');
                    if isempty(searchCheck) == 0;
                        %Wrong distance
                        removeRaw = [removeRaw checkRaw];
                    end;
                end;
                if isempty(removeRaw) == 0;
                    Search14(removeRaw) = [];
                end;
                Search15 = find(contains(raceMeet, '150') & contains(raceMeet, 'IM'));
                Search36 = find(contains(raceMeet, '150') & contains(raceMeet, 'Para-Medley'));
                                
                Search16 = find(contains(raceMeet, '200') & contains(raceMeet, 'BF'));
                Search17 = find(contains(raceMeet, '200') & contains(raceMeet, 'BK'));
                Search18 = find(contains(raceMeet, '200') & contains(raceMeet, 'BR'));
                Search19 = find(contains(raceMeet, '200') & contains(raceMeet, 'FS'));
                Search20 = find(contains(raceMeet, '200') & contains(raceMeet, 'IM'));
    
                Search21 = find(contains(raceMeet, '400') & contains(raceMeet, 'BF'));
                Search22 = find(contains(raceMeet, '400') & contains(raceMeet, 'BK'));
                Search23 = find(contains(raceMeet, '400') & contains(raceMeet, 'BR'));
                Search24 = find(contains(raceMeet, '400') & contains(raceMeet, 'FS'));
                Search25 = find(contains(raceMeet, '400') & contains(raceMeet, 'IM'));
    
                Search26 = find(contains(raceMeet, '800') & contains(raceMeet, 'BF'));
                Search27 = find(contains(raceMeet, '800') & contains(raceMeet, 'BK'));
                Search28 = find(contains(raceMeet, '800') & contains(raceMeet, 'BR'));
                Search29 = find(contains(raceMeet, '800') & contains(raceMeet, 'FS'));
                Search30 = find(contains(raceMeet, '800') & contains(raceMeet, 'IM'));
    
                Search31 = find(contains(raceMeet, '1500') & contains(raceMeet, 'BF'));
                Search32 = find(contains(raceMeet, '1500') & contains(raceMeet, 'BK'));
                Search33 = find(contains(raceMeet, '1500') & contains(raceMeet, 'BR'));
                Search34 = find(contains(raceMeet, '1500') & contains(raceMeet, 'FS'));
                Search35 = find(contains(raceMeet, '1500') & contains(raceMeet, 'IM'));
    
                orderraws = [Search1; Search2; Search3; Search4; Search5; ...
                    Search6; Search7; Search8; Search9; Search10; ...
                    Search11; Search12; Search13; Search14; Search15; ...
                    Search16; Search17; Search18; Search19; Search20; ...
                    Search21; Search22; Search23; Search24; Search25; ...
                    Search26; Search27; Search28; Search29; Search30; ...
                    Search31; Search32; Search33; Search34; Search35; Search36];
   
                raceMeetsort = raceMeetFull(orderraws);
                raceDatesort = raceDate(orderraws);
                
                iter = 1;
                for j = lim1:lim2;
                    listRaces{j} = raceMeetsort{iter};
                    listDates{j} = raceDatesort{iter};
                    iter = iter + 1;
                end;
            end;

            IndexYears = find(contains(listRaces, '----  20'));
            for yearEC = 1:length(IndexYears);
                if yearEC == length(IndexYears);
                    lim1year = IndexYears(yearEC)+1;
                    lim2year = length(listDates);
                else;
                    lim1year = IndexYears(yearEC)+1;
                    lim2year = IndexYears(yearEC+1)-1;
                end;
                listyearEC = listDates(lim1year:lim2year);

                IndexMeets = find(contains(listyearEC, '  --  '));
                groupMeet = [];
                for meetEC = 1:length(IndexMeets);
                    if meetEC == length(IndexMeets);
                        lim1meet = IndexMeets(meetEC)+1;
                        lim2meet = length(listyearEC);
                    else;
                        lim1meet = IndexMeets(meetEC)+1;
                        lim2meet = IndexMeets(meetEC+1)-1;
                    end;
                    groupMeet(meetEC,1:2) = [lim1year+lim1meet-1 lim1year+lim2meet-1];
                    listmeetEC = listyearEC(lim1meet:lim2meet);

                    currentEarlymonth = 12;
                    currentEarlyday = 31;
                    for dateEC = 1:length(listmeetEC);
                        date2check = listmeetEC{dateEC};
                        index = strfind(date2check, '-');
                        monthCheck = str2num(date2check(index(1)+1:index(2)-1));
                        dayCheck = str2num(date2check(index(2)+1:end));
                        
                        if monthCheck < currentEarlymonth;
                            currentEarlymonth = monthCheck;
                            currentEarlyday = dayCheck;
                            
                        elseif monthCheck == currentEarlymonth;
                            if dayCheck < currentEarlyday;
                                currentEarlyday = dayCheck;
                            end;
                        end;
                    end;
                    groupMeet(meetEC,3) = datenum(date2check, 'yyyy-mm-dd');
                end;
                [~, index] = sort(groupMeet(:,3), 'Descend');
                groupMeet = groupMeet(index,:);
                
                sortrawIni = sort(groupMeet(:,1));
                for liEC = 1:length(groupMeet(:,1));
                    liIni = sortrawIni(liEC) - 1;
                    groupEC = groupMeet(liEC,1:2);
                    nbra = groupEC(2)-groupEC(1)+1;

                    iter = 0;
                    for raEC = 0:nbra;
                        rawEC = find(contains(listRacesFinal, 'empty'));
                        rawEC = rawEC(1);

                        if raEC == 0;
                            %put meetname first
                            listRacesFinal{rawEC} = listRaces{groupEC(1)-1};
                        else;
                            %add each race
                            listRacesFinal{rawEC} = listRaces{groupEC(1)+iter};
                            iter = iter + 1;
                        end;
                    end;
                end;
            end;
            listRaces = listRacesFinal;
        else;
            checkDash = find(contains(listRaces(IndexMeets(1)+1), '----'));
            if isempty(checkDash) == 1;
                lim1 = IndexMeets(1)+1;
            else;
                lim1 = IndexMeets(1)+2;
            end;
            lim2 = length(listRaces);
            
            raceMeet = listRaces(lim1:lim2);
            checkraceMeet = find(contains(raceMeet, '--'));
            if isempty(checkraceMeet) == 0;
                likeep = [];
                for j = 1:length(raceMeet);
                    li = find(checkraceMeet == j);
                    if isempty(li) == 0;
                        likeep = [likeep li];
                    end;
                end;
                raceMeet = raceMeet(likeep);
            end;
            
            %remove letter from relay stroke
            raceMeetFull = raceMeet;
            raceName = {};
            for raceEC = 1:length(raceMeet);
                raceName = raceMeet{raceEC};
                index1 = strfind(raceName, '(');
                index2 = strfind(raceName, ')');
                if isempty(index1) == 0 & isempty(index2) == 0;
                    for letterEC = index1+1:index2-1;
                        raceName(letterEC) = 'x';
                    end;
                end;
                raceMeet{raceEC,1} = raceName;
            end;
            Search1 = find(contains(raceMeet, '50') & contains(raceMeet, 'BF'));
            Search2 = find(contains(raceMeet, '50') & contains(raceMeet, 'BK'));
            Search3 = find(contains(raceMeet, '50') & contains(raceMeet, 'BR'));
            Search4 = find(contains(raceMeet, '50') & contains(raceMeet, 'FS'));
            Search5 = find(contains(raceMeet, '50') & contains(raceMeet, 'IM'));

            Search6 = find(contains(raceMeet, '100') & contains(raceMeet, 'BF'));
            Search7 = find(contains(raceMeet, '100') & contains(raceMeet, 'BK'));
            Search8 = find(contains(raceMeet, '100') & contains(raceMeet, 'BR'));
            Search9 = find(contains(raceMeet, '100') & contains(raceMeet, 'FS'));
            Search10 = find(contains(raceMeet, '100') & contains(raceMeet, 'IM'));

            Search11 = find(contains(raceMeet, '150') & contains(raceMeet, 'BF'));
            Search12 = find(contains(raceMeet, '150') & contains(raceMeet, 'BK'));
            Search13 = find(contains(raceMeet, '150') & contains(raceMeet, 'BR'));
            Search14 = find(contains(raceMeet, '150') & contains(raceMeet, 'FS'));
            Search15 = find(contains(raceMeet, '150') & contains(raceMeet, 'IM'));

            Search16 = find(contains(raceMeet, '200') & contains(raceMeet, 'BF'));
            Search17 = find(contains(raceMeet, '200') & contains(raceMeet, 'BK'));
            Search18 = find(contains(raceMeet, '200') & contains(raceMeet, 'BR'));
            Search19 = find(contains(raceMeet, '200') & contains(raceMeet, 'FS'));
            Search20 = find(contains(raceMeet, '200') & contains(raceMeet, 'IM'));

            Search21 = find(contains(raceMeet, '400') & contains(raceMeet, 'BF'));
            Search22 = find(contains(raceMeet, '400') & contains(raceMeet, 'BK'));
            Search23 = find(contains(raceMeet, '400') & contains(raceMeet, 'BR'));
            Search24 = find(contains(raceMeet, '400') & contains(raceMeet, 'FS'));
            Search25 = find(contains(raceMeet, '400') & contains(raceMeet, 'IM'));

            Search26 = find(contains(raceMeet, '800') & contains(raceMeet, 'BF'));
            Search27 = find(contains(raceMeet, '800') & contains(raceMeet, 'BK'));
            Search28 = find(contains(raceMeet, '800') & contains(raceMeet, 'BR'));
            Search29 = find(contains(raceMeet, '800') & contains(raceMeet, 'FS'));
            Search30 = find(contains(raceMeet, '800') & contains(raceMeet, 'IM'));

            Search31 = find(contains(raceMeet, '1500') & contains(raceMeet, 'BF'));
            Search32 = find(contains(raceMeet, '1500') & contains(raceMeet, 'BK'));
            Search33 = find(contains(raceMeet, '1500') & contains(raceMeet, 'BR'));
            Search34 = find(contains(raceMeet, '1500') & contains(raceMeet, 'FS'));
            Search35 = find(contains(raceMeet, '1500') & contains(raceMeet, 'IM'));

            orderraws = [Search1; Search2; Search3; Search4; Search5; ...
                Search6; Search7; Search8; Search9; Search10; ...
                Search11; Search12; Search13; Search14; Search15; ...
                Search16; Search17; Search18; Search19; Search20; ...
                Search21; Search22; Search23; Search24; Search25; ...
                Search26; Search27; Search28; Search29; Search30; ...
                Search31; Search32; Search33; Search34; Search35];

            raceMeetsort = raceMeetFull(orderraws);
            iter = 1;
            for j = lim1:lim2;
                listRaces{j} = raceMeetsort{iter};
                iter = iter + 1;
            end;
        end;
        handles.AthleteRacelistDisp_analyser = listRaces;
        handles.AthleteRacelist_analyser = listRaces;
        set(handles.AthleteRace_list_analyser, 'String', handles.AthleteRacelistDisp_analyser, 'value', 1);
    end;

else;
    handles.AthleteRacelistDisp_analyser = '';
    set(handles.AthleteRace_list_analyser, 'String', handles.AthleteRacelistDisp_analyser, 'value', 1);
end;

