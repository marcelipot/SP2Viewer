FigPos = handles.FigPos;
pos = [220./FigPos(3), 40./FigPos(4), 810./FigPos(3), 560./FigPos(4)];
handles.axessplits_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
    'Position', pos, 'Visible', 'off', 'fontunits', 'normalized');

hold on;
%frame of the pool
line(handles.axessplits_analyser, [0 RaceDist], [0 0], 'linewidth', 4, 'color', [0.75 0.75 0.75]);
line(handles.axessplits_analyser, [0 RaceDist], [10 10], 'linewidth', 4, 'color', [0.75 0.75 0.75]);
line(handles.axessplits_analyser, [0 0], [0 10], 'linewidth', 4, 'color', [0.75 0.75 0.75]);
line(handles.axessplits_analyser, [RaceDist RaceDist], [0 10], 'linewidth', 4, 'color', [0.75 0.75 0.75]);
%laneropes
line(handles.axessplits_analyser, [0 RaceDist], [1 1], 'linewidth', 3, 'color', [0.2 0.6 0.2]);
line(handles.axessplits_analyser, [0 RaceDist], [2 2], 'linewidth', 3, 'color', [0 0.4 1]);
line(handles.axessplits_analyser, [0 RaceDist], [3 3], 'linewidth', 3, 'color', [0 0.4 1]);
line(handles.axessplits_analyser, [0 RaceDist], [4 4], 'linewidth', 3, 'color', [1 0.8 0]);
line(handles.axessplits_analyser, [0 RaceDist], [5 5], 'linewidth', 3, 'color', [1 0.8 0]);
line(handles.axessplits_analyser, [0 RaceDist], [6 6], 'linewidth', 3, 'color', [1 0.8 0]);
line(handles.axessplits_analyser, [0 RaceDist], [7 7], 'linewidth', 3, 'color', [0 0.4 1]);
line(handles.axessplits_analyser, [0 RaceDist], [8 8], 'linewidth', 3, 'color', [0 0.4 1]);
line(handles.axessplits_analyser, [0 RaceDist], [9 9], 'linewidth', 3, 'color', [0.2 0.6 0.2]);
%arrival
if handles.CurrentvalueRaceLapPacing == 1;
    XData = [RaceDist : (0.01.*RaceDist) : (RaceDist+(0.05.*RaceDist))];
else;
    XData = [RaceDist : (0.01.*50) : (RaceDist+(0.05.*50))];
end;
YData = [0:0.25:10];
corners = [1 2 3 4];
for i = 1:length(XData)-1;
    if mod(i,2) == 1;
        colorIni = 'white';
    else;
        colorIni = 'black';
    end;
    for j = 1:length(YData)-1;
        xy = [XData(i) YData(j); XData(i+1) YData(j); XData(i+1) YData(j+1); XData(i) YData(j+1)];
        hold on;
        if strcmpi(colorIni, 'white');
            if mod(j,2) == 1;
                patch('Faces', corners, 'Vertices', xy, 'FaceColor', [1 1 1]);
            else;
                patch('Faces', corners, 'Vertices', xy, 'FaceColor', [0 0 0]);
            end;
        else;
            if mod(j,2) == 1;
                patch('Faces', corners, 'Vertices', xy, 'FaceColor', [0 0 0]);
            else;
                patch('Faces', corners, 'Vertices', xy, 'FaceColor', [1 1 1]);
            end;
        end;
    end;
end;
%Laps
if RaceDist >= 800;
    linewidthEC = 2;
elseif RaceDist == 400;
    linewidthEC = 2.5;
else;
    linewidthEC = 3;
end;

if RaceDist == 50;
    line(handles.axessplits_analyser, [25 25], [0 10], ...
        'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);
    line(handles.axessplits_analyser, [50 50], [0 10], ...
        'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);
else;
    for i = 1:length(DistLap)-1;
        hold on;
        line(handles.axessplits_analyser, [DistLap(i) DistLap(i)], [0 10], ...
            'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);

        if handles.CurrentvalueRaceLapPacing == 1;
            if Course == 50;
                if RaceDist <= 400;
                    if i == 1;
                        line(handles.axessplits_analyser, [DistLap(i)-25 DistLap(i)-25], [0 10], ...
                            'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);
                    end;
                    line(handles.axessplits_analyser, [DistLap(i)+25 DistLap(i)+25], [0 10], ...
                        'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);
                end;
            end;
        else;
            if Course == 50;
                if i == 1;
                    line(handles.axessplits_analyser, [DistLap(i)-25 DistLap(i)-25], [0 10], ...
                        'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);
                end;
                line(handles.axessplits_analyser, [DistLap(i)+25 DistLap(i)+25], [0 10], ...
                    'linewidth', linewidthEC, 'linestyle', ':', 'color', [0.75 0.75 0.75]);
            end;
        end;
    end;
end;