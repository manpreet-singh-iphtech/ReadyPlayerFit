//
//  LockerCategoryPillButton.swift
//  Ready Player Fit
//
//  Created by Manpreet Singh on 02/02/26.
//

import Foundation

import UIKit

class CategoryPillButton: UIButton {
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 12, weight: .black)
        layer.cornerRadius = 18
        layer.borderWidth = 1.5
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        updateStyle()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func updateStyle() {
        if isSelected {
            backgroundColor = .neonCyan
            setTitleColor(.black, for: .normal)
            layer.borderColor = UIColor.neonCyan.cgColor
        } else {
            backgroundColor = UIColor.white.withAlphaComponent(0.05)
            setTitleColor(.white.withAlphaComponent(0.6), for: .normal)
            layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        }
    }
}
