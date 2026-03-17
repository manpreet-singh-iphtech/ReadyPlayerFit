//
//  MuscleCell.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 17/02/26.
//

import UIKit

class MuscleTableViewCell: UITableViewCell {
    static let identifier = "MuscleTableViewCell"
    
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .cardGray
        v.layer.cornerRadius = 12
        return v
    }()
    
    private let muscleIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .neonCyan
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 14, weight: .bold)
        return l
    }()
    
    private let selectionCircle: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.textGray.withAlphaComponent(0.3).cgColor
        v.backgroundColor = UIColor.textGray.withAlphaComponent(0.3)
        return v
    }()
    
    private let iconContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .cardGray
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        v.layer.cornerRadius = 12
        return v
    }()

    private let contentContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .cardGray
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        v.layer.cornerRadius = 12
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        [iconContainer, contentContainer].forEach { contentView.addSubview($0) }
        iconContainer.addSubview(muscleIcon)
        [titleLabel, selectionCircle].forEach { contentContainer.addSubview($0) }
        
        [iconContainer, contentContainer, muscleIcon, titleLabel, selectionCircle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 75),
//            iconContainer.heightAnchor.constraint(equalToConstant: 75),
            
            muscleIcon.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor, constant: 2),
            muscleIcon.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            muscleIcon.widthAnchor.constraint(equalToConstant: 80),
            muscleIcon.heightAnchor.constraint(equalToConstant: 60),
            
            contentContainer.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 5),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: iconContainer.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            
            selectionCircle.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -15),
            selectionCircle.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            selectionCircle.widthAnchor.constraint(equalToConstant: 20),
            selectionCircle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with title: String, imageName: String) {
        titleLabel.text = title
        
        let customImage = UIImage(named: imageName)
        muscleIcon.image = customImage
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
