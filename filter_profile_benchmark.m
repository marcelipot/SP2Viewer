
valAthlete = get(handles.SelectAthleteProfile_benchmark, 'value');
valPerf = get(handles.SelectPerfProfile_benchmark, 'Value');
BenchmarkEvents = handles.BenchmarkEvents;
valDistance = get(handles.SelectDistanceProfile_benchmark, 'Value');
valStroke = get(handles.SelectStrokeProfile_benchmark, 'Value');
valPool = get(handles.SelectPoolProfile_benchmark, 'Value');
valCountry = get(handles.SelectCountryProfile_benchmark, 'value');
valSeason = get(handles.SelectSeasonProfile_benchmark, 'value');
valSparta = get(handles.SelectSpartaProfile_benchmark, 'value');
valSimilarity = get(handles.SelectSimilarityProfile_benchmark, 'value');
valAge = get(handles.SelectAgeProfile_benchmark, 'value');
valPB = get(handles.SelectPBProfile_benchmark, 'value');

returnval = 0;

MDIR = getenv('USERPROFILE');
if valAthlete == 1;
    if strcmpi(handles.SelectPerfProfileList_benchmark(valPerf), 'None') == 1;
        if ismac == 1;
            errorwindow = errordlg('Please select a swimmer', 'Error');
        elseif ispc == 1;
            errorwindow = errordlg('Please select a swimmer', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        returnval = 1;
        return;
    elseif strcmpi(handles.AthleteNamesListDispProfile, 'Athlete name') == 1;
        if ismac == 1;
            errorwindow = errordlg('Please select a swimmer', 'Error');
        elseif ispc == 1;
            errorwindow = errordlg('Please select a swimmer', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        returnval = 1;
        return;
    end;
end;
if valPerf == 1;
    if strcmpi(handles.SelectPerfProfileList_benchmark(valPerf), 'None') == 1;
        if ismac == 1;
            errorwindow = errordlg('Please select a performance', 'Error');
        elseif ispc == 1;
            errorwindow = errordlg('Please select a performance', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        returnval = 1;
        return;
    elseif strcmpi(handles.SelectPerfProfileList_benchmark(valPerf), 'Race') == 1;
        if ismac == 1;
            errorwindow = errordlg('Please select a performance', 'Error');
        elseif ispc == 1;
            errorwindow = errordlg('Please select a performance', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        returnval = 1;
        return;
    end;
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
if valPool == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a pool type', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a pool type', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valCountry == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a country', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a country', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valSeason == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a season', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a season', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valSimilarity == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a profile', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a profile', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valAge == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select an age group', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select an age group', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valSparta == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a system', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a system', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valPB == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a performance type', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a performance type', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if valSparta == 2 | valSparta == 3 | valSparta == 4;
    if ismac == 1;
        warnwindow = warndlg('SP1 & GE data doesnt allow an accurate calculation of the speed decay', 'Warning');
    elseif ispc == 1;
        warnwindow = warndlg('SP1 & GE data doesnt allow an accurate calculation of the speed decay', 'Warning');
        jFrame = get(handle(warnwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(warnwindow);
end;


databaseCurrent = handles.FullDB(2:end,:);


%name
if isempty(databaseCurrent) == 0;
    likeepName = [];
    classifier = databaseCurrent(:,2);
    SearchName = handles.AthleteNamesListDispProfile(valAthlete);
    
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
    SearchDistance = handles.SelectDistanceProfileList_benchmark{valDistance};
    index = strfind(SearchDistance, 'm');
    SearchDistance = SearchDistance(1:end-1);
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
    SearchStroke = handles.SelectStrokeProfileList_benchmark{valStroke};
    lisearch = strcmpi(lower(classifier), lower(SearchStroke));
    likeepStroke = find(lisearch == 1);
    if isempty(likeepStroke) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepStroke,:);
    end;
end;
%Pool type
if isempty(databaseCurrent) == 0;
    likeepPool = [];
    classifier = databaseCurrent(:,10);
    SearchPool = handles.SelectPoolProfileList_benchmark(valPool);
    if strcmpi(SearchPool, 'LCM');
        SearchPool = '50';
    elseif strcmpi(SearchPool, 'SCM');
        SearchPool = '25';
    end;
    lisearch = strcmpi(lower(classifier), lower(SearchPool));
    likeepPool = find(lisearch == 1);
    if isempty(likeepPool) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepPool,:);
    end;
end;
%Sparta system
    if isempty(databaseCurrent) == 0;
        if valSparta > 2;
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


SearchPerf = handles.SelectPerfProfileList_benchmark{valPerf};
if strcmpi(SearchPerf, 'None') == 1;
    if ismac == 1;
        errorwindow = errordlg('No Performance available', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('No Performance available', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;

index = strfind(SearchPerf, '_');

if strcmpi(SearchPerf, 'Performance') == 1;
    if ismac == 1;
        errorwindow = errordlg('Please select a performance', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Please select a performance', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;

databaseCurrentSave = databaseCurrent;
handles.databaseCurrentSave = databaseCurrentSave;

%get PB
colACT = 14;
databaseCurrentPB = [];
TimePB = [];
classifier = databaseCurrent(:,colACT);
timeEC = [];
for i = 1:length(databaseCurrent(:,1));
    val = classifier{i,1};
    liSec = strfind(val, ' s');
    if isempty(liSec) == 0;
        timeEC(i,1) = str2num(val(1:5));
    else;
        lidot = strfind(val, ':');
        minu = str2num(val(1:lidot-1)).*60;
        sec = str2num(val(lidot+1:lidot+3));
        hun = str2num(['0.' val(end-1:end)]);
        timeEC(i,1) = minu+sec+hun;
    end;
end;
classifier = timeEC;

[output, index] = sort(classifier, 'ascend');
databaseCurrentPB = databaseCurrent(index,:);
databaseCurrentPB = databaseCurrentPB(1,:);
TimePB = databaseCurrentPB{1,14};
eval(['MeetBegDate = handles.AgeGroup.' databaseCurrentPB{1,36} ';']);
YearPB = MeetBegDate(1:4);


%get SB or CB
databaseCurrent = databaseCurrentSave;

listSeason = get(handles.SelectSeasonProfile_benchmark, 'String');
valSeason = get(handles.SelectSeasonProfile_benchmark, 'Value');
SeasonEC = listSeason{valSeason};
if length(SeasonEC) == 9;
    %Single year selected... SB
    index = strfind(SeasonEC, '-');
    dateini = num2str(str2num(SeasonEC(1:index-1))+1);
    dateend = dateini;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    likeepSeason = [];
    classifierMeetID = databaseCurrent(:,36);
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
    
    seasonLow = BenchmarkEvents{rawini,2};
    seasonHigh = BenchmarkEvents{rawend,3};
    if rawini == 1;
        seasonLowPrev = [];
        seasonHighPrev = [];
    else;
        seasonLowPrev = BenchmarkEvents{rawini-1,2};
        seasonHighPrev = BenchmarkEvents{rawend-1,3};
    end;

    dateini = BenchmarkEvents{rawini,2}; %beginning of season
    index = strfind(dateini, '-');
    dateDiffLow(1) = datetime(str2num(dateini(1:index(1)-1)), str2num(dateini(index(1)+1:index(2)-1)), str2num(dateini(index(2)+1:end)));

    dateend = BenchmarkEvents{rawend,3}; %end of season
    index = strfind(dateend, '-');
    dateDiffHigh(1) = datetime(str2num(dateend(1:index(1)-1)), str2num(dateend(index(1)+1:index(2)-1)), str2num(dateend(index(2)+1:end)));

else;
    index = strfind(lower(SeasonEC), lower('Any'));
    if isempty(index) == 1;
        %Cycle selected... CB
        OGyears = [2016 2021 2024 2028 2032 2036];
        index = strfind(SeasonEC, ' ');
        dateini = SeasonEC(index(1)+1:index(2)-1);
        diffyear = abs(OGyears - (str2num(dateini)-4));

        [minval, minloc] = min(diffyear);
        dateini = num2str(OGyears(minloc));
        dateend = num2str(str2num(SeasonEC(index(1)+1:index(2)-1)));
        
        likeepSeason = [];
        classifierMeetID = databaseCurrent(:,36);
        BenchmarkEvents = handles.BenchmarkEvents;

        seasonMin = BenchmarkEvents{1,1};
        seasonMin = str2num(seasonMin(7:end));
        seasonMax = BenchmarkEvents{end,1};
        seasonMax = str2num(seasonMax(7:end));
        if str2num(dateini) < seasonMin;
            rawini = 1;
        elseif str2num(dateini) > seasonMax;
            rawini = length(BenchmarkEvents(:,2));
        else;
            for i = 1:length(BenchmarkEvents(:,2));
                index = strfind(BenchmarkEvents{i,2}, dateini);
                if isempty(index) == 0;
                    rawini = i;
                end;
            end;
        end;

        if str2num(dateend) < seasonMin;
            rawend = 1;
        elseif str2num(dateend) > seasonMax;
            rawend = length(BenchmarkEvents(:,3));
        else;
            for i = 1:length(BenchmarkEvents(:,3));
                index = strfind(BenchmarkEvents{i,3}, dateend);
                if isempty(index) == 0;
                    rawend = i;
                end;
            end;
        end;

        seasonLow = BenchmarkEvents{rawini,2};
        seasonHigh = BenchmarkEvents{rawend,3};
        seasonLowPrev = BenchmarkEvents{rawini,2};
        seasonHighPrev = BenchmarkEvents{rawend,3};

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
        clear dateDiffLow;
        clear dateDiffHigh;
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

likeepSeason = [];
classifierMeetID = databaseCurrent(:,36);
BenchmarkEvents = handles.BenchmarkEvents;
try;
    index1 = strfind(handles.txtMainProfile_ID{1,7}.String, '(');
    index2 = strfind(handles.txtMainProfile_ID{1,7}.String, ')');
    if length(index1) == 2;
        yearsMeet = handles.txtMainProfile_ID{1,7}.String(index1(2)+1:index2(2)-1);
    end;
catch;
    index1 = [0 0];
    for i = 1:length(BenchmarkEvents(:,1));
        seasonIni = BenchmarkEvents{i,2};
        seasonEnd = BenchmarkEvents{i,3};
        
        index = strfind(seasonIni, '-');
        dateDiffLow(2) = datetime(str2num(seasonIni(1:index(1)-1)), str2num(seasonIni(index(1)+1:index(2)-1)), str2num(seasonIni(index(2)+1:end)));
        dateDiffHigh(2) = datetime(str2num(seasonEnd(1:index(1)-1)), str2num(seasonEnd(index(1)+1:index(2)-1)), str2num(seasonEnd(index(2)+1:end)));
        DLow = split(caldiff(dateDiffLow, 'days'), 'days');
        DHigh = split(caldiff(dateDiffHigh, 'days'), 'days');
        
        if DLow >= 0 & DHigh <= 0;
            likeepSeason = [likeepSeason i];
        end;
    end;
    seasonIni = BenchmarkEvents{likeepSeason(1),2};
    seasonEnd = BenchmarkEvents{likeepSeason(end),3};
    
    yearsMeet = [seasonIni(1:4) '-' seasonEnd(1:4)];
end;


likeepSeason = [];
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

if strcmpi(SearchPerf, 'SB') == 1;
    if isempty(likeepSeason) == 1;
        %No race found for that season: Look for races the season before
        if isempty(seasonLowPrev) == 1;
            txtprep = ['No races found for ' num2str(seasonLow(1:4)) '-' ...
                num2str(seasonHigh(1:4)) '.'];
        else;
            txtprep = ['No races found for ' num2str(seasonLow(1:4)) '-' ...
                num2str(seasonHigh(1:4)) '. Do you wish proceed with ' ...
                num2str(seasonLowPrev(1:4)) '-' num2str(seasonHighPrev(1:4)) ' ?'];
        end;
        seasonLow = seasonLowPrev;
        seasonHigh = seasonHighPrev;
        index = strfind(seasonLow, '-');
        dateDiffLow(1) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
        index = strfind(seasonLow, '-');
        dateDiffHigh(1) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));

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
        if isempty(likeepSeason) == 0;
            if isempty(seasonLowPrev) == 1;
                likeepSeason = [];
            else;
                answer = questdlg(txtprep, 'Season Selection', 'Yes', 'No', 'Yes');
                if strcmpi(answer, 'Yes') ~= 1;
                    likeepSeason = [];
                end;
            end;
        end;
    end;
end;

TimeSB = [];
databaseCurrentSB = [];

if isempty(databaseCurrent) == 0;
    if isempty(likeepSeason) == 1;
        databaseCurrent = [];
    else;
        databaseCurrent = databaseCurrent(likeepSeason,:);
        colACT = 14;
        classifier = databaseCurrent(:,colACT);
        timeEC = [];
        for i = 1:length(databaseCurrent(:,1));
            val = classifier{i,1};
            liSec = strfind(val, ' s');
            if isempty(liSec) == 0;
                timeEC(i,1) = str2num(val(1:5));
            else;
                lidot = strfind(val, ':');
                minu = str2num(val(1:lidot-1)).*60;
                sec = str2num(val(lidot+1:lidot+3));
                hun = str2num(['0.' val(end-1:end)]);
                timeEC(i,1) = minu+sec+hun;
            end;
        end;
        classifier = timeEC;

        [output, index] = sort(classifier, 'ascend');
        databaseCurrentSB = databaseCurrent(index,:);
        databaseCurrentSB = databaseCurrentSB(1,:);
        
        TimeSB = databaseCurrentSB{1,14};
    end;
end;

if strcmpi(SearchPerf, 'PB') == 1;
    databaseCurrent = databaseCurrentPB;
    
elseif strcmpi(SearchPerf, 'SB') == 1 | strcmpi(SearchPerf, 'CB') == 1;
    databaseCurrent = databaseCurrentSB;
%     SearchPerf2 = [databaseCurrent(1,3) databaseCurrent(1,4) '_' databaseCurrent(1,6) '_' databaseCurrent(1,7) databaseCurrent(1,8)];
    
else;
    databaseCurrent = databaseCurrentSave;
    SearchYear = SearchPerf(end-3:end);
    index = strfind(SearchPerf, '_');
    SearchMeet = SearchPerf(index(3)+1:end-4);
    SearchRound = SearchPerf(index(2)+1:index(3)-1);
    index = strfind(SearchRound, '(R.L1)');
    if isempty(index) == 1
        SearchRelay = 'Flat';
    else;
        SearchRound = SearchRound(1:index-1);
        SearchRelay = '(L.1)';
    end;

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
    if isempty(databaseCurrent) == 0;
        likeepRound = [];
        classifier = databaseCurrent(:,6);
        lisearch = strcmpi(lower(classifier), lower(SearchRound));
        likeepRound = find(lisearch == 1);
        if isempty(likeepRound) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRound,:);
        end;
    end;
    if isempty(databaseCurrent) == 0;
        likeepRelay = [];
        classifier = databaseCurrent(:,11);
        lisearch = strcmpi(classifier, 'Flat (L.1)');

        if strcmpi(SearchRelay, 'Flat') == 1;
            %keep only flat race
            likeepRelay = find(lisearch == 0);
        else;
            %keep only relay first leg
            likeepRelay = find(lisearch == 1);
        end;

        if isempty(likeepRelay) == 1;
            databaseCurrent = [];
        else;
            databaseCurrent = databaseCurrent(likeepRelay,:);
        end;
    end;
%     index = strfind(SearchPerf, '_');
%     SearchPerf2 = SearchPerf(index(1)+1:end);
end;

if isempty(databaseCurrent) == 1;
    if ismac == 1;
        errorwindow = errordlg('No entry found for that selection', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('No entry found for that selection', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;
if length(databaseCurrent(:,1)) > 1;
    if ismac == 1;
        errorwindow = errordlg('Multiple entries found for that selection', 'Error');
    elseif ispc == 1;
        errorwindow = errordlg('Multiple entries found for that selection', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    returnval = 1;
    return;
end;


%-----Database for ref group------
if isempty(databaseCurrent) == 0;
    databaseGroup = handles.FullDB(2:end,:);
    %distance
    if isempty(databaseGroup) == 0;
        likeepDistance = [];
        classifier = databaseGroup(:,3);
        SearchDistance = handles.SelectDistanceProfileList_benchmark{valDistance};
        index = strfind(SearchDistance, 'm');
        SearchDistance = SearchDistance(1:end-1);
        lisearch = strcmpi(lower(classifier), lower(SearchDistance));
        likeepDistance = find(lisearch == 1);
        if isempty(likeepDistance) == 1;
            databaseGroup = [];
        else;
            databaseGroup = databaseGroup(likeepDistance,:);
        end;
    end;
    %Stroke
    if isempty(databaseGroup) == 0;
        likeepStroke = [];
        classifier = databaseGroup(:,4);
        SearchStroke = handles.SelectStrokeProfileList_benchmark{valStroke};
        lisearch = strcmpi(lower(classifier), lower(SearchStroke));
        likeepStroke = find(lisearch == 1);
        if isempty(likeepStroke) == 1;
            databaseGroup = [];
        else;
            databaseGroup = databaseGroup(likeepStroke,:);
        end;
    end;
    %Pool type
    if isempty(databaseGroup) == 0;
        likeepPool = [];
        classifier = databaseGroup(:,10);
        SearchPool = handles.SelectPoolProfileList_benchmark(valPool);
        if strcmpi(SearchPool, 'LCM');
            SearchPool = '50';
        elseif strcmpi(SearchPool, 'SCM');
            SearchPool = '25';
        end;
        lisearch = strcmpi(lower(classifier), lower(SearchPool));
        likeepPool = find(lisearch == 1);
        if isempty(likeepPool) == 1;
            databaseGroup = [];
        else;
            databaseGroup = databaseGroup(likeepPool,:);
        end;
    end;
    %Sparta system
    if isempty(databaseGroup) == 0;
        if valSparta > 2;
            classifier = databaseGroup(:,58);
            if valSparta == 3;
                SearchSparta = 3;
            elseif valSparta == 4;
                SearchSparta = 1;
            elseif valSparta == 5;
                SearchSparta = 2;
            end;
    
            likeepSparta = find([classifier{:}] == SearchSparta); %strcmpi(lower(classifier), lower(SearchCountry));
            if isempty(likeepSparta) == 1;
                databaseGroup = [];
            else;
                databaseGroup = databaseGroup(likeepSparta,:);
            end;
        end;
    end;
    %Gender
    if isempty(databaseGroup) == 0;
        likeepGender = [];
        swimmerID = databaseCurrent{1,40};
        index = find(handles.AthletesDB.AMSID == swimmerID);
        findGender = handles.AthletesDB.Gender(index);

        if findGender == 1;
            SearchGender = 'Male';
        elseif findGender == 2;
            SearchGender = 'Female';
        end;
        classifier = databaseGroup(:,5);
        lisearch = strcmpi(lower(classifier), lower(SearchGender));
        likeepGender = find(lisearch == 1);
        if isempty(likeepGender) == 1;
            databaseGroup = [];
        else;
            databaseGroup = databaseGroup(likeepGender,:);
        end;
    end;
    %Race Type
    if isempty(databaseGroup) == 0;
        likeepRaceType = [];
        classifier = databaseGroup(:,11);
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
            databaseGroup = [];
        else;
            databaseGroup = databaseGroup(likeepRaceType,:);
        end;
    end;
    %Category
    SearchCategory = databaseGroup{1,12};
    if isempty(databaseGroup) == 0;
        likeepCategory = [];
        classifier = databaseGroup(:,12);
        lisearch = strcmpi(lower(classifier), lower(SearchCategory));
        likeepCategory = find(lisearch == 1);
        if isempty(likeepCategory) == 1;
            databaseGroup = [];
        else;
            databaseGroup = databaseGroup(likeepCategory,:);
        end;
    end;
    
    %Age
    databaseGroup = databaseGroup;
    likeepAgeGroup = [];
    AgeGroup = handles.AgeGroup; %meet first day dates
    classifierMeetID = databaseGroup(:,36);
    classifierDOB = databaseGroup(:,13);
    likeepAgeGroup = [];
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
        MatAge2(i,1) = AgeYear(1);

        AgeComp = 'Open';
        if get(handles.salRulesProfile_benchmark, 'Value') == 1;
            %First day of the meet to calculate the age
            if handles.selectAgeLimProfile_benchmark == 1;
                if AgeYear(1) < 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '13y & Under';
                elseif AgeYear(1) == 14 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '14y';
                elseif AgeYear(1) == 15 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '15y';
                elseif AgeYear(1) == 16 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '16y';
                elseif AgeYear(1) == 17 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '17y';
                elseif AgeYear(1) == 18 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '18y';
                end;
            elseif handles.selectAgeLimProfile_benchmark == 2;
                if AgeYear(1) < 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '13y & Under';
                elseif AgeYear(1) <= 14 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '14y & Under';
                elseif AgeYear(1) <= 15 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '15y & Under';
                elseif AgeYear(1) <= 16 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '16y & Under';
                elseif AgeYear(1) <= 17 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '17y & Under';
                elseif AgeYear(1) <= 18 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '18y & Under';
                end;
            end;
        else;
            %End of year rule
            index = strfind(MeetBegDate, '-');
            dateDiff(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), 12, 31);
            D = caldiff(dateDiff, {'years','months','days'});
            AgeYear = [];
            [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});

            if handles.selectAgeLimProfile_benchmark == 1;
                if AgeYear(1) == 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '14y';
                elseif AgeYear(1) == 15 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '15y';
                elseif AgeYear(1) == 16 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '16y';
                elseif AgeYear(1) == 17 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '17y';
                elseif AgeYear(1) == 18 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '18y';
                elseif AgeYear(1) == 19 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '19y';
                end;
            elseif handles.selectAgeLimProfile_benchmark == 2;
                if AgeYear(1) == 14 & valAge == 8;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '14y';
                elseif AgeYear(1) <= 15 & valAge == 7;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '15y & Under';
                elseif AgeYear(1) <= 16 & valAge == 6;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '16y & Under';
                elseif AgeYear(1) <= 17 & valAge == 5;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '17y & Under';
                elseif AgeYear(1) <= 18 & valAge == 4;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '18y & Under';
                elseif AgeYear(1) <= 19 & valAge == 3;
                    likeepAgeGroup = [likeepAgeGroup i];
                    AgeComp = '19y & Under';
                end;
            end;
        end;
    end;
    if isempty(databaseGroup) == 0;
        if valAge > 2;
            if isempty(likeepAgeGroup) == 1;
                databaseGroup = [];
            else;
                databaseGroup = databaseGroup(likeepAgeGroup,:);
                MatAge = MatAge(likeepAgeGroup, 1);
            end;
        end;
    end;

    %Country
    if valCountry > 2;
        if isempty(databaseGroup) == 0;
            likeepCountry = [];
            classifier = databaseGroup(:,35);
            if valCountry == 3;
                SearchCountry = 'AUS';
            elseif valCountry == 4;
                SearchCountry = 'INTER';
            end;
            lisearch = strcmpi(lower(classifier), lower(SearchCountry));
            likeepCountry = find(lisearch == 1);
            if isempty(likeepCountry) == 1;
                databaseGroup = [];
            else;
                databaseGroup = databaseGroup(likeepCountry,:);
                MatAge = MatAge(likeepCountry, 1);
            end;
        end;
    end;

    %Season
    if valSeason > 2;
        
        SearchSeason = handles.SelectSeasonProfileList_benchmark{valSeason};
        index1 = strfind(SearchSeason, 'Paris');
        index2 = strfind(SearchSeason, 'Tokyo');
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
            
            date2024 = BenchmarkEvents{5,3}; %end of 2024
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
        if proceedsearch == 1;
            %Single Season
            index = strfind(SearchSeason, '-');
            dateini = SearchSeason(1:index-1);
            for i = 1:length(BenchmarkEvents(:,1));
                index = strfind(BenchmarkEvents{i,2}, dateini);
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
            classifierMeetID = databaseGroup(:,36);
            for i = 1:length(databaseGroup(:,1));
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
                databaseGroup = [];
            else;
                databaseGroup = databaseGroup(likeepSeason,:);
                MatAge = MatAge(likeepSeason, 1);
            end;
        else;
            databaseGroup = [];
        end;
    end;
    
    %Country
    if valSimilarity == 3;
        if isempty(databaseGroup) == 0;
            groupsize = 10;
            if length(databaseGroup(:,1)) > groupsize;
                likeepSimilarity = [];
                
                classifierName = databaseGroup(:,2);
                SearchName = handles.AthleteNamesListDispProfile(valAthlete);
                if strcmpi(SearchName, 'Athlete Name') ~= 1;
                    lisearch = strfind(lower(classifierName), lower(SearchName));
                    likeepName = find(cellfun('isempty', lisearch));
                    if isempty(likeepName) == 1;
                        databaseGroup = [];
                    else;
                        databaseGroup = databaseGroup(likeepName,:);
                    end;
                else;
                    databaseGroup = [];
                end;
                databaseGroup2 = databaseGroup;
                
                %skill time(15), start time(22), Start BOdist(25), 
                %turn time(27), Turn BOdist(29), Av SI(31), Av Vel(32), Av SR(33),
                %Av DPS(34), Speed Decay(43)
                colInterest = [15 22 25 27 29 31 32 33 34 43];
                classifier = databaseGroup;
                classifierCONV = [];
                for col = 1:length(colInterest);
                    colEC = colInterest(col);
                    for k = 1:length(classifier(:,1));
                        if colEC == 14;
                            val = classifier{k,colEC};
                            liSec = strfind(val, ' s');
                            if isempty(liSec) == 0;
                                timeEC(k,1) = str2num(val(1:5));
                            else;
                                lidot = strfind(val, ':');
                                minu = str2num(val(1:lidot-1)).*60;
                                sec = str2num(val(lidot+1:lidot+3));
                                hun = str2num(['0.' val(end-1:end)]);
                                timeEC(k,1) = minu+sec+hun;
                            end;
                            
                        elseif colEC == 15;
                            val = classifier{k,colEC};
                            index = strfind(val, 's');
                            if isempty(index) == 0;
                                timeEC(k,1) = str2num(val(1:index-2));
                            else;
                                index = strfind(val, ':');
                                valsec = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                                timeEC(k,1) = valsec;
                            end;
                            
                        elseif colEC == 22 | colEC == 25 | colEC == 27 | colEC == 29 | colEC == 31 | colEC == 32 | colEC == 33 | colEC == 34;
                            val = classifier{k,colEC};
                            timeEC(k,1) = str2num(val);
                           
                        elseif colEC == 43;
                            timeEC(k,1) = classifier{k,colEC};
                            
                        end;
                    end;
                    classifierCONV(:,col) = timeEC;
                end;
                
                currentCONV = [];
                for col = 1:length(colInterest);
                    colEC = colInterest(col);
                    if colEC == 14;
                        val = databaseCurrent{1,colEC};
                        liSec = strfind(val, ' s');
                        if isempty(liSec) == 0;
                            timeEC = str2num(val(1:5));
                        else;
                            lidot = strfind(val, ':');
                            minu = str2num(val(1:lidot-1)).*60;
                            sec = str2num(val(lidot+1:lidot+3));
                            hun = str2num(['0.' val(end-1:end)]);
                            timeEC = minu+sec+hun;
                        end;
                        currentCONV(1,col) = timeEC;
                    elseif colEC == 15;
                        val = databaseCurrent{1,colEC};
                        index = strfind(val, 's');
                        if isempty(index) == 0;
                            timeEC = str2num(val(1:index-2));
                        else;
                            index = strfind(val, ':');
                            valsec = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                            timeEC = valsec;
                        end;
                        currentCONV(1,col) = timeEC;
                    elseif colEC == 22 | colEC == 25 | colEC == 27 | colEC == 29 | colEC == 31 | colEC == 32 | colEC == 33 | colEC == 34;
                        val = databaseCurrent{1,colEC};
                        currentCONV(1,col) = str2num(val);
                    elseif colEC == 43;
                        currentCONV(1,col) = databaseCurrent{1,colEC};
                    end;
                end;
                
                Mdl = KDTreeSearcher(classifierCONV);
                [likeepSimilarity, d] = knnsearch(Mdl, currentCONV, 'k', groupsize);
            end;
            if isempty(likeepSimilarity) == 1;
                databaseGroup = [];
            else;
                databaseGroup = databaseGroup(likeepSimilarity,:);
                if valPB == 2;
                    proceed = 1;
                    iter = 1;
                    while proceed == 1;
                        classifier = databaseGroup(:,14);
                        classifierName = databaseGroup(:,2);
                        colsource = 'RaceTime';
                        [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                        databaseGroup = databaseGroup(likeepPBs,:);
                        
                        if length(databaseGroup(:,1)) < groupsize;
                            inc = groupsize - length(databaseGroup(:,1));
                            [likeepSimilarity, d] = knnsearch(Mdl, currentCONV, 'k', groupsize+inc);
                            databaseGroup = databaseGroup2(likeepSimilarity,:);
                        end;
                        
                        if length(databaseGroup(:,1)) == groupsize;
                            proceed = 0;
                        end;
                        if iter == 10;
                            proceed = 0;
                        else;
                            iter = iter + 1;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if strcmpi(sourceSort, 'select') == 1;
        databaseSelect = handles.FullDB(2:end,:);
        if isempty(databaseSelect) == 0;
            classifier = databaseSelect(:,2);
            if strcmpi(databaseSelect, 'Athlete Name') ~= 1;
                lisearch = strfind(lower(classifier), lower(SearchNameSelect));
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
            lisearch = strcmpi(lower(classifier), lower(SearchDistanceSelect));
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
            lisearch = strcmpi(lower(classifier), lower(SearchStrokeSelect));
            likeepStroke = find(lisearch == 1);
            if isempty(likeepStroke) == 1;
                databaseSelect = [];
            else;
                databaseSelect = databaseSelect(likeepStroke,:);
            end;
        end;
        %Pool type
        if isempty(databaseSelect) == 0;
            likeepPool = [];
            classifier = databaseSelect(:,10);
            lisearch = strcmpi(lower(classifier), lower(SearchPoolSelect));
            likeepPool = find(lisearch == 1);
            if isempty(likeepPool) == 1;
                databaseSelect = [];
            else;
                databaseSelect = databaseSelect(likeepPool,:);
            end;
        end;
        %Sparta system
        if isempty(databaseSelect) == 0;
            if valSparta > 2;
                classifier = databaseSelect(:,58);
                if valSparta == 3;
                    SearchSparta = 3;
                elseif valSparta == 4;
                    SearchSparta = 1;
                elseif valSparta == 5;
                    SearchSparta = 2;
                end;
        
                likeepSparta = find([classifier{:}] == SearchSparta); %strcmpi(lower(classifier), lower(SearchCountry));
                if isempty(likeepSparta) == 1;
                    databaseSelect = [];
                else;
                    databaseSelect = databaseSelect(likeepSparta,:);
                end;
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
        TimeSelectPB = [];
        YearSelectPB = [];
        classifier = databaseSelect(:,colACT);
        timeEC = [];
        for i = 1:length(databaseSelect(:,1));
            val = classifier{i,1};
            liSec = strfind(val, ' s');
            if isempty(liSec) == 0;
                timeEC(i,1) = str2num(val(1:5));
            else;
                lidot = strfind(val, ':');
                minu = str2num(val(1:lidot-1)).*60;
                sec = str2num(val(lidot+1:lidot+3));
                hun = str2num(['0.' val(end-1:end)]);
                timeEC(i,1) = minu+sec+hun;
            end;
        end;
        classifier = timeEC;

        [output, index] = sort(classifier, 'ascend');
        databaseSelectPB = databaseSelect(index,:);
        databaseSelectPB = databaseSelectPB(1,:);
        TimeSelectPB = databaseSelectPB{1,14};
        eval(['MeetBegDate = handles.AgeGroup.' databaseSelectPB{1,36} ';']);
        YearSelectPB = MeetBegDate(1:4);

        
        %get SB
        databaseSelect = databaseSelectSave;
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
        clear dateDiffLow;
        clear dateDiffHigh;
        seasonLow = BenchmarkEvents{likeepSeason,2};
        seasonHigh = BenchmarkEvents{likeepSeason,3};

        seasonLowPrev = BenchmarkEvents{likeepSeason-1,2};
        seasonHighPrev = BenchmarkEvents{likeepSeason-1,3};
        index = strfind(seasonLow, '-');
        dateDiffLow(1) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
        index = strfind(seasonLow, '-');
        dateDiffHigh(1) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));

        likeepSeason = [];
        classifierMeetID = databaseGroup(:,36);
        for i = 1:length(databaseGroup(:,1));
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
        
        if strcmpi(SearchPerfSelect, 'SB') == 1;
            if isempty(likeepSeason) == 1;
                %No race found for that season: Look for races the season before
                txtprep = ['No races found for ' num2str(seasonLow(1:4)) '-' ...
                    num2str(seasonHigh(1:4)) '. Do you wish proceed with ' ...
                    num2str(seasonLowPrev(1:4)) '-' num2str(seasonHighPrev(1:4)) ' ?'];
                seasonLow = seasonLowPrev;
                seasonHigh = seasonHighPrev;
                index = strfind(seasonLow, '-');
                dateDiffLow(1) = datetime(str2num(seasonLow(1:index(1)-1)), str2num(seasonLow(index(1)+1:index(2)-1)), str2num(seasonLow(index(2)+1:end)));
                index = strfind(seasonLow, '-');
                dateDiffHigh(1) = datetime(str2num(seasonHigh(1:index(1)-1)), str2num(seasonHigh(index(1)+1:index(2)-1)), str2num(seasonHigh(index(2)+1:end)));

                likeepSeason = [];
                classifierMeetID = databaseGroup(:,36);
                for i = 1:length(databaseGroup(:,1));
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
                if isempty(likeepSeason) == 0;
                    answer = questdlg(txtprep, 'Season Selection', 'Yes', 'No', 'Yes');
                    if strcmpi(answer, 'Yes') ~= 1;
                        likeepSeason = [];
                    end;
                end;
            end;
        end;

        TimeSelectSB = [];
        databaseSelectSB = [];
        if isempty(databaseSelect) == 0;
            if isempty(likeepSeason) == 1;
                databaseSelect = [];
            else;
                databaseSelect = databaseSelect(likeepSeason,:);

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
                        minu = str2num(val(1:lidot-1)).*60;
                        sec = str2num(val(lidot+1:lidot+3));
                        hun = str2num(['0.' val(end-1:end)]);
                        timeEC(i,1) = minu+sec+hun;
                    end;
                end;
                classifier = timeEC;

                [output, index] = sort(classifier, 'ascend');
                databaseSelectSB = databaseSelect(index,:);
                databaseSelectSB = databaseSelectSB(1,:);

                TimeSelectSB = databaseSelectSB{1,14};
            end;
        end;
        
        if strcmpi(SearchPerfSelect, 'PB') == 1;
            databaseSelect = databaseSelectPB;

        elseif strcmpi(SearchPerfSelect, 'SB') == 1;
            databaseSelect = databaseSelectSB;
        %     SearchPerf2 = [databaseGroup(1,3) databaseGroup(1,4) '_' databaseGroup(1,6) '_' databaseGroup(1,7) databaseGroup(1,8)];

        else;

            databaseSelect = databaseSelectSave;
            index = strfind(SearchPerfSelect, '_'); 
            part1 = SearchPerfSelect(index(1)+1:index(2)-1);
            if strcmpi(part1(1:4), '1500') == 1;
                SearchDistSelect = part1(1:4);
                SearchStrokeSelect = part1(5:end);
            else;
                SearchDistSelect = part1(1:3);
                SearchStrokeSelect = part1(4:end);
            end;
            SearchRoundSelect = SearchPerfSelect(index(2)+1:index(3)-1);
            part2 = SearchPerfSelect(index(3)+1:end);
            SearchMeetSelect = part2(1:end-4);
            SearchYearSelect = part2(end-3:end);

            SearchYearSelect = SearchPerfSelect(end-3:end);
            index = strfind(SearchPerfSelect, '_');
            SearchMeetSelect = SearchPerfSelect(index(3)+1:end-4);
            SearchRoundSelect = SearchPerfSelect(index(2)+1:index(3)-1);
            index = strfind(SearchRoundSelect, '(R.L1)');
            if isempty(index) == 1;
                SearchRelaySelect = 'Flat';
            else;
                SearchRoundSelect = SearchRoundSelect(1:index-1);
                SearchRelaySelect = '(L.1)';
            end;

            if isempty(databaseSelect) == 0;
                likeepYear = [];
                classifier = databaseSelect(:,8);
                lisearch = strcmpi(lower(classifier), lower(SearchYearSelect));
                likeepYear = find(lisearch == 1);
                if isempty(likeepYear) == 1;
                    databaseSelect = [];
                else;
                    databaseSelect = databaseSelect(likeepYear,:);
                end;
            end;

            if isempty(databaseSelect) == 0;
                likeepMeet = [];
                classifier = databaseSelect(:,7);
                lisearch = strcmpi(lower(classifier), lower(SearchMeetSelect));
                likeepMeet = find(lisearch == 1);
                if isempty(likeepMeet) == 1;
                    databaseSelect = [];
                else;
                    databaseSelect = databaseSelect(likeepMeet,:);
                end;
            end;

            if isempty(databaseSelect) == 0;
                likeepRound = [];
                classifier = databaseSelect(:,6);
                lisearch = strcmpi(lower(classifier), lower(SearchRoundSelect));
                likeepRound = find(lisearch == 1);
                if isempty(likeepRound) == 1;
                    databaseSelect = [];
                else;
                    databaseSelect = databaseSelect(likeepRound,:);
                end;
            end;

            if isempty(databaseSelect) == 0;
                likeepRelay = [];
                classifier = databaseSelect(:,11);
                lisearch = strcmpi(classifier, 'Flat (L.1)');
                if strcmpi(SearchRelaySelect, 'Flat') == 1;
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
                end;
            end;
        end;
        if isempty(databaseSelect(:,1)) == 1;
            if ismac == 1;
                errorwindow = errordlg('No benchmark races found for that selection', 'Error');
            elseif ispc == 1;
                errorwindow = errordlg('No benchmark races found for that selection', 'Error');
                jFrame = get(handle(errorwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
            returnval = 1;
            return;
        end;
    end;

    if isempty(databaseGroup) == 1;
        if ismac == 1;
            errorwindow = errordlg('No benchmark races found for that selection', 'Error');
        elseif ispc == 1;
            errorwindow = errordlg('No benchmark races found for that selection', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        returnval = 1;
        return;
    end;
else;
    returnval = 1;
end;
    
% else;
%     
% end;

