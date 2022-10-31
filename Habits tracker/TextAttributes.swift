//
//  TextAttributes.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

private func paragraphStyle(lineHeightMultiple: CGFloat) -> NSMutableParagraphStyle {
    let style = NSMutableParagraphStyle()
    style.lineHeightMultiple = lineHeightMultiple
    return style
}

class TextAttributes {
    
    static let shared = TextAttributes()
    private init() {}
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    lazy var tabBarAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 10, weight: .medium) as Any,
        .kern: 0.16,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 0.89),
        .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    lazy var navigationTitleAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .semibold) as Any,
        .kern: -0.41,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
        .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    lazy var saveBarButtonItemTitleAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .semibold) as Any,
        .kern: -0.41,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
        .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    lazy var cancellBarButtonItemTitleAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
        .kern: -0.41,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
        .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    lazy var habitLabelAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold) as Any,
        .kern: -0.08,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
        .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    lazy var habitTextFieldTextlAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
        .kern: -0.41,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
        .foregroundColor: UIColor.black]
    
    lazy var habitTextFieldPlaceHolderlAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
        .kern: -0.41,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
        .foregroundColor: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)]
    
    lazy var dateLabelAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold) as Any,
        .kern: -0.08,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
        .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    lazy var habitNameLabelCellAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
        .kern: -0.41,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                             .foregroundColor: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)]
    
    lazy var habitDateLabelCellAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 12, weight: .regular) as Any,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.12),
        .foregroundColor: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)]
    
    lazy var habitCountLabelCellAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .regular) as Any,
        .kern: -0.08,
        .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
        .foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)]
}
