# Ready Player Fit 🏋️‍♂️

**Ready Player Fit** is a gamified fitness companion iOS application that combines workout tracking concepts, avatar customization, and engaging UI animations. The application focuses on creating a visually interactive experience where users can monitor their progress, maintain streaks, and personalize their in-app avatar.  

The project demonstrates how fitness concepts can be combined with game-like UI elements to create a motivating and engaging mobile experience.

---

## 🚀 Tech Stack

- **Platform:** iOS  
- **Language:** Swift  
- **Frameworks:** UIKit, QuartzCore  
- **UI Approach:** Programmatic UIKit  
- **Local Storage:** UserDefaults  
- **Graphics & Animations:** Core Animation, CAShapeLayer  

---

## 📋 Requirements

- Xcode 12.0 or later  
- Swift 5.0 or later  
- iOS 12.0 or later  

---

## ⚙️ Installation

Clone the repository:
```
git clone https://github.com/manpreet-singh-iphtech/ReadyPlayerFit.git
```

Navigate to the project directory:
```
cd ReadyPlayerFit
```

Open the Xcode project file:
```
open ReadyPlayerFit.xcodeproj
```

Build and run the project using the Xcode simulator or a connected iOS device.

---

## ✨ Core Features

### 🧍 Avatar Customization

The application allows users to personalize their avatar appearance.

**Available customization options:**
- 3 T-shirts  
- 3 Hoodies  
- 3 Shoes  

Users can select items through the locker interface, and the selected appearance is applied to the avatar in real time.  

The avatar customization system is built using **layered image assets**, allowing different clothing combinations to be displayed dynamically.

---

### 📊 Animated Fitness Dashboard

The app includes a visually dynamic dashboard that displays user statistics such as:

- Weekly goals  
- Workout streaks  
- Longest streak achieved  

UI elements animate into view to create a smooth and interactive experience.

---

### 🔵 Circular Progress Indicators

Custom circular progress components are used to visually represent user levels and progress.  

These indicators are built using **CAShapeLayer** and animated using **Core Animation** to create smooth progress ring animations.

---

### 🎮 Gamified UI Experience

The application incorporates several animation techniques to enhance the user experience, including:

- Animated stat cards  
- Circular progress animations  
- Flip transitions for stat updates  
- Spring-based UI animations  
- Glowing highlight effects for achievements  

These elements help create a **game-like fitness interface** that visually rewards progress and consistency.

---

## 🧩 Custom UI Components

### CircularStatView

A custom view that displays:

- An icon  
- A level label  
- An animated circular progress ring  

This component is used to visualize user statistics and progress levels.

---

### Locker Item Cells

The avatar locker interface uses custom collection view cells to present customization items.

Each item displays:

- A clothing asset  
- A title  
- A description  

These cells provide a structured way for users to browse and select avatar appearance options.

---

## 💾 Data Persistence

The application currently **does not use a backend service**.

All user selections and avatar customization data are stored locally using **UserDefaults**, ensuring that the user's appearance choices persist across app launches.

---

## 🎨 UI Design

The app uses a **modern neon-inspired design style**, including:

- Dark themed backgrounds  
- Neon accent highlights  
- Glowing progress indicators  
- Animated stat cards  
- Smooth UI transitions  

The design approach reinforces the idea of **fitness as a gamified experience**.

---

## 🎯 Project Goal

Ready Player Fit was developed to demonstrate:

- iOS development using **Swift and UIKit**  
- **Core Animation and CAShapeLayer usage**  
- Creation of **interactive animated interfaces**  
- **Avatar customization systems**  
- Local data persistence using **UserDefaults**  

---

## Sample Meme



---


