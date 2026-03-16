
set(gcf,'units','pixels');
PosUI = get(gcf,'position');
set(gcf,'units','normalized');

set(handles.Question_button_database, 'units', 'pixels');
P1 = get(handles.Question_button_database, 'position');
set(handles.Question_button_database,'units','normalized');

set(handles.Downloaddata_button_database, 'units', 'pixels');
P2 = get(handles.Downloaddata_button_database, 'position');
set(handles.Downloaddata_button_database,'units','normalized');

set(handles.Downloadraw_button_database, 'units', 'pixels');
P3 = get(handles.Downloadraw_button_database, 'position');
set(handles.Downloadraw_button_database,'units','normalized');

set(handles.Downloadbenchmark_button_database, 'units', 'pixels');
P4 = get(handles.Downloadbenchmark_button_database, 'position');
set(handles.Downloadbenchmark_button_database,'units','normalized');

set(handles.DownloadAMS_button_database, 'units', 'pixels');
P5 = get(handles.DownloadAMS_button_database, 'position');
set(handles.DownloadAMS_button_database,'units','normalized');

set(handles.Downloadall_button_database, 'units', 'pixels');
P6 = get(handles.Downloadall_button_database, 'position');
set(handles.Downloadall_button_database,'units','normalized');

set(handles.Downloadnew_button_database, 'units', 'pixels');
P7 = get(handles.Downloadnew_button_database, 'position');
set(handles.Downloadnew_button_database,'units','normalized');

set(handles.Downloadselect_button_database, 'units', 'pixels');
P8 = get(handles.Downloadselect_button_database, 'position');
set(handles.Downloadselect_button_database,'units','normalized');

set(handles.Arrowback_button_database, 'units', 'pixels');
P9 = get(handles.Arrowback_button_database, 'position');
set(handles.Arrowback_button_database,'units','normalized');

set(handles.Validate_button_database, 'units', 'pixels');
P10 = get(handles.Validate_button_database, 'position');
set(handles.Validate_button_database,'units','normalized');

set(handles.Redcross_button_database, 'units', 'pixels');
P11 = get(handles.Redcross_button_database, 'position');
set(handles.Redcross_button_database,'units','normalized');



ptmouse = get(0, 'PointerLocation');
ptmouseUI(1) = ptmouse(1)-PosUI(1);
ptmouseUI(2) = ptmouse(2)-PosUI(2);
handles.TooltipMain.mousepos = ptmouseUI;

isInzone = 0;



%---Question button down
if get(handles.Question_button_database, 'Visible') == 1;
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


%---Download all summary data tables for the selected races
if get(handles.Downloaddata_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P2(1,1) & ptmouseUI(1,1) <= (P2(1,1)+P2(1,3)) & ptmouseUI(1,2) >= P2(1,2) & ptmouseUI(1,2) <= (P2(1,2)+P2(1,4));
        isInzone = 2;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download all summary data tables for the selected races';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Download complete datasets for the selected race(s)
if get(handles.Downloadraw_button_database, 'Visible') == 1;
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


%---Download the selected database to a xls file
if get(handles.Downloadbenchmark_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P4(1,1) & ptmouseUI(1,1) <= (P4(1,1)+P4(1,3)) & ptmouseUI(1,2) >= P4(1,2) & ptmouseUI(1,2) <= (P4(1,2)+P4(1,4));
        isInzone = 4;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download the selected database to a xls file';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Download AMS export table for the selected races (compatible with race model sheets and pacing charts)
if get(handles.DownloadAMS_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P5(1,1) & ptmouseUI(1,1) <= (P5(1,1)+P5(1,3)) & ptmouseUI(1,2) >= P5(1,2) & ptmouseUI(1,2) <= (P5(1,2)+P5(1,4));
        isInzone = 5;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download AMS export table for the selected races (compatible with race model sheets and pacing charts)';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Download the entire S3 database to a local folder
if get(handles.Downloadall_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P6(1,1) & ptmouseUI(1,1) <= (P6(1,1)+P6(1,3)) & ptmouseUI(1,2) >= P6(1,2) & ptmouseUI(1,2) <= (P6(1,2)+P6(1,4));
        isInzone = 6;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download the entire database to a local folder';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Download all new races from the S3 database to a local folder
if get(handles.Downloadnew_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P7(1,1) & ptmouseUI(1,1) <= (P7(1,1)+P7(1,3)) & ptmouseUI(1,2) >= P7(1,2) & ptmouseUI(1,2) <= (P7(1,2)+P7(1,4));
        isInzone = 7;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download all new races from the database to a local folder';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Download all selected races from the S3 database to a local folder
if get(handles.Downloadselect_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P8(1,1) & ptmouseUI(1,1) <= (P8(1,1)+P8(1,3)) & ptmouseUI(1,2) >= P8(1,2) & ptmouseUI(1,2) <= (P8(1,2)+P8(1,4));
        isInzone = 8;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Download all selected races from the S3 database to a local folder';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Arrow back
if get(handles.Arrowback_button_database, 'Visible') == 1;
    if ptmouseUI(1,1) >= P9(1,1) & ptmouseUI(1,1) <= (P9(1,1)+P9(1,3)) & ptmouseUI(1,2) >= P9(1,2) & ptmouseUI(1,2) <= (P9(1,2)+P9(1,4));
        isInzone = 9;
        if handles.TooltipMain.isLastzone ~= 0;
            handles.TooltipMain.activestatus = 0;
        end;
        txtTooltip = 'Navigate back to the module selection page';
        TooltipMain = updatetooltip(ptmouseUI, handles.TooltipMain, txtTooltip, isInzone, PosUI);
        handles.TooltipMain = TooltipMain;
    end;
end;


%---Clear search profile
if get(handles.Validate_button_database, 'Visible') == 1;
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


%---Validate search profile
if get(handles.Redcross_button_database, 'Visible') == 1;
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






handles.TooltipMain.isLastzone = isInzone;
if handles.TooltipMain.activestatus == 1 & isInzone == 0;
    %out of any ZOI
    handles.TooltipMain.activestatus = 0;
    set(handles.TooltipMain.disptext, 'Visible', 'off');
end;

