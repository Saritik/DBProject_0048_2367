import random
import string


# Function to generate a random full name with a maximum length of 15 characters
def random_name():
    first_names = ['John', 'Jane', 'Alex', 'Emily', 'Chris', 'Katie', 'Michael', 'Sarah', 'David', 'Laura']
    last_names = ['Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore', 'Taylor']
    while True:
        name = f"{random.choice(first_names)} {random.choice(last_names)}"
        if len(name) <= 15:
            return name
        if len(first_names) > 0:
            first_names.pop()  # Reduce the pool to ensure we don't get into an infinite loop


# Function to generate a random email with a maximum length of 20 characters
def random_email(name):
    domains = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'example.com']
    email_prefix = name.replace(' ', '.').lower()
    email_suffix = random.choice(domains)
    email = f"{email_prefix}@{email_suffix}"
    if len(email) > 20:
        email = email[:20 - len(email_suffix) - 1] + '@' + email_suffix
    return email[:20]


# Function to generate a random address with a maximum length of 20 characters
def random_address():
    streets = ['Main', 'High', 'Broadway', 'Elm', 'Maple', 'Oak', 'Pine', 'Cedar', '2nd', '3rd']
    cities = ['Springfield', 'Riverside', 'Greenfield', 'Franklin', 'Clinton', 'Fairview', 'Greenville', 'Bristol', 'Madison', 'Georgetown']
    states = ['CA', 'TX', 'NY', 'FL', 'IL', 'PA', 'OH', 'MI', 'GA', 'NC']
    address = f"{random.randint(100, 999)} {random.choice(streets)} {random.choice(cities)} {random.choice(states)}"
    return address[:20]


# Function to generate a random phone number
def random_phone():
    return f"{random.randint(100, 999)}-{random.randint(100, 999)}{random.randint(1000, 9999)}"


# Function to generate random payment details
def random_payment():
    methods = ['CreditCard', 'Cash', 'Bit']
    return random.choice(methods)


# Function to generate a unique ID
def unique_id(existing_ids):
    while True:
        new_id = random.randint(1, 99999)
        if new_id not in existing_ids:
            existing_ids.add(new_id)
            return new_id


def generate_data_file(filename, num_rows):
    existing_ids = set()
    with open(filename, 'w') as file:
        for _ in range(num_rows):
            id = unique_id(existing_ids)
            name = random_name()
            email = random_email(name)
            address = random_address()
            phone = random_phone()
            payment = random_payment()
            row = f"{id},{name},{email},{address},{phone},{payment}\n"
            file.write(row)


# Generate the data file with 500 rows
generate_data_file('Customer.txt', 500)

print("Data file generated successfully.")


