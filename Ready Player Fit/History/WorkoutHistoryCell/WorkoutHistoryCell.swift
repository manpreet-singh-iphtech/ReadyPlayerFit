//
//  WorkoutHistoryCell.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 11/02/26.
//

import Foundation
import UIKit

class WorkoutHistoryCell: UITableViewCell {
    
    private let topContainer = UIView()
    private let muscleContainer = UIView()
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let exerciseHeaderLabel = UILabel()
    private let exercisesListLabel = UILabel()
    private let badgeStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        topContainer.backgroundColor = .white.withAlphaComponent(0.04)
        topContainer.layer.borderWidth = 1
        topContainer.layer.cornerRadius = 12
        topContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        [topContainer, muscleContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let titleStack = UIStackView(arrangedSubviews: [dateLabel, titleLabel])
        titleStack.axis = .vertical; titleStack.spacing = 4
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        topContainer.addSubview(titleStack)
        
        setupBadges()
        [exerciseHeaderLabel, exercisesListLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topContainer.addSubview($0)
        }
        
//        let muscleStack = createMuscleStack()
//        muscleContainer.addSubview(muscleStack)
//        muscleStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            topContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleStack.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 15),
            titleStack.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 20),
            
            badgeStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: 12),
            badgeStack.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 20),
            
            exerciseHeaderLabel.topAnchor.constraint(equalTo: badgeStack.bottomAnchor, constant: 15),
            exerciseHeaderLabel.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 20),
            
            exercisesListLabel.topAnchor.constraint(equalTo: exerciseHeaderLabel.bottomAnchor, constant: 4),
            exercisesListLabel.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 20),
            exercisesListLabel.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -20),
            exercisesListLabel.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -20),
            
            muscleContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 5),
            muscleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            muscleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            muscleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setupBadges() {
        let metrics = [("clock", "45 min"), ("dumbbell.fill", "6 exercises"), ("flame.fill", "265 kcal")]
        badgeStack.spacing = 8
        badgeStack.translatesAutoresizingMaskIntoConstraints = false
        topContainer.addSubview(badgeStack)
        
        metrics.forEach { icon, text in
            let pill = UIView()
            pill.backgroundColor = .black.withAlphaComponent(0.3)
            pill.layer.borderWidth = 2
            pill.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            pill.layer.cornerRadius = 8
            let img = UIImageView(image: UIImage(systemName: icon))
            img.tintColor = .textGray
            let lbl = UILabel()
            lbl.text = text
            lbl.textColor = .white
            lbl.font = .cleanBody(size: 11)
            
            let pStack = UIStackView(arrangedSubviews: [img, lbl])
            pStack.spacing = 4
            pStack.translatesAutoresizingMaskIntoConstraints = false
            pill.addSubview(pStack)
            NSLayoutConstraint.activate([
                pStack.leadingAnchor.constraint(equalTo: pill.leadingAnchor, constant: 8),
                pStack.trailingAnchor.constraint(equalTo: pill.trailingAnchor, constant: -8),
                pStack.centerYAnchor.constraint(equalTo: pill.centerYAnchor),
                pill.heightAnchor.constraint(equalToConstant: 26),
                img.widthAnchor.constraint(equalToConstant: 12), img.heightAnchor.constraint(equalToConstant: 12)
            ])
            badgeStack.addArrangedSubview(pill)
        }
    }
    
    private func createMuscleStack(muscles: [Muscle]) -> UIStackView {
        
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        muscles.forEach { muscle in
            
            let box = UIView()
            box.backgroundColor = .white.withAlphaComponent(0.04)
            box.layer.borderWidth = 1
            box.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            box.layer.cornerRadius = 12
            
            let icon = UIImageView()
            icon.image = UIImage(named: muscle.assetName)
            icon.contentMode = .scaleAspectFit
            
            let lbl = UILabel()
            lbl.text = muscle.name
            lbl.textColor = .white
            lbl.font = .cleanBody(size: 13)
            lbl.textAlignment = .center
            
            let vStack = UIStackView(arrangedSubviews: [icon, lbl])
            vStack.axis = .vertical
            vStack.spacing = 4
            vStack.translatesAutoresizingMaskIntoConstraints = false
            
            box.addSubview(vStack)
            
            NSLayoutConstraint.activate([
                vStack.topAnchor.constraint(equalTo: box.topAnchor, constant: 12),
                vStack.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -12),
                vStack.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 4),
                vStack.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -4),
                
                icon.heightAnchor.constraint(equalToConstant: 35),
                icon.widthAnchor.constraint(equalToConstant: 35)
            ])
            
            stack.addArrangedSubview(box)
        }
        
        return stack
    }
    
    func configure(
        date: String,
        title: String,
        exercises: String,
        muscles: [Muscle]
    ) {
        
        dateLabel.text = date
        dateLabel.textColor = .lightGray
        dateLabel.font = .cleanBody(size: 12, weight: .bold)
        
        titleLabel.text = title
        titleLabel.font = .cleanBody(size: 18, weight: .bold)
        titleLabel.textColor = .white
        
        exerciseHeaderLabel.text = "Exercises:"
        exerciseHeaderLabel.textColor = .white
        exerciseHeaderLabel.font = .cleanBody(size: 13, weight: .bold)
        
        let attr = NSMutableAttributedString(string: exercises, attributes: [
            .font: UIFont.cleanBody(size: 12),
            .foregroundColor: UIColor.white
        ])
        exercisesListLabel.attributedText = attr
        exercisesListLabel.numberOfLines = 2
        
        let muscleStack = createMuscleStack(muscles: muscles)
        muscleStack.translatesAutoresizingMaskIntoConstraints = false
        
        muscleContainer.subviews.forEach { $0.removeFromSuperview() }
        muscleContainer.addSubview(muscleStack)
        
        NSLayoutConstraint.activate([
            muscleStack.topAnchor.constraint(equalTo: muscleContainer.topAnchor),
            muscleStack.leadingAnchor.constraint(equalTo: muscleContainer.leadingAnchor),
            muscleStack.trailingAnchor.constraint(equalTo: muscleContainer.trailingAnchor),
            muscleStack.bottomAnchor.constraint(equalTo: muscleContainer.bottomAnchor),
            muscleStack.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
