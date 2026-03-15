function [] = checkno_analyser(varargin);


handles = guidata(gcf);

if handles.CurrentstatusOverlayNo == 1;
    set(handles.overlayno_check_analyser, 'Value', 1);
    return;
end;

handles.CurrentstatusOverlayYes = 0;
set(handles.overlayyes_check_analyser, 'Value', 0);

NewstatusOverlayNo = get(handles.overlayno_check_analyser, 'Value');
handles.CurrentstatusOverlayNo = NewstatusOverlayNo;

origin = 'checkno';
delete_allaxes_analyser;
create_emptyaxesSkill;
create_skillgraph;


handles.UpdateListGraphSkillOverlay = 1;
handles.UpdateListGraphSkillMultiple = 0;

guidata(handles.hf_w1_welcome, handles);
