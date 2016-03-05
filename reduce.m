clear all; close all; clc;

%% setup steps
%setup/compile neural network files
run(fullfile('matconvnet-1.0-beta18', 'matlab', 'vl_setupnn.m'));

%download imagenet cnn (only need to do this once ever)
% urlwrite('http://www.vlfeat.org/matconvnet/models/imagenet-vgg-f.mat', 'imagenet-vgg-f.mat');

%% construct matrix 
cnnModel.net = load('imagenet-vgg-f.mat');
addpath('matconvnet-1.0-beta18');
%these tell me which pictures are important 
train = readtable('data/lite/train.csv');
biz = readtable('data/lite/train_photo_to_biz_ids.csv');

for b = 1:size(train,1)
    photo_ids = biz.photo_id(find(biz.business_id == train.business_id(b)));
    for i = 1:length(photo_ids)

        img = imread(['data/train_photos/', num2str(photo_ids(i)), '.jpg']);

%         [featureVector, hogVisualization] = extractHOGFeatures(img, 'CellSize', [6 6]);
        [classLabel, scores, batchTime] = cnnPredict(cnnModel, img, 'display', false);
        
        figure;
        imshow(img); hold on;
        X(i,:) = featureVector;
    end
end