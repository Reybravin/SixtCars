//
//  File.swift
//  CarHire
//
//  Created by SS on 4/22/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import MapKit


class CarAnnotationView: MKAnnotationView {

    static let ReuseID = "carAnnotation"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "car"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
        setupGlyphImage()
    }

    private func setupGlyphImage(){
        if let annotation = annotation as? Car {
            loadAndResizeImage(urlString: annotation.carImageUrl)
        } else {
            setDefaultImage()
        }
    }
    
    private func setDefaultImage(){
        image = Images.defaultCarImage
    }
    
}
