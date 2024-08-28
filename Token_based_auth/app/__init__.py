from flask import Flask, request, session
from flask_sqlalchemy import SQLAlchemy
from flask_sqlalchemy import SQLAlchemy
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
import os
from dotenv import load_dotenv
from .utils import create_token, generate_csrf_token, validate_csrf_token, sanitize_input, validate_password, validate_email_address, hash_password, check_password

load_dotenv()

db = SQLAlchemy()
limiter = Limiter(
    get_remote_address,
    default_limits=["200 per day", "50 per hour"]
)

def create_app():
    app = Flask(__name__, template_folder='../templates', static_folder='../static')
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('SQLALCHEMY_DATABASE_URI')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['CSRF_SECRET_KEY'] = os.getenv('CSRF_SECRET_KEY')

    db.init_app(app)
    limiter.init_app(app)

    @app.before_request
    def before_request():
        if 'csrf_token' not in session:
            session['csrf_token'] = generate_csrf_token()
        if 'csrf_token' not in request.cookies:
            response = app.make_response("Cookie")
            response.set_cookie('csrf_token', session['csrf_token'])
            return response

    from . import routes
    app.register_blueprint(routes.bp)

    return app
