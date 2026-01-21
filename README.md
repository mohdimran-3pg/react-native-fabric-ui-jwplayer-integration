# React Native JWPlayer Fabric Integration (iOS)

A custom **Fabric-based native video player** for **React Native** on **iOS**, built using **JWPlayer iOS SDK**.  
This project demonstrates how to integrate a complex native video player into React Native using the **New Architecture (Fabric)** while maintaining correct lifecycle, layout, and prop updates.

---

## ✨ Features

- ✅ Fabric-compatible native component
- 🎬 JWPlayer iOS SDK integration
- 🔁 Dynamic `sourceURL` updates from React Native
- 🧠 Safe handling of Fabric lifecycle (props may arrive before view is ready)
- 📐 Layout fully controlled by React Native styles
- 🧼 Clean separation between JS, Fabric, and native player logic

---

## 📱 Platform Support

| Platform | Status |
|--------|--------|
| iOS | ✅ Supported |
| Android | ❌ Not implemented |

---

## 🧩 Architecture Overview

```
React Native (JS)
   ↓
Fabric Native Component (RCTPlayerView)
   ↓
Swift UIView (VideoView)
   ↓
JWPlayer (PlayerController)
```

### Key Design Decisions
- **React Native controls layout** (size & position)
- **Native code only fills its own bounds**
- Player setup is delayed until the view is attached to a window
- Props are buffered until the native player is ready

---

## 📦 Requirements

- React Native **0.73+** (New Architecture enabled)
- iOS **14.0+**
- Xcode **15+**
- CocoaPods
- JWPlayer iOS SDK
- A valid **JWPlayer license key**

---

## 🚀 Installation & Setup

### 1️⃣ Clone the repository

```bash
git clone https://github.com/your-username/react-native-jwplayer-fabric.git
cd react-native-jwplayer-fabric
```

---

### 2️⃣ Install JavaScript dependencies

```bash
yarn install
```

---

### 3️⃣ Install iOS dependencies

```bash
cd ios
pod install
cd ..
```

---

### 4️⃣ Enable New Architecture (Fabric)

Make sure **Fabric is enabled** in your app:

```ruby
ENV['RCT_NEW_ARCH_ENABLED'] = '1'
```

Then reinstall pods.

---

### 5️⃣ Add JWPlayer License Key

In `VideoView.swift` or `PlayerController.swift`:

```swift
let player = PlayerController(licenseKey: "YOUR_JWPLAYER_LICENSE_KEY")
```

⚠️ Do not commit your real license key to public repositories.

---

### 6️⃣ Run the app

```bash
npx react-native run-ios
```

---

## 🧪 Usage Example

```tsx
import PlayerView from './specs/PlayerViewNativeComponent';

<PlayerView
  style={{
    width: '100%',
    height: 200,
    alignSelf: 'center',
  }}
  sourceURL="https://playertest.longtailvideo.com/adaptive/oceans/oceans.m3u8"
/>
```

---

## 🔌 Props API

| Prop | Type | Required | Description |
|----|----|----|----|
| `sourceURL` | `string` | ✅ Yes | Video URL (HLS / MP4) |
| `style` | `ViewStyle` | ❌ No | React Native layout & styling |

---

## 🧠 Lifecycle & Fabric Notes (Important)

### Why buffering props is required

In Fabric, `updateProps()` can be called **before**:
- `didMoveToWindow`
- `parentViewController` is available
- Native player is initialized

To handle this safely:
- `VideoView` stores incoming URLs
- Applies them once the player is ready

This avoids crashes and ensures consistent behavior.

---

## 📐 Layout Behavior

- React Native **fully controls size and position**
- Native views **must never use `UIScreen.main.bounds`**
- Player always fills `VideoView.bounds`

### Recommended JS layout

```tsx
<PlayerView
  style={{
    width: '100%',
    aspectRatio: 16 / 9,
    alignSelf: 'center',
  }}
/>
```

---

## 🧹 Cleanup & Memory Management

- Player is removed in `deinit`
- Child view controller is detached correctly
- Prevents memory leaks on unmount

---

## ⚠️ Known Limitations

- Fullscreen toggle not implemented
- No Android implementation yet
- No playback event callbacks to JS (can be added)

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repo
2. Create a feature branch
3. Commit changes
4. Open a Pull Request

---

## 🙌 Acknowledgements

- React Native Team (Fabric)
- JWPlayer iOS SDK
- Open-source community

---

> **Note:** This project is intended for developers working with React Native New Architecture and advanced native integrations.

