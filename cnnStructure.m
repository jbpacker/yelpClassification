function net = cnnStructure()
    f = 1/100;

    % setup cnn
    run(fullfile('matconvnet-1.0-beta18', 'matlab', 'vl_setupnn.m'));

    % load cnn
    net = load('imagenet-vgg-f.mat');
    
    % replace the fc8 layer
    net.layers{21} = struct('type', 'conv', ...
                             'weights', {{f*randn(9,9,4096,15, 'single'), zeros(1, 15, 'single')}}, ...
                             'stride', 1, ...
                             'pad', 4, ...
                             'name', 'fc8') ;

    % repalce the softmx layer
    net.layers{22} = struct('type', 'softmaxloss');

    % % adding a dropout layer
    net.layers{20} = struct('type', 'dropout', 'rate', 0.5);
    
    %% adding two dropout layers
    net.layers{23} = net.layers{22};
    net.layers{22} = net.layers{21};
    net.layers{21} = net.layers{20};
    net.layers{20} = net.layers{19};
    net.layers{19} = net.layers{18};

    net.layers{18} = struct('type', 'dropout', 'rate', 0.5);

    %%
    vl_simplenn_display(net, 'inputSize', [224 224 3 50])
    
end