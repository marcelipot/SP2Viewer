function [] = getRace2Delete_benchmark(varargin);


handles = guidata(gcf);

raw2remove = varargin{3};


SaveA=handles.databaseCurrent_rankings(:,1:10);



if length(handles.databaseCurrent_rankings) > 1;
    databaseCurrent_rankingsNew = {};
    if raw2remove == 1;
        list2keep = [2:length(handles.databaseCurrent_rankings(:,1))];
%     elseif raw2remove == (length(handles.databaseCurrent_rankings(:,1)) - 1);
%         list2keep = [1:(length(handles.databaseCurrent_rankings(:,1))-1) length(handles.databaseCurrent_rankings(:,1))];
    elseif raw2remove == length(handles.databaseCurrent_rankings(:,1));
        list2keep = [1:length(handles.databaseCurrent_rankings(:,1))-1];
    else;
        list2keep = [1:(raw2remove-1) (raw2remove+1):length(handles.databaseCurrent_rankings(:,1))]; 
    end;

    update_ranking_benchmark;
end;

guidata(handles.hf_w1_welcome, handles);