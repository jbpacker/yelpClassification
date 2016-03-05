import shutil
import csv

dataLimitCnt = 0
with open('data/test_photo_to_biz.csv', 'rb') as idToPhoto:
    idToPhotoReader = csv.DictReader(idToPhoto)
    with open('data/lite/test_photo_to_biz.csv', 'wb') as newIdToPhoto:
        idToPhotoFields = ['photo_id', 'business_id']
        idToPhotoWrite = csv.DictWriter(newIdToPhoto, delimiter=',', fieldnames=idToPhotoFields)
        idToPhotoWrite.writeheader()
        prevID = ''
        
        # get first number of businesses from trainReader.
        for row in idToPhotoReader:
            
            # this assumes that entries are sorted on business ID, which they are    
            ID = row['business_id']
            if prevID != ID:
                dataLimitCnt += 1
                prevID = ID
                print('processing entry id ' + ID)
            
            # there are 999 restaurants total
            # 166 is 1/6 of all restaurants
            if dataLimitCnt < 100:
                photoId = row['photo_id']
                idToPhotoWrite.writerow({'photo_id': photoId, 'business_id': ID})
                fromFile = 'data/test_photos/' + photoId + '.jpg'
                toFile = 'data/lite/test_photos/' + photoId + '.jpg'
                shutil.copyfile(fromFile, toFile)
                fromFile = 'data/test_photos/._' + photoId + '.jpg'
                toFile = 'data/lite/test_photos/._' + photoId + '.jpg'
                shutil.copyfile(fromFile, toFile)
            else:
                break