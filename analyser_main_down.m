P1 = get(handles.Question_button_analyser, 'position');
P2 = get(handles.Save_button_analyser, 'position');
P3 = get(handles.Download_button_analyser, 'position');
P4 = get(handles.Arrowback_button_analyser, 'position');
P5 = get(handles.AddFile_button_analyser, 'position');
P6 = get(handles.RemoveFile_button_analyser, 'position');
P7 = get(handles.RemoveAllFile_button_analyser, 'position');
% P8 = get(handles.Reset_button_analyser, 'position');
% P9 = get(handles.Search_button_analyser, 'position');
P10 = get(handles.Fullscreen_button_analyser, 'position');
P11 = get(handles.Precedentchap_button_analyser, 'position');
P12 = get(handles.Precedentimage_button_analyser, 'position');
P13 = get(handles.Stop_button_analyser, 'position');
P14 = get(handles.Play_button_analyser, 'position');
P15 = get(handles.Suivantimage_button_analyser, 'position');
P16 = get(handles.Suivantchap_button_analyser, 'position');
P17 = get(handles.Reportpdf_button_analyser, 'position');

% %---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_analyser); imshow(handles.icones.question_onb);
% %     drawnow;
% end;
% 
% %---Save button down
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Save_button_analyser); imshow(handles.icones.downloaddata_onb);
% %     drawnow;
% end;
% 
% %---Download button down
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Download_button_analyser); imshow(handles.icones.downloadraw_onb);
% %     drawnow;
% end;
% 
% %---Full screen button down
% if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
%     axes(handles.Fullscreen_button_analyser); imshow(handles.icones.fullscreen_onb);
% %     drawnow;
% end;
% 
% %---Back button down
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     axes(handles.Arrowback_button_analyser); imshow(handles.icones.arrow_back_onb);
% %     drawnow;
% end;
% 
% %---Add File button down
% if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
%     axes(handles.AddFile_button_analyser); imshow(handles.icones.plus_onb);
% %     drawnow;
% end;
% 
% %---Remove File button down
% if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
%     axes(handles.RemoveFile_button_analyser); imshow(handles.icones.minus_onb);
% %     drawnow;
% end;
% 
% %---Remove All Files button down
% if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
%     axes(handles.RemoveAllFile_button_analyser); imshow(handles.icones.redcross_onb);
% %     drawnow;
% end;

% %---Reset button down
% if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
%     axes(handles.Reset_button_analyser); imshow(handles.icones.reset_onb);
% %     drawnow;
% end;
% 
% %---Search button down
% if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
%     axes(handles.Search_button_analyser); imshow(handles.icones.search_onb);
% %     drawnow;
% end;
% 
% %---Precentchap button down
% if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
%     axes(handles.Precedentchap_button_analyser); imshow(handles.icones.precedentchap_onb);
% %     drawnow;
% end;
% 
% %---Precentimage button down
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     axes(handles.Precedentimage_button_analyser); imshow(handles.icones.precedentimage_onb);
% %     drawnow;
% end;
% 
% %---Stop button down
% if pt(1,1) >= P13(1,1) & pt(1,1) <= (P13(1,1)+P13(1,3)) & pt(1,2) >= P13(1,2) & pt(1,2) <= (P13(1,2)+P13(1,4));
%     axes(handles.Stop_button_analyser); imshow(handles.icones.stop_onb);
% %     drawnow;
% end;
% 
% %---Play button down
% if pt(1,1) >= P14(1,1) & pt(1,1) <= (P14(1,1)+P14(1,3)) & pt(1,2) >= P14(1,2) & pt(1,2) <= (P14(1,2)+P14(1,4));
%     StatusEC = get(handles.AminationStatus_analyser, 'String');
%     if strcmpi(StatusEC, 'Play') == 0;
%         %the video is stopped and now launched
%         axes(handles.Play_button_analyser); imshow(handles.icones.play_onb);
%     else;
%         %the video is running and now stopped
%         axes(handles.Play_button_analyser); imshow(handles.icones.pause_onb);
%     end;
% %     drawnow;
% end;
% 
% %---Suivantimage button down
% if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
%     axes(handles.Suivantimage_button_analyser); imshow(handles.icones.suivant_onb);
% %     drawnow;
% end;
% 
% %---suivantchap button up
% if pt(1,1) >= P16(1,1) & pt(1,1) <= (P16(1,1)+P16(1,3)) & pt(1,2) >= P16(1,2) & pt(1,2) <= (P16(1,2)+P16(1,4));
%     axes(handles.Suivantchap_button_analyser); imshow(handles.icones.suivantchap_onb);
% %     drawnow;
% end;
% 
% %---Report pdf button down
% if pt(1,1) >= P17(1,1) & pt(1,1) <= (P17(1,1)+P17(1,3)) & pt(1,2) >= P17(1,2) & pt(1,2) <= (P17(1,2)+P17(1,4));
%     axes(handles.Reportpdf_button_analyser); imshow(handles.icones.report_onb);
% %     drawnow;
% end;
