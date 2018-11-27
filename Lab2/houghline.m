function [linepar,acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)
    acc = zeros(nrho, ntheta);
    dtheta = pi/ntheta;
    rhoMax = sqrt(power(size(magnitude,1),2) + power(size(magnitude,2),2));
    thetas = -pi/2+dtheta:dtheta:pi/2;%linspace(-pi/2, pi/2, ntheta);
    insize = size(curves, 2);
    trypointer = 1;
    numcurves = 0;
    while trypointer <= insize
        polylength = curves(2,trypointer);
        numcurves = numcurves + 1;
        trypointer = trypointer + 1;
        
        for idx = 1:polylength
           x = curves(2,trypointer);
           y = curves(1,trypointer);
           % Why do we use another threshold
           
           for th = 1:ntheta
               rho = x*cos(thetas(th)) + y*sin(thetas(th));
               rhoIndex = int64(((rho+rhoMax)/(2*rhoMax))*nrho);
               %disp(rhoIndex);
               acc(rhoIndex, th) = acc(rhoIndex, th)+magnitude(int64(x),int64(y));
           end
           trypointer = trypointer + 1;
        end
    end
    %acc = binsepsmoothiter(acc,0.3,1);
    %Extract local maxima from accum
    
    [pos, value] = locmax8(acc);
    [~, indexvector] = sort(value);
    nmaxima = size(value,1);
    linepar = zeros(2,min(nmaxima,nlines));
    
    for idx = 1:min(nmaxima,nlines)
       rhoidxacc = pos(indexvector(nmaxima - idx + 1),1);
       thetaidxacc = pos(indexvector(nmaxima - idx + 1),2);
       linepar(2,idx) = thetas(thetaidxacc);
       linepar(1,idx) = (rhoidxacc/nrho)*(2*rhoMax) - rhoMax;
    end
    
    
    
end

