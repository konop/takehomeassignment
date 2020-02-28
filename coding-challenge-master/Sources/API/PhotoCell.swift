//
//  PhotoCell.swift
//  CodeChallenge
//
//  Created by Mark Pettersson on 2020-02-28.
//  Copyright © 2020 Hootsuite. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    static let reuseIdentifier = "photoCell"

    func setTaggedImage(thisImage: TaggedImage) {
        let myURL = thisImage.url
        ImageStore.shared.getImage(url: myURL, completion: {result in
            switch result {
            case .success(let image):
                self.photoImageView.image = image
            case .failure( _): break
            }
        })
    }
}
