//
//  SwiftUIBannerAd.swift
//
//  Created by Raul Pena on 5/19/22.
//

import Foundation
import SwiftUI
import GoogleMobileAds

struct SwiftUIBannerAd: View {
    @State var height: CGFloat = 0 // Height of ad
    @State var width: CGFloat = 0 // Width of ad
    @State var adPosition: AdPosition
    
    @Binding var adHeight: CGFloat
    
    let adUnitId: String
    
    init(adPosition: AdPosition, adUnitId: String, height: Binding<CGFloat>) {
        self.adPosition = adPosition
        self.adUnitId = adUnitId
        _adHeight = height
    }
    
    enum AdPosition {
        case top
        case bottom
    }
    
    public var body: some View {
        VStack {
            if adPosition == .bottom {
                Spacer() // Pushes ad to bottom
            }
            
            // Ad
            BannerAd(adUnitId: adUnitId)
                .frame(width: width, height: height, alignment: .center)
                .onAppear {
                    // load the initial frame size
                    // .onReceive() will not be called on initial load
                    setFrame()
                }
                // Changes the frame of the ad whenever device is rotated
                // This is what creates the adaptive ad
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    setFrame()
                }
            
            if adPosition == .top {
                Spacer() // Pushes ad to top
            }
        }
    }
    
    func setFrame() {
        // Get the frame of the safe area
        let safeAreaInsets = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
        let frame = UIScreen.main.bounds.inset(by: safeAreaInsets)
        
        // Use the frame to determine the size of the ad
        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
        
        // Set the ads frame
        self.width = adSize.size.width
        self.height = adSize.size.height
        
        // update bound state var
        adHeight = adSize.size.height
    }
}
