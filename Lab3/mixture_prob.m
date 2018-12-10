function prob = mixture_prob(image, K, L, mask)
    [col, row, channels] = size(image);
    Ivec = double(reshape(image, col*row, channels));
    Mvec = double(reshape(mask, col*row, 1));
    %I = image .* repmat(mask, [1,1,3]);
    %I = uint8(bsxfun(@times, Ivec, cast(Mvec,class(Ivec))));
    %imshow(reshape(I, col,row,channels));
    %pause;
    cov = cell(K,1);
    w = zeros(K,1);
    w(:) = 1/K;
    u = zeros(K,3);
    maskedP = find(Mvec);
    IvecMasked = Ivec(maskedP,:);
    colors = unique(IvecMasked, 'rows');
    N = size(IvecMasked,1);
    if size(maskedP,1) == 0
        prob = zeros(1,col*row);
        return;
    end
    for k = 1:K  
        ci = randi(size(colors,1));
        u(k,:) = colors(ci,:);
        colors(ci,:)=[];       
        A = (randn(channels, channels) + 1)*0.5;
        A = 0.5*(A+A');
        cov{k} = A + 10000*eye(channels);
    end
    
    g = zeros(K, N);
    for l = 1:L
        %calculate g
        for k = 1:K
            g(k,:) = max(mvnpdf(IvecMasked,u(k,:),cov{k}), 1e-200);
        end
        %calculate p
        lowerSum = w' * g;
        %lowerSum(lowerSum == 0) = 1;
        base = repmat(w, [1,N]) .* g;
        p = base ./ repmat(lowerSum, [K,1]);
        %calculate w
        w = mean(p,2);
        %calculate mean
        lowerSum = sum(p,2);
        u =  (p * IvecMasked) ./ repmat(lowerSum, [1,channels]);
        %calculate cov
        for k = 1:K
            diff = bsxfun(@minus, IvecMasked, u(k,:));
            base = (repmat(p(k,:),channels,1)'.*diff)'*diff;
            cov{k} = base/(lowerSum(k));
        end        
    end
    g = zeros(K, col*row);
    for k = 1:K
        g(k,:) = mvnpdf(Ivec,u(k,:),cov{k});
    end

    prob = sum(repmat(w, [1,col*row]) .* g, 1);   
end

