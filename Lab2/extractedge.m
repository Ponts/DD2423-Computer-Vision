function curves = extractedge(inpic, scale, threshold, shape)
    if nargin < 3
        shape = 'same';
        threshold = 0;
    elseif nargin < 4
        shape='same';
    end
    
    smoothed = discgaussfft(inpic,scale);
    mags = Lv(smoothed,shape);
    Lvv = Lvvtilde(smoothed, shape);
    Lvvv = Lvvvtilde(smoothed, shape);
    
    curves = zerocrosscurves(Lvv, (Lvvv<0)-0.5);
    curves = thresholdcurves(curves, mags-threshold);

end

