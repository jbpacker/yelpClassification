clear all; close all; clc; clear mex;

dataPath = './data/lite/';
num_features = 1000;
important_label = 1;

%% setup steps
%setup/compile neural network files
run(fullfile('matconvnet-1.0-beta18', 'matlab', 'vl_setupnn.m'));

%download imagenet cnn (only need to do this once ever)
% urlwrite('http://www.vlfeat.org/matconvnet/models/imagenet-vgg-f.mat', 'imagenet-vgg-f.mat');

%% construct matrix 
cnnModel.net = load('imagenet-vgg-f.mat');
addpath('matconvnet-1.0-beta18');
%these tell me which pictures are important 
train = readtable([dataPath, 'train.csv']);
biz = readtable([dataPath, 'train_photo_to_biz_ids.csv']);

X = zeros(size(biz,1), 3+num_features);

 for b = 1:size(train,1)
    photo_ids = biz.photo_id(find(biz.business_id == train.business_id(b)));
    fprintf('business %5.0f: %2.0f of %2.0f\n', train.business_id(b), b, size(train,1));
    for i = 1:length(photo_ids)

        img = imread([dataPath, 'train_photos/', num2str(photo_ids(i)), '.jpg']);

        [classLabel, scores, batchTime] = cnnPredict(cnnModel, img, 'display', false);
        
        %for fun
        fprintf('labeled as: %s\n', char(classLabel));
        
        %output format:
        % <instance_name>,<bag_name>,<label>,<value> ... <value>
        X(i,1) = photo_ids(i);
        X(i,2) = train.business_id(b);
        X(i,3) = ~isempty(strfind(char(train.labels(b)), num2str(important_label)));
        X(i,4:end) = scores';
    end
end