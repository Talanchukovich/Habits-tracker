//
//  TextAttributes.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

enum TextAttributes {
    
    static func paragraphStyle(lineHeightMultiple: CGFloat) -> NSMutableParagraphStyle {
       let style = NSMutableParagraphStyle()
       style.lineHeightMultiple = lineHeightMultiple
       return style
   }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let tabBarAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 10, weight: .medium) as Any,
                                 .kern: 0.16,
                                   .paragraphStyle: NSParagraphStyle(),
                                 .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    static let navigationTitleAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .semibold) as Any,
                                          .kern: -0.41,
                                            .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                          .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    static let saveBarButtonItemTitleAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .semibold) as Any,
                                                 .kern: -0.41,
                                                 .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                                 .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    static let cancellBarButtonItemTitleAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
                                                    .kern: -0.41,
                                                    .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                                    .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    static let habitLabelAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold) as Any,
                                     .kern: -0.08,
                                     .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
                                     .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    static let habitTextFieldTextlAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
                                              .kern: -0.41,
                                              .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                              .foregroundColor: UIColor.black]
    
    static let habitTextFieldPlaceHolderlAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
                                                     .kern: -0.41,
                                                     .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                                     .foregroundColor: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)]
    
    static let dateLabelAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold) as Any,
                                    .kern: -0.08,
                                    .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
                                    .foregroundColor: UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)]
    
    static let habitNameLabelCellAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
                                             .kern: -0.41,
                                             .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08)]
    
    static let habitDateLabelCellAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 12, weight: .regular) as Any,
                                             .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.12),
                                             .foregroundColor: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)]
    
    static let habitCountLabelCellAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .regular) as Any,
                                              .kern: -0.08,
                                              .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
                                              .foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)]
    
    static let deleteButtonAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
                                       .kern: -0.41,
                                       .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.1),
                                       .foregroundColor: UIColor(red: 1, green: 0.231, blue: 0.188, alpha: 1)]
    
    static let allDoneLabelAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold) as Any,
                                       .kern: -0.08,
                                       .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.16),
                                       .foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)]
    
    static let infoTitleLabelTextAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 20, weight: .semibold) as Any,
                                       .kern: 0.38,
                                       .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.01),
                                       .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    static let infoLabelTextAttributes = [NSAttributedString.Key
        .font: UIFont.systemFont(ofSize: 17, weight: .regular) as Any,
                                       .kern: -0.41,
                                       .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.08),
                                       .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    
}
