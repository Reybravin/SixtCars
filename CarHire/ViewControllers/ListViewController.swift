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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
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
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
}
