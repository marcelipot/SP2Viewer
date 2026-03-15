if ispc == 1;
    fontEC = 14;
elseif ismac == 1;
    fontEC = 16;
end;
resolution = get(0,'ScreenSize');
resolution = resolution(1,3:4);
pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
    'color', [0 0 0], 'units', 'pixels','position', pos,'windowstyle','modal', ...
    'Name', 'Loading', 'NumberTitle', 'off');
h1 = uicontrol('parent', h, 'style', 'text', ...
    'string', 'Preparing your data ...', 'units', 'pixels', ...
    'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
    'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
    'FontWeight', 'Bold', 'Fontsize', fontEC);
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame = get(handle(h), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;
drawnow;


%------------------------------Connect to AWS------------------------------
%Check local AWS CLI
if ispc == 1;
    command = 'aws --version';
    [status, out] = system(command);

    if out == 1;
        errorwindow = errordlg('Please install AWS CLI on this machine', 'Error');
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
    end;

elseif ismac == 1;
    command = 'which aws';
    [status, out] = system(command);
    
   AWSFolder = '/usr/local/bin';
   if isdir(AWSFolder) == 0;
       path = uigetdir('Please select your AWS CLI installation root folder');
       if path == 0;
           errorwindow = errordlg('Please install AWS CLI on this machine', 'Error');
           return;
       end;
       if isempty(path) == 1;
           errorwindow = errordlg('Please install AWS CLI on this machine', 'Error');
           return;
       end;
   end;
   handles.AWSFolder = AWSFolder;
end;

currentYear = year(datetime("today"));
[connected,timing] = isnetavl;
if connected == 1;
    sourceAWS = 'boot';
    establishAWSconnection;

    if stopBoot == 1;
        close(h);
        return;
    end;

    if statusAWS == 0;
        fileDBUpdate = ['s3://sparta2-prod/sparta2-data/downloadDBUpdate.mat'];
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            filenameDBout = [MDIR '\SP2viewer\downloadDBUpdate.mat'];
            command = ['aws s3 cp ' fileDBUpdate ' ' filenameDBout];
        elseif ismac == 1;
            filenameDBout = ['/Applications/SP2Viewer/downloadDBUpdate.mat'];
            command = [handles.AWSFolder '/aws s3 cp ' fileDBUpdate ' ' filenameDBout];
        end;
        [status, out] = system(command);
    
        if ispc == 1;
            load([MDIR '\SP2Viewer\downloadDBUpdate.mat']);
        elseif ismac == 1;
            load /Applications/SP2Viewer/downloadDBUpdate.mat;
        end;
    
        for yearEC = 2018:currentYear;
            eval(['SP2dbEC = downloadDBUpdate.SP2_' num2str(yearEC) ';']);
            if SP2dbEC == 1;
                filenameDBin = ['s3://sparta2-prod/sparta2-data/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
                if ispc == 1;
                    MDIR = getenv('USERPROFILE');
                    filenameDBout = [MDIR '\SP2Viewer\SP2viewerDBSP2_' num2str(yearEC) '.mat'];
                elseif ismac == 1;
                    filenameDBout = ['/Applications/SP2Viewer/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
                end;
                command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
                [status, out] = system(command);
            end;
        end;
    
        if downloadDBUpdate.SP1 == 1;
            filenameDBin = ['s3://sparta2-prod/sparta2-data/SP2viewerDBSP1.mat'];
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDBout = [MDIR '\SP2Viewer\SP2viewerDBSP1.mat'];
            elseif ismac == 1;
                filenameDBout = ['/Applications/SP2Viewer/SP2viewerDBSP1.mat'];
            end;
            command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
            [status, out] = system(command);
        end;
    
        if downloadDBUpdate.GE == 1;
            filenameDBin = ['s3://sparta2-prod/sparta2-data/SP2viewerGreenEye.mat'];
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDBout = [MDIR '\SP2Viewer\SP2viewerGreenEye.mat'];
            elseif ismac == 1;
                filenameDBout = ['/Applications/SP2Viewer/SP2viewerGreenEye.mat'];
            end;
            command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
            [status, out] = system(command);
        end;
    end;    
else;
    warningwindow = errordlg('No internet connection detected', 'Warning');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame = get(handle(warningwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
end;
%--------------------------------------------------------------------------       





%---------------------------------checks-----------------------------------
norace = 0;
if ismac == 1;
    if isdir('/Applications/SP2Viewer') == 0;
        errorwindow = errordlg('Impossible to run: Root folder missing', 'Error');
        return;
    else;
        if isfile('/Applications/SP2Viewer/icons.mat') == 0;
            errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
            return;
        end;
        
%         if isfile('/Applications/SP2Viewer/SP2viewerDBSP2.mat') == 0;
%             errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%             return;
%         end;
        
        if isdir('/Applications/SP2Viewer/RaceDB/') == 0;
            errorwindow = errordlg('Impossible to run: No database available', 'Error');
            return;
        end;
            
%         if isdir('/Applications/SP2Viewer/ffmpeg/') == 1;
%             if isdir('/Applications/SP2Viewer/ffmpeg/bin') == 0;
%                 errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%                 return;
%             else;
%                 if isfile('/Applications/SP2Viewer/ffmpeg/bin/ffmpeg') == 0;
%                     errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%                     return;
%                 end;
%             end;
%         else;
%             errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%             return;
%         end;
    end;
    
    tempFolder = '/Applications/SP2Viewer/RaceDB/Temp';
    [tempFolder, specialChar] = checkFilename(tempFolder);
    command = ['rm -rf ' tempFolder];
    [status, cmdout] = system(command);

    MDIR = '/Applications/SP2Viewer';
    user_name = char(java.lang.System.getProperty('user.name'));
    handles.defaultpath = ['/Users/',user_name,'/Desktop'];
    handles.lastPath_analyser = handles.defaultpath;
    handles.lastPath_database = handles.defaultpath;
    handles.lastPath_player = handles.defaultpath;
    handles.lastPath_benchmark = handles.defaultpath;
    
elseif ispc == 1;
    MDIR = getenv('USERPROFILE');
    if isdir([MDIR '\SP2Viewer']) == 0;
        errorwindow = errordlg('Impossible to run: Root folder missing', 'Error');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
        return;
    else;
        if isfile([MDIR '\SP2Viewer\icons.mat']) == 0;
            errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
            return;
        end;
        
%         if isfile([MDIR '\SP2Viewer\SP2viewerDBSP2.mat']) == 0;
%             errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%             jFrame = get(handle(errorwindow), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%             return;
%         end;
        
        if isdir([MDIR '\SP2Viewer\RaceDB']) == 0;
           errorwindow = errordlg('Impossible to run: No database available', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
            return;
        end;
            
%         if isdir([MDIR '\SP2Viewer\ffmpeg']) == 1;
%             if isdir([MDIR '\SP2Viewer\ffmpeg\bin']) == 0;
%                 errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%                 jFrame = get(handle(errorwindow), 'javaframe');
%                 jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                 jFrame.setFigureIcon(jicon);
%                 clc;
%                 return;
%             else;
%                 if isfile([MDIR '\SP2Viewer\ffmpeg\bin\ffmpeg.exe']) == 0;
%                     errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%                     jFrame = get(handle(errorwindow), 'javaframe');
%                     jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                     jFrame.setFigureIcon(jicon);
%                     clc;
%                     return;
%                 end;
%             end;
%         else;
%             errorwindow = errordlg('Impossible to run: Root folder incomplete', 'Error');
%             jFrame = get(handle(errorwindow), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%             return;
%         end;
    end;
   
    MDIR = getenv('USERPROFILE');
    
    tempFolder = [MDIR '\SP2viewer\RaceDB\Temp'];
    [tempFolder, specialChar] = checkFilename(tempFolder);
    command = ['rmdir /Q /S ' tempFolder];
    [status, cmdout] = system(command);

    %---Last path and default path
    handles.defaultpath = winqueryreg('HKEY_CURRENT_USER', 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Desktop');
    handles.lastPath_analyser = handles.defaultpath;
    handles.lastPath_database = handles.defaultpath;
    handles.lastPath_player = handles.defaultpath;
    handles.lastPath_benchmark = handles.defaultpath;

end;
handles.tempFolder = tempFolder;

resolution = get(0,'ScreenSize');
resolution = resolution(1,3:4);
if resolution(1) < 1280;
    warningwindow = warndlg('A minimum resolution of 1280x720 is advised to run this application', 'Warning');
    if ispc == 1;
        jFrame = get(handle(warningwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(warnwindow);
end;
%--------------------------------------------------------------------------




%------------------------Load initial parameters---------------------------
%---Load the icones and the images
if ismac == 1;
    load /Applications/SP2Viewer/icons.mat;
    handles.icones = icones;
    clear icones;
    
    for yearEC = 2018:currentYear;
        fileEC = ['/Applications/SP2Viewer/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        if isfile(fileEC) == 1;
            load(['/Applications/SP2Viewer/SP2viewerDBSP2_' num2str(yearEC) '.mat']);

            if yearEC ~= currentYear;
                clear AthletesDB;
                clear BenchmarkEvents;
                clear MeetDB;
                clear isupdate;
                clear ParaDB;
                clear PBsDB;
                clear PBsDB_SC;
                clear RoundDB;
            else;
                isupdate_save = isupdate;
            end;
        end;
    end;
    MeetDB_save = MeetDB;
    AthletesDB_save = AthletesDB;

    BenchmarkEventsSave = BenchmarkEvents;
    isSP1 = 0;
    isGreenEye = 0;
    if exist('/Applications/SP2Viewer/SP2viewerDBSP1.mat') == 2;
        load /Applications/SP2Viewer/SP2viewerDBSP1.mat;
        isSP1 = 1;
    end;
    if length(MeetDB(:,1)) > length(MeetDB_save(:,1));
        MeetDB_save = MeetDB;
    end;
    if exist('/Applications/SP2Viewer/SP2viewerDBGreenEye.mat') == 2;
        load /Applications/SP2Viewer/SP2viewerDBGreenEye.mat;
        isGreenEye = 1;
    end;
    if length(MeetDB(:,1)) > length(MeetDB_save(:,1));
        MeetDB_save = MeetDB;
    end;
    BenchmarkEvents = BenchmarkEventsSave;

elseif ispc == 1;
    load([MDIR '\SP2Viewer\icons.mat']);
    handles.icones = icones;
    clear icones;
    
    for yearEC = 2018:currentYear;
        fileEC = [MDIR '\SP2Viewer\SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        if isfile(fileEC) == 1;
            load([MDIR '\SP2Viewer\SP2viewerDBSP2_' num2str(yearEC) '.mat']);

            if yearEC ~= currentYear;
                clear AthletesDB;
                clear BenchmarkEvents;
                clear MeetDB;
                clear isupdate;
                clear ParaDB;
                clear PBsDB;
                clear PBsDB_SC;
                clear RoundDB;
            else;
                isupdate_save = isupdate;
            end;
        end;
    end;
    MeetDB_save = MeetDB;
    AthletesDB_save = AthletesDB;

    BenchmarkEventsSave = BenchmarkEvents;
    isSP1 = 0;
    isGreenEye = 0;
    if exist([MDIR '\SP2Viewer\SP2viewerDBSP1.mat']) == 2;
        load([MDIR '\SP2Viewer\SP2viewerDBSP1.mat']);
        isSP1 = 1;
    end;
    if length(MeetDB(:,1)) > length(MeetDB_save(:,1));
        MeetDB_save = MeetDB;
    end;
    if exist([MDIR '\SP2Viewer\SP2viewerDBGreenEye.mat']) == 2;
        load([MDIR '\SP2Viewer\SP2viewerDBGreenEye.mat']);
        isGreenEye = 1;
    end;
    if length(MeetDB(:,1)) > length(MeetDB_save(:,1));
        MeetDB_save = MeetDB;
    end;
    BenchmarkEvents = BenchmarkEventsSave;
end;
isupdate = isupdate_save;
MeetDB = MeetDB_save;
AthletesDB = AthletesDB_save;

iter = 0;
for yearEC = 2018:currentYear-1;
    fileEC = ['FullDB_SP2_' num2str(yearEC)];
    if exist(fileEC) == 1;
        if iter == 0;
            eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
            eval(['uidDB = uidDB_SP2_' num2str(yearEC) ';']);
%             eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
            eval(['AgeGroup = AgeGroup_SP2_' num2str(yearEC) ';']);
            eval(['LastUpdate = LastUpdate_SP2_' num2str(yearEC) ';']);
            listFieldsExist = fieldnames(AgeGroup);

            iter = 1;
        else;
            eval(['uidDBEC = uidDB_SP2_' num2str(yearEC) ';']);
            if isempty(uidDBEC) == 0;
                rawIni = length(FullDB(:,1)) + 1;
                eval(['rawEnd = rawIni + length(FullDB_SP2_' num2str(yearEC) '(2:end,1)) - 1;']);
                eval(['FullDB(rawIni:rawEnd,:) = FullDB_SP2_' num2str(yearEC) '(2:end,:);']);
            
                rawIni = length(uidDB(:,1)) + 1;
                eval(['rawEnd = rawIni + length(uidDB_SP2_' num2str(yearEC) '(:,1)) - 1;']);
                eval(['uidDB(rawIni:rawEnd,:) = uidDB_SP2_' num2str(yearEC) ';']);
            end;

            eval(['listFieldsCheck = fieldnames(AgeGroup_SP2_' num2str(yearEC) ');']);
            for i = 1:length(listFieldsCheck);
                fieldCheck = listFieldsCheck{i};
                index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
                if isempty(index) == 1;
                    eval(['val = AgeGroup_SP2_' num2str(yearEC) '.' fieldCheck ';']);
                    eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
                end;
            end;
        end;
    end;
end;

% FullDB = FullDB_SP2;
% uidDB = uidDB_SP2;
% AgeGroup = AgeGroup_SP2;
% LastUpdate = LastUpdate_SP2;
if isSP1 == 1;
    rawIni = length(FullDB(:,1)) + 1;
    rawEnd = rawIni + length(FullDB_SP1(2:end,1)) - 1;
    FullDB(rawIni:rawEnd,:) = FullDB_SP1(2:end,:);

    rawIni = length(uidDB(:,1)) + 1;
    rawEnd = rawIni + length(uidDB_SP1(:,1)) - 1;
    uidDB(rawIni:rawEnd,:) = uidDB_SP1;

    listFieldsExist = fieldnames(AgeGroup);
    listFieldsCheck = fieldnames(AgeGroup_SP1);
    for i = 1:length(listFieldsCheck);
        fieldCheck = listFieldsCheck{i};
        index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
        if isempty(index) == 1;
            eval(['val = AgeGroup_SP1.' fieldCheck ';']);
            eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
        end;
    end;
end;
if isGreenEye == 1;
    rawIni = length(FullDB(:,1)) + 1;
    rawEnd = rawIni + length(FullDB_GreenEye(2:end,1)) - 1;
    FullDB(rawIni:rawEnd,:) = FullDB_GreenEye(2:end,:);

    rawIni = length(uidDB(:,1)) + 1;
    rawEnd = rawIni + length(uidDB_GreenEye(:,1)) - 1;
    uidDB(rawIni:rawEnd,:) = uidDB_GreenEye;

    listFieldsExist = fieldnames(AgeGroup);
    listFieldsCheck = fieldnames(AgeGroup_GreenEye);
    for i = 1:length(listFieldsCheck);
        fieldCheck = listFieldsCheck{i};
        index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
        if isempty(index) == 1;
            eval(['val = AgeGroup_GreenEye.' fieldCheck ';']);
            eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
        end;
    end;
end;

handles.FullDB_4update = FullDB;
handles.uidDB_4update = uidDB;
handles.AgeGroup_4update = AgeGroup;

yearEC = currentYear;
fileEC = ['FullDB_SP2_' num2str(yearEC)];
if exist(fileEC) == 1;
    if iter == 0;
        eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
        eval(['uidDB = uidDB_SP2_' num2str(yearEC) ';']);
%             eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
        eval(['AgeGroup = AgeGroup_SP2_' num2str(yearEC) ';']);
        eval(['LastUpdate = LastUpdate_SP2_' num2str(yearEC) ';']);
        listFieldsExist = fieldnames(AgeGroup);

        iter = 1;
    else;
        eval(['uidDBEC = uidDB_SP2_' num2str(yearEC) ';']);
        if isempty(uidDBEC) == 0;
            rawIni = length(FullDB(:,1)) + 1;
            eval(['rawEnd = rawIni + length(FullDB_SP2_' num2str(yearEC) '(2:end,1)) - 1;']);
            eval(['FullDB(rawIni:rawEnd,:) = FullDB_SP2_' num2str(yearEC) '(2:end,:);']);
        
            rawIni = length(uidDB(:,1)) + 1;
            eval(['rawEnd = rawIni + length(uidDB_SP2_' num2str(yearEC) '(:,1)) - 1;']);
            eval(['uidDB(rawIni:rawEnd,:) = uidDB_SP2_' num2str(yearEC) ';']);
        end;

        eval(['listFieldsCheck = fieldnames(AgeGroup_SP2_' num2str(yearEC) ');']);
        for i = 1:length(listFieldsCheck);
            fieldCheck = listFieldsCheck{i};
            index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
            if isempty(index) == 1;
                eval(['val = AgeGroup_SP2_' num2str(yearEC) '.' fieldCheck ';']);
                eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
            end;
        end;
    end;
end;

softwareVersion = 'ver1.13'; %displayed
softwareVersion2 = 'ver1.133'; %sub-version
if strcmpi(isupdate, softwareVersion2) == 0;
    warningwindow = warndlg('An update is available for this program. Please download this new version on MS Teams and update your software', 'Warning');
    if ispc == 1;
        jFrame = get(handle(warningwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    waitfor(warningwindow);
end;

handles.MeetDB = MeetDB;
handles.AthletesDB = AthletesDB;
handles.ParaDB = ParaDB;
handles.uidDB = uidDB;
for yearEC = 2018:currentYear;
    eval(['fileEC = [' '''' 'uidDB_SP2_' num2str(yearEC) '''' '];']);
    if exist(fileEC) == 1;
        eval(['handles.uidDB_SP2_' num2str(yearEC) ' = uidDB_SP2_' num2str(yearEC) ';']);
    else;
        eval(['handles.uidDB_SP2_' num2str(yearEC) ' = {};']);
    end;
end;
handles.FullDB = FullDB;
handles.FullDB_GreenEye = FullDB_GreenEye;
handles.FullDB_SP1 = FullDB_SP1;
for yearEC = 2018:currentYear;
    eval(['fileEC = [' '''' 'FullDB_SP2_' num2str(yearEC) '''' '];']);
    if exist(fileEC) == 1;
        eval(['handles.FullDB_SP2_' num2str(yearEC) ' = FullDB_SP2_' num2str(yearEC) ';']);
    else;
        eval(['handles.FullDB_SP2_' num2str(yearEC) ' = {};']);
    end;
end;
handles.PBsDB = PBsDB;
handles.PBsDB_SC = PBsDB_SC;
handles.AgeGroup = AgeGroup;
handles.AgeGroup_GreenEye = AgeGroup_GreenEye;
handles.AgeGroup_SP1 = AgeGroup_SP1;
for yearEC = 2018:currentYear;
    eval(['fileEC = [' '''' 'AgeGroup_SP2_' num2str(yearEC) '''' '];']);
    if exist(fileEC) == 1;
        eval(['handles.AgeGroup_SP2_' num2str(yearEC) ' = AgeGroup_SP2_' num2str(yearEC) ';']);
    else;
        eval(['handles.AgeGroup_SP2_' num2str(yearEC) ' = {};']);
    end;
end;
handles.LastUpdate = LastUpdate_SP2_2024;
handles.BenchmarkEvents = BenchmarkEvents;
handles.RoundDB = RoundDB;

handles.isupdate = isupdate;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%set(handles.CurrentUpdate_txt, 'String', handles.LastUpdate);

if isfield(handles, 'AthletesDB') == 0;
    warningwindow = warndlg('Incorrect database: No athletes available', 'Warning');
    if ispc == 1;
        jFrame = get(handle(warningwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
end;
handles.AthleteNamelist_analyser = [];
handles.AthleteRacelist_analyser = [];
if isfield(handles, 'uidDB') == 0;
    errorwindow = warndlg('No races available', 'Warning');
    if ispc == 1;
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
        return;
    end;
    
else;
    if isempty(handles.FullDB);
        if norace == 0;
            warningwindow = warndlg('No races available', 'Warning');
            if ispc == 1;
                jFrame = get(handle(warningwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;
    else;
        if length(handles.FullDB) == 0;
            if norace == 0;
                warningwindow = warndlg('No races available', 'Warning');
                if ispc == 1;
                    jFrame = get(handle(warningwindow), 'javaframe');
                    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                    jFrame.setFigureIcon(jicon);
                    clc;
                end;
            end;
        else;
            %all good
        end;
    end;
end;


%------------------------Create athletes names list------------------------
[AthleteNamesList, index] = sort(FullDB(2:end, 2));
AthleteNamesList2 = {'Athlete name'};

AthleteGendersList = FullDB(2:end, 5);
AthleteGendersList = AthleteGendersList(index,1);
AthleteGendersList2 = {'Gender'};

iter = 2;
for i = 1:length(AthleteNamesList);
    nameACT = AthleteNamesList{i,1};
    genderACT = AthleteGendersList{i,1};

    interrupt = 0;
    if strfind(nameACT, 'Admin');
        interrupt = 1;
    end;
    if strfind(nameACT, 'AIS');
        interrupt = 1;
    end;
    if strfind(nameACT, 'Dino');
        interrupt = 1;
    end;
    if strfind(nameACT, 'Doe');
        interrupt = 1;
    end;
    
    if interrupt == 0;
        if isempty(AthleteNamesList2) == 0;
            Index = find(contains(AthleteNamesList2, nameACT));
            if isempty(Index) == 1;
                AthleteNamesList2(iter,1) = {nameACT};
                AthleteGendersList2(iter,1) = {genderACT};
                iter = iter + 1;
            end;
        else;
            AthleteNamesList2(iter,1) = {nameACT};
            AthleteGendersList2(iter,1) = {genderACT};
            iter = iter + 1;
        end;
    end;
end;
handles.AthleteNamesList = AthleteNamesList2;
handles.AthleteGendersList = AthleteGendersList2;
handles.AthleteNamelist_analyser = AthleteNamesList2;
handles.AthleteNamelistDisp_analyser = AthleteNamesList2;
%--------------------------------------------------------------------------





%--------------------------Create the main window--------------------------
%---Create the welcome window
pos = [(resolution(1)-1280)./2 (resolution(2)-600)./2 1280 720];
handles.hf_w1_welcome = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal', 'color', [0 0 0], 'units', 'pixels', 'position', pos,...
    'WindowButtonDownFcn', @clickdownaction, 'WindowButtonUpFcn', @clickupaction, 'WindowKeyPressFcn', '', 'WindowKeyReleaseFcn', '', ...
    'CloseRequestFcn', @closeSP2Viewer);
set(handles.hf_w1_welcome, 'Name', 'Sparta 2 Viewer', 'NumberTitle', 'off');

clear functions;
handles.PosFigPrev = pos;

if ispc == 1;
    jFrame = get(handle(handles.hf_w1_welcome), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;

%---Create the txt of the page
handles.txtpage = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', 'position', [10, 10, 800, 15], 'String', '', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 16, 'HorizontalAlignment', 'Left');
handles.txtpagesub = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', 'position', [10, 10, 800, 15], 'String', '', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 16, 'HorizontalAlignment', 'Left');
%-------------------------------------------------------------------------







% %------------------Create the popup window warming and error-------------
% window_popupwarning;
% %------------------------------------------------------------------------




%---------------------Draw elements of the welcome page--------------------
window_welcome;
%--------------------------------------------------------------------------


%---------------------Draw elements of the analyser page-------------------
window_analyser;
%--------------------------------------------------------------------------


%---------------------Draw elements of the database page-------------------
window_database;
%--------------------------------------------------------------------------


%--------------------Draw elements of the benchmark page-------------------
window_benchmark;
%--------------------------------------------------------------------------



% WindowAPI(gcf, 'position', 'full');
handles.currentBenchmarkToggle = 0;
handles.PosMonitor = get(0, 'screensize');
% handles.TooltipMain.disptext = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'off', 'units', 'pixels', 'position', [1, 1, 10, 10], 'String', '', ...
%     'BackgroundColor', [1 1 0.7], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4-1, 'HorizontalAlignment', 'Center');
% handles.TooltipMain.mousepos = [0 0];
% handles.TooltipMain.activestatus = 0;
% handles.TooltipMain.isLastzone = 0;
% handles.timerTooltip = timer('TimerFcn', @timerCallbackTooltip, ...
%     'StartDelay', 0, 'Period', 3.5, 'Name', 'timerTooltip', ...
%     'ExecutionMode', 'fixedRate', 'BusyMode', 'drop');
% start(handles.timerTooltip);


handles.FigPos = get(handles.hf_w1_welcome, 'position');
guidata(handles.hf_w1_welcome, handles);
if ispc == 1;
    WindowAPI(handles.hf_w1_welcome, 'maximise');
    drawnow;
    handles.fullscreen = get(handles.hf_w1_welcome, 'position');
end;
set(handles.hf_w1_welcome, 'units', 'Normalized');
% clc;

delete(h);
