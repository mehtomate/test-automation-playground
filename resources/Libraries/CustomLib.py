import random
import string

def generate_random_zip_code():
    """Generates a random 5-digit zip code."""
    return ''.join(random.choices(string.digits, k=5))

def generate_random_transaction_id():
    """Generates a random alphanumeric transaction ID."""
    return "TX-" + ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))
