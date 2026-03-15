function xlsProperties(filename, properties, sheetnames);

%Inputs:
%
%   filename: string containing the full pathname and filename including
%       extension (.xlsx)
%
%   properties: cell containing all formating instructions
%          Sheet1 Selection1 property1 value1 ... propertyN valueN;
%                                 ...
%          SheetN SelectionN property1 value1 ... propertyN valueN;
%       
%       Sheet: String containing the sheet name
%       Selection: 'whole', 'A:A', '2:2', 'A1:D5'
%       'fontname': 'Antiqua', ...
%       'fontsize': 9, ...
%       'fontweight': 'bold'
%       'fontangle': 'italic'
%       'interiorcolor': number calculated using:
%           rgb_val = @(r,g,b) r*1+g*256+b*256^2;
%           r, g and b expressed from 0 to 255
%       'columnwidth': max 80
%       'mergecells': 1 to merge the selection
%       'horizontalalignment': 'left', 'right' or 'center'
%       'verticalalignment': 'top', 'bottom', 'middle'
%
%   sheetnames: cell
%       1 string of characters per sheet.
%
%Copyright, Marc Elipot, 2020



Excel = actxserver('Excel.Application');
set(Excel, 'Visible', 0);
set(Excel, 'DisplayAlert', 0);
Workbook = invoke(Excel.Workbooks, 'open', filename);

for instruction = 1:length(properties(:,1));

    sheetname = properties{instruction, 1};
    sheet = get(Excel.Worksheets, 'Item', sheetname);
    invoke(sheet, 'Activate');
    
    range = properties{instruction, 2};
    if strcmpi(range, 'whole');
        Excel.Cells.Select;
    else;
        ExAct = Excel.Activesheet;
        ExActRange = get(ExAct, 'Range', range);
        ExActRange.Select;
    end;
    
    proceed = 1;
    iter = 3;
    while proceed == 1;
        txtproperty = lower(properties{instruction, iter});
        valproperty = properties{instruction, iter+1};
        
        if strcmpi(txtproperty, 'fontname');
            Excel.Selection.Font.Name = valproperty;
            
        elseif strcmpi(txtproperty, 'fontsize');
            Excel.Selection.Font.Size = valproperty;
            
        elseif strcmpi(txtproperty, 'fontweight');
            if strcmpi(lower(valproperty), 'bold');
                Excel.Selection.Font.Bold = 1;
            else;
                Excel.Selection.Font.Bold = 0;
            end;
            
        elseif strcmpi(txtproperty, 'fontangle');
            if strcmpi(lower(valproperty), 'italic');
                Excel.Selection.Font.Italic = 1;
            else;
                Excel.Selection.Font.Italic = 0;
            end;
            
        elseif strcmpi(txtproperty, 'interiorcolor');
            Excel.Selection.Interior.Color = valproperty;
            
        elseif strcmpi(txtproperty, 'columnwidth');
            Excel.Selection.ColumnWidth = valproperty;
            
        elseif strcmpi(txtproperty, 'mergecells');
            Excel.Selection.MergeCells = valproperty;
            
        elseif strcmpi(txtproperty, 'horizontalalignment');
            if strcmpi(lower(valproperty), 'left');
                Excel.Selection.HorizontalAlignment = -4131;
            elseif strcmpi(lower(valproperty), 'right');
                Excel.Selection.HorizontalAlignment = -4152;
            elseif strcmpi(lower(valproperty), 'center');
                Excel.Selection.HorizontalAlignment = -4108;
            end;
            
        elseif strcmpi(txtproperty, 'verticalalignment');
            if strcmpi(lower(valproperty), 'bottom');
                Excel.Selection.VerticalAlignment = -4107;
            elseif strcmpi(lower(valproperty), 'top');
                Excel.Selection.VerticalAlignment = -4160;
            elseif strcmpi(lower(valproperty), 'middle');
                Excel.Selection.VerticalAlignment = -4108;
            end;
            
        elseif strcmpi(txtproperty, 'mergecells');
            Excel.Selection.MergeCells = valproperty;
            
        end;
       
        
        
        if iter+2 > length(properties(instruction, :));
           proceed = 0;            
        else;
            if isempty(properties{instruction, iter+2}) == 1;
                proceed = 0;
            else;
                iter = iter + 2;
            end;
        end;
    end;
end;

nbsheets = length(sheetnames);
for sh = -nbsheets:1:-1;
    sheet = get(Excel.Worksheets, 'Item', abs(sh));
    invoke(sheet, 'Activate');
    
    range = 'A1';
    ExAct = Excel.Activesheet;
    ExActRange = get(ExAct, 'Range', range);
    ExActRange.Select;
end;
    
for i = 1:nbsheets;
    Workbook.Worksheets.Item(i).Name = sheetnames{i};
end;


Workbook.Save;
Excel.Quit;
delete(Excel);
