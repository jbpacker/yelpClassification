close all; clear all; clc;

net = cnnStructure();
imdb = setupData(net.meta.normalization.averageImage);
