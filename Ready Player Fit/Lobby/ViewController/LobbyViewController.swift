//
//  LobbyViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

final class LobbyViewController: UIViewController {
    
    private let headerLabel = UILabel()
    private let xpBar = XPProgressView(currentXP: 500, totalXP: 1000)
    private let coinBox = CoinView()
    
    private let lobbyToggle = ProfileToggleButton()
    private let avatarView = AvatarView()
    
    private let invitationView = WorkoutInvitationView()
    private let bottomActionTray = LobbyActionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgDark
        setupLayout()
        configureLobbyToggle()
        bottomActionTray.onPlusTap = { [weak self] in
            self?.presentInviteFriends()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarView.refreshAvatar()
    }
    
    private func configureLobbyToggle() {
        lobbyToggle.setTitles(left: "PLAY", right: "QUESTS")
    }
    
    private func setupLayout() {
        headerLabel.text = "LOBBY"
        headerLabel.font = .systemFont(ofSize: 24, weight: .black)
        headerLabel.textColor = .white
        
        [headerLabel, xpBar, coinBox, lobbyToggle, avatarView, invitationView, bottomActionTray].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            xpBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            xpBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            xpBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            coinBox.centerYAnchor.constraint(equalTo: xpBar.centerYAnchor),
            coinBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            coinBox.leadingAnchor.constraint(equalTo: xpBar.trailingAnchor, constant: 10),
            coinBox.heightAnchor.constraint(equalTo: xpBar.heightAnchor),
            
            lobbyToggle.topAnchor.constraint(equalTo: xpBar.bottomAnchor, constant: 20),
            lobbyToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lobbyToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lobbyToggle.heightAnchor.constraint(equalToConstant: 45),
            
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.topAnchor.constraint(equalTo: lobbyToggle.bottomAnchor, constant: 10),
            avatarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            avatarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.46),
            
            invitationView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -60),
            invitationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            invitationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bottomActionTray.topAnchor.constraint(equalTo: invitationView.bottomAnchor, constant: 20),
            bottomActionTray.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            bottomActionTray.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomActionTray.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func presentInviteFriends() {
        let inviteVC = InviteFriendsViewController()
        inviteVC.modalPresentationStyle = .overFullScreen
        inviteVC.modalTransitionStyle = .crossDissolve
        self.present(inviteVC, animated: true)
    }
}
