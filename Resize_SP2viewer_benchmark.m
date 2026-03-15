function [] = Resize_SP2viewer_benchmark(varargin)


handles = guidata(gcf);

%------Analyser
%---Question
set(handles.Question_button_analyser, 'units', 'pixels');
pos = get(handles.Question_button_analyser, 'position');
set(handles.Question_button_analyser, 'cdata', imresize(handles.icones.question_offb, [pos(3) pos(4)]));
set(handles.Question_button_analyser, 'units', 'normalized');

%---PDF
set(handles.Reportpdf_button_analyser, 'units', 'pixels');
pos = get(handles.Reportpdf_button_analyser, 'position');
set(handles.Reportpdf_button_analyser, 'cdata', imresize(handles.icones.saveReport_offb, [pos(3) pos(4)]));
set(handles.Reportpdf_button_analyser, 'units', 'normalized');

%---TAB
set(handles.Save_button_analyser, 'units', 'pixels');
pos = get(handles.Save_button_analyser, 'position');
set(handles.Save_button_analyser, 'cdata', imresize(handles.icones.saveTab_offb, [pos(3) pos(4)]));
set(handles.Save_button_analyser, 'units', 'normalized');

%---RAW
set(handles.Download_button_analyser, 'units', 'pixels');
pos = get(handles.Download_button_analyser, 'position');
set(handles.Download_button_analyser, 'cdata', imresize(handles.icones.saveRaw_offb, [pos(3) pos(4)]));
set(handles.Download_button_analyser, 'units', 'normalized');

%---Full screen
set(handles.Fullscreen_button_analyser, 'units', 'pixels');
pos = get(handles.Fullscreen_button_analyser, 'position');
set(handles.Fullscreen_button_analyser, 'cdata', imresize(handles.icones.fullscreen_offb, [pos(3) pos(4)]));
set(handles.Fullscreen_button_analyser, 'units', 'normalized');

%---Arrow back
set(handles.Arrowback_button_analyser, 'units', 'pixels');
pos = get(handles.Arrowback_button_analyser, 'position');
set(handles.Arrowback_button_analyser, 'cdata', imresize(handles.icones.arrow_back_offb, [pos(3) pos(4)]));
set(handles.Arrowback_button_analyser, 'units', 'normalized');

%---Add Plus
set(handles.AddFile_button_analyser, 'units', 'pixels');
pos = get(handles.AddFile_button_analyser, 'position');
set(handles.AddFile_button_analyser, 'cdata', imresize(handles.icones.plus_offb, [pos(3) pos(4)]));
set(handles.AddFile_button_analyser, 'units', 'normalized');

%---Remove Minus
set(handles.RemoveFile_button_analyser, 'units', 'pixels');
pos = get(handles.RemoveFile_button_analyser, 'position');
set(handles.RemoveFile_button_analyser, 'cdata', imresize(handles.icones.minus_offb, [pos(3) pos(4)]));
set(handles.RemoveFile_button_analyser, 'units', 'normalized');

%---Delete Cross
set(handles.RemoveAllFile_button_analyser, 'units', 'pixels');
pos = get(handles.RemoveAllFile_button_analyser, 'position');
set(handles.RemoveAllFile_button_analyser, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.RemoveAllFile_button_analyser, 'units', 'normalized');


%--------Benchmarks
%---Question
set(handles.Question_button_benchmark, 'units', 'pixels');
pos = get(handles.Question_button_benchmark, 'position');
set(handles.Question_button_benchmark, 'cdata', imresize(handles.icones.question_offb, [pos(3) pos(4)]));
set(handles.Question_button_benchmark, 'units', 'normalized');

%---JPG
set(handles.Save_button_benchmark, 'units', 'pixels');
pos = get(handles.Save_button_benchmark, 'position');
set(handles.Save_button_benchmark, 'cdata', imresize(handles.icones.saveJPG_offb, [pos(3) pos(4)]));
set(handles.Save_button_benchmark, 'units', 'normalized');

%---PDF
set(handles.Reportpdf_button_benchmark, 'units', 'pixels');
pos = get(handles.Reportpdf_button_benchmark, 'position');
set(handles.Reportpdf_button_benchmark, 'cdata', imresize(handles.icones.saveReport_offb, [pos(3) pos(4)]));
set(handles.Reportpdf_button_benchmark, 'units', 'normalized');

%---SEG
set(handles.Download_button_benchmark, 'units', 'pixels');
pos = get(handles.Download_button_benchmark, 'position');
set(handles.Download_button_benchmark, 'cdata', imresize(handles.icones.saveSeg_offb, [pos(3) pos(4)]));
set(handles.Download_button_benchmark, 'units', 'normalized');

%---Full screen
set(handles.Refreshcloud_button_benchmark, 'units', 'pixels');
pos = get(handles.Refreshcloud_button_benchmark, 'position');
set(handles.Refreshcloud_button_benchmark, 'cdata', imresize(handles.icones.reset_offb, [pos(3) pos(4)]));
set(handles.Refreshcloud_button_benchmark, 'units', 'normalized');

%---Arrow back
set(handles.Arrowback_button_benchmark, 'units', 'pixels');
pos = get(handles.Arrowback_button_benchmark, 'position');
set(handles.Arrowback_button_benchmark, 'cdata', imresize(handles.icones.arrow_back_offb, [pos(3) pos(4)]));
set(handles.Arrowback_button_benchmark, 'units', 'normalized');

%---Clear rankings
set(handles.ClearSearchRanking_benchmark, 'units', 'pixels');
pos = get(handles.ClearSearchRanking_benchmark, 'position');
set(handles.ClearSearchRanking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearSearchRanking_benchmark, 'units', 'normalized');

%---Search rankings
set(handles.ValidateSearchRanking_benchmark, 'units', 'pixels');
pos = get(handles.ValidateSearchRanking_benchmark, 'position');
set(handles.ValidateSearchRanking_benchmark, 'cdata', imresize(handles.icones.validate_offb, [pos(3) pos(4)]));
set(handles.ValidateSearchRanking_benchmark, 'units', 'normalized');

%---Delete template
set(handles.deleteTemplateCustom_button_benchmark, 'units', 'pixels');
pos = get(handles.deleteTemplateCustom_button_benchmark, 'position');
set(handles.deleteTemplateCustom_button_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.deleteTemplateCustom_button_benchmark, 'units', 'normalized');

%---Add file
set(handles.AddFile_button_benchmark, 'units', 'pixels');
pos = get(handles.AddFile_button_benchmark, 'position');
set(handles.AddFile_button_benchmark, 'cdata', imresize(handles.icones.plus_offb, [pos(3) pos(4)]));
set(handles.AddFile_button_benchmark, 'units', 'normalized');

%---clear custom
set(handles.ClearCustom_button_benchmark, 'units', 'pixels');
pos = get(handles.ClearCustom_button_benchmark, 'position');
set(handles.ClearCustom_button_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearCustom_button_benchmark, 'units', 'normalized');

%---Save template
set(handles.saveComparison_button_benchmark, 'units', 'pixels');
pos = get(handles.saveComparison_button_benchmark, 'position');
set(handles.saveComparison_button_benchmark, 'cdata', imresize(handles.icones.save_onb, [pos(3) pos(4)]));
set(handles.saveComparison_button_benchmark, 'units', 'normalized');


%---Clear profile
set(handles.ClearSearchProfile_benchmark, 'units', 'pixels');
pos = get(handles.ClearSearchProfile_benchmark, 'position');
set(handles.ClearSearchProfile_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearSearchProfile_benchmark, 'units', 'normalized');

%---validate profile
set(handles.ValidateSearchProfile_benchmark, 'units', 'pixels');
pos = get(handles.ValidateSearchProfile_benchmark, 'position');
set(handles.ValidateSearchProfile_benchmark, 'cdata', imresize(handles.icones.validate_offb, [pos(3) pos(4)]));
set(handles.ValidateSearchProfile_benchmark, 'units', 'normalized');



%---Delete race 1
set(handles.ClearRace1Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace1Ranking_benchmark, 'position');
set(handles.ClearRace1Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace1Ranking_benchmark, 'units', 'normalized');

%---Delete race 2
set(handles.ClearRace2Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace2Ranking_benchmark, 'position');
set(handles.ClearRace2Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace2Ranking_benchmark, 'units', 'normalized');

%---Delete race 3
set(handles.ClearRace3Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace3Ranking_benchmark, 'position');
set(handles.ClearRace3Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace3Ranking_benchmark, 'units', 'normalized');

%---Delete race 4
set(handles.ClearRace4Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace4Ranking_benchmark, 'position');
set(handles.ClearRace4Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace4Ranking_benchmark, 'units', 'normalized');

%---Delete race 5
set(handles.ClearRace5Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace5Ranking_benchmark, 'position');
set(handles.ClearRace5Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace5Ranking_benchmark, 'units', 'normalized');

%---Delete race 6
set(handles.ClearRace6Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace6Ranking_benchmark, 'position');
set(handles.ClearRace6Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace6Ranking_benchmark, 'units', 'normalized');

%---Delete race 7
set(handles.ClearRace7Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace7Ranking_benchmark, 'position');
set(handles.ClearRace7Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace7Ranking_benchmark, 'units', 'normalized');

%---Delete race 8
set(handles.ClearRace8Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace8Ranking_benchmark, 'position');
set(handles.ClearRace8Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace8Ranking_benchmark, 'units', 'normalized');

%---Delete race 9
set(handles.ClearRace9Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace9Ranking_benchmark, 'position');
set(handles.ClearRace9Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace9Ranking_benchmark, 'units', 'normalized');

%---Delete race 10
set(handles.ClearRace10Ranking_benchmark, 'units', 'pixels');
pos = get(handles.ClearRace10Ranking_benchmark, 'position');
set(handles.ClearRace10Ranking_benchmark, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.ClearRace10Ranking_benchmark, 'units', 'normalized');


%-----Database
%---Question
set(handles.Question_button_database, 'units', 'pixels');
pos = get(handles.Question_button_database, 'position');
set(handles.Question_button_database, 'cdata', imresize(handles.icones.question_offb, [pos(3) pos(4)]));
set(handles.Question_button_database, 'units', 'normalized');

%---JPG
set(handles.Downloadraw_button_database, 'units', 'pixels');
pos = get(handles.Downloadraw_button_database, 'position');
set(handles.Downloadraw_button_database, 'cdata', imresize(handles.icones.saveTab_offb, [pos(3) pos(4)]));
set(handles.Downloadraw_button_database, 'units', 'normalized');

%---PDF
set(handles.Downloadbenchmark_button_database, 'units', 'pixels');
pos = get(handles.Downloadbenchmark_button_database, 'position');
set(handles.Downloadbenchmark_button_database, 'cdata', imresize(handles.icones.saveRaw_offb, [pos(3) pos(4)]));
set(handles.Downloadbenchmark_button_database, 'units', 'normalized');

%---SEG
set(handles.DownloadAMS_button_database, 'units', 'pixels');
pos = get(handles.DownloadAMS_button_database, 'position');
set(handles.DownloadAMS_button_database, 'cdata', imresize(handles.icones.saveSeg_offb, [pos(3) pos(4)]));
set(handles.DownloadAMS_button_database, 'units', 'normalized');

%---Cloud all
set(handles.Downloadall_button_database, 'units', 'pixels');
pos = get(handles.Downloadall_button_database, 'position');
set(handles.Downloadall_button_database, 'cdata', imresize(handles.icones.cloudall_offb, [pos(3) pos(4)]));
set(handles.Downloadall_button_database, 'units', 'normalized');

%---Cloud New
set(handles.Downloadnew_button_database, 'units', 'pixels');
pos = get(handles.Downloadnew_button_database, 'position');
set(handles.Downloadnew_button_database, 'cdata', imresize(handles.icones.cloudnew_offb, [pos(3) pos(4)]));
set(handles.Downloadnew_button_database, 'units', 'normalized');

%---Cloud Select
set(handles.Downloadselect_button_database, 'units', 'pixels');
pos = get(handles.Downloadselect_button_database, 'position');
set(handles.Downloadselect_button_database, 'cdata', imresize(handles.icones.cloudselect_offb, [pos(3) pos(4)]));
set(handles.Downloadselect_button_database, 'units', 'normalized');

%---Arrow back
set(handles.Arrowback_button_database, 'units', 'pixels');
pos = get(handles.Arrowback_button_database, 'position');
set(handles.Arrowback_button_database, 'cdata', imresize(handles.icones.arrow_back_offb, [pos(3) pos(4)]));
set(handles.Arrowback_button_database, 'units', 'normalized');

%---Validate
set(handles.Validate_button_database, 'units', 'pixels');
pos = get(handles.Validate_button_database, 'position');
set(handles.Validate_button_database, 'cdata', imresize(handles.icones.validate_offb, [pos(3) pos(4)]));
set(handles.Validate_button_database, 'units', 'normalized');

%---Delete
set(handles.Redcross_button_database, 'units', 'pixels');
pos = get(handles.Redcross_button_database, 'position');
set(handles.Redcross_button_database, 'cdata', imresize(handles.icones.redcross_offb, [pos(3) pos(4)]));
set(handles.Redcross_button_database, 'units', 'normalized');



