function [] = validateSearchProfile_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 2;
    %default display Best
    graphType = 1;
    imcolormap = handles.icones.histColormap;
    imcolormap2 = handles.icones.histColormap2;

    sourceSort = 'initial';
    RaceOption = 'Element';
    
    valStroke = get(handles.SelectStrokeProfile_benchmark, 'Value');
    SearchStroke = handles.SelectStrokeProfileList_benchmark{valStroke};
    if strcmpi(SearchStroke, 'Medley'); 
        LegOption = 'All Legs';
    else;
        LegOption = '';
    end;
    seasonOption = 0;
    handles.racetimeSpiderOption = 0;
    handles.swimspeedSpiderOption = 0;
    handles.speeddecaySpiderOption = 0;
    handles.strokeindexSpiderOption = 0;
    handles.swimspeedSpiderOption = 0;
    handles.skilltimeSpiderOption = 0;
    handles.starttimeSpiderOption = 0;
    handles.turntimeSpiderOption = 0;
    
    updateSBchoice = 1;
    filter_profile_benchmark;
    sort_profile_benchmark;
    if returnval ~= 1;
        handles.existProfile = 1;
        handles.graphType = graphType;
        handles.seasonOption = 0;
        try;
            handles.databaseGroup = databaseGroup;
        end;
        handles.databaseCurrent = databaseCurrent;
    end;
end;

guidata(handles.hf_w1_welcome, handles);