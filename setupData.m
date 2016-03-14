function imdb = setupData(averageImage)

    dataPath = './data/lite/';

    %% init
    train = readtable([dataPath, 'train.csv']);
    biz = readtable([dataPath, 'train_photo_to_biz_ids.csv']);

    num_images = size(biz,1);
    num_businesses = size(train,1);
    image_size = [224 224];
    imdb.images.data = zeros(image_size(1), image_size(2), 3, num_images, 'single');
    imdb.images.labels = zeros(9, num_images, 'single');
    imdb.images.set = zeros(1, num_images, 'uint8');
    imdb.images.id = zeros(1, num_images);
    imdb.images.biz = zeros(1, num_images);
    Kfolds = 10;
    
    % returns which bucket everythign goes into. Will have to do the
    % grouping myself if I want to expand it past 2 folds.
    setIdx = crossvalind('Kfold', num_businesses, Kfolds);

    counter = 1;

    %% populate struct
    for k = 1 %:Kfolds %for more testing!
        for b = 1:size(train,1)
            photo_ids = biz.photo_id(find(biz.business_id == train.business_id(b)));
            fprintf('business %5.0f: %2.0f of %2.0f\n', train.business_id(b), b, size(train,1));
            for i = 1:length(photo_ids)
                %image fun
                img = imread([dataPath, 'train_photos/', num2str(photo_ids(i)), '.jpg']);
                img = imresize(single(img), image_size);
                img = img - single(averageImage);

                %output into struct:
                imdb.images.data(:,:,:,counter) = img;
                if (setIdx(b) ~= k) %train
                    imdb.images.set(1,counter) = 1;
                else %test
                    imdb.images.set(1,counter) = 2;
                end
                imdb.images.id(1,counter) = photo_ids(i);
                imdb.images.biz(1,counter) = train.business_id(b);
    
                for j = 1:9
                    imdb.images.labels(j,counter) = ~isempty(strfind(char(train.labels(b)), num2str(j)));
                end
                
                counter = counter + 1;
            end
        end
    end
end