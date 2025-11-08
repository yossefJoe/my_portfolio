# 🌟 My Portfolio

A Flutter project for a personal portfolio website.  
This project is designed to showcase your personal information, skills, and projects in an attractive and responsive way.  

You can **customize your portfolio** by adding your own data and project images, and automatically generate project data.

---

## 📂 Project Structure

- **`assets/cv_info.json`**  
  Contains your personal information like name, title, and social links.  
  ✏️ **To customize:** edit this file with your own data.

- **`assets/projectScreens/`**  
  Folder for your project screenshots.  
  📸 **To auto-generate project data:** add your project images here.

- **`tools/generate_projects_data.dart`**  
  Dart script to automatically generate project data based on the files in `assets/projectScreens/`.  
  ▶️ **To run:**  
  ```bash
  dart run tools/generate_projects_data.dart

  ▶️ **To build web:**  
     
  ```bash
  flutter clean
  flutter pub get
  flutter build web --release
  xcopy /E /I /Y assets\projectsScreens build\web\assets\projectsScreens


>> After building, you can upload the contents of the build/web folder to your web server.