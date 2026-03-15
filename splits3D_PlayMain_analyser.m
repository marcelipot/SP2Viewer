function [] = splits3D_PlayMain_analyser(varargin);


handles = guidata(gcf);


StatusEC = get(handles.AminationStatus_analyser, 'String');
if strcmpi(StatusEC, 'Play') == 0;
    %the video is stopped and now launched
    axes(handles.Play_button_analyser); imshow(handles.icones.pause_offb);
    set(handles.AminationStatus_analyser, 'String', 'Play');
%         drawnow;
    splits3D_Play_analyser;
else;
    %the video is running and now stopped
    axes(handles.Play_button_analyser); imshow(handles.icones.play_offb);
    set(handles.AminationStatus_analyser, 'String', 'Pause');
%         drawnow;
end;
    

guidata(handles.hf_w1_welcome, handles);

