//
//  InviteFriendsViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 06/02/26.
//

import Foundation
import UIKit

struct FriendModel {
    let name: String
    let level: Int
    let streak: Int
    var isInvited: Bool = false
}

final class InviteFriendsViewController: UIViewController {
    
    private let successBanner = UIView()
    private var friends: [FriendModel] = [
        FriendModel(name: "Layla Ramsey", level: 2, streak: 5),
        FriendModel(name: "Ethan Brooks", level: 1, streak: 1),
        FriendModel(name: "Evelyn Castillo", level: 3, streak: 2)
    ]
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let searchField = UITextField()
    private let shareContainer = UIStackView()
    private let friendCountLabel = UILabel()
    private let linkContainer = UIView()
    private let linkLabel = UILabel()
    private let copyButton = UIView()
    private let shareButton = UIButton(type: .system)
    private let tableView = UITableView()
    private let startButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        setupLayout()
        setupTableView()
        setupSuccessBanner()
    }
    
    private func setupLayout() {
        containerView.backgroundColor = .bgDark
        containerView.layer.cornerRadius = 24
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        titleLabel.text = "CHOOSE YOUR WORKOUT TEAM!"
        titleLabel.font = .systemFont(ofSize: 20, weight: .black)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        descriptionLabel.text = "Invite up to 3 friends or random players to your workout. Start anytime – no need to wait for others."
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        searchField.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
        searchField.layer.cornerRadius = 8
        searchField.attributedPlaceholder = NSAttributedString(string: "SEARCH FOR A FRIEND", attributes: [.foregroundColor: UIColor.textGray])
        searchField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        searchField.leftViewMode = .always
        searchField.textColor = .white
        
        friendCountLabel.text = "YOUR FRIENDS: 3"
        friendCountLabel.font = .systemFont(ofSize: 14, weight: .bold)
        friendCountLabel.textColor = .white
        
        linkContainer.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
        linkContainer.layer.cornerRadius = 8
        
        linkLabel.text = "HTTPS://EXAM..."
        linkLabel.textColor = .lightGray
        
        copyButton.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
        copyButton.layer.cornerRadius = 8
        copyButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
        
        let copyIcon = UIImageView(image: UIImage(systemName: "document.on.document.fill"))
        copyIcon.tintColor = .lightGray
        copyIcon.contentMode = .scaleAspectFit
        
        shareButton.backgroundColor = .neonCyan
        shareButton.setTitle("SHARE", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        shareButton.layer.cornerRadius = 8
        
        startButton.backgroundColor = .neonCyan
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        startButton.layer.cornerRadius = 12
        
        cancelButton.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        cancelButton.layer.cornerRadius = 12
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        [containerView, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        copyButton.addSubview(copyIcon)
        
        [titleLabel, descriptionLabel, searchField, friendCountLabel, tableView, copyButton, copyIcon, shareButton, linkContainer, linkLabel, cancelButton, startButton, successBanner].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            searchField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            searchField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 45),
            
            copyButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            copyButton.widthAnchor.constraint(equalToConstant: 38),
            copyButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 13),
            copyButton.heightAnchor.constraint(equalToConstant: 38),
            
            copyIcon.centerXAnchor.constraint(equalTo: copyButton.centerXAnchor),
            copyIcon.centerYAnchor.constraint(equalTo: copyButton.centerYAnchor),
            copyIcon.widthAnchor.constraint(equalTo: copyButton.widthAnchor, multiplier: 0.5),
            
            linkContainer.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            linkContainer.leadingAnchor.constraint(equalTo: copyIcon.trailingAnchor, constant: 20),
            linkContainer.widthAnchor.constraint(equalToConstant: 180),
            linkContainer.heightAnchor.constraint(equalToConstant: 45),
            
            linkLabel.topAnchor.constraint(equalTo: linkContainer.topAnchor, constant: 10),
            linkLabel.bottomAnchor.constraint(equalTo: linkContainer.bottomAnchor, constant: -10),
            linkLabel.leadingAnchor.constraint(equalTo: linkContainer.leadingAnchor, constant: 10),
            
            shareButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: linkContainer.trailingAnchor, constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 45),
            
            friendCountLabel.topAnchor.constraint(equalTo: copyIcon.bottomAnchor, constant: 35),
            friendCountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: friendCountLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
            
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 45),
            cancelButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 150),
            
            startButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            startButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 45),
            
            closeButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendCardCell.self, forCellReuseIdentifier: FriendCardCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func setupSuccessBanner() {
        successBanner.backgroundColor = .clear
        successBanner.layer.borderWidth = 0
        successBanner.alpha = 0
        successBanner.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(successBanner)
        
        let iconBox = UIView()
        iconBox.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.16)
        iconBox.layer.cornerRadius = 12
        iconBox.layer.borderWidth = 1
        iconBox.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.16).cgColor
        iconBox.translatesAutoresizingMaskIntoConstraints = false
        
        let mailIcon = UIImageView(image: UIImage(systemName: "envelope.fill"))
        mailIcon.tintColor = .neonCyan
        mailIcon.contentMode = .scaleAspectFit
        mailIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let messageBox = UIView()
        messageBox.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.16)
        messageBox.layer.cornerRadius = 12
        messageBox.layer.borderWidth = 1
        messageBox.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.16).cgColor
        messageBox.translatesAutoresizingMaskIntoConstraints = false
        
        let successTitle = UILabel()
        successTitle.text = "SUCCESS!"
        successTitle.font = .systemFont(ofSize: 16, weight: .bold)
        successTitle.textColor = .white
        successTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let successMsg = UILabel()
        successMsg.text = "The invitation was sent!"
        successMsg.font = .systemFont(ofSize: 12, weight: .regular)
        successMsg.textColor = .white
        successMsg.translatesAutoresizingMaskIntoConstraints = false
        
        successBanner.addSubview(iconBox)
        iconBox.addSubview(mailIcon)
        successBanner.addSubview(messageBox)
        messageBox.addSubview(successTitle)
        messageBox.addSubview(successMsg)
        
        NSLayoutConstraint.activate([
            successBanner.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
            successBanner.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            successBanner.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            successBanner.heightAnchor.constraint(equalToConstant: 65),
            
            iconBox.leadingAnchor.constraint(equalTo: successBanner.leadingAnchor),
            iconBox.topAnchor.constraint(equalTo: successBanner.topAnchor),
            iconBox.bottomAnchor.constraint(equalTo: successBanner.bottomAnchor),
            iconBox.widthAnchor.constraint(equalTo: iconBox.heightAnchor),
            
            mailIcon.centerXAnchor.constraint(equalTo: iconBox.centerXAnchor),
            mailIcon.centerYAnchor.constraint(equalTo: iconBox.centerYAnchor),
            mailIcon.widthAnchor.constraint(equalToConstant: 22),
            
            messageBox.leadingAnchor.constraint(equalTo: iconBox.trailingAnchor, constant: 5),
            messageBox.trailingAnchor.constraint(equalTo: successBanner.trailingAnchor),
            messageBox.topAnchor.constraint(equalTo: successBanner.topAnchor),
            messageBox.bottomAnchor.constraint(equalTo: successBanner.bottomAnchor),
            
            successTitle.leadingAnchor.constraint(equalTo: messageBox.leadingAnchor, constant: 15),
            successTitle.topAnchor.constraint(equalTo: messageBox.topAnchor, constant: 12),
            
            successMsg.leadingAnchor.constraint(equalTo: successTitle.leadingAnchor),
            successMsg.topAnchor.constraint(equalTo: successTitle.bottomAnchor, constant: 2)
        ])
    }
    
    private func showSuccess() {
        successBanner.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.3) {
            self.successBanner.alpha = 1
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                UIView.animate(withDuration: 0.3) {
                    self.successBanner.alpha = 0
                }
            }
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

extension InviteFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCardCell.identifier, for: indexPath) as! FriendCardCell
        cell.configure(with: friends[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friends[indexPath.row].isInvited.toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
        showSuccess()
    }
}
