function prob = mixture_prob(image, K, L, mask)
    [col, row, channels] = size(image);
    
   
    
    Ivec = double(reshape(image, col*row, channels));
    Mvec = double(reshape(mask, col*row, 1));
    %I = image .* repmat(mask, [1,1,3]);
    I = (bsxfun(@times, Ivec, cast(Mvec,class(Ivec))));
    cov = cell(K,1);
    w = zeros(K,1);
    w(:) = 1/K;
    u = zeros(K,3);
    maskedP = find(Mvec);
    if size(maskedP,1) == 0
        prob = zeros(col,row);
        return;
    end
    for k = 1:K
        i = maskedP(randi(size(maskedP,1)));
        u(k,:) = I(i,:);
        cov{k} = eye(3);
    end
    
    g = zeros(K, col*row);
    %p = zeros(K, col*row);
    for l = 1:L
        %calculate g
        for k = 1:K
            g(k,:) = mvnpdf(I,u(k),cov{k});
        end
        %calculate p
        lowerSum = w' * g;
        lowerSum(lowerSum == 0) = 1;
        base = repmat(w, [1,col*row]) .* g;
        p = base ./ lowerSum;
        %for i = 1:col*row
        %   wgk = w .* g(:,i);
        %   lower = sum(wgk);
        %   p(:,i) = wgk ./ lower;         
        %end
        %calculate w
        w = mean(p,2);
        %calculate mean
        lowerSum = sum(p,2);
        
        u =  (p * I) ./ lowerSum;
        
        %calculate cov
        for k = 1:K
            cov{k} = zeros(channels,channels);
            for i = 1:col*row
                diff = I(i,:) - u(k,:);
                diff = p(k,i).*(diff' * diff);
                cov{k} = cov{k} + diff;
            end
           %diff = I - repmat(u(k,:), [col*row,1]);
           %diff = 
           %left = repmat(p(k,:)',[1,3]);
           %disp(size(diff));
           %left = diff .* left;
           %cov{k} = left ./ lowerSum(k);
        end
                
    end
    
    prob = sum(repmat(w, [1,col*row]) .* g,1);
    disp(size(prob));
    %prob = bsxfun(@times, prob, Mvec');
    
    
    %prob = uint8(reshape(I, col, row, channels));
    
    
end

