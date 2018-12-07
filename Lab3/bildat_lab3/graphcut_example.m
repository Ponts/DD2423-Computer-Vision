scale_factor = 0.5;          % image downscale factor
area = [80,400,500,530];%[ 80, 170, 570, 300 ];%[ 80, 110, 570, 300 ];% image region to train foreground with
K = 3;                      % number of mixture components
alpha = 10.0;                 % maximum edge cost
sigma = 55.0;                % edge cost decay factor

I = imread('flamingo.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/graphcut1.png')
imwrite(I,'bildat_lab3/result/graphcut2.png')
imwrite(prior,'bildat_lab3/result/graphcut3.png')
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(I);
subplot(2,2,3); imshow(prior);
