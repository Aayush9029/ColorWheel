# Color Wheel
A customizable color picker component built with SwiftUI that provides an intuitive way to select colors in your iOS applications.

<div align="center">
<img src="https://github.com/user-attachments/assets/fcb6eb5c-4ec4-4b56-ba78-7dbef45add46" width="240px"> <img src="https://github.com/user-attachments/assets/10c074fd-3fb0-4e97-9857-771056d4e3f4" width="240px"> <img src="https://github.com/user-attachments/assets/572752d9-b83f-472d-a68b-63e466a64275" width="240px">
</div>


## Features

- 🎨 Intuitive color selection interface
- 🌈 Full RGB color spectrum support
- 📱 Native SwiftUI implementation
- ⚡️ Real-time color preview
- 🔄 Binding support for seamless integration

## Installation

### Xcode Package Dependency
```
https://github.com/Aayush9029/ColorWheel.git
```

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Aayush9029/ColorWheel.git", branch: "main")
]
```

---

## Usage

```swift
import SwiftUI
import ColorWheel

struct ColorPickerView: View {
    @State private var rgbColor: RGB = .init(r: 0, g: 0, b: 1)
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(rgbColor.color)
            
            ColorWheelView(
                color: $rgbColor,
                brightness: .constant(1)
            )
        }
    }
}

```



