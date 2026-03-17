//
//  WorkoutHeaderView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 17/02/26.
//

import UIKit

class WorkoutHeaderView: UIView {
    
    private let progressStack = UIStackView()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "YOUR RECENT WORKOUT DETAILS"
        l.numberOfLines = 0
        l.textColor = .white
        l.font = .systemFont(ofSize: 20, weight: .medium)
        return l
    }()
    
    private let subLabel: UILabel = {
        let l = UILabel()
        l.text = "To build your first workout, RPF analyzes your recent muscle usage."
        l.numberOfLines = 2
        l.textColor = .white
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    private let sliderCard: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        v.layer.cornerRadius = 12
        return v
    }()
    
    private let sliderTitle: UILabel = {
        let l = UILabel()
        l.text = "Days ago"
        l.textColor = .white
        l.font = .systemFont(ofSize: 14, weight: .bold)
        return l
    }()
    
    private let customSlider: UISlider = {
        let s = UISlider()
        s.minimumTrackTintColor = .neonCyan
        s.maximumTrackTintColor = .darkGray
        
        let size = CGSize(width: 25, height: 20)
        let offset: CGFloat = 6
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.neonCyan.cgColor)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: offset, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: 0))
            path.addLine(to: CGPoint(x: size.width - offset, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
            path.close()
            
            context.addPath(path.cgPath)
            context.fillPath()
        }
        
        let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        s.setThumbImage(thumbImage, for: .normal)
        s.setThumbImage(thumbImage, for: .highlighted)
        return s
    }()
    
    private let labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        let labels = ["Today", "1-2", "2-4", ">4"].map { text -> UILabel in
            let l = UILabel()
            l.text = text
            l.textColor = .textGray
            l.font = .systemFont(ofSize: 12)
            return l
        }
        labels.forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        progressStack.axis = .horizontal
        progressStack.distribution = .fillEqually
        progressStack.spacing = 4
        
        for i in 0..<8 {
            let segment = UIView()
            segment.backgroundColor = i < 6 ? .neonCyan : .white.withAlphaComponent(0.3)
            segment.heightAnchor.constraint(equalToConstant: 4).isActive = true
            progressStack.addArrangedSubview(segment)
        }
        
        [progressStack, titleLabel, subLabel, sliderCard].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [sliderTitle, customSlider, labelStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            sliderCard.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            progressStack.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            progressStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: progressStack.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            sliderCard.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 20),
            sliderCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            sliderCard.trailingAnchor.constraint(equalTo: trailingAnchor),
            sliderCard.heightAnchor.constraint(equalToConstant: 100),
            
            sliderTitle.topAnchor.constraint(equalTo: sliderCard.topAnchor, constant: 12),
            sliderTitle.leadingAnchor.constraint(equalTo: sliderCard.leadingAnchor, constant: 16),
            
            customSlider.centerYAnchor.constraint(equalTo: sliderCard.centerYAnchor, constant: 5),
            customSlider.leadingAnchor.constraint(equalTo: sliderCard.leadingAnchor, constant: 16),
            customSlider.trailingAnchor.constraint(equalTo: sliderCard.trailingAnchor, constant: -16),
            
            labelStack.topAnchor.constraint(equalTo: customSlider.bottomAnchor, constant: 8),
            labelStack.leadingAnchor.constraint(equalTo: customSlider.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: customSlider.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
