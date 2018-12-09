function dist = pdist22(a, b)
    if (size(a) ~= size(b))
       error('Dimension mismatch'); 
    end
    sum = 0.0;
    for c = 1:size(a,2)
        sum = sum + ((a(1,c)) - (b(1,c)))^2;
    end
    dist = sqrt(sum);
end