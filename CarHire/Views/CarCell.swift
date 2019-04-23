//
//  CarCell.swift
//  CarHire
//
//  Created by SS on 4/23/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit

class CarCell : UITableViewCell {
    
    let defaultOffset : CGFloat = 2
    
    let carImageView : CarImageView = {
        let imageView = CarImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel = UILabel.Factory.makeForTitle()
    
    let fuelLabel = UILabel.Factory.makeForSubtitle()
    
    let transmissionLabel = UILabel.Factory.makeForSubtitle()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        stackView.addArrangedSubview(fuelLabel)
        stackView.addArrangedSubview(transmissionLabel)
        
        addSubview(titleLabel)
        addSubview(carImageView)
        addSubview(stackView)
        
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            carImageView.topAnchor.constraint(equalTo: topAnchor, constant: defaultOffset),
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultOffset),
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultOffset),
            carImageView.widthAnchor.constraint(equalToConstant: 70),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: defaultOffset),
            titleLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultOffset),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
            
            ])
    }
    
    func configureView(for car: Car){
        titleLabel.text = getTitle(for: car)
        fuelLabel.text = "Fuel type: \(car.fuelType)"
        transmissionLabel.text = "Transmission: \(car.transmission)"
        carImageView.loadAndResizeImage(urlString: car.carImageUrl)
    }
    
    private func getTitle(for car: Car) -> String {
        let make = car.make
        let modelName = car.modelName
        let cleanliness = car.innerCleanliness
        return "\(make) \(modelName) (\(cleanliness))"
    }
    
}
