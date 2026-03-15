%---Logo AARGOS
AARGOS_logo_P1;
AARGOS_logo_P2;
AARGOS_logo_P3;
logo_AARGOS(:,:,1) = reshape(A, 295, 329);
logo_AARGOS(:,:,2) = reshape(B, 295, 329);
logo_AARGOS(:,:,3) = reshape(C, 295, 329);
handles.icones.logo_AARGOS = uint8(logo_AARGOS);
clear A B C logo_AARGOS

%---Logo SAL
SAL_logo_P1;
SAL_logo_P2;
SAL_logo_P3;
logo_SAL(:,:,1) = reshape(A, 221, 901);
logo_SAL(:,:,2) = reshape(B, 221, 901);
logo_SAL(:,:,3) = reshape(C, 221, 901);
handles.icones.logo_SAL = uint8(logo_SAL);
clear A B C logo_analysis

%---Logo SPARTA
SPARTA_logo_P1;
SPARTA_logo_P2;
SPARTA_logo_P3;
logo_SPARTA(:,:,1) = reshape(A, 1000, 1000);
logo_SPARTA(:,:,2) = reshape(B, 1000, 1000);
logo_SPARTA(:,:,3) = reshape(C, 1000, 1000);
handles.icones.logo_SPARTA = uint8(logo_SPARTA);
clear A B C logo_SPARTA

%---Logo Analyser
Analyser_logo_P1;
Analyser_logo_P2;
Analyser_logo_P3;
logo_Analyser(:,:,1) = reshape(A, 1000, 1000);
logo_Analyser(:,:,2) = reshape(B, 1000, 1000);
logo_Analyser(:,:,3) = reshape(C, 1000, 1000);
handles.icones.logo_Analyser = uint8(logo_Analyser);
clear A B C logo_Analyser

%---Logo Databaser
Database_logo_P1;
Database_logo_P2;
Database_logo_P3;
logo_Database(:,:,1) = reshape(A, 1000, 1000);
logo_Database(:,:,2) = reshape(B, 1000, 1000);
logo_Database(:,:,3) = reshape(C, 1000, 1000);
handles.icones.logo_Database = uint8(logo_Database);
clear A B C logo_Database

%---fullscreen icones
fullscreen_offb_P1;
fullscreen_offb_P2;
fullscreen_offb_P3;
fullscreen_offb(:,:,1) = reshape(A, 200, 200);
fullscreen_offb(:,:,2) = reshape(B, 200, 200);
fullscreen_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.fullscreen_offb = uint8(fullscreen_offb);
clear A B C fullscreen_offb

fullscreen_onb_P1;
fullscreen_onb_P2;
fullscreen_onb_P3;
fullscreen_onb(:,:,1) = reshape(A, 200, 200);
fullscreen_onb(:,:,2) = reshape(B, 200, 200);
fullscreen_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.fullscreen_onb = uint8(fullscreen_onb);
clear A B C fullscreen_onb

%---question icones
arrow_back_offb_P1;
arrow_back_offb_P2;
arrow_back_offb_P3;
arrow_back_offb(:,:,1) = reshape(A, 200, 200);
arrow_back_offb(:,:,2) = reshape(B, 200, 200);
arrow_back_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.arrow_back_offb = uint8(arrow_back_offb);
clear A B C arrow_back_offb

arrow_back_onb_P1;
arrow_back_onb_P2;
arrow_back_onb_P3;
arrow_back_onb(:,:,1) = reshape(A, 200, 200);
arrow_back_onb(:,:,2) = reshape(B, 200, 200);
arrow_back_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.arrow_back_onb = uint8(arrow_back_onb);
clear A B C arrow_back_onb

%---search icones
search_offb_P1;
search_offb_P2;
search_offb_P3;
search_offb(:,:,1) = reshape(A, 200, 200);
search_offb(:,:,2) = reshape(B, 200, 200);
search_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.search_offb = uint8(search_offb);
clear A B C search_offb

search_onb_P1;
search_onb_P2;
search_onb_P3;
search_onb(:,:,1) = reshape(A, 200, 200);
search_onb(:,:,2) = reshape(B, 200, 200);
search_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.search_onb = uint8(search_onb);
clear A B C search_onb

%---reset icones
reset_offb_P1;
reset_offb_P2;
reset_offb_P3;
reset_offb(:,:,1) = reshape(A, 200, 200);
reset_offb(:,:,2) = reshape(B, 200, 200);
reset_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.reset_offb = uint8(reset_offb);
clear A B C reset_offb

reset_onb_P1;
reset_onb_P2;
reset_onb_P3;
reset_onb(:,:,1) = reshape(A, 200, 200);
reset_onb(:,:,2) = reshape(B, 200, 200);
reset_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.reset_onb = uint8(reset_onb);
clear A B C reset_onb

%---question icones
question_offb_P1;
question_offb_P2;
question_offb_P3;
question_offb(:,:,1) = reshape(A, 200, 200);
question_offb(:,:,2) = reshape(B, 200, 200);
question_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.question_offb = uint8(question_offb);
clear A B C question_offb

question_onb_P1;
question_onb_P2;
question_onb_P3;
question_onb(:,:,1) = reshape(A, 200, 200);
question_onb(:,:,2) = reshape(B, 200, 200);
question_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.question_onb = uint8(question_onb);
clear A B C question_onb

downloadbenchmark_onb_P1;
downloadbenchmark_onb_P2;
downloadbenchmark_onb_P3;
downloadbenchmark_onb(:,:,1) = reshape(A, 200, 200);
downloadbenchmark_onb(:,:,2) = reshape(B, 200, 200);
downloadbenchmark_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.downloadbenchmark_onb = uint8(downloadbenchmark_onb);
clear A B C downloadbenchmark_onb

%---minus icones
minus_offb_P1;
minus_offb_P2;
minus_offb_P3;
minus_offb(:,:,1) = reshape(A, 200, 200);
minus_offb(:,:,2) = reshape(B, 200, 200);
minus_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.minus_offb = uint8(minus_offb);
clear A B C minus_offb

minus_onb_P1;
minus_onb_P2;
minus_onb_P3;
minus_onb(:,:,1) = reshape(A, 200, 200);
minus_onb(:,:,2) = reshape(B, 200, 200);
minus_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.minus_onb = uint8(minus_onb);
clear A B C minus_onb

%---plus icones
plus_offb_P1;
plus_offb_P2;
plus_offb_P3;
plus_offb(:,:,1) = reshape(A, 200, 200);
plus_offb(:,:,2) = reshape(B, 200, 200);
plus_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.plus_offb = uint8(plus_offb);
clear A B C plus_offb

plus_onb_P1;
plus_onb_P2;
plus_onb_P3;
plus_onb(:,:,1) = reshape(A, 200, 200);
plus_onb(:,:,2) = reshape(B, 200, 200);
plus_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.plus_onb = uint8(plus_onb);
clear A B C plus_onb

%---redcross icones
redcross_offb_P1;
redcross_offb_P2;
redcross_offb_P3;
redcross_offb(:,:,1) = reshape(A, 200, 200);
redcross_offb(:,:,2) = reshape(B, 200, 200);
redcross_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.redcross_offb = uint8(redcross_offb);
clear A B C redcross_offb

redcross_onb_P1;
redcross_onb_P2;
redcross_onb_P3;
redcross_onb(:,:,1) = reshape(A, 200, 200);
redcross_onb(:,:,2) = reshape(B, 200, 200);
redcross_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.redcross_onb = uint8(redcross_onb);
clear A B C redcross_onb

%---validate icones
validate_offb_P1;
validate_offb_P2;
validate_offb_P3;
validate_offb(:,:,1) = reshape(A, 200, 200);
validate_offb(:,:,2) = reshape(B, 200, 200);
validate_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.validate_offb = uint8(validate_offb);
clear A B C validate_offb

validate_onb_P1;
validate_onb_P2;
validate_onb_P3;
validate_onb(:,:,1) = reshape(A, 200, 200);
validate_onb(:,:,2) = reshape(B, 200, 200);
validate_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.validate_onb = uint8(validate_onb);
clear A B C validate_onb

%---save icones
downloaddata_offb_P1;
downloaddata_offb_P2;
downloaddata_offb_P3;
downloaddata_offb(:,:,1) = reshape(A, 200, 200);
downloaddata_offb(:,:,2) = reshape(B, 200, 200);
downloaddata_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.downloaddata_offb = uint8(downloaddata_offb);
clear A B C downloaddata_offb

downloaddata_onb_P1;
downloaddata_onb_P2;
downloaddata_onb_P3;
downloaddata_onb(:,:,1) = reshape(A, 200, 200);
downloaddata_onb(:,:,2) = reshape(B, 200, 200);
downloaddata_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.downloaddata_onb = uint8(downloaddata_onb);
clear A B C downloaddata_onb

%---download raw icones
downloadraw_offb_P1;
downloadraw_offb_P2;
downloadraw_offb_P3;
downloadraw_offb(:,:,1) = reshape(A, 200, 200);
downloadraw_offb(:,:,2) = reshape(B, 200, 200);
downloadraw_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.downloadraw_offb = uint8(downloadraw_offb);
clear A B C downloadraw_offb

downloadraw_onb_P1;
downloadraw_onb_P2;
downloadraw_onb_P3;
downloadraw_onb(:,:,1) = reshape(A, 200, 200);
downloadraw_onb(:,:,2) = reshape(B, 200, 200);
downloadraw_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.downloadraw_onb = uint8(downloadraw_onb);
clear A B C downloadraw_onb

%---download Benchmark icones
downloadbenchmark_offb_P1;
downloadbenchmark_offb_P2;
downloadbenchmark_offb_P3;
downloadbenchmark_offb(:,:,1) = reshape(A, 200, 200);
downloadbenchmark_offb(:,:,2) = reshape(B, 200, 200);
downloadbenchmark_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.downloadbenchmark_offb = uint8(downloadbenchmark_offb);
clear A B C downloadbenchmark_offb

%---start icones
start_offb_P1;
start_offb_P2;
start_offb_P3;
start_offb(:,:,1) = reshape(A, 200, 800);
start_offb(:,:,2) = reshape(B, 200, 800);
start_offb(:,:,3) = reshape(C, 200, 800);
handles.icones.start_offb = uint8(start_offb);
clear A B C start_offb

start_onb_P1;
start_onb_P2;
start_onb_P3;
start_onb(:,:,1) = reshape(A, 200, 800);
start_onb(:,:,2) = reshape(B, 200, 800);
start_onb(:,:,3) = reshape(C, 200, 800);
handles.icones.start_onb = uint8(start_onb);
clear A B C start_onb

%---pause icones
pause_offb_P1;
pause_offb_P2;
pause_offb_P3;
pause_offb(:,:,1) = reshape(A, 200, 200);
pause_offb(:,:,2) = reshape(B, 200, 200);
pause_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.pause_offb = uint8(pause_offb);
clear A B C pause_offb

pause_onb_P1;
pause_onb_P2;
pause_onb_P3;
pause_onb(:,:,1) = reshape(A, 200, 200);
pause_onb(:,:,2) = reshape(B, 200, 200);
pause_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.pause_onb = uint8(pause_onb);
clear A B C pause_onb

%---play icones
play_offb_P1;
play_offb_P2;
play_offb_P3;
play_offb(:,:,1) = reshape(A, 200, 200);
play_offb(:,:,2) = reshape(B, 200, 200);
play_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.play_offb = uint8(play_offb);
clear A B C play_offb

play_onb_P1;
play_onb_P2;
play_onb_P3;
play_onb(:,:,1) = reshape(A, 200, 200);
play_onb(:,:,2) = reshape(B, 200, 200);
play_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.play_onb = uint8(play_onb);
clear A B C play_onb

%---precedentchap icones
precedentimage_offb_P1;
precedentimage_offb_P2;
precedentimage_offb_P3;
precedentimage_offb(:,:,1) = reshape(A, 200, 200);
precedentimage_offb(:,:,2) = reshape(B, 200, 200);
precedentimage_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.precedentimage_offb = uint8(precedentimage_offb);
clear A B C precedentimage_offb

precedentimage_onb_P1;
precedentimage_onb_P2;
precedentimage_onb_P3;
precedentimage_onb(:,:,1) = reshape(A, 200, 200);
precedentimage_onb(:,:,2) = reshape(B, 200, 200);
precedentimage_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.precedentimage_onb = uint8(precedentimage_onb);
clear A B C precedentimage_onb

%---precedentchap icones
precedentchap_offb_P1;
precedentchap_offb_P2;
precedentchap_offb_P3;
precedentchap_offb(:,:,1) = reshape(A, 200, 200);
precedentchap_offb(:,:,2) = reshape(B, 200, 200);
precedentchap_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.precedentchap_offb = uint8(precedentchap_offb);
clear A B C precedentchap_offb

precedentchap_onb_P1;
precedentchap_onb_P2;
precedentchap_onb_P3;
precedentchap_onb(:,:,1) = reshape(A, 200, 200);
precedentchap_onb(:,:,2) = reshape(B, 200, 200);
precedentchap_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.precedentchap_onb = uint8(precedentchap_onb);
clear A B C precedentchap_onb

%---Stop icones
stop_offb_P1;
stop_offb_P2;
stop_offb_P3;
stop_offb(:,:,1) = reshape(A, 200, 200);
stop_offb(:,:,2) = reshape(B, 200, 200);
stop_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.stop_offb = uint8(stop_offb);
clear A B C stop_offb

stop_onb_P1;
stop_onb_P2;
stop_onb_P3;
stop_onb(:,:,1) = reshape(A, 200, 200);
stop_onb(:,:,2) = reshape(B, 200, 200);
stop_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.stop_onb = uint8(stop_onb);
clear A B C stop_onb

%---Suivant icones
suivant_offb_P1;
suivant_offb_P2;
suivant_offb_P3;
suivant_offb(:,:,1) = reshape(A, 200, 200);
suivant_offb(:,:,2) = reshape(B, 200, 200);
suivant_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.suivant_offb = uint8(suivant_offb);
clear A B C suivant_offb

suivant_onb_P1;
suivant_onb_P2;
suivant_onb_P3;
suivant_onb(:,:,1) = reshape(A, 200, 200);
suivant_onb(:,:,2) = reshape(B, 200, 200);
suivant_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.suivant_onb = uint8(suivant_onb);
clear A B C suivant_onb

%---Suivantchap icones
suivantchap_offb_P1;
suivantchap_offb_P2;
suivantchap_offb_P3;
suivantchap_offb(:,:,1) = reshape(A, 200, 200);
suivantchap_offb(:,:,2) = reshape(B, 200, 200);
suivantchap_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.suivantchap_offb = uint8(suivantchap_offb);
clear A B C suivantchap_offb

suivantchap_onb_P1;
suivantchap_onb_P2;
suivantchap_onb_P3;
suivantchap_onb(:,:,1) = reshape(A, 200, 200);
suivantchap_onb(:,:,2) = reshape(B, 200, 200);
suivantchap_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.suivantchap_onb = uint8(suivantchap_onb);
clear A B C suivantchap_onb

%---cloud all icones
cloudall_offb_P1;
cloudall_offb_P2;
cloudall_offb_P3;
cloudall_offb(:,:,1) = reshape(A, 200, 200);
cloudall_offb(:,:,2) = reshape(B, 200, 200);
cloudall_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.cloudall_offb = uint8(cloudall_offb);
clear A B C cloudall_offb

cloudall_onb_P1;
cloudall_onb_P2;
cloudall_onb_P3;
cloudall_onb(:,:,1) = reshape(A, 200, 200);
cloudall_onb(:,:,2) = reshape(B, 200, 200);
cloudall_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.cloudall_onb = uint8(cloudall_onb);
clear A B C cloudall_onb

%---cloud new icones
cloudnew_offb_P1;
cloudnew_offb_P2;
cloudnew_offb_P3;
cloudnew_offb(:,:,1) = reshape(A, 200, 200);
cloudnew_offb(:,:,2) = reshape(B, 200, 200);
cloudnew_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.cloudnew_offb = uint8(cloudnew_offb);
clear A B C cloudnew_offb

cloudnew_onb_P1;
cloudnew_onb_P2;
cloudnew_onb_P3;
cloudnew_onb(:,:,1) = reshape(A, 200, 200);
cloudnew_onb(:,:,2) = reshape(B, 200, 200);
cloudnew_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.cloudnew_onb = uint8(cloudnew_onb);
clear A B C cloudnew_onb

%---cloud select icones
cloudselect_offb_P1;
cloudselect_offb_P2;
cloudselect_offb_P3;
cloudselect_offb(:,:,1) = reshape(A, 200, 200);
cloudselect_offb(:,:,2) = reshape(B, 200, 200);
cloudselect_offb(:,:,3) = reshape(C, 200, 200);
handles.icones.cloudselect_offb = uint8(cloudselect_offb);
clear A B C cloudselect_offb

cloudselect_onb_P1;
cloudselect_onb_P2;
cloudselect_onb_P3;
cloudselect_onb(:,:,1) = reshape(A, 200, 200);
cloudselect_onb(:,:,2) = reshape(B, 200, 200);
cloudselect_onb(:,:,3) = reshape(C, 200, 200);
handles.icones.cloudselect_onb = uint8(cloudselect_onb);
clear A B C cloudselect_onb


