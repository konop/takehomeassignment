//
//  ImageSetViewModel.swift
//  CodeChallenge
//
//  Created by Mark Pettersson on 2020-02-28.
//  Copyright © 2020 Hootsuite. All rights reserved.
//

import Foundation

class CurrentImagesViewModel {
    var imageAPI: InterviewAPI?
    var myImageSet: ImageSet?
    var currentTag: String?
    var currentFilteredImages: [TaggedImage]?
    
    func getAPIData() {
        imageAPI?.getImageSet(completion: {[unowned self] result in
            switch result {
            case .success(let imageSet):
                self.myImageSet = imageSet
                self.filterAPIData()
            case .failure( _): break
            }
        })
    }
    
    func filterAPIData() {
        pickTag()
        if let tag = currentTag {
            currentFilteredImages = myImageSet?.sources.filter{ $0.tags.contains(tag.uppercased())}
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//                self.tagLabel.text = tag
//            }
        }
    }
    
    func pickTag() {
        let listTags = myImageSet?.tags.filter { $0 != currentTag }
        let newTag = listTags?.randomElement() ?? ""
        currentTag = newTag
    }
    
}
