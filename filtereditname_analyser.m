function [] = filtereditname_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);

val = get(handles2.filteredit_name_analyser, 'string');
if strcmpi(val, 'Name');
    handles2.SearchName = [];
    
    fh = findobj(0, 'type', 'figure');
    set(0, 'CurrentFigure', fh(1).Number);
    guidata(gcf, handles2);
    return;
end;

if length(val) < 3;
    handles2.SearchName = [];
    set(handles2.filteredit_name_analyser, 'String', 'Name');
    
    fh = findobj(0, 'type', 'figure');
    set(0, 'CurrentFigure', fh(1).Number);
    guidata(gcf, handles2);
    return;
end;

li = strfind(val, ';');
if isempty(li) == 1;
    %Only 1 search
    SearchName = val;
else;
    %multiple Name seach
    SearchName = {};
    for i = 1:length(li)+1;
        if i == 1;
            str = val(1:li(i)-1);
        elseif i == length(li)+1;
            str = val(li(end)+1:end);
        else;
            str = val(li(i-1)+1:li(i)-1);
        end;
        
        if isempty(str) == 0;
            if strcmpi(str(1), ' ');
                str = str(2:end);
            end;
            if strcmpi(str(end), ' ');
                str = str(1:end-1);
            end;

            SearchName{i,1} = str;
        else;
            SearchName{i,1} = SearchName{i-1,1};
        end;
    end;
end;

nb = length(SearchName);

if nb > 1;
    proceed = 1;
    iter = 1;
    while proceed == 1;
        valEC = SearchName(iter);
        valnumCheck = SearchName;
        
        if length(valnumCheck) == 1;
            proceed = 0;
        else;
            li = find(strcmpi(valnumCheck, valEC) == 1);
            
            likeep = find(li ~= iter);
            li = li(likeep);
            if isempty(li) == 0;
                SearchName(li) = [];
            end;

            iter = iter + 1;
            if iter > length(SearchName);
                proceed = 0;
            end;
        end;
    end;
end;

handles2.SearchName = SearchName;

if length(SearchName) > 1;
    SearchNameNew = [];
    if iscell(SearchName) == 1;
        for i = 1:length(SearchName);
            SearchNameNew = [SearchNameNew SearchName{i} ';'];
        end;
        SearchNameNew = SearchNameNew(1:end-1);
    else;
        SearchNameNew = SearchName;
    end;
else;
    SearchNameNew = SearchName;
end;

handles2.sortbyExceptionSelection = 1;
set(handles2.filteredit_name_analyser, 'String', SearchNameNew);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);

