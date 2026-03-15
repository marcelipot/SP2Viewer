FigPos = handles.FigPos;
if handles.CurrentstatusOverlayYes == 1;
    pos = [70./FigPos(3), 10./FigPos(4), 1000./FigPos(3), 600./FigPos(4)];
    handles.axesskilloverlay_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
        'Position', pos, 'Visible', 'off');
end;

if handles.CurrentstatusOverlayNo == 1;
    if strcmpi(origin, 'UpdateSkills');
        listrace = selectrace;
    else;
        if isfield(handles, 'nbRacesEC') == 1;
            firstrace = 1;
            nbRaces = handles.nbRacesEC;
            listrace = 1:nbRaces;
        else;
            nbRaces = 8;
            listrace = 1:nbRaces;
        end;
    end;

    if nbRaces == 1;
        posA1 = [70./FigPos(3), 10./FigPos(4), 1000./FigPos(3), 600./FigPos(4)];
        handles.axesskillA1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
            'Position', posA1, 'Visible', 'off');
        
    elseif nbRaces == 2;
        posB1 = [320./FigPos(3), 345./FigPos(4), 500./FigPos(3), 245./FigPos(4)];
        posB2 = [320./FigPos(3), 40./FigPos(4), 500./FigPos(3), 245./FigPos(4)];
        
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillB1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
                'Position', posB1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillB2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
                'Position', posB2, 'Visible', 'off');
        end;
        
    elseif nbRaces == 3;
        posC1 = [200./FigPos(3), 335./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        posC2 = [600./FigPos(3), 335./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        posC3 = [400./FigPos(3), 40./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillC1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
                'Position', posC1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillC2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
                'Position', posC2, 'Visible', 'off');
        end;
        if isempty(find(listrace == 3)) == 0;
            handles.axesskillC3_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'normalized', ...
                'Position', posC3, 'Visible', 'off');
        end;
    
    elseif nbRaces == 4;
        posD1 = [210./FigPos(3), 335./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        posD2 = [600./FigPos(3), 335./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        posD3 = [210./FigPos(3), 40./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        posD4 = [600./FigPos(3), 40./FigPos(4), 300./FigPos(3), 245./FigPos(4)];
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillD1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posD1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillD2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posD2, 'Visible', 'off');
        end;
        if isempty(find(listrace == 3)) == 0;
            handles.axesskillD3_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posD3, 'Visible', 'off');
        end;
        if isempty(find(listrace == 4)) == 0;
            handles.axesskillD4_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posD4, 'Visible', 'off');
        end;
    
    elseif nbRaces == 5;
        posE1 = [220./FigPos(3), 335./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posE2 = [470./FigPos(3), 335./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posE3 = [730./FigPos(3), 335./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posE4 = [310./FigPos(3), 40./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posE5 = [600./FigPos(3), 40./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillE1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posE1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillE2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posE2, 'Visible', 'off');
        end;
        if isempty(find(listrace == 3)) == 0;
            handles.axesskillE3_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posE3, 'Visible', 'off');
        end;
        if isempty(find(listrace == 4)) == 0;
            handles.axesskillE4_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posE4, 'Visible', 'off');
        end;
        if isempty(find(listrace == 5)) == 0;
            handles.axesskillE5_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posE5, 'Visible', 'off');
        end;
    
    elseif nbRaces == 6;
        posF1 = [220./FigPos(3), 335./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posF2 = [470./FigPos(3), 335./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posF3 = [730./FigPos(3), 335./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posF4 = [220./FigPos(3), 40./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posF5 = [470./FigPos(3), 40./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        posF6 = [730./FigPos(3), 40./FigPos(4), 180./FigPos(3), 245./FigPos(4)];
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillF1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posF1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillF2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posF2, 'Visible', 'off');
        end;
        if isempty(find(listrace == 3)) == 0;
            handles.axesskillF3_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posF3, 'Visible', 'off');
        end;
        if isempty(find(listrace == 4)) == 0;
            handles.axesskillF4_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posF4, 'Visible', 'off');
        end;
        if isempty(find(listrace == 5)) == 0;
            handles.axesskillF5_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posF5, 'Visible', 'off');
        end;
        if isempty(find(listrace == 6)) == 0;
            handles.axesskillF6_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posF6, 'Visible', 'off');
        end;
        
    elseif nbRaces == 7;
        posG1 = [220./FigPos(3), 435./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posG2 = [470./FigPos(3), 435./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posG3 = [730./FigPos(3), 435./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posG4 = [220./FigPos(3), 222./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posG5 = [470./FigPos(3), 222./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posG6 = [730./FigPos(3), 222./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posG7 = [300./FigPos(3), 12./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillG1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillG2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG2, 'Visible', 'off');
        end;
        if isempty(find(listrace == 3)) == 0;
            handles.axesskillG3_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG3, 'Visible', 'off');
        end;
        if isempty(find(listrace == 4)) == 0;
            handles.axesskillG4_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG4, 'Visible', 'off');
        end;
        if isempty(find(listrace == 5)) == 0;
            handles.axesskillG5_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG5, 'Visible', 'off');
        end;
        if isempty(find(listrace == 6)) == 0;
            handles.axesskillG6_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG6, 'Visible', 'off');
        end;
        if isempty(find(listrace == 7)) == 0;
            handles.axesskillG7_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posG7, 'Visible', 'off');
        end;
    
    elseif nbRaces == 8;
        posH1 = [220./FigPos(3), 435./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH2 = [470./FigPos(3), 435./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH3 = [730./FigPos(3), 435./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH4 = [220./FigPos(3), 222./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH5 = [470./FigPos(3), 222./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH6 = [730./FigPos(3), 222./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH7 = [320./FigPos(3), 12./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        posH8 = [620./FigPos(3), 12./FigPos(4), 165./FigPos(3), 155./FigPos(4)];
        if isempty(find(listrace == 1)) == 0;
            handles.axesskillH1_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH1, 'Visible', 'off');
        end;
        if isempty(find(listrace == 2)) == 0;
            handles.axesskillH2_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH2, 'Visible', 'off');
        end;
        if isempty(find(listrace == 3)) == 0;
            handles.axesskillH3_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH3, 'Visible', 'off');
        end;
        if isempty(find(listrace == 4)) == 0;
            handles.axesskillH4_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH4, 'Visible', 'off');
        end;
        if isempty(find(listrace == 5)) == 0;
            handles.axesskillH5_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH5, 'Visible', 'off');
        end;
        if isempty(find(listrace == 6)) == 0;
            handles.axesskillH6_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH6, 'Visible', 'off');
        end;
        if isempty(find(listrace == 7)) == 0;
            handles.axesskillH7_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH7, 'Visible', 'off');
        end;
        if isempty(find(listrace == 8)) == 0;
            handles.axesskillH8_analyser = axes('parent', handles.hf_w1_welcome, 'units', 'Normalized', ...
                'Position', posH8, 'Visible', 'off');
        end;
    end;
end;

