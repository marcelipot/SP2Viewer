properties = [];
for i = 1:4;
    properties{i,1} = ['Sheet' num2str(i)];
    properties{i,2} = 'whole';
    properties{i,3} = 'fontname';
    properties{i,4} = 'Antiqua';
    properties{i,5} = 'fontsize';
    properties{i,6} = 9;
    properties{i,7} = 'fontangle';
    properties{i,8} = 'italic';
    properties{i,9} = 'verticalalignment';
    properties{i,10} = 'middle';
end;

properties{5,1} = 'Sheet1';
properties{5,2} = 'A:A';
properties{5,3} = 'columnwidth';
properties{5,4} = 13;
properties{6,1} = 'Sheet1';
properties{6,2} = 'B:B';
properties{6,3} = 'columnwidth';
properties{6,4} = 11;

properties{7,1} = 'Sheet2';
properties{7,2} = 'A:A';
properties{7,3} = 'columnwidth';
properties{7,4} = 13;
properties{8,1} = 'Sheet2';
properties{8,2} = 'B:B';
properties{8,3} = 'columnwidth';
properties{8,4} = 18;

properties{9,1} = 'Sheet3';
properties{9,2} = 'A:A';
properties{9,3} = 'columnwidth';
properties{9,4} = 9;
properties{10,1} = 'Sheet3';
properties{10,2} = 'B:B';
properties{10,3} = 'columnwidth';
properties{10,4} = 18;

properties{11,1} = 'Sheet4';
properties{11,2} = 'A:A';
properties{11,3} = 'columnwidth';
properties{11,4} = 13;
properties{12,1} = 'Sheet4';
properties{12,2} = 'B:B';
properties{12,3} = 'columnwidth';
properties{12,4} = 20;

iter = 13;
columnEC = {'C:C'; 'D:D'; 'E:E'; 'F:F'; 'G:G'; 'H:H'; 'I:I'; 'J:J'};
for race = 1:nbRaces;
    for sheet = 1:4;
        properties{iter,1} = ['Sheet' num2str(sheet)];
        properties{iter,2} = columnEC{race};
        properties{iter,3} = 'columnwidth';
        properties{iter,4} = 28;
        
        iter = iter + 1;
    end;
end;

limcol{1,1} = 'A';
limcol{1,2} = 'C';
limcol{2,1} = 'A';
limcol{2,2} = 'D';
limcol{3,1} = 'A';
limcol{3,2} = 'E';
limcol{4,1} = 'A';
limcol{4,2} = 'F';
limcol{5,1} = 'A';
limcol{5,2} = 'G';
limcol{6,1} = 'A';
limcol{6,2} = 'H';
limcol{7,1} = 'A';
limcol{7,2} = 'J';
limcol{8,1} = 'A';
limcol{8,2} = 'K';

for i = 1:limli_Summary;
    properties{iter,1} = 'Sheet1';
    properties{iter,2} = [limcol{nbRaces,1} num2str(i) ':' limcol{nbRaces,2} num2str(i)];
    properties{iter,3} = 'interiorcolor';
    properties{iter,4} = colorrowSummary(i);
    iter = iter + 1;
end;

for i = 1:limli_Stroke;
    properties{iter,1} = 'Sheet2';
    properties{iter,2} = [limcol{nbRaces,1} num2str(i) ':' limcol{nbRaces,2} num2str(i)];
    properties{iter,3} = 'interiorcolor';
    properties{iter,4} = colorrowStroke(i);
    iter = iter + 1;
end;

for i = 1:limli_Pacing;
    properties{iter,1} = 'Sheet3';
    properties{iter,2} = [limcol{nbRaces,1} num2str(i) ':' limcol{nbRaces,2} num2str(i)];
    properties{iter,3} = 'interiorcolor';
    properties{iter,4} = colorrowPacing(i);
    iter = iter + 1;
end;

for i = 1:limli_Skill;
    properties{iter,1} = 'Sheet4';
    properties{iter,2} = [limcol{nbRaces,1} num2str(i) ':' limcol{nbRaces,2} num2str(i)];
    properties{iter,3} = 'interiorcolor';
    properties{iter,4} = colorrowSkill(i);
    iter = iter + 1;
end;

for i = 1:4;
    properties{iter,1} = ['Sheet' num2str(i)];
    properties{iter,2} = 'A:A';
    properties{iter,3} = 'fontweight';
    properties{iter,4} = 'bold';
    iter = iter + 1;
end;

for i = 1:4;
    properties{iter,1} = ['Sheet' num2str(i)];
    properties{iter,2} = 'B:B';
    properties{iter,3} = 'fontweight';
    properties{iter,4} = 'bold';
    iter = iter + 1;
end;

for i = 1:4;
    properties{iter,1} = ['Sheet' num2str(i)];
    properties{iter,2} = [limcol{nbRaces,1} '1:' limcol{nbRaces,2} '1'];
    properties{iter,3} = 'fontweight';
    properties{iter,4} = 'bold';
    properties{iter,5} = 'mergecells';
    properties{iter,6} = 1;
    iter = iter + 1;
end;

for i = 1:4;
    properties{iter,1} = ['Sheet' num2str(i)];
    properties{iter,2} = [limcol{nbRaces,1} '8:' limcol{nbRaces,2} '8'];
    properties{iter,3} = 'fontweight';
    properties{iter,4} = 'bold';
    properties{iter,5} = 'mergecells';
    properties{iter,6} = 1;
    iter = iter + 1;
end;

for i = 1:4;
    properties{iter,1} = ['Sheet' num2str(i)];
    properties{iter,2} = [limcol{nbRaces,1} '1:' limcol{nbRaces,2} '1'];
    properties{iter,3} = 'horizontalalignment';
    properties{iter,4} = 'center';
    iter = iter + 1;
end;

for i = 1:4;
    properties{iter,1} = ['Sheet' num2str(i)];
    properties{iter,2} = [limcol{nbRaces,1} '8:' limcol{nbRaces,2} '8'];
    properties{iter,3} = 'horizontalalignment';
    properties{iter,4} = 'center';
    iter = iter + 1;
end;

sheetnames = {'Summary'; 'Strokes'; 'Pacing'; 'Skills'};
if ispc == 1
    if strcmpi(source, 'analyser');
        xlsProperties([pathname filename], properties, sheetnames);
    elseif strcmpi(source, 'database');
        xlsProperties(name, properties, sheetnames);
    end;
elseif ismac == 1
    
end;
