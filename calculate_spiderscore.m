ScoreRaw.StartRT(race,1) = RT;
ScoreRaw.StartBO(race,1) = BOEffStart;
try;
    ScoreRaw.StartBOCorr(race,1) = BOEffCorrStart;
catch
    ScoreRaw.StartBOCorr(race,1) = 0;
end;

if isempty(StartEntryDist) == 1;
    ScoreRaw.StartFlyDist(race,1) = 0; 
    ScoreRaw.StartUWS(race,1) = 0;
else;
    ScoreRaw.StartFlyDist(race,1) = StartEntryDist; 
    ScoreRaw.StartUWS(race,1) = StartUWVelocity;
end;
if NbLap ~= 1;
    for lap = 1:NbLap-1;
        ScoreRaw.TurnApproach(race,lap) = ApproachEffTurn(lap);
        ScoreRaw.TurnBO(race,lap) = BOEffTurn(lap);
        try;
            ScoreRaw.TurnBOCorr(race,lap) = BOEffCorrTurn(lap);
        catch;
            ScoreRaw.TurnBOCorr(race,lap) = 0;
        end;
    end;
    ScoreRaw.TurnApproachBest(race,1) = max(ScoreRaw.TurnApproach(race,:));
    ScoreRaw.TurnApproachWorst(race,1) = min(ScoreRaw.TurnApproach(race,:));
    ScoreRaw.TurnApproachMean(race,1) = mean(ScoreRaw.TurnApproach(race,:));
    ScoreRaw.TurnBOBest(race,1) = max(ScoreRaw.TurnBO(race,:));
    ScoreRaw.TurnBOWorst(race,1) = min(ScoreRaw.TurnBO(race,:));
    ScoreRaw.TurnBOMean(race,1) = mean(ScoreRaw.TurnBO(race,:));
    ScoreRaw.TurnBOBestCorr(race,1) = max(ScoreRaw.TurnBOCorr(race,:));
    ScoreRaw.TurnBOWorstCorr(race,1) = min(ScoreRaw.TurnBOCorr(race,:));
    ScoreRaw.TurnBOMeanCorr(race,1) = mean(ScoreRaw.TurnBOCorr(race,:));
end;
if NbLap == 1;
    ScoreRaw.LastApp(race,1) = ApproachEffLast;
end;

normRT = RefRT./ScoreRaw.StartRT(race,1);
ScoreSpider.StartRT(race,1) = (54.791.*(normRT.^2)) - (63.066.*normRT) + 18.216;

normSBO = (ScoreRaw.StartBOCorr(race,1).*100)./RefStBOEff;
ScoreSpider.StartBO(race,1) = (coef1StBOEff.*(normSBO.^3)) + (coef2StBOEff.*normSBO^2) + (coef3StBOEff.*normSBO) + coef4StBOEff;

if isempty(StartEntryDist) == 1;
    ScoreSpider.StartFlyDist(race,1) = 0;
    ScoreSpider.StartUWS(race,1) = 0;
else;
    normFlyDist = ScoreRaw.StartFlyDist(race,1)./RefFlyDist;
    ScoreSpider.StartFlyDist(race,1) = (coef1FlyDist.*(normFlyDist.^2)) + (coef2FlyDist.*normFlyDist) + coef3FlyDist;
    
    normUWS = ScoreRaw.StartUWS(race,1)./RefUWS;
    ScoreSpider.StartUWS(race,1) = (coef1UWS.*(normUWS.^2)) + (coef2UWS.*normUWS) + coef3UWS;
end;

if NbLap ~= 1;
    for lap = 1:NbLap-1;
        normTapp = ScoreRaw.TurnApproach(race,lap)./RefTuAppEff;
        ScoreSpider.TurnApproach(race,lap) = (2.5.*normTapp) + 7.5;
        
        normTBO = (ScoreRaw.TurnBOCorr(race,lap).*100)./RefTuBOEff;
        ScoreSpider.TurnBO(race,1) = (coef1TuBOEff.*(normTBO.^3)) + (coef2TuBOEff.*normTBO^2) + (coef3TuBOEff.*normTBO) + coef4TuBOEff;
    end;
    ScoreSpider.TurnApproachBest(race,1) = max(ScoreSpider.TurnApproach(race,:));
    ScoreSpider.TurnApproachWorst(race,1) = min(ScoreSpider.TurnApproach(race,:));
    ScoreSpider.TurnApproachMean(race,1) = mean(ScoreSpider.TurnApproach(race,:));
    ScoreSpider.TurnBOBest(race,1) = max(ScoreSpider.TurnBO(race,:));
    ScoreSpider.TurnBOWorst(race,1) = min(ScoreSpider.TurnBO(race,:));
    ScoreSpider.TurnBOMean(race,1) = mean(ScoreSpider.TurnBO(race,:));
end;
if NbLap == 1;
    normFinish = ScoreRaw.LastApp(race,:)./RefLastAppEff;
    ScoreSpider.LastApp(race,:) = (2.5.*normFinish) + 7.5;
end;
