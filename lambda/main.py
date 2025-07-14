import json
import logging
import os

###Configure logging
logging.basicConfig(level=logging.INFO)

def handler(event, context):
    try:
        ###Fetch message from environment variable or use default
        message = os.getenv("GREETING_MESSAGE", "Hello, DevSecOps!")
        logging.info("Handler invoked with event: %s", event)
        
        return {
            "statusCode": 200,
            "body": json.dumps({"message": message})
        }
    except Exception as e:
        logging.error("Error occurred: %s", str(e))
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal Server Error"})
        }