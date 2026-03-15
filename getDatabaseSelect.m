function [databaseSelect, MatAge] = getDatabaseSelect(FullDB, searchInfo, AgeGroup, BenchmarkEvents, SeasonEC);


SearchName = searchInfo{1,1};
SearchDistance = searchInfo{2,1};
SearchStroke = searchInfo{3,1};
SearchPool = searchInfo{4,1};
SearchPerf = searchInfo{5,1};
SearchSeason = searchInfo{6,1};
SearchSparta = searchInfo{7,1};
if length(searchInfo) == 8;
    SearchyearPerf = searchInfo{8,1};
else;
    SearchyearPerf = [];
end;
databaseSelect = FullDB(2:end,:);


%Name
likeepTot = [];
if isempty(databaseSelect) == 0;
    classifier = databaseSelect(:,2);
    if strcmpi(databaseSelect, 'Athlete Name') ~= 1;
        lisearch = strfind(lower(classifier), lower(SearchName));
        likeepName = find(~cellfun('isempty', lisearch));
        if isempty(likeepName) == 1;
            databaseSelect = [];
        else;
            databaseSelect = databaseSelect(likeepName,:);
        end;
    else;
        databaseSelect = [];
    end;
end;

%distance
if isempty(databaseSelect) == 0;
    likeepDistance = [];
    classifier = databaseSelect(:,3);
    lisearch = strcmpi(lower(classifier), lower(SearchDistance));
    likeepDistance = find(lisearch == 1);
    if isempty(likeepDistance) == 1;
        databaseSelect = [];
    else;
        databaseSelect = databaseSelect(likeepDistance,:);
    end;
end;

%Stroke
if isempty(databaseSelect) == 0;
    likeepStroke = [];
    classifier = databaseSelect(:,4);
    lisearch = strcmpi(lower(classifier), lower(SearchStroke));
    likeepStroke = find(lisearch == 1);
    if isempty(likeepStroke) == 1;
        databaseSelect = [];
    else;
        databaseSelect = databaseSelect(likeepStroke,:);
    end;
end;

%System
if SearchSparta ~= 0;
    if isempty(databaseSelect) == 0;
        likeepSparta = [];
        classifier = databaseSelect(:,58);
        likeepSparta = find([classifier{:}] == SearchSparta); %strcmpi(lower(classifier), lower(SearchCountry));
        if isempty(likeepSparta) == 1;
            databaseSelect = [];
        else;
            databaseSelect = databaseSelect(likeepSparta,:);
        end;
    end;
end;

%Pool type
if isempty(databaseSelect) == 0;
    likeepPool = [];
    classifier = databaseSelect(:,10);
    lisearch = strcmpi(lower(classifier), lower(SearchPool));
    likeepPool = find(lisearch == 1);
    if isempty(likeepPool) == 1;
        databaseSelect = [];
    else;
        databaseSelect = databaseSelect(likeepPool,:);
    end;
end;

%Relay
if isempty(databaseSelect) == 0;
    likeepRaceType = [];
    classifier = databaseSelect(:,11);
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
        databaseSelect = [];
    else;
        databaseSelect = databaseSelect(likeepRaceType,:);
    end;
end;
databaseSelectSave = databaseSelect;

%get PB
colACT = 14;
databaseSelectPB = [];
TimePB = [];
classifier = databaseSelect(:,colACT);
timeEC = [];
for i = 1:length(databaseSelect(:,1));
    val = classifier{i,1};
    liSec = strfind(val, ' s');
    if isempty(liSec) == 0;
        timeEC(i,1) = str2num(val(1:5));
    else;
        lidot = strfind(val, ':');
        minT = str2num(val(1:lidot-1)).*60;
        secT = str2num(val(lidot+1:lidot+3));
        hunT = str2num(['0.' val(end-1:end)]);
        timeEC(i,1) = minT+secT+hunT;
    end;
end;
classifier = timeEC;

classifierMeetID = databaseSelect(:,36);
classifierDOB = databaseSelect(:,13);
MatAgePB = [];
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
    MatAgePB(i,1) = AgeYear(1);
end;
[output, index] = sort(classifier, 'ascend');
databaseSelectPB = databaseSelect(index,:);
databaseSelectPB = databaseSelectPB(1,:);
MatAgePB = MatAgePB(index,1);
MatAgePB = MatAgePB(1,1);

TimePB = databaseSelectPB{1,14};
eval(['MeetBegDate = AgeGroup.' databaseSelectPB{1,36} ';']);
YearPB = MeetBegDate(1:4);


%get SB or CB
databaseSelect = databaseSelectSave;
if isempty(SearchyearPerf);
    databaseSelect = databaseSelectSave;
    if length(SearchSeason) == 9;
        %Single year selected
        index = strfind(SearchSeason, '-');
        dateini = SeasonEC(1:index-1);
        dateend = dateini;
    
        likeepSeason = [];
        classifierMeetID = databaseSelect(:,36);
        BenchmarkEvents = BenchmarkEvents;
    
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
    
        seasonLow = BenchmarkEvents{rawini,2};
        seasonHigh = BenchmarkEvents{rawend,3};
    
        dateini = BenchmarkEvents{rawini,2}; %beginning of season
        index = strfind(dateini, '-');
        dateDiffLow(1) = datetime(str2num(dateini(1:index(1)-1)), str2num(dateini(index(1)+1:index(2)-1)), str2num(dateini(index(2)+1:end)));
    
        dateend = BenchmarkEvents{rawend,3}; %end of season
        index = strfind(dateend, '-');
        dateDiffHigh(1) = datetime(str2num(dateend(1:index(1)-1)), str2num(dateend(index(1)+1:index(2)-1)), str2num(dateend(index(2)+1:end)));
    
    else;
        index = strfind(lower(SearchSeason), lower('Season'));
        if isempty(index) == 1;
            %Cycle selected
            OGyears = [2016 2021 2024 2028 2032 2036];
            index = strfind(SearchSeason, ' ');
    
            dateini = SearchSeason(index(1)+1:index(2)-1);
            diffyear = abs(OGyears - (str2num(dateini)-4));
            
            [~, minloc] = min(diffyear);
            dateini = num2str(OGyears(minloc));
            dateend = num2str(str2num(SearchSeason(index(1)+1:index(2)-1)));
    
            likeepSeason = [];
            classifierMeetID = databaseSelect(:,36);
    
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
    
            seasonLow = BenchmarkEvents{rawini,2};
            seasonHigh = BenchmarkEvents{rawend,3};
    
            dateini = BenchmarkEvents{rawini,2}; %beginning of season
            index = strfind(dateini, '-');
            dateDiffLow(1) = datetime(str2num(dateini(1:index(1)-1)), str2num(dateini(index(1)+1:index(2)-1)), str2num(dateini(index(2)+1:end)));
    
            dateend = BenchmarkEvents{rawend,3}; %end of season
            index = strfind(dateend, '-');
            dateDiffHigh(1) = datetime(str2num(dateend(1:index(1)-1)), str2num(dateend(index(1)+1:index(2)-1)), str2num(dateend(index(2)+1:end)));
    
        else;
            %All
            currentDate = datestr(date, 'yyyy-mm-dd');
            index = strfind(currentDate, '-');
            dateDiffLow(1) = datetime(str2num(currentDate(1:index(1)-1)), str2num(currentDate(index(1)+1:index(2)-1)), str2num(currentDate(index(2)+1:end)));
            dateDiffHigh(1) = datetime(str2num(currentDate(1:index(1)-1)), str2num(currentDate(index(1)+1:index(2)-1)), str2num(currentDate(index(2)+1:end)));
            
            likeepSeason = [];
            for i = 1:length(BenchmarkEvents(:,1));
                seasonLow = BenchmarkEvents{i,2};
                seasonHigh = BenchmarkEvents{i,3};
    
                index = strfind(seasonLow, '-');
                dateDiffLow(2) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
                index = strfind(seasonLow, '-');
                dateDiffHigh(2) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));
    
                DLow = split(caldiff(dateDiffLow, 'days'), 'days');
                DHigh = split(caldiff(dateDiffHigh, 'days'), 'days');
    
                if DLow <= 0 & DHigh > 0;
                    likeepSeason = i;
                end;
            end;
    
            seasonLow = BenchmarkEvents{likeepSeason,2};
            seasonHigh = BenchmarkEvents{likeepSeason,3};
            seasonLowPrev = BenchmarkEvents{likeepSeason-1,2};
            seasonHighPrev = BenchmarkEvents{likeepSeason-1,3};
            index = strfind(seasonLow, '-');
            dateDiffLow(1) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
            index = strfind(seasonLow, '-');
            dateDiffHigh(1) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));
        end;
    end;
    
else;
    if strfind(SearchyearPerf, 'SB ');
        %Single year selected
        index = strfind(SearchyearPerf, 'SB ');
        SearchyearPerfNew = SearchyearPerf(index+3:end);
    
        index = strfind(SearchyearPerfNew, '-');
        dateini = SearchyearPerfNew(index-4:index-1);
        dateend = dateini;
    
        likeepSeason = [];
        classifierMeetID = databaseSelect(:,36);
    %     BenchmarkEvents = BenchmarkEvents;
    
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
                    rawini = i+1;
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
                    rawend = i+1;
                end;
            end;
        end;
    
        seasonLow = BenchmarkEvents{rawini,2};
        seasonHigh = BenchmarkEvents{rawend,3};
        dateini = BenchmarkEvents{rawini,2}; %beginning of season
        index = strfind(dateini, '-');
        dateDiffLow(1) = datetime(str2num(dateini(1:index(1)-1)), str2num(dateini(index(1)+1:index(2)-1)), str2num(dateini(index(2)+1:end)));
    
        dateend = BenchmarkEvents{rawend,3}; %end of season
        index = strfind(dateend, '-');
        dateDiffHigh(1) = datetime(str2num(dateend(1:index(1)-1)), str2num(dateend(index(1)+1:index(2)-1)), str2num(dateend(index(2)+1:end)));
    
    elseif strfind(SearchyearPerf, 'PB');
        %All
        currentDate = datestr(date, 'yyyy-mm-dd');
        index = strfind(currentDate, '-');
        dateDiffLow(1) = datetime(str2num(currentDate(1:index(1)-1)), str2num(currentDate(index(1)+1:index(2)-1)), str2num(currentDate(index(2)+1:end)));
        dateDiffHigh(1) = datetime(str2num(currentDate(1:index(1)-1)), str2num(currentDate(index(1)+1:index(2)-1)), str2num(currentDate(index(2)+1:end)));
        
        likeepSeason = [];
        for i = 1:length(BenchmarkEvents(:,1));
            seasonLow = BenchmarkEvents{i,2};
            seasonHigh = BenchmarkEvents{i,3};
    
            index = strfind(seasonLow, '-');
            dateDiffLow(2) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
            index = strfind(seasonLow, '-');
            dateDiffHigh(2) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));
    
            DLow = split(caldiff(dateDiffLow, 'days'), 'days');
            DHigh = split(caldiff(dateDiffHigh, 'days'), 'days');
    
            if DLow <= 0 & DHigh > 0;
                likeepSeason = i;
            end;
        end;
    
        seasonLow = BenchmarkEvents{likeepSeason,2};
        seasonHigh = BenchmarkEvents{likeepSeason,3};
        seasonLowPrev = BenchmarkEvents{likeepSeason-1,2};
        seasonHighPrev = BenchmarkEvents{likeepSeason-1,3};
        index = strfind(seasonLow, '-');
        dateDiffLow(1) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
        index = strfind(seasonLow, '-');
        dateDiffHigh(1) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));
    end;
end;


%Create MatAge
classifierMeetID = databaseSelect(:,36);
classifierDOB = databaseSelect(:,13);
MatAge = [];
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
end;
MatAgeSave = MatAge;
likeepSeason = [];
classifierMeetID = databaseSelect(:,36);

for i = 1:length(databaseSelect(:,1));
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


TimeSB = [];
databaseSelectSB = [];

if isempty(databaseSelect) == 0;
    if isempty(likeepSeason) == 1;
        databaseSelect = [];
        MatAgeSB = [];
    else;
        databaseSelect = databaseSelect(likeepSeason,:);
        MatAge = MatAge(likeepSeason,:);
        
        colACT = 14;
        classifier = databaseSelect(:,colACT);
        timeEC = [];
        for i = 1:length(databaseSelect(:,1));
            val = classifier{i,1};
            liSec = strfind(val, ' s');
            if isempty(liSec) == 0;
                timeEC(i,1) = str2num(val(1:5));
            else;
                lidot = strfind(val, ':');
                minT = str2num(val(1:lidot-1)).*60;
                secT = str2num(val(lidot+1:lidot+3));
                hunT = str2num(['0.' val(end-1:end)]);
                timeEC(i,1) = minT+secT+hunT;
            end;
        end;
        classifier = timeEC;

        [output, index] = sort(classifier, 'ascend');
        databaseSelectSB = databaseSelect(index,:);
        databaseSelectSB = databaseSelectSB(1,:);

        MatAgeSB = MatAge(index,:);
        MatAgeSB = MatAgeSB(1,1);        
        TimeSB = databaseSelectSB{1,14};
    end;
else;
    MatAgeSB = [];
end;

currentDate = datetime("today");
for seasonEC = 1:length(BenchmarkEvents(:,1));
    dateINI = datetime(BenchmarkEvents(seasonEC,2), 'InputFormat', 'yyyy-MM-dd');
    dateEND = datetime(BenchmarkEvents(seasonEC,3), 'InputFormat', 'yyyy-MM-dd');
    
    if currentDate >= dateINI & currentDate <= dateEND;
        %this is the current season
        yearEC = year(dateINI);
        raw_SeasonInterest = seasonEC;
    end;
end;


if strfind(SearchyearPerf, 'PB') == 1;
    databaseSelect = databaseSelectPB;
    MatAge = MatAgePB;

elseif strfind(SearchyearPerf, 'SB') == 1;
    databaseSelect = databaseSelectSB;
    MatAge = MatAgeSB;

else;
    databaseSelect = databaseSelectSave;
    MatAge = MatAgeSave;
    index = strfind(SearchPerf, '_'); 
    part1 = SearchPerf(index(1)+1:index(2)-1);
    if strcmpi(part1(1:4), '1500') == 1;
        SearchDist = part1(1:4);
        SearchStroke = part1(5:end);
    else;
        SearchDist = part1(1:3);
        SearchStroke = part1(4:end);
    end;
    SearchRound = SearchPerf(index(2)+1:index(3)-1);
    part2 = SearchPerf(index(3)+1:end);
    SearchMeet = part2(1:end-4);
    SearchYear = part2(end-3:end);

    SearchYear = SearchPerf(end-3:end);
    index = strfind(SearchPerf, '_');
    SearchMeet = SearchPerf(index(3)+1:end-5);
    SearchRound = SearchPerf(index(2)+1:index(3)-1);
    index = strfind(SearchRound, '(R.L1)');
    if isempty(index) == 1;
        SearchRelay = 'Flat';
    else;
        SearchRound = SearchRound(1:index-1);
        SearchRelay = '(L.1)';
    end;
    
    if isempty(databaseSelect) == 0;
        likeepYear = [];
        classifier = databaseSelect(:,8);
        lisearch = strcmpi(lower(classifier), lower(SearchyearPerf));
        likeepYear = find(lisearch == 1);

        if isempty(likeepYear) == 1;
            databaseSelect = [];
        else;
            databaseSelect = databaseSelect(likeepYear,:);
            MatAge = MatAge(likeepYear,:);
        end;
    end;

    if isempty(databaseSelect) == 0;
        likeepMeet = [];
        classifier = databaseSelect(:,7);
        lisearch = strcmpi(lower(classifier), lower(SearchMeet));
        likeepMeet = find(lisearch == 1);
        if isempty(likeepMeet) == 1;
            databaseSelect = [];
        else;
            databaseSelect = databaseSelect(likeepMeet,:);
            MatAge = MatAge(likeepMeet,:);
        end;
    end;

    if isempty(databaseSelect) == 0;
        likeepRound = [];
        classifier = databaseSelect(:,6);
        lisearch = strcmpi(lower(classifier), lower(SearchRound));
        likeepRound = find(lisearch == 1);
        if isempty(likeepRound) == 1;
            databaseSelect = [];
        else;
            databaseSelect = databaseSelect(likeepRound,:);
            MatAge = MatAge(likeepRound,:);
        end;
    end;

    if isempty(databaseSelect) == 0;
        likeepRelay = [];
        classifier = databaseSelect(:,11);
        lisearch = strcmpi(classifier, 'Flat(L.1)');

        if strcmpi(SearchRelay, '(L.1)') == 0;
            %keep only flat race
            likeepRelay = find(lisearch == 0);
        else;
            %keep only relay first leg
            likeepRelay = find(lisearch == 1);
        end;

        if isempty(likeepRelay) == 1;
            databaseSelect = [];
        else;
            databaseSelect = databaseSelect(likeepRelay,:);
            MatAge = MatAge(likeepRelay,:);
        end;
    end;
end;

