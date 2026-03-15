function [] = savedata_report_benchmark(varargin);


handles2 = guidata(gcf);
if ispc == 1;
    path = winqueryreg('HKEY_CURRENT_USER', 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Desktop');
    [filename, pathname] = uiputfile({'*.jpg', 'JPG File'}, 'Save Report As', [path '\' handles2.filename]);
    if isempty(pathname) == 1;
        return;
    end;
    if pathname == 0;
        return;
    end;
    filetosave = [pathname '\' filename];
    if isfile(filetosave) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' filetosave];
        [status, cmdout] = system(command);
    end;

elseif ismac == 1;
    user_name = char(java.lang.System.getProperty('user.name'));
    path = ['/Users/',user_name,'/Desktop'];
    [filename, pathname] = uiputfile({'*.jpg', 'JPG File'}, 'Save Report As', [path '/' handles2.filename]);
    if isempty(pathname) == 1;
        return;
    end;
    if pathname == 0;
        return;
    end;
    filetosave = [pathname '/' filename];
    if isfile(filetosave) == 1;
        command = ['rm -rf ' filetosave];
        [status, cmdout] = system(command);
    end;
end;

source = 'export';
if strcmpi(handles2.sourceReport, 'Ind');
    if handles2.Course == 25;
        if handles2.RaceDist == 50;
            nima = 1;
            create_SP1report_SCM50_benchmark;
        elseif handles2.RaceDist == 100;
            nima = 1;
            create_SP1report_SCM100_benchmark;
        elseif handles2.RaceDist == 150;
            nima = 1;
            create_SP1report_SCM150_benchmark;
        elseif handles2.RaceDist == 200;
            nima = 1;
            create_SP1report_SCM200_benchmark;
        elseif handles2.RaceDist == 400;
            nima = 1;
            create_SP1report_SCM400_benchmark;
        elseif handles2.RaceDist == 800;
            nima = 2;
            create_SP1report_SCM800_benchmark;
        elseif handles2.RaceDist == 1500;
            nima = 3;
            create_SP1report_SCM1500_benchmark;
        end;
    else;
        if handles2.RaceDist == 50;
            nima = 1;
            create_SP1report_LCM50_benchmark;
        elseif handles2.RaceDist == 100;
            nima = 1;
            create_SP1report_LCM100_benchmark;
        elseif handles2.RaceDist == 150;
            nima = 1;
            create_SP1report_LCM150_benchmark;
        elseif handles2.RaceDist == 200;
            nima = 1;
            create_SP1report_LCM200_benchmark;
        elseif handles2.RaceDist == 400;
            nima = 1;
            create_SP1report_LCM400_benchmark;
        elseif handles2.RaceDist == 800;
            nima = 2;
            create_SP1report_LCM800_benchmark;
        elseif handles2.RaceDist == 1500;
            nima = 3;
            create_SP1report_LCM1500_benchmark;
        end;
    end;
    hdef.Visible = 'off';
    hdef.InvertHardcopy = 'off'; 
    if nima == 2;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
    end;
    if nima == 3;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
        hdef3.Visible = 'off';
        hdef3.InvertHardcopy = 'off';
    end;
else;
    if handles2.Course == 25;
        if handles2.RaceDist == 50;
            nima = 2;
            create_SP1reportComp_SCM50_rankings;
        elseif handles2.RaceDist == 100;
            nima = 2;
            create_SP1reportComp_SCM100_rankings;
        elseif handles2.RaceDist == 150;
    
        elseif handles2.RaceDist == 200;
            nima = 3;
            create_SP1reportComp_SCM200_rankings;
        elseif handles2.RaceDist == 400;
            nima = 4;
            create_SP1reportComp_SCM400_rankings;
        elseif handles2.RaceDist == 800;
            nima = 7;
            create_SP1reportComp_SCM800_rankings;
        elseif handles2.RaceDist == 1500;
            nima = 11;
            create_SP1reportComp_SCM1500_rankings;
        end;
    else;
        if handles2.RaceDist == 50;
            nima = 1;
            create_SP1reportComp_LCM50_rankings;
        elseif handles2.RaceDist == 100;
            nima = 2;
            create_SP1reportComp_LCM100_rankings;
        elseif handles2.RaceDist == 150;
    
        elseif handles2.RaceDist == 200;
            nima = 2;
            create_SP1reportComp_LCM200_rankings;
        elseif handles2.RaceDist == 400;
            nima = 3;
            create_SP1reportComp_LCM400_rankings;
        elseif handles2.RaceDist == 800;
            nima = 4;
            create_SP1reportComp_LCM800_rankings;
        elseif handles2.RaceDist == 1500;
            nima = 7;
            create_SP1reportComp_LCM1500_rankings;
        end;
    end;
    hdef.Visible = 'off';
    hdef.InvertHardcopy = 'off'; 
    if nima == 2;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
    end;
    if nima == 3;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
        hdef3.Visible = 'off';
        hdef3.InvertHardcopy = 'off';
    end;
    if nima == 4;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
        hdef3.Visible = 'off';
        hdef3.InvertHardcopy = 'off';
        hdef4.Visible = 'off';
        hdef4.InvertHardcopy = 'off';
    end;
    if nima == 7;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
        hdef3.Visible = 'off';
        hdef3.InvertHardcopy = 'off';
        hdef4.Visible = 'off';
        hdef4.InvertHardcopy = 'off';
        hdef5.Visible = 'off';
        hdef5.InvertHardcopy = 'off';
        hdef6.Visible = 'off';
        hdef6.InvertHardcopy = 'off';
        hdef7.Visible = 'off';
        hdef7.InvertHardcopy = 'off';
    end;
    if nima == 11;
        hdef2.Visible = 'off';
        hdef2.InvertHardcopy = 'off';
        hdef3.Visible = 'off';
        hdef3.InvertHardcopy = 'off';
        hdef4.Visible = 'off';
        hdef4.InvertHardcopy = 'off';
        hdef5.Visible = 'off';
        hdef5.InvertHardcopy = 'off';
        hdef6.Visible = 'off';
        hdef6.InvertHardcopy = 'off';
        hdef7.Visible = 'off';
        hdef7.InvertHardcopy = 'off';
        hdef8.Visible = 'off';
        hdef8.InvertHardcopy = 'off';
        hdef9.Visible = 'off';
        hdef9.InvertHardcopy = 'off';
        hdef10.Visible = 'off';
        hdef10.InvertHardcopy = 'off';
        hdef11.Visible = 'off';
        hdef11.InvertHardcopy = 'off';
    end;
end;

tempFolder = handles.tempFolder;
[tempFolder, specialChar] = checkFilename(tempFolder);
if ismac == 1;
    if isdir(tempFolder) == 0;
        command = ['mkdir ' tempFolder];
    end;

    tempImage1 = [tempFolder '/Image1.jpg'];
    [tempImage1New, specialChar] = checkFilename(tempImage1);
    if isfile(tempImage1) == 1;
        command = ['rm -rf ' tempImage1New];
        [status, cmdout] = system(command);
    end;
    
    if nima == 2;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
    end;
        
    if nima == 3;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 4;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
        
        tempImage3 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        tempImage4 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 7;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
        
        tempImage3 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
        
        tempImage4 = [tempFolder '/Image4.jpg'];
        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            command = ['rm -rf ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '/Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            command = ['rm -rf ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '/Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            command = ['rm -rf ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '/Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            command = ['rm -rf ' tempImage7New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 11;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
        
        tempImage3 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
        
        tempImage4 = [tempFolder '/Image4.jpg'];
        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            command = ['rm -rf ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '/Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            command = ['rm -rf ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '/Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            command = ['rm -rf ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '/Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            command = ['rm -rf ' tempImage7New];
            [status, cmdout] = system(command);
        end;

        tempImage8 = [tempFolder '/Image8.jpg'];
        [tempImage8New, specialChar] = checkFilename(tempImage8);
        if isfile(tempImage8) == 1;
            command = ['rm -rf ' tempImage8New];
            [status, cmdout] = system(command);
        end;

        tempImage9 = [tempFolder '/Image9.jpg'];
        [tempImage9New, specialChar] = checkFilename(tempImage9);
        if isfile(tempImage9) == 1;
            command = ['rm -rf ' tempImage9New];
            [status, cmdout] = system(command);
        end;

        tempImage10 = [tempFolder '/Image10.jpg'];
        [tempImage10New, specialChar] = checkFilename(tempImage10);
        if isfile(tempImage10) == 1;
            command = ['rm -rf ' tempImage10New];
            [status, cmdout] = system(command);
        end;

        tempImage11 = [tempFolder '/Image11.jpg'];
        [tempImage11New, specialChar] = checkFilename(tempImage11);
        if isfile(tempImage11) == 1;
            command = ['rm -rf ' tempImage11New];
            [status, cmdout] = system(command);
        end;
    end;

elseif ispc == 1;
    if isdir(tempFolder) == 0;
        command = ['mkdir ' tempFolder];
    end;

    tempImage1 = [tempFolder '\Image1.jpg'];
    [tempImage1New, specialChar] = checkFilename(tempImage1);
    if isfile(tempImage1) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' tempImage1New];
        [status, cmdout] = system(command);
    end;

    if nima == 2;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;
    end;
        
    if nima == 3;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '\Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 4;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '\Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        tempImage4 = [tempFolder '\Image4.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage4New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 7;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '\Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        tempImage4 = [tempFolder '\Image4.jpg'];
        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '\Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '\Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '\Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage7New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 11;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '\Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        tempImage4 = [tempFolder '\Image4.jpg'];
        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '\Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '\Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '\Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage7New];
            [status, cmdout] = system(command);
        end;

        tempImage8 = [tempFolder '\Image8.jpg'];
        [tempImage8New, specialChar] = checkFilename(tempImage8);
        if isfile(tempImage8) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage8New];
            [status, cmdout] = system(command);
        end;

        tempImage9 = [tempFolder '\Image9.jpg'];
        [tempImage9New, specialChar] = checkFilename(tempImage9);
        if isfile(tempImage9) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage9New];
            [status, cmdout] = system(command);
        end;

        tempImage10 = [tempFolder '\Image10.jpg'];
        [tempImage10New, specialChar] = checkFilename(tempImage10);
        if isfile(tempImage10) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage10New];
            [status, cmdout] = system(command);
        end;

        tempImage11 = [tempFolder '\Image11.jpg'];
        [tempImage11New, specialChar] = checkFilename(tempImage11);
        if isfile(tempImage11) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage11New];
            [status, cmdout] = system(command);
        end;
    end;
end;

%---Check temporary folder exists
if ismac == 1;
    tempFolder = '/Applications/SP2Viewer/RaceDB/Temp';
    [tempFolder, specialChar] = checkFilename(tempFolder);
    command = ['rm -rf ' tempFolder];
    [status, cmdout] = system(command);

    command = ['mkdir ' tempFolder];
    [status, cmdout] = system(command);
    
elseif ispc == 1;
    tempFolder = [MDIR '\SP2viewer\RaceDB\Temp'];
    [tempFolder, specialChar] = checkFilename(tempFolder);
    command = ['rmdir /Q /S ' tempFolder];
    [status, cmdout] = system(command);

    command = ['mkdir ' tempFolder];
    [status, cmdout] = system(command);
end;


indexQuote = strfind(tempImage1, '"');
if isempty(indexQuote) == 0;
    tempImage1(indexQuote) = [];
end;
print(hdef,tempImage1,'-dpng','-r300');
if nima == 2;
    indexQuote = strfind(tempImage2, '"');
    if isempty(indexQuote) == 0;
        tempImage2(indexQuote) = [];
    end;
    print(hdef2,tempImage2,'-dpng','-r300');
end;
if nima == 3;
    indexQuote = strfind(tempImage2, '"');
    if isempty(indexQuote) == 0;
        tempImage2(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage3, '"');
    if isempty(indexQuote) == 0;
        tempImage3(indexQuote) = [];
    end;
    print(hdef2,tempImage2,'-dpng','-r300');
    print(hdef3,tempImage3,'-dpng','-r300');
end;
if nima == 4;
    indexQuote = strfind(tempImage2, '"');
    if isempty(indexQuote) == 0;
        tempImage2(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage3, '"');
    if isempty(indexQuote) == 0;
        tempImage3(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage4, '"');
    if isempty(indexQuote) == 0;
        tempImage4(indexQuote) = [];
    end;
    print(hdef2,tempImage2,'-dpng','-r300');
    print(hdef3,tempImage3,'-dpng','-r300');
    print(hdef4,tempImage4,'-dpng','-r300');
end;
if nima == 7;
    indexQuote = strfind(tempImage2, '"');
    if isempty(indexQuote) == 0;
        tempImage2(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage3, '"');
    if isempty(indexQuote) == 0;
        tempImage3(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage4, '"');
    if isempty(indexQuote) == 0;
        tempImage4(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage5, '"');
    if isempty(indexQuote) == 0;
        tempImage5(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage6, '"');
    if isempty(indexQuote) == 0;
        tempImage6(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage7, '"');
    if isempty(indexQuote) == 0;
        tempImage7(indexQuote) = [];
    end;
    print(hdef2,tempImage2,'-dpng','-r300');
    print(hdef3,tempImage3,'-dpng','-r300');
    print(hdef4,tempImage4,'-dpng','-r300');
    print(hdef5,tempImage5,'-dpng','-r300');
    print(hdef6,tempImage6,'-dpng','-r300');
    print(hdef7,tempImage7,'-dpng','-r300');
end;
if nima == 11;
    indexQuote = strfind(tempImage2, '"');
    if isempty(indexQuote) == 0;
        tempImage2(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage3, '"');
    if isempty(indexQuote) == 0;
        tempImage3(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage4, '"');
    if isempty(indexQuote) == 0;
        tempImage4(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage5, '"');
    if isempty(indexQuote) == 0;
        tempImage5(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage6, '"');
    if isempty(indexQuote) == 0;
        tempImage6(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage7, '"');
    if isempty(indexQuote) == 0;
        tempImage7(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage8, '"');
    if isempty(indexQuote) == 0;
        tempImage8(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage9, '"');
    if isempty(indexQuote) == 0;
        tempImage9(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage10, '"');
    if isempty(indexQuote) == 0;
        tempImage10(indexQuote) = [];
    end;
    indexQuote = strfind(tempImage11, '"');
    if isempty(indexQuote) == 0;
        tempImage11(indexQuote) = [];
    end;
    print(hdef2,tempImage2,'-dpng','-r300');
    print(hdef3,tempImage3,'-dpng','-r300');
    print(hdef4,tempImage4,'-dpng','-r300');
    print(hdef5,tempImage5,'-dpng','-r300');
    print(hdef6,tempImage6,'-dpng','-r300');
    print(hdef7,tempImage7,'-dpng','-r300');
    print(hdef8,tempImage8,'-dpng','-r300');
    print(hdef9,tempImage9,'-dpng','-r300');
    print(hdef10,tempImage10,'-dpng','-r300');
    print(hdef11,tempImage11,'-dpng','-r300');
end;
if nima == 1;
    I1 = imread(tempImage1);
    Ireport = I1;
elseif nima == 2;
    I1 = imread(tempImage1);
    I2 = imread(tempImage2);
    Ireport = [I1;I2];
elseif nima == 3;
    I1 = imread(tempImage1);
    I2 = imread(tempImage2);
    I3 = imread(tempImage3);
    Ireport = [I1;I2;I3];
elseif nima == 4;
    I1 = imread(tempImage1);
    I2 = imread(tempImage2);
    I3 = imread(tempImage3);
    I4 = imread(tempImage4);
    Ireport = [I1;I2;I3;I4];
elseif nima == 7;
    I1 = imread(tempImage1);
    I2 = imread(tempImage2);
    I3 = imread(tempImage3);
    I4 = imread(tempImage4);
    I5 = imread(tempImage5);
    I6 = imread(tempImage6);
    I7 = imread(tempImage7);
    Ireport = [I1;I2;I3;I4;I5;I6;I7];
elseif nima == 11;
    I1 = imread(tempImage1);
    I2 = imread(tempImage2);
    I3 = imread(tempImage3);
    I4 = imread(tempImage4);
    I5 = imread(tempImage5);
    I6 = imread(tempImage6);
    I7 = imread(tempImage7);
    I8 = imread(tempImage8);
    I9 = imread(tempImage9);
    I10 = imread(tempImage10);
    I11 = imread(tempImage11);
    Ireport = [I1;I2;I3;I4;I5;I6;I7;I8;I9;I10;I11];
end;





hdef_export = figure('Visible', 'off');
imshow(Ireport);
imwrite(Ireport, filetosave);
close(hdef_export);











% clear_figures;

if ismac == 1;
    [tempImage1New, specialChar] = checkFilename(tempImage1);
    if isfile(tempImage1) == 1;
        command = ['rm -rf ' tempImage1New];
        [status, cmdout] = system(command);
    end;

    if nima == 2;
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 3;
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 4;
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            command = ['rm -rf ' tempImage4New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 7;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
        
        tempImage3 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
        
        tempImage4 = [tempFolder '/Image4.jpg'];
        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            command = ['rm -rf ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '/Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            command = ['rm -rf ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '/Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            command = ['rm -rf ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '/Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            command = ['rm -rf ' tempImage7New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 7;
        tempImage2 = [tempFolder '/Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            command = ['rm -rf ' tempImage2New];
            [status, cmdout] = system(command);
        end;
        
        tempImage3 = [tempFolder '/Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            command = ['rm -rf ' tempImage3New];
            [status, cmdout] = system(command);
        end;
        
        tempImage4 = [tempFolder '/Image4.jpg'];
        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            command = ['rm -rf ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '/Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            command = ['rm -rf ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '/Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            command = ['rm -rf ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '/Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            command = ['rm -rf ' tempImage7New];
            [status, cmdout] = system(command);
        end;

        tempImage8 = [tempFolder '/Image8.jpg'];
        [tempImage8New, specialChar] = checkFilename(tempImage8);
        if isfile(tempImage8) == 1;
            command = ['rm -rf ' tempImage8New];
            [status, cmdout] = system(command);
        end;
        
        tempImage9 = [tempFolder '/Image9.jpg'];
        [tempImage8New, specialChar] = checkFilename(tempImage9);
        if isfile(tempImage9) == 1;
            command = ['rm -rf ' tempImage9New];
            [status, cmdout] = system(command);
        end;

        tempImage10 = [tempFolder '/Image10.jpg'];
        [tempImage10New, specialChar] = checkFilename(tempImage10);
        if isfile(tempImage10) == 1;
            command = ['rm -rf ' tempImage10New];
            [status, cmdout] = system(command);
        end;

        tempImage11 = [tempFolder '/Image11.jpg'];
        [tempImage11New, specialChar] = checkFilename(tempImage11);
        if isfile(tempImage11) == 1;
            command = ['rm -rf ' tempImage11New];
            [status, cmdout] = system(command);
        end;
    end;

elseif ispc == 1;
    [tempImage1New, specialChar] = checkFilename(tempImage1);
    if isfile(tempImage1) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' tempImage1New];
        [status, cmdout] = system(command);
    end;

    if nima == 2;
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 3;
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 4;
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        [tempImage4New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage4New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 7;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '\Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        tempImage4 = [tempFolder '\Image4.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '\Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '\Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '\Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage7New];
            [status, cmdout] = system(command);
        end;
    end;

    if nima == 11
        ;
        tempImage2 = [tempFolder '\Image2.jpg'];
        [tempImage2New, specialChar] = checkFilename(tempImage2);
        if isfile(tempImage2) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage2New];
            [status, cmdout] = system(command);
        end;

        tempImage3 = [tempFolder '\Image3.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage3);
        if isfile(tempImage3) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage3New];
            [status, cmdout] = system(command);
        end;

        tempImage4 = [tempFolder '\Image4.jpg'];
        [tempImage3New, specialChar] = checkFilename(tempImage4);
        if isfile(tempImage4) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage4New];
            [status, cmdout] = system(command);
        end;

        tempImage5 = [tempFolder '\Image5.jpg'];
        [tempImage5New, specialChar] = checkFilename(tempImage5);
        if isfile(tempImage5) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage5New];
            [status, cmdout] = system(command);
        end;

        tempImage6 = [tempFolder '\Image6.jpg'];
        [tempImage6New, specialChar] = checkFilename(tempImage6);
        if isfile(tempImage6) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage6New];
            [status, cmdout] = system(command);
        end;

        tempImage7 = [tempFolder '\Image7.jpg'];
        [tempImage7New, specialChar] = checkFilename(tempImage7);
        if isfile(tempImage7) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage7New];
            [status, cmdout] = system(command);
        end;

        tempImage8 = [tempFolder '\Image8.jpg'];
        [tempImage8New, specialChar] = checkFilename(tempImage8);
        if isfile(tempImage8) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage8New];
            [status, cmdout] = system(command);
        end;

        tempImage9 = [tempFolder '\Image9.jpg'];
        [tempImage9New, specialChar] = checkFilename(tempImage9);
        if isfile(tempImage9) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage9New];
            [status, cmdout] = system(command);
        end;

        tempImage10 = [tempFolder '\Image10.jpg'];
        [tempImage10New, specialChar] = checkFilename(tempImage10);
        if isfile(tempImage10) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage10New];
            [status, cmdout] = system(command);
        end;

        tempImage11 = [tempFolder '\Image11.jpg'];
        [tempImage11New, specialChar] = checkFilename(tempImage11);
        if isfile(tempImage11) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' tempImage11New];
            [status, cmdout] = system(command);
        end;
    end;

end;
