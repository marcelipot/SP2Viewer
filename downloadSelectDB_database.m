function [] = downloadSelectDB_database(varargin);


handles = guidata(gcf);

if isempty(handles.uidDB) == 0;
    selectfiles = find(handles.StatusColDBFull == 1)+1;
    if isempty(selectfiles) == 0;
        [connected,timing] = isnetavl;
        if connected == 1;

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
                'Name', 'Scanning', 'NumberTitle', 'off');
            h1 = uicontrol('parent', h, 'style', 'text', ...
                'string', 'Scanning S3 bucket ...', 'units', 'pixels', ...
                'position', [1 40 298 30], 'HorizontalAlignment', 'center', ...
                'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
                'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                'FontWeight', 'Bold', 'Fontsize', fontEC);
                
            drawnow;

            sourceAWS = 'download';
            establishAWSconnection;
            if ispc == 1;
                command = 'aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive';
                [status, out] = system(command);
            elseif ismac == 1;
                command = [handles.AWSFolder '/aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive'];                    
                [status, out] = system(command);
            end;

            liSP2 = findstr(out,'sparta2');
            liMAT = findstr(out,'.mat');
            fileList = {};
            for line = 1:length(liMAT);
                valEC = liMAT(line);
                li1 = find(liSP2 - valEC < 0);
                sortSP2 = liSP2(li1(end));
                fileList{line,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+3])];
            end;
            fileListAWS = fileList;

            for file = 1:length(selectfiles);
%                     filename = handles.uidDB{selectfiles(file)-1,3}
%                     pause(1)
%                     filename = handles.uidDB{selectfiles(file)-1,13};
                filename = handles.uidDB{selectfiles(file)-1,1};
                index = strfind(filename, '-');
                filename(index) = '_';
                filename = ['A' filename 'A'];

                Index = find(contains(fileListAWS, filename)); 
                fileListAWSNew{file,1} = fileListAWS{Index};
            end;
            fileListAWS = fileListAWSNew;
            
            close(h);

            %launch synchro UI
            source_user= 'Select';
            Synch_Waitbar;

%                 %Display database
%                 source = 'Synch';
%                 Disp_Database;
            
        else;
            errorwindow = errordlg('No Internet Connection', 'Error');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame = get(handle(errorwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;
    end;
end;

guidata(handles.hf_w1_welcome, handles);