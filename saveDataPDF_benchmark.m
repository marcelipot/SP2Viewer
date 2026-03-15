function [] = saveDataPDF_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 1;
    %Rankins
    if handles.existRankings == 0;
        return;
    end;
elseif handles.currentBenchmarkToggle == 2;
    %Profile
    if handles.existProfile == 0;
        return;
    end;
end;

if handles.currentBenchmarkToggle == 1;
    saveSP1pdf_rankings_benchmark;
elseif handles.currentBenchmarkToggle == 2;
    saveSP1pdf_profile_benchmark;
else;   
    return;
end;

guidata(gcf, handles2);
