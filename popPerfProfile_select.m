function [] = popPerfProfile_select(varargin);


handles2 = guidata(gcf);

valPerf = get(handles2.SelectPerfProfile_select, 'Value');
listPerf = get(handles2.SelectPerfProfile_select, 'String');

PerfEC = listPerf{valPerf};
index = strfind(lower(PerfEC), '----');
index = find(index == 1);

if isempty(index) == 0;
    set(handles2.SelectPerfProfile_select, 'Value', valPerf+1);
    PerfEC = listPerf(valPerf+1);

    valPerf = valPerf+1;
end;
set(handles2.SelectPerfProfile_select, 'tooltip', PerfEC);

handles2.SearchPerf = PerfEC;

handles2.yearPerf = [];
if strfind(PerfEC, 'SB ');
    handles2.yearPerf = PerfEC;
elseif strfind(PerfEC, 'PB');
    handles2.yearPerf = PerfEC;
else;
    proceed = 1;
    iter = 1;
    while proceed == 1;
        PerfEC = listPerf{valPerf - iter};
        index = strfind(lower(PerfEC), '----');
        if isempty(index) == 0;
            handles2.yearPerf = PerfEC(index+6:index+9);
            proceed = 0;
        else;
            if valPerf - iter == 1;
                proceed = 0;
            else;
                iter = iter + 1;
            end;
        end;
    end;
end;

guidata(gcf, handles2);
