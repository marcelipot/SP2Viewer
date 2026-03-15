P1 = get(handles.Question_button_benchmark, 'position');
P2 = get(handles.Save_button_benchmark, 'position');
P3 = get(handles.Arrowback_button_benchmark, 'position');
P4 = get(handles.ClearSearchRanking_benchmark, 'position');
P5 = get(handles.ValidateSearchRanking_benchmark, 'position');
P6 = get(handles.ClearSearchProfile_benchmark, 'position');
P7 = get(handles.ValidateSearchProfile_benchmark, 'position');
P8 = get(handles.MainProfile_benchmark, 'position');
P9 = get(handles.Reportpdf_button_benchmark, 'position');
P10 = get(handles.ClearRace1Ranking_benchmark, 'Position');
P11 = get(handles.ClearRace2Ranking_benchmark, 'Position');
P12 = get(handles.ClearRace3Ranking_benchmark, 'Position');
P13 = get(handles.ClearRace4Ranking_benchmark, 'Position');
P14 = get(handles.ClearRace5Ranking_benchmark, 'Position');
P15 = get(handles.ClearRace6Ranking_benchmark, 'Position');
P16 = get(handles.ClearRace7Ranking_benchmark, 'Position');
P17 = get(handles.ClearRace8Ranking_benchmark, 'Position');
P18 = get(handles.ClearRace9Ranking_benchmark, 'Position');
P19 = get(handles.ClearRace10Ranking_benchmark, 'Position');


%---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_benchmark); imshow(handles.icones.question_offb);
% %     drawnow;
%     create_glossary;
% end;

%---Save button down
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Save_button_benchmark); imshow(handles.icones.downloaddata_offb);
% %     drawnow;
%     if handles.currentBenchmarkToggle == 1;
%         saveDisplayRankings_benchmark;
%     elseif handles.currentBenchmarkToggle == 2;
%         saveDisplayProfile_benchmark;
%     else;
%         return;
%     end;
% end;


%---pdf sparta report button down
% if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
%     axes(handles.Reportpdf_button_benchmark); imshow(handles.icones.report_offb);
% %     drawnow;
%     if handles.currentBenchmarkToggle == 1;
%         saveSP1pdf_rankings_benchmark;
%     elseif handles.currentBenchmarkToggle == 2;
%         saveSP1pdf_profile_benchmark;
%     else;
%         return;
%     end;
% end;


%---Back button down
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Arrowback_button_benchmark); imshow(handles.icones.arrow_back_offb);
% 
% %     set(allchild(handles.Question_button_benchmark), 'Visible', 'off');
% %     set(allchild(handles.Save_button_benchmark), 'Visible', 'off');
% %     set(allchild(handles.Reportpdf_button_benchmark), 'Visible', 'off');
% %     set(allchild(handles.Arrowback_button_benchmark), 'Visible', 'off');
% %     set(allchild(handles.ClearSearchRanking_benchmark), 'Visible', 'off');
% %     set(allchild(handles.ValidateSearchRanking_benchmark), 'Visible', 'off');
%     set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
%     set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');
% 
%     set(handles.Question_button_benchmark, 'Visible', 'off');
%     set(handles.Save_button_benchmark, 'Visible', 'off');
%     set(handles.Reportpdf_button_benchmark, 'Visible', 'off');
%     set(handles.Download_button_benchmark, 'Visible', 'off');
%     set(handles.Arrowback_button_benchmark, 'Visible', 'off');
%     set(handles.ClearSearchRanking_benchmark, 'Visible', 'off');
%     set(handles.ValidateSearchRanking_benchmark, 'Visible', 'off');
%     set(handles.MainRanking_benchmark, 'Visible', 'off');
%     set(handles.SecondaryRanking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
%     set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');
% 
%     try;
%         [li, co] = size(handles.txtMainRanking);
%         for i = 1:li;
%             for j = 1:co;
%                 delete(handles.txtMainRanking{i,j});
%             end;
%         end;
%         handles.txtMainRanking = {};
%     end;
%     try;
%         [li, co] = size(handles.txtSecondaryRanking);
%         for i = 1:li;
%             for j = 1:co;
%                 delete(handles.txtSecondaryRanking{i,j});
%             end;
%         end;
%         handles.txtSecondaryRanking = {};
%     end;
% %     set(allchild(handles.ClearSearchProfile_benchmark), 'Visible', 'off');
% %     set(allchild(handles.ValidateSearchProfile_benchmark), 'Visible', 'off');
% 
%     set(handles.ClearSearchProfile_benchmark, 'Visible', 'off');
%     set(handles.ValidateSearchProfile_benchmark, 'Visible', 'off');
% 
%     try;
%         [li, co] = size(handles.txtMainProfile);
%         for i = 1:li;
%             for j = 1:co;
%                 delete(handles.txtMainProfile{i,j});
%             end;
%         end;
%         handles.txtMainProfile = {};
%     end;
%     set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');
%     
%     set(handles.ranking_toggle_benchmark, 'Visible', 'off');
%     set(handles.profile_toggle_benchmark, 'Visible', 'off');
%     set(handles.trend_toggle_benchmark, 'Visible', 'off');
%     set(handles.SelectRaceRanking_benchmark, 'Visible', 'off');
%     set(handles.SelectDataRanking_benchmark, 'Visible', 'off');
%     set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'off');
%     set(handles.SelectSwimmerProfile_benchmark, 'Visible', 'off');
%     set(handles.SelectRaceProfile_benchmark, 'Visible', 'off');
%     set(handles.SelectPopulationProfile_benchmark, 'Visible', 'off');
%     
%     %---Show axes welcome
%     set(handles.logo_sparta_main, 'Visible', 'on');
%     set(allchild(handles.logo_sparta_main), 'Visible', 'on');
%     set(handles.logo_sparta_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_analyser_main, 'Visible', 'on');
%     set(allchild(handles.logo_analyser_main), 'Visible', 'on');
%     set(handles.logo_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_database_main, 'Visible', 'on');
%     set(allchild(handles.logo_database_main), 'Visible', 'on');
%     set(handles.logo_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.logo_benchmark_main, 'Visible', 'on');
%     set(allchild(handles.logo_benchmark_main), 'Visible', 'on');
%     set(handles.logo_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_analyser_main, 'Visible', 'on');
% %     set(allchild(handles.start_analyser_main), 'Visible', 'on');
% %     set(handles.start_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_database_main, 'Visible', 'on');
% %     set(allchild(handles.start_database_main), 'Visible', 'on');
% %     set(handles.start_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     set(handles.start_benchmark_main, 'Visible', 'on');
% %     set(allchild(handles.start_benchmark_main), 'Visible', 'on');
% %     set(handles.start_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
%     uistack(handles.logo_sparta_main, 'top');
%     uistack(handles.logo_analyser_main, 'top');
%     uistack(handles.logo_database_main, 'top');
%     uistack(handles.logo_benchmark_main, 'top');
%     uistack(handles.start_analyser_main, 'top');
%     uistack(handles.start_database_main, 'top');
%     uistack(handles.start_benchmark_main, 'top');
%     
%     %---Show uicontrols welcome
%     set(handles.txtlasupdate_main, 'Visible', 'on');
%     set(handles.txtsoftwareversion_main, 'Visible', 'on');
%     set(handles.txtwelcome_main, 'Visible', 'on');
%     set(handles.txtlogo_analyser_main, 'Visible', 'on');
%     set(handles.txtlogo_database_main, 'Visible', 'on');
%     set(handles.txtlogo_benchmark_main, 'Visible', 'on');
%     set(handles.tasktodo_main, 'Visible', 'on');
%     set(handles.txtlasupdate_main, 'String', ['Database last update: ' handles.LastUpdate]);
% 
%     set(handles.txtpage, 'string', 'Welcome');
%     
% end;

%---Clear Ranking
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearSearchRanking_benchmark); imshow(handles.icones.redcross_offb);
% 
%         set(handles.SelectGenderRanking_benchmark, 'value', 1);
%         set(handles.SelectStrokeRanking_benchmark, 'value', 1);
%         set(handles.SelectDistanceRanking_benchmark, 'value', 1);
%         set(handles.SelectPoolRanking_benchmark, 'value', 1);
%         set(handles.SelectCategoryRanking_benchmark, 'value', 1);
%         set(handles.SelectAgeRanking_benchmark, 'value', 1);
%         set(handles.SelectDatasetRanking_benchmark, 'value', 1);
%         set(handles.SelectPBRanking_benchmark, 'value', 1);
%         set(handles.SelectMeetRanking_benchmark, 'value', 1);
%         set(handles.SelectTypeRanking_benchmark, 'value', 1);
%         set(handles.SelectSeasonRanking_benchmark, 'value', 1);
%         set(handles.SelectCountryRanking_benchmark, 'value', 1);
%         set(handles.SelectSpartaRanking_benchmark, 'value', 1);
%         set(handles.SelectRoundRanking_benchmark, 'value', 1);
%         set(handles.SelectAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
%         set(handles.SearchAthleteRanking_benchmark, 'String', '');
% 
%         set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');
% 
%         set(handles.salRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
%         set(handles.finaRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
%         set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
%         set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
%         handles.selectAgeLimRanking_benchmark = 0;
%         handles.selectAgeRulesRanking_benchmark = 0;
%         handles.addPerfRanking = [];
%         handles.addPerfProfile = [];
%         handles.existRankings = 0;
% 
%         handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
%         set(handles.SelectAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
%         set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', 1);
%     end;
% % set(handles.txtSecondaryRanking,'Fontunits','normalized');
% %     get(handles.txtSecondaryRanking,'Fontsize')
% end;

%---Validate Ranking
% if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ValidateSearchRanking_benchmark); imshow(handles.icones.validate_offb);
% 
%         set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
%         set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');
%         set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');
%         drawnow;
% 
%         listSeason = get(handles.SelectSeasonRanking_benchmark, 'String');
%         valSeason = get(handles.SelectSeasonRanking_benchmark, 'Value');
%         SeasonEC = listSeason{valSeason};
% 
%         sourceRankings = 'new';
%         filter_ranking_benchmark;
%         sort_ranking_benchmark;
% 
%         handles.existRankings = 1;
%     end;
% end;

%---Clear Profile
if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
    if handles.currentBenchmarkToggle == 2;
        axes(handles.ClearSearchProfile_benchmark); imshow(handles.icones.redcross_offb);

        set(handles.SelectAthleteProfile_benchmark, 'Value', 1);
        set(handles.SearchAthleteProfile_benchmark, 'String', '');
        set(handles.SelectDistanceProfile_benchmark, 'Value', 1);
        set(handles.SelectStrokeProfile_benchmark, 'Value', 1);
        set(handles.SelectPoolProfile_benchmark, 'Value', 1);
        handles.SelectPerfProfileList_benchmark = {'Race';'PB';'SB'};
        set(handles.SelectPerfProfile_benchmark, 'Value', 1, 'String', handles.SelectPerfProfileList_benchmark);
        set(handles.SelectCountryProfile_benchmark, 'Value', 1);
        set(handles.SelectAgeProfile_benchmark, 'Value', 1);

        set(handles.salRulesProfile_benchmark, 'Value', 0, 'enable', 'off');
        set(handles.finaRulesProfile_benchmark, 'Value', 0, 'enable', 'off');
        set(handles.strictAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
        set(handles.belowAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
        handles.selectAgeLimProfile_benchmark = 0;
        handles.selectAgeRulesProfile_benchmark = 0;

        try;
            [li, co] = size(handles.txtMainProfile_ID);
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
        set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');

        handles.existProfile = 0;
        handles.AthleteNamesListDispProfile = handles.AthleteNamesList;
        set(handles.SelectAthleteProfile_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
        set(handles.SelectAgeProfile_benchmark, 'String', handles.SelectAgeProfileList_benchmark, 'Value', 1);
    end;
end;

%---Validate Profile
% if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
%     if handles.currentBenchmarkToggle == 2;
%         axes(handles.ValidateSearchProfile_benchmark); imshow(handles.icones.validate_offb);
% 
%         %default display Best
%         graphType = 1;
%         imcolormap = handles.icones.histColormap;
%         imcolormap2 = handles.icones.histColormap2;
% 
%         sourceSort = 'initial';
%         RaceOption = 'Element';
%         
%         valStroke = get(handles.SelectStrokeProfile_benchmark, 'Value');
%         SearchStroke = handles.SelectStrokeProfileList_benchmark{valStroke};
%         if strcmpi(SearchStroke, 'Medley'); 
%             LegOption = 'All Legs';
%         else;
%             LegOption = '';
%         end;
%         seasonOption = 0;
%         handles.racetimeSpiderOption = 0;
%         handles.swimspeedSpiderOption = 0;
%         handles.speeddecaySpiderOption = 0;
%         handles.strokeindexSpiderOption = 0;
%         handles.swimspeedSpiderOption = 0;
%         handles.skilltimeSpiderOption = 0;
%         handles.starttimeSpiderOption = 0;
%         handles.turntimeSpiderOption = 0;
%         
%         updateSBchoice = 1;
%         filter_profile_benchmark;
%         sort_profile_benchmark;
%         if returnval ~= 1;
%             handles.existProfile = 1;
%             handles.graphType = graphType;
%             handles.seasonOption = 0;
%             try;
%                 handles.databaseGroup = databaseGroup;
%             end;
%             handles.databaseCurrent = databaseCurrent;
%         end;
%     end;
% end;


%---Next top (best, top 3, top 8, select)
if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
    
    if handles.currentBenchmarkToggle == 2;
        pt = get(gcf, 'CurrentPoint');
        pt_act = [pt(1,1)-P8(1,1) pt(1,2)-P8(1,2)];

        ImageXlim = xlim(handles.MainProfile_benchmark);
        ImageYlim = ylim(handles.MainProfile_benchmark);
        H = ImageYlim(2) - ImageYlim(1);
        W = ImageXlim(2) - ImageXlim(1);
        set(gcf, 'units', 'pixels');
        posFig = get(gcf, 'position');
        set(gcf, 'units', 'normalized');
        P8b = [P8(1).*posFig(3) P8(2).*posFig(4) P8(3).*posFig(3) P8(2).*posFig(4)];

        limL = (P8b(1,3)-W)/2;
        limR = limL+W;
        limD = (P8b(1,4)-H)/2;
        limT = limD+H;

        if limL >= 0 & limD >= 0;
            %The image fit to the screen or the image size is increased

            %identify which axe will be the limitating one
            Hlimtest1 = P8(1,4);
            ratioWH = W./H;
            Wlimtest1 = Hlimtest1.*ratioWH;

            Wlimtest2 = P8(1,3);
            ratioHW = H./W;
            Hlimtest2 = Wlimtest2.*ratioHW;

            if Wlimtest1 >= P8(1,3);
                %The limitating axe will be the horizontal one
                limL = 0;
                limR = P8(1,3);
                Wnew = P8(1,3);

                ratioHW = H./W;
                Hnew = Wnew.*ratioHW;
                limD = (P8(1,4)-Hnew)/2;
                limT = limD+Hnew;
            else;
                if Hlimtest2 >= P8(1,4);
                    %The limitating axe is the vertical one
                    limD = 0;
                    limT = P8(1,4);
                    Hnew = P8(1,4);

                    ratioWH = W./H;
                    Wnew = Hnew.*ratioWH;
                    limL = (P8(1,3)-Wnew)/2;
                    limR = limL+Wnew;
                end;
            end;
        else;
            %The image doesn't fit to the screen and the image size is decreased
            if limD < 0 & limL >= 0;
                %the limitating axe is the vertical one
                limD = 0;
                limT = P8(1,4);
                Hnew = P8(1,4);

                ratioWH = W./H;
                Wnew = Hnew.*ratioWH;

                limL = (P8(1,3)-Wnew)/2;
                limR = limL+Wnew;

            elseif limD >= 0 & limL < 0;
                %the limitating axe is the horizontal one
                limL = 0;
                limR = P8(1,3);
                Wnew = P8(1,3);

                ratioHW = H./W;
                Hnew = Wnew.*ratioHW;
                limD = (P8(1,4)-Hnew)/2;
                limT = limD+Hnew;

            elseif limD < 0 & limL < 0;
                if limL > limD;
                    limD = 0;
                    limT = P8(1,4);
                    Hnew = P8(1,4);

                    ratioWH = W./H;
                    Wnew = Hnew.*ratioWH;
                    limL = (P8(1,3)-Wnew)/2;
                    limR = limL+Wnew;
                else;
                    limL = 0;
                    limR = P8(1,3);
                    Wnew = P8(1,3);

                    ratioHW = H./W;
                    Hnew = Wnew.*ratioHW;
                    limD = (P8(1,4)-Hnew)/2;
                    limT = limD+Hnew;
                end;
            end;
        end;

        if pt_act(1,1) >= limL & pt_act(1,1) <= limR & pt_act(1,2) >= limD & pt_act(1,2) <= limT;
            %click within the image
    %         try;
            if handles.currentBenchmarkToggle == 2;
                if handles.existProfile == 1;
                    Tbest = handles.txtMainProfile_HIST{10,1}.Vertices; %top (Best)
                    Telement = handles.txtMainProfile_ID{1,10}.Vertices;
                    Tpb = handles.txtMainProfile_ID{1,8}.Vertices;
                    Tracetime = handles.txtMainProfile_SPIDER{7,1}.Vertices;
                    Tswimspeed = handles.txtMainProfile_SPIDER{7,2}.Vertices;
                    Tstrokeindex = handles.txtMainProfile_SPIDER{7,3}.Vertices;
                    Tspeeddecay = handles.txtMainProfile_SPIDER{7,4}.Vertices;
                    Tskilltime = handles.txtMainProfile_SPIDER{7,5}.Vertices;
                    Tstarttime = handles.txtMainProfile_SPIDER{7,6}.Vertices;
                    Tturntime = handles.txtMainProfile_SPIDER{7,7}.Vertices;
                    if isempty(handles.txtMainProfile_ID{1,11}.String) == 0;
                        Tleg = handles.txtMainProfile_ID{1,12}.Vertices;
                    end;
                    
                    axes_handle = gca;
                    drawnow;
                    pt = get(axes_handle, 'CurrentPoint');
                    pt = pt(1,1:2);

                    limTbestx = [min(Tbest(:,1)) max(Tbest(:,1))];
                    limTbesty = [min(Tbest(:,2)) max(Tbest(:,2))];

                    limTelementx = [min(Telement(:,1)) max(Telement(:,1))];
                    limTelementy = [min(Telement(:,2)) max(Telement(:,2))];

                    limTpbx = [min(Tpb(:,1)) max(Tpb(:,1))];
                    limTpby = [min(Tpb(:,2)) max(Tpb(:,2))];

                    limTracetimex = [min(Tracetime(:,1)) max(Tracetime(:,1))];
                    limTracetimey = [min(Tracetime(:,2)) max(Tracetime(:,2))];
                    limTswimspeedx = [min(Tswimspeed(:,1)) max(Tswimspeed(:,1))];
                    limTswimspeedy = [min(Tswimspeed(:,2)) max(Tswimspeed(:,2))];
                    limTstrokeindexx = [min(Tstrokeindex(:,1)) max(Tstrokeindex(:,1))];
                    limTstrokeindexy = [min(Tstrokeindex(:,2)) max(Tstrokeindex(:,2))];
                    limTspeeddecayx = [min(Tspeeddecay(:,1)) max(Tspeeddecay(:,1))];
                    limTspeeddecayy = [min(Tspeeddecay(:,2)) max(Tspeeddecay(:,2))];
                    limTskilltimex = [min(Tskilltime(:,1)) max(Tskilltime(:,1))];
                    limTskilltimey = [min(Tskilltime(:,2)) max(Tskilltime(:,2))];
                    limTstarttimex = [min(Tstarttime(:,1)) max(Tstarttime(:,1))];
                    limTstarttimey = [min(Tstarttime(:,2)) max(Tstarttime(:,2))];
                    limTturntimex = [min(Tturntime(:,1)) max(Tturntime(:,1))];
                    limTturntimey = [min(Tturntime(:,2)) max(Tturntime(:,2))];
                    if isempty(handles.txtMainProfile_ID{1,11}.String) == 0;
                        limTlegx = [min(Tleg(:,1)) max(Tleg(:,1))];
                        limTlegy = [min(Tleg(:,2)) max(Tleg(:,2))];
                    end;

                    if pt(1) >= limTbestx(1) & pt(1) <= limTbestx(2);
                        if pt(2) >= limTbesty(1) & pt(2) <= limTbesty(2);

                            graphType = handles.graphType + 1;
                            if graphType == 5;
                                graphType = 1;
                            end;
                            if graphType == 4;
                                txtObj = handles.txtMainProfile_HIST{3,1};
                                txtObj.String = 'Select';
                                handles.graphType = graphType;
                            else;
                                imcolormap = handles.icones.histColormap;
                                imcolormap2 = handles.icones.histColormap2;

                                sourceSort = 'initial';
                                if strcmpi(handles.txtMainProfile_ID{1,9}.String, 'Element');
                                    RaceOption = 'Element';
                                else;
                                    RaceOption = 'Race';
                                end;
                                LegOption = handles.txtMainProfile_ID{1,11}.String;
                                
                                updateSBchoice = 1;
                                filter_profile_benchmark;
                                sort_profile_benchmark;
                                handles.graphType = graphType;
                            end;

                        end;
                    end;
                    if isempty(handles.txtMainProfile_ID{1,11}.String) == 0;
                        if pt(1) >= limTlegx(1) & pt(1) <= limTlegx(2);
                            if pt(2) >= limTlegy(1) & pt(2) <= limTlegy(2);

                                graphType = handles.graphType;
                                if graphType == 4;
                                    txtObj = handles.txtMainProfile_HIST{3,1};
                                    txtObj.String = 'Select';
                                    handles.graphType = graphType;
                                else;
                                    imcolormap = handles.icones.histColormap;
                                    imcolormap2 = handles.icones.histColormap2;

                                    sourceSort = 'initial';
                                    if strcmpi(handles.txtMainProfile_ID{1,9}.String, 'Element');
                                        RaceOption = 'Element';
                                    else;
                                        RaceOption = 'Race';
                                    end;
                                    if strcmpi(handles.txtMainProfile_ID{1,11}.String, 'All Legs') == 1;
                                        LegOption = 'Butterfly Only';
                                    elseif strcmpi(handles.txtMainProfile_ID{1,11}.String, 'Butterfly Only') == 1;
                                        LegOption = 'Backstroke Only';
                                    elseif strcmpi(handles.txtMainProfile_ID{1,11}.String, 'Backstroke Only') == 1;
                                        LegOption = 'Breaststroke Only';
                                    elseif strcmpi(handles.txtMainProfile_ID{1,11}.String, 'Breaststroke Only') == 1;
                                        LegOption = 'Freestyle Only';
                                    elseif strcmpi(handles.txtMainProfile_ID{1,11}.String, 'Freestyle Only') == 1;
                                        LegOption = 'All Legs';
                                    else;
                                        LegOption = '';
                                    end;

                                    updateSBchoice = 0;
                                    filter_profile_benchmark;
                                    sort_profile_benchmark;
                                    handles.graphType = graphType;
                                end;
                            end;
                        end;
                    end;
                    if pt(1) >= limTelementx(1) & pt(1) <= limTelementx(2);
                        if pt(2) >= limTelementy(1) & pt(2) <= limTelementy(2);

                            graphType = handles.graphType;
                            if graphType == 4;
                                txtObj = handles.txtMainProfile_HIST{3,1};
                                txtObj.String = 'Select';
                                handles.graphType = graphType;
                            else;
                                imcolormap = handles.icones.histColormap;
                                imcolormap2 = handles.icones.histColormap2;

                                sourceSort = 'initial';
                                if strcmpi(handles.txtMainProfile_ID{1,9}.String, 'Element');
                                    RaceOption = 'Race';
                                else;
                                    RaceOption = 'Element';
                                end;
                                LegOption = handles.txtMainProfile_ID{1,11}.String;
                                
                                updateSBchoice = 1;
                                filter_profile_benchmark;
                                sort_profile_benchmark;
                                handles.graphType = graphType;
                            end;
                        end;
                    end;

                    if pt(1) >= limTpbx(1) & pt(1) <= limTpbx(2);
                        if pt(2) >= limTpby(1) & pt(2) <= limTpby(2);
                            seasonOption = handles.seasonOption + 1;
                            if seasonOption == 5;
                                seasonOption = 0;
                            end;
                            updateSBchoice = 1;
                            updateSB;
                            handles.seasonOption = seasonOption;
                        end;
                    end;

                    if pt(1) >= limTracetimex(1) & pt(1) <= limTracetimex(2);
                        if pt(2) >= limTracetimey(1) & pt(2) <= limTracetimey(2);
                            handles.racetimeSpiderOption = handles.racetimeSpiderOption + 1;
                            if handles.racetimeSpiderOption == 3;
                                handles.racetimeSpiderOption = 0;
                            end;

                            if handles.racetimeSpiderOption == 0;
                                val = num2str(100 - handles.rankRaceTime);
                                if strcmpi(val, '100');
                                    val = {'Race Time'; 'Best'};
                                else;
                                    val = {'Race Time'; ['Top ' val '%']};
                                end;
                            elseif handles.racetimeSpiderOption == 1;
                                val = num2str(handles.posRaceTime);
                                val = {'Race Time'; ['Pos : ' ...
                                    val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                            else;
                                val = {'Race Time'; ...
                                    ['Val : ' timeSecToStr(handles.diff2bestRaceTime(2))]};
                            end;
                        end;
                        handles.txtMainProfile_SPIDER{6,1}.String = val;
                    end;

                    if pt(1) >= limTswimspeedx(1) & pt(1) <= limTswimspeedx(2);
                        if pt(2) >= limTswimspeedy(1) & pt(2) <= limTswimspeedy(2);
                            handles.swimspeedSpiderOption = handles.swimspeedSpiderOption + 1;
                            if handles.swimspeedSpiderOption == 3;
                                handles.swimspeedSpiderOption = 0;
                            end;

                            if handles.swimspeedSpiderOption == 0;
                                val = num2str(100 - handles.rankSwimSpeedelement);
                                if strcmpi(val, '100');
                                    val = {'Swim Speed'; 'Best'};
                                else;
                                    val = {'Swim Speed'; ['Top ' val '%']};
                                end;
                                pos = handles.txtMainProfile_SPIDER{6,2}.Position;
                                pos(1) = pos(1) - 7;
                                handles.txtMainProfile_SPIDER{6,2}.Position = pos;
                            elseif handles.swimspeedSpiderOption == 1;
                                val = num2str(handles.posSwimSpeedelement);
                                val = {'Swim Speed'; ['Pos : ' ...
                                    val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                            else;
                                val = dataToStr(handles.diff2bestSwimSpeedelement(2),2);
                                val = {'Swim Speed'; ['Val : ' val ' m/s']};
                                pos = handles.txtMainProfile_SPIDER{6,2}.Position;
                                pos(1) = pos(1) + 7;
                                handles.txtMainProfile_SPIDER{6,2}.Position = pos;
                            end;
                            handles.txtMainProfile_SPIDER{6,2}.String = val;
                        end;
                    end;

                    if pt(1) >= limTstrokeindexx(1) & pt(1) <= limTstrokeindexx(2);
                        if pt(2) >= limTstrokeindexy(1) & pt(2) <= limTstrokeindexy(2);
                            handles.strokeindexSpiderOption = handles.strokeindexSpiderOption + 1;
                            if handles.strokeindexSpiderOption == 3;
                                handles.strokeindexSpiderOption = 0;
                            end;

                            if handles.strokeindexSpiderOption == 0;
                                val = num2str(100 - handles.rankStrokeEffelement);
                                if strcmpi(val, '100');
                                    val = {'Stroke Index'; 'Best'};
                                else;
                                    val = {'Stroke Index'; ['Top ' val '%']};
                                end;
                                pos = handles.txtMainProfile_SPIDER{6,3}.Position;
                                pos(1) = pos(1) - 17;
                                handles.txtMainProfile_SPIDER{6,3}.Position = pos;
                            elseif handles.strokeindexSpiderOption == 1;
                                val = num2str(handles.posStrokeEffelement);
                                val = {'Stroke Index'; ['Pos : ' ...
                                    val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                            else;
                                val = dataToStr(handles.diff2bestStrokeEffelement(2),2);
                                val = {'Stroke Index'; ['Val : ' val ' m2/s/str']};
                                pos = handles.txtMainProfile_SPIDER{6,3}.Position;
                                pos(1) = pos(1) + 17;
                                handles.txtMainProfile_SPIDER{6,3}.Position = pos;
                            end;
                            handles.txtMainProfile_SPIDER{6,3}.String = val;
                        end;
                    end;

                    if pt(1) >= limTspeeddecayx(1) & pt(1) <= limTspeeddecayx(2);
                        if pt(2) >= limTspeeddecayy(1) & pt(2) <= limTspeeddecayy(2);
                            handles.speeddecaySpiderOption = handles.speeddecaySpiderOption + 1;
                            if handles.speeddecaySpiderOption == 3;
                                handles.speeddecaySpiderOption = 0;
                            end;

                            if handles.speeddecaySpiderOption == 0;
                                val = num2str(100 - handles.rankSpeedDecayelement);
                                if strcmpi(val, '100');
                                    val = {'Speed Decay'; 'Best'};
                                else;
                                    val = {'Speed Decay'; ['Top ' val '%']};
                                end;
                                pos = handles.txtMainProfile_SPIDER{6,4}.Position;
                                pos(1) = pos(1) - 7;
                                handles.txtMainProfile_SPIDER{6,4}.Position = pos;
                            elseif handles.speeddecaySpiderOption == 1;
                                val = num2str(handles.posSpeedDecayelement);
                                val = {'Speed Decay'; ['Pos : ' ... 
                                    val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                            else;
                                val = dataToStr(handles.diff2bestSpeedDecayelement(2).*100,2);
                                val = {'Speed Decay'; ['Val : ' val ' %']};
                                pos = handles.txtMainProfile_SPIDER{6,4}.Position;
                                pos(1) = pos(1) + 7;
                                handles.txtMainProfile_SPIDER{6,4}.Position = pos;
                            end;
                            handles.txtMainProfile_SPIDER{6,4}.String = val;
                        end;
                    end;

                    if pt(1) >= limTskilltimex(1) & pt(1) <= limTskilltimex(2);
                        if pt(2) >= limTskilltimey(1) & pt(2) <= limTskilltimey(2);
                            handles.skilltimeSpiderOption = handles.skilltimeSpiderOption + 1;
                            if handles.skilltimeSpiderOption == 3;
                                handles.skilltimeSpiderOption = 0;
                            end;

                            if handles.skilltimeSpiderOption == 0;
                                val = num2str(100 - handles.rankSkillTimeelement);
                                if strcmpi(val, '100');
                                    val = {'Skill Time'; 'Best'};
                                else;
                                    val = {'Skill Time'; ['Top ' val '%']};
                                end;
                            elseif handles.skilltimeSpiderOption == 1;
                                val = num2str(handles.posSkillTimeelement);
                                val = {'Skill Time'; ['Pos : ' ...
                                    val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                            else;
                                val = {'Skill Time'; ...
                                    ['Val : ' timeSecToStr(handles.diff2bestSkillTimeelement(2))]};
                            end;
                            handles.txtMainProfile_SPIDER{6,5}.String = val;
                        end;
                    end;

                    if pt(1) >= limTstarttimex(1) & pt(1) <= limTstarttimex(2);
                        if pt(2) >= limTstarttimey(1) & pt(2) <= limTstarttimey(2);
                            handles.starttimeSpiderOption = handles.starttimeSpiderOption + 1;
                            if handles.starttimeSpiderOption == 3;
                                handles.starttimeSpiderOption = 0;
                            end;

                            if handles.starttimeSpiderOption == 0;
                                val = num2str(100 - handles.rankStartTimeelement);
                                if strcmpi(val, '100');
                                    val = {'Start Time'; 'Best'};
                                else;
                                    val = {'Start Time'; ['Top ' val '%']};
                                end;
                            elseif handles.starttimeSpiderOption == 1;
                                val = num2str(handles.posStartTimeelement);
                                val = {'Start Time'; ['Pos : ' ...
                                    val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                            else;
                                val = {'Start Time'; ...
                                    ['Val : ' timeSecToStr(handles.diff2bestStartTimeelement(2))]};
                            end;
                            handles.txtMainProfile_SPIDER{6,6}.String = val;
                        end;
                    end;

                    if pt(1) >= limTturntimex(1) & pt(1) <= limTturntimex(2);
                        if pt(2) >= limTturntimey(1) & pt(2) <= limTturntimey(2);
                            valDistance = get(handles.SelectDistanceProfile_benchmark, 'Value');
                            valPool = get(handles.SelectPoolProfile_benchmark, 'Value');
                            SearchDistance = handles.SelectDistanceProfileList_benchmark{valDistance};
                            SearchPool = handles.SelectPoolProfileList_benchmark(valPool);
                            if strcmpi(SearchPool, 'LCM');
                                SearchPool = '50';
                            elseif strcmpi(SearchPool, 'SCM');
                                SearchPool = '25';
                            end;
                            if SearchPool == 50;
                                if strcmpi(SearchDistance, '50m');
                                    turnexist = 0;
                                else;
                                    turnexist = 1;
                                end;
                            else;
                                turnexist = 1;
                            end;

                            if turnexist == 1;
                                handles.turntimeSpiderOption = handles.turntimeSpiderOption + 1;
                                if handles.turntimeSpiderOption == 3;
                                    handles.turntimeSpiderOption = 0;
                                end;
                                if handles.turntimeSpiderOption == 0;
                                    val = num2str(100 - handles.rankTurnTimeelement);
                                    if strcmpi(val, '100');
                                        val = {'Turn Time'; 'Best'};
                                    else;
                                        val = {'Turn Time'; ['Top ' val '%']};
                                    end;
                                elseif handles.turntimeSpiderOption == 1;
                                    val = num2str(handles.posTurnTimeelement);
                                    val = {'Turn Time'; ['Pos : ' ...
                                        val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                                else;
                                    val = {'Turn Time'; ...
                                        ['Val : ' timeSecToStr(handles.diff2bestTurnTimeelement(2))]};
                                end;

                            else;
                                handles.finishtimeSpiderOption = handles.finishtimeSpiderOption + 1;
                                if handles.turntimeSpiderOption == 3;
                                    handles.turntimeSpiderOption = 0;
                                end;

                                if handles.turntimeSpiderOption == 0;
                                    val = num2str(100 - handles.rankFinishTimeelement);
                                    if strcmpi(val, '100');
                                        val = {'Finish Time'; 'Best'};
                                    else;
                                        val = {'Finish Time'; ['Top ' val '%']};
                                    end;
                                elseif handles.starttimeSpiderOption == 1;
                                    val = num2str(handles.posFinishTimeelement);
                                    val = {'Finish Time'; ['Pos : ' ...
                                        val ' / ' num2str(length(handles.databaseGroup(:,1)))]};
                                else;
                                    val = {'Finish Time'; ...
                                        ['Val : ' timeSecToStr(handles.diff2bestFinishTimeelement(2))]};
                                end;
                            end;
                            handles.txtMainProfile_SPIDER{6,7}.String = val;
                        end;
                    end;

                    if handles.graphType == 4;
                        txtObj = handles.txtMainProfile_HIST{3,1};
                        txtPos = get(txtObj, 'extent');
                        if pt(1) >= txtPos(1) & pt(1) <= txtPos(1)+txtPos(3);
                            if pt(2) <= txtPos(2) & pt(2) >= txtPos(2)-txtPos(4);

                                valDistance = get(handles.SelectDistanceProfile_benchmark, 'Value');
                                SearchDistanceSelect = handles.SelectDistanceProfileList_benchmark{valDistance};
                                SearchDistanceSelect = SearchDistanceSelect(1:end-1);

                                valStroke = get(handles.SelectStrokeProfile_benchmark, 'Value');
                                SearchStrokeSelect = handles.SelectStrokeProfileList_benchmark{valStroke};

                                valPool = get(handles.SelectPoolProfile_benchmark, 'Value');
                                SearchPoolSelect = handles.SelectPoolProfileList_benchmark{valPool};
                                
                                listSeason = get(handles.SelectSeasonProfile_benchmark, 'String');
                                valSeason = get(handles.SelectSeasonProfile_benchmark, 'Value');
                                SeasonEC = listSeason{valSeason};
                                
                                if strcmpi(SearchPoolSelect, 'SCM');
                                    SearchPoolSelect = '25';
                                else;
                                    SearchPoolSelect = '50';
                                end;
                                BenchmarkEvents = handles.BenchmarkEvents;
                                AgeGroup = handles.AgeGroup;
                                source = {'Profile'; 'None'};
                                handles2 = create_selecttool_profile(handles.FullDB, handles.icones, SearchStrokeSelect, SearchDistanceSelect, ...
                                    SearchPoolSelect, SeasonEC, BenchmarkEvents, AgeGroup, source);

                                if isempty(handles2) == 0;
                                    if isfield(handles2, 'SearchPerf') == 1 & isfield(handles2, 'SearchAthlete');
                                        if isempty(handles2.SearchPerf) == 0 & isempty(handles2.SearchAthlete) == 0;
                                            SearchPerfSelect = handles2.SearchPerf;
                                            SearchNameSelect = handles2.SearchAthlete;

                                            imcolormap = handles.icones.histColormap;
                                            imcolormap2 = handles.icones.histColormap2;
                                            sourceSort = 'select';
                                            if strcmpi(handles.txtMainProfile_ID{1,9}.String, 'Element');
                                                RaceOption = 'Race';
                                            else;
                                                RaceOption = 'Element';
                                            end;
                                            graphType = handles.graphType;
                                            filter_profile_benchmark;
                                            sort_profile_benchmark;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
    %         end;
        end;
    end;
end;


% %---Remove Race 1
% if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace1Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [2:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 1;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 2
% if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace2Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1 3:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 2;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 3
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace3Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:2 4:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 3;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 4
% if pt(1,1) >= P13(1,1) & pt(1,1) <= (P13(1,1)+P13(1,3)) & pt(1,2) >= P13(1,2) & pt(1,2) <= (P13(1,2)+P13(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace4Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:3 5:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 4;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 5
% if pt(1,1) >= P14(1,1) & pt(1,1) <= (P14(1,1)+P14(1,3)) & pt(1,2) >= P14(1,2) & pt(1,2) <= (P14(1,2)+P14(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace5Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:4 6:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 5;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 6
% if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace6Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:5 7:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 6;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 7
% if pt(1,1) >= P16(1,1) & pt(1,1) <= (P16(1,1)+P16(1,3)) & pt(1,2) >= P16(1,2) & pt(1,2) <= (P16(1,2)+P16(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace7Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:6 8:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 7;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 8
% if pt(1,1) >= P17(1,1) & pt(1,1) <= (P17(1,1)+P17(1,3)) & pt(1,2) >= P17(1,2) & pt(1,2) <= (P17(1,2)+P17(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace8Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:7 9:length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 8;
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 9
% if pt(1,1) >= P18(1,1) & pt(1,1) <= (P18(1,1)+P18(1,3)) & pt(1,2) >= P18(1,2) & pt(1,2) <= (P18(1,2)+P18(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace9Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:8 length(handles.databaseCurrent_rankings(:,1))];
%         raw2remove = 9; 
%         update_ranking_benchmark;
%     end;
% end;
% 
% %---Remove Race 10
% if pt(1,1) >= P19(1,1) & pt(1,1) <= (P19(1,1)+P19(1,3)) & pt(1,2) >= P19(1,2) & pt(1,2) <= (P19(1,2)+P19(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace10Ranking_benchmark); imshow(handles.icones.redcross_offb);
%     end;
% %     drawnow;
% 
%     if length(handles.databaseCurrent_rankings) > 1;
%         databaseCurrent_rankingsNew = {};
%         list2keep = [1:9];
%         raw2remove = 10;
%         update_ranking_benchmark;
%     end;
% end;
