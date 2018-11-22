function thresholdcomp(image, thresholds)
    smoothed = discgaussfft(image,3);
    gradmags = Lv(smoothed);
    figure()
    sq = ceil(sqrt(length(thresholds)));
    for c = 1:length(thresholds)
        subplot(sq,sq,c);
        showgrey((gradmags - thresholds(c)) > 0);
        title(sprintf('Threshold: %0.2f', thresholds(c)));
    end
end

