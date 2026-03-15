function [] = saveDisplay_analyser(varargin);


handles = guidata(gcf);



if isfield(handles, 'current_toggle') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        StatusEC = get(handles.AminationStatus_analyser, 'String');
        if strcmpi(StatusEC, 'Play');
            set(handles.AminationStatus_analyser, 'String', 'Other');
            return;
        end;
    end;
end;


if isempty(handles.filelistAdded) == 1;
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(handles, 'RacesDB') == 0;
    errordlg('Update data display', 'Error');
    return;
end;

if handles.updatedfiles == 1;
    errordlg('Update data display', 'Error');
    return;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
RaceUID = [];
for raceEC = 1:nbRaces;
    fileEC = handles.filelistAdded{raceEC};
    proceed = 1;
    iter = 1;
    while proceed == 1;
        raceCHECK = handles.uidDB{iter,2};
        if strcmpi(fileEC, raceCHECK) == 1;
            RaceUID{raceEC} = handles.uidDB{iter,1};
            proceed = 0;
        else;
            iter = iter + 1;
        end;
    end;
end;


pathname = uigetdir(handles.lastPath_analyser, 'Select a folder');
if isempty(pathname) == 1;
    return;
end;
if pathname == 0;
    return;
end;
handles.lastPath_analyser = pathname;

for i = 1:nbRaces;

    UID = RaceUID{i};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    if findstr(valRelay, 'L.1');
        valRelay = 'Leg1';
    elseif findstr(valRelay, 'L.2');
        valRelay = 'Leg2';
    elseif findstr(valRelay, 'L.3');
        valRelay = 'Leg3';
    elseif findstr(valRelay, 'L.4');
        valRelay = 'Leg4';
    else;
        valRelay = 'Flat';
    end;
    
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);
    if Source == 1 | Source == 3;
        isInterpolatedBO = BOAll(:,4);
        BOAll = BOAll(:,1:3);
    else;
        isInterpolatedBO = zeros(NbLap,1);
    end;

    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['DistanceINI = handles.RacesDB.' UID '.RawDistanceINI;']);
    eval(['Velocity = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['VelocityTrend = handles.RacesDB.' UID '.RawVelocityTrend;']);
    eval(['VelocityRaw = handles.RacesDB.' UID '.RawVelocityRaw;']);
    eval(['Time = handles.RacesDB.' UID '.RawTime;']);
    
    eval(['Stroke_SR = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['Stroke_SLINI = handles.RacesDB.' UID '.Stroke_DistanceINI;']);
    eval(['Stroke_SL = handles.RacesDB.' UID '.Stroke_Distance;']);
    eval(['Stroke_SIINI = handles.RacesDB.' UID '.Stroke_SIINI;']);
    eval(['Stroke_SI = handles.RacesDB.' UID '.Stroke_SI;']);
    eval(['Stroke_VelocityINI = handles.RacesDB.' UID '.Stroke_VelocityINI;']);
    eval(['Stroke_Velocity = handles.RacesDB.' UID '.Stroke_Velocity;']);
    eval(['Stroke_Count = handles.RacesDB.' UID '.Stroke_Count;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Breath_Frame = handles.RacesDB.' UID '.Breath_Frames;']);
    eval(['BreathsNb = handles.RacesDB.' UID '.BreathsNb;']);
    eval(['Kick_Frame = handles.RacesDB.' UID '.Kick_Frames;']);
    eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    
    %---filename
    if Source == 1;
        filename = [Athletename '_' num2str(RaceDist) 'm-' StrokeType '_' Meet Year '-' Stage '_' valRelay '_Raw_SP1'];
    elseif Source == 2;
        filename = [Athletename '_' num2str(RaceDist) 'm-' StrokeType '_' Meet Year '-' Stage '_' valRelay '_Raw_SP2'];
    elseif Source == 3;
        filename = [Athletename '_' num2str(RaceDist) 'm-' StrokeType '_' Meet Year '-' Stage '_' valRelay '_Raw_GE'];
    end;
    
    %---time series (time, position, velocity)
    dataTimeSeries = [];

    dataTimeSeries{1,1} = 'Continuous data';
    dataTimeSeries{1,2} = '(start at Breakout - 1s)';
    dataTimeSeries{2,1} = 'Time (s)';
    dataTimeSeries{2,2} = 'Distance Raw (m)';
    dataTimeSeries{2,3} = 'Distance Filtered (m)';
    dataTimeSeries{2,4} = 'Velocity Raw (m/s)';
    dataTimeSeries{2,5} = 'Velocity Filtered (m/s)';
    dataTimeSeries{2,6} = 'Velocity Trend (m/s)';

    dataTimeSeries{1,7} = "Source";
    if Source == 1;
        dataTimeSeries{2,7} = 'SP1';
    elseif Source == 2;
        dataTimeSeries{2,7} = 'SP2';
    elseif Source == 3;
        dataTimeSeries{2,7} = 'GE';    
    end;

    for raws = 1:length(Time);
        Timetxt = dataToStr(Time(raws),2);
        dataTimeSeries{raws+2,1} = Timetxt;

        if isnan(DistanceINI(raws)) == 1;
            Distancetxt = '';
        else;
            Distancetxt = dataToStr(DistanceINI(raws),2);
        end;
        dataTimeSeries{raws+2,2} = Distancetxt;

        if isnan(Distance(raws)) == 1;
            Distancetxt = '';
        else;
            Distancetxt = dataToStr(Distance(raws),2);
        end;
        dataTimeSeries{raws+2,3} = Distancetxt;

        if isnan(VelocityRaw(raws)) == 1;
            VelocityRawtxt = '';
        else;
            VelocityRawtxt = dataToStr(VelocityRaw(raws),3);
        end;
        dataTimeSeries{raws+2,4} = VelocityRawtxt;

        if isnan(Velocity(raws)) == 1;
            Velocitytxt = '';
        else;
            Velocitytxt = dataToStr(Velocity(raws),2);
        end;
        dataTimeSeries{raws+2,5} = Velocitytxt;
        
        if isnan(VelocityTrend(raws)) == 1;
            VelocityTrendtxt = '';
        else;
            VelocityTrendtxt = dataToStr(VelocityTrend(raws),2);
        end;
        dataTimeSeries{raws+2,6} = VelocityTrendtxt;

        
    end;

    %---Events
    dataEvent = [];
    dataEvent{1,1} = 'Strokes';
    dataEvent{2,1} = 'Lap';
    dataEvent{2,2} = 'Number';
    dataEvent{2,3} = 'Time (s)';
    dataEvent{2,4} = 'Distance Raw (m)';
    dataEvent{2,5} = 'Distance Filtered (m)';
    dataEvent{2,6} = 'Rate (stroke/min)';
    dataEvent{2,7} = 'Stroke Index Raw (m2/s/str)';
    dataEvent{2,8} = 'Stroke Index Filtered (m2/s/str)';
    dataEvent{2,9} = 'Velocity Raw (m/s)';
    dataEvent{2,10} = 'Velocity Filtered (m/s)';
    offset = 0;

    for lap = 1:NbLap;
        for stroke = 1:Stroke_Count(lap);

            dataEvent{stroke+2+offset,1} = num2str(lap);
            dataEvent{stroke+2+offset,2} = num2str(stroke);
            Timetxt = dataToStr(Stroke_Frame(lap,stroke)./FrameRate,2);
            dataEvent{stroke+2+offset,3} = Timetxt;
            
            if stroke == 1;
                Distancetxt = '';
            else;
                if isnan(Stroke_SLINI(lap,stroke-1)) == 1;
                    Distancetxt = '';
                elseif Stroke_SLINI(lap,stroke-1) == 0;
                    Distancetxt = '';
                else;
                    Distancetxt = dataToStr(Stroke_SLINI(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,4} = Distancetxt;

            if stroke == 1;
                Distancetxt = '';
            else;
                if isnan(Stroke_SL(lap,stroke-1)) == 1;
                    Distancetxt = '';
                elseif Stroke_SL(lap,stroke-1) == 0;
                    Distancetxt = '';
                else;
                    Distancetxt = dataToStr(Stroke_SL(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,5} = Distancetxt;

            if stroke == 1;
                Ratetxt = '';
            else;
                if isnan(Stroke_SR(lap,stroke-1)) == 1;
                    Ratetxt = '';
                elseif Stroke_SR(lap,stroke-1) == 0;
                    Ratetxt = '';
                else;
                    Ratetxt = dataToStr(Stroke_SR(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,6} = Ratetxt;
            
            if stroke == 1;
                SItxt = '';
            else;
                if isnan(Stroke_SIINI(lap,stroke-1)) == 1;
                    SItxt = '';
                elseif Stroke_SIINI(lap,stroke-1) == 0;
                    SItxt = '';
                else;
                    SItxt = dataToStr(Stroke_SIINI(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,7} = SItxt;  

            if stroke == 1;
                SItxt = '';
            else;
                if isnan(Stroke_SI(lap,stroke-1)) == 1;
                    SItxt = '';
                elseif Stroke_SI(lap,stroke-1) == 0;
                    SItxt = '';
                else;
                    SItxt = dataToStr(Stroke_SI(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,8} = SItxt;  

            if stroke == 1;
                Veltxt = '';
            else;
                if isnan(Stroke_VelocityINI(lap,stroke-1)) == 1;
                    Veltxt = '';
                elseif Stroke_VelocityINI(lap,stroke-1) == 0;
                    Veltxt = '';
                else;
                    Veltxt = dataToStr(Stroke_VelocityINI(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,9} = Veltxt;

             if stroke == 1;
                Veltxt = '';
            else;
                if isnan(Stroke_Velocity(lap,stroke-1)) == 1;
                    Veltxt = '';
                elseif Stroke_Velocity(lap,stroke-1) == 0;
                    Veltxt = '';
                else;
                    Veltxt = dataToStr(Stroke_Velocity(lap,stroke-1),2);
                end;
            end;
            dataEvent{stroke+2+offset,10} = Veltxt;
            
        end;
        offset = sum(Stroke_Count(1:lap));
    end;
    
    dataEvent{1,12} = 'Breaths';
    dataEvent{2,12} = 'Lap';
    dataEvent{2,13} = 'Number';
    dataEvent{2,14} = 'Time (s)';
    offset = 0;
    for lap = 1:NbLap;
        for breath = 1:BreathsNb(lap);
            dataEvent{breath+2+offset,12} = num2str(lap);
            dataEvent{breath+2+offset,13} = num2str(breath);
            Timetxt = dataToStr(Breath_Frame(lap,breath)./FrameRate,2);
            dataEvent{breath+2+offset,14} = Timetxt;
        end;
        offset = sum(BreathsNb(1:lap));
    end;
    
    dataEvent{1,16} = 'UW Kicks';
    dataEvent{2,16} = 'Lap';
    dataEvent{2,17} = 'Number';
    dataEvent{2,18} = 'Time (s)';
    offset = 0;
    for lap = 1:NbLap;
        for kick = 1:KicksNb(lap);
            dataEvent{kick+2+offset,16} = num2str(lap);
            dataEvent{kick+2+offset,17} = num2str(kick);
            Timetxt = dataToStr(Kick_Frame(lap,kick)./FrameRate,2);
            dataEvent{kick+2+offset,18} = Timetxt;
        end;
        if isempty(kick) == 0;
            offset = sum(KicksNb(1:lap));
        end;
    end;
    
    dataEvent{1,20} = 'Breakouts';
    dataEvent{2,20} = 'Lap';
    dataEvent{2,21} = 'Time Lap (s)';
    dataEvent{2,22} = 'Time Race (s)';
    dataEvent{2,23} = 'Distance (m)';
    for lap = 1:NbLap;
        dataEvent{lap+2,20} = num2str(lap);
        if lap == 1;
            if isInterpolatedBO(lap,1) == 0;
                %no interpolation
                BOTimetxt = dataToStr(BOAll(lap,2),2);
            else;
                %interpolation
                BOTimetxt = [dataToStr(BOAll(lap,2),2) ' !'];
            end;
        else;
            if isInterpolatedBO(lap,1) == 0;
                %no interpolation
                BOTimetxt = dataToStr(BOAll(lap,2)-SplitsAll(lap,2),2);
            else;
                %interpolation
                BOTimetxt = [dataToStr(BOAll(lap,2)-SplitsAll(lap,2),2) ' !'];
            end;
        end;
        dataEvent{lap+2,21} = BOTimetxt;

        if isInterpolatedBO(lap,1) == 0;
            %no interpolation
            BOTimetxt = dataToStr(BOAll(lap,2),2);
        else;
            %interpolation
            BOTimetxt = [dataToStr(BOAll(lap,2),2) ' !'];
        end;
        dataEvent{lap+2,22} = BOTimetxt;
        
        if isInterpolatedBO(lap,1) == 0;
            %no interpolation
            BODisttxt = dataToStr(BOAll(lap,3) - (Course.*(lap-1)),1);
        else;
            %interpolation
            BODisttxt = [dataToStr(BOAll(lap,3) - (Course.*(lap-1)),1) ' !'];
        end;
        dataEvent{lap+2,23} = BODisttxt;
    end;
    
    dataEvent{1,25} = 'Splits';
    dataEvent{2,25} = 'Lap';
    dataEvent{2,26} = 'Lap Time (s)'; 
    dataEvent{2,27} = 'Cumulative Time (s)';

    dataEvent{1,29} = 'Source';
    if Source == 1;
        dataEvent{2,29} = 'SP1';
    elseif Source == 2;
        dataEvent{2,29} = 'SP2';
    elseif Source == 3;
        dataEvent{2,29} = 'GE';
    end;

    for lap = 1:NbLap+1;
        if lap == 1
            dataEvent{lap+2,25} = 'Block';
        else;
            dataEvent{lap+2,25} = ['Lap ' num2str(lap-1)];
        end;
        if lap <= 2;
            Timetxt = dataToStr(SplitsAll(lap,2),2);
        else;
            Timetxt = dataToStr(SplitsAll(lap,2) - SplitsAll(lap-1,2),2);
        end;
        dataEvent{lap+2,26} = Timetxt;
        Timetxt = dataToStr(SplitsAll(lap,2),2);
        dataEvent{lap+2,27} = Timetxt;
    end;
    
    listdir = dir(pathname);
    proceed = 1;
    existfilesave = 0;
    iter = 1;
    while proceed == 1;
        for file = 1:length(listdir);
            fileEC = listdir(file).name;
            existfile = strcmpi(filename, fileEC);
            if existfile == 1;
                if iter == 1;
                    filename = [filename 'copy(' num2str(iter) ')'];
                else;
                    licopy = finstr(filename, 'copy');
                    filename = [filename(1:li-1) 'copy(' num2str(iter) ')'];
                end;
                existfilesave = 1;
            end;
        end;
        if existfilesave == 1;
            iter = iter + 1;
        else;
            proceed = 0;
        end;
    end;
    
    if ispc == 1;
        filename = [filename '.xlsx'];
        if isfile([pathname '\' filename]) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' pathname '\' filename];
            [status, cmdout] = system(command);
        end;
        
        exportstatusSheet1 = xlswrite([pathname '\' filename], dataEvent, 1);
        exportstatusSheet2 = xlswrite([pathname '\' filename], dataTimeSeries, 2);
        clc;
%         try;
            excelRenderingRaw_analyser;
%         end;
    elseif ismac == 1;
        filename = [filename '.xls'];
        if isfile([pathname '/' filename]) == 1;
            command = ['rm -rf ' pathname '/' filename];
            [status, cmdout] = system(command);
        end;
    
        javaaddpath('poi-3.8-20120326.jar');
        javaaddpath('poi-ooxml-3.8-20120326.jar');
        javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
        javaaddpath('xmlbeans-2.3.0.jar');
        javaaddpath('dom4j-1.6.1.jar');
        javaaddpath('stax-api-1.0.1.jar');

        xlwrite([pathname '/' filename], dataEvent, 'Event Data', 'A1');
        xlwrite([pathname '/' filename], dataTimeSeries, 'Time Series', 'A1');
        clc;
    end;
    
end;

guidata(handles.hf_w1_welcome, handles);


