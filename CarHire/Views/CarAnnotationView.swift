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
    
    private var imageView: CarImageView!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "car"
        
        self.frame = CGRect(x: 0, y: 0, width: Images.defaultCarImageSize.width, height: Images.defaultCarImageSize.height)
        self.imageView = CarImageView(frame: self.frame)
        self.addSubview(self.imageView)
        
    }
    
    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
        setupImage()
        //setupGlyphImage()
    }

//    private func setupGlyphImage(){
//        if let annotation = annotation as? Car {
//            loadAndResizeImage(urlString: annotation.carImageUrl)
//        } else {
//            setDefaultImage()
//        }
//    }
    
    private func setupImage(){
        if let annotation = annotation as? Car {
            imageView.loadAndResizeImage(urlString: annotation.carImageUrl)
            //loadAndResizeImage(urlString: annotation.carImageUrl)
        } else {
            setDefaultImage()
        }
    }

    
    private func setDefaultImage(){
        image = Images.defaultCarImage
    }
    
    
    
}
