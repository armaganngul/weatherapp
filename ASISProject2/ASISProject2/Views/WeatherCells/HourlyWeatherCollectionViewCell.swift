//
//  HourlyWeatherCollectionViewCell.swift
//  ASISProject2
//
//  Created by Armağan Gül on 19.08.2024.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "HourlyWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let timelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let icon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(timelabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)
        contentView.backgroundColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 0.1)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraint(){
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            timelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timelabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            timelabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            timelabel.heightAnchor.constraint(equalToConstant: 30),
            
            icon.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 20),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            icon.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            
            tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tempLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    public func configure(with viewModel: HourlyWeatherCollectionViewCellViewModel){
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
        
        
        timelabel.text = viewModel.hour
        tempLabel.text = String(viewModel.temperature.prefix(2))+"°"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timelabel.text = nil
        tempLabel.text = nil
        icon.image = nil
    }
}
