P1 = get(handles.Question_button_database, 'position');
% P2 = get(handles.Downloaddata_button_database, 'position');
P3 = get(handles.Downloadraw_button_database, 'position');
P4 = get(handles.Downloadbenchmark_button_database, 'position');
P5 = get(handles.Downloadall_button_database, 'position');
P6 = get(handles.Downloadnew_button_database, 'position');
P7 = get(handles.Downloadselect_button_database, 'position');
P8 = get(handles.Arrowback_button_database, 'position');
P9 = get(handles.Validate_button_database, 'position');
P10 = get(handles.Redcross_button_database, 'position');
% P11 = get(handles.Downloadpeople_button_database, 'position');
P12 = get(handles.DownloadAMS_button_database, 'position');

%---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
% %     axes(handles.Question_button_database); imshow(handles.icones.question_offb);
% %     create_glossary;
% end;

%---create download data icone
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Downloaddata_button_database); imshow(handles.icones.downloaddata_offb);
%     
%     if isempty(handles.uidDB) == 1;
%         return;
%     end;
%     
%     selectfiles = find(handles.StatusColDBFull == 1)+1;
%     if isempty(selectfiles) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%         return;
%     end;
%     pathname = uigetdir(handles.lastPath_database);
%     
%     if isempty(pathname) == 1;
%         return;
%     end;
%     if pathname == 0;
%         return;
%     end;
%     handles.lastPath_database = pathname;
%     
%     clear_figures;
%     nbRaces = length(selectfiles);
%     RaceUID = [];
%     filenameTOT = {};
%     RaceDistList = {};
%     CourseList = {};
%     
%     nb_waitbar = nbRaces;
%     hexport = waitbar(0, 'Preparing data...  0% ');
%     
%     for raceEC = 1:nbRaces;
%         
%         scoreN = roundn(raceEC/nb_waitbar,-2);
%         scoreT = roundn(raceEC/nb_waitbar*100,0);
%         waitbar(scoreN, hexport, ['Preparing data...  ' num2str(scoreT) '%']);
%         
%         RaceUID{raceEC} = handles.uidDB{selectfiles(raceEC)-1,1};
%         RaceDistList{raceEC} = handles.uidDB{selectfiles(raceEC)-1,4};
%         CourseList{raceEC} = handles.uidDB{selectfiles(raceEC)-1,11};
%         
%         UID = RaceUID{raceEC};
%         li = findstr(UID, '-');
%         UID(li) = '_';
%         UID = ['A' UID 'A'];
%         
%         Meet = handles.uidDB{selectfiles(raceEC)-1,8};
%         Year = handles.uidDB{selectfiles(raceEC)-1,9};
%         loadTrialsAWS;
%         
%         eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
%         if findstr(valRelay, 'L.1');
%             valRelay = 'Leg1';
%         elseif findstr(valRelay, 'L.2');
%             valRelay = 'Leg2';
%         elseif findstr(valRelay, 'L.3');
%             valRelay = 'Leg3';
%         elseif findstr(valRelay, 'L.4');
%             valRelay = 'Leg4';
%         else;
%             valRelay = 'Flat';
%         end;
%         
%         filenameTOT{raceEC} = [handles.uidDB{selectfiles(raceEC)-1,2} '_' valRelay];
%     
%     end;
%     RaceUIDTOT = RaceUID;
%     nbRacesTOT = nbRaces;
%     waitbar(0, hexport, ['Exporting data...  0%']);
%     
%     
%     if ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         jFrame=get(handle(hexport), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     for raceExport = 1:nbRacesTOT;
%         nbRaces = 1;
%         RaceUID = RaceUIDTOT(raceExport);
%         
%         if ispc == 1;
%             filenameTable = [filenameTOT{raceExport} '_Tables.xlsx'];
%             if isfile(filenameTable) == 1;
%                 MDIR = getenv('USERPROFILE');
%                 command = ['del /Q /S ' filenameTable];
%                 [status, cmdout] = system(command);
%             end;
%         elseif ismac == 1;
%             filenameTable = [filenameTOT{raceExport} '_Tables.xls'];
%             if isfile(filenameTable) == 1;
%                 command = ['rm -rf ' filenameTable];
%                 [status, cmdout] = system(command);
%             end;
%         end;
%         
%         dataMatSplitsPacing = [];
%         dataMatCumSplitsPacing = [];
%     
%         saveTables_database;
%         scoreN = roundn(raceExport/nb_waitbar,-2);
%         scoreT = roundn(raceExport/nb_waitbar*100,0);
%         waitbar(scoreN, hexport, ['Exporting data...  ' num2str(scoreT) '%']);
%     end;
%     delete(hexport);
% end;

%---create download raw icone
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Downloadraw_button_database); imshow(handles.icones.downloadraw_offb);
%     
%     if isempty(handles.uidDB) == 1;
%         return;
%     end;
%     
%     selectfiles = find(handles.StatusColDBFull == 1)+1;
%     if isempty(selectfiles) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%         return;
%     end;
%     pathname = uigetdir(handles.lastPath_database);
%     if isempty(pathname) == 1;
%         return;
%     end;
%     if pathname == 0;
%         return;
%     end;
%     handles.lastPath_database = pathname;
%     
%     clear_figures;
%     nbRaces = length(selectfiles);
%     RaceUID = [];
%     filenameTOT = {};
%     RaceDistList = {};
%     CourseList = {};
%    
%     hexport = waitbar(0, 'Preparing data...  0% ');
%     for raceEC = 1:nbRaces;
%         RaceUID{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 1};
%         filenameTOT{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 2};
%         RaceDistList{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 4};
%         CourseList{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 11};
%         
%         UID = RaceUID{raceEC};
%         li = findstr(UID, '-');
%         UID(li) = '_';
%         UID = ['A' UID 'A'];
%         
%         Meet = handles.uidDB{selectfiles(raceEC)-1,8};
%         Year = handles.uidDB{selectfiles(raceEC)-1,9};
%         loadTrialsAWS;
%         
%         scoreN = roundn(raceEC/nbRaces,-2);
%         scoreT = roundn(raceEC/nbRaces*100,0);
%         waitbar(scoreN, hexport, ['Preparing data...  ' num2str(scoreT) '%']);
%     end;
%     downloadRawData_database;
% end;

%---create download benchmark benchmark icon
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     axes(handles.Downloadbenchmark_button_database); imshow(handles.icones.downloadbenchmark_offb);
% 
%     tableDisp = get(handles.databasemain_table_database, 'data');
%     if strcmpi(tableDisp{2,2}, 'No matching results') == 1;
%         return;
%     end;
%     downloadBenchmark_database;
% end;

%---create download AMS icon
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     axes(handles.DownloadAMS_button_database); imshow(handles.icones.AMS_offb);
% 
%     if isempty(handles.uidDB) == 1;
%         return;
%     end;
% 
%     selectfiles = find(handles.StatusColDBFull == 1)+1;
%     if isempty(selectfiles) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%         return;
%     end;
% 
%     handles2 = create_AMSExportOption_database;
%     AMSExportType = handles2.AMSExportType;
%     AMSExportHeader = handles2.AMSExportHeader;
%     AMSExportPath = handles2.AMSExportPath;
%     
%     if isempty(AMSExportPath) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%     end;
% 
%     hexport = waitbar(0, 'Preparing data...  0% ');
%     waitbar(0, hexport, ['Preparing data...  0%'], 'fontsize', 7);
%     if ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         jFrame=get(handle(hexport), 'javaframe');
%         jicon=javax.swing.ImageIcon([MDIR '\SP2viewer\SpartaLogoSmall.jpg']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     drawnow;
% 
%     clear_figures;
%     nbRaces = length(selectfiles);
%     RaceUID = [];
%     filenameTOT = {};
%     RaceDistList = {};
%     CourseList = {};
%     downloadAMS_database;
% 
% %     drawnow;
% end;


%---create download all
% if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
%     axes(handles.Downloadall_button_database); imshow(handles.icones.cloudall_offb);
% 
% %     if isempty(handles.uidDB) == 0;
%         [connected,timing] = isnetavl;
%         if connected == 1;
% 
%             if ispc == 1;
%                 fontEC = 14;
%             elseif ismac == 1;
%                 fontEC = 16;
%             end;
%             resolution = get(0,'ScreenSize');
%             resolution = resolution(1,3:4);
%             pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
%             h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
%                 'color', [0 0 0], 'units', 'pixels','position', pos,'windowstyle','modal', ...
%                 'Name', 'Scanning', 'NumberTitle', 'off');
%             h1 = uicontrol('parent', h, 'style', 'text', ...
%                 'string', 'Scanning S3 bucket ...', 'units', 'pixels', ...
%                 'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
%                 'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
%                 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
%                 'FontWeight', 'Bold', 'Fontsize', fontEC);
%                 
%             drawnow;
% 
%             sourceAWS = 'download';
%             establishAWSconnection;
%             if ispc == 1;
%                 command = 'aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive';
%                 [status, out] = system(command);
%             elseif ismac == 1;
%                 command = [handles.AWSFolder '/aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive'];                    
%                 [status, out] = system(command);
%             end;
% 
%             liSP2 = findstr(out,'sparta2');
%             liMAT = findstr(out,'.mat');
%             fileList = {};
%             for line = 1:length(liMAT);
%                 valEC = liMAT(line);
%                 li1 = find(liSP2 - valEC < 0);
%                 sortSP2 = liSP2(li1(end));
%                 fileList{line,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+3])];
%             end;
% 
%             %launch synchro UI
%             source_user = 'All';
%             fileListAWS = fileList;
% 
%             Synch_Waitbar;
% 
% %             %Display database
% %             source = 'synch';
% %             Disp_Database;
%         else;
%             errorwindow = errordlg('No Internet Connection', 'Error');
%             if ispc == 1;
%                 MDIR = getenv('USERPROFILE');
%                 jFrame = get(handle(errorwindow), 'javaframe');
%                 jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                 jFrame.setFigureIcon(jicon);
%                 clc;
%             end;
%         end;
% %     end;
% end;

%---create download new
% if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
%     axes(handles.Downloadnew_button_database); imshow(handles.icones.cloudnew_offb);
% 
%     [connected,timing] = isnetavl;
%     if connected == 1;
% 
%         if ispc == 1;
%             fontEC = 14;
%         elseif ismac == 1;
%             fontEC = 16;
%         end;
%         resolution = get(0,'ScreenSize');
%         resolution = resolution(1,3:4);
%         pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
%         h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
%             'color', [0 0 0], 'units', 'pixels','position', pos,'windowstyle','modal', ...
%             'Name', 'Scanning', 'NumberTitle', 'off');
%         h1 = uicontrol('parent', h, 'style', 'text', ...
%             'string', 'Scanning S3 bucket ...', 'units', 'pixels', ...
%             'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
%             'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
%             'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
%             'FontWeight', 'Bold', 'Fontsize', fontEC);
%             
%         drawnow;
% 
%         sourceAWS = 'download';
%         establishAWSconnection;
%         if ispc == 1;
%             command = 'aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive';
%             [status, out] = system(command);
%         elseif ismac == 1;
%             command = [handles.AWSFolder '/aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive'];                    
%             [status, out] = system(command);
%         end;
% 
%         liSP2 = findstr(out,'sparta2');
%         liMAT = findstr(out,'.mat');
%         fileList = {};
%         for line = 1:length(liMAT);
%             valEC = liMAT(line);
%             li1 = find(liSP2 - valEC < 0);
%             sortSP2 = liSP2(li1(end));
%             fileList{line,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+3])];
%         end;
% 
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             fileTarget = [MDIR '\SP2Viewer\RaceDB\'];
%         elseif ismac == 1;
%             fileTarget = '/Applications/SP2Viewer/RaceDB/';
%         end;
%         dirTarget = regexp(genpath(fileTarget),['[^;]*'],'match');
% 
%         %launch synchro UI
%         fileListAWS = fileList;
%         fileListAWSUpdate = {};
%         fileListAWSNew = {};
%         iterUpdate = 1;
%         iterNew = 1;
% %         if isempty(handles.uidDB) == 0;
%             for file = 1:length(fileListAWS);
%                 noneed = [];
%                 fileECOri = fileListAWS{file};
%                 li = strfind(fileECOri, '/');
%                 fileEC = fileECOri(li(end)+1:end);
%                 for dirCount = 1:length(dirTarget);
%                     dirEC = dirTarget{dirCount};
%                     index = isfile([dirEC '\' fileEC]);
%                     noneed = [noneed index];
%                 end;
%                 index = find(noneed == 1);
%                 if isempty(index) == 1;
%                     fileListAWSNew{iterNew,1} = fileECOri;
%                     iterNew = iterNew + 1;
%                 end;
%             end;
% %         else;
% %             for file = 1:length(fileListAWS);
% %                 fileECOri = fileListAWS{file};
% %                 li = strfind(fileECOri, '/');
% %                 fileEC = fileECOri(li(end)+1:end);
% %                 fileListAWSNew{iterNew,1} = fileECOri;
% %                 iterNew = iterNew + 1;
% %             end;
% %         end;
% 
%         %launch synchro UI
%         source_user = 'Update';
%         Synch_Waitbar;
%         
% %         %Display database
% %         source = 'Synch';
% %         Disp_Database;
%     else;
%         errorwindow = errordlg('No Internet Connection', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame = get(handle(errorwindow), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%     end;
% end;

%---create download selected
% if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
%     axes(handles.Downloadselect_button_database); imshow(handles.icones.cloudselect_offb);
% 
%     if isempty(handles.uidDB) == 0;
%         selectfiles = find(handles.StatusColDBFull == 1)+1;
%         if isempty(selectfiles) == 0;
%             [connected,timing] = isnetavl;
%             if connected == 1;
% 
%                 if ispc == 1;
%                     fontEC = 14;
%                 elseif ismac == 1;
%                     fontEC = 16;
%                 end;
%                 resolution = get(0,'ScreenSize');
%                 resolution = resolution(1,3:4);
%                 pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
%                 h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
%                     'color', [0 0 0], 'units', 'pixels','position', pos,'windowstyle','modal', ...
%                     'Name', 'Scanning', 'NumberTitle', 'off');
%                 h1 = uicontrol('parent', h, 'style', 'text', ...
%                     'string', 'Scanning S3 bucket ...', 'units', 'pixels', ...
%                     'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
%                     'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
%                     'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
%                     'FontWeight', 'Bold', 'Fontsize', fontEC);
%                     
%                 drawnow;
% 
%                 sourceAWS = 'download';
%                 establishAWSconnection;
%                 if ispc == 1;
%                     command = 'aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive';
%                     [status, out] = system(command);
%                 elseif ismac == 1;
%                     command = [handles.AWSFolder '/aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive'];                    
%                     [status, out] = system(command);
%                 end;
% 
%                 liSP2 = findstr(out,'sparta2');
%                 liMAT = findstr(out,'.mat');
%                 fileList = {};
%                 for line = 1:length(liMAT);
%                     valEC = liMAT(line);
%                     li1 = find(liSP2 - valEC < 0);
%                     sortSP2 = liSP2(li1(end));
%                     fileList{line,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+3])];
%                 end;
%                 fileListAWS = fileList;
% 
%                 for file = 1:length(selectfiles);
% %                     filename = handles.uidDB{selectfiles(file)-1,3}
% %                     pause(1)
% %                     filename = handles.uidDB{selectfiles(file)-1,13};
%                     filename = handles.uidDB{selectfiles(file)-1,1};
%                     index = strfind(filename, '-');
%                     filename(index) = '_';
%                     filename = ['A' filename 'A'];
% 
%                     Index = find(contains(fileListAWS, filename)); 
%                     fileListAWSNew{file,1} = fileListAWS{Index};
%                 end;
%                 fileListAWS = fileListAWSNew;
%                 
%                 close(h);
% 
%                 %launch synchro UI
%                 source_user= 'Select';
%                 Synch_Waitbar;
% 
% %                 %Display database
% %                 source = 'Synch';
% %                 Disp_Database;
%                 
%             else;
%                 errorwindow = errordlg('No Internet Connection', 'Error');
%                 if ispc == 1;
%                     MDIR = getenv('USERPROFILE');
%                     jFrame = get(handle(errorwindow), 'javaframe');
%                     jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
%                     jFrame.setFigureIcon(jicon);
%                     clc;
%                 end;
%             end;
%         end;
%     end;
% end;

%---create arrow back icone
% if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
%     axes(handles.Arrowback_button_database); imshow(handles.icones.arrow_back_offb);
% %     drawnow;
% 
%     %---Show elemennts
%     set(handles.Question_button_database, 'Visible', 'off');
%     set(allchild(handles.Question_button_database), 'Visible', 'off');
% %     set(handles.Downloaddata_button_database, 'Visible', 'off');
% %     set(allchild(handles.Downloaddata_button_database), 'Visible', 'off');
%     set(handles.Downloadraw_button_database, 'Visible', 'off'); 
%     set(allchild(handles.Downloadraw_button_database), 'Visible', 'off');
%     set(handles.Downloadbenchmark_button_database, 'Visible', 'off');
%     set(allchild(handles.Downloadbenchmark_button_database), 'Visible', 'off');
%     set(handles.DownloadAMS_button_database, 'Visible', 'off');
%     set(allchild(handles.DownloadAMS_button_database), 'Visible', 'off');
%     set(handles.Downloadall_button_database, 'Visible', 'off');
%     set(allchild(handles.Downloadall_button_database), 'Visible', 'off');
%     set(handles.Downloadnew_button_database, 'Visible', 'off');
%     set(allchild(handles.Downloadnew_button_database), 'Visible', 'off');
%     set(handles.Downloadselect_button_database, 'Visible', 'off');
%     set(allchild(handles.Downloadselect_button_database), 'Visible', 'off');
%     set(handles.Arrowback_button_database, 'Visible', 'off');
%     set(allchild(handles.Arrowback_button_database), 'Visible', 'off');
%     set(handles.Validate_button_database, 'Visible', 'off');
%     set(allchild(handles.Validate_button_database), 'Visible', 'off');
%     set(handles.Redcross_button_database, 'Visible', 'off');
%     set(allchild(handles.Redcross_button_database), 'Visible', 'off');
% %     set(allchild(handles.Downloadpeople_button_database), 'Visible', 'off');
%     set(handles.databasemain_table_database, 'Visible', 'off');
% 
%     set(handles.tabledisplaytxt1_database, 'Visible', 'off');
%     set(handles.popDisplayResults_database, 'Visible', 'off', 'enable', 'off');
%     set(handles.databasedisplayoptions_database, 'Visible', 'off');
%     set(handles.databasefilteroptions_database, 'Visible', 'off');
%     set(handles.databasefilteroptions_database, 'Visible', 'off');
% 
%     %---Show axes welcome
%     set(handles.logo_sparta_main, 'Visible', 'on');
%     set(allchild(handles.logo_sparta_main), 'Visible', 'on');
%     set(handles.logo_sparta_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_analyser_main, 'Visible', 'on');
%     set(allchild(handles.logo_analyser_main), 'Visible', 'on');
%     set(handles.logo_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_database_main, 'Visible', 'on');
%     set(allchild(handles.logo_database_main), 'Visible', 'on');
%     set(handles.logo_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_benchmark_main, 'Visible', 'on');
%     set(allchild(handles.logo_benchmark_main), 'Visible', 'on');
%     set(handles.logo_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_analyser_main, 'Visible', 'on');
% %     set(allchild(handles.start_analyser_main), 'Visible', 'on');
% %     set(handles.start_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_database_main, 'Visible', 'on');
% %     set(allchild(handles.start_database_main), 'Visible', 'on');
% %     set(handles.start_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_benchmark_main, 'Visible', 'on');
% %     set(allchild(handles.start_benchmark_main), 'Visible', 'on');
% %     set(handles.start_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     uistack(handles.logo_sparta_main, 'top');
%     uistack(handles.logo_analyser_main, 'top');
%     uistack(handles.logo_database_main, 'top');
%     uistack(handles.logo_benchmark_main, 'top');
%     uistack(handles.start_analyser_main, 'top');
%     uistack(handles.start_database_main, 'top');
%     uistack(handles.start_benchmark_main, 'top');
%     
%     %---Show uicontrols welcome
%     set(handles.txtlasupdate_main, 'Visible', 'on');
%     set(handles.txtsoftwareversion_main, 'Visible', 'on');
%     set(handles.txtwelcome_main, 'Visible', 'on');
%     set(handles.txtlogo_analyser_main, 'Visible', 'on');
%     set(handles.txtlogo_database_main, 'Visible', 'on');
%     set(handles.txtlogo_benchmark_main, 'Visible', 'on');
%     set(handles.tasktodo_main, 'Visible', 'on');
%     set(handles.txtlasupdate_main, 'String', ['Database last update: ' handles.LastUpdate]);
% 
%     set(handles.txtpage, 'string', 'Welcome');
% end;

%---create validate icone
% if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
%     axes(handles.Validate_button_database); imshow(handles.icones.validate_offb);
%     
%     if isempty(handles.uidDB) == 0;
%         %Display database
%         source = 'Filter';
%         Disp_Database;
%         
%         handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
%     end;
% end;

%---create clear icone
% if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
%     axes(handles.Redcross_button_database); imshow(handles.icones.redcross_offb);
% 
%     if isempty(handles.uidDB) == 0;
%         %reset search
%         handles.jCBModel.checkAll;
%         handles.checkedColDisp = ones(length(handles.listDropCol),1);
%         
%         set(handles.popSort_database, 'value', 1);
%         handles.sortbyCurrentSelection = 1;
% 
%         handles.SearchMeet = [];
%         handles.SearchYear = [];
%         handles.SearchName = [];
%         handles.SearchMeet = [];
%         handles.SearchGender = [];
%         handles.SearchSwimType = [];
%         handles.SearchStrokeType = [];
%         handles.SearchDistance = [];
%         handles.SearchPoolType = [];
%         handles.SearchCategory = [];
%         handles.SearchRaceType = [];
%         handles.SearchAgeGroup = [];
%         handles.SearchPB = [];
%         
%         set(handles.filteredit_meet_database, 'String', 'Meet');
%         set(handles.filteredit_year_database, 'String', 'Year');
%         set(handles.filteredit_name_database, 'String', 'Name');
%         set(handles.filterpop_gender_database, 'Value', 1);
%         set(handles.filterpop_type_database, 'Value', 1);
%         set(handles.filterpop_stroke_database, 'Value', 1);
%         set(handles.filterpop_distance_database, 'Value', 1);
%         set(handles.filterpop_pool_database, 'Value', 1);
%         set(handles.filterpop_category_database, 'Value', 1);
%         set(handles.filterpop_relay_database, 'Value', 1);
%         set(handles.filterpop_group_database, 'Value', 1);
%         set(handles.filterpop_time_database, 'Value', 1);
%         
%         handles.sortbyExceptionSelection = 1;
%         %Display database
%         source = 'Filter';
%         Disp_Database;
%         
%         handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
%     end;
% end;

% %---create download people icon
% if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
%     axes(handles.Downloadpeople_button_database); imshow(handles.icones.people_offb);
%     
%     %---Load the internal parameters
%     [filename, pathname] = uigetfile({'*.xlsx';'*.*'}, 'Select an athletes database', handles.lastPath_database);
%     if filename == 0;
%         return;
%     end;
%     handles.lastPath_database = pathname;
%     name = [pathname filename];
% 
%     if ismac == 1;
%         load /Applications/SP2Viewer/SP2viewerDB.mat;
%     elseif ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         load([MDIR '\SP2Viewer\SP2viewerDB.mat']);
%     end;
%     clear AthletesDB;
%     clear ParaDB;
%     
%     [tableAll, headerAll] = xlsread(name, 1);
%     [tablePara, headerPara] = xlsread(name, 2);
%     
%     for i = 2:length(headerAll(:,1));
%         AthletesDBNames{i-1,1} = headerAll{i,7};
%         AthletesDBNames{i-1,2} = headerAll{i,8};
%         
%         if isempty(headerAll{i,5}) == 1;
%             AthletesDBDOB{i-1,1} = '01/01/2000';
%         else;
%             AthletesDBDOB{i-1,1} = headerAll{i,5};
%         end;
%         if isempty(headerAll{i,4}) == 1;
%             AthletesDBNat{i-1,1} = 'AUS';
%         else;
%             AthletesDBNat{i-1,1} = headerAll{i,4};
%         end;
%     end;
%     AthletesDBID(:,1) = tableAll(:,1);
%     AthletesDBGender(:,1) = tableAll(:,6);
% 
%     AthletesDB.Names = AthletesDBNames;
%     AthletesDB.AMSID = AthletesDBID;
%     AthletesDB.DOB = AthletesDBDOB;
%     AthletesDB.Nat = AthletesDBNat;
%     AthletesDB.Gender = AthletesDBGender;
%     
%     for i = 2:length(headerPara(:,1));
%         ParaDBNames{i-1,1} = headerPara{i,2};
%         ParaDBNames{i-1,2} = headerPara{i,3};
%         
%         if isempty(headerPara{i,5}) == 1;
%             ParaDBDOB{i-1,1} = '01/01/2000';
%         else;
%             ParaDBDOB{i-1,1} = headerPara{i,5};
%         end;
%         if isempty(headerPara{i,4}) == 1;
%             ParaDBNat{i-1,1} = 'AUS';
%         else;
%             ParaDBNat{i-1,1} = headerPara{i,4};
%         end;
%     end;
%     ParaDBID(:,1) = tablePara(:,1);
%     ParaDB.Names = ParaDBNames;
%     ParaDB.AMSID = ParaDBID;
%     ParaDB.DOB = ParaDBDOB;
%     ParaDB.AMSNat = ParaDBNat;
%     
%     if ismac == 1;
%         DBname = '/Applications/SP2Viewer/SP2viewerDB.mat';
%     elseif ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         DBname = [MDIR '\SP2Viewer\SP2viewerDB.mat'];
%     end;
%     save(DBname, 'AthletesDB', 'FullDB', 'LastUpdate', 'ParaDB', 'PBsDB', 'PBsDB_SC', 'uidDB', 'AgeGroup', 'BenchmarkEvents');
%     
%     if ismac == 1;
%         load /Applications/SP2Viewer/SP2viewerDB.mat;
%     elseif ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         load([MDIR '\SP2Viewer\SP2viewerDB.mat']);
%     end;
%     handles.AthletesDB = AthletesDB;
%     handles.ParaDB = ParaDB;
%     handles.uidDB = uidDB;
%     handles.FullDB = FullDB;
%     handles.PBsDB = PBsDB;
%     handles.PBsDB_SC = PBsDB_SC;
%     handles.LastUpdate = LastUpdate;    
%     handles.BenchmarkEvents = BenchmarkEvents;
%     handles.AgeGroup = AgeGroup;
% end;


