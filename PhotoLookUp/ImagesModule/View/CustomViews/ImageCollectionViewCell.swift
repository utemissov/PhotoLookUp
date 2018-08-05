//
//  ImageCollectionViewCell.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 05.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    func configure(iconUrl: URL) {
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(with: iconUrl)
    }
}
