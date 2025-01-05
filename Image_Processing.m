%% Stage 1 : Remove Pepper and Salt Noise

% Read the input image with salt-and-pepper noise
inputImage = imread('input_1.png'); % Replace 'your_image_with_noise.jpg' with the actual image file

inputImage = im2double(inputImage);

% Apply median filter for noise removal
filterSize = 3; 
stage_1 = medfilt3(inputImage, [filterSize, filterSize, filterSize]); % Adjust the filter size as needed

%% Display after Stage 1
figure;
subplot(2,3,1);
imshow(inputImage);
title('Original Image');
subplot(2,3,2);
imshow(stage_1);
title('Stage 1: Removing Salt and Pepper Noise');

%% Stage 2 : Sharpen the image

% Define the Laplacian filter kernel
LaplacianFliter = [0, -1, 0; -1, 4, -1; 0, -1, 0];

% Apply the Laplacian filter for image sharpening
stage_2 = imfilter(stage_1, LaplacianFliter);

% Adjust the strength of sharpening (optional)
sharpeningFactor = 3;
stage_2 = stage_1 + sharpeningFactor * stage_2;

%% Display after Stage 2
subplot(2,3,3);
imshow(stage_2);
title('Stage 2: Sharpened Image');

%% Stage 3 : Remove sharpening Noise

filterSize = 5; 
stage_3 = medfilt3(stage_2, [filterSize, filterSize, filterSize]); % Adjust the filter size as needed

%% Display after Stage 3
subplot(2,3,4);
imshow(stage_3);
title('Stage 3: Removing Sharpening Noise');

%% Stage 4 : Histogram Equalization

% Convert the image to grayscale if it's a color image
if size(stage_3, 3) == 3
    grayImage = rgb2gray(stage_3);
else
    grayImage = stage_3;
end

% Perform histogram equalization
equalizedImage = histeq(grayImage);

%% Display after Stage 4
subplot(2,3,5);
imshow(equalizedImage);
title('Stage 4: Histogram Equalization');

%% Final Comparison
figure;
subplot(1,2,1);
imshow(inputImage);
title('Original Image');
subplot(1,2,2);
imshow(equalizedImage);
title('Final Processed Image');
