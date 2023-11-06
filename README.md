# SmoothDigitInput

A simple and smooth digit input view for SwiftUI

- 100% SwiftUI for iOS17+
- Highly customizable: animations, transitions, padding, spacing, ...
- No assumptions made: style with your standard  view modifiers
- provides amazing default transitions
- exposes simple but effective data store, that drives your view
- automatically parses input into number


## Installation

SmoothDigitInput is available via the [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#). Requires iOS17+.
```
https://github.com/valentinpurrucker/SmoothDigitInput
```

## Usage
### 1. Create the data store
```swift
@State var store = DigitStore()
```

### 2. Use the view
```swift 
SmoothDigitInputView(store, animation: .interactiveSpring) {
    Text("$")
      .font(.system(size: fontSize / 2))
      .fontWeight(.semibold)
      .fontDesign(.rounded)
      .offset(y: -10)
    } suffixContent: {

    }
    .font(.system(size: fontSize))
    .fontWeight(.semibold)
    .fontDesign(.rounded)
	.foregroundStyle(store.isFirstSet ? .black : Color(uiColor: .systemGray3))
```

### The store exposes the following methods
- `add(number: Int)` to add a single digit
- `addDecimal()` to add a decimal point
- `remove()`to remove the last digit
- `getNumber()`that returns the number if it is valid
- ... and a few more that make it easy to build a beautiful app

### Community

If you run into problems or want some more features, feel free to add an [Issue](https://github.com/valentinpurrucker/SmoothDigitInput/issues) or open a [Pull request](https://github.com/valentinpurrucker/SmoothDigitInput/pulls)

### License
SmoothDigitInput is under the MIT license.
