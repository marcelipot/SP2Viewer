
set(gcf,'units','pixels');
PosUI = get(gcf,'position');
set(gcf,'units','normalized');

set(handles.Question_button_analyser, 'units', 'pixels');
P1 = get(handles.Question_button_analyser, 'position');
set(handles.Question_button_analyser,'units','normalized');

set(handles.Save_button_analyser, 'units', 'pixels');
P2 = get(handles.Save_button_analyser, 'position');
set(handles.Save_button_analyser,'units','normalized');

set(handles.Download_button_analyser, 'units', 'pixels');
P3 = get(handles.Download_button_analyser, 'position');
set(handles.Download_button_analyser,'units','normalized');

set(handles.Arrowback_button_analyser, 'units', 'pixels');
P4 = get(handles.Arrowback_button_analyser, 'position');
set(handles.Arrowback_button_analyser,'units','normalized');

set(handles.AddFile_button_analyser, 'units', 'pixels');
P5 = get(handles.AddFile_button_analyser, 'position');
set(handles.AddFile_button_analyser,'units','normalized');

set(handles.RemoveFile_button_analyser, 'units', 'pixels');
P6 = get(handles.RemoveFile_button_analyser, 'position');
set(handles.RemoveFile_button_analyser,'units','normalized');

set(handles.RemoveAllFile_button_analyser, 'units', 'pixels');
P7 = get(handles.RemoveAllFile_button_analyser, 'position');
set(handles.RemoveAllFile_button_analyser,'units','normalized');

% set(handles.Reset_button_analyser, 'units', 'pixels');
% P8 = get(handles.Reset_button_analyser, 'position');
% set(handles.Reset_button_analyser,'units','normalized');
% 
% set(handles.Search_button_analyser, 'units', 'pixels');
% P9 = get(handles.Search_button_analyser, 'position');
% set(handles.Search_button_analyser,'units','normalized');

set(handles.Fullscreen_button_analyser, 'units', 'pixels');
P10 = get(handles.Fullscreen_button_analyser, 'position');
set(handles.Fullscreen_button_analyser,'units','normalized');

set(handles.Precedentchap_button_analyser, 'units', 'pixels');
P11 = get(handles.Precedentchap_button_analyser, 'position');
set(handles.Precedentchap_button_analyser,'units','normalized');

set(handles.Precedentimage_button_analyser, 'units', 'pixels');
P12 = get(handles.Precedentimage_button_analyser, 'position');
set(handles.Precedentimage_button_analyser,'units','normalized');

set(handles.Stop_button_analyser, 'units', 'pixels');
P13 = get(handles.Stop_button_analyser, 'position');
set(handles.Stop_button_analyser,'units','normalized');

set(handles.Play_button_analyser, 'units', 'pixels');
P14 = get(handles.Play_button_analyser, 'position');
set(handles.Play_button_analyser,'units','normalized');

set(handles.Suivantimage_button_analyser, 'units', 'pixels');
P15 = get(handles.Suivantimage_button_analyser, 'position');
set(handles.Suivantimage_button_analyser,'units','normalized');

set(handles.Suivantchap_button_analyser, 'units', 'pixels');
P16 = get(handles.Suivantchap_button_analyser, 'position');
set(handles.Suivantchap_button_analyser,'units','normalized');

set(handles.Reportpdf_button_analyser, 'units', 'pixels');
P17 = get(handles.Reportpdf_button_analyser, 'position');
set(handles.Reportpdf_button_analyser,'units','normalized');

% set(handles.Search_athletename_analyser, 'units', 'pixels');
% P18 = get(handles.Search_athletename_analyser, 'position');
% set(handles.Search_athletename_analyser,'units','normalized');
% 
% set(handles.Search_racename_analyser, 'units', 'pixels');
% P19 = get(handles.Search_racename_analyser, 'position');
% set(handles.Search_racename_analyser,'units','normalized');

set(handles.display_button_analyser, 'units', 'pixels');
P20 = get(handles.display_button_analyser, 'position');
set(handles.display_button_analyser,'units','normalized');

set(handles.DataPanel_toggle_analyser, 'units', 'pixels');
P21 = get(handles.DataPanel_toggle_analyser, 'position');
set(handles.DataPanel_toggle_analyser,'units','normalized');

set(handles.PacingDisplay_toggle_analyser, 'units', 'pixels');
P22 = get(handles.PacingDisplay_toggle_analyser, 'position');
set(handles.PacingDisplay_toggle_analyser,'units','normalized');

set(handles.SkillDisplay_toggle_analyser, 'units', 'pixels');
P23 = get(handles.SkillDisplay_toggle_analyser, 'position');
set(handles.SkillDisplay_toggle_analyser,'units','normalized');

set(handles.SplitsDisplay_toggle_analyser, 'units', 'pixels');
P24 = get(handles.SplitsDisplay_toggle_analyser, 'position');
set(handles.SplitsDisplay_toggle_analyser,'units','normalized');

set(handles.SummaryData_Panel_analyser, 'units', 'pixels');
P25 = get(handles.SummaryData_Panel_analyser, 'position');
set(handles.SummaryData_Panel_analyser,'units','normalized');

set(handles.PacingData_Panel_analyser, 'units', 'pixels');
P26 = get(handles.PacingData_Panel_analyser, 'position');
set(handles.PacingData_Panel_analyser,'units','normalized');

set(handles.StrokeData_Panel_analyser, 'units', 'pixels');
P27 = get(handles.StrokeData_Panel_analyser, 'position');
set(handles.StrokeData_Panel_analyser,'units','normalized');

set(handles.SkillsData_Panel_analyser, 'units', 'pixels');
P28 = get(handles.SkillsData_Panel_analyser, 'position');
set(handles.SkillsData_Panel_analyser,'units','normalized');

set(handles.insVelToggle_analyser, 'units', 'pixels');
P29 = get(handles.insVelToggle_analyser, 'position');
set(handles.insVelToggle_analyser,'units','normalized');

set(handles.predVelToggle_analyser, 'units', 'pixels');
P30 = get(handles.predVelToggle_analyser, 'position');
set(handles.predVelToggle_analyser,'units','normalized');

set(handles.flucVelToggle_analyser, 'units', 'pixels');
P31 = get(handles.flucVelToggle_analyser, 'position');
set(handles.flucVelToggle_analyser,'units','normalized');

ptmouse = get(0, 'PointerLocation');
ptmouseUI(1) = ptmouse(1)-PosUI(1);
ptmouseUI(2) = ptmouse(2)-PosUI(2);
handles.TooltipMain.mousepos = ptmouseUI;

isInzone = 0;



%---Question button down
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P1(1,1) & ptmouseUI(1,1) <= (P1(1,1)+P1(1,3)) & ptmouseUI(1,2) >= P1(1,2) & ptmouseUI(1,2) <= (P1(1,2)+P1(1,4));
        isInzone = 1;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Show parameters definitions';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Save button down
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P2(1,1) & ptmouseUI(1,1) <= (P2(1,1)+P2(1,3)) & ptmouseUI(1,2) >= P2(1,2) & ptmouseUI(1,2) <= (P2(1,2)+P2(1,4));
        isInzone = 2;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        if strcmpi(handles.current_toggle, 'Data') == 1;
            txtTooltip = 'Save tables as a xlsx file';
        else;
            txtTooltip = 'Save graph as a jpg image';
        end;
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Download button down
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P3(1,1) & ptmouseUI(1,1) <= (P3(1,1)+P3(1,3)) & ptmouseUI(1,2) >= P3(1,2) & ptmouseUI(1,2) <= (P3(1,2)+P3(1,4));
        isInzone = 3;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download complete datasets for the selected race(s)';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Full screen button down
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P10(1,1) & ptmouseUI(1,1) <= (P10(1,1)+P10(1,3)) & ptmouseUI(1,2) >= P10(1,2) & ptmouseUI(1,2) <= (P10(1,2)+P10(1,4));
        isInzone = 10;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Move graph to a seperate window';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Arrow back
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P4(1,1) & ptmouseUI(1,1) <= (P4(1,1)+P4(1,3)) & ptmouseUI(1,2) >= P4(1,2) & ptmouseUI(1,2) <= (P4(1,2)+P4(1,4));
        isInzone = 4;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Navigate back to the module selection page';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Add file button
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P5(1,1) & ptmouseUI(1,1) <= (P5(1,1)+P5(1,3)) & ptmouseUI(1,2) >= P5(1,2) & ptmouseUI(1,2) <= (P5(1,2)+P5(1,4));
        isInzone = 5;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Add file to the list';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Remove file button
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P6(1,1) & ptmouseUI(1,1) <= (P6(1,1)+P6(1,3)) & ptmouseUI(1,2) >= P6(1,2) & ptmouseUI(1,2) <= (P6(1,2)+P6(1,4));
        isInzone = 6;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Remove file from the list';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Remove all files button
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P7(1,1) & ptmouseUI(1,1) <= (P7(1,1)+P7(1,3)) & ptmouseUI(1,2) >= P7(1,2) & ptmouseUI(1,2) <= (P7(1,2)+P7(1,4));
        isInzone = 7;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Remove all file from the list';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


% %---reset button
% if get(handles.Reset_button_analyser, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P8(1,1) & ptmouseUI(1,1) <= (P8(1,1)+P8(1,3)) & ptmouseUI(1,2) >= P8(1,2) & ptmouseUI(1,2) <= (P8(1,2)+P8(1,4));
%         isInzone = 8;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Access Analyser module';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;
% 
% 
% %---Search button
% if get(handles.Search_button_analyser, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P9(1,1) & ptmouseUI(1,1) <= (P9(1,1)+P9(1,3)) & ptmouseUI(1,2) >= P9(1,2) & ptmouseUI(1,2) <= (P9(1,2)+P9(1,4));
%         isInzone = 9;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Access Analyser module';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;


%---Pacing 3D, playback control previous zone
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if handles.CurrentvalueSplits3D == 1;
            if ptmouseUI(1,1) >= P11(1,1) & ptmouseUI(1,1) <= (P11(1,1)+P11(1,3)) & ptmouseUI(1,2) >= P11(1,2) & ptmouseUI(1,2) <= (P11(1,2)+P11(1,4));
                isInzone = 11;
                if handles.TooltipMain.isLastzone ~= 0;
                    handles.TooltipMain.activestatus = 0;
                end;
                txtTooltip = 'Previous split';
                TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
                handles.TooltipMain = TooltipMain;
            end;
        end;
    end;
end;


%---Pacing 3D, playback control previous image
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if handles.CurrentvalueSplits3D == 1;
            if ptmouseUI(1,1) >= P12(1,1) & ptmouseUI(1,1) <= (P12(1,1)+P12(1,3)) & ptmouseUI(1,2) >= P12(1,2) & ptmouseUI(1,2) <= (P12(1,2)+P12(1,4));
                isInzone = 12;
                if handles.TooltipMain.isLastzone ~= 0;
                    handles.TooltipMain.activestatus = 0;
                end;
                txtTooltip = 'Previous frame';
                TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
                handles.TooltipMain = TooltipMain;
            end;
        end;
    end;
end;


%---Pacing 3D, playback control stop
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if handles.CurrentvalueSplits3D == 1;
            if ptmouseUI(1,1) >= P13(1,1) & ptmouseUI(1,1) <= (P13(1,1)+P13(1,3)) & ptmouseUI(1,2) >= P13(1,2) & ptmouseUI(1,2) <= (P13(1,2)+P13(1,4));
                isInzone = 13;
                if handles.TooltipMain.isLastzone ~= 0;
                    handles.TooltipMain.activestatus = 0;
                end;
                txtTooltip = 'Stop playback';
                TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
                handles.TooltipMain = TooltipMain;
            end;
        end;
    end;
end;


%---Pacing 3D, playback control play
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if handles.CurrentvalueSplits3D == 1;
            if ptmouseUI(1,1) >= P14(1,1) & ptmouseUI(1,1) <= (P14(1,1)+P14(1,3)) & ptmouseUI(1,2) >= P14(1,2) & ptmouseUI(1,2) <= (P14(1,2)+P14(1,4));
                isInzone = 14;
                if handles.TooltipMain.isLastzone ~= 0;
                    handles.TooltipMain.activestatus = 0;
                end;
                txtTooltip = 'Start playback';
                TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
                handles.TooltipMain = TooltipMain;
            end;
        end;
    end;
end;


%---Pacing 3D, playback control next image
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if handles.CurrentvalueSplits3D == 1;
            if ptmouseUI(1,1) >= P15(1,1) & ptmouseUI(1,1) <= (P15(1,1)+P15(1,3)) & ptmouseUI(1,2) >= P15(1,2) & ptmouseUI(1,2) <= (P15(1,2)+P15(1,4));
                isInzone = 15;
                if handles.TooltipMain.isLastzone ~= 0;
                    handles.TooltipMain.activestatus = 0;
                end;
                txtTooltip = 'Next frame';
                TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
                handles.TooltipMain = TooltipMain;
            end;
        end;
    end;
end;


%---Pacing 3D, playback control next split
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if handles.CurrentvalueSplits3D == 1;
            if ptmouseUI(1,1) >= P16(1,1) & ptmouseUI(1,1) <= (P16(1,1)+P16(1,3)) & ptmouseUI(1,2) >= P16(1,2) & ptmouseUI(1,2) <= (P16(1,2)+P16(1,4));
                isInzone = 16;
                if handles.TooltipMain.isLastzone ~= 0;
                    handles.TooltipMain.activestatus = 0;
                end;
                txtTooltip = 'Next split';
                TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
                handles.TooltipMain = TooltipMain;
            end;
        end;
    end;
end;


%---PDF report
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P17(1,1) & ptmouseUI(1,1) <= (P17(1,1)+P17(1,3)) & ptmouseUI(1,2) >= P17(1,2) & ptmouseUI(1,2) <= (P17(1,2)+P17(1,4));
        isInzone = 17;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Create Locker PDF report';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


% %---Search athlete name
% if get(handles.Search_athletename_analyser, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P18(1,1) & ptmouseUI(1,1) <= (P18(1,1)+P18(1,3)) & ptmouseUI(1,2) >= P18(1,2) & ptmouseUI(1,2) <= (P18(1,2)+P18(1,4));
%         isInzone = 18;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Type an athlete name and press enter to search';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;
% 
% 
% %---Search race name
% if get(handles.Search_racename_analyser, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P19(1,1) & ptmouseUI(1,1) <= (P19(1,1)+P19(1,3)) & ptmouseUI(1,2) >= P19(1,2) & ptmouseUI(1,2) <= (P19(1,2)+P19(1,4));
%         isInzone = 19;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Type a race name and press enter to search';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;


%---Display race data
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P20(1,1) & ptmouseUI(1,1) <= (P20(1,1)+P20(1,3)) & ptmouseUI(1,2) >= P20(1,2) & ptmouseUI(1,2) <= (P20(1,2)+P20(1,4));
        isInzone = 20;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Display race(s) data';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Display data tables
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P21(1,1) & ptmouseUI(1,1) <= (P21(1,1)+P21(1,3)) & ptmouseUI(1,2) >= P21(1,2) & ptmouseUI(1,2) <= (P21(1,2)+P21(1,4));
        isInzone = 21;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Display data tables';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Display velocity graph
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P22(1,1) & ptmouseUI(1,1) <= (P22(1,1)+P22(1,3)) & ptmouseUI(1,2) >= P22(1,2) & ptmouseUI(1,2) <= (P22(1,2)+P22(1,4));
        isInzone = 22;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Display velocity graph';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Display pacing graph
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P23(1,1) & ptmouseUI(1,1) <= (P23(1,1)+P23(1,3)) & ptmouseUI(1,2) >= P23(1,2) & ptmouseUI(1,2) <= (P23(1,2)+P23(1,4));
        isInzone = 23;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Display pacing graph';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Display skill graph
if strcmpi(page_actu, 'Analyser_main') == 1;
    if ptmouseUI(1,1) >= P24(1,1) & ptmouseUI(1,1) <= (P24(1,1)+P24(1,3)) & ptmouseUI(1,2) >= P24(1,2) & ptmouseUI(1,2) <= (P24(1,2)+P24(1,4));
        isInzone = 24;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Display skill graph';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Display summary table
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Data') == 1;
        if ptmouseUI(1,1) >= P25(1,1) & ptmouseUI(1,1) <= (P25(1,1)+P25(1,3)) & ptmouseUI(1,2) >= P25(1,2) & ptmouseUI(1,2) <= (P25(1,2)+P25(1,4));
            isInzone = 25;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display summary table';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Display Pacing table
if strcmpi(page_actu, 'Analyser_main') == 1;    
    if strcmpi(handles.current_toggle, 'Data') == 1;    
        if ptmouseUI(1,1) >= P26(1,1) & ptmouseUI(1,1) <= (P26(1,1)+P26(1,3)) & ptmouseUI(1,2) >= P26(1,2) & ptmouseUI(1,2) <= (P26(1,2)+P26(1,4));
            isInzone = 26;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display pacing table';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Display Stroke table
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Data') == 1;
        if ptmouseUI(1,1) >= P27(1,1) & ptmouseUI(1,1) <= (P27(1,1)+P27(1,3)) & ptmouseUI(1,2) >= P27(1,2) & ptmouseUI(1,2) <= (P27(1,2)+P27(1,4));
            isInzone = 27;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display stroke table';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Display Skill table
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Data') == 1;
        if ptmouseUI(1,1) >= P28(1,1) & ptmouseUI(1,1) <= (P28(1,1)+P28(1,3)) & ptmouseUI(1,2) >= P28(1,2) & ptmouseUI(1,2) <= (P28(1,2)+P28(1,4));
            isInzone = 28;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display skills table';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Display instantaneous velocity graph
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Pacing') == 1;
        if ptmouseUI(1,1) >= P29(1,1) & ptmouseUI(1,1) <= (P29(1,1)+P29(1,3)) & ptmouseUI(1,2) >= P29(1,2) & ptmouseUI(1,2) <= (P29(1,2)+P29(1,4));
            isInzone = 29;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display instantaneous velocity graph';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Display velocity dristribution graph
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Pacing') == 1;
        if ptmouseUI(1,1) >= P30(1,1) & ptmouseUI(1,1) <= (P30(1,1)+P30(1,3)) & ptmouseUI(1,2) >= P30(1,2) & ptmouseUI(1,2) <= (P30(1,2)+P30(1,4));
            isInzone = 30;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display velocity dristribution graph';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Display velocity crests & troughts analysis graph
if strcmpi(page_actu, 'Analyser_main') == 1;
    if strcmpi(handles.current_toggle, 'Pacing') == 1;
        if ptmouseUI(1,1) >= P31(1,1) & ptmouseUI(1,1) <= (P31(1,1)+P31(1,3)) & ptmouseUI(1,2) >= P31(1,2) & ptmouseUI(1,2) <= (P31(1,2)+P31(1,4));
            isInzone = 31;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Display velocity crests & troughts analysis graph';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;



handles.TooltipMain.isLastzone = isInzone;
if handles.TooltipMain.activestatus == 1 & isInzone == 0;
    %out of any ZOI
    handles.TooltipMain.activestatus = 0;
    set(handles.TooltipMain.disptext, 'Visible', 'off');
end;

