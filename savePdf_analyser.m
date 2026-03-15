function [] = saveDisplay_analyser(varargin);


handles = guidata(gcf);


if isempty(handles.filelistAdded) == 1;
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(handles, 'RacesDB') == 0;
    herror = errordlg('Update data display', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(herror);
    return;
end;

if handles.updatedfiles == 1;
    herror = errordlg('Update data display', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame=get(handle(herror), 'javaframe');
        jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(herror);
    return;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
databaseCurrent = handles.databaseCurrent_analyser;

% RaceUID = [];
% for raceEC = 1:nbRaces;
%     fileEC = handles.filelistAdded{raceEC};
%     proceed = 1;
%     iter = 1;
%     while proceed == 1;
%         raceCHECK = handles.uidDB{iter,2};
%         if strcmpi(fileEC, raceCHECK) == 1;
%             RaceUID{raceEC} = handles.uidDB{iter,1};
%             proceed = 0;
%         else;
%             iter = iter + 1;
%         end;
%     end;
% end;
% UID = RaceUID{1};
% li = findstr(UID, '-');
% UID(li) = '_';
% UID = ['A' UID 'A'];
% eval(['Course = handles.RacesDB.' UID '.Course;']);  
% eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
% origin = 'graph';

if nbRaces == 1;
    
    handles2.sourceReport = 'Ind';
%     eval(['AthletenameFull = handles.RacesDB.' UID '.AthletenameFull;']);
%     eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
%     eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
%     eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
%     eval(['Course = handles.RacesDB.' UID '.Course;']);
%     eval(['AgeGroup = handles.RacesDB.' UID '.DOB;']);
%     eval(['Meet = handles.RacesDB.' UID '.Meet;']);
%     eval(['Year = handles.RacesDB.' UID '.Year;']);
%     eval(['Stage = handles.RacesDB.' UID '.Stage;']);
%     eval(['RawDistance = handles.RacesDB.' UID '.RawDistance;']);
%     eval(['RawDistanceINI = handles.RacesDB.' UID '.RawDistanceINI;']);
%     eval(['RawTime = handles.RacesDB.' UID '.RawTime;']);
%     eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
%     eval(['BOAllINI = handles.RacesDB.' UID '.BOAllINI;']);
%     eval(['framerate = handles.RacesDB.' UID '.FrameRate;']);
%     eval(['Source = handles.RacesDB.' UID '.Source;']);


%     if Source == 1;
%         answerReport = 'SP1';
%     elseif Source == 2;
%         answerReport = 'SP2';
%     elseif Source == 3;
%         answerReport = 'GE';
%     end;
% 
%     idx = isstrprop(Meet,'upper');
%     MeetShort = Meet(idx);
%     if strcmpi(Stage, 'SemiFinal');
%         StageShort = 'SF';
%     elseif strcmpi(Stage, 'Semi-final');
%         StageShort = 'SF';
%     else;
%         StageShort = Stage;
%     end;
%     if strcmpi(lower(StrokeType), 'freestyle');
%         StrokeShort = 'FS';
%     elseif strcmpi(lower(StrokeType), 'medley');
%         StrokeShort = 'IM';
%     elseif strcmpi(lower(StrokeType), 'backstroke');
%         StrokeShort = 'BK';
%     elseif strcmpi(lower(StrokeType), 'breaststroke');
%         StrokeShort = 'BR';
%     elseif strcmpi(lower(StrokeType), 'butterfly');
%         StrokeShort = 'BF';
%     end;
%         
%     if strcmpi(answerReport, 'SP1') == 1;
%         filename = [Athletename '_' num2str(RaceDist) StrokeShort '_' MeetShort Year '_' StageShort '_SP1'];
%     elseif strcmpi(answerReport, 'SP2') == 1;
%         filename = [Athletename '_' num2str(RaceDist) StrokeShort '_' MeetShort Year '_' StageShort '_SP2'];
%     elseif strcmpi(answerReport, 'GE') == 1;
%         filename = [Athletename '_' num2str(RaceDist) StrokeShort '_' MeetShort Year '_' StageShort '_GE'];
%     end;
    
%     if Course == 25;
%         Race = [num2str(RaceDist) 'm ' StrokeType ' (SCM)'];
%     else;
%         Race = [num2str(RaceDist) 'm ' StrokeType ' (LCM)'];
%     end;
%     eval(['RaceDate = handles.RacesDB.' UID '.RaceDate;']);
%     
%     index = strfind(AgeGroup, '/');
% 
%     dateDiff(1) = datetime(str2num(AgeGroup(index(2)+1:end)), str2num(AgeGroup(index(1)+1:index(2)-1)), str2num(AgeGroup(1:index(1)-1)));
%     index = strfind(RaceDate, '-');
% 
%     if Source == 1;
%         dateDiff(2) = datetime(str2num(RaceDate(1:index(1)-1)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(index(2)+1:end)));
%     elseif Source == 2;
%         dateDiff(2) = datetime(str2num(RaceDate(1:index(1)-1)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(index(2)+1:end)));
%     end;
%     [DYear, DMonth, DDay] = split(caldiff(dateDiff, {'years';'months';'days'}), {'years';'months';'days'});
% 
%     if DYear <= 18 & DYear > 17;
%         AgeGroup = '18y';
%     elseif DYear <= 17 & DYear > 16;
%         AgeGroup = '17y';
%     elseif DYear <= 16 & DYear > 15;
%         AgeGroup = '16y';
%     elseif DYear <= 15 & DYear > 14;
%         AgeGroup = '15y';
%     elseif DYear <= 14 & DYear > 13;
%         AgeGroup = '14y';
%     elseif DYear <= 13;
%         AgeGroup = '13y & under';
%     else;
%         AgeGroup = 'Open';
%     end;
% 
%     Round = [AgeGroup ' - ' Stage];
%     eval(['Venue = handles.RacesDB.' UID '.Venue;']);
%     eval(['AnalysisDate = handles.RacesDB.' UID '.AnalysisDate;']);
% 
%     li1 = strfind(AnalysisDate, 'T');
%     li2 = strfind(AnalysisDate, '.');
%     AnalysisDate = [AnalysisDate(1:li1-1) '  ' AnalysisDate(li1+1:li2-1)];
%     AnalysisDate = ['Swim created at ' AnalysisDate];
%     
%     t = now;
%     ReportDate = ['Report last generated at ' datestr(datetime(t,'ConvertFrom','datenum'))];
    
    source = 'display';
    Course = str2num(databaseCurrent{1,10});
    RaceDist = str2num(databaseCurrent{1,3});
    Gender = databaseCurrent{1,5};
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
else;
    source = 'display';
    handles2.sourceReport = 'Comp';
    Course = str2num(databaseCurrent{1,10});
    RaceDist = str2num(databaseCurrent{1,3});
    Gender = databaseCurrent{1,5};
    if Course == 25;
        if RaceDist == 50;
            create_SP1reportComp_SCM50_rankings;
        elseif RaceDist == 100;
            create_SP1reportComp_SCM100_rankings;
        elseif RaceDist == 150;
            create_SP1reportComp_SCM150_rankings;
        elseif RaceDist == 200;
            create_SP1reportComp_SCM200_rankings;
        elseif RaceDist == 400;
            create_SP1reportComp_SCM400_rankings;
        elseif RaceDist == 800;
            create_SP1reportComp_SCM800_rankings;
        elseif RaceDist == 1500;
            create_SP1reportComp_SCM1500_rankings;
        end;
        if strcmpi(lower(Gender), 'female') == 1;
            handles2.filename = ['Women_' num2str(RaceDist) StrokeShort '_SCM_SPComp'];
        else;
            handles2.filename = ['Men_' num2str(RaceDist) StrokeShort '_SCM_SP1Comp'];
        end;
    else;
        if RaceDist == 50;
            create_SP1reportComp_LCM50_rankings;
        elseif RaceDist == 100;
            create_SP1reportComp_LCM100_rankings;
        elseif RaceDist == 150;
            create_SP1reportComp_LCM150_rankings;
        elseif RaceDist == 200;
            create_SP1reportComp_LCM200_rankings;
        elseif RaceDist == 400;
            create_SP1reportComp_LCM400_rankings;
        elseif RaceDist == 800;
            create_SP1reportComp_LCM800_rankings;
        elseif RaceDist == 1500;
            create_SP1reportComp_LCM1500_rankings;
        end;
        if strcmpi(lower(Gender), 'female') == 1;
            handles2.filename = ['Women_' num2str(RaceDist) StrokeShort '_LCM_SPComp'];
        else;
            handles2.filename = ['Men_' num2str(RaceDist) StrokeShort '_LCM_SPComp'];
        end;
    end;
    guidata(handles2.hdef, handles2);
end;
 

guidata(handles.hf_w1_welcome, handles);

