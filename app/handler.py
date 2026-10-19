import json


def lambda_handler(event, context):
    params = event.get("queryStringParameters") or {}
    name = params.get("name", "World")

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({
            "message": f"Hello, {name}!",
            "source": "Lambda puro en Python",
        }),
    }


if __name__ == "__main__":
    event = {"queryStringParameters": {"name": "UTEC"}}
    print(json.dumps(lambda_handler(event, None), indent=2))
