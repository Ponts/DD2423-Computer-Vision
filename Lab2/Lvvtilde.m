function vv = Lvvtilde(image)
    Lx = conv2(image, deltax,'same');
    Ly = conv2(image, deltay, 'same');
    Lxx = conv2(image, deltaxx, 'same');
    Lyy = conv2(image, deltayy, 'same');
    Lxy = conv2(Lx, deltay, 'same');
    vv = power(Lx,2).*Lxx + 2.*Lx.*Ly.*Lxy + power(Ly,2).*Lyy;
end

