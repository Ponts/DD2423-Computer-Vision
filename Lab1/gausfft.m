function newPic = gausfft(pic,t)
    xRaise = mod(mod(size(pic,1),2) + 1,2);
    yRaise = mod(mod(size(pic,2),2) + 1,2);
    [X, Y] = meshgrid(ceil(-size(pic,1)/2):1:(floor(size(pic,1)/2)-xRaise), ceil(-size(pic,2)/2):1:(floor(size(pic,2)/2))-yRaise);
    
    gauss = (1/(2*pi*t))*exp(-(X.^2 + Y.^2)/(2*t));
    ftFilter = fftshift(fft2(gauss));
    ftPic = fftshift(fft2(pic));
    
    ftfiltered = ftPic.*ftFilter;
    
    newPic = ifft(ftfiltered);
end

