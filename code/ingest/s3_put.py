import os
import boto3


s3 = boto3.resource('s3')



def get_bucket_s3():
    bucket_list = []

    for bucket in s3.buckets.all():
        bucket_list.append(bucket.name)
    
    return bucket_list


def create_bucket_s3(bucket_name):
    if bucket_name in get_bucket_s3():
        print("Bucket already existing")
    else:
        response = s3.create_bucket(
            Bucket='20210317bucket',
            CreateBucketConfiguration={
                'LocationConstraint': 'us-east-2'
            },
        )

        print(response)





if __name__ == "__main__": 
    # For test
    path = os.getcwd()
    print(path)


    #List all the buckets in S3
    buckets_list = get_bucket_s3()
    print("Bucket list :")
    print(buckets_list)


    #Create a a bucket for the test
    create_bucket_s3('20210317bucket')

    try: 
        data = open('data/test.csv', 'rb')
        s3.Bucket('20210317bucket').put_object(Key='test.csv', Body=data)
    except ValueError:
        print("Oops, there is a probleme with to import de the files in S3")