from flask import current_app as app
import bcrypt
import jwt
import datetime
import re
import secrets
from flask import session
import os

PEPPER = os.getenv('PEPPER', 'default_pepper_value')

def create_token(identity, expires_in=600):
    expiration = datetime.datetime.utcnow() + datetime.timedelta(seconds=expires_in)
    token = jwt.encode({'identity': identity, 'exp': expiration}, app.config['SECRET_KEY'], algorithm='HS256')
    return token

def validate_password(password):
    if len(password) < 8:
        return False, "Password must be at least 8 characters long"
    if not re.search(r"\d", password):
        return False, "Password must contain at least one digit"
    return True, "Password is strong"

def validate_email_address(email):
    email_regex = re.compile(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
    if email_regex.match(email):
        return True, "Valid email address"
    return False, "Invalid email address format"

def sanitize_input(input_value):
    dangerous_chars = {
        '<': '&lt;',
        '>': '&gt;',
        '&': '&amp;',
        '"': '&quot;',
        "'": '&#x27;',
        "/": '&#x2F;',
        "\\": '&#x5C;',
        "`": '&#x60;',
        "=": '&#x3D;',
        "{": '&#x7B;',
        "}": '&#x7D;'
    }
    sanitized_value = ''.join(dangerous_chars.get(c, c) for c in input_value)
    return sanitized_value

def hash_password(password):
    salt = bcrypt.gensalt(rounds=12)
    hashed = bcrypt.hashpw((password + PEPPER).encode('utf-8'), salt)
    return hashed.decode('utf-8')

def check_password(stored_password, provided_password):
    return bcrypt.checkpw((provided_password + PEPPER).encode('utf-8'), stored_password.encode('utf-8'))

def generate_csrf_token():
    return secrets.token_hex(16)

def validate_csrf_token(token):
    return token == session.get('csrf_token')
