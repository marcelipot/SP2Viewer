
if handles.existProfile == 1;
    databaseCurrent = handles.databaseCurrent_Profile;

    answerReport = 'SP1';

    RaceDist = str2num(databaseCurrent{1,3});
    Course = str2num(databaseCurrent{1,10});
    Gender = databaseCurrent{1,5};
    StrokeType = databaseCurrent{1,4};
    Stage = databaseCurrent{1,6};
    metadata = databaseCurrent{1,67};
    Venue = metadata{3,1};

    if strcmpi(lower(StrokeType), 'freestyle');
        StrokeShort = 'FS';
    elseif strcmpi(lower(StrokeType), 'medley');
        StrokeShort = 'IM';
    elseif strcmpi(lower(StrokeType), 'backstroke');
        StrokeShort = 'BK';
    elseif strcmpi(lower(StrokeType), 'breaststroke');
        StrokeShort = 'BR';
    elseif strcmpi(lower(StrokeType), 'butterfly');
        StrokeShort = 'BF';
    end;

    handles2.sourceReport = 'Ind';

    Athletename = databaseCurrent{1,2};
    RaceDist = str2num(databaseCurrent{1,3});
    Meet = databaseCurrent{1,7};
    Year = databaseCurrent{1,8};
    Course = str2num(databaseCurrent{1,10});
    RaceDate = databaseCurrent{1,57};
    AnalysisDate = databaseCurrent{1,58};
    AgeGroup = databaseCurrent{1,13};
    Source = databaseCurrent{1,58};

    idx = isstrprop(Meet,'upper');
    MeetShort = Meet(idx);
    if strcmpi(Stage, 'SemiFinal');
        StageShort = 'SF';
    elseif strcmpi(Stage, 'Semi-final');
        StageShort = 'SF';
    else;
        StageShort = Stage;
    end;
    if strcmpi(lower(StrokeType), 'freestyle');
        StrokeShort = 'FS';
    elseif strcmpi(lower(StrokeType), 'medley');
        StrokeShort = 'IM';
    elseif strcmpi(lower(StrokeType), 'backstroke');
        StrokeShort = 'BK';
    elseif strcmpi(lower(StrokeType), 'breaststroke');
        StrokeShort = 'BR';
    elseif strcmpi(lower(StrokeType), 'butterfly');
        StrokeShort = 'BF';
    end;
        
    filename = [Athletename '_' num2str(RaceDist) StrokeShort '_' MeetShort Year '_' StageShort '_Sparta'];
    
    if Course == 25;
        Race = [num2str(RaceDist) 'm ' StrokeType ' (SCM)'];
    else;
        Race = [num2str(RaceDist) 'm ' StrokeType ' (LCM)'];
    end;
    
    index = strfind(AgeGroup, '/');

    dateDiff(1) = datetime(str2num(AgeGroup(index(2)+1:end)), str2num(AgeGroup(index(1)+1:index(2)-1)), str2num(AgeGroup(1:index(1)-1)));
    index = strfind(RaceDate, '-');

    if Source == 1 | Source == 3;
        dateDiff(2) = datetime(str2num(RaceDate(1:index(1)-1)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(index(2)+1:end)));
    elseif Source == 2;
        dateDiff(2) = datetime(str2num(RaceDate(1:index(1)-1)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(index(2)+1:end)));
    end;
    [DYear, DMonth, DDay] = split(caldiff(dateDiff, {'years';'months';'days'}), {'years';'months';'days'});

    if DYear <= 18 & DYear > 17;
        AgeGroup = '18y';
    elseif DYear <= 17 & DYear > 16;
        AgeGroup = '17y';
    elseif DYear <= 16 & DYear > 15;
        AgeGroup = '16y';
    elseif DYear <= 15 & DYear > 14;
        AgeGroup = '15y';
    elseif DYear <= 14 & DYear > 13;
        AgeGroup = '14y';
    elseif DYear <= 13;
        AgeGroup = '13y & under';
    else;
        AgeGroup = 'Open';
    end;

    Round = [AgeGroup ' - ' Stage];

    li1 = strfind(AnalysisDate, 'T');
    li2 = strfind(AnalysisDate, '.');
    AnalysisDate = [AnalysisDate(1:li1-1) '  ' AnalysisDate(li1+1:li2-1)];
    AnalysisDate = ['Swim created at ' AnalysisDate];
    
    t = now;
    ReportDate = ['Report last generated at ' datestr(datetime(t,'ConvertFrom','datenum'))];
    
    source = 'display';
    if Course == 25;
        if RaceDist == 50;
            create_SP1report_SCM50_benchmark;
        elseif RaceDist == 100;
            create_SP1report_SCM100_benchmark;
        elseif RaceDist == 150;
            create_SP1report_SCM150_benchmark;
        elseif RaceDist == 200;
            create_SP1report_SCM200_benchmark;
        elseif RaceDist == 400;
            create_SP1report_SCM400_benchmark;
        elseif RaceDist == 800;
            create_SP1report_SCM800_benchmark;
        elseif RaceDist == 1500;
            create_SP1report_SCM1500_benchmark;
        end;
    else;
        if RaceDist == 50;
            create_SP1report_LCM50_benchmark;
        elseif RaceDist == 100;
            create_SP1report_LCM100_benchmark;
        elseif RaceDist == 150;
            create_SP1report_LCM150_benchmark;
        elseif RaceDist == 200;
            create_SP1report_LCM200_benchmark;
        elseif RaceDist == 400;
            create_SP1report_LCM400_benchmark;
        elseif RaceDist == 800;
            create_SP1report_LCM800_benchmark;
        elseif RaceDist == 1500;
            create_SP1report_LCM1500_benchmark;
        end;
    end;

    guidata(handles2.hdef, handles2);


else;
    return;
end;
handles.filelistAdded = [];
% 
% set(Fig, 'units', 'normalized');
% Fig.Visible = 'off';
% Fig.InvertHardcopy = 'off';
% if ispc == 1;
%     if isfile([pathname '\' filename]) == 1;
%         MDIR = getenv('USERPROFILE');
%         command = ['del /Q /S ' pathname '\' filename];
%         [status, cmdout] = system(command);
%     end;
%     saveas(Fig, [pathname '\' filename]);
% elseif ismac == 1;
%     if isfile([pathname '/' filename]) == 1;
%         command = ['rm -rf ' pathname '/' filename];
%         [status, cmdout] = system(command);
%     end;
%     saveas(Fig, [pathname '/' filename]);
% end;
% clear_figures;
