import os
import json
import logging

def handler(event, context):
    try:
        message = os.getenv("GREETING_MESSAGE", "Hello, DevSecOps!")
        query_params = event.get("queryStringParameters", {}) or {}
        name = query_params.get("name", "Guest")
        logging.info("Handler invoked with event: %s", event)
        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"message": f"{message} {name}!"})
        }
    except Exception as e:
        logging.error("Error occurred: %s", str(e))
        return {
            "statusCode": 500,
            "headers": {
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"error": "Internal Server Error"})
        }