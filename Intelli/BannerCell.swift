//
//
// Intelli
// BannerCell.swift
// 
// Created by Alexander Kist on 04.08.2023.
//


import UIKit

class BannerCell: UICollectionViewCell {
    
    private enum Constants{
        static let iconSize: CGFloat = 52
        static let viewMargin: CGFloat = 10
        static let imageSize: CGFloat = 40
        static let titleLabelFontSize: CGFloat = 26
        static let descriptionLabelFontSize: CGFloat = 18
        static let priceLabelFontSize: CGFloat = 20
    }
    
    
    //MARK: - Properties
    
    let checkMarkImageView = CustomImageView(image: UIImage(systemName: "checkmark.circle.fill"), tintColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), contentMode: .scaleAspectFit, translatesAutoresizingMaskIntoConstraints: false)
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
    
    
    func configure(with dataResult: List){
        networkService.loadFrom(urlAddress: dataResult.icon.the52X52) { [weak self] image in
            DispatchQueue.main.async {
                self?.iconImageView.image = image
            }
        }
        titleLabel.text = dataResult.title
        descriptionLabel.text = dataResult.description
        priceLabel.text = dataResult.price
        checkMarkImageView.isHidden = !dataResult.isSelected
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    
    private let networkService = NetworkService()
    
    private var maxWidthConstraint: NSLayoutConstraint!
    
    private let iconImageView = CustomImageView(contentMode: .scaleAspectFit, translatesAutoresizingMaskIntoConstraints: false)
    
    private let titleLabel = CustomLabel(font: UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold), numberOfLines: 0, lineBreakMode: .byWordWrapping, textColor: .black, translatesAutoresizingMaskIntoConstraints: false)
    
    private let descriptionLabel = CustomLabel(font: UIFont.systemFont(ofSize: Constants.descriptionLabelFontSize), numberOfLines: 0, lineBreakMode: .byWordWrapping, textColor: .black, translatesAutoresizingMaskIntoConstraints: false)
    
    private let priceLabel = CustomLabel(font: UIFont.systemFont(ofSize: Constants.priceLabelFontSize, weight: .bold), numberOfLines: 0, lineBreakMode: .byWordWrapping, textColor: .black, translatesAutoresizingMaskIntoConstraints: false)
    
    private var stackView: UIStackView!
       
    //MARK: - Private Methods
    
    private func setupMaxWidthConstraint() {
        maxWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: 1000)
        maxWidthConstraint.isActive = false
    }
    
    private func setupUI(){
        contentView.backgroundColor = .systemGray6
        
        stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(checkMarkImageView)
        
        setupMaxWidthConstraint()
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.viewMargin),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewMargin),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewMargin),
        ])
        
        NSLayoutConstraint.activate(([
            checkMarkImageView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            checkMarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            checkMarkImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
        ]))
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.viewMargin)
        ])
    }
}



