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
           trypointer = trypointer + 1;
           if magnitude(int64(round(x)),int64(round(y))) < threshold
               continue
           end
           for th = 1:ntheta
               rho = x*cos(thetas(th)) + y*sin(thetas(th));
               rhoIndex = int64(((rho+rhoMax)/(2*rhoMax))*nrho);
               %disp(rhoIndex);
               acc(rhoIndex, th) = acc(rhoIndex, th)+magnitude(int64(round(x)),int64(round(y)));
           end
           
        end
    end
    acc = binsepsmoothiter(acc,0.1,3);
    %Extract local maxima from accum
    
    [pos, value] = locmax8(acc);
    [~, indexvector] = sort(value);
    nmaxima = size(value,1);
    linepar = zeros(4,min(nmaxima,nlines));
    added = 0;
    idx = 1;
    cont = 1;
    while added < min(nmaxima,nlines) && idx < length(indexvector)
       
       rhoidxacc = pos(indexvector(nmaxima - idx + 1),1);
       thetaidxacc = pos(indexvector(nmaxima - idx + 1),2);
       for i = 1:added
          if abs(thetas(thetaidxacc) - linepar(2,i)) < 0.2 && abs((rhoidxacc/nrho)*(2*rhoMax) - rhoMax - linepar(1,i)) < 10
              cont = 0;
              break
          end
       end
       if cont == 0
           cont = 1;
           idx = idx + 1;
           continue
       end
       linepar(4,added+1) = thetaidxacc;
       linepar(3,added+1) = rhoidxacc;
       linepar(2,added+1) = thetas(thetaidxacc);
       linepar(1,added+1) = (rhoidxacc/nrho)*(2*rhoMax) - rhoMax;
       added = added + 1;
       idx = idx + 1;
    end
    
    
    
end

