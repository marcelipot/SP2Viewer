if Source == 1 | Source == 3;
    eval(['RaceLocation = handles.RacesDB.' UID '.RaceLocation;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    
    %Start interpolation
    indexDive = find(RaceLocation(:,5) == 15); 
    if isnan(RaceLocation(indexDive,3)) == 1;
        isInterpolatedDive = 1;
    else;
        isInterpolatedDive = 0;
    end;

    %Turns interpolation
    isInterpolatedTurns = zeros(NbLap-1,3);
    for lap = 1:NbLap-1;
        if Source == 1;
            %reverse the distance for each lap
            if rem(lap,2) == 1;
                %odd laps
                index50 = find(RaceLocation(:,5) == Course);
                index50 = index50((lap+1)/2);
                TurnLocation = RaceLocation(index50-2:index50+2,:);
                indexIn = find(TurnLocation(:,5) == Course-5);
                indexOut = find(TurnLocation(:,5) == Course-10); 
                if isnan(TurnLocation(indexIn,3)) == 1;
                    isInterpolatedTurns(lap,1) = 1;
                    isInterpolatedTurns(lap,3) = 1; 
                end;
                if isnan(TurnLocation(indexOut,3)) == 1;
                    isInterpolatedTurns(lap,2) = 1;
                    isInterpolatedTurns(lap,3) = 1;
                end;
            else;
                %even laps
                index0 = find(RaceLocation(:,5) == 0);
                index0 = index0((lap/2)+1);
                TurnLocation = RaceLocation(index0-2:index0+2,:);
                indexIn = find(TurnLocation(:,5) == 5);
                indexOut = find(TurnLocation(:,5) == 10); 
                if isnan(TurnLocation(indexIn,3)) == 1;
                    isInterpolatedTurns(lap,1) = 1;
                    isInterpolatedTurns(lap,3) = 1; 
                end;
                if isnan(TurnLocation(indexOut,3)) == 1;
                    isInterpolatedTurns(lap,2) = 1;
                    isInterpolatedTurns(lap,3) = 1;
                end;
            end;
            
        elseif Source == 3;
            %cumulative distance
            TurinDist = (lap*Course) - 5;
            TurOutDist = (lap*Course) + 10;
            indexIn = find(RaceLocation(:,5) == TurinDist);
            indexOut = find(RaceLocation(:,5) == TurOutDist); 
            if isnan(RaceLocation(indexIn,3)) == 1;
                isInterpolatedTurns(lap,1) = 1;
                isInterpolatedTurns(lap,3) = 1; 
            end;
            if isnan(RaceLocation(indexOut,3)) == 1;
                isInterpolatedTurns(lap,2) = 1;
                isInterpolatedTurns(lap,3) = 1;
            end;
        end;
    end;

    %Finish interpolation
    if Source == 1;
        if RaceDist == 50 | RaceDist == 150;
            indexFinish = find(RaceLocation(:,5) == Course-5); 
            indexFinish = indexFinish(end);
        else;
            indexFinish = find(RaceLocation(:,5) == 5); 
            indexFinish = indexFinish(end);
        end;
    elseif Source == 3;
        indexFinish = find(RaceLocation(:,5) == RaceDist-5); 
    end;
    if isnan(RaceLocation(indexFinish,3)) == 1;
        isInterpolatedFinish = 1;
    else;
        isInterpolatedFinish = 0;
    end;

    if isInterpolatedDive == 0 & isempty(find(isInterpolatedTurns) == 1) == 1 & isInterpolatedFinish == 0;
        isInterpolatedSkills = 0;
    else;
        isInterpolatedSkills = 1;
    end;
else;
    RaceLocation = [];
    isInterpolatedDive = 0;
    isInterpolatedFinish = 0;
    isInterpolatedTurns = zeros(NbLap-1,3);
    isInterpolatedSkills = 0;
end;