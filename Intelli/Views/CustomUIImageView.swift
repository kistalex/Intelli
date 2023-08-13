//
//
// Intelli
// CustomUIImageView.swift
// 
// Created by Alexander Kist on 09.08.2023.
//


import UIKit

class CustomImageView: UIImageView {
    var customImage: UIImage?
    var customTintColor: UIColor?
    var customContentMode: UIView.ContentMode
    var customTranslatesAutoresizingMaskIntoConstraints: Bool
    
    init(image: UIImage? = nil, tintColor: UIColor? = nil, contentMode: UIView.ContentMode, translatesAutoresizingMaskIntoConstraints: Bool) {
        self.customImage = image
        self.customTintColor = tintColor
        self.customContentMode = contentMode
        self.customTranslatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        
        super.init(frame: .zero)
        
        configureImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        self.image = customImage
        self.tintColor = customTintColor
        self.contentMode = customContentMode
        self.translatesAutoresizingMaskIntoConstraints = customTranslatesAutoresizingMaskIntoConstraints
    }
}
