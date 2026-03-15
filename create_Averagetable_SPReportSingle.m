% RacesTOT = length(handles.uidDB(:,1));
% nbRaces = length(handles.filelistAdded);
% RaceUID = [];
% for raceEC = 1:nbRaces;
%     fileEC = handles.filelistAdded{raceEC};
%     proceed = 1;
%     iter = 1;
%     while proceed == 1;
%         raceCHECK = handles.uidDB{iter,2};
%         if strcmpi(fileEC, raceCHECK) == 1;
%             RaceUID{raceEC} = handles.uidDB{iter,1};
%             proceed = 0;
%         else;
%             iter = iter + 1;
%         end;
%     end;
% end;
% set(gcf, 'units', 'pixels');
% PosFig = get(gcf, 'Position');
% set(gcf, 'units', 'normalized');
% 
% 
% 
% R2 = RaceUID
% 
% 
% 
% for mainIter = 3:nbRaces+2;    
% 
%     %----------------------------------Meta--------------------------------
%     UID = RaceUID{mainIter-2};
%     li = findstr(UID, '-');
%     UID(li) = '_';
%     UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['Source = handles.RacesDB.' UID '.Source;']);
    eval(['framerate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    
    NbLap = roundn(RaceDist./Course,0);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);

    idx = isstrprop(Meet,'upper');
    MeetShort = Meet(idx);
    if strcmpi(Stage, 'Semi-Final');
        StageShort = 'SF';
    elseif strcmpi(Stage, 'Semi-final');
        StageShort = 'SF';
    else;
        StageShort = Stage;
    end;
    YearShort = Year(3:4);
    graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
    storeTitle2{mainIter-2} = graphTitle2;
    
    %---------------------------------Pacing-------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);    
%     if mainIter == 3;
        dataTableAverage = {};
        if Course == 25;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';

                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];

            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-20m';
                dataTableAverage{3,1} = '20-25m';
                dataTableAverage{4,1} = '25-35m';
                dataTableAverage{5,1} = '35-45m';
                dataTableAverage{6,1} = '45-50m';
                dataTableAverage{7,1} = '50-60m';
                dataTableAverage{8,1} = '60-70m';
                dataTableAverage{9,1} = '70-75m';
                dataTableAverage{10,1} = '75-85m';
                dataTableAverage{11,1} = '85-95m';
                dataTableAverage{12,1} = '95-100m';

                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 20];
                dataZone(3,:) = [20 25];
                dataZone(4,:) = [25 35];
                dataZone(5,:) = [35 45];
                dataZone(6,:) = [45 50];
                dataZone(7,:) = [50 60];
                dataZone(8,:) = [60 70];
                dataZone(9,:) = [70 75];
                dataZone(10,:) = [75 85];
                dataZone(11,:) = [85 95];
                dataZone(12,:) = [95 100];

            elseif RaceDist == 150;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];

            elseif RaceDist == 200;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];

            elseif RaceDist == 400;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';
                dataTableAverage{9,1} = '200-225m';
                dataTableAverage{10,1} = '225-250m';
                dataTableAverage{11,1} = '250-275m';
                dataTableAverage{12,1} = '275-300m';
                dataTableAverage{13,1} = '300-325m';
                dataTableAverage{14,1} = '325-350m';
                dataTableAverage{15,1} = '350-375m';
                dataTableAverage{16,1} = '375-400m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];
                dataZone(9,:) = [200 225];
                dataZone(10,:) = [225 250];
                dataZone(11,:) = [250 275];
                dataZone(12,:) = [275 300];
                dataZone(13,:) = [300 325];
                dataZone(14,:) = [325 350];
                dataZone(15,:) = [350 375];
                dataZone(16,:) = [375 400];

            elseif RaceDist == 800;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';
                dataTableAverage{9,1} = '200-225m';
                dataTableAverage{10,1} = '225-250m';
                dataTableAverage{11,1} = '250-275m';
                dataTableAverage{12,1} = '275-300m';
                dataTableAverage{13,1} = '300-325m';
                dataTableAverage{14,1} = '325-350m';
                dataTableAverage{15,1} = '350-375m';
                dataTableAverage{16,1} = '375-400m';
                dataTableAverage{17,1} = '400-425m';
                dataTableAverage{18,1} = '425-450m';
                dataTableAverage{19,1} = '450-475m';
                dataTableAverage{20,1} = '475-500m';
                dataTableAverage{21,1} = '500-525m';
                dataTableAverage{22,1} = '525-550m';
                dataTableAverage{23,1} = '550-575m';
                dataTableAverage{24,1} = '575-600m';
                dataTableAverage{25,1} = '600-625m';
                dataTableAverage{26,1} = '625-650m';
                dataTableAverage{27,1} = '650-675m';
                dataTableAverage{28,1} = '675-700m';
                dataTableAverage{29,1} = '700-725m';
                dataTableAverage{30,1} = '725-750m';
                dataTableAverage{31,1} = '750-775m';
                dataTableAverage{32,1} = '775-800m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];
                dataZone(9,:) = [200 225];
                dataZone(10,:) = [225 250];
                dataZone(11,:) = [250 275];
                dataZone(12,:) = [275 300];
                dataZone(13,:) = [300 325];
                dataZone(14,:) = [325 350];
                dataZone(15,:) = [350 375];
                dataZone(16,:) = [375 400];
                dataZone(17,:) = [400 425];
                dataZone(18,:) = [425 450];
                dataZone(19,:) = [450 475];
                dataZone(20,:) = [475 500];
                dataZone(21,:) = [500 525];
                dataZone(22,:) = [525 550];
                dataZone(23,:) = [550 575];
                dataZone(24,:) = [575 600];
                dataZone(25,:) = [600 625];
                dataZone(26,:) = [625 650];
                dataZone(27,:) = [650 675];
                dataZone(28,:) = [675 700];
                dataZone(29,:) = [700 725];
                dataZone(30,:) = [725 750];
                dataZone(31,:) = [750 775];
                dataZone(32,:) = [775 800];

            elseif RaceDist == 1500;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';
                dataTableAverage{9,1} = '200-225m';
                dataTableAverage{10,1} = '225-250m';
                dataTableAverage{11,1} = '250-275m';
                dataTableAverage{12,1} = '275-300m';
                dataTableAverage{13,1} = '300-325m';
                dataTableAverage{14,1} = '325-350m';
                dataTableAverage{15,1} = '350-375m';
                dataTableAverage{16,1} = '375-400m';
                dataTableAverage{17,1} = '400-425m';
                dataTableAverage{18,1} = '425-450m';
                dataTableAverage{19,1} = '450-475m';
                dataTableAverage{20,1} = '475-500m';
                dataTableAverage{21,1} = '500-525m';
                dataTableAverage{22,1} = '525-550m';
                dataTableAverage{23,1} = '550-575m';
                dataTableAverage{24,1} = '575-600m';
                dataTableAverage{25,1} = '600-625m';
                dataTableAverage{26,1} = '625-650m';
                dataTableAverage{27,1} = '650-675m';
                dataTableAverage{28,1} = '675-700m';
                dataTableAverage{29,1} = '700-725m';
                dataTableAverage{30,1} = '725-750m';
                dataTableAverage{31,1} = '750-775m';
                dataTableAverage{32,1} = '775-800m';
                dataTableAverage{33,1} = '800-825m';
                dataTableAverage{34,1} = '825-850m';
                dataTableAverage{35,1} = '850-875m';
                dataTableAverage{36,1} = '875-900m';
                dataTableAverage{37,1} = '900-925m';
                dataTableAverage{38,1} = '925-950m';
                dataTableAverage{39,1} = '950-975m';
                dataTableAverage{40,1} = '975-1000m';
                dataTableAverage{41,1} = '1000-1025m';
                dataTableAverage{42,1} = '1025-1050m';
                dataTableAverage{43,1} = '1050-1075m';
                dataTableAverage{44,1} = '1075-1100m';
                dataTableAverage{45,1} = '1100-1125m';
                dataTableAverage{46,1} = '1125-1150m';
                dataTableAverage{47,1} = '1150-1175m';
                dataTableAverage{48,1} = '1175-1200m';
                dataTableAverage{49,1} = '1200-1225m';
                dataTableAverage{50,1} = '1225-1250m';
                dataTableAverage{51,1} = '1250-1275m';
                dataTableAverage{52,1} = '1275-1300m';
                dataTableAverage{53,1} = '1300-1325m';
                dataTableAverage{54,1} = '1325-1350m';
                dataTableAverage{55,1} = '1350-1375m';
                dataTableAverage{56,1} = '1375-1400m';
                dataTableAverage{57,1} = '1400-1425m';
                dataTableAverage{58,1} = '1425-1450m';
                dataTableAverage{59,1} = '1450-1475m';
                dataTableAverage{60,1} = '1475-1500m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];
                dataZone(9,:) = [200 225];
                dataZone(10,:) = [225 250];
                dataZone(11,:) = [250 275];
                dataZone(12,:) = [275 300];
                dataZone(13,:) = [300 325];
                dataZone(14,:) = [325 350];
                dataZone(15,:) = [350 375];
                dataZone(16,:) = [375 400];
                dataZone(17,:) = [400 425];
                dataZone(18,:) = [425 450];
                dataZone(19,:) = [450 475];
                dataZone(20,:) = [475 500];
                dataZone(21,:) = [500 525];
                dataZone(22,:) = [525 550];
                dataZone(23,:) = [550 575];
                dataZone(24,:) = [575 600];
                dataZone(25,:) = [600 625];
                dataZone(26,:) = [625 650];
                dataZone(27,:) = [650 675];
                dataZone(28,:) = [675 700];
                dataZone(29,:) = [700 725];
                dataZone(30,:) = [725 750];
                dataZone(31,:) = [750 775];
                dataZone(32,:) = [775 800];
                dataZone(33,:) = [800 825];
                dataZone(34,:) = [825 850];
                dataZone(35,:) = [850 875];
                dataZone(36,:) = [875 900];
                dataZone(37,:) = [900 925];
                dataZone(38,:) = [925 950];
                dataZone(39,:) = [950 975];
                dataZone(40,:) = [975 1000];
                dataZone(41,:) = [1000 1025];
                dataZone(42,:) = [1025 1050];
                dataZone(43,:) = [1050 1075];
                dataZone(44,:) = [1075 1100];
                dataZone(45,:) = [1100 1125];
                dataZone(46,:) = [1125 1150];
                dataZone(47,:) = [1150 1175];
                dataZone(48,:) = [1175 1200];
                dataZone(49,:) = [1200 1225];
                dataZone(50,:) = [1225 1250];
                dataZone(51,:) = [1250 1275];
                dataZone(52,:) = [1275 1300];
                dataZone(53,:) = [1300 1325];
                dataZone(54,:) = [1325 1350];
                dataZone(55,:) = [1350 1375];
                dataZone(56,:) = [1375 1400];
                dataZone(57,:) = [1400 1425];
                dataZone(58,:) = [1425 1450];
                dataZone(59,:) = [1450 1475];
                dataZone(60,:) = [1475 1500];

            end;
        elseif Course == 50;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';

                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];

            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
                dataTableAverage{6,1} = '50-65m';
                dataTableAverage{7,1} = '65-75m';
                dataTableAverage{8,1} = '75-85m';
                dataTableAverage{9,1} = '85-95m';
                dataTableAverage{10,1} = '95-100m';

                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
                dataZone(6,:) = [50 65];
                dataZone(7,:) = [65 75];
                dataZone(8,:) = [75 85];
                dataZone(9,:) = [85 95];
                dataZone(10,:) = [95 100];

            elseif RaceDist == 150;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];

            elseif RaceDist == 200;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];

            elseif RaceDist == 400;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';
                dataTableAverage{9,1} = '200-225m';
                dataTableAverage{10,1} = '225-250m';
                dataTableAverage{11,1} = '250-275m';
                dataTableAverage{12,1} = '275-300m';
                dataTableAverage{13,1} = '300-325m';
                dataTableAverage{14,1} = '325-350m';
                dataTableAverage{15,1} = '350-375m';
                dataTableAverage{16,1} = '375-400m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];
                dataZone(9,:) = [200 225];
                dataZone(10,:) = [225 250];
                dataZone(11,:) = [250 275];
                dataZone(12,:) = [275 300];
                dataZone(13,:) = [300 325];
                dataZone(14,:) = [325 350];
                dataZone(15,:) = [350 375];
                dataZone(16,:) = [375 400];

            elseif RaceDist == 800;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';
                dataTableAverage{9,1} = '200-225m';
                dataTableAverage{10,1} = '225-250m';
                dataTableAverage{11,1} = '250-275m';
                dataTableAverage{12,1} = '275-300m';
                dataTableAverage{13,1} = '300-325m';
                dataTableAverage{14,1} = '325-350m';
                dataTableAverage{15,1} = '350-375m';
                dataTableAverage{16,1} = '375-400m';
                dataTableAverage{17,1} = '400-425m';
                dataTableAverage{18,1} = '425-450m';
                dataTableAverage{19,1} = '450-475m';
                dataTableAverage{20,1} = '475-500m';
                dataTableAverage{21,1} = '500-525m';
                dataTableAverage{22,1} = '525-550m';
                dataTableAverage{23,1} = '550-575m';
                dataTableAverage{24,1} = '575-600m';
                dataTableAverage{25,1} = '600-625m';
                dataTableAverage{26,1} = '625-650m';
                dataTableAverage{27,1} = '650-675m';
                dataTableAverage{28,1} = '675-700m';
                dataTableAverage{29,1} = '700-725m';
                dataTableAverage{30,1} = '725-750m';
                dataTableAverage{31,1} = '750-775m';
                dataTableAverage{32,1} = '775-800m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];
                dataZone(9,:) = [200 225];
                dataZone(10,:) = [225 250];
                dataZone(11,:) = [250 275];
                dataZone(12,:) = [275 300];
                dataZone(13,:) = [300 325];
                dataZone(14,:) = [325 350];
                dataZone(15,:) = [350 375];
                dataZone(16,:) = [375 400];
                dataZone(17,:) = [400 425];
                dataZone(18,:) = [425 450];
                dataZone(19,:) = [450 475];
                dataZone(20,:) = [475 500];
                dataZone(21,:) = [500 525];
                dataZone(22,:) = [525 550];
                dataZone(23,:) = [550 575];
                dataZone(24,:) = [575 600];
                dataZone(25,:) = [600 625];
                dataZone(26,:) = [625 650];
                dataZone(27,:) = [650 675];
                dataZone(28,:) = [675 700];
                dataZone(29,:) = [700 725];
                dataZone(30,:) = [725 750];
                dataZone(31,:) = [750 775];
                dataZone(32,:) = [775 800];

            elseif RaceDist == 1500;
                dataTableAverage{1,1} = '0-25m';
                dataTableAverage{2,1} = '25-50m';
                dataTableAverage{3,1} = '50-75m';
                dataTableAverage{4,1} = '75-100m';
                dataTableAverage{5,1} = '100-125m';
                dataTableAverage{6,1} = '125-150m';
                dataTableAverage{7,1} = '150-175m';
                dataTableAverage{8,1} = '175-200m';
                dataTableAverage{9,1} = '200-225m';
                dataTableAverage{10,1} = '225-250m';
                dataTableAverage{11,1} = '250-275m';
                dataTableAverage{12,1} = '275-300m';
                dataTableAverage{13,1} = '300-325m';
                dataTableAverage{14,1} = '325-350m';
                dataTableAverage{15,1} = '350-375m';
                dataTableAverage{16,1} = '375-400m';
                dataTableAverage{17,1} = '400-425m';
                dataTableAverage{18,1} = '425-450m';
                dataTableAverage{19,1} = '450-475m';
                dataTableAverage{20,1} = '475-500m';
                dataTableAverage{21,1} = '500-525m';
                dataTableAverage{22,1} = '525-550m';
                dataTableAverage{23,1} = '550-575m';
                dataTableAverage{24,1} = '575-600m';
                dataTableAverage{25,1} = '600-625m';
                dataTableAverage{26,1} = '625-650m';
                dataTableAverage{27,1} = '650-675m';
                dataTableAverage{28,1} = '675-700m';
                dataTableAverage{29,1} = '700-725m';
                dataTableAverage{30,1} = '725-750m';
                dataTableAverage{31,1} = '750-775m';
                dataTableAverage{32,1} = '775-800m';
                dataTableAverage{33,1} = '800-825m';
                dataTableAverage{34,1} = '825-850m';
                dataTableAverage{35,1} = '850-875m';
                dataTableAverage{36,1} = '875-900m';
                dataTableAverage{37,1} = '900-925m';
                dataTableAverage{38,1} = '925-950m';
                dataTableAverage{39,1} = '950-975m';
                dataTableAverage{40,1} = '975-1000m';
                dataTableAverage{41,1} = '1000-1025m';
                dataTableAverage{42,1} = '1025-1050m';
                dataTableAverage{43,1} = '1050-1075m';
                dataTableAverage{44,1} = '1075-1100m';
                dataTableAverage{45,1} = '1100-1125m';
                dataTableAverage{46,1} = '1125-1150m';
                dataTableAverage{47,1} = '1150-1175m';
                dataTableAverage{48,1} = '1175-1200m';
                dataTableAverage{49,1} = '1200-1225m';
                dataTableAverage{50,1} = '1225-1250m';
                dataTableAverage{51,1} = '1250-1275m';
                dataTableAverage{52,1} = '1275-1300m';
                dataTableAverage{53,1} = '1300-1325m';
                dataTableAverage{54,1} = '1325-1350m';
                dataTableAverage{55,1} = '1350-1375m';
                dataTableAverage{56,1} = '1375-1400m';
                dataTableAverage{57,1} = '1400-1425m';
                dataTableAverage{58,1} = '1425-1450m';
                dataTableAverage{59,1} = '1450-1475m';
                dataTableAverage{60,1} = '1475-1500m';

                dataZone(1,:) = [0 25];
                dataZone(2,:) = [25 50];
                dataZone(3,:) = [50 75];
                dataZone(4,:) = [75 100];
                dataZone(5,:) = [100 125];
                dataZone(6,:) = [125 150];
                dataZone(7,:) = [150 175];
                dataZone(8,:) = [175 200];
                dataZone(9,:) = [200 225];
                dataZone(10,:) = [225 250];
                dataZone(11,:) = [250 275];
                dataZone(12,:) = [275 300];
                dataZone(13,:) = [300 325];
                dataZone(14,:) = [325 350];
                dataZone(15,:) = [350 375];
                dataZone(16,:) = [375 400];
                dataZone(17,:) = [400 425];
                dataZone(18,:) = [425 450];
                dataZone(19,:) = [450 475];
                dataZone(20,:) = [475 500];
                dataZone(21,:) = [500 525];
                dataZone(22,:) = [525 550];
                dataZone(23,:) = [550 575];
                dataZone(24,:) = [575 600];
                dataZone(25,:) = [600 625];
                dataZone(26,:) = [625 650];
                dataZone(27,:) = [650 675];
                dataZone(28,:) = [675 700];
                dataZone(29,:) = [700 725];
                dataZone(30,:) = [725 750];
                dataZone(31,:) = [750 775];
                dataZone(32,:) = [775 800];
                dataZone(33,:) = [800 825];
                dataZone(34,:) = [825 850];
                dataZone(35,:) = [850 875];
                dataZone(36,:) = [875 900];
                dataZone(37,:) = [900 925];
                dataZone(38,:) = [925 950];
                dataZone(39,:) = [950 975];
                dataZone(40,:) = [975 1000];
                dataZone(41,:) = [1000 1025];
                dataZone(42,:) = [1025 1050];
                dataZone(43,:) = [1050 1075];
                dataZone(44,:) = [1075 1100];
                dataZone(45,:) = [1100 1125];
                dataZone(46,:) = [1125 1150];
                dataZone(47,:) = [1150 1175];
                dataZone(48,:) = [1175 1200];
                dataZone(49,:) = [1200 1225];
                dataZone(50,:) = [1225 1250];
                dataZone(51,:) = [1250 1275];
                dataZone(52,:) = [1275 1300];
                dataZone(53,:) = [1300 1325];
                dataZone(54,:) = [1325 1350];
                dataZone(55,:) = [1350 1375];
                dataZone(56,:) = [1375 1400];
                dataZone(57,:) = [1400 1425];
                dataZone(58,:) = [1425 1450];
                dataZone(59,:) = [1450 1475];
                dataZone(60,:) = [1475 1500];

            end;
        end;
%     end;

    
    
    SplitsAll = SplitsAll(2:end,:);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.DistanceINIBO;']);
%     eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);

%     eval(['RawStroke = handles.RacesDB.' UID '.RawStroke;']);
% 
%     rawFrame = 1:length(TimeEC);
%     A = [rawFrame' TimeEC' RawStroke'];
%     A = A(2300:3110,:)


    eval(['BOEC = handles.RacesDB.' UID '.RawBreakout;']);

    %calculate velocities per sections
    lapLim = Course:Course:RaceDist;
    lapEC = 1;
    updateLap = 0;
    for zoneEC = 1:length(dataTableAverage(:,1));

        zone_dist_ini = dataZone(zoneEC,1);
        zone_dist_end = dataZone(zoneEC,2);

        indexLap = find(lapLim == zone_dist_end);
        if isempty(indexLap) == 0;
            %Last zone for a lap, remove 2m
            zone_dist_end = zone_dist_end-2;
            updateLap = 1;
        end;

        if BOAll(lapEC,3) > zone_dist_end;
            %BO happened in the following zone
            VelEC = [];

        elseif BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
            %BO happened in this zone
            distBO2End = zone_dist_end-BOAll(lapEC,3);
            if distBO2End <= 2;
                %Less than 2m to end of zone
                VelEC = [];

            else;
                %more than 2m to calculate the speed
                zone_dist_ini = BOAll(lapEC,3);
                zone_time_ini = BOAll(lapEC,2);

                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_time_end = TimeEC(minLoc(1));

                VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
            end;

        else;
            %BO happened before
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
            zone_time_ini = TimeEC(minLoc(1));
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_time_end = TimeEC(minLoc(1));
            VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
        end;
        dataTableAverage{zoneEC,2} = VelEC;

        if updateLap == 1;
            updateLap = 0;
            lapEC = lapEC + 1;
        end;
    end;

    %calculate SR per sections
    %find legs if IM
    if strcmpi(lower(StrokeType), 'medley');
        if Course == 25;
            if RaceDist == 100;
                legsIM = [1;2;3;4];
            elseif RaceDist == 150;
                legsIM = [[1 2]; [3 4]; [5 6]];
            elseif RaceDist == 200;
                legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
            elseif RaceDist == 400;
                legsIM = [[1 2 3 4]; [5 6 7 8]; [9 10 11 12]; [13 14 15 16]];
            end;
        elseif Course == 50;
            if RaceDist == 150;
                legsIM = [1; 2; 3];
            elseif RaceDist == 200;
                legsIM = [1; 2; 3; 4];
            elseif RaceDist == 400;
                legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
            end;
        end;
    else;
        legsIM = [];
    end;

    %restructure Stroke_Frame
    Stroke_FrameRestruc = [];
    for lapEC = 1:NbLap;
        indexZero = find(Stroke_Frame(lapEC,:) ~= 0);
        Stroke_FrameRestruc = [Stroke_FrameRestruc Stroke_Frame(lapEC, indexZero)];
    end;

    lapEC = 1;
    updateLap = 0;
    for zoneEC = 1:length(dataTableAverage(:,1));

        durationStroke = [];
        durationStrokeSave = [];
        SREC = [];
        searchExtraStroke = [];
        zone_dist_ini = dataZone(zoneEC,1);
        zone_dist_end = dataZone(zoneEC,2);
        
        indexLap = find(lapLim == zone_dist_ini);
        if zone_dist_ini == 0;
            %zone beginning is 0
            zone_frame_ini = 1;
        
        else;
            if isempty(indexLap) == 0;
                %Zone beginning is matching with a lap
                zone_frame_ini = SplitsAll(indexLap,3);
        
            else;
                %Zone beginning is mid-pool
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                zone_frame_ini = minLoc(1);
            end;
        end;

        indexLap = find(lapLim == zone_dist_end);
        if zone_dist_end == 0;
            %zone end is 0
            zone_frame_end = 1;
        else;
            if isempty(indexLap) == 0;
                %Zone end is matching with a lap
                zone_frame_end = SplitsAll(indexLap,3);

            else;
                %Zone end is mid-pool
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_frame_end = minLoc(1);
            end;
        end;
        
        if isempty(indexLap) == 0;
            %last zone of the lap: take the previous zone to look
            %for other strokes
            searchExtraStroke = 'pre';
            updateLap = 1;
        else;
            %other zones: take the next zone to look
            %for other strokes
            searchExtraStroke = 'post';
        end;
        
        li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc <= zone_frame_end);

        strokeList = Stroke_FrameRestruc(1,li_stroke);
        strokeCount = length(strokeList);

        if strokeCount < 2;
            %no stroke rate if count if 1
            SREC = [];

        else;
            if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                if rem(strokeCount,2) == 1;
                    %odd stroke count: no need for another stroke
                    
                else;
                    %even stroke count: add another stroke to get a
                    %full cycle
                    if Course == 25;
                        if RaceDist >= 150;
                            caseSC = 1;
                        else;
                            caseSC = 0;
                        end;
                    else;
                        caseSC = 0;
                    end

                    if caseSC == 1;
                        strokeList = strokeList(1:end-1);
                    else;
                        if strcmpi(searchExtraStroke, 'pre');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);

                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke pre
                                strokeList = strokeList(2:end);
                            else;
                                li_strokeExtra = li_strokeExtra(end);
                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            end;
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (5*framerate);
                            zone_frame_iniExtra = strokeList(end) + 1;
    
                            %take the first stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            
                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke post
                                strokeList = strokeList(1:end-1);
                            else;
                                li_strokeExtra = li_strokeExtra(1);
                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;
                    end;    
                end;

%                 for strokeEC = 2:length(strokeList);
%                     durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
%                     SREC(strokeEC-1) = 60/durationStroke;
%                     SREC(strokeEC-1) = SREC(strokeEC-1)./2;
%                 end;
%                 SREC = mean(SREC);
                for strokeEC = 2:length(strokeList);
                    durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                end;
                avDurationStroke = mean(durationStroke);
                SREC = 60./avDurationStroke;
                SREC = SREC./2;

            elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
%                 for strokeEC = 2:length(strokeList);
%                     durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
%                     SREC(strokeEC-1) = 60/durationStroke;
%                 end;
%                 SREC = mean(SREC);
                for strokeEC = 2:length(strokeList);
                    durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                end;
                avDurationStroke = mean(durationStroke);
                SREC = 60./avDurationStroke;

            elseif strcmpi(lower(StrokeType), 'medley');
                [li, co] = find(legsIM == lapEC);
                if li == 1 | li == 3;
%                     for strokeEC = 2:length(strokeList);
%                         durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
% %                         durationStrokeSave(strokeEC-1) = durationStroke;
%                         SREC(strokeEC-1) = 60/durationStroke;
%                     end;
                    SREC = mean(SREC);
                    for strokeEC = 2:length(strokeList);
                        durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                    end;
                    avDurationStroke = mean(durationStroke);
                    SREC = 60./avDurationStroke;
                else;
                    if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                    else;
                        %even stroke count: add another stroke to get a
                        %full cycle
                        if Course == 25;
                            if RaceDist >= 150;
                                caseSC = 1;
                            else;
                                caseSC = 0;
                            end;
                        else;
                            caseSC = 0;
                        end;

                        if caseSC == 1;
                            strokeList = strokeList(1:end-1);
                        else;
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
    
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke pre
                                    strokeList = strokeList(2:end);
                                else;
                                    li_strokeExtra = li_strokeExtra(end);
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                end;
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
        
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke post
                                    strokeList = strokeList(1:end-1);
                                else;
                                    li_strokeExtra = li_strokeExtra(1);
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
                        end;
                    end;

%                     for strokeEC = 2:length(strokeList);
%                         durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
%                         SREC(strokeEC-1) = 60/durationStroke;
%                         SREC(strokeEC-1) = SREC(strokeEC-1)./2;
%                     end;
%                     SREC = mean(SREC);
                    for strokeEC = 2:length(strokeList);
                        durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                    end;
                    avDurationStroke = mean(durationStroke);
                    SREC = 60./avDurationStroke;
                    SREC = SREC./2;
                end;
            end;

            dataTableAverage{zoneEC,3} = SREC;
        end;

        if updateLap == 1;
            updateLap = 0;
            lapEC = lapEC + 1;
        end;
    end;




    %calculate DPS per sections
    lapEC = 1;
    updateLap = 0;
    for zoneEC = 1:length(dataTableAverage(:,1));

        DPSEC = [];
        searchExtraStroke = [];
        zone_dist_ini = dataZone(zoneEC,1);
        zone_dist_end = dataZone(zoneEC,2);

        indexLap = find(lapLim == zone_dist_ini);
        if zone_dist_ini == 0;
            %zone beginning is 0
            zone_frame_ini = 1;
        
        else;
            if isempty(indexLap) == 0;
                %Zone beginning is matching with a lap
                zone_frame_ini = SplitsAll(indexLap,3);
        
            else;
                %Zone beginning is mid-pool
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                zone_frame_ini = minLoc(1);
            end;
        end;
        
        indexLap = find(lapLim == zone_dist_end);
        if isempty(indexLap) == 0;
            %Last zone for a lap, remove 2m
            zone_dist_end = zone_dist_end-2;
        end;
        [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
        zone_frame_end = minLoc(1);
        
        if isempty(indexLap) == 0;
            %last zone of the lap: take the previous zone to look
            %for other strokes
            searchExtraStroke = 'pre';
            updateLap = 1;
        else;
            %other zones: take the next zone to look
            %for other strokes
            searchExtraStroke = 'post';
        end;
        
        li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc <= zone_frame_end);

        strokeList = Stroke_FrameRestruc(1,li_stroke);
        strokeCount = length(strokeList);

        if strokeCount < 2;
            %no stroke rate if count if 1
            DPSEC = [];

        else;
            if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                if rem(strokeCount,2) == 1;
                    %odd stroke count: no need for another stroke
                    
                else;
                    %even stroke count: add another stroke to get a
                    %full cycle
                    if Course == 25;
                        if RaceDist >= 150;
                            caseSC = 1;
                        else;
                            caseSC = 0;
                        end;
                    else;
                        caseSC = 0;
                    end;

                    if caseSC == 1;
                        strokeList = strokeList(1:end-1);
                    else;
                        if strcmpi(searchExtraStroke, 'pre');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke pre
                                strokeList = strokeList(2:end);
                            else;
                                li_strokeExtra = li_strokeExtra(end);
                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            end;
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (5*framerate);
                            zone_frame_iniExtra = strokeList(end) + 1;
    
                            %take the first stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke post
                                strokeList = strokeList(1:end-1);
                            else;
                                li_strokeExtra = li_strokeExtra(1);
                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;
                    end;
                end;

% 
% 
%                     
%                     if zoneEC == 5
%                     a=zoneEC
%                     b=strokeList
%                     DistanceEC(strokeList)
%                     TimeEC(strokeList)
%                     end
% 
% 
% 


                for strokeEC = 2:length(strokeList);
                    distanceStroke(strokeEC) = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                    DPSEC(strokeEC-1) = distanceStroke(strokeEC).*2;
                end;
% 
%                     if zoneEC == 5
%                     c=DPSEC
%                     end;
% 
% 
                DPSEC = mean(DPSEC);
% 
%                     if zoneEC == 5
%                     d=DPSEC
%                     end;

            elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');

%                     
% 
%                     
%                     a=zoneEC
%                     b=strokeList
%                     DistanceEC(strokeList)
% 
% 
% 
% 


                for strokeEC = 2:length(strokeList);
                    distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                    DPSEC(strokeEC-1) = distanceStroke;
                end;
% 
%                     c=DPSEC
%                   
% 
% 
                DPSEC = mean(DPSEC);
% 
%                     DPSEC


            elseif strcmpi(lower(StrokeType), 'medley');
                [li, co] = find(legsIM == lapEC);
                if li == 1 | li == 3;
                    %butterfly and breaststroke legs
                    for strokeEC = 2:length(strokeList);
                        distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                        DPSEC(strokeEC-1) = distanceStroke;
                    end;
                    DPSEC = mean(DPSEC);

                else;
                    %backstroke and freestyle legs
                    if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                    else;
                        %even stroke count: add another stroke to get a
                        %full cycle
                        if Course == 25;
                            if RaceDist >= 150;
                                caseSC = 1;
                            else;
                                caseSC = 0;
                            end;
                        else;
                            caseSC = 0;
                        end;
    
                        if caseSC == 1;
                            strokeList = strokeList(1:end-1);
                        else;
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke pre
                                    strokeList = strokeList(2:end);
                                else;
                                    li_strokeExtra = li_strokeExtra(end);
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                end;
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
    
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke post
                                    strokeList = strokeList(1:end-1);
                                else;
                                    li_strokeExtra = li_strokeExtra(1);
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
                        end;
                    end;

                    for strokeEC = 2:length(strokeList);
                        distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                        DPSEC(strokeEC-1) = distanceStroke.*2;
                    end;



% 
%                     
%                     a=zoneEC
%                     b=strokeList
%                     DistanceEC(strokeList)
% 
% 
% 
%                     c=DPSEC

                    DPSEC = mean(DPSEC);
                
%                     d=DPSEC

                
                end;
            end;

            dataTableAverage{zoneEC,4} = DPSEC;
        end;

        if updateLap == 1;
            updateLap = 0;
            lapEC = lapEC + 1;
        end;
    end;
    
    
    
    %calculate splits
    lapEC = 1;
    updateLap = 0;
    for zoneEC = 1:length(dataTableAverage(:,1));

        if zoneEC == 1;
            zone_time_ini = 0;
            
            zone_dist_end = dataZone(zoneEC,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_frame_end = minLoc(1);
            zone_time_end = TimeEC(zone_frame_end);
    
        else;
            
            zone_dist_end = dataZone(zoneEC,2);
            indexLap = find(lapLim == zone_dist_end);
            if isempty(indexLap) == 0;
                zone_time_end = SplitsAll(indexLap,2);
            else;
                zone_dist_end = dataZone(zoneEC,2);
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_frame_end = minLoc(1);
                zone_time_end = TimeEC(zone_frame_end);
            end;
        end;
        if zoneEC == 1;
            dataTableAverage{zoneEC,5} = zone_time_end - zone_time_ini;                
        else;
            dataTableAverage{zoneEC,5} = dataTableAverage{zoneEC-1,5} + (zone_time_end - zone_time_ini); 
        end;
        zone_time_ini = zone_time_end;
    end;

%     clear Athletename;
%     clear Source;
%     clear framerate;
%     clear RaceDist;
%     clear StrokeType;
%     clear Course;
%     clear Meet;
%     clear Year;
%     clear Stage;
%     clear DistanceEC;
%     clear TimeEC;
%     clear Stroke_Frame;
%     clear BOAll;
%     clear UID;
% end;
