function txtMainProfile_HIST = hist_plot_benchmark(DataToPlot, DataToTitle, nameBestAll, axeEC, axesLabel, fontsizelegend, fontsizeaxes, histim, histim2, graphType, histTitle, RaceOption, LegOption);


% if graphType == 1;
    xpos = 130;
    xwidth = 300;
    xcenter = 200;
    ypos = [210 247 284 321 358 395 432];
    ywidth = 10;
% else;
%     xpos = 130;
%     xwidth = 300;
    xwidth2 = 60;
%     xcenter = 200;
%     ypos = [210 247 284 321 358 395 432];
%     ywidth = 10;
% end;
colorGraph = [0 0 0];
colorZero = [0 0 0];
colorLegendTxt = [0 0 0];
colorAxesTxt = [0 0 0];


axes(axeEC);
hold on;

% DataToPlot

%calculate data
ratedata = [];
limaxes = [];

iter = 1;
for i = 1:3:length(DataToPlot)-2;
    dataset = DataToPlot(i:i+2);
    
    ratedataEC = dataset(1)./dataset(3);
    ratedata = [ratedata ratedataEC];
    
    if ratedataEC > 0.2;
        ratedataEC = 0.2;
    elseif ratedataEC < -0.2
        ratedataEC = -0.2;
    end;

    if iter == 1 | iter == 5 | iter == 6 | iter == 7;
        if ratedataEC >= 0;
            limaxesEC = (abs(ratedataEC).*5) .* xwidth;
        else;
            limaxesEC = (ratedataEC.*5) .* xwidth2;
        end;
    else;
        if ratedataEC <= 0;
            limaxesEC = (abs(ratedataEC).*5) .* xwidth;
        else;
            limaxesEC = (ratedataEC.*5) .* xwidth2;
        end;
    end;
    iter = iter + 1;
    limaxes = [limaxes limaxesEC];
end;

if strcmpi(RaceOption,'Element') == 1;
    graphTypeCorr = graphType;
else;
    if graphType ~= 4;
        graphTypeCorr = 2;
    else;
        graphTypeCorr = graphType;
    end;
end;

%overlay image
for i = 1:length(ypos);
    imcut = [];
    if graphTypeCorr == 1;
        if i == 6;
            if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
                imcut = [];
            else;
                imcut = histim(:,1:floor(abs(limaxes(i))),:);
            end;
        elseif i == 7;
            if strcmpi(LegOption, 'Butterfly Only');
                imcut = [];
            else;
                imcut = histim(:,1:floor(abs(limaxes(i))),:);
            end;
        else;
            imcut = histim(:,1:floor(abs(limaxes(i))),:);
        end;
    else;
        if i == 1 | i == 5;
            if ratedata(i) > 0;
                imcut = histim(:,1:floor(limaxes(i)),:);
            else;
                [li,co] = size(histim2(:,:,1));
                imcut = histim2(:, floor(co+limaxes(i)):co, :);
            end;
        elseif i == 6;
            if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
                imcut = [];
            else;
                if ratedata(i) > 0;
                    imcut = histim(:,1:floor(limaxes(i)),:);
                else;
                    [li,co] = size(histim2(:,:,1));
                    imcut = histim2(:, floor(co+limaxes(i)):co, :);
                end;
            end;
        elseif i == 7;
            if strcmpi(LegOption, 'Butterfly Only');
                imcut = [];
            else;
                if ratedata(i) > 0;
                    imcut = histim(:,1:floor(limaxes(i)),:);
                else;
                    [li,co] = size(histim2(:,:,1));
                    imcut = histim2(:, floor(co+limaxes(i)):co, :);
                end;
            end;
        else;
            if ratedata(i) < 0;
                imcut = histim(:,1:floor(abs(limaxes(i))),:);
            else;
                [li,co] = size(histim2(:,:,1));
                imcut = histim2(:, floor(co-limaxes(i)):co, :);
            end;
        end;
    end;
    
    PosNeg = [];
    if i == 1 | i == 5 | i == 6 | i == 7;
        txtdiff = timeSecToStr(roundn(DataToPlot((i*3)-2),-2));
        txtACT = timeSecToStr(roundn(DataToPlot((i*3-1)),-2));
        txtBest = timeSecToStr(roundn(DataToPlot((i*3)),-2));
        
        if DataToPlot((i*3)-2) < 0;
            if graphTypeCorr == 1;
                txtdiff = '';
                PosNeg(i) = 0;
            else;
                txtdiff = txtdiff;
                PosNeg(i) = -1;
            end;
        elseif DataToPlot((i*3)-2) > 0;
            txtdiff = ['+' txtdiff];
            PosNeg(i) = 1;
        else;
            txtdiff = ['='];
            PosNeg(i) = 1;
        end;
        
    elseif i == 2;
        txtdiff = dataToStr(DataToPlot((i*3)-2),2);
        txtACT = dataToStr(DataToPlot((i*3-1)),2);
        txtBest = dataToStr(DataToPlot((i*3)),2);
        
        if DataToPlot((i*3)-2) < 0;
            txtdiff = txtdiff;
            PosNeg(i) = 1;
        elseif DataToPlot((i*3)-2) > 0;
            if graphTypeCorr == 1;
                txtdiff = '';
                PosNeg(i) = 0;
            else;
                txtdiff = ['+' txtdiff];
                PosNeg(i) = -1;
            end;
        else;
            txtdiff = ['='];
            PosNeg(i) = 1;
        end;
        txtdiff = [txtdiff ' m/s'];
        txtACT = [txtACT ' m/s'];
        txtBest = [txtBest ' m/s'];
        
    elseif i == 3;
        txtdiff = dataToStr(DataToPlot((i*3)-2),2);
        txtACT = dataToStr(DataToPlot((i*3-1)),2);
        txtBest = dataToStr(DataToPlot((i*3)),2);
        
        if DataToPlot((i*3)-2) < 0;
            txtdiff = txtdiff;
            PosNeg(i) = 1;
        elseif DataToPlot((i*3)-2) > 0;
            if graphTypeCorr == 1;
                txtdiff = '';
                PosNeg(i) = 0;
            else;
                txtdiff = ['+' txtdiff];
                PosNeg(i) = -1;
            end;
        else;
            txtdiff = ['='];
            PosNeg(i) = 1;
        end;
        txtdiff = [txtdiff ' m2/s/str'];
        txtACT = [txtACT ' m2/s/str'];
        txtBest = [txtBest ' m2/s/str'];

    elseif i == 4;
        txtdiff = dataToStr(DataToPlot((i*3)-2).*100,2);
        
        valACT = abs(0.5-DataToPlot((i*3-1)));
        valBest = abs(0.5-DataToPlot((i*3)));
        
        if strcmpi(txtBest, '10000');
            txtBest = '100';
        end;
        if strcmpi(txtACT, '10000');
            txtACT = '100';
        end;
         
        if DataToPlot((i*3)-2) < 0;
            txtdiff = txtdiff;
            PosNeg(i) = 1;
        elseif DataToPlot((i*3)-2) > 0;
            if graphTypeCorr == 1;
                txtdiff = '';
                PosNeg(i) = 0;
            else;
                txtdiff = ['+' txtdiff];
                PosNeg(i) = -1;
            end;
        else;
            txtdiff = ['='];
            PosNeg(i) = 1;
        end;
        txtdiff = [txtdiff ' %'];
        txtACT = [txtACT ' %'];
        txtBest = [txtBest ' %'];
    end;
    
    if PosNeg(i) ~= 0;
        if graphTypeCorr == 1;
            txtMainProfile_HIST{1,i} = plot(axeEC, [xpos xpos+xwidth], [ypos(i)+5 ypos(i)+5], ':k', 'LineWidth', 0.5);
            txtMainProfile_HIST{2,i} = image(imcut, 'XData', [xpos xpos+limaxes(i)], 'YData', [ypos(i) ypos(i)+ywidth]);

        else;
            txtMainProfile_HIST{1,i} = plot(axeEC, [xpos-xwidth2 xpos+xwidth], [ypos(i)+5 ypos(i)+5], ':k', 'LineWidth', 0.5);
            if i == 1 | i == 5 | i == 6 | i == 7;
                 if ratedata(i) > 0;
                    txtMainProfile_HIST{2,i} = image(imcut, 'XData', [xpos+2 xpos+limaxes(i)+2], 'YData', [ypos(i) ypos(i)+ywidth]);
                else;
                    txtMainProfile_HIST{2,i} = image(imcut, 'XData', [xpos+limaxes(i)-2 xpos-2], 'YData', [ypos(i) ypos(i)+ywidth]);
                end;
            else;
                if ratedata(i) < 0;
                    txtMainProfile_HIST{2,i} = image(imcut, 'XData', [xpos+2 xpos+abs(limaxes(i))+2], 'YData', [ypos(i) ypos(i)+ywidth]);
                else;
                    txtMainProfile_HIST{2,i} = image(imcut, 'XData', [xpos-limaxes(i)-2 xpos-2], 'YData', [ypos(i) ypos(i)+ywidth]);
                end;
            end;
        end;
    end;
    
    if i == 1;
        corrPos = 39;
        if graphType == 1;
            txt = 'Best';
        elseif graphType == 2;
            txt = 'Top 3';
        elseif graphType == 3;
            txt = 'Top 8';
        elseif graphType == 4;
            txt = 'Select';
        end;
        txtMainProfile_HIST{3,1} = text(xpos-corrPos, ypos(1)-20, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                    'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                    'Interpreter', 'none', 'horizontalalignment', 'center');
                
%         txtMainProfile_HIST{3,2} = text(xpos-corrPos, ypos(1)-15, RaceOption, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
%                     'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
%                     'Interpreter', 'none', 'horizontalalignment', 'center');
        txtMainProfile_HIST{3,2} = [];
        
                
    end;
    txtMainProfile_HIST{3,i+2} = text(xpos+160, ypos(i)-10, axesLabel{i}, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
        'Interpreter', 'none', 'horizontalalignment', 'center');

    if i == 6;
        if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
            txtMainProfile_HIST{4,i} = text(xpos+5, ypos(i)+5, 'No Start', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                'Interpreter', 'none', 'horizontalalignment', 'left');
        else;
            if PosNeg(i) == 1;
                txtMainProfile_HIST{4,i} = text(floor(limaxes(i))+5+xpos, ypos(i)+5, txtdiff, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                            'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                            'Interpreter', 'none', 'horizontalalignment', 'left');
            elseif PosNeg(i) == -1;
                txtMainProfile_HIST{4,i} = text(floor(xpos-limaxes(i))-5, ypos(i)+5, txtdiff, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                            'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                            'Interpreter', 'none', 'horizontalalignment', 'right');

                getExtent = get(txtMainProfile_HIST{4,i}, 'extent');
                if getExtent(1) <= 45;
                    AddX = 45 - getExtent(1);
                    getPos = get(txtMainProfile_HIST{4,i}, 'position');
                    getPos(1) = getPos(1) + AddX + 1;
                    txtMainProfile_HIST{4,i}.Position = getPos;
                end;
            end;
        end;

    elseif i == 7;
        if strcmpi(LegOption, 'Butterfly Only');
            txtMainProfile_HIST{4,i} = text(xpos+5, ypos(i)+5, 'No Turn', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                'Interpreter', 'none', 'horizontalalignment', 'left');
        else;
            if PosNeg(i) == 1;
                txtMainProfile_HIST{4,i} = text(floor(limaxes(i))+5+xpos, ypos(i)+5, txtdiff, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                            'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                            'Interpreter', 'none', 'horizontalalignment', 'left');
            elseif PosNeg(i) == -1;
                txtMainProfile_HIST{4,i} = text(floor(xpos-limaxes(i))-5, ypos(i)+5, txtdiff, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                            'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                            'Interpreter', 'none', 'horizontalalignment', 'right');

                getExtent = get(txtMainProfile_HIST{4,i}, 'extent');
                if getExtent(1) <= 45;
                    AddX = 45 - getExtent(1);
                    getPos = get(txtMainProfile_HIST{4,i}, 'position');
                    getPos(1) = getPos(1) + AddX + 1;
                    txtMainProfile_HIST{4,i}.Position = getPos;
                end;
            end;
        end;
        
    else;
        if PosNeg(i) == 1;
            txtMainProfile_HIST{4,i} = text(floor(limaxes(i))+5+xpos, ypos(i)+5, txtdiff, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'left');
        elseif PosNeg(i) == -1;
            txtMainProfile_HIST{4,i} = text(floor(xpos-limaxes(i))-5, ypos(i)+5, txtdiff, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'right');

            getExtent = get(txtMainProfile_HIST{4,i}, 'extent');
            if getExtent(1) <= 45;
                AddX = 45 - getExtent(1);
                getPos = get(txtMainProfile_HIST{4,i}, 'position');
                getPos(1) = getPos(1) + AddX + 1;
                txtMainProfile_HIST{4,i}.Position = getPos;
            end;
        end;
    end;
    
    
    if graphType == 1;
        nameEC = nameBestAll{i,1};
        index = strfind(nameEC, ' ');
        if isempty(index) == 0;
            nameEC = [nameEC(1) '.' nameEC(index(1)+1:end)];
        end;
        txtMainProfile_HIST{5,i} = text(floor(xpos-5), ypos(i)+5, nameEC, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                    'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
                    'Interpreter', 'none', 'horizontalalignment', 'right'); 
    end;
end;

txtMainProfile_HIST{6,1} = plot(axeEC, [xpos xpos], [ypos(1)-10 ypos(end)+20], 'k', 'LineWidth', 2);
iter = 1;
for j = 1:length(ypos);

    if j == 1 | j == 5 | j == 6 | j == 7;
        if ratedata(j) > 0;
            tickspacing = 0;
            nbticks = 10;
        else;
            nbticks = 10; %3
            tickspacing = -3.*(xwidth/nbticks); %-3.*(xwidth2/nbticks);
        end;
    else;
        if ratedata(j) < 0;
            tickspacing = 0;
            nbticks = 10;
        else;
            nbticks = 10; %3
            tickspacing = -(xwidth/nbticks); %-3.*(xwidth2/nbticks)
        end;
    end;
    for i = 1:nbticks;
        if j == 1 | j == 5;
            if ratedata(j) > 0;
                if tickspacing <= limaxes(j);
                    txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                    iter = iter + 1;
                end;
                tickspacing = tickspacing+(xwidth/nbticks);
            else;
                if tickspacing >= limaxes(j);
                    txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                    iter = iter + 1;
                end;
                tickspacing = tickspacing+(xwidth2/nbticks);
            end;
        elseif j == 6;
            if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
                txtMainProfile_HIST{7,iter} = [];
                tickspacing = [];
            else;
                if ratedata(j) > 0;
                    if tickspacing <= limaxes(j);
                        txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                        iter = iter + 1;
                    end;
                    tickspacing = tickspacing+(xwidth/nbticks);
                else;
                    if tickspacing >= limaxes(j);
                        txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                        iter = iter + 1;
                    end;
                    tickspacing = tickspacing+(xwidth2/nbticks);
                end;
            end;
        elseif j == 7;
            if strcmpi(LegOption, 'Butterfly Only');
                
            else;
                if ratedata(j) > 0;
                    if tickspacing <= limaxes(j);
                        txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                        iter = iter + 1;
                    end;
                    tickspacing = tickspacing+(xwidth/nbticks);
                else;
                    if tickspacing >= limaxes(j);
                        txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                        iter = iter + 1;
                    end;
                    tickspacing = tickspacing+(xwidth2/nbticks);
                end;
            end;
        else;
            if ratedata(j) < 0;
                if tickspacing <= limaxes(j); 
                    txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                    iter = iter + 1;
                end;
                tickspacing = tickspacing+(xwidth/nbticks);
            else;
                if tickspacing >= -limaxes(j); %tickspacing >= limaxes(j)
                    txtMainProfile_HIST{7,iter} = plot(axeEC, [tickspacing+xpos tickspacing+xpos], [ypos(j)-4 ypos(j)+16], ':k', 'LineWidth', 0.5);
                    iter = iter + 1;
                end;
                tickspacing = tickspacing-(xwidth/nbticks); %tickspacing+(xwidth2/nbticks)
            end;
        end;
    end;
    
    if j == length(ypos);
        %add the legend
        if graphTypeCorr == 1;
            nbticks = 10;
            tickspacing = (xwidth/nbticks);
            for i = 1:nbticks;
                %10 ticks and no 0
                if i == nbticks;
                    txt = [num2str(i*2) '% (& more)'];
                    txtMainProfile_HIST{8,i} = text(tickspacing+xpos-12, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'left');
                else;
                    txt = [num2str(i*2) '%'];
                    txtMainProfile_HIST{8,i} = text(tickspacing+xpos, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'center');
                end;
                tickspacing = tickspacing+(xwidth/nbticks);
            end;
        else;
            %13 ticks including 0
            
            %negative part
            nbticks = 2;
            tickspacing = -2.*(xwidth2/nbticks);
            for i = 1:nbticks;
                if i == 1;
                    txt = [num2str((i*2)-6) '%'];
                    txtMainProfile_HIST{8,i} = text(xpos+tickspacing, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'center');
                elseif i == nbticks;
                    txt = [num2str((i*2)-6) '%'];
                    txtMainProfile_HIST{8,i} = text(xpos+tickspacing, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'center');
                else;
                    txt = [num2str((i*2)-6) '%'];
                    txtMainProfile_HIST{8,i} = text(xpos+tickspacing, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'center');
                end;
                tickspacing = tickspacing+(xwidth2/nbticks);
            end;

            iter = length(txtMainProfile_HIST(8,:));
            nbticks = 10;
            tickspacing = (xwidth/nbticks);
            for i = 1:nbticks;
                %10 ticks and no 0
                if i == nbticks;
                    txt = [num2str(i*2) '% (& more)'];
                    txtMainProfile_HIST{8,iter+i} = text(tickspacing+xpos-12, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'left');
                else;
                    txt = [num2str(i*2) '%'];
                    txtMainProfile_HIST{8,iter+i} = text(tickspacing+xpos, ypos(j)+30, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                        'Interpreter', 'none', 'horizontalalignment', 'center');
                end;
                tickspacing = tickspacing+(xwidth/nbticks);
            end;
            
            txt = [num2str(i*2) '% (& more)'];
            txtMainProfile_HIST{8,iter+i+1} = text(xpos, ypos(j)+30, '0%', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
                'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizelegend, 'Color', [0 0 0], ...
                'Interpreter', 'none', 'horizontalalignment', 'center');
            
        end;
    end;
end;

%plot Triangle buttons
x = [xpos-10 xpos-5 xpos-15];
y = [ypos(1)-15.5 ypos(1)-25.5 ypos(1)-25.5];
txtMainProfile_HIST{10,1} = patch(x, y, 'Black');

% x = [xpos-70 xpos-65 xpos-75];
% y = [ypos(1)-10 ypos(1)-20 ypos(1)-20];
% txtMainProfile_HIST{10,2} = patch(x, y, 'Black');
txtMainProfile_HIST{10,2} = [];


txtMainProfile_HIST{11,1} = text(xpos-75, ypos(1)-35, histTitle, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
    'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizeaxes, 'Color', [0 0 0], ...
    'Interpreter', 'none', 'horizontalalignment', 'left');

