function [] = resizefullscreenSkill(varargin)



Data_table = varargin{3};
fontTable = varargin{4};

set(gcf, 'units', 'pixels');
FigPos = get(gcf, 'position');
set(gcf, 'units', 'normalized');
FigPos = FigPos(3:4);
IniPos = [1280 720];
RatioPos = [FigPos(1)./IniPos(1) FigPos(2)./IniPos(2)];

colWidthNorm = [];
colWidthNorm{1} = floor(200.*RatioPos(1));
colWidthNorm{2} = floor(60.*RatioPos(1));
colWidthNorm{3} = floor(60.*RatioPos(1));
colWidthNorm{4} = floor(60.*RatioPos(1));
colWidthNorm{5} = floor(90.*RatioPos(1));
colWidthNorm{6} = floor(100.*RatioPos(1));
colWidthNorm{7} = floor(60.*RatioPos(1));
colWidthNorm{8} = floor(110.*RatioPos(1));
colWidthNorm{9} = floor(60.*RatioPos(1));
colWidthNorm{10} = floor(100.*RatioPos(1));
colWidthNorm{11} = floor(130.*RatioPos(1));
colWidthNorm{12} = floor(60.*RatioPos(1));
colWidthNorm{13} = floor(90.*RatioPos(1));
colWidthNorm{14} = floor(99.*RatioPos(1));
fontTableNorm = fontTable.*RatioPos(2);

set(Data_table, 'ColumnWidth', colWidthNorm, 'FontSize', fontTableNorm);