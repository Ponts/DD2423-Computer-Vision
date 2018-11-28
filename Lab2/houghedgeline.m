function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)
    smoothed = discgaussfft(pic,scale);
    mag = Lv(smoothed);
    curves = extractedge(pic,scale,gradmagnthreshold);
    [linepar, acc] = houghline(curves,mag,nrho,ntheta,gradmagnthreshold,nlines,verbose);
    subplot(1,3,1);
    showgrey(pic);
    subplot(1,3,2);
    showgrey(acc);
    for i = 1:size(linepar,2)
        theta = linepar(4,i);
        rho = linepar(3,i);
        text(theta, rho, 'o', 'color','red');
    end
    subplot(1,3,3);
    drawLines(linepar,pic);
    
end

