function meanshiftex(scale_factor, spatial_bandwidth, colour_bandwidth, num_iterations, image_sigma, image)

I = imread(image);
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/meanshift1.png')
imwrite(I,'bildat_lab3/result/meanshift2.png')
subplot(1,2,1); imshow(Inew);
subplot(1,2,2); imshow(I);

end