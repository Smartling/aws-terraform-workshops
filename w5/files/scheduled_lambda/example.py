import logging
import httplib
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)
sns_client = boto3.client('sns')

checks = [ { 'host': 'your-elb-name.us-east-1.elb.amazonaws.com', 'url': '/', 'port': 80, 'assert_code': 200 } ]
sns_topic_arn = "arn:aws:sns:us-east-1:1111111111111:your-topic-name"

def lambda_handler(event, context):

  for check in checks:
    conn = httplib.HTTPConnection(check['host'], check['port'], 2)
    conn.request("GET", check['url'])
    response = conn.getresponse()

    check_string = check['host'] + ':' + str(check['port']) + check['url']
    if response.status == check['assert_code']:
      send_sns(sns_topic_arn, 'Successful web check', check_string + " is alive.")
    else:
      send_sns(sns_topic_arn, 'Failed web check', check_string + " is fails.")
    

def send_sns(topic, subject, message):
  response = sns_client.publish(
    TopicArn=topic,
    Message=message,
    Subject=subject
  )
