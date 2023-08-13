//
//
// Intelli
// CustomLabel.swift
// 
// Created by Alexander Kist on 09.08.2023.
//

import UIKit

class CustomLabel: UILabel {
    var customFont: UIFont
    var customNumberOfLines: Int
    var customLineBreakMode: NSLineBreakMode
    var customTextColor: UIColor
    var customTranslatesAutoresizingMaskIntoConstraints: Bool
    
    init(font: UIFont, numberOfLines: Int, lineBreakMode: NSLineBreakMode, textColor: UIColor, translatesAutoresizingMaskIntoConstraints: Bool) {
        self.customFont = font
        self.customNumberOfLines = numberOfLines
        self.customLineBreakMode = lineBreakMode
        self.customTextColor = textColor
        self.customTranslatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        
        super.init(frame: .zero)
        
        configureLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        font = customFont
        numberOfLines = customNumberOfLines
        lineBreakMode = customLineBreakMode
        textColor = customTextColor
        translatesAutoresizingMaskIntoConstraints = customTranslatesAutoresizingMaskIntoConstraints
    }
}
