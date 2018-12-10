function normcutex(colour_bandwidth, radius, ncuts_thresh, min_area, max_depth, scale_factor, image_sigma, image)


I = imread(image);
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/normcuts1.png')
imwrite(I,'bildat_lab3/result/normcuts2.png')
subplot(1,2,1); imshow(Inew);
subplot(1,2,2); imshow(I);