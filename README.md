yelpClassification
======

Machine learning for yelp restaurant classification for the [kaggle competition](https://engineeringblog.yelp.com/amp/2015/12/yelp-restaurant-photo-classification-kaggle.html). Based on [MILL](http://www.cs.cmu.edu/~juny/MILL/) and [MatConvNet](https://www.vlfeat.org/matconvnet/).

For UC Davis Machine Learning Course in 2015 by Nolan Reis and Jef Packer. For more details please see [our final paper](https://drive.google.com/file/d/19wDcACilZKjqru2DgGyJ5Ixj5w5cOM7G/view?usp=sharing).

## Install Instructions
MatConvNet setup (if getting errors regarding vl_ functions)
http://www.vlfeat.org/matconvnet/install/

MILL options and help
http://www.cs.cmu.edu/~juny/MILL/

./data/* to be populated with by user. files include:

```
./data/test_photo_to_biz.csv
./data/train.csv
./data/train_photo_to_biz_ids.csv
./data/train_photos/*
./data/test_photos/*

./data/lite/test_photo_to_biz.csv
./data/lite/train.csv
./data/lite/train_photo_to_biz_ids.csv
./data/lite/train_photos/*
./data/lite/test_photos/*
```