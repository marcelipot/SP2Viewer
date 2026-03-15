
%---create question icon
handles.Question_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [10, 685, 30, 30], 'callback', @questionMarks_analyser, 'cdata', imresize(handles.icones.question_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Question_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Show definitions');

%---create save icon
handles.Save_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [45, 685, 30, 30], 'callback', @saveDataJPG_benchmark, 'cdata', imresize(handles.icones.saveJPG_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Save_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Save image');

%---create pdf icone
handles.Reportpdf_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [80, 685, 30, 30], 'callback', @saveDataPDF_benchmark, 'cdata', imresize(handles.icones.saveReport_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Reportpdf_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Save Sparta reports');

%---create download icone
handles.Download_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [115, 685, 30, 30], 'callback', @saveDataXLS_benchmark, 'cdata', imresize(handles.icones.saveSeg_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Download_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Download segment data');

%---refresh icone
handles.Refreshcloud_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1210, 685, 30, 30], 'callback', @refreshCloud_benchmark, 'cdata', imresize(handles.icones.reset_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Refreshcloud_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Download new races');

%---create arrow back icone
handles.Arrowback_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1245, 685, 30, 30], 'callback', @return2menu_benchmark, 'cdata', imresize(handles.icones.arrow_back_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.Arrowback_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Return to selection menu');


if ispc == 1;
    font1 = 12;
    font2 = 11;
elseif ismac == 1;
    font1 = 15;
    font2 = 14;
end;

if ismac == 1;
    %---create data panel button
    handles.ranking_toggle_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [190, 645, 125, 33], 'callback', @rankingpanel_benchmark, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Rankings');
    set(handles.ranking_toggle_benchmark, 'fontunits', 'normalized');

    %---create data panel button
    handles.profile_toggle_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [316, 645, 125, 33], 'callback', @profilepanel_benchmark, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Profiles');
    set(handles.profile_toggle_benchmark, 'fontunits', 'normalized');
    
    %---create data panel button
    handles.trend_toggle_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [442, 645, 125, 33], 'callback', @trendpanel_benchmark, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Trends');
    set(handles.trend_toggle_benchmark, 'fontunits', 'normalized');
    
elseif ispc == 1;
    %---create data panel button
    handles.ranking_toggle_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [190, 645, 125, 33], 'callback', @rankingpanel_benchmark, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Rankings');
    set(handles.ranking_toggle_benchmark, 'fontunits', 'normalized');
    
    %---create data panel button
    handles.profile_toggle_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [316, 645, 125, 33], 'callback', @profilepanel_benchmark, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Profiles');
    set(handles.profile_toggle_benchmark, 'fontunits', 'normalized');
    
    %---create data panel button
    handles.trend_toggle_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Togglebutton', 'Visible', 'off', 'units', 'pixels', ...
        'position', [442, 645, 125, 33], 'callback', @trendpanel_benchmark, ...
        'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'String', 'Trends');
    set(handles.trend_toggle_benchmark, 'fontunits', 'normalized');
end;


%------------------------------RANKINGS Top10------------------------------
%--------------------------------------------------------------------------

%---Select ranking type
handles.typeRankingTop10_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 655, 85, 20], 'value', 1, 'callback', @checkTypeRankingTop10_benchmark, 'enable', 'on', 'Visible', 'off', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', ' Top 10');
set(handles.typeRankingTop10_benchmark, 'fontunits', 'normalized');

handles.typeRankingCustom_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [100, 655, 85, 20], 'value', 0, 'callback', @checkTypeRankingCustom_benchmark, 'enable', 'on', 'Visible', 'off',  ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', ' Custom');
set(handles.typeRankingCustom_benchmark, 'fontunits', 'normalized');



%---create race selection panel button
handles.SelectRaceRanking_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 375, 175, 275], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select an event', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectRaceRanking_benchmark, 'fontunits', 'normalized');

if ispc == 1;
    handles.SelectGenderRankingList_benchmark = {'Gender';'Male';'Female'};
    handles.SelectGenderRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 232, 165, 20], 'string', handles.SelectGenderRankingList_benchmark, 'callback', @popGenderRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectGenderRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectStrokeRankingList_benchmark = {'Stroke';'Butterfly';'Backstroke';'Breaststroke';'Freestyle';'Medley'};
    handles.SelectStrokeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 209, 165, 20], 'string', handles.SelectStrokeRankingList_benchmark, 'callback', @popStrokeRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectStrokeRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectDistanceRankingList_benchmark = {'Distance';'50m';'100m';'150m';'200m';'400m';'800m';'1500m'};
    handles.SelectDistanceRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 186, 165, 20], 'string', handles.SelectDistanceRankingList_benchmark, 'callback', @popDistanceRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectDistanceRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectPoolRankingList_benchmark = {'Pool type';'LCM';'SCM'};
    handles.SelectPoolRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 163, 165, 20], 'string', handles.SelectPoolRankingList_benchmark, 'callback', @popCourseRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPoolRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectCategoryRankingList_benchmark = {'Category';'Able';'Para'};
    handles.SelectCategoryRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 140, 165, 20], 'string', handles.SelectCategoryRankingList_benchmark, 'callback', @popCatRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectCategoryRanking_benchmark, 'fontunits', 'normalized');
    
    meetIDlist = fields(handles.AgeGroup);
    meetIDDatabase = [];
    for meetEC = 1:length(handles.MeetDB(:,2));
        meetIDDatabase(meetEC,1) = handles.MeetDB{meetEC,2};
    end;
    
    %Remove meets from AgeGroup
    meet2remove{1,1} = 'A274724_2018A';
    meet2remove{2,1} = 'A274724_2019A';
    meet2remove{3,1} = 'A274725_2019A';
    meet2remove{4,1} = 'A274724_2020A';
    meet2remove{5,1} = 'A274812_2020A';
    meet2remove{6,1} = 'A274725_2020A';
    meet2remove{7,1} = 'A274725_2021A';
    meet2remove{8,1} = 'A274812_2022A';
    meet2remove{9,1} = 'A365146_2023A';
    meet2remove{10,1} = 'A368206_2023A';
    meet2remove{11,1} = 'A368203_2023A';
    meet2remove{12,1} = 'A368205_2023A';
    meet2remove{13,1} = 'A274812_2023A';
    meet2remove{14,1} = 'A368202_2023A';
    meet2remove{15,1} = 'A0_2011A';

    listmeetNameRanking = {};
    listmeetYearRanking = {};
    meetIDlistNew = {};
    iter = 1;
    for meetEC = 1:length(meetIDlist);
        txtEC = meetIDlist{meetEC};
        eval(['dateEC = handles.AgeGroup.' txtEC ';']);
        li = strfind(txtEC, '_');
        meetNumberEC = str2num(txtEC(2:li(1)-1));
%         meetYearEC = txtEC(li(1)+1:end-1);
        
        limeet = find(meetIDDatabase == meetNumberEC);
        liRemove = find(contains(meet2remove, txtEC));
        if isempty(liRemove) == 1;
            meetNameEC = handles.MeetDB{limeet(1),1};
            listmeetNameRanking{iter,1} = meetNameEC;
            listmeetYearRanking{iter,1} = dateEC;
            meetIDlistNew{iter,1} = txtEC;
            iter = iter + 1;
        end;
    end;
    [listmeetYearRanking, liSortMeet] = sort(listmeetYearRanking);
    listmeetNameRanking = listmeetNameRanking(liSortMeet,1);
    meetIDlistRanking = meetIDlistNew(liSortMeet,1);
    SelectMeetRankingList_benchmark{1,1} = 'Championship';
    SelectMeetNumberRankingList_benchmark{1,1} = 'Championship';
    SelectMeetYearRankingList_benchmark{1,1} = 'Championship';
    SelectMeetRankingList_benchmark{2,1} = 'All';
    SelectMeetNumberRankingList_benchmark{2,1} = 'All';
    SelectMeetYearRankingList_benchmark{2,1} = 'All';
    iter = length(listmeetYearRanking)+1;

    for dateCheck = 1:length(listmeetYearRanking);
        yearEC = listmeetYearRanking{iter-dateCheck};
        yearEC = yearEC(1:4);
        if dateCheck == 1;            
            yearRef = yearEC;
            SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
            SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = listmeetNameRanking{iter-dateCheck,1};

            SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
            SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = meetIDlistRanking{iter-dateCheck,1};

            SelectMeetNumberRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
            SelectMeetNumberRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = yearRef;
        else;
            if strcmpi(yearEC, yearRef) == 1;
                %same year
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = listmeetNameRanking{iter-dateCheck,1};
                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = meetIDlistRanking{iter-dateCheck,1};
                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = yearRef;
            else;
                %new year
                yearRef = yearEC;
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = '  ';
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = listmeetNameRanking{iter-dateCheck,1};

                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = '  ';
                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = meetIDlistRanking{iter-dateCheck,1};

                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = '  ';
                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = yearRef;
            end;
        end;
    end;

    handles.SelectMeetRankingList_benchmark = SelectMeetRankingList_benchmark;
    handles.SelectMeetNumberRankingList_benchmark = SelectMeetNumberRankingList_benchmark;
    handles.SelectMeetYearRankingList_benchmark = SelectMeetYearRankingList_benchmark;
    handles.SelectMeetRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 117, 165, 20], 'string', handles.SelectMeetRankingList_benchmark, 'callback', @popMeetRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectMeetRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectRoundRankingList_benchmark{1,1} = 'Round';
    handles.SelectRoundRankingList_benchmark{2,1} = 'All';
    for i = 1:length(handles.RoundDB);
        RoundEC = handles.RoundDB{i,1};
        handles.SelectRoundRankingList_benchmark{2+i,1} = RoundEC;
    end;
    handles.SelectRoundRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 94, 165, 20], 'string', handles.SelectRoundRankingList_benchmark, 'callback', @popRoundRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectRoundRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectTypeRankingList_benchmark{1,1} = 'Type';
    handles.SelectTypeRankingList_benchmark{2,1} = 'All';
    handles.SelectTypeRankingList_benchmark{3,1} = 'Individual';
    handles.SelectTypeRankingList_benchmark{4,1} = 'Relay (L.1)';
    handles.SelectTypeRankingList_benchmark{5,1} = 'Relay (CO)';
    handles.SelectTypeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 71, 165, 20], 'string', handles.SelectTypeRankingList_benchmark, 'callback', @popTypeRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectTypeRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectAgeRankingList_benchmark = {'Age Group';'Open';'18y';'17y';'16y';'15y';'14y';'13y & under'};
    handles.SelectAgeRankingList2_benchmark = {'Age Group';'Open';'19y';'18y';'17y';'16y';'15y';'14y'};
    handles.SelectAgeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 48, 165, 20], 'string', handles.SelectAgeRankingList_benchmark, 'callback', @popAgeRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAgeRanking_benchmark, 'fontunits', 'normalized');
    
elseif ismac == 1;
    
    handles.SelectGenderRankingList_benchmark = {'Gender';'Male';'Female'};
    handles.SelectGenderRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 232, 165, 20], 'string', handles.SelectGenderRankingList_benchmark, 'callback', @popGenderRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectGenderRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectStrokeRankingList_benchmark = {'Stroke';'Butterfly';'Backstroke';'Breaststroke';'Freestyle';'Medley'};
    handles.SelectStrokeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 209, 165, 20], 'string', handles.SelectStrokeRankingList_benchmark, 'callback', @popStrokeRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectStrokeRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectDistanceRankingList_benchmark = {'Distance';'50m';'100m';'150m';'200m';'400m';'800m';'1500m'};
    handles.SelectDistanceRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 186, 165, 20], 'string', handles.SelectDistanceRankingList_benchmark, 'callback', @popDistanceRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectDistanceRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectPoolRankingList_benchmark = {'Pool type';'LCM';'SCM'};
    handles.SelectPoolRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 163, 165, 20], 'string', handles.SelectPoolRankingList_benchmark, 'callback', @popCourseRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPoolRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectCategoryRankingList_benchmark = {'Category';'Able';'Para'};
    handles.SelectCategoryRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 140, 165, 20], 'string', handles.SelectCategoryRankingList_benchmark, 'callback', @popCatRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectCategoryRanking_benchmark, 'fontunits', 'normalized');
    
    meetIDlist = fields(handles.AgeGroup);
    meetIDDatabase = [];
    for meetEC = 1:length(handles.MeetDB(:,2));
        meetIDDatabase(meetEC,1) = handles.MeetDB{meetEC,2};
    end;
    
    %Remove meets from AgeGroup
    meet2remove{1,1} = 'A274724_2018A';
    meet2remove{2,1} = 'A274724_2019A';
    meet2remove{3,1} = 'A274725_2019A';
    meet2remove{4,1} = 'A274724_2020A';
    meet2remove{5,1} = 'A274812_2020A';
    meet2remove{6,1} = 'A274725_2020A';
    meet2remove{7,1} = 'A274725_2021A';
    meet2remove{8,1} = 'A274812_2022A';
    meet2remove{9,1} = 'A365146_2023A';
    meet2remove{10,1} = 'A368206_2023A';
    meet2remove{11,1} = 'A368203_2023A';
    meet2remove{12,1} = 'A368205_2023A';
    meet2remove{13,1} = 'A274812_2023A';
    meet2remove{14,1} = 'A368202_2023A';
    meet2remove{15,1} = 'A0_2011A';

    listmeetNameRanking = {};
    listmeetYearRanking = {};
    meetIDlistNew = {};
    iter = 1;
    for meetEC = 1:length(meetIDlist);
        txtEC = meetIDlist{meetEC};
        eval(['dateEC = handles.AgeGroup.' txtEC ';']);
        li = strfind(txtEC, '_');
        meetNumberEC = str2num(txtEC(2:li(1)-1));
%         meetYearEC = txtEC(li(1)+1:end-1);
        
        limeet = find(meetIDDatabase == meetNumberEC);
        liRemove = find(contains(meet2remove, txtEC));
        if isempty(liRemove) == 1;
            meetNameEC = handles.MeetDB{limeet(1),1};
            listmeetNameRanking{iter,1} = meetNameEC;
            listmeetYearRanking{iter,1} = dateEC;
            meetIDlistNew{iter,1} = txtEC;
            iter = iter + 1;
        end;
    end;
    [listmeetYearRanking, liSortMeet] = sort(listmeetYearRanking);
    listmeetNameRanking = listmeetNameRanking(liSortMeet,1);
    meetIDlistRanking = meetIDlistNew(liSortMeet,1);
    SelectMeetRankingList_benchmark{1,1} = 'Championship';
    SelectMeetNumberRankingList_benchmark{1,1} = 'Championship';
    SelectMeetYearRankingList_benchmark{1,1} = 'Championship';
    SelectMeetRankingList_benchmark{2,1} = 'All';
    SelectMeetNumberRankingList_benchmark{2,1} = 'All';
    SelectMeetYearRankingList_benchmark{2,1} = 'All';
    iter = length(listmeetYearRanking)+1;

    for dateCheck = 1:length(listmeetYearRanking);
        yearEC = listmeetYearRanking{iter-dateCheck};
        yearEC = yearEC(1:4);
        if dateCheck == 1;            
            yearRef = yearEC;
            SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
            SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = listmeetNameRanking{iter-dateCheck,1};

            SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
            SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = meetIDlistRanking{iter-dateCheck,1};

            SelectMeetNumberRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
            SelectMeetNumberRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = yearRef;
        else;
            if strcmpi(yearEC, yearRef) == 1;
                %same year
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = listmeetNameRanking{iter-dateCheck,1};
                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = meetIDlistRanking{iter-dateCheck,1};
                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = yearRef;
            else;
                %new year
                yearRef = yearEC;
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = '  ';
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
                SelectMeetRankingList_benchmark{length(SelectMeetRankingList_benchmark(:,1))+1,1} = listmeetNameRanking{iter-dateCheck,1};

                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = '  ';
                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
                SelectMeetNumberRankingList_benchmark{length(SelectMeetNumberRankingList_benchmark(:,1))+1,1} = meetIDlistRanking{iter-dateCheck,1};

                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = '  ';
                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = [' -- ' yearRef ' -- '];
                SelectMeetYearRankingList_benchmark{length(SelectMeetYearRankingList_benchmark(:,1))+1,1} = yearRef;
            end;
        end;
    end;

    handles.SelectMeetRankingList_benchmark = SelectMeetRankingList_benchmark;
    handles.SelectMeetNumberRankingList_benchmark = SelectMeetNumberRankingList_benchmark;
    handles.SelectMeetYearRankingList_benchmark = SelectMeetYearRankingList_benchmark;

    handles.SelectMeetRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 117, 165, 20], 'string', handles.SelectMeetRankingList_benchmark, 'callback', @popMeetRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectMeetRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectRoundRankingList_benchmark{1,1} = 'Round';
    handles.SelectRoundRankingList_benchmark{2,1} = 'All';
    for i = 1:length(handles.RoundDB);
        RoundEC = handles.RoundDB{i,1};
        handles.SelectRoundRankingList_benchmark{2+i,1} = RoundEC;
    end;
    handles.SelectRoundRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 94, 165, 20], 'string', handles.SelectRoundRankingList_benchmark, 'callback', @popRoundRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectRoundRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectTypeRankingList_benchmark{1,1} = 'Type';
    handles.SelectTypeRankingList_benchmark{2,1} = 'All';
    handles.SelectTypeRankingList_benchmark{3,1} = 'Individual';
    handles.SelectTypeRankingList_benchmark{4,1} = 'Relay (L.1)';
    handles.SelectTypeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 71, 165, 20], 'string', handles.SelectTypeRankingList_benchmark, 'callback', @popTypeRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectTypeRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectAgeRankingList_benchmark = {'Age Group';'Open';'18y';'17y';'16y';'15y';'14y';'13y & under'};
    handles.SelectAgeRankingList2_benchmark = {'Age Group';'Open';'19y';'18y';'17y';'16y';'15y';'14y'};
    handles.SelectAgeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 48, 165, 20], 'string', handles.SelectAgeRankingList_benchmark, 'callback', @popAgeRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAgeRanking_benchmark, 'fontunits', 'normalized');
end;
%---Create checkbox inferior or equal age
handles.strictAgeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 23, 85, 20], 'value', 0, 'callback', @checkstrictAgeRanking_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'Strict Age');
set(handles.strictAgeRanking_benchmark, 'fontunits', 'normalized');
handles.belowAgeRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [90, 23, 80, 20], 'value', 0, 'callback', @checkbelowAgeRanking_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'Include <');
set(handles.belowAgeRanking_benchmark, 'fontunits', 'normalized');

%---Create checkbox FINA/SAL
handles.finaRulesRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 5, 85, 20], 'value', 0, 'callback', @checkFinaRanking_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'FINA Age');
set(handles.finaRulesRanking_benchmark, 'fontunits', 'normalized');
handles.salRulesRanking_benchmark = uicontrol('parent', handles.SelectRaceRanking_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [90, 5, 80, 20], 'value', 0, 'callback', @checkSalRanking_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'SA Age');
set(handles.salRulesRanking_benchmark, 'fontunits', 'normalized');


%---create Dataset selection panel button
handles.SelectDataRanking_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 160, 175, 215], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select a dataset', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectDataRanking_benchmark, 'fontunits', 'normalized');

handles.SelectDatasetRankingList_benchmark = {'Dataset';'Race Time';'Swim Speed';'Stroke Efficiency';'Speed Decay';'Decay Index';'Skill Time';'Block Time';'Start Time';'Turn Time'};
handles.SelectPBRankingList_benchmark = {'Performance';'PBs Only';'All'};
handles.SelectCountryRankingList_benchmark = {'Countries';'Any';'Australian';'International'};
handles.SelectSeasonRankingList_benchmark = {'Seasons';'Any';'----  Cycle  ----';'LA 2028 cycle';'Paris 2024 cycle';'Tokyo 2021 cycle';'----  Season  ----';'2023-2024';'2022-2023';'2021-2022';'2020-2021';'2019-2020';'2018-2019';'2017-2018';'2016-2017'};
handles.SelectSpartaRankingList_benchmark = {'System';'Any';'GreenEye';'Sparta 1';'Sparta 2'};
if ispc == 1;
    handles.SelectDatasetRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 172, 165, 20], 'string', handles.SelectDatasetRankingList_benchmark, 'callback', @popDatasetRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectDatasetRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectPBRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 149, 165, 20], 'string', handles.SelectPBRankingList_benchmark, 'callback', @popPBRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPBRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectCountryRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 126, 165, 20], 'string', handles.SelectCountryRankingList_benchmark, 'callback', @popCountryRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectCountryRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectSeasonRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 103, 165, 20], 'string', handles.SelectSeasonRankingList_benchmark, 'callback', @popSeasonRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSeasonRanking_benchmark, 'fontunits', 'normalized');

    handles.AthleteNamesListGender = handles.AthleteNamesList;
    handles.AthleteNamesListGender{1,1} = 'All Swimmers';
    handles.SelectAthleteRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 80, 165, 20], 'string', handles.AthleteNamesListGender, 'callback', @popSwimmerRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAthleteRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SearchAthleteRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 57, 165, 20], 'Callback', @searchAthleteRanking_benchmark, ...
        'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', '');
    set(handles.SearchAthleteRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectSpartaRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 34, 165, 20], 'string', handles.SelectSpartaRankingList_benchmark, 'callback', @popSpartaRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSpartaRanking_benchmark, 'fontunits', 'normalized');

elseif ismac == 1;
    handles.SelectDatasetRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 172, 165, 20], 'string', handles.SelectDatasetRankingList_benchmark, 'callback', @popDatasetRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectDatasetRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectPBRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 149, 165, 20], 'string', handles.SelectPBRankingList_benchmark, 'callback', @popPBRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPBRanking_benchmark, 'fontunits', 'normalized');

    handles.SelectCountryRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 126, 165, 20], 'string', handles.SelectCountryRankingList_benchmark, 'callback', @popCountryRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectCountryRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SelectSeasonRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 103, 165, 20], 'string', handles.SelectSeasonRankingList_benchmark, 'callback', @popSeasonRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSeasonRanking_benchmark, 'fontunits', 'normalized');

    handles.AthleteNamesListGender = handles.AthleteNamesList;
    handles.AthleteNamesListGender{1,1} = 'All Swimmers';
    handles.SelectAthleteRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 80, 165, 20], 'string', handles.AthleteNamesListGender, 'callback', @popSwimmerRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAthleteRanking_benchmark, 'fontunits', 'normalized');
    
    handles.SearchAthleteRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 57, 165, 20], 'Callback', @searchAthleteRanking_benchmark, ...
        'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', '');
    set(handles.SearchAthleteRanking_benchmark, 'fontunits', 'normalized');


    handles.SelectSpartaRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 34, 165, 20], 'string', handles.SelectSpartaRankingList_benchmark, 'callback', @popSpartaRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSpartaRanking_benchmark, 'fontunits', 'normalized');
end;
handles.displayTurnsRanking_benchmark = uicontrol('parent', handles.SelectDataRanking_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 10, 165, 20], 'value', 0, 'callback', @checkDisplayTurnsRanking_benchmark, 'enable', 'on', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', 'Display all turn times');
set(handles.displayTurnsRanking_benchmark, 'fontunits', 'normalized');


%---create group selection panel button
handles.SelectSwimmerRanking_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 88, 175, 70], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Add a swimmer', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectSwimmerRanking_benchmark, 'fontunits', 'normalized');

if ispc == 1;
    handles.SelectAddAthleteRanking_benchmark = uicontrol('parent', handles.SelectSwimmerRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 32, 165, 20], 'string', handles.AthleteNamesList, 'callback', @popAddSwimmerRanking_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAddAthleteRanking_benchmark, 'fontunits', 'normalized');
    
elseif ismac == 1;
    handles.SelectAddAthleteRanking_benchmark = uicontrol('parent', handles.SelectSwimmerRanking_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 32, 165, 20], 'string', handles.AthleteNamesList, 'callback', @popAddSwimmerRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAddAthleteRanking_benchmark, 'fontunits', 'normalized');
end;

handles.SearchAddAthleteRanking_benchmark = uicontrol('parent', handles.SelectSwimmerRanking_benchmark, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 9, 165, 20], 'Callback', @searchAddAthleteRanking_benchmark, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', '');
set(handles.SearchAddAthleteRanking_benchmark, 'fontunits', 'normalized');


%---create remove all and validate icons
handles.ClearSearchRanking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [55, 55, 30, 30], 'callback', @clearSearchRanking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearSearchRanking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Clear selection');

handles.ValidateSearchRanking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [95, 55, 30, 30], 'callback', @validateSearchRanking_benchmark, 'cdata', imresize(handles.icones.validate_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ValidateSearchRanking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Validate selection');


%---Create main and secondary axes
handles.ClearRace1Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 548, 20, 20], 'callback', {@getRace2Delete_benchmark, 1}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace1Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 1');

handles.ClearRace2Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 506, 20, 20], 'callback', {@getRace2Delete_benchmark, 2}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace2Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 2');

handles.ClearRace3Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 464, 20, 20], 'callback', {@getRace2Delete_benchmark, 3}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace3Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 3');

handles.ClearRace4Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 420, 20, 20], 'callback', {@getRace2Delete_benchmark, 4}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace4Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 4');

handles.ClearRace5Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 378, 20, 20], 'callback', {@getRace2Delete_benchmark, 5}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace5Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 5');

handles.ClearRace6Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 335, 20, 20], 'callback', {@getRace2Delete_benchmark, 6}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace6Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 6');

handles.ClearRace7Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 291, 20, 20], 'callback', {@getRace2Delete_benchmark, 7}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace7Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 7');

handles.ClearRace8Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 248, 20, 20], 'callback', {@getRace2Delete_benchmark, 8}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace8Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 8');

handles.ClearRace9Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 207, 20, 20], 'callback', {@getRace2Delete_benchmark, 9}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace9Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 9');

handles.ClearRace10Ranking_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [1250, 164, 20, 20], 'callback', {@getRace2Delete_benchmark, 10}, 'cdata', imresize(handles.icones.redcross_offb, [30 30]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearRace10Ranking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Remove Race 10');

handles.MainRanking_benchmark = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [200, 150, 1050, 475], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.RankingBKG1);
uistack(handles.MainRanking_benchmark, 'bottom');

handles.SecondaryRanking_benchmark = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [200, 80, 1050, 43.5], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.RankingBKG2);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------







%-----------------------------RANKINGS Custom------------------------------
%--------------------------------------------------------------------------
%---create race selection panel
handles.SelectPerformanceCustom_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 95, 175, 555], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select a performance', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectPerformanceCustom_benchmark, 'fontunits', 'normalized');

%---Load a comparison profile
comparison_templatelist = 'Select a template';
if ispc == 1;
    handles.LoadComparisonCustomRanking_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 510, 142, 20], 'string', comparison_templatelist, 'callback', @popLoadComparisonRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.LoadComparisonCustomRanking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Load a comparison');
    
elseif ismac == 1;
    handles.LoadComparisonCustomRanking_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 510, 142, 20], 'string', comparison_templatelist, 'callback', @popLoadComparisonRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.LoadComparisonCustomRanking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Load a comparison');
end;

%---Delete comparison template
handles.deleteTemplateCustom_button_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [150, 510, 20, 20], 'callback', @deleteTemplateComp_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [25 25]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.deleteTemplateCustom_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Delete template');


%---Select top 20
handles.top20SelectionCustom_button_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 480, 165, 20], 'callback', @top20SelectionCustom_benchmark, ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', 'Display top 20 list');
set(handles.top20SelectionCustom_button_benchmark, 'fontunits', 'normalized');



%---create list athlete
handles.AthleteName_list_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'Listbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 290, 165, 185], 'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', font4, 'max', 1, 'min', 1, ...
    'callback', @listAthleteNameCustom_benchmark, 'Tooltipstring', 'Select an athlete');
% set(handles.AthleteName_list_benchmark, 'fontunits', 'normalized');

%---create search name
handles.Search_athletename_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 265, 165, 20], 'Callback', @searchathletenameCustom_benchmark, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'String', '');
set(handles.Search_athletename_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Search for an athlete');

%---create list races
handles.AthleteRace_list_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'Listbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 60, 165, 200], 'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4, 'max', 1, 'min', 1, ...
    'Callback', @listRaceName_benchmark, 'String', '', 'Tooltipstring', 'Select a race');
% set(handles.CurrentFolder_list_analyser, 'fontunits', 'normalized');

%---create search race
handles.Search_racename_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 35, 165, 20], 'Callback', @searchathleterace_benchmark, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', font4, 'String', '');
set(handles.Search_racename_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Search for a race');

%---Sorting options
sortingList = {'No sorting';'Sort by time';'Sort by date'};
if ispc == 1;
    handles.sortOptionCustomRanking_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 5, 165, 20], 'string', sortingList, 'callback', @popsortingtypeRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.sortOptionCustomRanking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Select sorting option');
    
elseif ismac == 1;
    handles.sortOptionCustomRanking_benchmark = uicontrol('parent', handles.SelectPerformanceCustom_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 5, 165, 20], 'string', sortingList, 'callback', @popsortingtypeRanking_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font4);
    set(handles.sortOptionCustomRanking_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Select sorting option');
end;

%---create add icone
handles.AddFile_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [78, 60, 30, 30], 'callback', @addRaceList_benchmark, 'cdata', imresize(handles.icones.plus_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.AddFile_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Add a race');

%---Delete all
handles.ClearCustom_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [116, 60, 30, 30], 'callback', @clearCustom_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearCustom_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Clear selection');

%---create save icone
handles.saveComparison_button_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [42, 60, 30, 30], 'callback', @saveTemplateComp_benchmark, 'cdata', imresize(handles.icones.save_onb, [45 45]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.saveComparison_button_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Save this comparison');


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------















%--------------------------------Profile-----------------------------------
%--------------------------------------------------------------------------
%---create swimmer selection panel button
handles.SelectSwimmerProfile_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 530, 175, 85], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select a swimmer', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectSwimmerProfile_benchmark, 'fontunits', 'normalized');

if ispc == 1;
    handles.SelectAthleteProfile_benchmark = uicontrol('parent', handles.SelectSwimmerProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 40, 165, 20], 'string', handles.AthleteNamesList, 'callback', @popSwimmerProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAthleteProfile_benchmark, 'fontunits', 'normalized');
    
elseif ismac == 1;
    handles.SelectAthleteProfile_benchmark = uicontrol('parent', handles.SelectSwimmerProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 40, 165, 20], 'string', handles.AthleteNamesList, 'callback', @popSwimmerProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAthleteProfile_benchmark, 'fontunits', 'normalized');
end;

handles.SearchAthleteProfile_benchmark = uicontrol('parent', handles.SelectSwimmerProfile_benchmark, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 10, 165, 20], 'Callback', @searchAthleteProfile_benchmark, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', '');
set(handles.SearchAthleteProfile_benchmark, 'fontunits', 'normalized');





%---create performance selection panel button
handles.SelectRaceProfile_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 345, 175, 175], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select an event', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectRaceProfile_benchmark, 'fontunits', 'normalized');

if ispc == 1;
    handles.SelectDistanceProfileList_benchmark = {'Distance';'50m';'100m';'150m';'200m';'400m';'800m';'1500m'};
    handles.SelectDistanceProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 130, 165, 20], 'string', handles.SelectDistanceProfileList_benchmark, 'callback', @popDistanceProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectDistanceProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectStrokeProfileList_benchmark = {'Stroke';'Butterfly';'Backstroke';'Breaststroke';'Freestyle';'Medley'};
    handles.SelectStrokeProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 100, 165, 20], 'string', handles.SelectStrokeProfileList_benchmark, 'callback', @popStrokeProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectStrokeProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectPoolProfileList_benchmark = {'Pool type';'LCM';'SCM'};
    handles.SelectPoolProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 70, 165, 20], 'string', handles.SelectPoolProfileList_benchmark, 'callback', @popPoolProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPoolProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectSpartaProfileList_benchmark = {'System';'Any';'GreenEye';'Sparta 1';'Sparta 2'};
    handles.SelectSpartaProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 40, 165, 20], 'string', handles.SelectSpartaProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSpartaProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectPerfProfileList_benchmark = {'Race';'PB';'SB'};
    handles.SelectPerfProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 10, 165, 20], 'string', handles.SelectPerfProfileList_benchmark, 'callback', @popPerfProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPerfProfile_benchmark, 'fontunits', 'normalized');
    
elseif ismac == 1;
    
    handles.SelectDistanceProfileList_benchmark = {'Distance';'50m';'100m';'150m';'200m';'400m';'800m';'1500m'};
    handles.SelectDistanceProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 130, 165, 20], 'string', handles.SelectDistanceProfileList_benchmark, 'callback', @popDistanceProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectDistanceProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectStrokeProfileList_benchmark = {'Stroke';'Butterfly';'Backstroke';'Breaststroke';'Freestyle';'IM'};
    handles.SelectStrokeProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 100, 165, 20], 'string', handles.SelectStrokeProfileList_benchmark, 'callback', @popStrokeProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectStrokeProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectPoolProfileList_benchmark = {'Pool type';'LCM';'SCM'};
    handles.SelectPoolProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 70, 165, 20], 'string', handles.SelectPoolProfileList_benchmark, 'callback', @popPoolProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPoolProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectSpartaProfileList_benchmark = {'System';'Any';'Sparta 1';'Sparta 2'};
    handles.SelectSpartaProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 40, 165, 20], 'string', handles.SelectSpartaProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSpartaProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectPerfProfileList_benchmark = {'Race';'PB';'SB'};
    handles.SelectPerfProfile_benchmark = uicontrol('parent', handles.SelectRaceProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 10, 165, 20], 'string', handles.SelectPerfProfileList_benchmark, 'callback', @popPerfProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPerfProfile_benchmark, 'fontunits', 'normalized');
end;



%---create poulation selection panel button
handles.SelectPopulationProfile_benchmark = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'off', 'units', 'pixels', ...
    'position', [5, 105, 175, 235], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Select a group', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.SelectPopulationProfile_benchmark, 'fontunits', 'normalized');

handles.SelectCountryProfileList_benchmark = {'Country';'Any';'Australian';'International'};
handles.SelectSeasonProfileList_benchmark = {'Season';'Any';'----  Cycle  ----';'Paris 2024 cycle';'Tokyo 2021 cycle';'----  Season  ----';'2022-2023';'2021-2022';'2020-2021';'2019-2020';'2018-2019';'2017-2018';'2016-2017'};
handles.SelectSimilarityProfileList_benchmark = {'Similarity';'All';'Similar race profile'};
handles.SelectAgeProfileList_benchmark = {'Age Group';'Open';'18y';'17y';'16y';'15y';'14y';'13y & under'};
handles.SelectAgeProfileList2_benchmark = {'Age Group';'Open';'19y';'18y';'17y';'16y';'15y';'14y'};
handles.SelectPBProfileList_benchmark = {'Performance';'PBs Only';'All'};
if ispc == 1;
    handles.SelectCountryProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 190, 165, 20], 'string', handles.SelectCountryProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectCountryProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectSeasonProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 160, 165, 20], 'string', handles.SelectSeasonProfileList_benchmark, 'callback', @popSeasonProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSeasonProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectSimilarityProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 130, 165, 20], 'string', handles.SelectSimilarityProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSimilarityProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectPBProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 100, 165, 20], 'string', handles.SelectPBProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPBProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectAgeProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 70, 165, 20], 'string', handles.SelectAgeProfileList_benchmark, 'callback', @popAgeProfile_benchmark, ...
        'BackgroundColor', [0.3 0.3 0.3], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAgeProfile_benchmark, 'fontunits', 'normalized');
    
elseif ismac == 1;
    handles.SelectCountryProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 190, 165, 20], 'string', handles.SelectCountryProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectCountryProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectSeasonProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 160, 165, 20], 'string', handles.SelectSeasonProfileList_benchmark, 'callback', @popSeasonProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSeasonProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectSimilarityProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 130, 165, 20], 'string', handles.SelectSimilarityProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectSimilarityProfile_benchmark, 'fontunits', 'normalized');
    
    handles.SelectPBProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 100, 165, 20], 'string', handles.SelectPBProfileList_benchmark, 'callback', '', ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectPBProfile_benchmark, 'fontunits', 'normalized');

    handles.SelectAgeProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [5, 70, 165, 20], 'string', handles.SelectAgeProfileList_benchmark, 'callback', @popAgeProfile_benchmark, ...
        'BackgroundColor', [1 1 1], 'ForegroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
    set(handles.SelectAgeProfile_benchmark, 'fontunits', 'normalized');
end;

%---Create checkbox inferior or equal age
handles.strictAgeProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 40, 85, 20], 'value', 0, 'callback', @checkstrictAgeProfile_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'Strict Age');
set(handles.strictAgeProfile_benchmark, 'fontunits', 'normalized');
handles.belowAgeProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [90, 40, 80, 20], 'value', 0, 'callback', @checkbelowAgeProfile_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'Include <');
set(handles.belowAgeProfile_benchmark, 'fontunits', 'normalized');

%---Create checkbox FINA/SAL
handles.finaRulesProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 10, 85, 20], 'value', 0, 'callback', @checkFinaProfile_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'FINA Age');
set(handles.finaRulesProfile_benchmark, 'fontunits', 'normalized');
handles.salRulesProfile_benchmark = uicontrol('parent', handles.SelectPopulationProfile_benchmark, 'Style', 'Checkbox', 'Visible', 'on', 'units', 'pixels', ...
    'position', [90, 10, 80, 20], 'value', 0, 'callback', @checkSalProfile_benchmark, 'enable', 'off', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'String', 'SA Age');
set(handles.salRulesProfile_benchmark, 'fontunits', 'normalized');


%---create remove all and validate icons
handles.ClearSearchProfile_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [55, 70, 25, 25], 'callback', @clearSearchProfile_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ClearSearchProfile_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Clear selection');

handles.ValidateSearchProfile_benchmark = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Pushbutton', 'Visible', 'off', 'units', 'pixels', ...
    'position', [95, 70, 25, 25], 'callback', @validateSearchProfile_benchmark, 'cdata', imresize(handles.icones.validate_offb, [40 40]), ...
    'BackgroundColor', [0.26 0.26 0.26], 'ForegroundColor', [0.26 0.26 0.26], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1+4, 'String', '');
set(handles.ValidateSearchProfile_benchmark, 'fontunits', 'normalized', 'Tooltipstring', 'Clear selection');




%---Create main and secondary axes
handles.MainProfile_benchmark = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [200, 30, 1050, 605], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.ProfileBKG1);
uistack(handles.MainProfile_benchmark, 'bottom');



%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%---hide axes
% set(allchild(handles.Question_button_benchmark), 'Visible', 'off');
% set(allchild(handles.Save_button_benchmark), 'Visible', 'off');
% set(allchild(handles.Reportpdf_button_benchmark), 'Visible', 'off');
% set(allchild(handles.Arrowback_button_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearSearchRanking_benchmark), 'Visible', 'off');
% set(allchild(handles.ValidateSearchRanking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
% set(allchild(handles.ClearSearchProfile_benchmark), 'Visible', 'off');
% set(allchild(handles.ValidateSearchProfile_benchmark), 'Visible', 'off');
set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');




%---reset the units
set(handles.Question_button_benchmark, 'units', 'normalized');
set(handles.Save_button_benchmark, 'units', 'normalized');
set(handles.Reportpdf_button_benchmark, 'units', 'normalized');
set(handles.Download_button_benchmark, 'units', 'normalized');
set(handles.Refreshcloud_button_benchmark, 'units', 'normalized');
set(handles.Arrowback_button_benchmark, 'units', 'normalized');
set(handles.ranking_toggle_benchmark, 'units', 'normalized');
set(handles.profile_toggle_benchmark, 'units', 'normalized');
set(handles.trend_toggle_benchmark, 'units', 'normalized');
set(handles.typeRankingTop10_benchmark, 'units', 'normalized');
set(handles.typeRankingCustom_benchmark, 'units', 'normalized');
set(handles.SelectRaceRanking_benchmark, 'units', 'normalized');
set(handles.SelectGenderRanking_benchmark, 'units', 'normalized')
set(handles.SelectStrokeRanking_benchmark, 'units', 'normalized');
set(handles.SelectDistanceRanking_benchmark, 'units', 'normalized');
set(handles.SelectPoolRanking_benchmark, 'units', 'normalized');
set(handles.SelectCategoryRanking_benchmark, 'units', 'normalized');
set(handles.SelectMeetRanking_benchmark, 'units', 'normalized');
set(handles.SelectRoundRanking_benchmark, 'units', 'normalized');
set(handles.SelectTypeRanking_benchmark, 'units', 'normalized');
set(handles.SelectAgeRanking_benchmark, 'units', 'normalized');
set(handles.strictAgeRanking_benchmark, 'units', 'normalized');
set(handles.belowAgeRanking_benchmark, 'units', 'normalized');
set(handles.finaRulesRanking_benchmark, 'units', 'normalized');
set(handles.salRulesRanking_benchmark, 'units', 'normalized');
set(handles.SelectDataRanking_benchmark, 'units', 'normalized');
set(handles.SelectDatasetRanking_benchmark, 'units', 'normalized');
set(handles.SelectPBRanking_benchmark, 'units', 'normalized');
set(handles.SelectSwimmerRanking_benchmark, 'units', 'normalized');
set(handles.SelectAthleteRanking_benchmark, 'units', 'normalized');
set(handles.SearchAthleteRanking_benchmark, 'units', 'normalized');
set(handles.SelectAddAthleteRanking_benchmark, 'units', 'normalized');
set(handles.SearchAddAthleteRanking_benchmark, 'units', 'normalized');
set(handles.SelectSeasonRanking_benchmark, 'units', 'normalized');
set(handles.SelectSpartaRanking_benchmark, 'units', 'normalized');
set(handles.SelectCountryProfile_benchmark, 'units', 'normalized');
set(handles.SelectPBProfile_benchmark, 'units', 'normalized');
set(handles.strictAgeProfile_benchmark, 'units', 'normalized');
set(handles.belowAgeProfile_benchmark, 'units', 'normalized');
set(handles.finaRulesProfile_benchmark, 'units', 'normalized');
set(handles.displayTurnsRanking_benchmark, 'units', 'normalized');
set(handles.salRulesProfile_benchmark, 'units', 'normalized');
set(handles.ClearSearchRanking_benchmark, 'units', 'normalized');
set(handles.ValidateSearchRanking_benchmark, 'units', 'normalized');
set(handles.SelectPerformanceCustom_benchmark, 'units', 'normalized');
set(handles.LoadComparisonCustomRanking_benchmark, 'units', 'normalized');
set(handles.AthleteName_list_benchmark, 'units', 'normalized');
set(handles.Search_athletename_benchmark, 'units', 'normalized');
set(handles.AthleteRace_list_benchmark, 'units', 'normalized');
set(handles.Search_racename_benchmark, 'units', 'normalized');
set(handles.sortOptionCustomRanking_benchmark, 'units', 'normalized');
set(handles.AddFile_button_benchmark, 'units', 'normalized');
set(handles.ClearCustom_button_benchmark, 'units', 'normalized');
set(handles.deleteTemplateCustom_button_benchmark, 'units', 'normalized');
set(handles.saveComparison_button_benchmark, 'units', 'normalized');
set(handles.top20SelectionCustom_button_benchmark, 'units', 'normalized');
set(handles.MainRanking_benchmark, 'units', 'normalized');
set(handles.SecondaryRanking_benchmark, 'units', 'normalized');
set(handles.ClearRace1Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace2Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace3Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace4Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace5Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace6Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace7Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace8Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace9Ranking_benchmark, 'units', 'normalized');
set(handles.ClearRace10Ranking_benchmark, 'units', 'normalized');
set(handles.SelectSwimmerProfile_benchmark, 'units', 'normalized');
set(handles.SelectAthleteProfile_benchmark, 'units', 'normalized');
set(handles.SearchAthleteProfile_benchmark, 'units', 'normalized');
set(handles.SelectRaceProfile_benchmark, 'units', 'normalized');
set(handles.SelectDistanceProfile_benchmark, 'units', 'normalized');
set(handles.SelectStrokeProfile_benchmark, 'units', 'normalized');
set(handles.SelectPoolProfile_benchmark, 'units', 'normalized');
set(handles.SelectPerfProfile_benchmark, 'units', 'normalized');
set(handles.SelectPopulationProfile_benchmark, 'units', 'normalized');
set(handles.SelectAgeProfile_benchmark, 'units', 'normalized');
set(handles.SelectSpartaProfile_benchmark, 'units', 'normalized');
set(handles.SelectCountryRanking_benchmark, 'units', 'normalized');
set(handles.SelectSeasonProfile_benchmark, 'units', 'normalized');
set(handles.SelectSimilarityProfile_benchmark, 'units', 'normalized');
set(handles.ClearSearchProfile_benchmark, 'units', 'normalized');
set(handles.ValidateSearchProfile_benchmark, 'units', 'normalized');
set(handles.MainProfile_benchmark, 'units', 'normalized');

