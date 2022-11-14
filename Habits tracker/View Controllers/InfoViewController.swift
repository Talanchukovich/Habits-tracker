//
//  InfoViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var attributes = TextAttributes.shared
   
    let titleLabelText = "Привычка за 21 день"
    let ifnoLabelText = """
    Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
    
    1. Провести 1 день без обращения\nк старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
    
    2. Выдержать 2 дня в прежнем состоянии самоконтроля.
    
    3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
    
    4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
    
    5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
    """
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: titleLabelText, attributes: attributes.infoTitleLabelTextAttributes)
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: ifnoLabelText, attributes: attributes.infoLabelTextAttributes)
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubview()
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = TextAttributes.shared.navigationTitleAttributes
        navigationItem.title = "Информация"
    }
    
    func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(infoView)
        infoView.addSubview(titleLabel)
        infoView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            infoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            infoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: infoView.safeAreaLayoutGuide.topAnchor, constant: 22),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -22)])
    }
}
