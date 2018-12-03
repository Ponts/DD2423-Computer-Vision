function [segmentation, centers] = kmeans_segm(image, K, L, seed)
    if nargin < 3
        seed = 1337; 
    end
    rng(seed);
    [rows, cols, channels] = size(image);
    imgvec = reshape(image, rows*cols, channels);
    centers = zeros(K, channels);
    for i = 1:K
       r = randi(rows);
       c = randi(cols);
       centers(i,:) = image(r,c,:);
    end
    segmentation = zeros(1,length(imgvec));
    changes = zeros(L);
    for i = 1:L
        change = 0;
        clusterSums = zeros(K, channels);
        clusterCounters = zeros(K, 1);
        % Assign pixel to cluster
        for p = 1:length(imgvec)
            index = assignPixel(imgvec(p), centers);
            clusterSums(index,:) = clusterSums(index,:) + double(imgvec(p,:));
            clusterCounters(index) = clusterCounters(index) + 1;
            if segmentation(p) ~= index
               change = change + 1;
               segmentation(p) = index;
            end
        end
        changes(i) = change;
        for c = 1:K
            if clusterCounters(c) ~= 0
                centers(c,:) = clusterSums(c,:) ./ clusterCounters(c);
            end
        end
    end
    for p = 1:length(imgvec)
        segmentation(p) = assignPixel(imgvec(p), centers);
    end
    plot(changes);
    segmentation = reshape(segmentation, rows, cols);
end

function index = assignPixel(pixel, clusters)
    distance = pdist2(pixel, clusters(1));
    index = 1;
    [rows, ~] = size(clusters);
    for i = 2:rows
        newDist = pdist2(pixel, clusters(i));
        if  newDist < distance
           index = i;
           distance = newDist;
        end
    end
    
end

