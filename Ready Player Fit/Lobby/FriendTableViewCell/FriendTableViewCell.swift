//
//  FriendTableViewCell.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 10/02/26.
//

import UIKit

class FriendCardCell: UITableViewCell {
    static let identifier = "FriendCardCell"
    
    private let cardView = UIView()
    private let avatarImageView = UIImageView()
    private let statusDot = UIView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let actionIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        cardView.layer.cornerRadius = 12
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        
        avatarImageView.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.clipsToBounds = true
        
        statusDot.backgroundColor = .neonCyan
        statusDot.layer.cornerRadius = 5
        statusDot.layer.borderWidth = 1.5
        statusDot.layer.borderColor = UIColor.black.cgColor
        
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        infoLabel.textColor = .white
        infoLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        actionIcon.tintColor = .gray
        actionIcon.contentMode = .scaleAspectFit
        
        [avatarImageView, statusDot, nameLabel, infoLabel, actionIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            avatarImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45),
            
            statusDot.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: -6),
            statusDot.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 2),
            statusDot.widthAnchor.constraint(equalToConstant: 10),
            statusDot.heightAnchor.constraint(equalToConstant: 10),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.centerYAnchor, constant: 0),
            
            infoLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            
            actionIcon.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            actionIcon.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            actionIcon.widthAnchor.constraint(equalToConstant: 25),
            actionIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configure(with friend: FriendModel) {
        avatarImageView.image = UIImage(named: "avatar")
        nameLabel.text = friend.name
        infoLabel.text = "Lvl \(friend.level) • Current streak: \(friend.streak) w"
        
        if friend.isInvited {
            actionIcon.image = UIImage(systemName: "checkmark")
            actionIcon.tintColor = .white
        } else {
            actionIcon.image = UIImage(systemName: "plus")
            actionIcon.tintColor = .gray
        }
    }
}
