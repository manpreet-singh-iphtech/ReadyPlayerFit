//
//  HistoryHeaderView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 11/02/26.
//

import Foundation
import UIKit

class HistoryHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        let mainTitle = UILabel()
        mainTitle.text = "WORKOUT HISTORY"
        mainTitle.textColor = .white
        mainTitle.font = .systemFont(ofSize: 24, weight: .bold)
        
        let stats = UIStackView()
        stats.spacing = 15
        [("UPPER", .systemYellow), ("LOWER", .neonCyan), ("CORE", .systemBlue)].forEach { title, color in
            let dot = UIView()
            dot.backgroundColor = color
            dot.layer.cornerRadius = 3
            let lbl = UILabel()
            lbl.text = "\(title): 25%"
            lbl.font = .cleanBody(size: 13, weight: .medium)
            lbl.textColor = .white
            
            let item = UIStackView(arrangedSubviews: [dot, lbl])
            item.spacing = 4; item.alignment = .center
            dot.widthAnchor.constraint(equalToConstant: 6).isActive = true
            dot.heightAnchor.constraint(equalToConstant: 6).isActive = true
            stats.addArrangedSubview(item)
        }
        
        
        let monthLabel = UILabel()
        monthLabel.text = "NOVEMBER, 2024"
        monthLabel.font = .cleanBody(size: 14, weight: .bold)
        monthLabel.textColor = .white
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftDiamond = createDiamondButton(systemName: "chevron.left")
        let rightDiamond = createDiamondButton(systemName: "chevron.right")
        
        let mStack = UIStackView(arrangedSubviews: [leftDiamond, rightDiamond])
        mStack.spacing = 5
        mStack.translatesAutoresizingMaskIntoConstraints = false
        
        let masterStack = UIStackView(arrangedSubviews: [mainTitle, stats])
        masterStack.axis = .vertical
        masterStack.spacing = 5
        masterStack.alignment = .leading
        addSubview(masterStack)
        addSubview(monthLabel)
        addSubview(mStack)
        masterStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            masterStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            masterStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            masterStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            masterStack.heightAnchor.constraint(equalToConstant: 60),
            
            monthLabel.topAnchor.constraint(equalTo: masterStack.bottomAnchor, constant: 10),
            monthLabel.heightAnchor.constraint(equalToConstant: 50),
            monthLabel.leadingAnchor.constraint(equalTo: masterStack.leadingAnchor),
            monthLabel.widthAnchor.constraint(equalToConstant: 150),
            
            mStack.topAnchor.constraint(equalTo: monthLabel.topAnchor),
            mStack.heightAnchor.constraint(equalToConstant: 45),
            mStack.trailingAnchor.constraint(equalTo: masterStack.trailingAnchor),
            mStack.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func createDiamondButton(systemName: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let size: CGFloat = 45
        let path = UIBezierPath()
        path.move(to: CGPoint(x: size/2, y: 0))
        path.addLine(to: CGPoint(x: size, y: size/2))
        path.addLine(to: CGPoint(x: size/2, y: size))
        path.addLine(to: CGPoint(x: 0, y: size/2))
        path.close()
        
        let bgLayer = CAShapeLayer()
        bgLayer.path = path.cgPath
        bgLayer.fillColor = UIColor.white.withAlphaComponent(0.04).cgColor
        container.layer.addSublayer(bgLayer)
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.withAlphaComponent(0.1).cgColor
        borderLayer.lineWidth = 1.5
        container.layer.addSublayer(borderLayer)
        
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: systemName), for: .normal)
        btn.tintColor = .textGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(btn)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: size),
            container.heightAnchor.constraint(equalToConstant: size),
            btn.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            btn.widthAnchor.constraint(equalToConstant: 16),
            btn.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        return container
    }
}
