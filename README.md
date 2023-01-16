# Swift UI Banner Ad Height
Swift admob banner ad integration code

These three swift files are integration code for Google's Admob banner ad.

It includes a Swift UI View for adding directly into your own view and position the ad at the bottom or top of the screen.

The more useful feature built into the view is the option to pass through a state variable which is updated automatically through a binding to reflect the banner ads height.

This is useful when you have contents on display that are using the full size of the screen or are adaptive to the screen dimensions. Instead of reserving some arbitrary amount of space at the bottop/top of your view for the banner ad, you can conditionally bring in the view and update your other views whenever you have the calculated height of the banner ad. For example for a subview that calculates its dimensions based on the screen size, you can pass in the state var which is initialized to "0" and then is updated as the ad loads in real time.

This is some example code to show this use case.

```swift
import SwiftUI

struct SomeView: View {
  let showBannerAd: Bool
  @State private var bottomAdHeight: CGFloat = 0
  
  init() {
    showBannerAd = true // set this through any means you have such as preferences
  }
  
  var body: some View {
    ZStack(alignment:.top) {
      Color.clear.ignoresSafeArea() // to grow the ZStack to full size
      
      if(showBannerAd) {
        // banner ad must be inside a ZStack. It is overlaid and other views react to $bottomAdHeight
        SwiftUIBannerAd(adPosition: .bottom, adUnitId: "your-ad-unit-id", height: $bottomAdHeight)
      }
      
      VStack(spacing: 0) {
        // your contents here
        
        // example view using $bottomAdHeight
        // internally it can adjust its size by reacting to any changes in bottomAdHeight that is passed in
        LargeCarousel(heightOffset: $bottomAdHeight)
        
        Spacer()
      }
    }
  }
}
```

If you want to use the banner ad and have it flow with the normal contents of your view, you can modify SwiftUIBannerAd to remove the VStack and the spacers, or just place a full-width rectangle at the bottom of your view that uses $bottomAdHeight as it's dynamic height.
