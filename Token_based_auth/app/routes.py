from flask import Blueprint, render_template, jsonify, request, redirect, url_for, current_app as app
import jwt
from .models import User
from .utils import create_token, validate_password, validate_email_address, sanitize_input, hash_password, check_password, generate_csrf_token, validate_csrf_token

bp = Blueprint('main', __name__)

@bp.route('/')
def home():
    return redirect(url_for('main.login_page'))

@bp.route('/login')
def login_page():
    return render_template('login.html')

@bp.route('/register')
def register_page():
    return render_template('register.html')

@bp.route('/register', methods=['POST'])
def register():
    csrf_token = request.headers.get('X-CSRF-Token')
    if not validate_csrf_token(csrf_token):
        return jsonify({'message': 'Invalid CSRF token'}), 403

    data = request.get_json()

    name = sanitize_input(data.get('name', ''))
    email = sanitize_input(data.get('email', ''))
    password = sanitize_input(data.get('password', ''))

    is_valid_email, message = validate_email_address(email)
    if not is_valid_email:
        return jsonify({'message': message}), 400

    if User.query.filter_by(email=email).first():
        return jsonify({'message': 'User already exists'}), 400

    is_valid_password, message = validate_password(password)
    if not is_valid_password:
        return jsonify({'message': message}), 400

    hashed_password = hash_password(password)
    new_user = User(name=name, email=email, password=hashed_password)
    db = app.extensions['sqlalchemy'].db  # Access db from current_app
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'User registered successfully'}), 201

@bp.route('/login', methods=['POST'])
def login():
    csrf_token = request.headers.get('X-CSRF-Token')
    if not validate_csrf_token(csrf_token):
        return jsonify({'message': 'Invalid CSRF token'}), 403

    data = request.get_json()

    email = sanitize_input(data.get('email', ''))
    password = sanitize_input(data.get('password', ''))

    user = User.query.filter_by(email=email).first()

    if not user or not check_password(user.password, password):
        return jsonify({'message': 'Invalid credentials'}), 401

    access_token = create_token(identity=user.email)
    refresh_token = create_token(identity=user.email, expires_in=86400)
    return jsonify({'access_token': access_token, 'refresh_token': refresh_token}), 200

@bp.route('/verify', methods=['POST'])
def verify_token():
    csrf_token = request.headers.get('X-CSRF-Token')
    if not validate_csrf_token(csrf_token):
        return jsonify({'message': 'Invalid CSRF token'}), 403

    token = request.headers.get('Authorization').split()[1]
    try:
        jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        return jsonify({'message': 'Token is valid'}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Token has expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Invalid token'}), 401

@bp.route('/refresh', methods=['POST'])
def refresh_token():
    csrf_token = request.headers.get('X-CSRF-Token')
    if not validate_csrf_token(csrf_token):
        return jsonify({'message': 'Invalid CSRF token'}), 403

    token = request.headers.get('Authorization').split()[1]
    try:
        data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        new_access_token = create_token(identity=data['identity'])
        return jsonify({'access_token': new_access_token}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Refresh token has expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Invalid token'}), 401

@bp.route('/profile', methods=['GET'])
def profile():
    if request.headers.get('Authorization'):
        csrf_token = request.headers.get('X-CSRF-Token')
        if not validate_csrf_token(csrf_token):
            return jsonify({'message': 'Invalid CSRF token'}), 403

        token = request.headers.get('Authorization').split()[1]
        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            user = User.query.filter_by(email=data['identity']).first()
            return jsonify({'name': user.name, 'email': user.email}), 200
        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'message': 'Invalid token'}), 401
    else:
        return render_template('profile.html')
