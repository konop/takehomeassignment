//  Copyright © 2018 Hootsuite. All rights reserved.

import Foundation

/// Representing an API requests object
enum APIRequests: String, Requests {
    /// Request's URL in string
    case request = "https://gist.githubusercontent.com/steve-sun-hs/8234979f673e62b28c47a8b57b5dc2f2/raw/b71bd881ecc5097cf41ab7dcbcbb875eec7bfda4/Questions.json"

    /// Request's URL
    var url: URL {
        return URL(string: rawValue)!
    }
}

/// Representing an Interview API object
final class InterviewAPI {

    /// `InterviewAPI` service
    let service: Service

    /// Initialize an `InterviewAPI` object
    init(service: Service = NetworkService()) {
        self.service = service
    }

    /// Retrieve `ImageSet` from `Requests` object
    ///
    /// parameter: Takes a `Requests` object to retrieve its request
    /// completion: `Result` of `ImageSet` or errors
    func getImageSet(request: Requests = APIRequests.request, completion: @escaping (Result<ImageSet>) -> Void) {
        service.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let imageSet: ImageSet = try JSONDecoder().decode(ImageSet.self, from: data)
                    guard !imageSet.tags.isEmpty && !imageSet.sources.isEmpty else {
                        completion(.failure(APIError.noAvailableImageSet))
                        return
                    }
                    completion(.success(imageSet))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
