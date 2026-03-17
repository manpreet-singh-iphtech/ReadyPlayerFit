//
//  WorkoutInvitationView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 03/02/26.
//

import Foundation
import UIKit

class WorkoutInvitationView: UIView {
    
    private let sideIconContainer = UIView()
    private let mailIcon = UIImageView()
    
    private let rightContentContainer = UIView()
    
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    
    private let declineButton = UIButton(type: .system)
    private let acceptButton = UIButton(type: .system)
    private let horizontalSeparator = UIView()
    private let verticalSeparator = UIView()
    
    private let alertView = UIView()
    private let alertLabel = UILabel()
    private let alertButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpAlert()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        backgroundColor = .clear
        
        sideIconContainer.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.16)
        sideIconContainer.layer.cornerRadius = 12
        sideIconContainer.layer.borderWidth = 1
        sideIconContainer.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.16).cgColor
        
        mailIcon.image = UIImage(systemName: "envelope.fill")
        mailIcon.tintColor = .neonCyan
        mailIcon.contentMode = .scaleAspectFit
        
        rightContentContainer.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.16)
        rightContentContainer.layer.cornerRadius = 12
        rightContentContainer.layer.borderWidth = 1
        rightContentContainer.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.16).cgColor
        rightContentContainer.clipsToBounds = true
        
        titleLabel.text = "WORKOUT INVITATION"
        titleLabel.font = .systemFont(ofSize: 14, weight: .black)
        titleLabel.textColor = .white
        
        bodyLabel.text = "Your friend has invited you to join the multiple workout."
        bodyLabel.font = .systemFont(ofSize: 12, weight: .regular)
        bodyLabel.textColor = .white
        bodyLabel.numberOfLines = 2
        
        horizontalSeparator.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        verticalSeparator.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        configureButton(declineButton, title: "DECLINE", color: .textGray)
        configureButton(acceptButton, title: "ACCEPT", color: .neonCyan)
        
        acceptButton.tag = 0
        declineButton.tag = 1
        
        [acceptButton, declineButton].forEach {
            $0.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        }
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        
        [sideIconContainer, rightContentContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        sideIconContainer.addSubview(mailIcon)
        mailIcon.translatesAutoresizingMaskIntoConstraints = false
        
        [textStack, horizontalSeparator, verticalSeparator, declineButton, acceptButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            rightContentContainer.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            sideIconContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            sideIconContainer.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            sideIconContainer.heightAnchor.constraint(equalToConstant: 120),
            sideIconContainer.widthAnchor.constraint(equalToConstant: 50),
            
            mailIcon.centerXAnchor.constraint(equalTo: sideIconContainer.centerXAnchor),
            mailIcon.centerYAnchor.constraint(equalTo: sideIconContainer.centerYAnchor),
            mailIcon.widthAnchor.constraint(equalToConstant: 20),
            
            rightContentContainer.leadingAnchor.constraint(equalTo: sideIconContainer.trailingAnchor, constant: 8),
            rightContentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightContentContainer.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            rightContentContainer.heightAnchor.constraint(equalToConstant: 120),
            rightContentContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            textStack.topAnchor.constraint(equalTo: rightContentContainer.topAnchor, constant: 15),
            textStack.leadingAnchor.constraint(equalTo: rightContentContainer.leadingAnchor, constant: 15),
            textStack.trailingAnchor.constraint(equalTo: rightContentContainer.trailingAnchor, constant: -15),
            
            horizontalSeparator.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 15),
            horizontalSeparator.leadingAnchor.constraint(equalTo: rightContentContainer.leadingAnchor),
            horizontalSeparator.trailingAnchor.constraint(equalTo: rightContentContainer.trailingAnchor),
            horizontalSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            verticalSeparator.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor),
            verticalSeparator.bottomAnchor.constraint(equalTo: rightContentContainer.bottomAnchor),
            verticalSeparator.centerXAnchor.constraint(equalTo: rightContentContainer.centerXAnchor),
            verticalSeparator.widthAnchor.constraint(equalToConstant: 1),
            
            declineButton.leadingAnchor.constraint(equalTo: rightContentContainer.leadingAnchor),
            declineButton.trailingAnchor.constraint(equalTo: verticalSeparator.leadingAnchor),
            declineButton.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor),
            declineButton.bottomAnchor.constraint(equalTo: rightContentContainer.bottomAnchor),
            declineButton.heightAnchor.constraint(equalToConstant: 39),
            
            acceptButton.leadingAnchor.constraint(equalTo: verticalSeparator.trailingAnchor),
            acceptButton.trailingAnchor.constraint(equalTo: rightContentContainer.trailingAnchor),
            acceptButton.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor),
            acceptButton.bottomAnchor.constraint(equalTo: rightContentContainer.bottomAnchor),
            acceptButton.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    private func configureButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    }
    
    private func setUpAlert() {
//        alertView.axis = .vertical
//        alertView.alignment = .center
        alertView.layer.cornerRadius = 16
        alertView.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.16)
        alertView.layer.borderWidth = 1
        alertView.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.16).cgColor
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.alpha = 0
            
        alertLabel.textColor = .white
        alertLabel.font = .systemFont(ofSize: 14, weight: .regular)
        alertLabel.textAlignment = .center
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        alertButton.setTitle("OK", for: .normal)
        alertButton.setTitleColor(.black, for: .normal)
        alertButton.backgroundColor = .neonCyan
        alertButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        alertButton.layer.cornerRadius = 10
        alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(alertView)
        alertView.addSubview(alertLabel)
        alertView.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 220),
            alertView.heightAnchor.constraint(equalToConstant: 100),
            
            alertLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 5),
            alertLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            alertLabel.heightAnchor.constraint(equalToConstant: 40),
            alertLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),

            alertButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: 100),
            alertButton.heightAnchor.constraint(equalToConstant: 35),
            alertButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -15)
        ])
    }
    
    @objc func handleButtonTapped(_ sender: UIButton) {
        print("tapped")
        
        [rightContentContainer, sideIconContainer].forEach {
            $0 .isHidden = true
            $0 .alpha = 0
        }
        
        if sender.tag == 0 {
            alertLabel.text = "Invitation Accepted!"
        }
        else {
            alertLabel.text = "Invitation Declined!"
        }
        self.alertView.isHidden = false
        self.alertView.alpha = 1
    }
    
    @objc func alertButtonTapped(){
        self.alertView.isHidden = true
        self.alertView.alpha = 0
    }
}
