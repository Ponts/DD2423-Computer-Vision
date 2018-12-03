function dist = pdist2(a, b)
    if (size(a) ~= size(b))
       error('Dimension mismatch'); 
    end
    sum = 0.0;
    for c = 1:length(a)
        sum = sum + (double(a(c)) - double(b(c)))^2;
    end
    dist = sqrt(sum);
end

