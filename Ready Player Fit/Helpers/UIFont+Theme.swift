//
//  UIFont+Theme.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 11/02/26.
//

import Foundation
import UIKit

extension UIFont {
    static func cleanBody(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return .systemFont(ofSize: size, weight: weight)
    }
}
