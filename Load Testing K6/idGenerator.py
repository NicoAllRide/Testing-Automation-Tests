import random
import string
import json

def generate_user_ids(count):
    user_ids = []
    for _ in range(count):
        user_id = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
        user_ids.append(user_id)
    return user_ids

def write_to_file(user_ids):
    with open("user_ids.json", "w") as file:
        json.dump(user_ids, file)

if __name__ == "__main__":
    count = 120
    user_ids = generate_user_ids(count)
    write_to_file(user_ids)
    print(f"{count} user IDs generated and written to user_ids.json")
