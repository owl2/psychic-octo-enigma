import os
import boto3


s3 = boto3.resource('s3')



def print_bucket_s3():
    for bucket in s3.buckets.all():
        print(bucket.name)




if __name__ == "__main__": 
    # For test
    path = os.getcwd()
    print(path)


    #List all the buckets in S3
    print_bucket_s3()


    #Create a a bucket for the test
    #TODO

    try: 
        data = open('data/test.csv', 'rb')
        s3.Bucket('20210317bucket').put_object(Key='test.csv', Body=data)
    except ValueError:
        print("Oops, there is a probleme with to import de the files in S3")