//
//  BackgroundProviding.swift
//  SwiftDependencyInjc
//
//  Created by Ali Mert Kaya on 11.09.2023.
//

import Foundation
import UIKit

class BackgroundProviding : BackgroundProvider {
    var backgroundColor: UIColor {
        let backgroundColors : [UIColor] = [.systemGray, .systemRed, .systemMint, .systemCyan]
        return backgroundColors.randomElement()!
    }
}
