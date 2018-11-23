function vv = Lvvtilde(image, shape)
    if (nargin < 2)
        shape = 'same';
    end
    Lx = conv2(image, deltax, shape);
    Ly = conv2(image, deltay, shape);
    Lxx = conv2(image, deltaxx, shape);
    Lyy = conv2(image, deltayy, shape);
    Lxy = conv2(Lx, deltay, shape);
    vv = power(Lx,2).*Lxx + 2.*Lx.*Ly.*Lxy + power(Ly,2).*Lyy;
end

