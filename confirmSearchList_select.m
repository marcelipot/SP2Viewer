function [] = confirmSearchList_select(varargin);


handles2 = guidata(gcf);

databaseCurrent = handles2.FullDB;
BenchmarkEvents = handles2.BenchmarkEvents;
AgeGroup = handles2.AgeGroup;

valGender = get(handles2.selectSearchGender_select, 'Value');
listGender = get(handles2.selectSearchGender_select, 'String');
if valGender == 1;
    SearchGender = [];
else;
    SearchGender = listGender{valGender};
end;

valStroke = get(handles2.selectSearchStroke_select, 'Value');
listStroke = get(handles2.selectSearchStroke_select, 'String');
if valStroke == 1;
    SearchStroke = [];
else;
    SearchStroke = listStroke{valStroke};
end;

valDist = get(handles2.selectSearchDistance_select, 'Value');
listDist = get(handles2.selectSearchDistance_select, 'String');
if valDist == 1;
    SearchDistance = [];
else;
    SearchDistance = listDist{valDist};
    SearchDistance = SearchDistance(1:end-1);
end;

valCourse = get(handles2.selectSearchCourse_select, 'Value');
listCourse = get(handles2.selectSearchCourse_select, 'String');
if valCourse == 1;
    SearchPool = [];
else;
    if strcmpi(listCourse{valCourse}, 'SCM');
        SearchPool = '25';
    else;
        SearchPool = '50';
    end;    
end;

valYear = get(handles2.selectSearchSeason_select, 'Value');
listYear = get(handles2.selectSearchSeason_select, 'String');
if valYear == 1;
    SearchSeason = [];
else;
    SearchSeason = listYear{valYear};
end;

valPB = get(handles2.selectSearchPB_select, 'Value');
listPB = get(handles2.selectSearchPB_select, 'String');
if valPB == 1;
    SearchPB = [];
else;
    SearchPB = listPB{valPB};
end;

valCountry = get(handles2.selectSearchCountry_select, 'Value');
listCountry = get(handles2.selectSearchCountry_select, 'String');
if valCountry == 1;
    SearchCountry = [];
else;
    SearchCountry = listCountry{valCountry};
end;


valType = get(handles2.selectSearchRelay_select, 'Value');
listType = get(handles2.selectSearchRelay_select, 'String');
if valType == 1;
    SearchType = [];
else;
   SearchType = listType{valType};
end;

if isempty(SearchGender) == 1 | ...
        isempty(SearchStroke) == 1 | ...
        isempty(SearchDistance) == 1 | ...
        isempty(SearchPool) == 1 | ...
        isempty(SearchSeason) == 1 | ...
        isempty(SearchType) == 1 | ...
        isempty(SearchPB) == 1 | ...
        isempty(SearchCountry) == 1;

    errordlg('Incomplete Search', 'Error');
    return;
end;


%---Filter gender
if isempty(databaseCurrent) == 0;
    likeepGender = [];
    classifier = databaseCurrent(:,5);
    lisearch = strcmpi(lower(classifier), lower(SearchGender));
    likeepGender = find(lisearch == 1);
    if isempty(likeepGender) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepGender,:);
    end;
end;

%---Filter stroke
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

%---Filter distance
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

%---Filter Pool
if isempty(databaseCurrent) == 0;
    likeepPoolType = [];
    classifier = databaseCurrent(:,10);
    lisearch = strcmpi(lower(classifier), lower(SearchPool));
    likeepPool = find(lisearch == 1);
    if isempty(likeepPool) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepPool,:);
    end;
end;

%---Filter Season
if isempty(databaseCurrent) == 0;
    if valYear == 2;
        %dont do anything
    else;
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
                eval(['MeetBegDate = AgeGroup.' MeetID ';']);
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
    end;
end;

%---Type
if valType == 2;
    %All individual races (no relay leg at all)
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        
        classifier = databaseCurrent(:,53);
        SearchRaceType = 'None'; %not a relay
        lisearch = strfind(lower(classifier), lower(SearchRaceType));
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType = find(lisearch == 1);
        
        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;

elseif valType == 3;
    %All individual races and first leg of relay
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        classifier = databaseCurrent(:,11);
        SearchRaceType = 'Flat'; %include 'Flat' and 'Flat (L.1)'
        lisearch = strfind(lower(classifier), lower(SearchRaceType));
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType = find(lisearch == 1);

        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;
    
elseif valType == 4;
    %All first leg of relay
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        classifier = databaseCurrent(:,11);
        SearchRaceType = 'Flat(L.1)';
        lisearch = strcmpi(lower(classifier), lower(SearchRaceType));
        likeepRaceType = find(lisearch == 1);
        
        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;
elseif valType == 5;
    if isempty(databaseCurrent) == 0;
        likeepRaceType = [];
        
        classifier = databaseCurrent(:,11);
        SearchRaceType = 'Relay';
        lisearch = strfind(lower(classifier), lower(SearchRaceType));
        emptyIndex = cellfun('isempty', lisearch);
        lisearch(emptyIndex) = {0};
        lisearch = cell2mat(lisearch);
        likeepRaceType = find(lisearch == 1);
        
        if isempty(likeepRaceType) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRaceType,:);
        end;
    end;
end;

%---Filter country
if isempty(databaseCurrent) == 0;
    likeepCountry = [];
    classifier = databaseCurrent(:,35);
    if valCountry == 3;
        SearchCountry = 'AUS';
        lisearch = strcmpi(lower(classifier), lower(SearchCountry));
        likeepCountry = find(lisearch == 1);
        if isempty(likeepCountry) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepCountry,:);
        end;
    end;
end;


%---Sort top 20 by race times
if isempty(databaseCurrent) == 1;
    errordlg('No races found for that selection', 'Error');
    return;
else;
    colACT = 14; %Race Time
    classifier = databaseCurrent(:,colACT);
    timeEC = [];
    if valPB == 2;
        %filter down to PB, SB, CB (based on race time)
        classifierName = databaseCurrent(:,2);
        colsource = 'RaceTime';
        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
        classifier = classifierFILT;
        databaseCurrent = databaseCurrent(likeepPBs,:);
    end;
    
%     Course = str2num(databaseCurrent{1,10});
%     RaceDist = str2num(databaseCurrent{1,3});
    if isempty(databaseCurrent) == 0;
        limInfRanking = 1;
        if length(databaseCurrent(:,1)) >= 20;
            limSupRanking = 20;
        else;
            limSupRanking = length(databaseCurrent(:,1));
        end;
    end;
    
    for i = 1:length(databaseCurrent(:,1));
        val = classifier{i,1};
        liSec = strfind(val, ' s');
        if isempty(liSec) == 0;
            timeEC(i,1) = str2num(val(1:5));
        else;
            lidot = strfind(val, ':');
            min = str2num(val(1:lidot-1)).*60;
            sec = str2num(val(lidot+1:lidot+3));
            hun = str2num(['0.' val(end-1:end)]);
            timeEC(i,1) = min+sec+hun;
        end;
    end;
    classifier = timeEC;
    [output, index] = sort(classifier, 'ascend');
    databaseCurrent = databaseCurrent(index(limInfRanking:limSupRanking),:);
end;

for raceEC = 1:20;
    eval(['selectECRace_select = handles2.select' num2str(raceEC) 'Race_select;']);
    eval(['txtRaceECMeet_select = handles2.txtRace' num2str(raceEC) 'Meet_select;']);
    eval(['txtRaceECYear_select = handles2.txtRace' num2str(raceEC) 'Year_select;']);
    eval(['txtRaceECStage_select = handles2.txtRace' num2str(raceEC) 'Stage_select;']);
    eval(['txtRaceECRelay_select = handles2.txtRace' num2str(raceEC) 'Relay_select;']);
    eval(['txtRaceECTime_select = handles2.txtRace' num2str(raceEC) 'Time_select;']);
    eval(['txtRaceECSystem_select = handles2.txtRace' num2str(raceEC) 'System_select;']);

    if raceEC > length(databaseCurrent(:,1));
        %untick, make it invisible and reset the content
        set(selectECRace_select, 'Visible', 'off', 'Value', 0, 'String', '');
        set(txtRaceECMeet_select, 'Visible', 'off', 'String', '');
        set(txtRaceECYear_select, 'Visible', 'off', 'String', '');
        set(txtRaceECStage_select, 'Visible', 'off', 'String', '');
        set(txtRaceECRelay_select, 'Visible', 'off', 'String', '');
        set(txtRaceECTime_select, 'Visible', 'off', 'String', '');
        set(txtRaceECSystem_select, 'Visible', 'off', 'String', '');

    else;
        %untick, make it visible and update the content
        yearRef = databaseCurrent{raceEC,8};
        meetRef = databaseCurrent{raceEC,7};
        name = databaseCurrent{raceEC,2};
        dist = databaseCurrent{raceEC,3};
        stroke = databaseCurrent{raceEC,4};
        stage = databaseCurrent{raceEC,6};
        relay = databaseCurrent(raceEC,11);
        relayType = databaseCurrent{raceEC,53};
        RaceTime = databaseCurrent{raceEC,14};
        RaceDate = databaseCurrent{raceEC,57};
        Source = databaseCurrent{raceEC,58};

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

%         nameLength = 50;
%         meetLength = 70;
%         stageLength = 10;
%         racetimeLength = 15;
%         relayLength = 10;
% 
%         if length(name) > nameLength;
%             charHalf = floor((nameLength/2))-3;
%             name = [name(1:charHalf) ' ... ' name(end-charHalf:end)];
%         else;
%             addChar = nameLength - length(name);
%             for addEC = 1:addChar;
%                 name = [name ' '];
%             end;
%         end;
%         if length(meetRef) > meetLength;
%             charHalf = floor((meetLength/2))-3;
%             meetRef = [meetRef(1:charHalf) ' ... ' meetRef(end-charHalf:end)];
%         else;
%             addChar = meetLength - length(meetRef);
%             for addEC = 1:addChar;
%                 meetRef = [meetRef ' '];
%             end;
%         end;
%         if length(stageshort) > stageLength;
%             charHalf = floor((stageLength/2))-3;
%             stageshort = [stageshort(1:charHalf) ' ... ' stageshort(end-charHalf:end)];
%         else;
%             addChar = stageLength - length(stageshort);
%             for addEC = 1:addChar;
%                 stageshort = [stageshort ' '];
%             end;
%         end;
%         if length(RaceTime) > racetimeLength;
%             charHalf = floor((racetimeLength/2))-3;
%             RaceTime = [RaceTime(1:charHalf) ' ... ' RaceTime(end-charHalf:end)];
%         else;
%             addChar = racetimeLength - length(RaceTime);
%             for addEC = 1:addChar;
%                 RaceTime = [RaceTime ' '];
%             end;
%         end;
        if strcmpi(relay, 'Flat');
            relayTXT = 'Indiv.';
        else;
            relayTXT = ['R-' relayType];
        end;
        if Source == 3;
            sourceTXT = 'GE';
        else;
            sourceTXT = ['SP' num2str(Source)];
        end;

        set(selectECRace_select, 'Visible', 'on', 'Value', 0, 'String', name);
        set(txtRaceECMeet_select, 'Visible', 'on', 'String', meetRef);
        set(txtRaceECYear_select, 'Visible', 'on', 'String', yearRef);
        set(txtRaceECStage_select, 'Visible', 'on', 'String', stageshort);
        set(txtRaceECRelay_select, 'Visible', 'on', 'String', relayTXT);
        set(txtRaceECTime_select, 'Visible', 'on', 'String', RaceTime);
        set(txtRaceECSystem_select, 'Visible', 'on', 'String', sourceTXT);
    end;
end;
handles2.databaseCurrent = databaseCurrent;

guidata(gcf, handles2);
