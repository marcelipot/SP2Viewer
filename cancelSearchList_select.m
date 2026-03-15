function [] = cancelSearchList_select(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = [];
guidata(gcf, handles2);

uiresume(gcf);
