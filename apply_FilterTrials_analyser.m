titles = FullDB(1,:);
database = FullDB(2:end,:);

if ismac == 1;
    load /Applications/SP2Viewer/SP2viewerDB.mat;
    
elseif ispc == 1;
    MDIR = getenv('USERPROFILE');
    load([MDIR '\SP2Viewer\SP2viewerDB.mat']);
end;


%Find raws for 'Meet' (col 7)
likeepMeet = [];
if isempty(handles2.SearchMeet) == 0 & isempty(database) == 0;
    classifier = database(:,7);
    
    if iscell(handles2.SearchMeet) == 1;
        for i = 1:length(handles2.SearchMeet);
            SearchMeet = handles2.SearchMeet{i};
            lisearch = strfind(lower(classifier), lower(SearchMeet));
            likeepMeet = [likeepMeet; find(~cellfun('isempty', lisearch))];
        end;
    else;
        SearchMeet = handles2.SearchMeet;
        lisearch = strfind(lower(classifier), lower(SearchMeet));
        likeepMeet = [likeepMeet; find(~cellfun('isempty', lisearch))];
    end;
    if isempty(likeepMeet) == 1;
        database = [];
    else;
        database = database(likeepMeet,:);
    end;
end;

%Find raws for 'Year' (col 8)
likeepYear = [];
if isempty(handles2.SearchYear) == 0 & isempty(database) == 0;
    classifier = database(:,8);
    
    if length(handles2.SearchYear) > 1;
        for i = 1:length(handles2.SearchYear);
            handles2.SearchYear2{i} = num2str(handles2.SearchYear(i));
        end;
        handles2.SearchYear = handles2.SearchYear2;
    end;
    
    if iscell(handles2.SearchYear) == 1;
        for i = 1:length(handles2.SearchYear);
            SearchYear = num2str(handles2.SearchYear{i});
            lisearch = strfind(lower(classifier), lower(SearchYear));
            likeepYear = [likeepYear; find(~cellfun('isempty', lisearch))];
        end;
    else;
        SearchYear = num2str(handles2.SearchYear);
        lisearch = strfind(lower(classifier), lower(SearchYear));
        likeepYear = [likeepYear; find(~cellfun('isempty', lisearch))];
    end;
    if isempty(likeepYear) == 1;
        database = [];
    else;
        database = database(likeepYear,:);
    end;
end;

%Find raws for 'Name' (col 2)
likeepName = [];
if isempty(handles2.SearchName) == 0 & isempty(database) == 0;
    classifier = database(:,2);
    
    if iscell(handles2.SearchName) == 1;
        for i = 1:length(handles2.SearchName);
            SearchName = handles2.SearchName{i};
            lisearch = strfind(lower(classifier), lower(SearchName));
            likeepName = [likeepName; find(~cellfun('isempty', lisearch))];
        end;
    else;
        SearchName = handles2.SearchName;
        lisearch = strfind(lower(classifier), lower(SearchName));
        likeepName = [likeepName; find(~cellfun('isempty', lisearch))];
    end;
    if isempty(likeepName) == 1;
        database = [];
    else;
        database = database(likeepName,:);
    end;
end;

%Find raws for 'Gender' (col 5)
likeepGender = [];
if isempty(handles2.SearchGender) == 0 & isempty(database) == 0;
    classifier = database(:,5);
    SearchGender = handles2.listpopGender{handles2.SearchGender};
    
    lisearch = strcmpi(lower(classifier), lower(SearchGender));
    likeepGender = find(lisearch == 1);
    if isempty(likeepGender) == 1;
        database = [];
    else;
        database = database(likeepGender,:);
    end;
end;

%Find raws for 'SwimType' (col 6)
likeepSwimType = [];
if isempty(handles2.SearchSwimType) == 0 & isempty(database) == 0;
    classifier = database(:,6);
    SearchSwimType = handles2.listpopType{handles2.SearchSwimType};
    
    lisearch = strcmpi(lower(classifier), lower(SearchSwimType));
    likeepSwimType = find(lisearch == 1);
    if isempty(likeepSwimType) == 1;
        database = [];
    else;
        database = database(likeepSwimType,:);
    end;
end;

%Find raws for 'StrokeType' (col 4)
likeepStrokeType = [];
if isempty(handles2.SearchStrokeType) == 0 & isempty(database) == 0;
    classifier = database(:,4);
    SearchStrokeType = handles2.listpopStroke{handles2.SearchStrokeType};
    
    lisearch = strcmpi(lower(classifier), lower(SearchStrokeType));
    likeepStrokeType = find(lisearch == 1);
    if isempty(likeepStrokeType) == 1;
        database = [];
    else;
        database = database(likeepStrokeType,:);
    end;
end;

%Find raws for 'Distance' (col 3)
likeepDistance = [];
if isempty(handles2.SearchDistance) == 0 & isempty(database) == 0;
    classifier = database(:,3);
    SearchDistance = handles2.listpopDistance{handles2.SearchDistance};
    SearchDistance = SearchDistance(1:end-1);
    
    lisearch = strcmpi(lower(classifier), lower(SearchDistance));
    likeepDistance = find(lisearch == 1);
    if isempty(likeepDistance) == 1;
        database = [];
    else;
        database = database(likeepDistance,:);
    end;
end;

%Find raws for 'PoolType' (col 10)
likeepPoolType = [];
if isempty(handles2.SearchPoolType) == 0 & isempty(database) == 0;
    classifier = database(:,10);
    SearchPoolType = handles2.listpopPool{handles2.SearchPoolType};
    if strcmpi(SearchPoolType, 'SCM');
        SearchPoolType = '25';
    else;
        SearchPoolType = '50';
    end;
    
    lisearch = strcmpi(lower(classifier), lower(SearchPoolType));
    likeepPoolType = find(lisearch == 1);
    if isempty(likeepPoolType) == 1;
        database = [];
    else;
        database = database(likeepPoolType,:);
    end;
end;

%Find raws for 'Category' (col 12)
likeepCategory = [];
if isempty(handles2.SearchCategory) == 0 & isempty(database) == 0;
    classifier = database(:,12);
    SearchCategory = handles2.listpopGroup{handles2.SearchCategory};
    
    lisearch = strcmpi(lower(classifier), lower(SearchCategory));
    likeepCategory = find(lisearch == 1);
    if isempty(likeepCategory) == 1;
        database = [];
    else;
        database = database(likeepCategory,:);
    end;
end;

%Find raws for 'RaceType' (col 11)
likeepRaceType = [];
if isempty(handles2.SearchRaceType) == 0 & isempty(database) == 0;
    classifier = database(:,11);
    SearchRaceType = handles2.listpopRelay{handles2.SearchRaceType};
    
    lisearch = strcmpi(lower(classifier), lower(SearchRaceType));
    likeepRaceType = find(lisearch == 1);
    if isempty(likeepRaceType) == 1;
        database = [];
    else;
        database = database(likeepRaceType,:);
    end;
end;

%Find raws for 'AgeGroup' (col 13)
likeepAgeGroup = [];
if isempty(handles2.SearchAgeGroup) == 0 & isempty(database) == 0;
    if handles2.SearchAgeGroup > 2;
        classifierMeetID = database(:,36);
        classifierDOB = database(:,13);
        
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

            if AgeYear(1) < 14 & handles2.SearchAgeGroup == 7;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 14 & handles2.SearchAgeGroup == 6;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 15 & handles2.SearchAgeGroup == 5;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 16 & handles2.SearchAgeGroup == 4;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 17 & handles2.SearchAgeGroup == 3;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 18 & handles2.SearchAgeGroup == 2;
                likeepAgeGroup = [likeepAgeGroup i];
            end;
        end;
        if isempty(likeepAgeGroup) == 1;
            database = [];
        else;
            database = database(likeepAgeGroup,:);
        end;
    end;
end;



%PBs filter
likeepPBs = [];
if isempty(handles2.SearchPB) == 0 & isempty(database) == 0;
    rankColPB = 1;
    
    for i = 1:length(database(:,1));
        li = find(strcmpi(uidDB(:,1), database{i,1}));
        athleteUID = uidDB{li,15};
        CurentDist = str2num(uidDB{li,4});
        CurrentStroke = uidDB{li,5};
        
        if strcmpi(CurrentStroke, 'Butterfly');
            if CurentDist == 50;
                target = 1;
            elseif CurentDist == 100;
                target = 2;
            elseif CurentDist == 200;
                target = 3;
            end;
        elseif strcmpi(CurrentStroke, 'Backstroke');
            if CurentDist == 50;
                target = 4;
            elseif CurentDist == 100;
                target = 5;
            elseif CurentDist == 200;
                target = 6;
            end;
        elseif strcmpi(CurrentStroke, 'Breaststroke');
            if CurentDist == 50;
                target = 7;
            elseif CurentDist == 100;
                target = 8;
            elseif CurentDist == 200;
                target = 9;
            end;
        elseif strcmpi(CurrentStroke, 'Freestyle');
            if CurentDist == 50;
                target = 10;
            elseif CurentDist == 100;
                target = 11;
            elseif CurentDist == 200;
                target = 12;
            elseif CurentDist == 400;
                target = 13;
            elseif CurentDist == 800;
                target = 14;
            elseif CurentDist == 1500;
                target = 15;
            end;
        elseif strcmpi(CurrentStroke, 'Medley');
            if CurentDist == 100;
                target = 16;
            elseif CurentDist == 150;
                target = 17;
            elseif CurentDist == 200;
                target = 18;
            elseif CurentDist == 400;
                target = 19;
            end;
        end;

        likeepPoolType = [];
        if isempty(likeepPoolType) == 0
            if str2num(SearchPoolType) == 25;
                eval(['PB = PBsDB_SC.A' num2str(athleteUID) 'A(' num2str(target) ',' num2str(rankColPB) ');']);
            else;
                eval(['PB = PBsDB.A' num2str(athleteUID) 'A(' num2str(target) ',' num2str(rankColPB) ');']);
            end;
        else;
            eval(['PB = PBsDB.A' num2str(athleteUID) 'A(' num2str(target) ',' num2str(rankColPB) ');']);
        end;
        
        %rank by race time
        rankColVAL = 14;
        VAL = database{i,rankColVAL};
        li = strfind(VAL, 's');
        if isempty(li) == 1;
            li2 = strfind(VAL, ':');
            min = str2num(VAL(1:li2-1)).*60;
            sec = str2num(VAL(li2+1:end));
            VAL = min+sec;
        else;
            VAL = str2num(VAL(1:end-1));
        end;
        
        if PB == VAL;
            %I keep the race
            likeepPBs = [likeepPBs i];
        end;
    end;
    if isempty(likeepPBs) == 1;
        database = [];
    else;
        database = database(likeepPBs,:);
    end;
end;
