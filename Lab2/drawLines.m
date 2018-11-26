function drawLines(linepair, inpic)
    
    outcurves = zeros(2,4*size(linepair,2));
    for i = 1:size(linepair,2)
        rho = linepair(1,i);
        theta = linepair(2,i);
        x0 = rho*cos(theta);
        y0 = rho*sin(theta);
        dx = -100*y0;
        dy = 100*x0;
        
        
        outcurves(1, 4*(i-1)+1) = 0;
        outcurves(2, 4*(i-1)+1) = 3;
        outcurves(2, 4*(i-1)+2) = x0-dx;
        outcurves(1, 4*(i-1)+2) = y0-dy;
        outcurves(2, 4*(i-1)+3) = x0;
        outcurves(1, 4*(i-1)+3) = y0;
        outcurves(2, 4*(i-1)+4) = x0+dx;
        outcurves(1, 4*(i-1)+4) = y0+dy;
    end

    overlaycurves(inpic, outcurves);
    axis([0, size(inpic,1), 0, size(inpic,2)])
end

