//  Copyright © 2018 Hootsuite. All rights reserved.

import Foundation
import UIKit

/// Representing an `ImageRequests` object
struct ImageRequests: Requests {
    /// Image's URL
    var url: URL
}

/// Representing an `ImageStore` object
/// `ImageStore` is responsibile for downloading an image
final class ImageStore {

    /// Representing an `ImageStore` Signleton
    static let shared = ImageStore()

    private let session: URLSession

    private let operationQueue: OperationQueue = {
        let operation = OperationQueue()
        operation.maxConcurrentOperationCount = 1
        return operation
    }()

    private init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: self.operationQueue)
    }

    deinit {
        session.invalidateAndCancel()
    }

    /// Get image
    ///
    /// parameter: URL for image's destination
    /// parameter: `Service` for networking layer
    /// completion: `Result` of UIImage or error
    func getImage(url: URL, service: Service = NetworkService(), completion: @escaping (Result<UIImage>) -> Void) {
        service.get(request: ImageRequests(url: url)) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
