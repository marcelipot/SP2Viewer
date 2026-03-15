if returnval == 1;
    return;
end;
try;
    [li, co] = size(handles.txtMainProfile_ID);
    txtPBSB = handles.txtMainProfile_ID{1,7}.String;
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.txtMainProfile_ID{i,j}) == 0;
                delete(handles.txtMainProfile_ID{i,j});
            end;
        end;
    end;
    handles.txtMainProfile_ID = {};
end;

try;
    [li, co] = size(handles.txtMainProfile_SUMMARY);
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.txtMainProfile_SUMMARY{i,j}) == 0;
                delete(handles.txtMainProfile_SUMMARY{i,j});
            end;
        end;
    end;
    handles.txtMainProfile_SUMMARY = {};
end;

try;
    [li, co] = size(handles.txtMainProfile_SPIDER);
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.txtMainProfile_SPIDER{i,j}) == 0;
                delete(handles.txtMainProfile_SPIDER{i,j});
            end;
        end;
    end;
    handles.txtMainProfile_SPIDER = {};
end;

try;
    [li, co] = size(handles.txtMainProfile_HIST);
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.txtMainProfile_HIST{i,j}) == 0;
                delete(handles.txtMainProfile_HIST{i,j});
            end;
        end;
    end;
    handles.txtMainProfile_HIST = {};
end;

try;
    [li, co] = size(handles.txtOBJ_TABLE);
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.txtOBJ_TABLE{i,j}) == 0;
                delete(handles.txtOBJ_TABLE{i,j});
            end;
        end;
    end;
    handles.txtOBJ_TABLE = {};
end;

try;
    [li, co] = size(handles.txtOBJ_GROUP);
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.txtOBJ_GROUP{i,j}) == 0;
                delete(handles.txtOBJ_GROUP{i,j});
            end;
        end;
    end;
    handles.txtOBJ_GROUP = {};
end;

try;
    [li, co] = size(handles.pushButtonsProfile_HIST);
    for i = 1:li;
        for j = 1:co;
            if isempty(handles.pushButtonsProfile_HIST{i,j}) == 0;
                delete(handles.pushButtonsProfile_HIST{i,j});
            end;
        end;
    end;
    handles.pushButtonsProfile_HIST = {};
end;


%---------------------------calculate benchmarks---------------------------
if strcmpi(SearchPool, '50') == 1;
    if strcmpi(SearchDistance, '50') == 1;
        NbLap = 1;
    elseif strcmpi(SearchDistance, '100') == 1;
        NbLap = 2;
    elseif strcmpi(SearchDistance, '150') == 1;
        NbLap = 3;
    elseif strcmpi(SearchDistance, '200') == 1;
        NbLap = 4;
    elseif strcmpi(SearchDistance, '400') == 1;
        NbLap = 8;
    elseif strcmpi(SearchDistance, '800') == 1;
        NbLap = 16;
    elseif strcmpi(SearchDistance, '1500') == 1;
        NbLap = 30;
    end;
else;
    if strcmpi(SearchDistance, '50') == 1;
        NbLap = 2;
    elseif strcmpi(SearchDistance, '100') == 1;
        NbLap = 4;
    elseif strcmpi(SearchDistance, '150') == 1;
        NbLap = 6;
    elseif strcmpi(SearchDistance, '200') == 1;
        NbLap = 8;
    elseif strcmpi(SearchDistance, '400') == 1;
        NbLap = 16;
    elseif strcmpi(SearchDistance, '800') == 1;
        NbLap = 32;
    elseif strcmpi(SearchDistance, '1500') == 1;
        NbLap = 60;
    end;
end;
databaseGroupSave = databaseGroup;

centileRaceTime;
centileSkillTime;
centileStartTime;
centileTurnFinishTime;
centileSwimSpeed;
centileStrokeIndex;
centileSpeedDecay;

%--------------------------------------------------------------------------




%---------------------------Display Summary txt----------------------------
% databaseGroup = databaseGroupSave;
set(allchild(handles.MainProfile_benchmark), 'Visible', 'on');
axes(handles.MainProfile_benchmark);
hold on;
txt = databaseCurrent{1,2};
if length(txt) > 20;
    index = strfind(txt, ' ');
    txt = [txt(1) '. ' txt(index(1)+1:end)];
end;
txtOBJ_ID{1,1} = text(60, 35, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.038, 'Color', [0 0 0], 'Interpreter', 'none');

currentDate = datestr(date, 'yyyy-mm-dd');
index = strfind(currentDate, '-');
AgeToday(1) = datetime(str2num(currentDate(1:index(1)-1)), str2num(currentDate(index(1)+1:index(2)-1)), str2num(currentDate(index(2)+1:end)));
DOB = databaseCurrent{1,13};
index = strfind(DOB, '/');
AgeToday(2) = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
D = split(caldiff(AgeToday, {'years','months','days'}), {'years','months','days'});
txt = [databaseCurrent{1,13} '  (' num2str(abs(D(1))) 'y)'];
txtOBJ_ID{1,2} = text(70, 60, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.022, 'Color', [0 0 0], 'Interpreter', 'none');


txt = databaseCurrent{1,14};
txtOBJ_ID{1,3} = text(340, 35, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.038, 'Color', [0 0 0], 'Interpreter', 'none');

DOB = databaseCurrent{1,13};
index = strfind(DOB, '/');
AgeGroupMeet(1) = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
MeetID = databaseCurrent{1,36};
eval(['MeetBegDate = handles.AgeGroup.' MeetID ';']);
index = strfind(MeetBegDate, '-');
AgeGroupMeet(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), str2num(MeetBegDate(index(1)+1:index(2)-1)), str2num(MeetBegDate(index(2)+1:end)));
D = caldiff(AgeGroupMeet, {'years','months','days'});
[AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});
AG = 'Age :  Open';

% if get(handles.salRulesProfile_benchmark, 'Value') == 1;
    if AgeYear(1) >= 19
        AG = 'Age :  Open';
    elseif AgeYear(1) <= 13;
        AG = ['Age :  ' num2str(AgeYear(1)) 'y & under'];
    else;
        AG = ['Age :  ' num2str(AgeYear(1)) 'y'];
    end;

    
    
% elseif get(handles.finaRulesProfile_benchmark, 'Value') == 1;;
%     index = strfind(MeetBegDate, '-');
%     dateDiff(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), 12, 31);
%     D = caldiff(dateDiff, {'years','months','days'});
%     AgeYear = [];
%     [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});
%     AG = AgeYear(1);
%     if AgeYear(1) > 19
%         AG = 'Age :  Open';
%     elseif AgeYear(1) <= 13;
%         AG = ['No FINA age group below 13y'];
%     else;
%         AG = ['Age :  ' num2str(AgeYear(1)) 'y'];
%     end;
% 
% end;
txtOBJ_ID{1,4} = text(340, 60, AG, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.022, 'Color', [0 0 0], 'Interpreter', 'none');

txt1 = databaseCurrent{1,3};
txt2 = databaseCurrent{1,4};
txt3 = databaseCurrent{1,6};

if strcmpi(databaseCurrent{1,11}, 'Flat (L.1)');
    txt4 = ' (R.L1)';
else;
    txt4 = '';
end;

txt = [txt1 'm  ' txt2 '   -   ' txt3 txt4];
txtOBJ_ID{1,5} = text(70, 90, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');

txt1 = databaseCurrent{1,7};
txt2 = databaseCurrent{1,8};
txt = [txt1 '  -  ' txt2];
txtOBJ_ID{1,6} = text(70, 110, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');

if length(SeasonEC) == 9;
    if updateSBchoice == 1;
        %Single year selected
        txt1 = ['PB :  ' TimePB '  (' YearPB ')'];
        if isempty(TimeSB) == 1;
            txt2 = ['No SB for '  num2str(seasonLow(1:4)) '-' num2str(seasonHigh(1:4))];
        else;
            txt2 = ['SB (' num2str(seasonLow(1:4)) '-' num2str(seasonHigh(1:4)) ') : ' TimeSB];
        end;
        txt = [txt1 '  -  ' txt2];
        txtOBJ_ID{1,7} = text(70, 130, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');
        posExtent = get(txtOBJ_ID{1,7}, 'Extent');
        posExtentX = posExtent(1)+posExtent(3);
        posExtentY = posExtent(2);
        %plot Triangle buttons
        x = [posExtentX+12 posExtentX+7 posExtentX+17];
        y = [posExtentY-4 posExtentY-14 posExtentY-14];
        txtOBJ_ID{1,8} = patch(x, y, 'Black');
    else;
        txt = txtPBSB;
        txtOBJ_ID{1,7} = text(70, 130, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');
        posExtent = get(txtOBJ_ID{1,7}, 'Extent');
        posExtentX = posExtent(1)+posExtent(3);
        posExtentY = posExtent(2);
        %plot Triangle buttons
        x = [posExtentX+12 posExtentX+7 posExtentX+17];
        y = [posExtentY-4 posExtentY-14 posExtentY-14];
        txtOBJ_ID{1,8} = patch(x, y, 'Black');
    end;
else;
    if updateSBchoice == 1;
        index = strfind(lower(SeasonEC), lower('Any'));
        if isempty(index) == 1;
            %Cycle selected
            txt1 = ['PB :  ' TimePB '  (' YearPB ')'];
            txt2 = ['CB (' num2str(seasonLow(1:4)) '-' num2str(seasonHigh(1:4)) ') : ' TimeSB];
            txt = [txt1 '  -  ' txt2];
            txtOBJ_ID{1,7} = text(70, 130, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');
            %plot Triangle buttons (duny)
            posExtent = get(txtOBJ_ID{1,7}, 'Extent');
            posExtentX = posExtent(1)+posExtent(3);
            posExtentY = posExtent(2);
            x = [posExtentX+12 posExtentX+7 posExtentX+17];
            y = [posExtentY-4 posExtentY-14 posExtentY-14];
            txtOBJ_ID{1,8} = patch(x, y, 'Black');

        else;
            %All
            txt1 = ['PB :  ' TimePB '  (' YearPB ')'];
            if isempty(TimeSB) == 1;
                txt2 = ['No SB for '  num2str(seasonLow(1:4)) '-' num2str(seasonHigh(1:4))];
            else;
                txt2 = ['SB (' num2str(seasonLow(1:4)) '-' num2str(seasonHigh(1:4)) ') : ' TimeSB];
            end;
            txt = [txt1 '  -  ' txt2];
            txtOBJ_ID{1,7} = text(70, 130, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');
            posExtent = get(txtOBJ_ID{1,7}, 'Extent');
            posExtentX = posExtent(1)+posExtent(3);
            posExtentY = posExtent(2);
            %plot Triangle buttons
            x = [posExtentX+12 posExtentX+7 posExtentX+17];
            y = [posExtentY-4 posExtentY-14 posExtentY-14];
            txtOBJ_ID{1,8} = patch(x, y, 'Black');
        end;
    else;
        txt = txtPBSB;
        txtOBJ_ID{1,7} = text(70, 130, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], 'Interpreter', 'none');
        posExtent = get(txtOBJ_ID{1,7}, 'Extent');
        posExtentX = posExtent(1)+posExtent(3);
        posExtentY = posExtent(2);
        %plot Triangle buttons
        x = [posExtentX+12 posExtentX+7 posExtentX+17];
        y = [posExtentY-4 posExtentY-14 posExtentY-14];
        txtOBJ_ID{1,8} = patch(x, y, 'Black');
    end;
end;
% ###############################
txtOBJ_ID{1,9} = text(70, 150, RaceOption, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
    'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], ...
    'Interpreter', 'none');
posExtent = get(txtOBJ_ID{1,9}, 'Extent');
posExtentX = posExtent(1)+posExtent(3);
posExtentY = posExtent(2);
x = [posExtentX+12 posExtentX+7 posExtentX+17];
y = [posExtentY-4 posExtentY-14 posExtentY-14];
txtOBJ_ID{1,10} = patch(x, y, 'Black');

if isempty(LegOption) == 0;
    txtOBJ_ID{1,11} = text(x(3) + 20, 150, LegOption, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], ...
        'Interpreter', 'none');
    posExtent = get(txtOBJ_ID{1,11}, 'Extent');
    posExtentX = posExtent(1)+posExtent(3);
    posExtentY = posExtent(2);
    x = [posExtentX+12 posExtentX+7 posExtentX+17];
    y = [posExtentY-4 posExtentY-14 posExtentY-14];
    txtOBJ_ID{1,12} = patch(x, y, 'Black');
else;
    txtOBJ_ID{1,11} = text(x(3) + 20, 150, '', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
        'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.024, 'Color', [0 0 0], ...
        'Interpreter', 'none');
    txtOBJ_ID{1,12} = [];
end;

handles.txtMainProfile_ID = txtOBJ_ID;

if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
    txt = ['Race Time'];
else;
    txt = ['Leg Time'];
end;
txtOBJ_SUMMARY{1,1} = text(90, 503, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.038, 'Color', [1 1 1], 'Interpreter', 'none');
txt = ['Swim Speed'];
txtOBJ_SUMMARY{1,2} = text(276, 503, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.038, 'Color', [1 1 1], 'Interpreter', 'none');
txt = ['Stroke Index'];
txtOBJ_SUMMARY{1,3} = text(468, 503, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.038, 'Color', [1 1 1], 'Interpreter', 'none');
txt = ['Skill Time'];
txtOBJ_SUMMARY{1,4} = text(675, 503, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.040, 'Color', [1 1 1], 'Interpreter', 'none');

txt = [num2str(posRaceTime)];
if length(txt) > 2;
    txtOBJ_SUMMARY{2,1} = text(85, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,1} = text(148, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,1} = text(165, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
elseif length(txt) == 1;
    txtOBJ_SUMMARY{2,1} = text(115, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    if posRaceTime == 1;
        txt = 'st';
    elseif posRaceTime == 2;
        txt = 'nd';
    elseif posRaceTime == 3;
        txt = 'rd';
    else;
        txt = 'th';
    end;
    txtOBJ_SUMMARY{3,1} = text(137, 540, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,1} = text(155, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
else;
    txtOBJ_SUMMARY{2,1} = text(100, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,1} = text(142, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,1} = text(160, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
end;
% databaseCurrent{1,14}
txt = ['(' timeSecToStr(diff2bestRaceTime(2)) ')'];
txtOBJ_SUMMARY{5,1} = text(110, 585, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.0326, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');

if strcmpi(RaceOption,'Element') == 1;
    posSwimSpeedcurrent = posSwimSpeedelement;
else;
    posSwimSpeedcurrent = posSwimSpeedrace;
end;
txt = [num2str(posSwimSpeedcurrent)];
if length(txt) > 2;
    txtOBJ_SUMMARY{2,2} = text(281, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,2} = text(343, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,2} = text(361, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
elseif length(txt) == 1;
    txtOBJ_SUMMARY{2,2} = text(301, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    if posSwimSpeedcurrent == 1;
        txt = 'st';
    elseif posSwimSpeedcurrent == 2;
        txt = 'nd';
    elseif posSwimSpeedcurrent == 3;
        txt = 'rd';
    else;
        txt = 'th';
    end;
    txtOBJ_SUMMARY{3,2} = text(323, 540, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,2} = text(341, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
else;
    txtOBJ_SUMMARY{2,2} = text(291, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,2} = text(333, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,2} = text(353, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
end;

if strcmpi(RaceOption,'Element') == 1;
    txt = ['(' dataToStr(diff2bestSwimSpeedelement(2),2) ' m/s)'];
else;
    txt = ['(' dataToStr(diff2bestSwimSpeedrace(2),2) ' m/s)'];
end;
txtOBJ_SUMMARY{5,2} = text(299, 585, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.0326, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');

if strcmpi(RaceOption,'Element') == 1;
    posStrokeEffcurrent = posStrokeEffelement;
else;
    posStrokeEffcurrent = posStrokeEffrace;
end;
txt = [num2str(posStrokeEffcurrent)];
if length(txt) > 2;
    txtOBJ_SUMMARY{2,3} = text(473, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,3} = text(535, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,3} = text(553, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
elseif length(txt) == 1;
    txtOBJ_SUMMARY{2,3} = text(498, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    if posStrokeEffcurrent == 1;
        txt = 'st';
    elseif posStrokeEffcurrent == 2;
        txt = 'nd';
    elseif posStrokeEffcurrent == 3;
        txt = 'rd';
    else;
        txt = 'th';
    end;
    txtOBJ_SUMMARY{3,3} = text(520, 540, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,3} = text(538, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
else;
    txtOBJ_SUMMARY{2,3} = text(483, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,3} = text(527, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,3} = text(543, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
end;
if strcmpi(RaceOption,'Element') == 1;
    txt = ['(' dataToStr(diff2bestStrokeEffelement(2),2) ' m^2/s/str)'];
else;
    txt = ['(' dataToStr(diff2bestStrokeEffrace(2),2) ' m^2/s/str)'];
end;
% txt = ['(' databaseCurrent{1,31} ' m^2/s/str)'];
txtOBJ_SUMMARY{5,3} = text(476, 585, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.0326, 'Color', [0.7 0.7 0.7]);

if strcmpi(RaceOption,'Element') == 1;
    posSkillTimecurrent = posSkillTimeelement;
else;
    posSkillTimecurrent = posSkillTimerace;
end;
txt = [num2str(posSkillTimecurrent)];
if length(txt) > 2;
    txtOBJ_SUMMARY{2,4} = text(670, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,4} = text(735, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,4} = text(755, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
elseif length(txt) == 1;
    txtOBJ_SUMMARY{2,4} = text(695, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    if posSkillTimecurrent == 1;
        txt = 'st';
    elseif posSkillTimecurrent == 2;
        txt = 'nd';
    elseif posSkillTimecurrent == 3;
        txt = 'rd';
    else;
        txt = 'th';
    end;
    txtOBJ_SUMMARY{3,4} = text(718, 540, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,4} = text(735, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
else;
    txtOBJ_SUMMARY{2,4} = text(683, 550, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.070, 'Color', [1 1 1], 'Interpreter', 'none');
    txtOBJ_SUMMARY{3,4} = text(726, 540, 'th', 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.030, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
    txt = ['/' num2str(length(databaseGroup(:,1)))];
    txtOBJ_SUMMARY{4,4} = text(743, 555, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');
end;

if strcmpi(RaceOption,'Element') == 1;
    txt = ['(' timeSecToStr(roundn(diff2bestSkillTimeelement(2),-2)) ')'];
else;
    txt = ['(' timeSecToStr(roundn(diff2bestSkillTimerace(2),-2)) ')'];
end;
% txt = ['(' databaseCurrent{1,15} ')'];
txtOBJ_SUMMARY{5,4} = text(697, 585, txt, 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [0.7 0.7 0.7], 'Interpreter', 'none');


handles.txtMainProfile_SUMMARY = txtOBJ_SUMMARY;
%--------------------------------------------------------------------------



%------------------------------Spider Graph--------------------------------
if turnexist == 1;
    if strcmpi(RaceOption,'Element') == 1;
        DataToPlot = [10-(rankRaceTime./10) 10-(rankSwimSpeedelement./10) 10-(rankStrokeEffelement./10) 10-(rankSpeedDecayelement./10) ...
            10-(rankSkillTimeelement./10) 10-(rankStartTimeelement./10) 10-(rankTurnTimeelement./10)];
        DataToTitle = [100-rankRaceTime 100-rankSwimSpeedelement 100-rankStrokeEffelement 100-rankSpeedDecayelement ...
            100-rankSkillTimeelement 100-rankStartTimeelement 100-rankTurnTimeelement];
    else;
        DataToPlot = [10-(rankRaceTime./10) 10-(rankSwimSpeedrace./10) 10-(rankStrokeEffrace./10) 10-(rankSpeedDecayrace./10) ...
            10-(rankSkillTimerace./10) 10-(rankStartTimerace./10) 10-(rankTurnTimerace./10)];
        DataToTitle = [100-rankRaceTime 100-rankSwimSpeedrace 100-rankStrokeEffrace 100-rankSpeedDecayrace ...
            100-rankSkillTimerace 100-rankStartTimerace 100-rankTurnTimerace];
    end;
    
    LimSpider = [0 0 0 0 0 0 0; 10 10 10 10 10 10 10];
    axesLabel = {'Race Time'; 'Swim Speed'; 'Stroke Index'; 'Speed Decay'; ...
        'Skill Time'; 'Start Time'; 'Turn Time'};
else;
    if strcmpi(RaceOption,'Element') == 1;
        DataToPlot = [10-(rankRaceTime./10) 10-(rankSwimSpeedelement./10) 10-(rankStrokeEffelement./10) 10-(rankSpeedDecayelement./10) ...
            10-(rankSkillTimeelement./10) 10-(rankStartTimeelement./10) 10-(rankFinishTimeelement./10)];
        DataToTitle = [100-rankRaceTime 100-rankSwimSpeedelement 100-rankStrokeEffelement 100-rankSpeedDecayelement ...
            100-rankSkillTimeelement 100-rankStartTimeelement 100-rankFinishTimeelement];
    else;
        DataToPlot = [10-(rankRaceTime./10) 10-(rankSwimSpeedrace./10) 10-(rankStrokeEffrace./10) 10-(rankSpeedDecayrace./10) ...
            10-(rankSkillTimerace./10) 10-(rankStartTimerace./10) 10-(rankFinishTimerace./10)];
        DataToTitle = [100-rankRaceTime 100-rankSwimSpeedrace 100-rankStrokeEffrace 100-rankSpeedDecayrace ...
            100-rankSkillTimerace 100-rankStartTimerace 100-rankFinishTimerace];
    end;
    LimSpider = [0 0 0 0 0 0 0; 10 10 10 10 10 10 10];
    axesLabel = {'Race Time'; 'Swim Speed'; 'Stroke Index'; 'Speed Decay'; ...
        'Skill Time'; 'Start Time'; 'Finish Time'};
end;
axesinterval = 5;    
handles.txtMainProfile_SPIDER = spider_plot_benchmark(DataToPlot, 'valuetitles', DataToTitle, 'fullscreenPos', 0, 'Races', 1, ...
    'axetoplot', handles.MainProfile_benchmark, 'AxesLimits', LimSpider, 'AxesLabels', axesLabel, ...
    'AxesInterval', axesinterval, 'FillOption', 'on', 'FillTransparency', 0.5, ...
    'color', [0 0 1], 'AxesFontSize', 0.020, 'markersize', 6, ...
    'LabelFontSize', 0.020, 'graphOption', LegOption);
%--------------------------------------------------------------------------



%--------------------------------Hist Graph--------------------------------
if turnexist == 1;
    nameBestAll{1,1} = nameBestRaceTime;
    if strcmpi(RaceOption,'Element') == 1;
        nameBestAll{2,1} = nameBestSwimSpeed;
        nameBestAll{3,1} = nameBestStrokeEff;
        nameBestAll{4,1} = nameBestSpeedDecay;
        nameBestAll{5,1} = nameBestSkillTime;
        nameBestAll{6,1} = nameBestStartTime;
        nameBestAll{7,1} = nameBestTurnTime;
    
        DataToPlot = [diff2bestRaceTime diff2bestSwimSpeedelement diff2bestStrokeEffelement diff2bestSpeedDecayelement ...
            diff2bestSkillTimeelement diff2bestStartTimeelement diff2bestTurnTimeelement];
    
    else;
        nameBestAll{2,1} = '';
        nameBestAll{3,1} = '';
        nameBestAll{4,1} = '';
        nameBestAll{5,1} = '';
        nameBestAll{6,1} = '';
        nameBestAll{7,1} = '';
        
        DataToPlot = [diff2bestRaceTime diff2bestSwimSpeedrace diff2bestStrokeEffrace diff2bestSpeedDecayrace ...
            diff2bestSkillTimerace diff2bestStartTimerace diff2bestTurnTimerace];
    end;
    DataToTitle = [nameBestRaceTime nameBestSwimSpeed nameBestStrokeEff nameBestSpeedDecay ...
            nameBestSkillTime nameBestStartTime nameBestTurnTime];
    axesLabel = {'Race Time'; 'Swim Speed'; 'Stroke Index'; 'Speed Decay'; ...
            'Skill Time'; 'Start Time'; 'Turn Time'};
else;
    nameBestAll{1,1} = nameBestRaceTime;
    if strcmpi(RaceOption,'Element') == 1;
        nameBestAll{2,1} = nameBestSwimSpeed;
        nameBestAll{3,1} = nameBestStrokeEff;
        nameBestAll{4,1} = nameBestSpeedDecay;
        nameBestAll{5,1} = nameBestSkillTime;
        nameBestAll{6,1} = nameBestStartTime;
        nameBestAll{7,1} = nameBestFinishTime;
        
        DataToPlot = [diff2bestRaceTime diff2bestSwimSpeedelement diff2bestStrokeEffelement diff2bestSpeedDecayelement ...
            diff2bestSkillTimeelement diff2bestStartTimeelement diff2bestFinishTimeelement];
    
    else;
        nameBestAll{2,1} = '';
        nameBestAll{3,1} = '';
        nameBestAll{4,1} = '';
        nameBestAll{5,1} = '';
        nameBestAll{6,1} = '';
        nameBestAll{7,1} = '';
        
        DataToPlot = [diff2bestRaceTime diff2bestSwimSpeedrace diff2bestStrokeEffrace diff2bestSpeedDecayrace ...
            diff2bestSkillTimerace diff2bestStartTimerace diff2bestFinishTimerace];
    end;

    DataToTitle = [nameBestRaceTime nameBestSwimSpeed nameBestStrokeEff nameBestSpeedDecay ...
            nameBestSkillTime nameBestStartTime nameBestFinishTime];
    axesLabel = {'Race Time'; 'Swim Speed'; 'Stroke Index'; 'Speed Decay'; ...
            'Skill Time'; 'Start Time'; 'Finish Time'};
end;

fontsizelegend = 0.02;
fontsizeaxes = 0.016;
if graphType == 4;
    if strcmpi(SearchPerfSelect, 'PB') | strcmpi(SearchPerfSelect, 'SB');
        histTitle = [SearchNameSelect{1,1} '_' SearchPerfSelect];
    else;
        histTitle = SearchPerfSelect;
    end;
    
else;
    histTitle = '';
end;
handles.txtMainProfile_HIST = hist_plot_benchmark(DataToPlot, DataToTitle, nameBestAll, ...
    handles.MainProfile_benchmark, axesLabel, ...
    fontsizelegend, fontsizeaxes, imcolormap, imcolormap2, graphType, histTitle, RaceOption, LegOption);
%--------------------------------------------------------------------------



%-----------------------------Display Table--------------------------------
%---Table lines
tableTop = 370;
tableLeft = 550;
rowHeight = 20;
columnWidth = 60;
fontsizetitle = 0.017;
fontsizevalue = 0.017;
colortitle = [0 0 0];
colorvalue = [0.2 0.2 0.2];

% txtOBJ_TABLE{1,1} = rectangle(handles.MainProfile_benchmark, 'position', [tableLeft tableTop tableLeft+(8*columnWidth) tableTop+(1*rowHeight)], 'edgecolor', 'none', 'facecolor', [0.8 0.8 0.8]);
txtOBJ_TABLE{1,1} = plot(handles.MainProfile_benchmark, [tableLeft tableLeft+(8*columnWidth)], [tableTop tableTop], 'k', 'linewidth', 1.5);
txtOBJ_TABLE{1,2} = plot(handles.MainProfile_benchmark, [tableLeft tableLeft+(8*columnWidth)], [tableTop+(5*rowHeight) tableTop+(5*rowHeight)], 'k', 'linewidth', 1.5);
txtOBJ_TABLE{1,3} = plot(handles.MainProfile_benchmark, [tableLeft tableLeft+(8*columnWidth)], [tableTop+(1*rowHeight) tableTop+(1*rowHeight)], 'color', [0.7 0.7 0.7], 'linewidth', 0.5);
txtOBJ_TABLE{1,4} = plot(handles.MainProfile_benchmark, [tableLeft tableLeft+(8*columnWidth)], [tableTop+(2*rowHeight) tableTop+(2*rowHeight)], 'color', [0.7 0.7 0.7], 'linewidth', 0.5);
txtOBJ_TABLE{1,5} = plot(handles.MainProfile_benchmark, [tableLeft tableLeft+(8*columnWidth)], [tableTop+(3*rowHeight) tableTop+(3*rowHeight)], 'color', [0.7 0.7 0.7], 'linewidth', 0.5);
txtOBJ_TABLE{1,6} = plot(handles.MainProfile_benchmark, [tableLeft tableLeft+(8*columnWidth)], [tableTop+(4*rowHeight) tableTop+(4*rowHeight)], 'color', [0.5 0.5 0.5], 'linewidth', 0.5);

% txtOBJ_TABLE{2,1} = text(tableLeft, tableTop+2, 'ererere', 'FontName', 'Book Antiqua', 'FontAngle', ...
%     'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', 'verticalalignment', 'top');
txtOBJ_TABLE{2,1} = text(tableLeft, tableTop+(1*rowHeight)+2, 'Selection', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', 'verticalalignment', 'top');
txtOBJ_TABLE{2,2} = text(tableLeft, tableTop+(2*rowHeight)+2, 'PB', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', 'verticalalignment', 'top');

listSeason = get(handles.SelectSeasonProfile_benchmark, 'String');
valSeason = get(handles.SelectSeasonProfile_benchmark, 'Value');
SeasonEC = listSeason{valSeason};
if length(SeasonEC) == 9;
    %Single year selected
    txt = 'SB';
else;
    index = strfind(lower(SeasonEC), lower('Any'));
    if isempty(index) == 1;
        %Cycle selected
        txt = 'CB';
    else;
        %All
        txt = 'SB';
    end;
end;
txtOBJ_TABLE{2,3} = text(tableLeft, tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', 'verticalalignment', 'top');

if graphType == 1;
    txt = 'Best';
elseif graphType == 2;
    txt = 'Top 3';
elseif graphType == 3;
    txt = 'Top 8';
elseif graphType == 4;
    txt = 'Select';
end;
txtOBJ_TABLE{2,4} = text(tableLeft, tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', 'verticalalignment', 'top');

txtOBJ_TABLE{3,1} = text(tableLeft+(1.5*columnWidth)-5, tableTop+2, 'Race Time', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
txtOBJ_TABLE{3,2} = text(tableLeft+(2.5*columnWidth)-5, tableTop+2, 'Swim Speed', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
txtOBJ_TABLE{3,3} = text(tableLeft+(3.5*columnWidth), tableTop+2, 'Stroke Index', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
txtOBJ_TABLE{3,4} = text(tableLeft+(4.5*columnWidth+5), tableTop+2, 'Speed Decay', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
txtOBJ_TABLE{3,5} = text(tableLeft+(5.5*columnWidth)+5, tableTop+2, 'Skill Time', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
txtOBJ_TABLE{3,6} = text(tableLeft+(6.5*columnWidth)+5, tableTop+2, 'Start Time', 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if turnexist == 1
    txt = 'Turn Time';
else;
    txt = 'Finish Time';
end;
txtOBJ_TABLE{3,7} = text(tableLeft+(7.5*columnWidth)+5, tableTop+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizetitle, 'Color', colortitle, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');

txt = timeSecToStr(diff2bestRaceTime(2));
txtOBJ_TABLE{4,1} = text(tableLeft+(1.5*columnWidth)-5, tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestSwimSpeedelement(2),2) ' m/s'];
else;
    txt = [dataToStr(diff2bestSwimSpeedrace(2),2) ' m/s'];
end;
txtOBJ_TABLE{4,2} = text(tableLeft+(2.5*columnWidth)-5, tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestStrokeEffelement(2),2) ' m2/s/str'];
else;
    txt = [dataToStr(diff2bestStrokeEffrace(2),2) ' m2/s/str'];
end;
txtOBJ_TABLE{4,3} = text(tableLeft+(3.5*columnWidth), tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestSpeedDecayelement(2).*100,2) ' %'];
else;
    txt = [dataToStr(diff2bestSpeedDecayrace(2).*100,2) ' %'];
end;
txtOBJ_TABLE{4,4} = text(tableLeft+(4.5*columnWidth+5), tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = timeSecToStr(roundn(diff2bestSkillTimeelement(2),-2));
else;
    txt = timeSecToStr(roundn(diff2bestSkillTimerace(2),-2));
end;
txtOBJ_TABLE{4,5} = text(tableLeft+(5.5*columnWidth)+5, tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
    txt = 'No Start';
else;
    if strcmpi(RaceOption,'Element') == 1;
        txt = timeSecToStr(roundn(diff2bestStartTimeelement(2),-2));
    else;
        txt = timeSecToStr(roundn(diff2bestStartTimerace(2),-2));
    end;
end;
txtOBJ_TABLE{4,6} = text(tableLeft+(6.5*columnWidth)+5, tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if turnexist == 1
    if strcmpi(LegOption, 'Butterfly Only');
        txt = 'No Turn';
    else;
        if strcmpi(RaceOption,'Element') == 1;
            txt = timeSecToStr(roundn(diff2bestTurnTimeelement(2),-2));
        else;
            txt = timeSecToStr(roundn(diff2bestTurnTimerace(2),-2));
        end;
    end;
else;
    if strcmpi(RaceOption,'Element') == 1;
        txt = timeSecToStr(roundn(diff2bestFinishTimeelement(2),-2));
    else;
        txt = timeSecToStr(roundn(diff2bestFinishTimerace(2),-2));
    end;
end;
txtOBJ_TABLE{4,7} = text(tableLeft+(7.5*columnWidth)+5, tableTop+(1*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');


txt = timeSecToStr(diff2bestRaceTimePB(2));
txtOBJ_TABLE{5,1} = text(tableLeft+(1.5*columnWidth)-5, tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestSwimSpeedelementPB(2),2) ' m/s'];
else;
    txt = [dataToStr(diff2bestSwimSpeedracePB(2),2) ' m/s'];
end;
txtOBJ_TABLE{5,2} = text(tableLeft+(2.5*columnWidth)-5, tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestStrokeEffelementPB(2),2) ' m2/s/str'];
else;
    txt = [dataToStr(diff2bestStrokeEffracePB(2),2) ' m2/s/str'];
end;
txtOBJ_TABLE{5,3} = text(tableLeft+(3.5*columnWidth), tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestSpeedDecayelementPB(2).*100,2) ' %'];
else;
    txt = [dataToStr(diff2bestSpeedDecayracePB(2).*100,2) ' %'];
end;
txtOBJ_TABLE{5,4} = text(tableLeft+(4.5*columnWidth+5), tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = timeSecToStr(roundn(diff2bestSkillTimeelementPB(2),-2));
else;
    txt = timeSecToStr(roundn(diff2bestSkillTimeracePB(2),-2));
end;
txtOBJ_TABLE{5,5} = text(tableLeft+(5.5*columnWidth)+5, tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
    txt = 'No Start';
else;
    if strcmpi(RaceOption,'Element') == 1;
        txt = timeSecToStr(roundn(diff2bestStartTimeelementPB(2),-2));
    else;
        txt = timeSecToStr(roundn(diff2bestStartTimeracePB(2),-2));
    end;
end;
txtOBJ_TABLE{5,6} = text(tableLeft+(6.5*columnWidth)+5, tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if turnexist == 1
    if strcmpi(LegOption, 'Butterfly Only');
        txt = 'No Turn';
    else;
        if strcmpi(RaceOption,'Element') == 1;
            txt = timeSecToStr(roundn(diff2bestTurnTimeelementPB(2),-2));
        else;
            txt = timeSecToStr(roundn(diff2bestTurnTimeracePB(2),-2));
        end;
    end;
else;
    if strcmpi(RaceOption,'Element') == 1;
        txt = timeSecToStr(roundn(diff2bestFinishTimeelementPB(2),-2));
    else;
        txt = timeSecToStr(roundn(diff2bestFinishTimeracePB(2),-2));
    end;
end;
txtOBJ_TABLE{5,7} = text(tableLeft+(7.5*columnWidth)+5, tableTop+(2*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');


if diff2bestRaceTimeSB(2) ~= 0;
    txt = timeSecToStr(diff2bestRaceTimeSB(2));
else;
    txt = '-';
end;
txtOBJ_TABLE{6,1} = text(tableLeft+(1.5*columnWidth)-5, tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    if diff2bestSwimSpeedelementSB(2) ~= 0;
        txt = [dataToStr(diff2bestSwimSpeedelementSB(2),2) ' m/s'];
    else;
        txt = '-';
    end;
else;
    if diff2bestSwimSpeedraceSB(2) ~= 0;
        txt = [dataToStr(diff2bestSwimSpeedraceSB(2),2) ' m/s'];
    else;
        txt = '-';
    end;
end;
txtOBJ_TABLE{6,2} = text(tableLeft+(2.5*columnWidth)-5, tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    if diff2bestStrokeEffelementSB(2) ~= 0;
        txt = [dataToStr(diff2bestStrokeEffelementSB(2),2) ' m2/s/str'];
    else;
        txt = '-';
    end;
else;
    if diff2bestStrokeEffraceSB(2) ~= 0;
        txt = [dataToStr(diff2bestStrokeEffraceSB(2),2) ' m2/s/str'];
    else;
        txt = '-';
    end;
end;
txtOBJ_TABLE{6,3} = text(tableLeft+(3.5*columnWidth), tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    if diff2bestSpeedDecayelementSB(2) ~= 0;
        txt = [dataToStr(diff2bestSpeedDecayelementSB(2).*100,2) ' %'];
    else;
        txt = '-';
    end;
else;
    if diff2bestSpeedDecayraceSB(2) ~= 0;
        txt = [dataToStr(diff2bestSpeedDecayraceSB(2).*100,2) ' %'];
    else;
        txt = '-';
    end;
end;
txtOBJ_TABLE{6,4} = text(tableLeft+(4.5*columnWidth+5), tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    if diff2bestSkillTimeelementSB(2) ~= 0;
        txt = timeSecToStr(roundn(diff2bestSkillTimeelementSB(2),-2));
    else;
        txt = '-';
    end;
else;
    if diff2bestSkillTimeraceSB(2) ~= 0;
        txt = timeSecToStr(roundn(diff2bestSkillTimeraceSB(2),-2));
    else;
        txt = '-';
    end;
end;
txtOBJ_TABLE{6,5} = text(tableLeft+(5.5*columnWidth)+5, tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    if diff2bestStartTimeelementSB(2) ~= 0;
        if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
            txt = 'No Start';
        else;
            txt = timeSecToStr(roundn(diff2bestStartTimeelementSB(2),-2));
        end;
    else;
        txt = '-';
    end;
else;
    if diff2bestStartTimeraceSB(2) ~= 0;
        if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
            txt = 'No Start';
        else;
            txt = timeSecToStr(roundn(diff2bestStartTimeraceSB(2),-2));
        end;
    else;
        txt = '-';
    end;
end;
txtOBJ_TABLE{6,6} = text(tableLeft+(6.5*columnWidth)+5, tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if turnexist == 1
    if strcmpi(RaceOption,'Element') == 1;
        if strcmpi(LegOption, 'Butterfly Only');
            if isempty(databaseCurrentSB) == 1
                txt= '-';
            else;
                txt = 'No Turn';
            end;
        else;
            if diff2bestTurnTimeelementSB(2) ~= 0;
                txt = timeSecToStr(roundn(diff2bestTurnTimeelementSB(2),-2));
            else;
                txt = '-';
            end;
        end;
    else;
        if strcmpi(LegOption, 'Butterfly Only');
            if isempty(databaseCurrentSB) == 1
                txt= '-';
            else;
                txt = 'No Turn';
            end;
        else;
            if diff2bestTurnTimeraceSB(2) ~= 0;
                txt = timeSecToStr(roundn(diff2bestTurnTimeraceSB(2),-2));
            else;
                txt = '-';
            end;
        end;
    end;
else;
    if strcmpi(RaceOption,'Element') == 1;
        if diff2bestFinishTimeelementSB(2) ~= 0;
            txt = [timeSecToStr(roundn(diff2bestFinishTimeelementSB(2),-2))];
        else;
            txt = '-';
        end;
    else;
        if diff2bestFinishTimeraceSB(2) ~= 0;
            txt = [timeSecToStr(roundn(diff2bestFinishTimeraceSB(2),-2))];
        else;
            txt = '-';
        end;
    end;
end;
txtOBJ_TABLE{6,7} = text(tableLeft+(7.5*columnWidth)+5, tableTop+(3*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');

txt = timeSecToStr(roundn(diff2bestRaceTime(3),-2));
txtOBJ_TABLE{7,1} = text(tableLeft+(1.5*columnWidth)-5, tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestSwimSpeedelement(3),2) ' m/s'];
else;
    txt = [dataToStr(diff2bestSwimSpeedrace(3),2) ' m/s'];
end;
txtOBJ_TABLE{7,2} = text(tableLeft+(2.5*columnWidth)-5, tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestStrokeEffelement(3),2) ' m2/s/str'];
else;
    txt = [dataToStr(diff2bestStrokeEffrace(3),2) ' m2/s/str'];
end;
txtOBJ_TABLE{7,3} = text(tableLeft+(3.5*columnWidth), tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = [dataToStr(diff2bestSpeedDecayelement(3).*100,2) ' %'];
else;
    txt = [dataToStr(diff2bestSpeedDecayrace(3).*100,2) ' %'];
end;
txtOBJ_TABLE{7,4} = text(tableLeft+(4.5*columnWidth+5), tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(RaceOption,'Element') == 1;
    txt = timeSecToStr(roundn(diff2bestSkillTimeelement(3),-2));
else;
    txt = timeSecToStr(roundn(diff2bestSkillTimerace(3),-2));
end;
txtOBJ_TABLE{7,5} = text(tableLeft+(5.5*columnWidth)+5, tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
    txt = 'No Start';
else;
    if strcmpi(RaceOption,'Element') == 1;
        txt = timeSecToStr(roundn(diff2bestStartTimeelement(3),-2));
    else;
        txt = timeSecToStr(roundn(diff2bestStartTimerace(3),-2));
    end;
end;
txtOBJ_TABLE{7,6} = text(tableLeft+(6.5*columnWidth)+5, tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');
if turnexist == 1;
    if strcmpi(LegOption, 'Butterfly Only');
        txt = 'No Turn';
    else;
        if strcmpi(RaceOption,'Element') == 1;
            txt = timeSecToStr(roundn(diff2bestTurnTimeelement(3),-2));
        else;
            txt = timeSecToStr(roundn(diff2bestTurnTimerace(3),-2));
        end;
    end;
else;
    if strcmpi(RaceOption,'Element') == 1;
        txt = timeSecToStr(roundn(diff2bestFinishTimeelement(3),-2));
    else;
        txt = timeSecToStr(roundn(diff2bestFinishTimerace(3),-2));
    end;
end;
txtOBJ_TABLE{7,7} = text(tableLeft+(7.5*columnWidth)+5, tableTop+(4*rowHeight)+2, txt, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', fontsizevalue, 'Color', colorvalue, 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'top');

handles.txtOBJ_TABLE = txtOBJ_TABLE;
%--------------------------------------------------------------------------



%-----------------------------Display Group--------------------------------
AgeComp = 'Open';
if get(handles.salRulesProfile_benchmark, 'Value') == 1;
    %First day of the meet to calculate the age
    if handles.selectAgeLimProfile_benchmark == 1;
        if valAge == 8;
            AgeComp = '13y & Under';
        elseif valAge == 7;
            AgeComp = '14y';
        elseif valAge == 6;
            AgeComp = '15y';
        elseif valAge == 5;
            AgeComp = '16y';
        elseif valAge == 4;
            AgeComp = '17y';
        elseif valAge == 3;
            AgeComp = '18y';
        end;
    elseif handles.selectAgeLimProfile_benchmark == 2;
        if valAge == 8;
            AgeComp = '13y & Under';
        elseif valAge == 7;
            AgeComp = '14y & Under';
        elseif valAge == 6;
            AgeComp = '15y & Under';
        elseif valAge == 5;
            AgeComp = '16y & Under';
        elseif valAge == 4;
            AgeComp = '17y & Under';
        elseif valAge == 3;
            AgeComp = '18y & Under';
        end;
    end;
else;
    %End of year rule
    if handles.selectAgeLimProfile_benchmark == 1;
        if valAge == 8;
            AgeComp = '14y';
        elseif valAge == 7;
            AgeComp = '15y';
        elseif valAge == 6;
            AgeComp = '16y';
        elseif valAge == 5;
            AgeComp = '17y';
        elseif valAge == 4;
            AgeComp = '18y';
        elseif valAge == 3;
            AgeComp = '19y';
        end;
    elseif handles.selectAgeLimProfile_benchmark == 2;
        if valAge == 8;
            AgeComp = '14y';
        elseif valAge == 7;
            AgeComp = '15y & Under';
        elseif valAge == 6;
            AgeComp = '16y & Under';
        elseif valAge == 5;
            AgeComp = '17y & Under';
        elseif valAge == 4;
            AgeComp = '18y & Under';
        elseif valAge == 3;
            AgeComp = '19y & Under';
        end;
    end;
end;
        
if valCountry == 2;
    groupCountry = 'World';
elseif valCountry == 3;
    groupCountry = 'Australian';
elseif valCountry == 4;
    groupCountry = 'International';
end;
txt = [groupCountry ' Best   -   ' AgeComp];
txtOBJ_GROUP{1,1} = text(20, 280, txt, 'Rotation',90, 'FontName', 'Book Antiqua', 'FontAngle', ...
    'Italic', 'FontWeight', 'Bold', 'fontunits', 'normalized', 'Fontsize', 0.036, 'Color', [1 1 1], 'Interpreter', 'none', ...
    'horizontalalignment', 'center', 'verticalalignment', 'middle');

handles.txtOBJ_GROUP = txtOBJ_GROUP;
%--------------------------------------------------------------------------

handles.databaseCurrent_Profile = databaseCurrent;

uistack(handles.logo_sa_main, 'top');


