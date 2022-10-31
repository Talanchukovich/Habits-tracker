//
//  HabitCollectionViewCell.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 31.10.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    let attributes = TextAttributes.shared
    
    struct ViewModel {
        var name: String
        var date: Date
        var color: UIColor
        var count: Int
    }
    
    private lazy var habitNameLabel: UILabel = {
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
        habitNameLabel.attributedText = NSAttributedString(string: viewModel.name,
                                                           attributes: attributes.habitNameLabelCellAttributes)
        habitDateLabel.attributedText = NSAttributedString(string: "Каждый день в " + attributes.dateFormatter.string(from: viewModel.date),
                                                           attributes: attributes.habitDateLabelCellAttributes)
        countHabitLabel.attributedText = NSAttributedString(string: "Счетчик: \(viewModel.count)",
                                                            attributes: attributes.habitCountLabelCellAttributes)
        habitCircleButton.layer.borderColor = viewModel.color.cgColor
    }
    
    func setView() {
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
}
