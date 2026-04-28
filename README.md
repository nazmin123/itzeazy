# Service Home Screen UI (iOS)

## 📌 Overview
This project demonstrates the design and implementation of a modern **Home Screen UI** for an iOS application using SwiftUI.

The focus of this project is on **clean UI design, layout structuring, and reusable components**, rather than full backend integration.

---

## 🎯 Key Highlights
- Built using **SwiftUI**
- Clean and modern UI design
- Component-based architecture
- Responsive layout using `LazyVGrid`
- State-driven UI with `@StateObject`
- Handles loading, error, and success states

---

## 🧱 UI Components

### 🔹 Header Section
- Menu icon
- App brand name
- Location indicator with capsule design

### 🔹 Search Bar
- Custom styled search field
- Placeholder-driven input
- Rounded border with subtle UI styling

### 🔹 Services Section
- Grid-based layout using `LazyVGrid`
- Reusable `ServiceCard` component
- Displays services dynamically from ViewModel
- Handles:
  - Loading state (ProgressView)
  - Error state (Retry option)

### 🔹 Popular Section
- Featured promotional card (Hero UI)
- Secondary offer card
- Gradient backgrounds and shadow effects

---

## 🧠 Architecture
- MVVM (Model-View-ViewModel)
- Dependency injection using `AppContainer`
- ViewModel-driven UI updates

---

## 📱 Screenshots

### Home Screen
![Home](Screenshots/home.png)

*(Add more screenshots if available)*

---

## 🛠 Tech Stack
- Swift
- SwiftUI
- MVVM Architecture

---

## ▶️ How to Run
1. Clone the repository
2. Open `.xcodeproj` in Xcode
3. Run on iOS Simulator

---

## 🚧 Note
This project currently focuses on **UI implementation only**.  
Data is managed via ViewModel and mock/state-driven logic.

---

## 👩‍💻 Author
Nazmin Parween