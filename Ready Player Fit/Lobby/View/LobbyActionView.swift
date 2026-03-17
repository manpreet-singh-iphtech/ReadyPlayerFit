//
//  LobbyActionView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 03/02/26.
//

import Foundation
import UIKit

class LobbyActionView: UIView {
    
    var onPlusTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let diamondContainer = UIView()
        diamondContainer.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        diamondContainer.layer.cornerRadius = 8
        diamondContainer.transform = CGAffineTransform(rotationAngle: .pi / 4)
        
        let personIcon = UIImageView(image: UIImage(systemName: "person.fill"))
        personIcon.tintColor = .lightGray
        personIcon.contentMode = .scaleAspectFit
        personIcon.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        
        let playerStack = UIStackView()
        playerStack.spacing = 0
        for _ in 0..<2 {
            let img = UIImageView(image: UIImage(named: "avatar"))
            img.contentMode = .scaleAspectFill
            img.layer.cornerRadius = 10
            img.clipsToBounds = true
            img.layer.borderWidth = 1.5
            img.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.5).cgColor
            img.widthAnchor.constraint(equalToConstant: 50).isActive = true
            img.heightAnchor.constraint(equalToConstant: 60).isActive = true
            playerStack.addArrangedSubview(img)
        }
        
        let plusButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .medium)
        let plusImage = UIImage(systemName: "plus", withConfiguration: config)
        plusButton.setImage(plusImage, for: .normal)
        plusButton.tintColor = UIColor.neonCyan
        plusButton.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        plusButton.layer.cornerRadius = 10
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        
        let startButton = UIButton(type: .system)
        startButton.backgroundColor = .cyan
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        startButton.layer.cornerRadius = 12
        
        [diamondContainer, personIcon, playerStack, plusButton, startButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(diamondContainer)
        diamondContainer.addSubview(personIcon)
        addSubview(playerStack)
        addSubview(plusButton)
        addSubview(startButton)
        
        NSLayoutConstraint.activate([
            diamondContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            diamondContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            diamondContainer.widthAnchor.constraint(equalToConstant: 50),
            diamondContainer.heightAnchor.constraint(equalToConstant: 50),
            
            personIcon.centerXAnchor.constraint(equalTo: diamondContainer.centerXAnchor),
            personIcon.centerYAnchor.constraint(equalTo: diamondContainer.centerYAnchor),
            personIcon.widthAnchor.constraint(equalTo: diamondContainer.widthAnchor, multiplier: 0.5),
            
            playerStack.leadingAnchor.constraint(equalTo: diamondContainer.trailingAnchor, constant: 20),
            playerStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            plusButton.leadingAnchor.constraint(equalTo: playerStack.trailingAnchor, constant: 8),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            startButton.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @objc private func didTapPlus() {
        onPlusTap?()
    }
}
