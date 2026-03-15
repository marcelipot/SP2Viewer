
if handles.existRankings == 1;

    [filename, pathname] = uiputfile({'*.bmp', 'Image File'}, 'Save Graph As', handles.lastPath_benchmark);
    if isempty(pathname) == 1;
        return;
    end;
    if pathname == 0;
        return;
    end;
    handles.lastPath_benchmark = pathname;

    FigPos = [50 50 1100 660];
    Fig = figure('position', FigPos, 'units', 'pixels', 'color', [0 0 0], 'Visible', 'on', ...
        'MenuBar', 'none', 'NumberTitle', 'off');
    set(Fig, 'Name', 'Profile');

    if get(handles.typeRankingTop10_benchmark, 'Value') == 1;
        listSeason = get(handles.SelectSeasonRanking_benchmark, 'String');
        valSeason = get(handles.SelectSeasonRanking_benchmark, 'Value');
        SeasonEC = listSeason{valSeason};

        listMeet = get(handles.SelectMeetRanking_benchmark, 'String');
        valMeet = get(handles.SelectMeetRanking_benchmark, 'Value');
        MeetEC = listMeet{valMeet};

        filter_ranking_benchmark;
        databaseCurrent = handles.databaseCurrentFull_rankings;
        MatAge = handles.MatAgeRankings;

        dispTurns = get(handles.displayTurnsRanking_benchmark, 'Value');
    else;
        databaseCurrent = handles.databaseCurrent;
        MatAge = handles.MatAge;
        databaseCurrentName = [];
        dispTurns = 0;
        valDataset = 2;
        valPB = 1;

        SearchPool = databaseCurrent{1,10};
        SearchDistance = databaseCurrent{1,3};
    end;

    if isempty(databaseCurrent) == 0;

        if ismac == 1;
            fontEC1 = 0.028;
            fontEC2 = 0.030;
            fontEC3 = 0.022;
            fontEC4 = 0.25;
            fontEC5 = 0.3125;
            fontEC6 = 0.2325;
        elseif ispc == 1;
            fontEC1 = 0.032;
            fontEC2 = 0.0312;
            fontEC3 = 0.025;
            fontEC4 = 0.3;
            fontEC5 = 0.3500;
            fontEC6 = 0.2800;
        end;

        MainRanking_benchmark = axes('parent', Fig, 'units', 'pixels', 'Position', [25, 110, 1050, 475], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
        imshow(handles.icones.RankingBKG1);
        
        SecondaryRanking_benchmark = axes('parent', Fig, 'units', 'pixels', 'Position', [25, 40, 1050, 43.5], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
        imshow(handles.icones.RankingBKG2);

%         set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');

        if valDataset == 2;
            %Race Time
            colACT = 14;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'RaceTime';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
    
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                val = classifier{i,1};
                liSec = strfind(val, ' s');
                if isempty(liSec) == 0;
                    timeEC(i,1) = str2num(val(1:5));
                else;
                    lidot = strfind(val, ':');
                    min = str2num(val(1:lidot-1)).*60;
                    sec = str2num(val(lidot+1:lidot+3));
                    hun = str2num(['0.' val(end-1:end)]);
                    timeEC(i,1) = min+sec+hun;
                end;
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'ascend');
            if get(handles.typeRankingCustom_benchmark, 'Value') == 1;
                %Custom ranking
                valComp = get(handles.sortOptionCustomRanking_benchmark, 'Value');
                if valComp == 1;
                    %no sorting
                    index = 1:length(classifier);
                elseif valComp == 2;
                    %sorting by perf
                    [output, index] = sort(classifier, 'ascend');
                elseif valComp == 3;
                    %sorting by date
                    timeClassifier = datetime(databaseCurrent(:,57));
                    [output, index] = sort(timeClassifier, 'ascend');
                end;
            else;
                [output, index] = sort(classifier, 'ascend');
            end;
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);

            iter = 1;
            classifierNew = {};
            MatAgeNew = [];
            for i = 1:length(classifier(:,1));
                index = find(handles.raw2delete_rankings == i);
                if isempty(index) == 1;
                    %find and add raws that haven't been removed by the
                    %users
                    classifierNew(iter, :) = classifier(i, :);
                    MatAgeNew(iter,1) = MatAge(i,1);
                    iter = iter + 1;
                end;
            end;
            classifier = classifierNew;
            MatAge = MatAgeNew;
    
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;  

            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(300, 19, 'Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(410, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(510, 12, 'Speed / Skills', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            if strcmpi(SearchPool, '50');
                if strcmpi(SearchDistance, '50');
                    turnexist = 0;
                else;
                    turnexist = 1;
                end;
            else;
                turnexist = 1;
            end;
            if turnexist == 1;
                if dispTurns == 1;
                    txtOBJ{1,7} = text(510, 29, '(Start / Av. turns)', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0]);
                else;
                    txtOBJ{1,7} = text(520, 29, '(Start / All turns)', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0]);
                end;
            else;
                txtOBJ{1,7} = text(520, 29, '(Start / Finish)', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0]);
            end;
            txtOBJ{1,8} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,11} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,4} = text(250, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,colACT};
                txtOBJ{i+1,5} = text(300, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                if i == 1;
                    val = classifier{i,colACT};
                    liSec = strfind(val, ' s');
                    if isempty(liSec) == 0;
                        timeRef = str2num(val(1:5));
                    else;
                        lidot = strfind(val, ':');
                        min = str2num(val(1:lidot-1)).*60;
                        sec = str2num(val(lidot+1:lidot+3));
                        hun = str2num(['0.' val(end-1:end)]);
                        timeRef = min+sec+hun;
                    end;
                    DiffCalsec = '0.00s';
                    DiffCalper = '0.00%';
                else;
                    val = classifier{i,colACT};
                    liSec = strfind(val, ' s');
                    if isempty(liSec) == 0;
                        timeAct = str2num(val(1:5));
                    else;
                        lidot = strfind(val, ':');
                        min = str2num(val(1:lidot-1)).*60;
                        sec = str2num(val(lidot+1:lidot+3));
                        hun = str2num(['0.' val(end-1:end)]);
                        timeAct = min+sec+hun;
                    end;
                    DiffCalsec = [dataToStr(abs(timeAct - timeRef),2) 's'];
                    DiffCalper = [dataToStr((abs(timeAct - timeRef)./timeRef).*100,2) '%'];
                end;
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJ{i+1,6} = text(380, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    

                









            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            txtSpeed = classifier{i,32};
%             if Source == 1 | Source == 3;
%                 dataTableAverage = classifier{i,68};
%                 VelLap = [];
%                 interpVel = 0;
%                 if Course == 50;
%                     if RaceDist == 50;
%                         validIndex = [5 7 9];
%                         colSpeed = 4;
%                     elseif RaceDist == 100;
%                         validIndex = [5 7 9 13 15 17 19];
%                         colSpeed = 4;
%                     elseif RaceDist == 150;
%                         validIndex = [5 10 15 20 25 30];
%                         colSpeed = 5;
%                     elseif RaceDist == 200;
%                         validIndex = [5 10 15 20 25 30 35 40];
%                         colSpeed = 5;
%                     elseif RaceDist == 400;
%                         validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80];
%                         colSpeed = 5;
%                     elseif RaceDist == 800;
%                         validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
%                             85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160];
%                         colSpeed = 5;
%                     elseif RaceDist == 1500;
%                         validIndex = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 ...
%                             85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 ...
%                             165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 ...
%                             245 250 255 260 265 270 275 280 285 290 295 300];
%                         colSpeed = 5;
%                     end;
%                 end;
% 
%                 for iter = 1:length(validIndex);
%                     valEC = dataTableAverage(validIndex(iter),colSpeed);
%                     if isempty(valEC) == 1 | isnan(valEC) == 1;
%                         ValEC = ' ';
%                     else;
%                         VelLap = [VelLap valEC];
%                     end;
%                 end;
%                 txtSpeed = dataToStr(mean(VelLap),2);
%         
%             elseif Source == 2;
%                 %50m race so take col 3 for the speed
%                 dataTableAverage = classifier{i,68};
%                 VelLap = [];
%                 interpVel = 0;
%                 validIndex = [3 5 7 9 10];
%                 for iter = 1:length(validIndex);
%                     valEC = dataTableAverage{validIndex(iter),3};
%                     if isempty(valEC) == 1 | isnan(valEC) == 1;
%                         ValEC = ' ';
%                     else;
%                         VelLap = [VelLap valEC];
%                     end;
%                 end;
%                 txtSpeed = dataToStr(mean(VelLap),2);
%             end;

%             if Source == 2;
%                 dataTableAverage = classifier{i,68};
%                 if str2num(classifier{i,3}) < 150;
%                     SpeedAverage = dataTableAverage(:,3);
%                 else;
%                     SpeedAverage = dataTableAverage(:,4);
%                 end;
%                 valkeep = [];
%                 for iter = 1:length(SpeedAverage);
%                     valEC = SpeedAverage{iter,1};
%                     if isempty(valEC) == 0
%                         valkeep = [valkeep valEC];
%                     end;
%                 end;
%                 txtSpeed = dataToStr(mean(valkeep),2);
%             elseif Source == 1;
%                 dataTableAverage = classifier{i,68};
% 
%                 if str2num(classifier{i,3}) < 150;
%                     SpeedAverage = dataTableAverage(:,3);
%                 else;
%                     SpeedAverage = dataTableAverage(:,4);
%                 end;
%                 valkeep = [];
%                 for iter = 1:length(SpeedAverage);
%                     valEC = SpeedAverage(iter,1);
%                     if isnan(valEC) == 0
%                         valkeep = [valkeep valEC];
%                     end;
%                 end;
%                 txtSpeed = dataToStr(mean(valkeep),2);
%             elseif Source == 3;
%                 dataTableAverage = classifier{i,68};
% 
%                 if str2num(classifier{i,3}) < 150;
%                     SpeedAverage = dataTableAverage(:,4);
%                 else;
%                     SpeedAverage = dataTableAverage(:,5);
%                 end;
%                 valkeep = [];
%                 for iter = 1:length(SpeedAverage);
%                     valEC = SpeedAverage(iter,1);
%                     if isnan(valEC) == 0
%                         valkeep = [valkeep valEC];
%                     end;
%                 end;
%                 txtSpeed = dataToStr(mean(valkeep),2);                
%             end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









                txtSkill = classifier{i,15};
                if findstr(txtSkill, 'NaN') == 1;
                    txtSkill = 'na';
                end;
                txt = [txtSpeed ' m/s / ' txtSkill];
                txtOBJ{i+1,7} = text(500, posY-9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txtStart = classifier{i,22};
                if turnexist == 1;
                    txt = '';
                    updateHori = 0;
                    updateVert = 0;
                    if dispTurns == 1;
                        valAllTurns = classifier{i,52};
                        if strcmpi(SearchPool, '50');
                            if strcmpi(SearchDistance, '100');
                                txt = ['(' txtStart ' s / ' timeSecToStr(valAllTurns(1)) ')'];
                                posX = 515;
                                txtOBJ{i+1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJ{i+1,9} = [];
                            elseif strcmpi(SearchDistance, '400');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJ{i+1,9} = text(posX, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                                updateVert = 1;
                            end;
                        else;
                            if strcmpi(SearchDistance, '100');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJ{i+1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJ{i+1,9} = text(posX, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                                updateVert = 1;
                            end;
                        end;
                    else;
                        txtTurns = classifier{i,27};
                        index = strfind(txtTurns, '[');
                        txtTurns = txtTurns(1:index-2);
                        txt = ['(' txtStart ' s / ' txtTurns ' s)'];
                        posX = 515;
                        txtOBJ{i+1,9} = [];
                        updateHori = 1;
                    end;
                    txtOBJ{i+1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                    if updateHori == 1;   
                        posTxt = get(txtOBJ{i+1,8}, 'Position');
                        posTxt(1) = 520;
                        set(txtOBJ{i+1,8}, 'Position', posTxt);
                    end;
                    if updateVert == 1;
                        posTxt = get(txtOBJ{i+1,7}, 'Position');
                        posTxt(2) = posY-13;
                        set(txtOBJ{i+1,7}, 'Position', posTxt);
    
                        posTxt = get(txtOBJ{i+1,8}, 'Position');
                        posTxt(1) = posTxt(1)+15;
                        posTxt(2) = posY+3;
                        set(txtOBJ{i+1,8}, 'Position', posTxt, 'Fontsize', fontEC3-0.005);
    
                        posTxt = get(txtOBJ{i+1,9}, 'Position');
                        posTxt(1) = posTxt(1)+15;
                        set(txtOBJ{i+1,9}, 'Position', posTxt, 'Fontsize', fontEC3-0.005);
                    end;
                else;
                    txtFinish = timeSecToStr(classifier{i,41});
                    txt = ['(' txtStart ' s / ' txtFinish ')'];
                    txtOBJ{i+1,8} = text(515, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                    txtOBJ{i+1,9} = [];
                end;

                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,10} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,11} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,12} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,13} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
    
            txtMainRanking = txtOBJ;

            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'RaceTime';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
                for i = 1:length(databaseCurrentName(:,1));
                    val = classifierName{i,1};
                    liSec = strfind(val, ' s');
                    if isempty(liSec) == 0;
                        timeEC(i,1) = str2num(val(1:5));
                    else;
                        lidot = strfind(val, ':');
                        min = str2num(val(1:lidot-1)).*60;
                        sec = str2num(val(lidot+1:lidot+3));
                        hun = str2num(['0.' val(end-1:end)]);
                        timeEC(i,1) = min+sec+hun;
                    end;
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'ascend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
    
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                Source = classifierName{1,58};
                hold on;
                posY = 22.5;
    
                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,4} = text(250, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,colACT};
                txtOBJSecondary{1,5} = text(300, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
    
                val = classifierName{1,colACT};
                liSec = strfind(val, ' s');
                if isempty(liSec) == 0;
                    timeAct = str2num(val(1:5));
                else;
                    lidot = strfind(val, ':');
                    min = str2num(val(1:lidot-1)).*60;
                    sec = str2num(val(lidot+1:lidot+3));
                    hun = str2num(['0.' val(end-1:end)]);
                    timeAct = min+sec+hun;
                end;
                DiffCalsec = [dataToStr(abs(timeAct - timeRef),2) ' s'];
                DiffCalper = [dataToStr((abs(timeAct - timeRef)./timeRef).*100,2) ' %'];
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJSecondary{1,6} = text(380, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);

                txtSpeed = classifierName{1,32};
                txtSkill = classifierName{1,15};
                if findstr(txtSkill, 'NaN') == 1;
                    txtSkill = 'na';
                end;
                txt = [txtSpeed ' m/s / ' txtSkill];
                txtOBJSecondary{1,7} = text(500, posY-9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txtStart = classifierName{1,22};
                if turnexist == 1;
                    txt = '';
                    updateHori = 0;
                    updateVert = 0;
                    if dispTurns == 1;
                        valAllTurns = classifierName{1,52};
                        if strcmpi(SearchPool, '50');
                            if strcmpi(SearchDistance, '100');
                                txt = ['(' txtStart ' s / ' timeSecToStr(valAllTurns(1)) ')'];
                                posX = 515;
                                txtOBJSecondary{1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJSecondary{1,9} = [];
                            elseif strcmpi(SearchDistance, '400');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJSecondary{1,9} = text(posX, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                updateVert = 1;
                            end;
                        else;
                            if strcmpi(SearchDistance, '100');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJSecondary{1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txt = ['(' txtStart ' s / '];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 480;
                                txtOBJSecondary{1,9} = text(posX, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                updateVert = 1;
                            end;
                        end;
                    else;
                        txtTurns = classifierName{1,27};
                        index = strfind(txtTurns, '[');
                        txtTurns = txtTurns(1:index-2);
                        txt = ['(' txtStart ' s / ' txtTurns ' s)'];
                        posX = 515;
                        txtOBJSecondary{1,9} = [];
                        updateHori = 1;
                    end;
                    txtOBJSecondary{1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6, 'Color', [1 1 1]);
                    if updateHori == 1;   
                        posTxt = get(txtOBJSecondary{1,8}, 'Position');
                        posTxt(1) = 510;
                        set(txtOBJSecondary{1,8}, 'Position', posTxt);
                    end;
                    if updateVert == 1;
                        posTxt = get(txtOBJSecondary{1,7}, 'Position');
                        posTxt(2) = posY-13;
                        set(txtOBJSecondary{1,7}, 'Position', posTxt);
    
                        posTxt = get(txtOBJSecondary{1,8}, 'Position');
                        posTxt(1) = posTxt(1)+15;
                        posTxt(2) = posY+3;
                        set(txtOBJSecondary{1,8}, 'Position', posTxt, 'Fontsize', fontEC6-0.02);
    
                        posTxt = get(txtOBJSecondary{1,9}, 'Position');
                        posTxt(1) = posTxt(1)+15;
                        set(txtOBJSecondary{1,9}, 'Position', posTxt, 'Fontsize', fontEC6-0.02);
                    end;

                else;
                    txtFinish = timeSecToStr(classifierName{1,41});
                    txt = ['(' txtStart ' s / ' txtFinish ')'];
                    txtOBJSecondary{1,8} = text(515, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6, 'Color', [1 1 1]);
                    txtOBJSecondary{1,9} = [];
                end;

                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,10} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,11} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,12} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,13} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
    
                txtSecondaryRanking = txtOBJSecondary;
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
            
        elseif valDataset == 3;
            
            %Swim Speed
            colACT = 32;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'SwimSpeed';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                val = classifier{i,1};
                timeEC(i,1) = str2num(val);
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'Descend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(handles.MainRanking_benchmark);
            hold on;  
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(300, 19, 'Swim Speed', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(445, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(610, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,7} = text(800, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(970, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
    
            posY = 68;
    
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};


                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,colACT};
                txtOBJ{i+1,5} = text(315, posY, [txt ' m/s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                if i == 1;
                    val = classifier{i,colACT};
                    valRef = str2num(val);
                    DiffCalsec = '0.00 m/s';
                    DiffCalper = '0.00 %';
                else;
                    val = classifier{i,colACT};
                    valAct = str2num(val);
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' m/s'];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) ' %'];
                end;
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJ{i+1,6} = text(405, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,7} = text(550, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,8} = text(800, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,10} = text(985, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
    
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'SwimSpeed';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
                for i = 1:length(databaseCurrentName(:,1));
                    val = classifierName{i,1};
                    timeEC(i,1) = str2num(val);
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'Descend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
                
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                Source = classifierName{1,58};
                hold on;
                posY = 22.5;
    
                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,colACT};
                txtOBJSecondary{1,5} = text(315, posY, [txt ' m/s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                val = classifierName{1,colACT};
                valAct = str2num(val);
                DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' m/s'];
                DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) ' %'];
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJSecondary{1,6} = text(405, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,7} = text(550, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,8} = text(800, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,10} = text(985, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                txtSecondaryRanking = txtOBJSecondary;
    
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
            
        elseif valDataset == 4;
            
            %Stroke Efficiency
            colACT = 31;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'StrokeEff';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                val = classifier{i,1};
                timeEC(i,1) = str2num(val);
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'Descend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;  
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(290, 19, 'Stroke Index', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(430, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(515, 19, 'SR / DPS / VEL', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,7} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,colACT};
                txtOBJ{i+1,5} = text(290, posY, [txt ' m2/s/str'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                if i == 1;
                    val = classifier{i,colACT};
                    valRef = str2num(val);
                    DiffCalsec = '0.00';
                    DiffCalper = '0.00 %';
                else;
                    val = classifier{i,colACT};
                    valAct = str2num(val);
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2)];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) ' %'];
                end;
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJ{i+1,6} = text(400, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txtSR = num2str(roundn(str2num(classifier{i,33}),-1));
                txtDPS = classifier{i,34};
                txtVEL = classifier{i,32};
                txt = [txtSR ' / ' txtDPS ' / ' txtVEL];
                txtOBJ{i+1,7} = text(510, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,8} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,10} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,11} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
    
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'StrokeEff';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
                for i = 1:length(databaseCurrentName(:,1));
                    val = classifierName{i,1};
                    timeEC(i,1) = str2num(val);
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'Descend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
    
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                Source = classifierName{1,58};
                hold on;
                posY = 22.5;
    
                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,colACT};
                txtOBJSecondary{1,5} = text(290, posY, [txt ' m2/s/str'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                val = classifierName{1,colACT};
                valAct = str2num(val);
                DiffCalsec = [dataToStr(abs(valAct - valRef),2)];
                DiffCalper = [dataToStr(abs(((valAct - valRef)./valRef).*100),2) ' %'];
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJSecondary{1,6} = text(400, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txtSR = num2str(roundn(str2num(classifierName{1,33}),-1));
                txtDPS = classifierName{1,34};
                txtVEL = classifierName{1,32};
                txt = [txtSR ' / ' txtDPS ' / ' txtVEL];
                txtOBJSecondary{1,7} = text(510, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,8} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,10} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,11} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                txtSecondaryRanking = txtOBJSecondary;
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
    
        elseif valDataset == 5;
            %Speed Decay
%            if SearchDistance == 50 | SearchDistance == 100;
            colACT = 61;
%             elseif SearchDistance == 150 | SearchDistance == 200 | SearchDistance == 400;
%                 colACT = 62;
%           else;
%                 colACT = 63;
%           end;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'SpeedDecay';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
    %         for i = 1:length(databaseCurrent(:,1));
    %             timeEC(i,1) = abs(0.5 - classifier{i,1});
    %             timeECori(i,1) = classifier{i,1};
    %         end;
    %         [timeEC, index] = sort(timeEC, 'Ascend');
    %         timeECori = timeECori(index,1);
    %         classifier = databaseCurrent(index,:);
    %         MatAge = MatAge(index,:);
            for i = 1:length(databaseCurrent(:,1));
                if strcmpi(SearchStroke, 'Medley') == 1;
                    valZones = classifier{i,1};
                    timeEC(i,1) = mean(valZones(:,1)) + mean(valZones(:,8));
                else;
                    valZones = classifier{i,1};
                    timeEC(i,1) = valZones(1) + valZones(8);
                end;
            end;
            [timeEC, index] = sort(timeEC, 'Descend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
    %         classifier = timeEC;
    %         [output, index] = sort(classifier, 'Descend');
    %         classifier = databaseCurrent(index,:);
    %         MatAge = MatAge(index,:);
            
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(290, 19, 'Speed Decay', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(410, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(470, 19, 'Ref Speed / Decay Index', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,7} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                
                
                if strcmpi(SearchStroke, 'Medley') == 1;
                    valZones = classifier{i,colACT};
                    txt = [dataToStr((mean(valZones(:,1)) + mean(valZones(:,8))).*100,2) ' %'];
                else;
                    valZones = classifier{i,colACT};
                    txt = [dataToStr((valZones(1) + valZones(8)).*100,2) ' %'];
                end;
    %             txt = [dataToStr(mean(classifier{i,colACT}.*100),2) ' %'];
                txtOBJ{i+1,5} = text(310, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                if i == 1;
                    valRef = timeEC(i,1).*100;
    %                 valRef = classifier{i,colACT}.*100;
                    DiffCalsec = '0.00 %';
                    DiffCalper = '0.00';
                else;
                    valAct = timeEC(i,1).*100;
    %                 valAct = classifier{i,colACT}.*100;
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' %'];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef)*100,2)];
    %                 DiffCalper = [dataToStr(roundn((abs(valAct - valRef)./valRef).*100,-2))];
                end;
                txt = [DiffCalsec '  (' DiffCalper '%)'];
                txtOBJ{i+1,6} = text(380, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                
                SpeedDecayRef = classifier{i,43};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = classifier{i,61};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                txt = [dataToStr(SpeedDecayRef,2) ' m/s / ' dataToStr(decayIndex,2)];
                txtOBJ{i+1,7} = text(505, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,8} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,10} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,11} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
            
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'SpeedDecay';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
    %             for i = 1:length(databaseCurrentName(:,1));
    %                 timeECName(i,1) = abs(0.5 - classifierName{i,1});
    %                 timeECoriName(i,1) = classifierName{i,1};
    %             end;
    %             [timeECName, indexName] = sort(timeECName, 'Ascend');
    %             timeECoriName = timeECoriName(indexName,1);
    %             classifierName = databaseCurrentName(indexName,:);
    %             MatAgeName = MatAgeName(indexName,:);
                for i = 1:length(databaseCurrentName(:,1));
                    if strcmpi(SearchStroke, 'Medley') == 1;
                        valZones = classifierName{i,1};
                        timeECName(i,1) = mean(valZones(:,1)) + mean(valZones(:,8));
                    else;
                        valZones = classifierName{i,1};
                        timeECName(i,1) = valZones(1) + valZones(8);
                    end;
                end;
                [timeECName, indexName] = sort(timeECName, 'Descend');
                classifierName = databaseCurrentName(indexName,:);
                MatAgeName = MatAgeName(indexName,:);
            
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                Source = classifierName{1,58};
                hold on;
                posY = 22.5;

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                if strcmpi(SearchStroke, 'Medley') == 1;
                    valZones = classifierName{1,colACT};
                    txt = [dataToStr((mean(valZones(:,1)) + mean(valZones(:,8))).*100,2) ' %'];
                else;
                    valZones = classifierName{1,colACT};
                    txt = [dataToStr((valZones(1) + valZones(8)).*100,2) ' %'];
                end;
                txtOBJSecondary{1,5} = text(310, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                valAct = timeECName(1,1).*100;
    %             valAct = classifierName{1,colACT}.*100;
                DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' %'];
                DiffCalper = [dataToStr((abs(valAct - valRef)./valRef),2)];
                txt = [DiffCalsec '  (' DiffCalper '%)'];
                txtOBJSecondary{1,6} = text(380, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                SpeedDecayRef = classifierName{1,43};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = classifierName{1,61};            
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                txt = [dataToStr(SpeedDecayRef,2) ' m/s / ' dataToStr(decayIndex,2)];
                txtOBJSecondary{1,7} = text(505, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,8} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,10} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,11} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
    
                txtSecondaryRanking = txtOBJSecondary;
            
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
            
        elseif valDataset == 6;
            %Decay Index
%         if SearchDistance == 50 | SearchDistance == 100;
            colACT1 = 43; %Speed ref
            colACT2 = 61; %Speed decay
%         elseif SearchDistance == 150 | SearchDistance == 200 | SearchDistance == 400;
%             colACT = 62;
%         else;
%             colACT = 63;
%         end;
            for i = 1:length(databaseCurrent(:,1));
                SpeedDecayRef = databaseCurrent{i,colACT1};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = databaseCurrent{i,colACT2};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                classifier{i,1} = decayIndex;
            end;
            timeEC = [];
            
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'DecayIndex';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                SpeedDecayRef = databaseCurrent{i,colACT1};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = databaseCurrent{i,colACT2};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                timeEC(i,1) = decayIndex;
            end;
            [timeEC, index] = sort(timeEC, 'Descend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
    %         classifier = timeEC;
    %         [output, index] = sort(classifier, 'Descend');
    %         classifier = databaseCurrent(index,:);
    %         MatAge = MatAge(index,:);
            
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(290, 19, 'Decay Index', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(410, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(470, 19, 'Ref Speed / Speed Decay', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,7} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};
    
                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                SpeedDecayRef = classifier{i,colACT1};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = classifier{i,colACT2};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                txt = [dataToStr(decayIndex, 2)];
                txtOBJ{i+1,5} = text(310, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                if i == 1;
                    valRef = decayIndex;
    %                 valRef = classifier{i,colACT}.*100;
                    DiffCalsec = '0.00';
                    DiffCalper = '0.00';
                else;
                    valAct = decayIndex;
    %                 valAct = classifier{i,colACT}.*100;
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2)];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef)*100,2)];
    %                 DiffCalper = [dataToStr(roundn((abs(valAct - valRef)./valRef).*100,-2))];
                end;
                txt = [DiffCalsec '  (' DiffCalper '%)'];
                txtOBJ{i+1,6} = text(380, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                SpeedDecayRef = classifier{i,43};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = classifier{i,61};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                txt = [dataToStr(SpeedDecayRef,2) ' m/s / ' dataToStr(distriMain*100,2) '%'];
                txtOBJ{i+1,7} = text(505, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,8} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,10} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,11} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
            
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
%                 classifierName = databaseCurrentName(:,colACT);
                SpeedDecayRef = databaseCurrentName{1,colACT1};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = databaseCurrentName{1,colACT2};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                classifierName{1,1} = decayIndex;
    
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'DecayIndex';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
    
                for i = 1:length(databaseCurrentName(:,1));
                    SpeedDecayRef = databaseCurrentName{i,colACT1};
                    SpeedDecayRef = mean(SpeedDecayRef(:,2));
                    SpeedDecay = databaseCurrentName{i,colACT2};
                    distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                    decayIndex = (SpeedDecayRef.^3).*distriMain;
                    timeECName(i,1) = decayIndex;
                end;
                [timeECName, indexName] = sort(timeECName, 'Descend');
                classifierName = databaseCurrentName(indexName,:);
                MatAgeName = MatAgeName(indexName,:);
            
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                Source = classifierName{1,58};
                hold on;
                posY = 22.5;

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                SpeedDecayRef = classifierName{1,colACT1};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = classifierName{1,colACT2};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                decayIndex = (SpeedDecayRef.^3).*distriMain;
                txt = [dataToStr(decayIndex, 2)];
                txtOBJSecondary{1,5} = text(310, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                valAct = timeECName(1,1);
    %             valAct = classifierName{1,colACT}.*100;
                DiffCalsec = [dataToStr(abs(valAct - valRef),2)];
                DiffCalper = [dataToStr((abs(valAct - valRef)./valRef)*100,2)];
                txt = [DiffCalsec '  (' DiffCalper '%)'];
                txtOBJSecondary{1,6} = text(380, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
    
                SpeedDecayRef = classifierName{1,43};
                SpeedDecayRef = mean(SpeedDecayRef(:,2));
                SpeedDecay = classifierName{1,61};
                distriMain = mean(SpeedDecay(:,1)) + mean(SpeedDecay(:,8));
                txt = [dataToStr(SpeedDecayRef,2) ' m/s / ' dataToStr(distriMain*100,2) '%'];
                txtOBJSecondary{1,7} = text(505, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,8} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,9} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,10} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,11} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);

                txtSecondaryRanking = txtOBJSecondary;
            
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;

        elseif valDataset == 7;
            %Skill Time
            if strcmpi(SearchPool, '50');
                if strcmpi(SearchDistance, '50');
                    turnexist = 0;
                else;
                    turnexist = 1;
                end;
            else;
                turnexist = 1;
            end;
            
            colACT = 15;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'SkillTime';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                val = classifier{i,1};
                
                index = strfind(val, 's');
                if isempty(index) == 0;
                    if strfind(val, 'NaN') == 1;
                        timeEC(i,1) = 10000;
                    else;
                        timeEC(i,1) = str2num(val(1:index-2));
                    end;
                else;
                    index = strfind(val, ':');
                    valsec = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                    timeEC(i,1) = valsec;
                end;
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'Ascend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;  
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(300, 19, 'Skills', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(400, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            if turnexist == 1;
                txtOBJ{1,6} = text(470, 19, 'Start / Av.turns / Finish', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            else;
                txtOBJ{1,6} = text(500, 19, 'Start / Finish', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            end;
            txtOBJ{1,7} = text(655, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,colACT};
                txtOBJ{i+1,5} = text(295, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                if i == 1;
                    val = classifier{i,colACT};
                    index = strfind(val, 's');
                    if isempty(index) == 0;
                        valRef = str2num(val(1:index-2));
                    else;
                        index = strfind(val, ':');
                        valRef = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                    end;
                    DiffCalsec = '0.00 s';
                    DiffCalper = '0.00 %';
                else;
                    val = classifier{i,colACT};
                    index = strfind(val, 's');
                    if isempty(index) == 0;
                        valAct = str2num(val(1:index-2));
                    else;
                        index = strfind(val, ':');
                        valAct = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                    end;
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' s'];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) ' %'];
                end;
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJ{i+1,6} = text(370, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txtStart = classifier{i,22};
                if turnexist == 1;
                    txtTurns = classifier{i,27};
                    index = strfind(txtTurns, '[');
                    txtTurns = txtTurns(1:index-2);
                    txtFinish = timeSecToStr(classifier{i,41});
                    txt = [txtStart ' s / ' txtTurns ' s / ' txtFinish];
                    if dispTurns == 1;
                        valAllTurns = classifier{i,52};
                        if strcmpi(SearchPool, '50');
                            if strcmpi(SearchDistance, '100');
                                txtOBJ{i+1,7} = text(490, posY-10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                                posX = 540;
                                txt = ['(' timeSecToStr(valAllTurns(1)) ')'];
                                txtOBJ{i+1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                                txtOBJ{i+1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txtOBJ{i+1,7} = text(490, posY-10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 500;
                                txtOBJ{i+1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                                txtOBJ{i+1,9} = [];
                            elseif strcmpi(SearchDistance, '400');
                                txtOBJ{i+1,7} = text(490, posY-12, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txtOBJ{i+1,8} = text(515, posY+3, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3-0.005, 'Color', [1 1 1]);
                                txtOBJ{i+1,9} = text(495, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3-0.005, 'Color', [1 1 1]);
                                updateVert = 1;
                            end;
                        else;
                            if strcmpi(SearchDistance, '100');
                                txtOBJ{i+1,7} = text(490, posY-10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 500;
                                txtOBJ{i+1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [1 1 1]);
                                txtOBJ{i+1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txtOBJ{i+1,7} = text(490, posY-12, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txtOBJ{i+1,8} = text(515, posY+3, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3-0.005, 'Color', [1 1 1]);
                                txtOBJ{i+1,9} = text(495, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3-0.005, 'Color', [1 1 1]);
                                updateVert = 1;
                            end;
                        end;
                    else;
                        txtOBJ{i+1,7} = text(490, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                        txtOBJ{i+1,8} = [];
                        txtOBJ{i+1,9} = [];
                    end;
                else;
                    txtFinish = timeSecToStr(classifier{i,41});
                    txt = [txtStart ' s / ' txtFinish];
                    txtOBJ{i+1,7} = text(505, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    txtOBJ{i+1,8} = [];
                    txtOBJ{i+1,9} = [];
                end;
                txt = classifier{i,7};
                if length(txt) > 20;
                    txt = [txt(1:20) '...'];
                end;
                txtOBJ{i+1,10} = text(655, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,11} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,12} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,13} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
    
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'SkillTime';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
                for i = 1:length(databaseCurrentName(:,1));
                    val = classifierName{i,1};
    
                    index = strfind(val, 's');
                    if isempty(index) == 0;
                        timeEC(i,1) = str2num(val(1:index-2));
                    else;
                        index = strfind(val, ':');
                        valsec = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                        timeEC(i,1) = valsec;
                    end;
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'Ascend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
                
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                Source = classifierName{1,58};
                hold on;
                posY = 22.5;

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,2} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,3} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,4} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,colACT};
                txtOBJSecondary{1,5} = text(295, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                val = classifierName{1,colACT};
                index = strfind(val, 's');
                if isempty(index) == 0;
                    valAct = str2num(val(1:index-2));
                else;
                    index = strfind(val, ':');
                    valAct = str2num(val(1:index-1)).*60 + str2num(val(index+1:end));
                end;
                DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' s'];
                DiffCalper = [dataToStr(abs(((valAct - valRef)./valRef).*100),2) ' %'];
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJSecondary{1,6} = text(370, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txtStart = classifierName{1,22};

                if turnexist == 1;
                    txtTurns = classifierName{1,27};
                    index = strfind(txtTurns, '[');
                    txtTurns = txtTurns(1:index-2);
                    txtFinish = timeSecToStr(classifierName{1,41});
                    txt = [txtStart ' s / ' txtTurns ' s / ' txtFinish];
                    if dispTurns == 1;
                        valAllTurns = classifierName{1,52};
                        if strcmpi(SearchPool, '50');
                            if strcmpi(SearchDistance, '100');
                                txtOBJSecondary{1,7} = text(490, posY-10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                posX = 540;
                                txt = ['(' timeSecToStr(valAllTurns(1)) ')'];
                                txtOBJSecondary{1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6, 'Color', [1 1 1]);
                                txtOBJSecondary{1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txtOBJSecondary{1,7} = text(490, posY-10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 500;
                                txtOBJSecondary{1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6, 'Color', [1 1 1]);
                                txtOBJSecondary{1,9} = [];
                            elseif strcmpi(SearchDistance, '400');
                                txtOBJSecondary{1,7} = text(490, posY-12, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txtOBJSecondary{1,8} = text(515, posY+3, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6-0.02, 'Color', [1 1 1]);
                                txtOBJSecondary{1,9} = text(495, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6-0.02, 'Color', [1 1 1]);
                            end;
                        else;
                            if strcmpi(SearchDistance, '100');
                                txtOBJSecondary{1,7} = text(490, posY-10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                posX = 500;
                                txtOBJSecondary{1,8} = text(posX, posY+10, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6, 'Color', [1 1 1]);
                                txtOBJSecondary{1,9} = [];
                            elseif strcmpi(SearchDistance, '200');
                                txtOBJSecondary{1,7} = text(490, posY-12, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                                txt = ['('];
                                for lap = 1:3;
                                    if lap == 3;
                                        txt = [txt timeSecToStr(valAllTurns(lap))];
                                    else;
                                        txt = [txt timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txt2 = '';
                                for lap = 4:7;
                                    if lap == 7;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ')'];
                                    else;
                                        txt2 = [txt2 timeSecToStr(valAllTurns(lap)) ' / '];
                                    end;
                                end;
                                txtOBJSecondary{1,8} = text(515, posY+3, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6-0.02, 'Color', [1 1 1]);
                                txtOBJSecondary{1,9} = text(495, posY+15, txt2, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC6-0.02, 'Color', [1 1 1]);
                            end;
                        end;
                    else;
                        txtOBJSecondary{1,7} = text(490, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                        txtOBJSecondary{1,8} = [];
                        txtOBJSecondary{1,9} = [];
                    end;
                else;
                    txtFinish = timeSecToStr(classifierName{1,41});
                    txt = [txtStart ' s / ' txtFinish];
                    txtOBJSecondary{1,7} = text(505, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    txtOBJSecondary{1,8} = [];
                    txtOBJSecondary{1,9} = [];
                end;

                txt = classifierName{1,7};
                if length(txt) > 20;
                    txt = [txt(1:20) '...'];
                end;
                txtOBJSecondary{1,10} = text(655, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,11} = text(860, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,12} = text(910, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,13} = text(990, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                txtSecondaryRanking = txtOBJSecondary;
    
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
    
        elseif valDataset == 8;
            %Block Time (RT)
            colACT = 21;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'BlockTime';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                val = classifier{i,1};
                timeEC(i,1) = str2num(val);
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'Ascend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
%             set(allchild(MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;  
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(300, 19, 'RT', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(400, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(485, 19, 'Start / Skills', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,7} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,11} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,2} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,3} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = num2str(classifier{i,colACT});
                txtOBJ{i+1,4} = text(295, posY, [txt ' s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                if i == 1;
                    valRef = str2num(classifier{i,colACT});
                    DiffCalsec = '0.00 s';
                    DiffCalper = '0.00 %';
                else;
                    valAct = str2num(classifier{i,colACT});
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' s'];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) ' %'];
                end;
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJ{i+1,5} = text(370, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txtStart = classifier{i,22};
                txtSkills = classifier{i,15};
                txt = [txtStart ' s / ' txtSkills];
                txtOBJ{i+1,6} = text(490, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,7} = text(665, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,8} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,9} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,10} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
    
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'BlockTime';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
            
                for i = 1:length(databaseCurrentName(:,1));
                    val = classifierName{i,1};
                    timeEC(i,1) = str2num(val);
    
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'Ascend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
                
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                hold on;
                posY = 22.5;

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,11} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,2} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,3} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = num2str(classifierName{1,colACT});
                txtOBJSecondary{1,4} = text(295, posY, [txt ' s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                valAct = str2num(classifierName{1,colACT});
                DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' s'];
                DiffCalper = [dataToStr(abs(((valAct - valRef)./valRef).*100),2) ' %'];
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJSecondary{1,5} = text(370, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txtStart = classifierName{1,22};
                txtSkills = classifierName{1,15};
                txt = [txtStart ' s / ' txtSkills];
                txtOBJSecondary{1,6} = text(490, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,7};
                if length(txt) > 20;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,7} = text(665, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,8} = text(860, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,9} = text(910, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,10} = text(990, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                txtSecondaryRanking = txtOBJSecondary;
                
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
    
        elseif valDataset == 9;
            %Start Time
            colACT = 22;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                colsource = 'StartTime';
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            for i = 1:length(databaseCurrent(:,1));
                val = classifier{i,1};
                if findstr(val, 'NaN') == 1;
                    val = '10000';
                end;
                timeEC(i,1) = str2num(val);
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'Ascend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;  
            txtOBJ{1,1} = text(15, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(65, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(245, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,4} = text(295, 19, 'Start', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,5} = text(380, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,6} = text(475, 19, 'RT / BODist / Kicks', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,7} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,11} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,2} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,3} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = num2str(classifier{i,colACT});
                txtOBJ{i+1,4} = text(295, posY, [txt ' s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                if i == 1;
                    valRef = str2num(classifier{i,colACT});
                    DiffCalsec = '0.00 s';
                    DiffCalper = '0.00 %';
                else;
                    valAct = str2num(classifier{i,colACT});
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' s'];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) ' %'];
                end;
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJ{i+1,5} = text(350, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txtRT = classifier{i,21};
                txtBO = classifier{i,25};
                if Source == 1;
                    skillTable = classifier{i,71};
                    startTimeEC = skillTable{22,3};
                    indexInterp = isempty(strfind(startTimeEC, '!'));
                elseif Source == 2;
                    indexInterp = 1;
                elseif Source == 3;
                    skillTable = classifier{i,71};
                    startTimeEC = skillTable{22,3};
                    indexInterp = isempty(strfind(startTimeEC, '!'));
                end;
                index1 = strfind(txtBO, '(');
                index2 = strfind(txtBO, 'k');
    
                if isempty(index1) == 1 & isempty(index2) == 1;
                    if indexInterp == 1;
                        txtBOAll = [txtBO 'm'];
                    else;
                        txtBOAll = '(na)';
                    end;
                elseif isempty(index1) == 0 & isempty(index2) == 1;
                    if indexInterp == 1;
                        txtBOAll = [txtBO(1:index1-2) 'm / ' txtBO(index1:end)];
                    else;
                        txtBOAll = ['(na) / ' txtBO(index1:end)];
                    end;
                else;
                    if indexInterp == 1;
                        txtBOAll = [txtBO(1:index1(1)-3) 'm / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                    else;
                        txtBOAll = ['(na) / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                    end;
                end;
                txt = [txtRT 's / ' txtBOAll];
                txtOBJ{i+1,6} = text(485, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,7} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,8} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,9} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,10} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
    
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    colsource = 'StartTime';
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
                for i = 1:length(databaseCurrentName(:,1));
                    val = classifierName{i,1};
                    timeEC(i,1) = str2num(val);
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'Ascend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
                
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
                
%                 set(allchild(SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                hold on;
                posY = 22.5;

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJSecondary{1,11} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,2} = text(65, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,3} = text(245, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = num2str(classifierName{1,colACT});
                txtOBJSecondary{1,4} = text(295, posY, [txt ' s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                valAct = str2num(classifierName{1,colACT});
                DiffCalsec = [dataToStr(abs(valAct - valRef),2) ' s'];
                DiffCalper = [dataToStr(abs(((valAct - valRef)./valRef).*100),2) ' %'];
                txt = [DiffCalsec '  (' DiffCalper ')'];
                txtOBJSecondary{1,5} = text(350, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
    
                txtRT = classifierName{1,21};
                txtBO = classifierName{1,25};
                if Source == 1;
                    skillTable = classifierName{1,71};
                    startTimeEC = skillTable{22,3};
                    indexInterp = isempty(strfind(startTimeEC, '!'));
                elseif Source == 2;
                    indexInterp = 1;
                elseif Source == 3;
                    skillTable = classifierName{1,71};
                    startTimeEC = skillTable{22,3};
                    indexInterp = isempty(strfind(startTimeEC, '!'));
                end;
                index1 = strfind(txtBO, '(');
                index2 = strfind(txtBO, 'k');
                if isempty(index1) == 1 & isempty(index2) == 1;
                    if indexInterp == 1;
                        txtBOAll = [txtBO 'm'];
                    else;
                        txtBOAll = '(na)';
                    end;
                elseif isempty(index1) == 0 & isempty(index2) == 1;
                     if indexInterp == 1;
                        txtBOAll = [txtBO(1:index1-2) 'm / ' txtBO(index1:end)];
                    else;
                        txtBOAll = ['(na) / ' txtBO(index1:end)];
                    end;
                else;
                    if indexInterp == 1;
                        txtBOAll = [txtBO(1:index1(1)-3) 'm / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                    else;
                        txtBOAll = ['(na) / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                    end;
                end;
                txt = [txtRT 's / ' txtBOAll];
                txtOBJSecondary{1,6} = text(485, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,7} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,8} = text(860, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,9} = text(910, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,10} = text(990, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                
                txtSecondaryRanking = txtOBJSecondary;
            
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
            
        elseif valDataset == 10;
            %Turn Time/Finish Time
            if strcmpi(SearchPool, '50');
                if strcmpi(SearchDistance, '50');
                    turnexist = 0;
                else;
                    turnexist = 1;
                end;
            else;
                turnexist = 1;
            end;
            if turnexist == 1;
                %turn;
                colACT = 39;
            else;
                %last5
                colACT = 41;
            end;
            classifier = databaseCurrent(:,colACT);
            timeEC = [];
      
            if valPB == 2;
                %filter down to PB, SB, CB (based on race time)
                classifierName = databaseCurrent(:,2);
                if turnexist == 1;
                    colsource = 'TurnTime';
                else;
                    colsource = 'FinishTime';
                end;
                [classifierFILT, likeepPBs] = PBfilter(classifier, classifierName, colsource);
                classifier = classifierFILT;
                databaseCurrent = databaseCurrent(likeepPBs,:);
                MatAge = MatAge(likeepPBs,:);
            end;
            
            if isempty(databaseCurrent) == 0;
                limInfRanking = 1;
                if length(databaseCurrent(:,1)) >= 10;
                    limSupRanking = 10;
                else;
                    limSupRanking = length(databaseCurrent(:,1));
                end;
            end;
            
            if turnexist == 1;
                %Turn
                for i = 1:length(databaseCurrent(:,1));
                    val = classifier{i,1};
                    if findstr(val, 'NaN') == 1;
                        val = '10000';
                    end;
                    timeEC(i,1) = str2num(val);
                end;
                
            else;
                %Last5
                for i = 1:length(databaseCurrent(:,1));
                    timeEC(i,1) = classifier{i,1};
                end;
            end;
            classifier = timeEC;
            [output, index] = sort(classifier, 'Ascend');
            classifier = databaseCurrent(index,:);
            MatAge = MatAge(index,:);
            
            if turnexist == 1;
                if strcmpi(SearchPool, '25');
                    if strcmpi(SearchDistance, '100');
                        nbTurns = 3;
                    elseif strcmpi(SearchDistance, '150');
                        nbTurns = 5;
                    elseif strcmpi(SearchDistance, '200');
                        nbTurns = 7;
                    elseif strcmpi(SearchDistance, '400');
                        nbTurns = 15;
                    elseif strcmpi(SearchDistance, '800');
                        nbTurns = 31;
                    elseif strcmpi(SearchDistance, '1500');
                        nbTurns = 59;
                    end;
                else;
                    if strcmpi(SearchDistance, '100');
                        nbTurns = 1;
                    elseif strcmpi(SearchDistance, '150');
                        nbTurns = 2;
                    elseif strcmpi(SearchDistance, '200');
                        nbTurns = 3;
                    elseif strcmpi(SearchDistance, '400');
                        nbTurns = 7;
                    elseif strcmpi(SearchDistance, '800');
                        nbTurns = 15;
                    elseif strcmpi(SearchDistance, '1500');
                        nbTurns = 29;
                    end;
                end;
            end;

%             set(allchild(handles.MainRanking_benchmark), 'Visible', 'on');
            axes(MainRanking_benchmark);
            hold on;  
            
            txtOBJ{1,1} = text(10, 19, 'Rank', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,2} = text(55, 19, 'Athlete Name', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            txtOBJ{1,3} = text(235, 19, 'Age', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC2, 'Color', [0 0 0]);
            if turnexist == 1;
                txtOBJ{1,4} = text(285, 19, 'Turn [in/out]', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
                txtOBJ{1,5} = text(400, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
                if nbTurns <= 7;
                    kTxt = 'Kicks';
                else;
                    kTxt = 'Av.Kicks';
                end;
                txtOBJ{1,6} = text(460, 19, ['App / BODist / ' kTxt], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            else;
                txtOBJ{1,4} = text(300, 19, 'Finish', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
                txtOBJ{1,5} = text(400, 19, 'Diff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
                txtOBJ{1,6} = text(475, 19, 'Dist / Time / Eff', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            end;
            txtOBJ{1,7} = text(650, 19, 'Meet', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,8} = text(870, 19, 'Year', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,9} = text(920, 19, 'Round', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            txtOBJ{1,10} = text(1000, 19, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [0 0 0]);
            
            posY = 68;
            for i = limInfRanking:limSupRanking;
                Source = classifier{i,58};

                if Source == 3;
                    txt = ['^(^G^E^)'];
                else;
                    txt = ['^(^S^P^' num2str(Source) '^)'];
                end;
                txtOBJ{i+1,11} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(i);
                txtOBJ{i+1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC3, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifier{i,2};
                if length(txt) > 20;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJ{i+1,2} = text(55, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = [num2str(MatAge(i,1)) 'y'];
                txtOBJ{i+1,3} = text(235, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                
                if turnexist == 1;
                    txtTT = num2str(classifier{i,colACT});
                    txtTI = num2str(classifier{i,37});
                    txtTO = num2str(classifier{i,38});
                    txt = [];
                    txt =  ['[' txtTI ' / ' txtTO ']'];
                    txtOBJ{i+1,4} = text(315, posY-9, [txtTT ' s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    txtOBJ{i+1,5} = text(290, posY+9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                else;
                    txt = [timeSecToStr(classifier{i,colACT})];
                    txtOBJ{i+1,4} = text(305, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                end;
    
                if i == 1;
                    if turnexist == 1;
                        valRef = str2num(classifier{i,colACT});
                    else;
                        valRef = classifier{i,colACT};
                    end;
                    DiffCalsec = '0.00s';
                    DiffCalper = '0.00%';
                else;
                    if turnexist == 1;
                        valAct = str2num(classifier{i,colACT});
                    else;
                        valAct = classifier{i,colACT};
                    end;
                    DiffCalsec = [dataToStr(abs(valAct - valRef),2) 's'];
                    DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) '%'];
                end;
                
                if turnexist == 1;
                    txtOBJ{i+1,6} = text(400, posY-9, DiffCalsec, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    txt = ['(' DiffCalper ')'];
                    txtOBJ{i+1,7} = text(390, posY+9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    txtAppEff = classifier{i,28};
                    index = strfind(txtAppEff, '[');
                    txtAppEff = txtAppEff(1:index(1)-3);
                    
                    txtBO = classifier{i,29};
                    if Source == 1;
                        skillTable = classifier{i,71};
                        startTimeEC = skillTable{28,3};
                        indexInterp = isempty(strfind(startTimeEC, '!'));
                    elseif Source == 2;
                        indexInterp = 1;
                    elseif Source == 3;
                        skillTable = classifier{i,71};
                        startTimeEC = skillTable{28,3};
                        indexInterp = isempty(strfind(startTimeEC, '!'));
                    end;
                    index1 = strfind(txtBO, '(');
                    index2 = strfind(txtBO, 'k');
                    txtBODist = [txtBO 'm'];
    
                    kickCount = classifier{i,64};
                    kicktxt = [];
                    if isempty(kickCount) == 0;
                        if nbTurns <= 7;
                            for kickEC = 2:length(kickCount);
                                if kickEC == 2;
                                    kicktxt = [num2str(kickCount(kickEC))];
                                else;
                                    kicktxt = [kicktxt ',' num2str(kickCount(kickEC))];
                                end;
                            end;
                        else;
                            kicktxt = num2str(roundn(mean(kickCount),0));
                        end;
                    else;
                        kicktxt = '0';
                    end;
                    if Source == 1 | Source == 3;
                        if isempty(index1) == 1 & isempty(index2) == 1;
                            if indexInterp == 1;
                                txt = ['(na) / ' txtBO 'm / (na)'];
                            else;
                                txt = ['(na) / (na) / (na)'];
                            end;
                        elseif isempty(index1) == 0 & isempty(index2) == 1;
                            if indexInterp == 1;
                                txt = ['(na) / ' txtBO(1:index1-2) 'm / ' txtBO(index1:end)];
                            else;
                                txt = ['(na) / (na) / ' txtBO(index1:end)];
                            end;
                        else;
                            if indexInterp == 1;
                                txt = ['(na) / ' txtBO(1:index1(1)-3) 'm / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                            else;
                                txt = ['(na) / (na) / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                            end;
                        end;
                    elseif Source == 2;
                        if isempty(index1) == 1 & isempty(index2) == 1;
                            txt = [txtAppEff '% / ' txtBO 'm / (na)'];
                        elseif isempty(index1) == 0 & isempty(index2) == 1;
                            txt = [txtAppEff '% / ' txtBO(1:index1-2) 'm / ' txtBO(index1:end)];
                        else;
                            txt = [txtAppEff '% / ' txtBO(1:index1(1)-3) 'm / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                        end;
                    end;
    
                    if nbTurns == 1;
                        posX = 480;
                    elseif nbTurns == 2;
                        posX = 480;
                    elseif nbTurns == 3;
                        posX = 475;
                    elseif nbTurns == 7;
                        posX = 460;
                    else;
                        posX = 490;
                    end;
                    txtOBJ{i+1,8} = text(posX, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                else;
                    txtOBJ{i+1,6} = text(400, posY-9, DiffCalsec, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    txt = ['(' DiffCalper ')'];
                    txtOBJ{i+1,7} = text(390, posY+9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    
                    txtDist = dataToStr(classifier{i,44},2);
                    txtTime = dataToStr(classifier{i,45},2);
                    txtEff = dataToStr(classifier{i,46}.*100,1);
                    if Source == 1 | Source == 3;
                        txt = ['     na / na / na'];
                    elseif Source == 2;
                        txt = [txtDist 'm / ' txtTime 's / ' txtEff '%'];
                    end;
                    txtOBJ{i+1,8} = text(470, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                    
                end;
                
                txt = classifier{i,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJ{i+1,9} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,8};
                txtOBJ{i+1,10} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,6};
    
                if isempty(strfind(classifier{i,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJ{i+1,11} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
                txt = classifier{i,14};
                txtOBJ{i+1,12} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC1, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
            end;
            hold off;
            txtMainRanking = txtOBJ;
    
            if isempty(databaseCurrentName) == 0;
                classifierName = databaseCurrentName(:,colACT);
                timeEC = [];
                if valPB == 2;
                    %filter down to PB, SB, CB (based on race time)
                    classifierName2 = databaseCurrentName(:,2);
                    if turnexist == 1;
                        colsource = 'TurnTime';
                    else;
                        colsource = 'FinishTime';
                    end;
                    [classifierFILT, likeepPBs] = PBfilter(classifierName, classifierName2, colsource);
                    classifierName = classifierFILT;
                    databaseCurrentName = databaseCurrentName(likeepPBs,:);
                    MatAgeName = MatAgeName(likeepPBs,:);
                end;
                
                if turnexist == 1;
                    %Turn
                    for i = 1:length(databaseCurrentName(:,1));
                        val = classifierName{i,1};
                        timeEC(i,1) = str2num(val);
                    end;
                else;
                    %Last5
                    for i = 1:length(databaseCurrentName(:,1));
                        timeEC(i,1) = classifierName{i,1};
                    end;
                end;
                classifierName = timeEC;
                [output, index] = sort(classifierName, 'Ascend');
                classifierName = databaseCurrentName(index,:);
                MatAgeName = MatAgeName(index,:);
            
                RaceUID = classifierName{1,1};
                lisearch = strfind(classifier(:,1), RaceUID);
                RankName = find(~cellfun('isempty', lisearch));
    
%                 set(allchild(SecondaryRanking_benchmark), 'Visible', 'on');
                axes(SecondaryRanking_benchmark);
                hold on;
                posY = 22.5;

                txt = ['^(^S^P^' num2str(Source) '^)'];
                txtOBJSecondary{1,11} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC4, 'Color', [0 0 0], 'VerticalAlignment', 'Bottom', 'HorizontalAlignment', 'center');
                txt = num2str(RankName);
                txtOBJSecondary{1,1} = text(30, posY+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [0 0 0], 'VerticalAlignment', 'Middle', 'HorizontalAlignment', 'center');
                txt = classifierName{1,2};
                if length(txt) > 22;
                    index = strfind(txt, ' ');
                    txt = [txt(1) '.' txt(index+1:end)];
                end;
                txtOBJSecondary{1,2} = text(55, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = [num2str(MatAgeName(1,1)) 'y'];
                txtOBJSecondary{1,3} = text(235, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                if turnexist == 1;
                    txtTT = num2str(classifierName{1,colACT});
                    txtTI = num2str(classifierName{1,37});
                    txtTO = num2str(classifierName{1,38});
                    txt = [];
                    txt =  ['[' txtTI ' / ' txtTO ']'];
                    txtOBJSecondary{1,4} = text(315, posY-9, [txtTT ' s'], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    txtOBJSecondary{1,5} = text(290, posY+9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                else;
                    txt = [timeSecToStr(classifierName{1,colACT})];
                    txtOBJSecondary{1,4} = text(305, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                end;
                    
                if turnexist == 1;
                    valAct = str2num(classifierName{1,colACT});
                else;
                    valAct = classifierName{1,colACT};
                end;
                DiffCalsec = [dataToStr(abs(valAct - valRef),2) 's'];
                DiffCalper = [dataToStr((abs(valAct - valRef)./valRef).*100,2) '%'];
            
                if turnexist == 1;
                    txtOBJSecondary{1,6} = text(400, posY-9, DiffCalsec, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    txt = ['(' DiffCalper ')'];
                    txtOBJSecondary{1,7} = text(390, posY+9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    txtAppEff = classifierName{1,28};
                    index = strfind(txtAppEff, '[');
                    txtAppEff = txtAppEff(1:index(1)-3);
                    
                    txtBO = classifierName{1,29};
                    if Source == 1;
                        skillTable = classifierName{1,71};
                        startTimeEC = skillTable{28,3};
                        indexInterp = isempty(strfind(startTimeEC, '!'));
                    elseif Source == 2;
                        indexInterp = 1;
                    elseif Source == 3;
                        skillTable = classifierName{1,71};
                        startTimeEC = skillTable{28,3};
                        indexInterp = isempty(strfind(startTimeEC, '!'));
                    end;
                    index1 = strfind(txtBO, '(');
                    index2 = strfind(txtBO, 'k');
                    txtBODist = [txtBO 'm'];
    
                    kickCount = classifierName{1,64};
                    kicktxt = [];
                    if isempty(kickCount) == 0;
                        if nbTurns <= 7;
                            for kickEC = 2:length(kickCount);
                                if kickEC == 2;
                                    kicktxt = [num2str(kickCount(kickEC))];
                                else;
                                    kicktxt = [kicktxt ',' num2str(kickCount(kickEC))];
                                end;
                            end;
                        else;
                            kicktxt = num2str(roundn(mean(kickCount),0));
                        end;
                    else;
                        kicktxt = '0';
                    end;
                    if Source == 1 | Source == 3;
                        if isempty(index1) == 1 & isempty(index2) == 1;
                            if indexInterp == 1;
                                txt = ['(na) / ' txtBO 'm / (na)'];
                            else;
                                txt = ['(na) / (na) / (na)'];
                            end;
                        elseif isempty(index1) == 0 & isempty(index2) == 1;
                            if indexInterp == 1;
                                txt = ['(na) / ' txtBO(1:index1-2) 'm / ' txtBO(index1:end)];
                            else;
                                txt = ['(na) / (na) / ' txtBO(index1:end)];
                            end;
                        else;
                            if indexInterp == 1;
                                txt = ['(na) / ' txtBO(1:index1(1)-3) 'm / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                            else;
                                txt = ['(na) / (na) / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                            end;
                        end;
                    elseif Source == 2;
                        if isempty(index1) == 1 & isempty(index2) == 1;
                            txt = [txtAppEff '% / ' txtBO 'm / (na)'];
                        elseif isempty(index1) == 0 & isempty(index2) == 1;
                            txt = [txtAppEff '% / ' txtBO(1:index1-2) 'm / ' txtBO(index1:end)];
                        else;
                            txt = [txtAppEff '% / ' txtBO(1:index1(1)-3) 'm / ' txtBO(index1(1)+1:index2(1)-2) 'k'];
                        end;
                    end;
    
                    if nbTurns == 1;
                        posX = 480;
                    elseif nbTurns == 2;
                        posX = 480;
                    elseif nbTurns == 3;
                        posX = 475;
                    elseif nbTurns == 7;
                        posX = 460;
                    else;
                        posX = 490;
                    end;
                    txtOBJSecondary{1,8} = text(posX, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                else;
                    txtOBJSecondary{1,6} = text(400, posY-9, DiffCalsec, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    txt = ['(' DiffCalper ')'];
                    txtOBJSecondary{1,7} = text(390, posY+9, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    
                    txtDist = dataToStr(classifierName{1,44},2);
                    txtTime = dataToStr(classifierName{1,45},2);
                    txtEff = dataToStr(classifierName{1,46}.*100,1);
                    if Source == 1 | Source == 3;
                        txt = ['     na / na / na'];
                    elseif Source == 2;
                        txt = [txtDist 'm / ' txtTime 's / ' txtEff '%'];
                    end;
                    txtOBJSecondary{1,8} = text(470, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                    
                end;    
                    
                txt = classifierName{1,7};
                if length(txt) > 22;
                    txt = [txt(1:22) '...'];
                end;
                txtOBJSecondary{1,9} = text(650, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,8};
                txtOBJSecondary{1,10} = text(870, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,6};
                
                if isempty(strfind(classifierName{1,11}, '(L.1)')) == 0;
                    txt = [txt ' (R)'];
                end;
                txtOBJSecondary{1,11} = text(920, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
                txt = classifierName{1,14};
                txtOBJSecondary{1,12} = text(1000, posY, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontEC5, 'Color', [1 1 1]);
    
                posY = posY + 45.5;
    
                txtSecondaryRanking = txtOBJSecondary;
                
            else;
                set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
            end;
        end;
    
    
    else;
        set(allchild(MainRanking_benchmark), 'Visible', 'off');
        set(allchild(SecondaryRanking_benchmark), 'Visible', 'off');
        
        MDIR = getenv('USERPROFILE');
        if ismac == 1;
            errorwindow = errordlg('databaseCurrent empty for that selection', 'Error');
        elseif ispc == 1;
            errorwindow = errordlg('databaseCurrent empty for that selection', 'Error');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
    end;

    %---create logo_aargos
    logo_aargos_main = axes('parent', Fig, 'units', 'pixels', 'Position', [10, 610, 110, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
    axes(logo_aargos_main); imshow(handles.icones.logo_AARGOS);

    %---create SA logo
    logo_sa_main = axes('parent', Fig, 'units', 'pixels', 'Position', [965, 605, 120, 40], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
    axes(logo_sa_main); imshow(handles.icones.logo_SAL);

    %create title
    txtdistance = str2num(databaseCurrent{1,3});
    Course = str2num(databaseCurrent{1,10});
    Gender = databaseCurrent{1,5};
    if strcmpi(lower(Gender), 'male') == 1;
        txtgender = 'Men';
    elseif strcmpi(lower(Gender), 'female') == 1;
        txtgender = 'Women';
    else;
        txtgender = 'Error';
    end;
    txtstroke = databaseCurrent{1,4};

    if get(handles.typeRankingTop10_benchmark, 'Value') == 1;
        %TOp 10 Rankings
        ageList = get(handles.SelectAgeRanking_benchmark, 'String');
        countryList = get(handles.SelectCountryRanking_benchmark, 'String');
        seasonList = get(handles.SelectSeasonRanking_benchmark, 'String');
        datasetList = get(handles.SelectDatasetRanking_benchmark, 'String');
        txtdataset = datasetList{valDataset};
        txtage = ['Age: ' ageList{valAge}];

        if valMeet == 2;
            if valSeason == 1;
                txtseason = 'All-Time';
            else;
                txtseason = seasonList{valSeason};
                if strcmpi(txtseason, 'cycle');
                    txtseason = ['Season : ' txtseason];
                else;
                    txtseason = ['Cycle : ' txtseason];
                end;
            end;
        else;
            txtmeet = listMeet{valMeet};
            proceed = 1;
            iter = 1;
            yearEC = '';
            while proceed == 1;
                fyear = listMeet{valMeet-iter};
                if strfind(fyear, ' -- 20') == 1;
                    proceed = 0;
                    index = strfind(fyear, '2');
                    yearEC = num2str(fyear(index(1):index(1)+4));
                else;
                    iter = iter + 1;
                end;
            end;
            txtseason = [txtmeet '-' yearEC];
        end;
    
        if valCountry == 2;
            txtcountry = 'All countries';
        else;
            txtcountry = ['Country: ' countryList{valCountry} ' Only'];
        end;

        txtTitle = {['Ranking:   ' txtdataset]; ...
            [txtgender ':   ' txtdistance '-' txtstroke]; ...
            [txtage '   -   ' txtseason '   -   ' txtcountry]};

    else;
        txtTitle = ['Custom Rankings'];
    end;
    
    titleRankings = uicontrol('parent', Fig, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
        'position', [130, 585, 840, 70], 'HorizontalAlignment', 'center', 'String', txtTitle, ...
        'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', 12);
    set(titleRankings, 'fontunits', 'normalized');

else;
    return;
end;

set(Fig, 'units', 'normalized');

Fig.Visible = 'off';
Fig.InvertHardcopy = 'off';
if ispc == 1;
    if isfile([pathname '\' filename]) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' pathname '\' filename];
        [status, cmdout] = system(command);
    end;
    saveas(Fig, [pathname '\' filename]);
elseif ismac == 1;
    if isfile([pathname '/' filename]) == 1;
        command = ['rm -rf ' pathname '/' filename];
        [status, cmdout] = system(command);
    end;
    saveas(Fig, [pathname '/' filename]);
end;
clear_figures;
