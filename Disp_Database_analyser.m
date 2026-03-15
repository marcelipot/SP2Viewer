if ismac == 1;
    load('/Applications/SP2Viewer/SP2viewerDB.mat');

elseif ispc == 1;
    MDIR = getenv('USERPROFILE');
    load([MDIR '\SP2Viewer\SP2viewerDB.mat']);
end;

if isempty(FullDB) == 0;
    set(handles2.table_analyser, 'units', 'pixels');
    posTable = get(handles2.table_analyser, 'position');
    set(handles2.table_analyser, 'units', 'normalized');
    datatable_analyser = {};
    
    %---Select matching trials
    apply_FilterTrials_analyser;
    
    if isempty(database) == 0;
        databaseTab = titles;
        databaseTab(2:length(database(:,1))+1,:) = database;
        
        %---Display      
        colFormat_analyser;
        colorrow(1,:) = [1 0.9 0.1];
        [nRaw, nCol] = size(databaseTab);    
        for raw = 2:nRaw;
            if rem(raw,2) == 1;
                %odd
                colorrow(raw,:) = [0.75 0.75 0.75];
            else;
                %even
                colorrow(raw,:) = [0.9 0.9 0.9];
            end;
        end;
        handles2.FullDBTab = databaseTab;
    else;
        
        ColWidth{1} = 20; %empty
        ColWidth{2} = posTable(3)-ColWidth{1}-1; %Message
        ColFormat{1} = 'char';
        ColFormat{2} = 'char';
        ColEdit(1) = false;
        ColEdit(2) = false;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [0.9 0.9 0.9];
        
        databaseTab{2,2} = 'No matching results';
        handles2.FullDBTab = databaseTab;
    end;

    if ismac == 1;
        font = 10;
    elseif ispc == 1;
        font = 8;
    end;

    if isempty(database) == 0;
        %Col 1:30 Original columns. Might require an update
        set(handles2.table_analyser, 'data', handles2.FullDBTab(:,1:30), ...
            'ColumnWidth', ColWidth, 'backgroundcolor', colorrow, ...
            'ColumnFormat', ColFormat, 'ColumnEditable', ColEdit, ...
            'Visible', 'on', 'units', 'pixels', 'rowstriping', 'on', ...
            'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', font);
    else;
        set(handles2.table_analyser, 'data', handles2.FullDBTab, ...
            'ColumnWidth', ColWidth, 'backgroundcolor', colorrow, ...
            'ColumnFormat', ColFormat, 'ColumnEditable', ColEdit, ...
            'Visible', 'on', 'units', 'pixels', 'rowstriping', 'on', ...
            'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', font);
    end;

    set(handles2.table_analyser, 'Units', 'Normalized');
    
end;

