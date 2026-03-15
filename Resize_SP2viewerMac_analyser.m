function [] = Resize_SP2viewerMac_analyser(varargin)

persistent blockCalls  % Reject calling this function again until it is finished
if any(blockCalls);
    return;
end
blockCalls = true;


handles = guidata(gcf);

%---Question
set(handles.Question_button_analyser, 'units', 'pixels');
pos = get(handles.Question_button_analyser, 'position');
set(handles.Question_button_analyser, 'cdata', imresize(handles.icones.question_offb, [pos(3) pos(4)]));
set(handles.Question_button_analyser, 'units', 'normalized');

%---PDF
set(handles.Reportpdf_button_analyser, 'units', 'pixels');
pos = get(handles.Reportpdf_button_analyser, 'position');
set(handles.Reportpdf_button_analyser, 'cdata', imresize(handles.icones.saveReport_offb, [pos(3) pos(4)]));
set(handles.Reportpdf_button_analyser, 'units', 'normalized');

%---TAB
set(handles.Save_button_analyser, 'units', 'pixels');
pos = get(handles.Save_button_analyser, 'position');
set(handles.Save_button_analyser, 'cdata', imresize(handles.icones.saveTab_offb, [pos(3) pos(4)]));
set(handles.Save_button_analyser, 'units', 'normalized');

%---RAW
set(handles.Download_button_analyser, 'units', 'pixels');
pos = get(handles.Download_button_analyser, 'position');
set(handles.Download_button_analyser, 'cdata', imresize(handles.icones.saveRaw_offb, [pos(3) pos(4)]));
set(handles.Download_button_analyser, 'units', 'normalized');

%---Full screen
set(handles.Fullscreen_button_analyser, 'units', 'pixels');
pos = get(handles.Fullscreen_button_analyser, 'position');
set(handles.Fullscreen_button_analyser, 'cdata', imresize(handles.icones.fullscreen_offb, [pos(3) pos(4)]));
set(handles.Fullscreen_button_analyser, 'units', 'normalized');

%---Arrow back
set(handles.Arrowback_button_analyser, 'units', 'pixels');
pos = get(handles.Arrowback_button_analyser, 'position');
set(handles.Arrowback_button_analyser, 'cdata', imresize(handles.icones.arrow_back_offb, [pos(3) pos(4)]));
set(handles.Arrowback_button_analyser, 'units', 'normalized');

%---Add Plus
set(handles.AddFile_button_analyser, 'units', 'pixels');
pos = get(handles.AddFile_button_analyser, 'position');
set(handles.AddFile_button_analyser, 'cdata', imresize(handles.icones.plus_offb, [pos(3) pos(4)]));
set(handles.AddFile_button_analyser, 'units', 'normalized');

%---Remove Minus
set(handles.RemoveFile_button_analyser, 'units', 'pixels');
pos = get(handles.RemoveFile_button_analyser, 'position');
set(handles.RemoveFile_button_analyser, 'cdata', imresize(handles.icones.minus_offb, [pos(3) pos(4)]));
set(handles.RemoveFile_button_analyser, 'units', 'normalized');

%---Delete Cross
set(handles.RemoveAllFile_button_analyser, 'units', 'pixels');
pos = get(handles.RemoveAllFile_button_analyser, 'position');
set(handles.RemoveAllFile_button_analyser, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.RemoveAllFile_button_analyser, 'units', 'normalized');

% screen = get(0,'screensize');
% screen = screen(3:4)
% handles = guidata(gcf);
% PosFigPrev = handles.PosFigPrev


try;
    handles = guidata(gcf);
    PosFigPrev = handles.PosFigPrev;

    sizemod = 0;
    screen = get(0,'screensize');
    screen = screen(3:4);
    set(gcf, 'units', 'pixels');
    PosFig = get(gcf, 'Position');
    
    if PosFig(3) == screen(1);
        if PosFig(4) ~= screen(2);
            PosFig(4) = screen(2);
            sizemod = 1;
        end;
    end;
    if PosFig(4) == screen(2);
        if PosFig(3) ~= screen(1);
            PosFig(3) = screen(1);
            sizemod = 1;
        end;
    end;
    
    if sizemod == 0;
        if isempty(PosFigPrev) == 0;
            if PosFigPrev(3) ~=  PosFig(3) & PosFigPrev(4) ==  PosFig(4);
                %Resize from the sides
                if PosFig(3) ~= screen(1);
                    if PosFig(3)./1.7778 ~= PosFig(4);
                        PosFig(4) = roundn(PosFig(3)./1.7778,0);
                        sizemod = 1;
                    end;
                end;
            elseif PosFigPrev(3) ==  PosFig(3) & PosFigPrev(4) ~=  PosFig(4);
                %Resize from top/bottom
                if PosFig(4) ~= screen(2);
                    if PosFig(4).*1.7778 ~= PosFig(3);
                        PosFig(3) = roundn(PosFig(4).*1.7778,0);
                        sizemod = 1;
                    end;
                end;
                
            elseif PosFigPrev(3) ~=  PosFig(3) & PosFigPrev(4) ~=  PosFig(4);
                %Resize from angles
                if PosFig(3) ~= screen(1);
                    if PosFig(3)./1.7778 ~= PosFig(4);
                        PosFig(4) = roundn(PosFig(3)./1.7778,0);
                        sizemod = 1;
                    end;
                end;
            end;
        end;
        
        if PosFig(3) < 800;
            PosFig(3) = 800;
            PosFig(4) = 450;
            sizemod = 1;
        elseif PosFig(4) < 450;
            PosFig(3) = 800;
            PosFig(4) = 450;
            sizemod = 1;
        end;
    end;
    
    if sizemod == 1;
        set(gcf, 'position', PosFig);
    end;    
    
    if isempty(handles.dataTableSummary) == 0;
        nbRaces = length(handles.filelistAdded);
        set(handles.SummaryData_table_analyser, 'units', 'pixels');
        %pos = get(handles.SummaryData_table_analyser, 'position');
        
        PosTableBottom = (0.0069*PosFig(4));
        PosTable = get(handles.DataPanel_toggle_analyser, 'position');
        PosTableLeft = PosTable(1)*PosFig(3);
        PosTableTop = PosTable(2)*PosFig(4) - ((5./720)*PosFig(4));
        PosTableHeight = PosTable(2)*PosFig(4) - PosTableBottom - ((5./720)*PosFig(4));
        PosTable = get(handles.SummaryData_Panel_analyser, 'position');
        PosTableWidth = PosTable(1)*PosFig(3) - PosTableLeft - ((5./720)*PosFig(3));
        PixelTot = PosTableWidth;
        
        PixelSwimmers = (PixelTot - 100 - 150)./nbRaces;
        if PixelSwimmers < 200;
            PixelSwimmers = 200;
            ColWidth = {100 150};
            Extent = 0;
        else;
            ColWidth = {100 149};
            Extent = 1;
        end;
        for i = 3:nbRaces+2;
            ColWidth{i} = PixelSwimmers;
        end;
        set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
        
        table_extent = get(handles.SummaryData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.SummaryData_table_analyser, 'Position');

        if table_extent(4) > table_position(4);
            offset = 18;
            PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
            if PixelSwimmers < 200;
                PixelSwimmers = 200;
                ColWidth = {100 150};
                Extent = 0;
            else;
                ColWidth = {100 149};
                Extent = 1;
            end;
            for i = 3:nbRaces+2;
                ColWidth{i} = PixelSwimmers;
            end;
        end;
        
        set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
        table_extent = get(handles.SummaryData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.SummaryData_table_analyser, 'Position');
        pos_cor = table_position;

        if table_extent(4) < table_position(4);

            if Extent == 0;
                %Add 5% to give space for the slider bar at the bottom
                offset = 18;
                pos_cor(2) = PosTableTop-table_extent(4)-offset;
                pos_cor(4) = table_extent(4)+offset;
            else;
                pos_cor(2) = PosTableTop-table_extent(4);
                pos_cor(4) = table_extent(4);
            end;

        elseif table_extent(4) >= table_position(4);
            if table_position(2) < (0.0069*PosFig(4));
                pos_cor(2) = PosTableBottom+1;
                pos_cor(4) = PosTableHeight+1;
                %there is a bar on the side: need to remove some pixel
                %to col
                offset = 18;
                PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                if PixelSwimmers < 200;
                    PixelSwimmers = 200;
                    ColWidth = {100 150};
                    Extent = 0;
                else;
                    ColWidth = {100 149};
                    Extent = 1;
                end;
                for i = 3:nbRaces+2;
                    ColWidth{i} = PixelSwimmers;
                end;
                set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                
                if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                    pos_cor(2) = PosTableBottom+1;
                    pos_cor(4) = PosTableHeight+1;
                    %there is a bar on the side: need to remove some pixel
                    %to col
                    offset = 18;
                    PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                    if PixelSwimmers < 200;
                        PixelSwimmers = 200;
                        ColWidth = {100 150};
                        Extent = 0;
                    else;
                        ColWidth = {100 149};
                        Extent = 1;
                    end;
                    for i = 3:nbRaces+2;
                        ColWidth{i} = PixelSwimmers;
                    end;
                    set(handles.SummaryData_table_analyser, 'ColumnWidth', ColWidth);
                    
                else;
                    if Extent == 0;
                        offset = 18;
                        pos_cor(2) = PosTableTop-table_extent(4)+1-offset;
                        pos_cor(4) = table_extent(4)+offset;
                    else;
                        pos_cor(2) = PosTableTop-table_extent(4);
                        pos_cor(4) = table_extent(4);
                    end;
                end;
            end;
        end;

        if Extent == 1;
            if table_extent(3) > table_position(3);
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = table_extent(3);
            else;
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = PosTableWidth;
            end;
        else;
            pos_cor(1) = PosTableLeft;
            pos_cor(3) = PosTableWidth;
        end;
        set(handles.SummaryData_table_analyser, 'Position', pos_cor);
        set(handles.SummaryData_table_analyser, 'Units', 'normalized');

        PosEND = get(handles.SummaryData_table_analyser, 'Position');
        PosEND = PosEND(3);
        handles.diffPosSummaryTable = PosEND - handles.PosINI_SummaryTable;
        
    end;
    
    

    if isempty(handles.dataTableStroke) == 0;
        nbRaces = length(handles.filelistAdded);
        set(handles.StrokeData_table_analyser, 'units', 'pixels');
        %pos = get(handles.SummaryData_table_analyser, 'position');
        
        PosTableBottom = (0.0069*PosFig(4));
        PosTable = get(handles.DataPanel_toggle_analyser, 'position');
        PosTableLeft = PosTable(1)*PosFig(3);
        PosTableTop = PosTable(2)*PosFig(4) - ((5./720)*PosFig(4));
        PosTableHeight = PosTable(2)*PosFig(4) - PosTableBottom - ((5./720)*PosFig(4));
        PosTable = get(handles.SummaryData_Panel_analyser, 'position');
        PosTableWidth = PosTable(1)*PosFig(3) - PosTableLeft - ((5./720)*PosFig(3));
        PixelTot = PosTableWidth;
        
        PixelSwimmers = (PixelTot - 100 - 150)./nbRaces;
        if PixelSwimmers < 200;
            PixelSwimmers = 200;
            ColWidth = {100 150};
            Extent = 0;
        else;
            ColWidth = {100 149};
            Extent = 1;
        end;
        for i = 3:nbRaces+2;
            ColWidth{i} = PixelSwimmers;
        end;
        set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
        
        table_extent = get(handles.StrokeData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.StrokeData_table_analyser, 'Position');

        if table_extent(4) > table_position(4);
            offset = 18;
            PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
            if PixelSwimmers < 200;
                PixelSwimmers = 200;
                ColWidth = {100 150};
                Extent = 0;
            else;
                ColWidth = {100 149};
                Extent = 1;
            end;
            for i = 3:nbRaces+2;
                ColWidth{i} = PixelSwimmers;
            end;
        end;
        
        set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
        table_extent = get(handles.StrokeData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.StrokeData_table_analyser, 'Position');
        pos_cor = table_position;

        if table_extent(4) < table_position(4);

            if Extent == 0;
                %Add 5% to give space for the slider bar at the bottom
                offset = 18;
                pos_cor(2) = PosTableTop-table_extent(4)-offset;
                pos_cor(4) = table_extent(4)+offset;
            else;
                pos_cor(2) = PosTableTop-table_extent(4);
                pos_cor(4) = table_extent(4);
            end;

        elseif table_extent(4) >= table_position(4);
            if table_position(2) < (0.0069*PosFig(4));
                pos_cor(2) = PosTableBottom+1;
                pos_cor(4) = PosTableHeight+1;
                offset = 18;
                PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                if PixelSwimmers < 200;
                    PixelSwimmers = 200;
                    ColWidth = {100 150};
                    Extent = 0;
                else;
                    ColWidth = {100 149};
                    Extent = 1;
                end;
                for i = 3:nbRaces+2;
                    ColWidth{i} = PixelSwimmers;
                end;
                set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                
                if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                    pos_cor(2) = PosTableBottom+1;
                    pos_cor(4) = PosTableHeight+1;
                    %there is a bar on the side: need to remove some pixel
                    %to col
                    offset = 18;
                    PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                    if PixelSwimmers < 200;
                        PixelSwimmers = 200;
                        ColWidth = {100 150};
                        Extent = 0;
                    else;
                        ColWidth = {100 149};
                        Extent = 1;
                    end;
                    for i = 3:nbRaces+2;
                        ColWidth{i} = PixelSwimmers;
                    end;
                    set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
                else;
                    if Extent == 0;
                        offset = 18;
                        pos_cor(2) = PosTableTop-table_extent(4)+1-offset;
                        pos_cor(4) = table_extent(4)+offset;
                    else;
                        pos_cor(2) = PosTableTop-table_extent(4);
                        pos_cor(4) = table_extent(4);
                    end;
                end;
            end;
        end;

        if Extent == 1;
            if table_extent(3) > table_position(3);
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = table_extent(3);
            else;
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = PosTableWidth;
            end;
        else;
            pos_cor(1) = PosTableLeft;
            pos_cor(3) = PosTableWidth;
        end;
        set(handles.StrokeData_table_analyser, 'Position', pos_cor);
        set(handles.StrokeData_table_analyser, 'Units', 'normalized');

        PosEND = get(handles.StrokeData_table_analyser, 'Position');
        PosEND = PosEND(3);
        handles.diffPosStrokeTable = PosEND - handles.PosINI_StrokeTable;
        
    end;
    
    
    if isempty(handles.dataTablePacing) == 0;
        nbRaces = length(handles.filelistAdded);
        set(handles.PacingData_table_analyser, 'units', 'pixels');
        %pos = get(handles.SummaryData_table_analyser, 'position');
        
        PosTableBottom = (0.0069*PosFig(4));
        PosTable = get(handles.DataPanel_toggle_analyser, 'position');
        PosTableLeft = PosTable(1)*PosFig(3);
        PosTableTop = PosTable(2)*PosFig(4) - ((5./720)*PosFig(4));
        PosTableHeight = PosTable(2)*PosFig(4) - PosTableBottom - ((5./720)*PosFig(4));
        PosTable = get(handles.SummaryData_Panel_analyser, 'position');
        PosTableWidth = PosTable(1)*PosFig(3) - PosTableLeft - ((5./720)*PosFig(3));
        PixelTot = PosTableWidth;
        
        PixelSwimmers = (PixelTot - 100 - 150)./nbRaces;
        if PixelSwimmers < 200;
            PixelSwimmers = 200;
            ColWidth = {100 150};
            Extent = 0;
        else;
            ColWidth = {100 149};
            Extent = 1;
        end;
        for i = 3:nbRaces+2;
            ColWidth{i} = PixelSwimmers;
        end;
        set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
        
        table_extent = get(handles.PacingData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.PacingData_table_analyser, 'Position');

        if table_extent(4) > table_position(4);
            offset = 18;
            PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
            if PixelSwimmers < 200;
                PixelSwimmers = 200;
                ColWidth = {100 150};
                Extent = 0;
            else;
                ColWidth = {100 149};
                Extent = 1;
            end;
            for i = 3:nbRaces+2;
                ColWidth{i} = PixelSwimmers;
            end;
        end;
        
        set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
        table_extent = get(handles.PacingData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.PacingData_table_analyser, 'Position');
        pos_cor = table_position;

        if table_extent(4) < table_position(4);

            if Extent == 0;
                %Add 5% to give space for the slider bar at the bottom
                offset = 18;
                pos_cor(2) = PosTableTop-table_extent(4)-offset;
                pos_cor(4) = table_extent(4)+offset;
            else;
                pos_cor(2) = PosTableTop-table_extent(4);
                pos_cor(4) = table_extent(4);
            end;

        elseif table_extent(4) >= table_position(4);
            if table_position(2) < (0.0069*PosFig(4));
                pos_cor(2) = PosTableBottom+1;
                pos_cor(4) = PosTableHeight+1;
                %there is a bar on the side: need to remove some pixel
                %to col
                offset = 18;
                PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                if PixelSwimmers < 200;
                    PixelSwimmers = 200;
                    ColWidth = {100 150};
                    Extent = 0;
                else;
                    ColWidth = {100 149};
                    Extent = 1;
                end;
                for i = 3:nbRaces+2;
                    ColWidth{i} = PixelSwimmers;
                end;
                set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                
                if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                    pos_cor(2) = PosTableBottom+1;
                    pos_cor(4) = PosTableHeight+1;
                    %there is a bar on the side: need to remove some pixel
                    %to col
                    offset = 18;
                    PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                    if PixelSwimmers < 200;
                        PixelSwimmers = 200;
                        ColWidth = {100 150};
                        Extent = 0;
                    else;
                        ColWidth = {100 149};
                        Extent = 1;
                    end;
                    for i = 3:nbRaces+2;
                        ColWidth{i} = PixelSwimmers;
                    end;
                    set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
                else;
                    if Extent == 0;
                        offset = 18;
                        pos_cor(2) = PosTableTop-table_extent(4)+1-offset;
                        pos_cor(4) = table_extent(4)+offset;
                    else;
                        pos_cor(2) = PosTableTop-table_extent(4);
                        pos_cor(4) = table_extent(4);
                    end;
                end;
            end;
        end;

        if Extent == 1;
            if table_extent(3) > table_position(3);
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = table_extent(3);
            else;
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = PosTableWidth;
            end;
        else;
            pos_cor(1) = PosTableLeft;
            pos_cor(3) = PosTableWidth;
        end;
        set(handles.PacingData_table_analyser, 'Position', pos_cor);
        set(handles.PacingData_table_analyser, 'Units', 'normalized');

        PosEND = get(handles.PacingData_table_analyser, 'Position');
        PosEND = PosEND(3);
        handles.diffPosPacingTable = PosEND - handles.PosINI_PacingTable;
        
    end;
    
    
    if isempty(handles.dataTableSkill) == 0;
        nbRaces = length(handles.filelistAdded);
        set(handles.SkillData_table_analyser, 'units', 'pixels');
        %pos = get(handles.SummaryData_table_analyser, 'position');
        
        PosTableBottom = (0.0069*PosFig(4));
        PosTable = get(handles.DataPanel_toggle_analyser, 'position');
        PosTableLeft = PosTable(1)*PosFig(3);
        PosTableTop = PosTable(2)*PosFig(4) - ((5./720)*PosFig(4));
        PosTableHeight = PosTable(2)*PosFig(4) - PosTableBottom - ((5./720)*PosFig(4));
        PosTable = get(handles.SummaryData_Panel_analyser, 'position');
        PosTableWidth = PosTable(1)*PosFig(3) - PosTableLeft - ((5./720)*PosFig(3));
        PixelTot = PosTableWidth;
        
        PixelSwimmers = (PixelTot - 100 - 150)./nbRaces;
        if PixelSwimmers < 200;
            PixelSwimmers = 200;
            ColWidth = {100 150};
            Extent = 0;
        else;
            ColWidth = {100 149};
            Extent = 1;
        end;
        for i = 3:nbRaces+2;
            ColWidth{i} = PixelSwimmers;
        end;
        set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
        
        table_extent = get(handles.SkillData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.SkillData_table_analyser, 'Position');

        if table_extent(4) > table_position(4);
            offset = 18;
            PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
            if PixelSwimmers < 200;
                PixelSwimmers = 200;
                ColWidth = {100 150};
                Extent = 0;
            else;
                ColWidth = {100 149};
                Extent = 1;
            end;
            for i = 3:nbRaces+2;
                ColWidth{i} = PixelSwimmers;
            end;
        end;
        
        set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
        table_extent = get(handles.SkillData_table_analyser, 'Extent');
        set(gcf, 'position', PosFig);
        table_position = get(handles.SkillData_table_analyser, 'Position');
        pos_cor = table_position;

        if table_extent(4) < table_position(4);

            if Extent == 0;
                %Add 5% to give space for the slider bar at the bottom
                offset = 18;
                pos_cor(2) = PosTableTop-table_extent(4)-offset;
                pos_cor(4) = table_extent(4)+offset;
            else;
                pos_cor(2) = PosTableTop-table_extent(4);
                pos_cor(4) = table_extent(4);
            end;

        elseif table_extent(4) >= table_position(4);
            if table_position(2) < (0.0069*PosFig(4));
                pos_cor(2) = PosTableBottom+1;
                pos_cor(4) = PosTableHeight+1;
                %there is a bar on the side: need to remove some pixel
                %to col
                offset = 18;
                PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                if PixelSwimmers < 200;
                    PixelSwimmers = 200;
                    ColWidth = {100 150};
                    Extent = 0;
                else;
                    ColWidth = {100 149};
                    Extent = 1;
                end;
                for i = 3:nbRaces+2;
                    ColWidth{i} = PixelSwimmers;
                end;
                set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
            else;
                
                if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
                    pos_cor(2) = PosTableBottom+1;
                    pos_cor(4) = PosTableHeight+1;
                    %there is a bar on the side: need to remove some pixel
                    %to col
                    offset = 18;
                    PixelSwimmers = (PixelTot - 100 - 150 - offset)./nbRaces;
                    if PixelSwimmers < 200;
                        PixelSwimmers = 200;
                        ColWidth = {100 150};
                        Extent = 0;
                    else;
                        ColWidth = {100 149};
                        Extent = 1;
                    end;
                    for i = 3:nbRaces+2;
                        ColWidth{i} = PixelSwimmers;
                    end;
                    set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
                else;
                    if Extent == 0;
                        offset = 18;
                        pos_cor(2) = PosTableTop-table_extent(4)+1-offset;
                        pos_cor(4) = table_extent(4)+offset;
                    else;
                        pos_cor(2) = PosTableTop-table_extent(4);
                        pos_cor(4) = table_extent(4);
                    end;
                end;
            end;
        end;

        if Extent == 1;
            if table_extent(3) > table_position(3);
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = table_extent(3);
            else;
                pos_cor(1) = PosTableLeft;
                pos_cor(3) = PosTableWidth;
            end;
        else;
            pos_cor(1) = PosTableLeft;
            pos_cor(3) = PosTableWidth;
        end;
        set(handles.SkillData_table_analyser, 'Position', pos_cor);
        set(handles.SkillData_table_analyser, 'Units', 'normalized');

        PosEND = get(handles.SkillData_table_analyser, 'Position');
        PosEND = PosEND(3);
        handles.diffPosSkillTable = PosEND - handles.PosINI_SkillTable;
        
    end;
    

    set(gcf, 'units', 'normalized');
    try;
        handles.PosFigPrev = PosFig;
        guidata(handles.hf_w1_welcome, handles);
    end;
end;

try;
    handles = guidata(gcf);
    fontsizeLevel1 = 12;
    fontsizeLevel2 = 10;
    
    set(handles.hf_w1_welcome, 'units', 'pixels');
    figpos = get(handles.hf_w1_welcome, 'position');
    set(handles.hf_w1_welcome, 'units', 'normalized');
    fontsizeLevel1Norm = (fontsizeLevel1./720).*figpos(4);
    fontsizeLevel2Norm = (fontsizeLevel2./720).*figpos(4);
    
    diff1 = (fontsizeLevel1Norm-fontsizeLevel1).*0.7;
    diff2 = (fontsizeLevel2Norm-fontsizeLevel2).*0.7;
    fontsizeLevel1Norm = fontsizeLevel1Norm-diff1;
    fontsizeLevel2Norm = fontsizeLevel2Norm-diff2;
    
    for BoxEC = 1:nbRaces;
        set(handles.UIskillpanel.txt_titlestart{BoxEC}, 'FontSize', fontsizeLevel1Norm);
        set(handles.UIskillpanel.txt_TimeTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_TimeVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_EntryDistTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_EntryDistVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_RTTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_RTVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_BODistTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_BODistVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_BOSkillTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_BOSkillVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_UWKTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_UWKVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_UWSkillTXTstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        set(handles.UIskillpanel.txt_UWSkillVALstart{BoxEC}, 'FontSize', fontsizeLevel2Norm);
         
        try;
            set(handles.UIskillpanel.txt_titleturn{BoxEC}, 'FontSize', fontsizeLevel1Norm);
            set(handles.UIskillpanel.txt_TimeTXTturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_TimeVALturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_AppSkillTXTturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_AppSkillVALturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_GlideWallTXTturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_GlideWallVALturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_BODistTXTturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_BODistVALturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_BOSkillTXTturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_BOSkillVALturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_UWKTXTturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
            set(handles.UIskillpanel.txt_UWKVALturn{BoxEC}, 'FontSize', fontsizeLevel2Norm);
        end;
%         try;
%             set(handles.UIskillpanel.txt_TimeVAL2turn{BoxEC}, 'FontSize', fontsizeLevel3Norm);
%             set(handles.UIskillpanel.txt_AppSkillVAL2turn{BoxEC}, 'FontSize', fontsizeLevel3Norm);
%             set(handles.UIskillpanel.txt_GlideWallVAL2turn{BoxEC}, 'FontSize', fontsizeLevel3Norm);
%             set(handles.UIskillpanel.txt_BODistVAL2turn{BoxEC}, 'FontSize', fontsizeLevel3Norm);
%             set(handles.UIskillpanel.txt_BOSkillVAL2turn{BoxEC}, 'FontSize', fontsizeLevel3Norm);
%             set(handles.UIskillpanel.txt_UWKVAL2turn{BoxEC}, 'FontSize', fontsizeLevel3Norm);
%         end;
    end;
end;

try;
    set(handles.hf_w1_welcome, 'units', 'normalized');
end;

blockCalls = false;  % Allow further calls again

