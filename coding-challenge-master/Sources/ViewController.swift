//  Copyright © 2018 Hootsuite. All rights reserved.

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var myViewModel: CurrentImagesViewModel?
    
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBAction private func refreshButtonTapped(_ sender: UIBarButtonItem){
        myViewModel?.getAPIData()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(setModelView(notification:)), name: .imageViewModel, object: nil)
        myViewModel = CurrentImagesViewModel()
        myViewModel?.getAPIData()
    }
    
    @objc func setModelView(notification: NSNotification) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.tagLabel.text = self.myViewModel?.currentTag
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myViewModel?.currentFilteredImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        // Configure the cell
        if let taggedImage = myViewModel?.currentFilteredImages?[indexPath.row] {
            cell.setTaggedImage(thisImage: taggedImage)
        }
        return cell
    }
}

//Required for notifications.  Using notifications instead of reactiveswift because of time restrictions but functions in a similar way
extension Notification.Name {
    static let imageViewModel = Notification.Name("imageViewModel")
}
