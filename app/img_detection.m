function [highlighted_img] = Segmentation_Fn(img1, img2)
img1 = imread('TestImage1.jpg');
img2 = imread('TestImage2.jpg');
%figure
%imshow(img1)
%figure
%imshow(img2)

% Convert colour images to greyscale
img1_bw = rgb2gray(img1);
img2_bw = rgb2gray(img2);

%Show these images
%figure
%imtool(img1_bw)
%figure
%imtool(img2_bw)

%Subtract Images
img_diff = abs(img1_bw - img2_bw);

%Show the difference
%figure
%imtool(img_diff)

%Find Center of Mass
com = max(max(img_diff));
[row_cm , col_cm] = find(img_diff == com);

%imshow(img_diff)
%hold on
%plot(col_cm , row_cm , 'r*')

%For any pixel size greater than 8px , count the spot to be white; or else
%count it to be black

img_thresh = img_diff > 8;
%figure
%imshow(img_thresh)
%hold on
%plot(col_cm , row_cm , 'r*')

%Eliminate NoiseimgFilled = bwareaopen(img_thresh, 15); %Remove small objects from binary image
%figure
%imshow(imgFilled)

%Overlay the image
img_overlay = imoverlay(img2 , imgFilled, [1,0,0]);
highlighted_img = img_overlay;
%figure
%imshow(img_overlay);

%Only allow stuff grater than 90 cms (Human)
image_stats = regionprops(imgFilled, 'MajorAxisLength');
img_lengths = [image_stats.MajorAxisLength];
idx = img_lengths > 80;
imageStatsFinal = imageStats(idx);
%disp(imageStatsFinal)

%Warn
if isempty(imageStatsFinal)
    disp(' You are safe! ');
else
    disp(' Danger!! ');
end

