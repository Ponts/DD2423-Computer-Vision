function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)
    smoothed = discgaussfft(pic,scale);
    mag = Lv(smoothed);
    curves = extractedge(pic,scale,gradmagnthreshold);
    [linepar, acc] = houghline(curves,mag,nrho,ntheta,gradmagnthreshold,nlines,verbose);
    rhoMax = sqrt(power(size(pic,1),2) + power(size(pic,2),2));
    subplot(1,3,1);
    showgrey(pic);
    subplot(1,3,2);
    showgrey(flip(acc));
    subplot(1,3,3);
    drawLines(linepar,pic);
    %axis([-pi/2, pi/2, -rhoMax, rhoMax])
    
end

