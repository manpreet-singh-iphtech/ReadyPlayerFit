//
//  LockerItemCell.swift
//  Ready Player Fit
//
//  Created by Manpreet Singh on 02/02/26.
//

import Foundation
import UIKit

class LockerItemCell: UICollectionViewCell {
    private let cardView = UIView()
    private let iconView = UIImageView()
    
    private let labelStack = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        cardView.layer.cornerRadius = 16
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        iconView.clipsToBounds = true
        iconView.contentMode = .scaleAspectFit
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        labelStack.axis = .vertical
        labelStack.alignment = .center
        labelStack.spacing = 2
        labelStack.layer.borderWidth = 1
        labelStack.layer.cornerRadius = 8
        labelStack.backgroundColor = .white
        labelStack.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        labelStack.isLayoutMarginsRelativeArrangement = true
        labelStack.layoutMargins = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        
        [cardView, labelStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(descriptionLabel)
        
        cardView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 130),
            
            iconView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.heightAnchor.constraint(equalToConstant: 80),
            
            labelStack.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 5),
            labelStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with image: String, title: String, subtitle: String) {
        iconView.image = UIImage(named: image)
        titleLabel.text = title
        descriptionLabel.text = subtitle
    }
}
