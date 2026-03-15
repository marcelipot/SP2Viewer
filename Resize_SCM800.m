function [] = Resize_SCM800(varargin);


handles2 = guidata(gcf);

%% Intro 
slider_lower_side = 0.42301166666666673;
%
base = get(gcf,'Position');
%
slider_y = get(handles2.sliderRight,'Position');
slider_y(1,1) = base(1,3)-slider_lower_side;%x slider coordinate
slider_y(1,2) = slider_lower_side;%y slider coordinate
slider_y(1,4) = base(1,4)-slider_lower_side;
if slider_y(1,4) > 0 %to exclude error for minimum size
    set(handles2.sliderRight, 'Position', slider_y);
end
%
slider_x = [0 0 base(1,3)-slider_lower_side slider_lower_side];
%X slider
set(handles2.sliderRight, 'Position', slider_x);

%% Small rectangular between sliders
set(handles.rectangle,'Position',...
    [base(1,3)-slider_lower_side  0 ...
    slider_lower_side   slider_lower_side])

%% Panel properties
panel = get(handles2.panelMain,'Position');
panel(1,1) = 0;
panel(1,2) = base(1,4)-panel(1,4);
set(handles2.panelMain, 'Position', panel);
%

%% seting scroll x min max position and slider x step size
new_slider_x_min = 0;
new_slider_x_max = -base(1,3)+panel(1,3)+slider_lower_side;
%
set(handles2.sliderRight, 'Min', new_slider_x_min);
set(handles2.sliderRight, 'Max', new_slider_x_max);
set(handles2.sliderRight, 'Value', new_slider_x_min);
%    
set(handles2.slider_x,'SliderStep',[0.01*base(1,3)/panel(1,3)...
    2*base(1,3)/panel(1,3)]);
%% seting scroll y min max position and slider y step size
%
new_slider_y_min=-slider_lower_side;
new_slider_y_max=-base(1,4)+panel(1,4);
%
set(handles.slider_y,'Min',new_slider_y_min);
set(handles.slider_y,'Max',new_slider_y_max);
set(handles.slider_y,'Value',new_slider_y_max);
%    
set(handles.slider_y,'SliderStep',[0.01*base(1,4)/panel(1,4)...
    2*base(1,4)/panel(1,4)]);
%
% 
%% if is window size larger then panel deactivate scroll in that direction
%
if panel(1,3)<base(1,3)
    set(handles.slider_x,'Visible','off');
    set(handles.slider_y,'Position',[base(1,3)-slider_lower_side...
        0 slider_lower_side  base(1,4)]);
else
    set(handles.slider_x,'Visible','on');
end
%
if panel(1,4)<base(1,4)
   set(handles.slider_y,'Visible','off');
   set(handles.slider_x,'Position',[0 0 base(1,3) slider_lower_side]);
else
    set(handles.slider_y,'Visible','on');    
end
%% Rectangle show requirements
if panel(1,3)>base(1,3)&&panel(1,4)>base(1,4)
    set(handles.rectangle,'Visible','on');
else
    set(handles.rectangle,'Visible','off');
end

guidata(handles2.hdef, handles2);