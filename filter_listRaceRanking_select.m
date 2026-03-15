strAthlete = get(handles2.SearchAthleteProfile_select, 'String');
selvalAthlete = get(handles2.SelectAthleteProfile_select, 'Value');
selstrAthlete = get(handles2.SelectAthleteProfile_select, 'String');
valName = 0;

if isempty(strAthlete) == 1;
    %no name search
    %swimmer selected
    valName = 1;
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

    SearchName = handles2.source{selvalAthlete+1,1};
    SearchDistance = handles2.Distance;
    SearchStroke = handles2.Stroke;
    SearchPool = handles2.Pool;
    SearchSparta = handles2.Sparta;
    SeasonEC = handles2.SeasonEC;
    BenchmarkEvents = handles2.BenchmarkEvents;
    AgeGroup = handles2.AgeGroup;
    FullDB = handles2.FullDB;
    source = handles2.source;
    filter_listRace_ranking;
    
else;
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
    set(handles2.SelectPerfProfile_select, 'String', handles2.SelectPerfProfileList_select, 'value', 1);
end;

