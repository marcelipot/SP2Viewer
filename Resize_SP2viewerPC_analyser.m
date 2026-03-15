function [] = Resize_SP2viewerPC_analyser(varargin)


persistent blockCalls;  % Reject calling this function again until it is finished
persistent blockPos;

if any(blockPos);
    blockPos = false;
    return;
end;
if any(blockCalls);
    return;
end
blockCalls = true;

handles = guidata(gcf);


%------Analyser
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


%--------Benchmarks
%---Question
set(handles.Question_button_benchmark, 'units', 'pixels');
pos = get(handles.Question_button_benchmark, 'position');
set(handles.Question_button_benchmark, 'cdata', imresize(handles.icones.question_offb, [pos(3) pos(4)]));
set(handles.Question_button_benchmark, 'units', 'normalized');

%---JPG
set(handles.Save_button_benchmark, 'units', 'pixels');
pos = get(handles.Save_button_benchmark, 'position');
set(handles.Save_button_benchmark, 'cdata', imresize(handles.icones.saveJPG_offb, [pos(3) pos(4)]));
set(handles.Save_button_benchmark, 'units', 'normalized');

%---PDF
set(handles.Reportpdf_button_benchmark, 'units', 'pixels');
pos = get(handles.Reportpdf_button_benchmark, 'position');
set(handles.Reportpdf_button_benchmark, 'cdata', imresize(handles.icones.saveReport_offb, [pos(3) pos(4)]));
set(handles.Reportpdf_button_benchmark, 'units', 'normalized');

%---SEG
set(handles.Download_button_benchmark, 'units', 'pixels');
pos = get(handles.Download_button_benchmark, 'position');
set(handles.Download_button_benchmark, 'cdata', imresize(handles.icones.saveSeg_offb, [pos(3) pos(4)]));
set(handles.Download_button_benchmark, 'units', 'normalized');

%---Full screen
set(handles.Refreshcloud_button_benchmark, 'units', 'pixels');
pos = get(handles.Refreshcloud_button_benchmark, 'position');
set(handles.Refreshcloud_button_benchmark, 'cdata', imresize(handles.icones.reset_offb, [pos(3) pos(4)]));
set(handles.Refreshcloud_button_benchmark, 'units', 'normalized');

%---Arrow back
set(handles.Arrowback_button_benchmark, 'units', 'pixels');
pos = get(handles.Arrowback_button_benchmark, 'position');
set(handles.Arrowback_button_benchmark, 'cdata', imresize(handles.icones.arrow_back_offb, [pos(3) pos(4)]));
set(handles.Arrowback_button_benchmark, 'units', 'normalized');

%---Clear rankings
set(handles.ClearSearchRanking_benchmark, 'units', 'pixels');
pos = get(handles.ClearSearchRanking_benchmark, 'position');
set(handles.ClearSearchRanking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearSearchRanking_benchmark, 'units', 'normalized');

%---Search rankings
set(handles.ValidateSearchRanking_benchmark, 'units', 'pixels');
pos = get(handles.ValidateSearchRanking_benchmark, 'position');
set(handles.ValidateSearchRanking_benchmark, 'cdata', imresize(handles.icones.validate_offb, [pos(3) pos(4)]));
set(handles.ValidateSearchRanking_benchmark, 'units', 'normalized');

%---Delete template
set(handles.deleteTemplateCustom_button_benchmark, 'units', 'pixels');
pos = get(handles.deleteTemplateCustom_button_benchmark, 'position');
set(handles.deleteTemplateCustom_button_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.deleteTemplateCustom_button_benchmark, 'units', 'normalized');

%---Add file
set(handles.AddFile_button_benchmark, 'units', 'pixels');
pos = get(handles.AddFile_button_benchmark, 'position');
set(handles.AddFile_button_benchmark, 'cdata', imresize(handles.icones.plus_offb, [pos(3) pos(4)]));
set(handles.AddFile_button_benchmark, 'units', 'normalized');

%---clear custom
set(handles.ClearCustom_button_benchmark, 'units', 'pixels');
pos = get(handles.ClearCustom_button_benchmark, 'position');
set(handles.ClearCustom_button_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearCustom_button_benchmark, 'units', 'normalized');

%---Save template
set(handles.saveComparison_button_benchmark, 'units', 'pixels');
pos = get(handles.saveComparison_button_benchmark, 'position');
set(handles.saveComparison_button_benchmark, 'cdata', imresize(handles.icones.save_onb, [pos(3) pos(4)]));
set(handles.saveComparison_button_benchmark, 'units', 'normalized');


%---Clear profile
set(handles.ClearSearchProfile_benchmark, 'units', 'pixels');
pos = get(handles.ClearSearchProfile_benchmark, 'position');
set(handles.ClearSearchProfile_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearSearchProfile_benchmark, 'units', 'normalized');

%---validate profile
set(handles.ValidateSearchProfile_benchmark, 'units', 'pixels');
pos = get(handles.ValidateSearchProfile_benchmark, 'position');
set(handles.ValidateSearchProfile_benchmark, 'cdata', imresize(handles.icones.validate_offb, [pos(3) pos(4)]));
set(handles.ValidateSearchProfile_benchmark, 'units', 'normalized');



%---Delete race 1
set(handles.ClearRace1Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace1Ranking_benchmark, 'position');
set(handles.ClearRace1Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace1Ranking_benchmark, 'units', 'normalized');

%---Delete race 2
set(handles.ClearRace2Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace2Ranking_benchmark, 'position');
set(handles.ClearRace2Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace2Ranking_benchmark, 'units', 'normalized');

%---Delete race 3
set(handles.ClearRace3Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace3Ranking_benchmark, 'position');
set(handles.ClearRace3Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace3Ranking_benchmark, 'units', 'normalized');

%---Delete race 4
set(handles.ClearRace4Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace4Ranking_benchmark, 'position');
set(handles.ClearRace4Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace4Ranking_benchmark, 'units', 'normalized');

%---Delete race 5
set(handles.ClearRace5Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace5Ranking_benchmark, 'position');
set(handles.ClearRace5Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace5Ranking_benchmark, 'units', 'normalized');

%---Delete race 6
set(handles.ClearRace6Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace6Ranking_benchmark, 'position');
set(handles.ClearRace6Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace6Ranking_benchmark, 'units', 'normalized');

%---Delete race 7
set(handles.ClearRace7Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace7Ranking_benchmark, 'position');
set(handles.ClearRace7Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace7Ranking_benchmark, 'units', 'normalized');

%---Delete race 8
set(handles.ClearRace8Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace8Ranking_benchmark, 'position');
set(handles.ClearRace8Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace8Ranking_benchmark, 'units', 'normalized');

%---Delete race 9
set(handles.ClearRace9Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace9Ranking_benchmark, 'position');
set(handles.ClearRace9Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace9Ranking_benchmark, 'units', 'normalized');

%---Delete race 10
set(handles.ClearRace10Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace10Ranking_benchmark, 'position');
set(handles.ClearRace10Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace10Ranking_benchmark, 'units', 'normalized');


%-----Database
%---Question
set(handles.Question_button_database, 'units', 'pixels');
pos = get(handles.Question_button_database, 'position');
set(handles.Question_button_database, 'cdata', imresize(handles.icones.question_offb, [pos(3) pos(4)]));
set(handles.Question_button_database, 'units', 'normalized');

%---JPG
set(handles.Downloadraw_button_database, 'units', 'pixels');
pos = get(handles.Downloadraw_button_database, 'position');
set(handles.Downloadraw_button_database, 'cdata', imresize(handles.icones.saveTab_offb, [pos(3) pos(4)]));
set(handles.Downloadraw_button_database, 'units', 'normalized');

%---PDF
set(handles.Downloadbenchmark_button_database, 'units', 'pixels');
pos = get(handles.Downloadbenchmark_button_database, 'position');
set(handles.Downloadbenchmark_button_database, 'cdata', imresize(handles.icones.saveRaw_offb, [pos(3) pos(4)]));
set(handles.Downloadbenchmark_button_database, 'units', 'normalized');

%---SEG
set(handles.DownloadAMS_button_database, 'units', 'pixels');
pos = get(handles.DownloadAMS_button_database, 'position');
set(handles.DownloadAMS_button_database, 'cdata', imresize(handles.icones.saveSeg_offb, [pos(3) pos(4)]));
set(handles.DownloadAMS_button_database, 'units', 'normalized');

%---Cloud all
set(handles.Downloadall_button_database, 'units', 'pixels');
pos = get(handles.Downloadall_button_database, 'position');
set(handles.Downloadall_button_database, 'cdata', imresize(handles.icones.cloudall_offb, [pos(3) pos(4)]));
set(handles.Downloadall_button_database, 'units', 'normalized');

%---Cloud New
set(handles.Downloadnew_button_database, 'units', 'pixels');
pos = get(handles.Downloadnew_button_database, 'position');
set(handles.Downloadnew_button_database, 'cdata', imresize(handles.icones.cloudnew_offb, [pos(3) pos(4)]));
set(handles.Downloadnew_button_database, 'units', 'normalized');

%---Cloud Select
set(handles.Downloadselect_button_database, 'units', 'pixels');
pos = get(handles.Downloadselect_button_database, 'position');
set(handles.Downloadselect_button_database, 'cdata', imresize(handles.icones.cloudselect_offb, [pos(3) pos(4)]));
set(handles.Downloadselect_button_database, 'units', 'normalized');

%---Arrow back
set(handles.Arrowback_button_database, 'units', 'pixels');
pos = get(handles.Arrowback_button_database, 'position');
set(handles.Arrowback_button_database, 'cdata', imresize(handles.icones.arrow_back_offb, [pos(3) pos(4)]));
set(handles.Arrowback_button_database, 'units', 'normalized');

%---Validate
set(handles.Validate_button_database, 'units', 'pixels');
pos = get(handles.Validate_button_database, 'position');
set(handles.Validate_button_database, 'cdata', imresize(handles.icones.validate_offb, [pos(3) pos(4)]));
set(handles.Validate_button_database, 'units', 'normalized');

%---Delete
set(handles.Redcross_button_database, 'units', 'pixels');
pos = get(handles.Redcross_button_database, 'position');
set(handles.Redcross_button_database, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.Redcross_button_database, 'units', 'normalized');




try;
    handles = guidata(gcf);
    PosFigPrev = handles.PosFigPrev;

    sizemod = 0;
    set(gcf, 'units', 'pixels');
    PosFig = get(gcf, 'Position');

    if PosFig(3) >= handles.fullscreen(3);
        if PosFig(4) < handles.fullscreen(4);
            PosFig = handles.fullscreen;
            sizemod = 1;
        end;
    end;
    if PosFig(4) >= handles.fullscreen(4);
        if PosFig(3) < handles.fullscreen(3);
            PosFig = handles.fullscreen;
            sizemod = 1;
        end;
    end;
    if sizemod == 0;
        if isempty(PosFigPrev) == 0;
            if PosFigPrev(3) ~=  PosFig(3) & PosFigPrev(4) ==  PosFig(4);
                %Resize from the sides
                if PosFig(3) < handles.fullscreen(3);
                    if PosFig(3)./1.7778 ~= PosFig(4);
                        PosFig(4) = roundn(PosFig(3)./1.7778,0);
                        PosFig(1) = (handles.fullscreen(3)-PosFig(3))./2;
                        if PosFig(1) == 0;
                            PosFig(1) = 1;
                        end;
                        PosFig(2) = (handles.fullscreen(4)-PosFig(4))./2;
                        if PosFig(2) == 0;
                            PosFig(2) = 1;
                        end;
                        sizemod = 1;
                    end;
                end;
            elseif PosFigPrev(3) ==  PosFig(3) & PosFigPrev(4) ~=  PosFig(4);
                %Resize from top/bottom
                if PosFig(4) < handles.fullscreen(4);
                    if PosFig(4).*1.7778 ~= PosFig(3);
                        PosFig(3) = roundn(PosFig(4).*1.7778,0);
                        PosFig(1) = (handles.fullscreen(3)-PosFig(3))./2;
                        if PosFig(1) == 0;
                            PosFig(1) = 1;
                        end;
                        PosFig(2) = (handles.fullscreen(4)-PosFig(4))./2;
                        if PosFig(2) == 0;
                            PosFig(2) = 1;
                        end;
                        sizemod = 1;
                    end;
                end;
                
            elseif PosFigPrev(3) ~=  PosFig(3) & PosFigPrev(4) ~=  PosFig(4);
                %Resize from angles
                if PosFig(3) < handles.fullscreen(3);
                    if PosFig(3)./1.7778 ~= PosFig(4);
                        PosFig(4) = roundn(PosFig(3)./1.7778,0);
                        PosFig(1) = (handles.fullscreen(3)-PosFig(3))./2;
                        if PosFig(1) == 0;
                            PosFig(1) = 1;
                        end;
                        PosFig(2) = (handles.fullscreen(4)-PosFig(4))./2;
                        if PosFig(2) == 0;
                            PosFig(2) = 1;
                        end;
                        sizemod = 1;
                    end;
                end;
            end;
        end;
        
        if PosFig(3) < 800;
            PosFig(3) = 800;
            PosFig(4) = 450;
            PosFig(1) = (handles.fullscreen(3)-PosFig(3))./2;
            PosFig(2) = (handles.fullscreen(4)-400)./2;
            sizemod = 1;
        elseif PosFig(4) < 450;
            PosFig(3) = 800;
            PosFig(4) = 450;
            PosFig(1) = (handles.fullscreen(3)-400)./2;
            sizemod = 1;
        end;
    end;
    
    if sizemod == 1;
        set(gcf, 'Position', PosFig);
        blockPos = true;
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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
        set(gcf, 'Position', PosFig);
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

