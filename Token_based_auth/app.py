from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import bcrypt
import jwt
import datetime
import os
import re
from dotenv import load_dotenv

load_dotenv()  # Load environment variables from .env file

app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('SQLALCHEMY_DATABASE_URI')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Define a pepper value
PEPPER = os.getenv('PEPPER', 'default_pepper_value')  # Use a secure, random value

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    email = db.Column(db.String(50), unique=True)
    password = db.Column(db.String(100))  # bcrypt hashes are 60 bytes long, so this is sufficient

def create_token(identity, expires_in=600):
    expiration = datetime.datetime.utcnow() + datetime.timedelta(seconds=expires_in)
    token = jwt.encode({'identity': identity, 'exp': expiration}, app.config['SECRET_KEY'], algorithm='HS256')
    return token

def validate_password(password):
    """Enforce strong password policies."""
    if len(password) < 8:
        return False, "Password must be at least 8 characters long"
    if not re.search(r"[A-Z]", password):
        return False, "Password must contain at least one uppercase letter"
    if not re.search(r"[a-z]", password):
        return False, "Password must contain at least one lowercase letter"
    if not re.search(r"\d", password):
        return False, "Password must contain at least one digit"
    if not re.search(r"[!@#$%^&*(),.?\":{}|<>]", password):
        return False, "Password must contain at least one special character"
    return True, "Password is strong"

def hash_password(password):
    """Hash the password with bcrypt and a pepper."""
    salt = bcrypt.gensalt(rounds=12)  # Work factor of 12 is generally considered secure
    hashed = bcrypt.hashpw((password + PEPPER).encode('utf-8'), salt)
    return hashed.decode('utf-8')

def check_password(stored_password, provided_password):
    """Check the provided password against the stored hashed password."""
    return bcrypt.checkpw((provided_password + PEPPER).encode('utf-8'), stored_password.encode('utf-8'))

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    if User.query.filter_by(email=data['email']).first():
        return jsonify({'message': 'User already exists'}), 400

    password = data['password']
    is_valid, message = validate_password(password)
    if not is_valid:
        return jsonify({'message': message}), 400

    hashed_password = hash_password(password)
    new_user = User(name=data['name'], email=data['email'], password=hashed_password)
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(email=data['email']).first()
    
    if not user or not check_password(user.password, data['password']):
        return jsonify({'message': 'Invalid credentials'}), 401
    
    access_token = create_token(identity=user.email)
    refresh_token = create_token(identity=user.email, expires_in=86400)  # 1 day
    return jsonify({'access_token': access_token, 'refresh_token': refresh_token}), 200

@app.route('/verify', methods=['POST'])
def verify_token():
    token = request.headers.get('Authorization').split()[1]
    try:
        jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        return jsonify({'message': 'Token is valid'}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Token has expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Invalid token'}), 401

@app.route('/refresh', methods=['POST'])
def refresh_token():
    token = request.headers.get('Authorization').split()[1]
    try:
        data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        new_access_token = create_token(identity=data['identity'])
        return jsonify({'access_token': new_access_token}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Refresh token has expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Invalid token'}), 401

@app.route('/profile', methods=['GET'])
def profile():
    token = request.headers.get('Authorization').split()[1]
    try:
        data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        user = User.query.filter_by(email=data['identity']).first()
        return jsonify({'name': user.name, 'email': user.email}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Token has expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Invalid token'}), 401

if __name__ == '__main__':
    db.create_all()  # Creates the SQLite database and tables
    app.run(debug=True)
