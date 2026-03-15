ScoreRaw.StartRT(race,1) = (RefRT - RT)./RefRT;
ScoreRaw.StartBO(race,1) = BOEffStart;
ScoreRaw.StartFlyDist(race,1) = 0; %%%%%%%%%%%%%%%%%%%%%%%%%%
ScoreRaw.StartUWS(race,1) = 0; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if NbLap ~= 1;
    for lap = 1:NbLap-1;
        ScoreRaw.TurnApproach(race,lap) = ApproachEffTurn(lap);
        ScoreRaw.TurnBO(race,lap) = BOEffTurn(lap);
    end;
    ScoreRaw.TurnApproachBest(race,1) = max(ScoreRaw.TurnApproach(race,:));
    ScoreRaw.TurnApproachWorst(race,1) = min(ScoreRaw.TurnApproach(race,:));
    ScoreRaw.TurnApproachMean(race,1) = mean(ScoreRaw.TurnApproach(race,:));
    ScoreRaw.TurnBOBest(race,1) = max(ScoreRaw.TurnBO(race,:));
    ScoreRaw.TurnBOWorst(race,1) = min(ScoreRaw.TurnBO(race,:));
    ScoreRaw.TurnBOMean(race,1) = mean(ScoreRaw.TurnBO(race,:));
end;
if NbLap == 1;
    ScoreRaw.LastApp(race,1) = ApproachEffLast;
end;


ScoreSpider.StartRT(race,1) = (5.5166.*(ScoreRaw.StartRT(race,1).^3)) + (14.366.*(ScoreRaw.StartRT(race,1).^2)) + (13.45.*(ScoreRaw.StartRT(race,1))) + 9.9979;
ScoreSpider.StartBO(race,1) = (52.417.*(ScoreRaw.StartBO(race,1).^3)) + (55.634.*(ScoreRaw.StartBO(race,1).^2)) + (28.442.*(ScoreRaw.StartBO(race,1))) + 7.3709;
%     ScoreSpider.StartFlyDist = (-76.197.*(ScoreRaw.StartFlyDist.^3)) + (77.884.*(ScoreRaw.StartFlyDist.^2)) - (31.509.*(ScoreRaw.StartFlyDist)) + 10.126;
ScoreSpider.StartFlyDist(race,1) = 0;
%     ScoreSpider.StartUWS = (-34.644.*(ScoreRaw.StartUWS.^3)) + (45.913.*(ScoreRaw.StartUWS.^2)) - (23.892.*(ScoreRaw.StartUWS)) + 10.129;
ScoreSpider.StartUWS(race,1) = 0;
if NbLap ~= 1;
    for lap = 1:NbLap-1;
        ScoreSpider.TurnApproach(race,lap) = (-80.899.*(ScoreRaw.TurnApproach(race,lap).^3)) + (72.43.*(ScoreRaw.TurnApproach(race,lap).^2)) + (35.888.*(ScoreRaw.TurnApproach(race,lap))) + 8.4677;
        ScoreSpider.TurnBO(race,lap) = (49.229.*(ScoreRaw.TurnBO(race,lap).^3)) + (54.604.*(ScoreRaw.TurnBO(race,lap).^2)) + (28.396.*(ScoreRaw.TurnBO(race,lap))) + 6.5738;
    end;
    ScoreSpider.TurnApproachBest(race,1) = max(ScoreSpider.TurnApproach(race,:));
    ScoreSpider.TurnApproachWorst(race,1) = min(ScoreSpider.TurnApproach(race,:));
    ScoreSpider.TurnApproachMean(race,1) = mean(ScoreSpider.TurnApproach(race,:));
    ScoreSpider.TurnBOBest(race,1) = max(ScoreSpider.TurnBO(race,:));
    ScoreSpider.TurnBOWorst(race,1) = min(ScoreSpider.TurnBO(race,:));
    ScoreSpider.TurnBOMean(race,1) = mean(ScoreSpider.TurnBO(race,:));
end;
if NbLap == 1;
    ScoreSpider.LastApp(race,:) = (-80.899.*(ScoreRaw.LastApp(race,:).^3)) + (72.43.*(ScoreRaw.LastApp(race,:).^2)) + (35.888.*(ScoreRaw.LastApp(race,:))) + 8.4677;
end;