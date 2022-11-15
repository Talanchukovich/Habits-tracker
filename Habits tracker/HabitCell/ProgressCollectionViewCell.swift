//
//  ProgressCollectionViewCell.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 07.11.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel {
        var todayProgress: Float
    }
    
    private lazy var allDoneLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Все получится!", attributes: TextAttributes.allDoneLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentProgressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        view.layer.cornerRadius = 3.5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(viewModel: ViewModel) {
        let witdhCurrentProgressView: CGFloat = (self.bounds.width - 24) * CGFloat(viewModel.todayProgress)
        let todayProgress = "\(Int(viewModel.todayProgress * 100))%"
        progressLabel.attributedText = NSAttributedString(string: todayProgress, attributes: TextAttributes.allDoneLabelAttributes)
        currentProgressView.frame = CGRect(x: 0, y: 0, width: witdhCurrentProgressView, height: 7)
    }
    
    private func setupView(){
        self.backgroundColor = .white
        progressView.addSubview(currentProgressView)
        let viewes = [allDoneLabel, progressLabel, progressView]
        viewes.forEach{self.addSubview($0)}
        
        NSLayoutConstraint.activate([
            allDoneLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            allDoneLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            progressLabel.centerYAnchor.constraint(equalTo: allDoneLabel.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: allDoneLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: allDoneLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: progressLabel.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 7),
        ])
    }
}
