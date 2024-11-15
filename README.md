
# Document Opinion Request System

This repository contains a comprehensive solution for managing document opinion requests for the head of government. It includes a **Web Frontend**, **Backend**, and **Mobile Applications** to provide a seamless experience across different platforms.

---

## Table of Contents

1. [Project Structure](#project-structure)  
2. [Web Frontend](#web-frontend)  
3. [Backend](#backend)  
4. [Mobile Apps](#mobile-apps)  
5. [Getting Started](#getting-started)  
6. [Contributing](#contributing)  
7. [License](#license)  

---

## Project Structure

The repository is organized as follows:

```bash
.
├── web-frontend/    # Web frontend codebase (React application)
│   ├── public/      # Static files
│   ├── src/         # Source code (components, hooks, services)
│   └── package.json # Web frontend dependencies
│
├── backend/         # Backend codebase (Django application)
│   ├── project/     # Main Django project folder
│   ├── app/         # Django app with models, views, and templates
│   └── requirements.txt # Backend dependencies
│
├── mobile-apps/     # Mobile applications (Flutter)
│   ├── ios/         # iOS-specific files
│   ├── android/     # Android-specific files
│   ├── lib/         # Dart source files
│   └── pubspec.yaml # Flutter dependencies
│
└── README.md        # Documentation
```

---

## Web Frontend

### Location: `web-frontend/`

The web frontend is built using **React** to provide a dynamic and user-friendly interface for government staff.

#### Key Features:
- Responsive design
- Real-time updates
- Integration with backend API

#### Commands:

1. **Install dependencies**:  
   ```bash
   cd web-frontend
   npm install
   ```

2. **Run development server**:  
   ```bash
   npm start
   ```

3. **Build for production**:  
   ```bash
   npm run build
   ```

---

## Backend

### Location: `backend/`

The backend is a **Django** application for handling API requests and managing data.

#### Key Features:
- RESTful APIs with Django REST Framework
- Authentication with JWT
- Data validation and error handling

#### Commands:

1. **Set up virtual environment**:  
   ```bash
   python -m venv env
   source env/bin/activate  # On Windows: env\Scripts\activate
   ```

2. **Install dependencies**:  
   ```bash
   pip install -r requirements.txt
   ```

3. **Run development server**:  
   ```bash
   python manage.py runserver
   ```

4. **Environment variables**:  
   Create a `.env` file in the `backend` folder with the following structure:
   ```
   SECRET_KEY=your_django_secret_key
   DATABASE_URL=postgres://user:password@localhost:5432/project_db
   DEBUG=True
   ```

---

## Mobile Apps

### Location: `mobile-apps/`

The mobile applications are built using **Flutter**, ensuring compatibility across iOS and Android devices.

#### Key Features:
- Cross-platform support
- Smooth UI with Material Design
- Offline capabilities

#### Commands:

1. **Install Flutter**: Follow the instructions from the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. **Run the app**:

   a. **Install dependencies**:  
   ```bash
   cd mobile-apps
   flutter pub get
   ```

   b. **Run on iOS**:  
   ```bash
   flutter run -d ios
   ```

   c. **Run on Android**:  
   ```bash
   flutter run -d android
   ```

---

## Getting Started

### Prerequisites:
- Node.js
- Python & Django
- PostgreSQL (or other supported databases)
- Flutter environment setup (Xcode, Android Studio)

### Setup:
1. Clone the repository:
   ```bash
   git clone https://github.com/username/document-opinion-request.git
   cd document-opinion-request
   ```

2. Follow the setup instructions for [Web Frontend](#web-frontend), [Backend](#backend), and [Mobile Apps](#mobile-apps).

---

## Contributing

1. Fork the repository.  
2. Create a feature branch (\`git checkout -b feature/new-feature\`).  
3. Commit your changes (\`git commit -m 'Add feature'\`).  
4. Push to the branch (\`git push origin feature/new-feature\`).  
5. Open a Pull Request.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---
