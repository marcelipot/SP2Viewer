P1 = get(handles.Question_button_database, 'position');
% P2 = get(handles.Downloaddata_button_database, 'position');
P3 = get(handles.Downloadraw_button_database, 'position');
P4 = get(handles.Downloadbenchmark_button_database, 'position');
P5 = get(handles.Downloadall_button_database, 'position');
P6 = get(handles.Downloadnew_button_database, 'position');
P7 = get(handles.Downloadselect_button_database, 'position');
P8 = get(handles.Arrowback_button_database, 'position');
P9 = get(handles.Validate_button_database, 'position');
P10 = get(handles.Redcross_button_database, 'position');
% P11 = get(handles.Downloadpeople_button_database, 'position');
P12 = get(handles.DownloadAMS_button_database, 'position');


%---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_database); imshow(handles.icones.question_onb);
%     drawnow;
% end;

%---create download data icone
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Downloaddata_button_database); imshow(handles.icones.downloaddata_onb);
% %     drawnow;
% end;

%---create download raw icone
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Downloadraw_button_database); imshow(handles.icones.downloadraw_onb);
%     drawnow;
% end;

%---create download benchmark benchmark icon
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     axes(handles.Downloadbenchmark_button_database); imshow(handles.icones.downloadbenchmark_onb);
%     drawnow;
% end;

%---create download benchmark benchmark icon
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     axes(handles.DownloadAMS_button_database); imshow(handles.icones.AMS_onb);
%     drawnow;
% end;


%---create download all
% if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
%     axes(handles.Downloadall_button_database); imshow(handles.icones.cloudall_onb);
%     drawnow;
% end;

%---create download new
% if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
%     axes(handles.Downloadnew_button_database); imshow(handles.icones.cloudnew_onb);
%     drawnow;
% end;

%---create download selected
% if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
%     axes(handles.Downloadselect_button_database); imshow(handles.icones.cloudselect_onb);
%     drawnow;
% end;

%---create arrow back icone
% if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
%     axes(handles.Arrowback_button_database); imshow(handles.icones.arrow_back_onb);
%     drawnow;
% end;

%---create validate icone
% if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
%     axes(handles.Validate_button_database); imshow(handles.icones.validate_onb);
%     drawnow;
% end;

%---create clear icone
% if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
%     axes(handles.Redcross_button_database); imshow(handles.icones.redcross_onb);
%     drawnow;
% end;

% %---create download people icon
% if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
%     axes(handles.Downloadpeople_button_database); imshow(handles.icones.people_onb);
%     
% end;