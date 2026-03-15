function [] = applyfilter_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);

% source = 'Filter';
Disp_Database_analyser;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);

guidata(gcf, handles2);


