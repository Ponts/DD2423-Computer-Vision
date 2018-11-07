function subsample(img, func1, func2)
    figure()
    smoothimg1 = img;
    smoothimg2 = img;
    N = 5;
    for i=1:N
        if i>1
           img = rawsubsample(img);
           smoothimg1 = func1(smoothimg1);
           smoothimg1 = rawsubsample(smoothimg1);
           smoothimg2 = func2(smoothimg2);
           smoothimg2 = rawsubsample(smoothimg2);
        end
        subplot(3,N,i);
        showgrey(img);
        subplot(3,N,i+N);
        showgrey(smoothimg1);
        subplot(3,N,i+2*N);
        showgrey(smoothimg2);
    end

end

