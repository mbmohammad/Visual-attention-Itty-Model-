clear; %close all; clc;
%%
load 'E:\UNI\visio neuro\Itty\EyeMovementDetectorEvaluation-master\annotated_data\originally uploaded data\images\UL23_img_Europe_labelled_MN.mat'
positions = ETdata.pos;
image = double(imread('E:\UNI\visio neuro\Itty\EyeMovementDetectorEvaluation-master\Stimuli\images\Europe1024x768.png'));
imsize = [480 640];
image = imresize(image,imsize);
image = (image-min(image(:)))/(max(image(:))-min(image(:)));
tic
[saliencyCoord,saliencyMap,conspI,conspC,conspOr,CSI,RG,BY,orientationMaps,I,R,G,B,Y] = ittiSaliency(image);
time = toc;
figure
imagesc(image)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
set(gcf, 'Name', 'original image', 'NumberTitle', 'Off') 
hold on 
scatter(positions(:,4)*640/1024, positions(:,5)*480/768,'filled','red')
