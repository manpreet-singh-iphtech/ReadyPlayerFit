//
//  UIView+Animations.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

extension UIView {
    
    func float() {
        UIView.animate(withDuration: 2.5,
                       delay: 0,
                       options: [.autoreverse, .repeat]) {
            self.transform = CGAffineTransform(translationX: 0, y: -6)
        }
    }
}
