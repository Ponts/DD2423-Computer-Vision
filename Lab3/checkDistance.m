function check = checkDistance(new,clusters, threshold)
    [cols, ~] = size(clusters);
    check = true;
    for i = 1:cols
        if pdist22(new, clusters(i,:)) < threshold
            check = false;
            break;
        end
    end
end

