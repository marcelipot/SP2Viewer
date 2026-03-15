function [] = checkyes_analyser(varargin);


handles = guidata(gcf);

if handles.CurrentstatusOverlayYes == 1;
    set(handles.overlayyes_check_analyser, 'Value', 1);
    return;
end;

handles.CurrentstatusOverlayNo = 0;
set(handles.overlayno_check_analyser, 'Value', 0);

NewstatusOverlayYes = get(handles.overlayyes_check_analyser, 'Value');
handles.CurrentstatusOverlayYes = NewstatusOverlayYes;

origin = 'checkyes';
delete_allaxes_analyser;
create_emptyaxesSkill;
create_skillgraph;


handles.UpdateListGraphSkillOverlay = 0;
handles.UpdateListGraphSkillMultiple = 1;
handles.gtitleskilloverlay = gtitleskill;
handles.legGraph = legGraph;
handles.CurrentstatusOverlayYes = NewstatusOverlayYes;
handles.axesskilloverlay_analyser = axesEC;

guidata(handles.hf_w1_welcome, handles);

