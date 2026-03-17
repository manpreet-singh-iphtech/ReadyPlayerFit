//
//  GoalStreakView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

class GoalStreakView: UIView {
    private let stackView = UIStackView()
    
    private weak var weeklyGoalValueLabel: UILabel?
    private weak var weeklyGoalIcon: UIImageView?
    private weak var weeklyGoalCard: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupCards()
    }
    
    private func setupCards() {
        let cardData = [
            (title: "Weekly goal", value: "1/3", icon: "trophy.fill"),
            (title: "Current streak", value: "3 WEEKS", icon: "calendar.badge.clock"),
            (title: "Longest streak", value: "5 WEEKS", icon: "medal.fill")
        ]
        
        for (index, data) in cardData.enumerated() {
            let card = createCard(title: data.title, value: data.value, icon: data.icon)
            stackView.addArrangedSubview(card)
            
            card.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            card.alpha = 0
        }
    }
    
    func animateCardsIn() {
        let trophy = weeklyGoalIcon
        trophy?.alpha = 0
        resetCards()
        for (index, card) in stackView.arrangedSubviews.enumerated() {
            UIView.animate(withDuration: 0.6,
                           delay: Double(index) * 0.15,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseOut,
                           animations: {
                card.transform = .identity
                card.alpha = 1
            }, completion: nil)
        }
    }
    
    func animateWeeklyGoalProgress() {

        guard let label = weeklyGoalValueLabel,
              let trophy = weeklyGoalIcon else { return }
//        trophy.alpha = 1

        let steps = ["1/1", "2/3", "3/3"]

        var index = 0

        func updateStep() {

            if index >= steps.count {
                return
            }

            UIView.transition(
                with: label,
                duration: 0.35,
                options: .transitionFlipFromTop,
                animations: {
                    label.text = steps[index]
                })

            if index == steps.count - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    trophy.alpha = 1
                    self.weeklyGoalCard?.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.25)
                    self.weeklyGoalValueLabel?.text = "DONE"
                    self.animateTrophyPop(trophy)
                }
            }

            index += 1

            if index < steps.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    updateStep()
                }
            }
        }

        updateStep()
    }
    
    private func animateTrophyPop(_ trophy: UIImageView) {

        trophy.layer.shadowColor = UIColor.neonCyan.cgColor
        trophy.layer.shadowRadius = 12
        trophy.layer.shadowOpacity = 1
        trophy.layer.shadowOffset = .zero

        trophy.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        UIView.animate(
            withDuration: 1.2,
            delay: 0,
            usingSpringWithDamping: 1.5,
            initialSpringVelocity: 0.9,
            options: [],
            animations: {
                trophy.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                self.weeklyGoalValueLabel?.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            })
    }
    
    private func resetCards() {
        for card in stackView.arrangedSubviews {
            card.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            card.alpha = 0
        }
    }
    
    private func createCard(title: String, value: String, icon: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor.cardGray.withAlphaComponent(1.0)
        card.layer.cornerRadius = 12
        
        let tLabel = UILabel()
        tLabel.text = title
        tLabel.textColor = .white
        tLabel.font = .systemFont(ofSize: 12)
        
        let vLabel = UILabel()
        vLabel.text = value
        vLabel.textColor = .neonCyan
        vLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        let iconImg = UIImageView(image: UIImage(systemName: icon))
        iconImg.tintColor = .neonCyan
        
        if title == "Weekly goal" {
            weeklyGoalValueLabel = vLabel
            weeklyGoalValueLabel?.font = .systemFont(ofSize: 22, weight: .medium)
            weeklyGoalIcon = iconImg
//            weeklyGoalIcon?.alpha = 0
            weeklyGoalCard = card
        }
        
        [tLabel, vLabel, iconImg].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            card.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 75),
            
            tLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            tLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            
            vLabel.topAnchor.constraint(equalTo: tLabel.bottomAnchor, constant: 4),
            vLabel.leadingAnchor.constraint(equalTo: tLabel.leadingAnchor),
            vLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12),
            
            iconImg.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            iconImg.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            iconImg.widthAnchor.constraint(equalToConstant: 24),
            iconImg.heightAnchor.constraint(equalToConstant: 24)
        ])
        return card
    }
}
