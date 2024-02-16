import json
import boto3

dynamodb=boto3.resource('dynamodb')
table = dynamodb.Table('cloud_resume')    
    
def lambda_handler(event, context):
    response = table.get_item(Key={
        'id' : '0'
    })
    views = response["Item"]["viewsCount"]
    views = views + 1
    response = table.update_item(
        Key={
            'id' : '0' 
        },
        UpdateExpression='SET viewsCount = :val',
        ExpressionAttributeValues={
            ':val': views
        }
    )
    return views