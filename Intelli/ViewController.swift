//
//
// Intelli
// ViewController.swift
// 
// Created by Alexander Kist on 31.07.2023.
//


import UIKit

class ViewController: UIViewController {
    
    
    
    private var headerLabel = UILabel()
    private var bannersCollectionView : UICollectionView!
    private var selectedIndexPaths = Set<IndexPath>()
    private var sizingCell = BannerCell()
    
    
    var bannerData: BannerData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchBannerData()
        setupHeaderLabel()
        setupBannersCollectionView()
        
    }
    
    private func setupHeaderLabel() {
        
        headerLabel.text = bannerData?.result.title
        headerLabel.numberOfLines = 2
        headerLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
    }
    
    private func fetchBannerData(){
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                bannerData = try decoder.decode(BannerData.self, from: jsonData)
            } catch {
                print("Ошибка при декодировании JSON: \(error)")
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
            bannersCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            bannersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bannersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bannersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
        bannersCollectionView.reloadData()
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 20, left: 10, bottom: 20, right: 10)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.remove(indexPath)
        } else {
            selectedIndexPaths.insert(indexPath)
        }
        bannersCollectionView.reloadItems(at: [indexPath])
    }
}
