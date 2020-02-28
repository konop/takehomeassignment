//  Copyright © 2018 Hootsuite. All rights reserved.

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var imageAPI: InterviewAPI?
    var myImageSet: ImageSet?
    var currentTag: String? = "Dog"
    var currentFilteredImages: [TaggedImage]?
    
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBAction private func refreshButtonTapped(_ sender: UIBarButtonItem){
    }
    
    override func viewDidLoad() {
        imageAPI = InterviewAPI()
        getAPIData()
    }
    
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
        if let tag = currentTag {
            currentFilteredImages = myImageSet?.sources.filter{ $0.tags.contains(tag.uppercased())}
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.tagLabel.text = tag
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentFilteredImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        // Configure the cell
        if let taggedImage = currentFilteredImages?[indexPath.row] {
            cell.setTaggedImage(thisImage: taggedImage)
        }
        return cell
    }
}
