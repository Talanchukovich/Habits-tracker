//
//  HabitCollectionViewCell.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 31.10.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    let attributes = TextAttributes.shared
    var trackHabitComletision: (()->Void)?
    
    struct ViewModel {
        var name: String
        var date: Date
        var color: UIColor
        var count: Int
        var isAlreadyTakenToday: Bool
    }
    
    lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var habitCircleButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.setImage(UIImage(named: "check"), for: .normal)
        button.addTarget(self, action: #selector(trackHabit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(viewModel: ViewModel) {
        let habitNameLabelAttributes = [NSAttributedString.Key.font: UIFont
            .systemFont(ofSize: 17, weight: .regular) as Any,
                                        .kern: -0.41,
                                        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                        .foregroundColor: viewModel.color]
        let habitName = NSAttributedString(string: viewModel.name,
                                           attributes: habitNameLabelAttributes)
        let habitDate = NSAttributedString(string: "Каждый день в " + attributes.dateFormatter.string(from: viewModel.date),
                                           attributes: attributes.habitDateLabelCellAttributes)
        let countHabit = NSAttributedString(string: "Счетчик: \(viewModel.count)",
                                            attributes: attributes.habitCountLabelCellAttributes)
        var  habitCircleButtonBackgroundColor: UIColor {
            viewModel.isAlreadyTakenToday == true ? viewModel.color : .white
        }
        habitNameLabel.attributedText = habitName
        habitDateLabel.attributedText = habitDate
        countHabitLabel.attributedText = countHabit
        habitCircleButton.layer.borderColor = viewModel.color.cgColor
        habitCircleButton.backgroundColor = habitCircleButtonBackgroundColor
    }
    
    private func setView() {
        self.backgroundColor = .white
        let viewes = [habitNameLabel, habitDateLabel, countHabitLabel, habitCircleButton]
        viewes.forEach{self.addSubview($0)}
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            habitNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            habitNameLabel.widthAnchor.constraint(equalToConstant: 220),
            
            habitDateLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitDateLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            
            countHabitLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            countHabitLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            
            habitCircleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            habitCircleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            habitCircleButton.widthAnchor.constraint(equalToConstant: 36),
            habitCircleButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    override func prepareForReuse() {
        habitNameLabel.text = nil
        habitDateLabel.text = nil
        countHabitLabel.text = nil
        habitCircleButton.backgroundColor = nil
    }
    
    @objc func trackHabit() {
        trackHabitComletision?()
        
    }
}
