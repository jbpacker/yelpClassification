import shutil
import csv

#need to make directory /data/lite/train_photos
dataLimitCnt = 0
with open('../data/train.csv', 'rb') as trainData:
    trainReader = csv.DictReader(trainData)
    with open('../data/train_photo_to_biz_ids.csv', 'rb') as idToPhoto:
        idToPhotoReader = csv.DictReader(idToPhoto)
        with open('../data/lite/train.csv', 'wb') as newTrain:
            trainFields = ['business_id', 'labels']
            trainWrite = csv.DictWriter(newTrain, delimiter=',', fieldnames=trainFields)
            trainWrite.writeheader()
            with open('../data/lite/train_photo_to_biz_ids.csv', 'wb') as newIdToPhoto:
                idToPhotoFields = ['photo_id', 'business_id']
                idToPhotoWrite = csv.DictWriter(newIdToPhoto, delimiter=',', fieldnames=idToPhotoFields)
                idToPhotoWrite.writeheader()
                # get first number of rows from trainReader.
                for trainRow in trainReader:
                    dataLimitCnt += 1
                    
                    # there are 999 restaurants total
                    # 166 is 1/6 of all restaurants
                    if dataLimitCnt < 100:
                        ID = trainRow['business_id']
                        labels = trainRow['labels']
                        trainWrite.writerow({'business_id': ID, 'labels': labels})
                        print('processing entry id ' + ID)

                        # find the corresponding biz ID's in idToPhoto
                        for photoRow in idToPhotoReader:
                            if ID == photoRow['business_id']:
                                photoId = photoRow['photo_id']
                                idToPhotoWrite.writerow({'photo_id': photoId, 'business_id': ID})
                                fromFile = '../data/train_photos/' + photoId + '.jpg'
                                toFile = '../data/lite/train_photos/' + photoId + '.jpg'
                                shutil.copyfile(fromFile, toFile)
                                fromFile = '../data/train_photos/._' + photoId + '.jpg'
                                toFile = '../data/lite/train_photos/._' + photoId + '.jpg'
                                shutil.copyfile(fromFile, toFile)
                        idToPhoto.seek(0)
                    else:
                        break