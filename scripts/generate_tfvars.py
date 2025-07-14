import json

config = {
    "region": "us-east-1",
    "tables": {"tasks": {"hash_key": "id"}, "logs": {"hash_key": "log_id"}}
}
with open("terraform.tfvars.json", "w") as f:
    json.dump(config, f, indent=2)