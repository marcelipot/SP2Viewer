function [] = downloadAllDB_database(varargin);


handles = guidata(gcf);

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

    %launch synchro UI
    source_user = 'All';
    fileListAWS = fileList;

    Synch_Waitbar;

%             %Display database
%             source = 'synch';
%             Disp_Database;
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

guidata(handles.hf_w1_welcome, handles);