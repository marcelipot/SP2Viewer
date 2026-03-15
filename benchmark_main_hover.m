
set(gcf,'units','pixels');
PosUI = get(gcf,'position');
set(gcf,'units','normalized');

set(handles.Question_button_benchmark, 'units', 'pixels');
P1 = get(handles.Question_button_benchmark, 'position');
set(handles.Question_button_benchmark,'units','normalized');

set(handles.Save_button_benchmark, 'units', 'pixels');
P2 = get(handles.Save_button_benchmark, 'position');
set(handles.Save_button_benchmark,'units','normalized');

set(handles.Reportpdf_button_benchmark, 'units', 'pixels');
P3 = get(handles.Reportpdf_button_benchmark, 'position');
set(handles.Reportpdf_button_benchmark,'units','normalized');

set(handles.Arrowback_button_benchmark, 'units', 'pixels');
P4 = get(handles.Arrowback_button_benchmark, 'position');
set(handles.Arrowback_button_benchmark,'units','normalized');

% set(handles.ranking_toggle_benchmark, 'units', 'pixels');
% P5 = get(handles.ranking_toggle_benchmark, 'position');
% set(handles.ranking_toggle_benchmark,'units','normalized');
% 
% set(handles.profile_toggle_benchmark, 'units', 'pixels');
% P6 = get(handles.profile_toggle_benchmark, 'position');
% set(handles.profile_toggle_benchmark,'units','normalized');
% 
% set(handles.trend_toggle_benchmark, 'units', 'pixels');
% P7 = get(handles.trend_toggle_benchmark, 'position');
% set(handles.trend_toggle_benchmark,'units','normalized');

set(handles.ClearSearchRanking_benchmark, 'units', 'pixels');
P8 = get(handles.ClearSearchRanking_benchmark, 'position');
set(handles.ClearSearchRanking_benchmark,'units','normalized');

set(handles.ValidateSearchRanking_benchmark, 'units', 'pixels');
P9 = get(handles.ValidateSearchRanking_benchmark, 'position');
set(handles.ValidateSearchRanking_benchmark,'units','normalized');

set(handles.ClearSearchProfile_benchmark, 'units', 'pixels');
P10 = get(handles.ClearSearchProfile_benchmark, 'position');
set(handles.ClearSearchProfile_benchmark,'units','normalized');

set(handles.ValidateSearchProfile_benchmark, 'units', 'pixels');
P11 = get(handles.ValidateSearchProfile_benchmark, 'position');
set(handles.ValidateSearchProfile_benchmark,'units','normalized');



ptmouse = get(0, 'PointerLocation');
ptmouseUI(1) = ptmouse(1)-PosUI(1);
ptmouseUI(2) = ptmouse(2)-PosUI(2);
handles.TooltipMain.mousepos = ptmouseUI;

isInzone = 0;



%---Question button down
if strcmpi(page_actu, 'Benchmark_main') == 1;
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
if strcmpi(page_actu, 'Benchmark_main') == 1;
    if ptmouseUI(1,1) >= P2(1,1) & ptmouseUI(1,1) <= (P2(1,1)+P2(1,3)) & ptmouseUI(1,2) >= P2(1,2) & ptmouseUI(1,2) <= (P2(1,2)+P2(1,4));
        isInzone = 2;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Save rankings/profile as a jpg image';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Export PDF report
if strcmpi(page_actu, 'Benchmark_main') == 1;
    if ptmouseUI(1,1) >= P3(1,1) & ptmouseUI(1,1) <= (P3(1,1)+P3(1,3)) & ptmouseUI(1,2) >= P3(1,2) & ptmouseUI(1,2) <= (P3(1,2)+P3(1,4));
        isInzone = 3;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Save Locker PDF comparison report for all selected races';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Arrow back
if strcmpi(page_actu, 'Benchmark_main') == 1;
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


% %---Menu for rankings
% if get(handles.ranking_toggle_benchmark, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P5(1,1) & ptmouseUI(1,1) <= (P5(1,1)+P5(1,3)) & ptmouseUI(1,2) >= P5(1,2) & ptmouseUI(1,2) <= (P5(1,2)+P5(1,4));
%         isInzone = 5;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Open the rankings menu';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;
% 
% 
% %---Menu for Profiles
% if get(handles.profile_toggle_benchmark, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P6(1,1) & ptmouseUI(1,1) <= (P6(1,1)+P6(1,3)) & ptmouseUI(1,2) >= P6(1,2) & ptmouseUI(1,2) <= (P6(1,2)+P6(1,4));
%         isInzone = 6;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Open the profiles menu';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;
% 
% 
% %---Menu for Trends
% if get(handles.trend_toggle_benchmark, 'Visible') == 1;
%     if ptmouseUI(1,1) >= P7(1,1) & ptmouseUI(1,1) <= (P7(1,1)+P7(1,3)) & ptmouseUI(1,2) >= P7(1,2) & ptmouseUI(1,2) <= (P7(1,2)+P7(1,4));
%         isInzone = 7;
%         if handles.TooltipMain.isLastzone ~= 0;
%             handles.TooltipMain.activestatus = 0;
%         end;
%         txtTooltip = 'Open the trend menu';
%         TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
%         handles.TooltipMain = TooltipMain;
%     end;
% end;


%---Clear search Main
if strcmpi(page_actu, 'Benchmark_main') == 1;
    if handles.currentBenchmarkToggle == 1;
        if ptmouseUI(1,1) >= P8(1,1) & ptmouseUI(1,1) <= (P8(1,1)+P8(1,3)) & ptmouseUI(1,2) >= P8(1,2) & ptmouseUI(1,2) <= (P8(1,2)+P8(1,4));
            isInzone = 8;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Clear Search';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Validate search Main
if strcmpi(page_actu, 'Benchmark_main') == 1;
    if handles.currentBenchmarkToggle == 1;
        if ptmouseUI(1,1) >= P9(1,1) & ptmouseUI(1,1) <= (P9(1,1)+P9(1,3)) & ptmouseUI(1,2) >= P9(1,2) & ptmouseUI(1,2) <= (P9(1,2)+P9(1,4));
            isInzone = 9;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Validate search';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Clear search profile
if strcmpi(page_actu, 'Benchmark_main') == 1;
    if handles.currentBenchmarkToggle == 2;
        if ptmouseUI(1,1) >= P10(1,1) & ptmouseUI(1,1) <= (P10(1,1)+P10(1,3)) & ptmouseUI(1,2) >= P10(1,2) & ptmouseUI(1,2) <= (P10(1,2)+P10(1,4));
            isInzone = 10;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Clear search';
            TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
            handles.TooltipMain = TooltipMain;
        end;
    end;
end;


%---Validate search profile
if strcmpi(page_actu, 'Benchmark_main') == 1;
    if handles.currentBenchmarkToggle == 2;
        if ptmouseUI(1,1) >= P11(1,1) & ptmouseUI(1,1) <= (P11(1,1)+P11(1,3)) & ptmouseUI(1,2) >= P11(1,2) & ptmouseUI(1,2) <= (P11(1,2)+P11(1,4));
            isInzone = 11;
            if handles.TooltipMain.isLastzone ~= 0;
                handles.TooltipMain.activestatus = 0;
            end;
            txtTooltip = 'Validate search';
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

