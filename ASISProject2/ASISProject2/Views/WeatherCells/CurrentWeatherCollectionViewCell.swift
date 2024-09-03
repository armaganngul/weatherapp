//
//  CurrentWeatherCollectionViewCell.swift
//  ASISProject2
//
//  Created by Armağan Gül on 19.08.2024.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    private let locationManager = LocationManager()
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 120, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 27, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = ""
        return label
    }()
    
    private let lowestHighest: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let icon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let iconConditionStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 8 // Adjust spacing as needed
            return stackView
        }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(tempLabel)
        contentView.addSubview(iconConditionStackView)
        contentView.addSubview(cityLabel)
        contentView.addSubview(lowestHighest)

        iconConditionStackView.addArrangedSubview(icon)
        iconConditionStackView.addArrangedSubview(conditionLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with viewModel: CurrentWeatherCollectionViewCellViewModel){
        
        
        let location = viewModel.cityLocation
                
        locationManager.getCityName(from: location) { [weak self] cityName in
                    DispatchQueue.main.async {
                        if let cityName = cityName {
                            self?.cityLabel.text = cityName
                        } else {
                            self?.cityLabel.text = "City not found"
                        }
                    }
                }

        icon.image = UIImage(systemName: viewModel.iconname)
        
        switch viewModel.iconname{
        case "sun.max":
            icon.tintColor = UIColor(red: 253/255, green: 216/255, blue: 53/255, alpha: 1.0)
        case "cloud.rain":
            icon.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0)
        case "moon.stars":
            icon.tintColor = UIColor(red: 149/255, green: 117/255, blue: 205/255, alpha: 1.0)
        default:
            icon.tintColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
        }
        
        conditionLabel.text = viewModel.condition
        tempLabel.text = String(viewModel.temperature.prefix(2))+"°"
        
        
        lowestHighest.text = UserDefaults.standard.string(forKey: "dailyweather")

    }
    
    private func setupConstraints(){

        
        NSLayoutConstraint.activate([
            
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 23),
            tempLabel.heightAnchor.constraint(equalToConstant: 120),
            
            lowestHighest.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            lowestHighest.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lowestHighest.heightAnchor.constraint(equalToConstant: 40),


            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.centerYAnchor.constraint(equalTo: conditionLabel.centerYAnchor),

            iconConditionStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconConditionStackView.topAnchor.constraint(equalTo: lowestHighest.bottomAnchor, constant: 10),
            iconConditionStackView.heightAnchor.constraint(equalToConstant: 40),
            iconConditionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

                        
            cityLabel.bottomAnchor.constraint(equalTo: tempLabel.topAnchor),
            cityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        conditionLabel.text = nil
        tempLabel.text = nil
        icon.image = nil
    }
}
