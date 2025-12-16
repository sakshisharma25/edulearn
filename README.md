# EduLearn – Flutter Learning App

EduLearn is a Flutter-based learning application built as part of an assignment.  
The app supports **role-based authentication**, **course management**, and **student learning features** using **Firebase** as the backend.

---

## ✨ Features

### 🔐 Authentication
- Email & Password login
- Email verification
- Google Sign-In
- Forgot password
- Persistent login session
- Role-based access:
  - Student
  - Admin

### 👨‍🎓 Student Module
- View list of available courses
- Course detail screen with:
  - Video (YouTube player)
  - Web-based document/PDF viewer (in-app)
  - MCQs with instant feedback
- Student profile:
  - Update personal details
  - Logout with confirmation

### 🧑‍💼 Admin Module
- Admin dashboard
- Add new courses
- Add MCQs for courses
- View all courses
- Manage students (basic structure implemented)
- Admin profile & logout

### 🎨 UI & Architecture
- Clean UI using custom theme, colors, and text styles
- Responsive design (mobile-first)
- GetX for:
  - State management
  - Routing
  - Dependency injection
- MVC / Clean Architecture approach:
  - `controller`
  - `service`
  - `view`
  - `widgets`

---

## 🛠 Tech Stack

- **Flutter**
- **Firebase**
  - Firebase Authentication
  - Cloud Firestore
- **GetX**
- **YouTube Player**
- **InAppWebView**

---

## 📁 Project Structure (Simplified)

## ▶️ How to Run the App (Locally)

### 1️⃣ Prerequisites
- Flutter SDK installed
- Android Studio / VS Code
- Android device or emulator
- Firebase project configured

### 2️⃣ Clone the Project
```bash
git clone <repository-url>
cd edulearn

flutter pub get
flutter run
