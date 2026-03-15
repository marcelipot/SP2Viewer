function [] = scrollSP1report(hObject, callbackdata, handles);


if callbackdata.VerticalScrollCount > 0
    moveSlider = -0.02;
elseif callbackdata.VerticalScrollCount < 0
    moveSlider = 0.02;
end

handles2 = guidata(gcf);

slider_y = get(handles2.sliderRight, 'Value');
slider_y = roundn(slider_y + moveSlider,-2);
if slider_y > 1.01;
    return;
elseif slider_y < -0.01;
    return;
end;
if slider_y > 1;
    slider_y = 1;
elseif slider_y < -0.01;
    slider_y = 0;
end;

set(handles2.sliderRight, 'Value', slider_y);
slider_yCORR = 10.*(1-slider_y);

TopPos = handles2.panel_size(1,2);
StepPos = abs(TopPos./10);

panel = get(handles2.panelMain, 'Position');
NewPos = TopPos + (slider_yCORR.*StepPos);
panel(1,2) = NewPos; %y slider coordinate

set(handles2.panelMain, 'Position', panel);
drawnow;

