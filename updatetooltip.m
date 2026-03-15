function TooltipMain = updatetooltip(ptmouseUI, TooltipMain, txtTooltip, isInzone, PosUI)



if ptmouseUI(1,1) == TooltipMain.mousepos(1,1) & ...
        ptmouseUI(1,2) == TooltipMain.mousepos(1,2);

    
    %static for 2 seconds... display the tooltip
    if TooltipMain.activestatus == 0;
        PosEC = [ptmouseUI(1,1) ptmouseUI(1,2) ptmouseUI(1,1)+10 ptmouseUI(1,2)+20];
        set(TooltipMain.disptext, 'Position', PosEC, 'String', txtTooltip);
        posExtent = get(TooltipMain.disptext, 'Extent');
        PosEC = [ptmouseUI(1,1)-(posExtent(3)+20)./2 ...
            ptmouseUI(1,2) ...
            posExtent(3)+20 ...
            20];

        if PosEC(1) <= 0;
            PosEC(1) = 1;
        end;
        if PosEC(2) <= 0;
            PosEC(2) = 1;
        end;
        if PosEC(1)+PosEC(3) >= PosUI(3);
            b=1
            PosEC(1) = PosUI(3)-PosEC(3)-1;
        end;
        if PosEC(2)+PosEC(4) >= PosUI(4);
            PosEC(2) = PosUI(4)-PosEC(4)-1;
        end;

        set(TooltipMain.disptext, 'Position', PosEC, 'Visible', 'on');

        TooltipMain.activestatus = 1;
    end;

else;
    %moving hide the tooltip;
    TooltipMain.activestatus = 0;
    set(TooltipMain.disptext, 'Visible', 'off');
end;



