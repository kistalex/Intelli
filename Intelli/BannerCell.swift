//
//
// Intelli
// BannerCell.swift
// 
// Created by Alexander Kist on 04.08.2023.
//


import UIKit

class BannerCell: UICollectionViewCell {
    
    private var maxWidthConstraint: NSLayoutConstraint!
    
    
    private func setupMaxWidthConstraint() {
        maxWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: 1000)
        maxWidthConstraint.isActive = false
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
    
    let bannerIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bannerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bannerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bannerPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dataResult: List){
        bannerIconImageView.loadFrom(URLAddress: dataResult.icon.the52X52)
        bannerTitleLabel.text = dataResult.title
        bannerDescriptionLabel.text = dataResult.description
        bannerPriceLabel.text = dataResult.price
    }
    
    
    private func setupUI(){
        contentView.backgroundColor = .systemGray6
        
        stackView = UIStackView(arrangedSubviews: [bannerTitleLabel, bannerDescriptionLabel, bannerPriceLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        contentView.addSubview(bannerIconImageView)
        contentView.addSubview(checkMarkImageView)
        
        setupMaxWidthConstraint()
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            bannerIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bannerIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bannerIconImageView.widthAnchor.constraint(equalToConstant: 52),
            bannerIconImageView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: bannerIconImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate(([
            checkMarkImageView.centerYAnchor.constraint(equalTo: bannerIconImageView.centerYAnchor),
            checkMarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: 40),
            checkMarkImageView.heightAnchor.constraint(equalToConstant: 40),
        ]))
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ])
    }
}
