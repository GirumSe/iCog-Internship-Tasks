Here's a comprehensive `README.md` for your Flask project:

```markdown
# Flask JWT Authentication App

This is a simple Flask application that demonstrates JWT authentication with CSRF protection. The project includes basic features for user registration, login, profile access, and token verification/refresh.

## Project Structure

```
flask_project/
│
├── app/
│   ├── __init__.py
│   ├── models.py
│   ├── routes.py
│   └── utils.py
│
├── static/
│
├── templates/
│   ├── login.html
│   ├── register.html
│   └── profile.html
│
├── requirements.txt
├── run.py
└── example.env
```

## Setup

1. **Clone the Repository**

   ```bash
   git clone <repository_url>
   cd flask_project
   ```

2. **Create a Virtual Environment**

   ```bash
   python -m venv venv
   ```

3. **Activate the Virtual Environment**

   - On Windows:
     ```bash
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```bash
     source venv/bin/activate
     ```

4. **Install Dependencies**

   ```bash
   pip install -r requirements.txt
   ```

5. **Configure Environment Variables**

   Copy `example.env` to `.env` and update the values as needed:

   ```bash
   cp example.env .env
   ```

   Edit `.env` to include your own values for the following variables:
   
   - `SECRET_KEY`: A secret key for Flask sessions and JWT encoding.
   - `SQLALCHEMY_DATABASE_URI`: Database URI for SQLAlchemy.
   - `CSRF_SECRET_KEY`: A secret key for CSRF protection.
   - `PEPPER`: A pepper value used for hashing passwords.

6. **Run the Application**

   ```bash
   python run.py
   ```

   The application will start and be accessible at `http://127.0.0.1:5000`.

## Endpoints

- **Home**: Redirects to the login page.
  - `GET /`

- **Login Page**: Displays the login form.
  - `GET /login`

- **Register Page**: Displays the registration form.
  - `GET /register`

- **Register**: Handles user registration.
  - `POST /register`
  - Requires CSRF token in the header.
  - Expects JSON with `name`, `email`, and `password` fields.

- **Login**: Handles user login and returns JWT tokens.
  - `POST /login`
  - Requires CSRF token in the header.
  - Expects JSON with `email` and `password` fields.

- **Verify Token**: Verifies JWT tokens.
  - `POST /verify`
  - Requires CSRF token in the header.
  - Expects JWT token in the `Authorization` header.

- **Refresh Token**: Refreshes JWT tokens.
  - `POST /refresh`
  - Requires CSRF token in the header.
  - Expects JWT token in the `Authorization` header.

- **Profile**: Displays user profile or returns user data in JSON format.
  - `GET /profile`
  - Requires JWT token in the `Authorization` header for JSON response.

## Files

- **`requirements.txt`**: Lists the Python packages required for the project.
- **`run.py`**: Entry point to run the Flask application.
- **`example.env`**: Example environment variables configuration.

## Utilities

- **`utils.py`**: Contains utility functions for token creation, password hashing, email validation, input sanitization, and CSRF protection.

## Contributing

If you wish to contribute to this project, please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to reach out if you have any questions or need further assistance!
```

This `README.md` provides a clear overview of the project's structure, setup instructions, available endpoints, and utility functions. Adjust the `repository_url` placeholder and other details as needed.