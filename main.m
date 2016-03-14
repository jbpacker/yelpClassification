close all; clear all; clc;

run(fullfile('matconvnet-1.0-beta18', 'matlab', 'vl_setupnn.m'));

% construct matrix 
cnnModel.net = load('imagenet-vgg-f.mat');
addpath('matconvnet-1.0-beta18');

imdb = setupData(cnnModel.net.meta.normalization.averageImage);