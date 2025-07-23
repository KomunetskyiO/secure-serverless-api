import json
import logging
import boto3

logging.basicConfig(level=logging.INFO)
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("Tasks")

def handler(event, context):
    try:
        http_method = event.get("httpMethod", "GET")
        logging.info("Handler invoked with event: %s", event)

        if http_method == "GET":
            response = table.scan()
            items = response.get("Items", [])
            return {
                "statusCode": 200,
                "headers": {"Access-Control-Allow-Origin": "*"},
                "body": json.dumps({"tasks": items})
            }

        elif http_method == "POST":
            body = json.loads(event.get("body", "{}"))
            task = {
                "id": body.get("id", ""),
                "name": body.get("name", ""),
                "description": body.get("description", ""),
                "status": "open"
            }
            if not task["id"]:
                raise ValueError("Task ID is required")
            table.put_item(Item=task)
            return {
                "statusCode": 200,
                "headers": {"Access-Control-Allow-Origin": "*"},
                "body": "Task saved"
            }

        elif http_method == "DELETE":
            task_id = event.get("pathParameters", {}).get("id")
            if not task_id:
                raise ValueError("Task ID is required")
            table.update_item(
                Key={"id": task_id},
                UpdateExpression="SET status = :s",
                ExpressionAttributeValues={":s": "done"}
            )
            return {
                "statusCode": 200,
                "headers": {"Access-Control-Allow-Origin": "*"},
                "body": "Task closed"
            }

        else:
            raise ValueError("Unsupported HTTP method")

    except Exception as e:
        logging.error("Error occurred: %s", str(e))
        return {
            "statusCode": 500,
            "headers": {"Access-Control-Allow-Origin": "*"},
            "body": "Internal Server Error"
        }