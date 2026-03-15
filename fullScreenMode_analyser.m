function [] = fullScreenMode_analyser(varargin);


handles = guidata(gcf);


if isfield(handles, 'current_toggle') == 1;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        StatusEC = get(handles.AminationStatus_analyser, 'String');
        if strcmpi(StatusEC, 'Play');
            set(handles.AminationStatus_analyser, 'String', 'Other');
            return;
        end;
    end;
end;

origin = 'fullscreen';
if ispc == 1;
    if get(handles.PacingDisplay_toggle_analyser, 'value') == 1;
        if handles.VelGraphAct == 1;
            saveGraphPacing_analyser;
        elseif handles.VelGraphAct == 2;
            saveGraphVelDistri_analyser;
        elseif handles.VelGraphAct == 3;
            saveGraphVelFluc_analyser;
        end;
    end;
    if get(handles.SkillDisplay_toggle_analyser, 'value') == 1;
        saveGraphSkills_analyser;
    end;
    if get(handles.SplitsDisplay_toggle_analyser, 'value') == 1;
        if get(handles.splits1D_check_analyser, 'Value') == 1;
            saveGraphSplits1D_analyser;
        end;
        if get(handles.splits2D_check_analyser, 'Value') == 1;
            saveGraphSplits2D_analyser;
        end;
        if get(handles.splits3D_check_analyser, 'Value') == 1;
            herror = errordlg('Full screen display impossible', 'Error');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame=get(handle(herror), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;
    end;

elseif ismac == 1;        
    if strcmpi(handles.current_toggle, 'Data') == 1;
        saveTables_analyser;
    end;
    if strcmpi(handles.current_toggle, 'Pacing') == 1;
        if handles.VelGraphAct == 1;
            saveGraphPacing_analyser;
        elseif handles.VelGraphAct == 2;
            saveGraphVelDistri_analyser;
        elseif handles.VelGraphAct == 3;
            saveGraphVelFluc_analyser;
        end;
    end;
    if strcmpi(handles.current_toggle, 'Skill') == 1;
        saveGraphSkills_analyser;
    end;
    if strcmpi(handles.current_toggle, 'Splits') == 1;
        if get(handles.splits1D_check_analyser, 'Value') == 1;
            saveGraphSplits1D_analyser;
        end;
        if get(handles.splits2D_check_analyser, 'Value') == 1;
            saveGraphSplits2D_analyser;
        end;
        if get(handles.splits3D_check_analyser, 'Value') == 1;
            herror = errordlg('Impossible to save', 'Error');
        end;
    end;
end;




guidata(handles.hf_w1_welcome, handles);
