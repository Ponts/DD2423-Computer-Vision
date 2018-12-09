function kmeansexample(K, L, seed, scale_factor, image_sigma, image)



I = imread(image);
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/kmeans1.png')
imwrite(I,'bildat_lab3/result/kmeans2.png')
end