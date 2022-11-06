//
//  HabitDetailsTableViewCell.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 04.11.2022.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var dateLabelText: String
        var isHidden: Bool
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "check")?.withTintColor(UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)))
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.addSubview(dateLabel)
        self.addSubview(checkView)
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        
            checkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            checkView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    func setupView(viewModel: ViewModel) {
        dateLabel.text = viewModel.dateLabelText
        checkView.isHidden = viewModel.isHidden
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        checkView.image = nil
    }
}
