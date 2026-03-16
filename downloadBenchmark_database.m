if ispc == 1;
    [filename, pathname] = uiputfile({'*.xlsx', 'Excel File'}, 'Save Benchmark As', handles.lastPath_database);
elseif ismac == 1;
    [filename, pathname] = uiputfile({'*.xls', 'Excel File'}, 'Save Benchmark As', handles.lastPath_database);
end;

if isempty(pathname) == 1;
    return;
end;
if pathname == 0;
    return;
end;
handles.lastPath_database = pathname;
name = [pathname filename];

%Current colmn limit is 29... To change is adding more column to the export

checkedColDisp = ones(length(handles.listDropCol),1);
checked = handles.jCBModel.getCheckedIndicies;

for i = 1:length(checkedColDisp);
    if isempty(find(checked == i-1)) == 1;
        checkedColDisp(i, 1) = 0;
    else;
        checkedColDisp(i, 1) = 1;
    end;
end;

fullTitles = handles.FullDB(1,:);
selectedTitles = handles.FullDBTab(1,:);
col2exp = [];
for titleIter = 1:length(selectedTitles);
    titleEC = selectedTitles{titleIter};
    if titleEC ~= 0;

        for check = 1:length(fullTitles(1:end-4));
            checkVal = fullTitles{check};
            if findstr(lower(checkVal), lower(titleEC)) == 1;
                index = check;
            end;
        end;

%         index = find(contains(fullTitles(1:end-4),titleEC) == 1);
        charRef = length(titleEC);
        if length(index) > 1;
            for i = 1:length(index);
                indexEC = index(i);
                titleCheck = fullTitles{indexEC};
                charCheck = length(titleCheck);

                if charCheck == charRef;
                    indexOK = indexEC;
                end;
            end;
            index = indexOK;
        end;
        col2exp = [col2exp; index];
    end;
end;
dataTable = handles.FullDB(1,col2exp);
dataTable(2:length(handles.FullDBSort(:,1))+1,:) = handles.FullDBSort(:,2:end);

%change times to seconds
columnNameALL = {}; %find columns based on column name
columnNameALL{1} = 'Race Time';
columnNameALL{2} = 'Skills';
columnNameALL{3} = 'Free Swim';
for col2do = 1:3;
    columnNameEC = columnNameALL{col2do};
    titleAll = dataTable(1,2:end); %need to remove column 1 as it is the checkbox column
    findRaceTime = find(contains(titleAll,columnNameEC)) + 1; %need to add 1 to offset the first column that was removed
    if isempty(findRaceTime) == 0; %check the column is selected
        datasetEC = dataTable(:,findRaceTime);
        for rawEC = 2:length(datasetEC);
            dataOri = datasetEC{rawEC};
            if strcmpi(dataOri, 'na') == 0;
                indexSec = strfind(dataOri, 's');
                if isempty(indexSec) == 0;
                    %time already expressed in seconds with s in the string
                    dataConv = dataOri(1:indexSec-2);
                else;
                    %time in the minutes with a : to seperate minutes to
                    %seconds
                    indexSepar = strfind(dataOri, ':');
                    minupart = str2num(dataOri(1:indexSepar-1));
                    secpart = str2num(dataOri(indexSepar+1:end));
                    dataConv = num2str((minupart.*60) + secpart);
                end;
            else;
                dataConv = dataOri;
            end;
            datasetEC{rawEC} = dataConv;
        end;
        dataTable(:,findRaceTime) = datasetEC;
    end;
end;

% dataTable = handles.FullDB(1,2:30);
% dataTable(2:length(handles.FullDBSort(:,1))+1,:) = handles.FullDBSort(:,2:end);

if ispc == 1;
    exportstatusSheet1 = xlswrite(name, dataTable, 1);
elseif ismac == 1;
    javaaddpath('poi-3.8-20120326.jar');
    javaaddpath('poi-ooxml-3.8-20120326.jar');
    javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('xmlbeans-2.3.0.jar');
    javaaddpath('dom4j-1.6.1.jar');
    javaaddpath('stax-api-1.0.1.jar');

    xlwrite(name, dataTable, 'Benchmarks', 'A1');
    
end;
clc;