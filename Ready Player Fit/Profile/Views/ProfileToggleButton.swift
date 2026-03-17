//
//  ProfileToggleButton.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

class ProfileToggleButton: UIView {
    private let statsButton = UIButton(type: .system)
    private let goalButton = UIButton(type: .system)
    var onToggle: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        configureButtonStyle(statsButton, title: "STATS")
        configureButtonStyle(goalButton, title: "GOAL & STREAK")
        
        updateButtonBorders(selectedIndex: 0)
        
        let stack = UIStackView(arrangedSubviews: [statsButton, goalButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        statsButton.addTarget(self, action: #selector(didTapStats), for: .touchUpInside)
        goalButton.addTarget(self, action: #selector(didTapGoal), for: .touchUpInside)
    }
    
    private func configureButtonStyle(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.cardGray
    }
    
    func setTitles(left: String, right: String) {
        statsButton.setTitle(left, for: .normal)
        goalButton.setTitle(right, for: .normal)
    }
    
    @objc private func didTapStats() {
        updateButtonBorders(selectedIndex: 0)
        onToggle?(0)
    }
    
    @objc private func didTapGoal() {
        updateButtonBorders(selectedIndex: 1)
        onToggle?(1)
    }
    
    private func updateButtonBorders(selectedIndex: Int) {
        UIView.animate(withDuration: 0.3) {
            self.statsButton.layer.borderColor = (selectedIndex == 0) ?
            UIColor.neonCyan.cgColor : UIColor.white.withAlphaComponent(0.1).cgColor
            self.statsButton.setTitleColor((selectedIndex == 0) ? .white : .textGray, for: .normal)
            
            self.goalButton.layer.borderColor = (selectedIndex == 1) ?
            UIColor.neonCyan.cgColor : UIColor.white.withAlphaComponent(0.1).cgColor
            self.goalButton.setTitleColor((selectedIndex == 1) ? .white : .textGray, for: .normal)
        }
    }
}
