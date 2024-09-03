//
//  DailyWeatherCollectionViewCell.swift
//  ASISProject2
//
//  Created by Armağan Gül on 19.08.2024.
//

import UIKit
import MapKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "DailyWeatherCollectionViewCell"
        
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let timelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
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
    
    public func configure(with viewModel: DailyWeatherCollectionViewCellViewModel){
        icon.image = UIImage(systemName: viewModel.iconname)

        switch viewModel.iconname{
        case "sun.max":
            icon.tintColor = UIColor(red: 253/255, green: 216/255, blue: 53/255, alpha: 1.0)
        case "cloud.rain":
            icon.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0)
        default:
            icon.tintColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)

        }
        timelabel.text = viewModel.date
        tempLabel.text = viewModel.temperature
        
    }
    
    private func addConstraint(){
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        

        NSLayoutConstraint.activate([
            timelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timelabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
            timelabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            timelabel.heightAnchor.constraint(equalToConstant: 20),
            
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            icon.heightAnchor.constraint(equalToConstant: 50),
            icon.widthAnchor.constraint(equalToConstant: 50),

            
            tempLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
            tempLabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 10),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timelabel.text = nil
        tempLabel.text = nil
        icon.image = nil
    }
    
}
