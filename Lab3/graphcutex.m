function graphcutex(scale_factor, area, K, alpha, sigma, image) 
I = imread(image);
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/graphcut1.png')
imwrite(I,'bildat_lab3/result/graphcut2.png')
imwrite(prior,'bildat_lab3/result/graphcut3.png')
subplot(2,2,2); imshow(Inew);
subplot(2,2,3); imshow(I);
subplot(2,2,4); imshow(prior);