function [segmentation, centers] = kmeans_segm(image, K, L, seed)
    if nargin < 3
        seed = 1337; 
    end
    threshold = 0.0;
    rng(seed);
    [rows, cols, channels] = size(image);
    imgvec = double(reshape(image, rows*cols, channels));
    [colors, ~, ~] = unique(imgvec', 'rows');
    colors = colors';
    [colorsLen, ~] = size(colors);
    centers = zeros(K, channels);
    i = 1;
    iters = 0;
    while i <= K && iters < 500
       r = randi(colorsLen);
       new = reshape(colors(r,:), [1,channels]);
       %fprintf("%d, %d, %d, \n", new);
       if checkDistance(new, centers(1:i-1,:), threshold)
           centers(i,:) = new;
           i = i + 1;
       end
       iters = iters + 1;
    end
    
    segmentation = zeros(1,length(imgvec));
    changes = zeros(L);
    terminationI = L;
    for i = 1:L
        change = 0;
        clusterSums = zeros(K, channels);
        clusterCounters = zeros(K, 1);
        % Assign pixel to cluster
        for p = 1:length(imgvec)
            index = assignPixel(imgvec(p,:), centers);
            clusterSums(index,:) = clusterSums(index,:) + double(imgvec(p,:));
            clusterCounters(index) = clusterCounters(index) + 1;
            if segmentation(p) ~= index
               change = change + 1;
               segmentation(p) = index;
            end
        end
        changes(i) = change;
        for c = 1:K
            if clusterCounters(c) > 1000
                centers(c,:) = clusterSums(c,:) ./ clusterCounters(c);
            else
                iter = 0;
                while iter < 500
                    r = randi(colorsLen);
                    new = reshape(colors(r,:), [1,channels]);
                   % fprintf("%d, %d, %d, \n", new);
                    if checkDistance(new, centers, threshold)
                        centers(c,:) = new;
                        break;
                    end
                    iter = iter + 1;
                end
                %fprintf("New center at %d, %d, %d \n",centers(c,:))
            end
        end
        if change == 0
            terminationI = i;
            break;
        end
    end
    for p = 1:length(imgvec)
        segmentation(p) = assignPixel(imgvec(p,:), centers);
    end
    %plot(changes(1:terminationI));
    segmentation = reshape(segmentation, rows, cols);
end

function index = assignPixel(pixel, clusters)
    distance = pdist22(pixel, clusters(1,:));
    index = 1;
    
    [rows, ~] = size(clusters);
    for i = 2:rows
        newDist = pdist22(pixel, clusters(i,:));
        if  newDist < distance
           index = i;
           distance = newDist;
        end
    end
    
end

