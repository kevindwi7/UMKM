//
//  HapticModel.swift
//  UMKM
//
//  Created by Vidya on 30/08/22.
//

import Foundation
import SwiftUI

class HapticManager{
    static let instance = HapticManager () // singleton
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
