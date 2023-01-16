//
//  BannerAd.swift
//
//  Created by Raul Pena on 5/19/22.
//

import Foundation
import GoogleMobileAds
import SwiftUI
import UIKit

struct BannerAd: UIViewControllerRepresentable {
    
    //typealias UIViewControllerType = BannerAdVC
    let adUnitId: String
    
    init(adUnitId: String) {
        self.adUnitId = adUnitId
    }
    
    func makeUIViewController(context: Context) -> BannerAdVC {
        return BannerAdVC(adUnitId: adUnitId)
    }
    
    func updateUIViewController(_ uiViewController: BannerAdVC, context: Context) {
        //
    }
}
