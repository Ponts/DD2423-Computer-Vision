function vvv = Lvvvtilde(image)
    Lx = conv2(image, deltax, 'same');
    Ly = conv2(image, deltay,  'same');
    Lxx = conv2(image, deltaxx, 'same');
    Lyy = conv2(image, deltayy, 'same');
    Lxy = conv2(Lx, deltay, 'same');
    Lxxx = conv2(Lxx, deltax, 'same');
    Lxxy = conv2(Lxx, deltay, 'same');
    Lxyy = conv2(Lxy, deltay, 'same');
    Lyyy = conv2(Lyy, deltay, 'same');
    vvv = pow(Lx,3).*Lxxx + 3.*pow(Lx,2).*Ly.*Lxxy + 3.*Lx.*pow(Ly,2).*Lxyy + pow(Ly,3).*Lyyy;
    
end
