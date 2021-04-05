import boto3



s3 = boto3.resource('s3')

# Print all bucket name
for bucket in s3.buckets.all(): 
    print(bucket.name)


data = open('../../data/test.csv', 'rb')
s3.Bucket('20210317bucket').put_object(Key='test.csv', Body=data)