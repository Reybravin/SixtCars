//
//  ListViewController.swift
//  CarHire
//
//  Created by SS on 4/23/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ListViewController: UITableViewController {

    private var cars : [Car] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateCarAnnotations()
    }

    private func setupView(){
        tableView.register(CarCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func updateCarAnnotations(){
        
        SixtAPI.fetchCars { [weak self] (result) in
            switch result {
            case .success(let cars):
                guard let strongSelf = self else { return }
                strongSelf.cars = cars
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CarCell else { return UITableViewCell() }
        let car = cars[indexPath.row]
        cell.configureView(for: car)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}



class CarCell : UITableViewCell {
    
    var car : Car?
    
    let carImageView : CarImageView = {
        let imageView = CarImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel : UILabel = {
        return UILabel.Factory.makeForTitle()
    }()
    
    let fuelLabel : UILabel = {
        return UILabel.Factory.makeForSubtitle()
    }()
    
    let transmissionLabel : UILabel = {
        return UILabel.Factory.makeForSubtitle()
    }()
    
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
            
            carImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            carImageView.widthAnchor.constraint(equalToConstant: 70),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
            
            ])
    }
    
    func configureView(for car: Car){
        self.car = car
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

///////
class CarImageView : UIImageView {
    
    var imageUrlString : String?
    
    func loadAndResizeImage(urlString: String) {
        
        imageUrlString = urlString
        
        self.image = nil
        
        //1. Try to get the image from cache
        let suffix = "\(Images.defaultCarImageSize.width)" + "x" + "\(Images.defaultCarImageSize.height)"
        
        let key = urlString + suffix
        
        if let imageFromCache = imageCache.object(forKey: key as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        //2. Download if not found in cache
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let imageToCache = UIImage(data: data) {
                        let resizedImage = imageToCache.resizeImage(targetSize: Images.defaultCarImageSize)
                        if self.imageUrlString == urlString {
                            self.image = resizedImage
                        }
                        imageCache.setObject(resizedImage, forKey: key as AnyObject)
                        return
                    }
                }
                self.image = Images.defaultCarImage?.resizeImage(targetSize: Images.defaultCarImageSize)
            }
        }
        task.resume()
    }
    
}
