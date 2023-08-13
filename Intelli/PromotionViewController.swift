//
//
// Intelli
// ViewController.swift
// 
// Created by Alexander Kist on 31.07.2023.
//


import UIKit

final class PromotionViewController: UIViewController {
    
    
    
    //MARK: - Private properties
    
    private enum Constants{
        static let viewMargin: CGFloat = 20
        static let headerLabelFontSize: CGFloat = 32
       
    }
    
    private let headerLabel = UILabel()
    private var selectedIndexPaths = Set<IndexPath>()
    private let dataService = DataService()
    
    private var bannersCollectionView : UICollectionView!
    private var bannerData: BannerData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchBannerData(forFileName: "data")
        setupHeaderLabel()
        setupBannersCollectionView()
        
    }
    
    private func setupHeaderLabel() {
        
        headerLabel.text = bannerData?.result.title
        headerLabel.numberOfLines = 2
        headerLabel.font = UIFont.systemFont(ofSize: Constants.headerLabelFontSize, weight: .bold)
        
        
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.viewMargin),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.viewMargin),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.viewMargin),
            
        ])
        
    }
    
    private func fetchBannerData(forFileName fileName: String){
        dataService.fetchBannerData(fromFileNamed: fileName) { [weak self] result  in
            switch result{
            case .success(let bannerData):
                self?.bannerData = bannerData
            case .failure(let error):
                print("Ошибка чтения json: \(error)")
            }
        }
        
    }
    
    private func setupBannersCollectionView(){
        
        bannersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        bannersCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: "\(BannerCell.self)")
        
        bannersCollectionView.backgroundColor = .white
        bannersCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(bannersCollectionView)
        bannersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannersCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Constants.viewMargin),
            bannersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bannersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bannersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 20, left: 10, bottom: 20, right: 10)
        return layout
    }
}

extension PromotionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerData?.result.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BannerCell.self)", for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        
        if let dataResult = bannerData?.result.list[indexPath.item]{
            cell.configure(with: dataResult)
        }
        let isSelected = selectedIndexPaths.contains(indexPath)
        cell.checkMarkImageView.isHidden = !isSelected
       
        
        cell.maxWidth = bannersCollectionView.bounds.width - 20
        
        return cell
    }
}

extension PromotionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.remove(indexPath)
        } else {
            selectedIndexPaths.insert(indexPath)
        }

//        if let dataResult = bannerData?.result.list[indexPath.item]{
//            dataResult.isSelected.toggle()
//        }
        
        bannersCollectionView.reloadItems(at: [indexPath])
    }
}
