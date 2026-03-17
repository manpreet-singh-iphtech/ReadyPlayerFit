//
//  ProfileHeaderView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

class XPProgressView: UIView {
    private let levelLabel = UILabel()
    private let xpLabel = UILabel()
    private let segmentStack = UIStackView()
    
    init(currentXP: Int, totalXP: Int) {
        super.init(frame: .zero)
        setup(current: currentXP, total: totalXP)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup(current: Int, total: Int) {
        backgroundColor = UIColor.white.withAlphaComponent(0.04)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 8
        
        levelLabel.text = "LVL 1"
        levelLabel.font = .systemFont(ofSize: 12, weight: .bold)
        levelLabel.textColor = .white
        xpLabel.text = "\(current)/\(total) XP"
        xpLabel.font = .systemFont(ofSize: 12, weight: .medium)
        xpLabel.textColor = .textGray
        
        segmentStack.axis = .horizontal
        segmentStack.distribution = .fillEqually
        segmentStack.spacing = 4
        for i in 0..<10 {
            let segment = UIView()
            segment.backgroundColor = i < 2 ? .neonCyan : UIColor.white.withAlphaComponent(0.1)
            segment.layer.cornerRadius = 2
            segmentStack.addArrangedSubview(segment)
        }
        
        [levelLabel, xpLabel, segmentStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; addSubview($0) }
        
        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            xpLabel.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor),
            xpLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            segmentStack.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 12),
            segmentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            segmentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            segmentStack.heightAnchor.constraint(equalToConstant: 6),
            segmentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}

class CoinView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.04)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 8
        let title = UILabel()
        title.text = "COINS:"
        title.font = .systemFont(ofSize: 12, weight: .bold)
        title.textColor = .white
        let val = UILabel()
        val.text = "100"
        val.font = .systemFont(ofSize: 13, weight: .bold)
        val.textColor = .white
        let icon = UIImageView(image: UIImage(systemName: "circlebadge.2"))
        icon.tintColor = .neonCyan
        
        [title, val, icon].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; addSubview($0) }
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            icon.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 18),
            val.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            val.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 2)
        ])
    }
    required init?(coder: NSCoder) { fatalError() }
}

class ProfileHeaderView: UIView {
    let dateLabel = UILabel()
    let nameLabel = UILabel()
    let xpBar = XPProgressView(currentXP: 100, totalXP: 500)
    let coinBox = CoinView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        dateLabel.text = "Joined 21 October, 2024"
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 11)
        nameLabel.text = "HI, JAMES"
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 26, weight: .black)
        
        [dateLabel, nameLabel, xpBar, coinBox].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; addSubview($0) }
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            xpBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            xpBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            xpBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            xpBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            coinBox.centerYAnchor.constraint(equalTo: xpBar.centerYAnchor),
            coinBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            coinBox.leadingAnchor.constraint(equalTo: xpBar.trailingAnchor, constant: 8),
            coinBox.heightAnchor.constraint(equalTo: xpBar.heightAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError() }
}
