P1 = get(handles.Question_button_benchmark, 'position');
P2 = get(handles.Save_button_benchmark, 'position');
P3 = get(handles.Arrowback_button_benchmark, 'position');
P4 = get(handles.ClearSearchRanking_benchmark, 'position');
P5 = get(handles.ValidateSearchRanking_benchmark, 'position');
P6 = get(handles.ClearSearchProfile_benchmark, 'position');
P7 = get(handles.ValidateSearchProfile_benchmark, 'position');
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

% %---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_benchmark); imshow(handles.icones.question_onb);
% %     drawnow;
% end;
% 
% %---Save button down
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Save_button_benchmark); imshow(handles.icones.downloaddata_onb);
% %     drawnow;
% end;
% 
% %---pdf sparta report button down
% if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
%     axes(handles.Reportpdf_button_benchmark); imshow(handles.icones.report_onb);
% %     drawnow;
% end;
% 
% %---Back button down
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Arrowback_button_benchmark); imshow(handles.icones.arrow_back_onb);
% %     drawnow;
% end;
% 
% %---Clear Ranking
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearSearchRanking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Validate Ranking
% if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ValidateSearchRanking_benchmark); imshow(handles.icones.validate_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Clear Profile
% if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
%     if handles.currentBenchmarkToggle == 2;
%         axes(handles.ClearSearchProfile_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Validate Profile
% if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
%     if handles.currentBenchmarkToggle == 2;
%         axes(handles.ValidateSearchProfile_benchmark); imshow(handles.icones.validate_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 1
% if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace1Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 2
% if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace2Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 3
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace3Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 4
% if pt(1,1) >= P13(1,1) & pt(1,1) <= (P13(1,1)+P13(1,3)) & pt(1,2) >= P13(1,2) & pt(1,2) <= (P13(1,2)+P13(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace4Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 5
% if pt(1,1) >= P14(1,1) & pt(1,1) <= (P14(1,1)+P14(1,3)) & pt(1,2) >= P14(1,2) & pt(1,2) <= (P14(1,2)+P14(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace5Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 6
% if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace6Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 7
% if pt(1,1) >= P16(1,1) & pt(1,1) <= (P16(1,1)+P16(1,3)) & pt(1,2) >= P16(1,2) & pt(1,2) <= (P16(1,2)+P16(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace7Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 8
% if pt(1,1) >= P17(1,1) & pt(1,1) <= (P17(1,1)+P17(1,3)) & pt(1,2) >= P17(1,2) & pt(1,2) <= (P17(1,2)+P17(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace8Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 9
% if pt(1,1) >= P18(1,1) & pt(1,1) <= (P18(1,1)+P18(1,3)) & pt(1,2) >= P18(1,2) & pt(1,2) <= (P18(1,2)+P18(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace9Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Remove Race 10
% if pt(1,1) >= P19(1,1) & pt(1,1) <= (P19(1,1)+P19(1,3)) & pt(1,2) >= P19(1,2) & pt(1,2) <= (P19(1,2)+P19(1,4));
%     if handles.currentBenchmarkToggle == 1;
%         axes(handles.ClearRace10Ranking_benchmark); imshow(handles.icones.redcross_onb);
%     end;
% %     drawnow;
% end;


