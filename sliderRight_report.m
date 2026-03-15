function [] = sliderRight_report(varargin);


handles2 = guidata(gcf);

slider_y = get(handles2.sliderRight, 'Value');
slider_yCORR = 10.*(1-slider_y);

TopPos = handles2.panel_size(1,2);
StepPos = abs(TopPos./10);

panel = get(handles2.panelMain, 'Position');
NewPos = TopPos + (slider_yCORR.*StepPos);
panel(1,2) = NewPos; %y slider coordinate

set(handles2.panelMain, 'Position', panel);
drawnow;

guidata(handles2.hdef, handles2);