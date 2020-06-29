                                 
function security_cam()

clear all; close all; clc; imaqreset;

hCamera = webcam;

%  Create a handle to an imshow figure for faster updating
hShow = imshow(zeros(480,640,3,'uint8'));title('Security Camera');

ref_vid_img = snapshot(hCamera);



frames = 2000;
for i = 1:frames

% Acquire an image from the webcam
    vid_img = snapshot(hCamera);

% Call the live segmentation function
    object_detected = Segmentation_Fn_UI(vid_img, ref_vid_img);

%  Update the imshow handle with a new image 
    set(hShow,'CData',object_detected);
    drawnow;
end


stop(hCamera);
delete(hCamera);
