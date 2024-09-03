//
//  CurrentWeatherView.swift
//  ASISProject2
//
//  Created by Armağan Gül on 18.08.2024.
//

import UIKit

class CurrentWeatherView: UIView {
    
    private var viewModel: [WeatherViewModel] = []
    lazy var layout = UICollectionViewCompositionalLayout {sectionIndex, _ in
               return self.layout(for: sectionIndex)
           }
    public lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = .init(width: 150, height: 150)
            let collectionview = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
            collectionview.translatesAutoresizingMaskIntoConstraints = false
            collectionview.showsHorizontalScrollIndicator = false
            collectionview.showsVerticalScrollIndicator = false
            collectionview.dataSource = self
            collectionview.delegate = self
            collectionview.backgroundColor = .clear
            collectionview.register(CurrentWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
            collectionview.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier)
            collectionview.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier)
            collectionview.isScrollEnabled = true
            return collectionview
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    public func setUpView(){
        self.addSubview(collectionView)
        collectionView.overrideUserInterfaceStyle = .dark
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),])
    }
    public func configure(with viewModel: [WeatherViewModel]){
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
            let section = CurrentWeatherSection.allCases[sectionIndex]
            
            switch section {
            case .current:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                
                return NSCollectionLayoutSection(group: group)
                
            case .hourly:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)), subitems: [item])
                group.contentInsets = .init(top: 1, leading: 2, bottom: 1, trailing: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

                return section
                
            case .daily:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(77)), subitems: [item])
                
                group.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            }
    }
}

extension CurrentWeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel[section] {
        case .current:
            return 1
        case .hourly(let viewModels):
            return viewModels.count
        case .daily(let viewModels):
            print(viewModels.count)
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel[indexPath.section] {
        case .current(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier, for: indexPath) as?  CurrentWeatherCollectionViewCell else {
            fatalError()
        }
            cell.configure(with: viewModel)
            return cell
            
        case .hourly(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as?  HourlyWeatherCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
        case .daily(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as?  DailyWeatherCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}
