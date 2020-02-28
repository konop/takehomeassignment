//  Copyright © 2018 Hootsuite. All rights reserved.

import Foundation

/// A collection of tags and tagged images.
struct ImageSet: Codable {
    /// Available tags
    var tags: [String]
    /// List of tagged images
    var sources: [TaggedImage]
}

/// An image with a list of associated tags
struct TaggedImage: Codable {
    /// List of tags relevant to this image.
    var tags: [String]
    /// TaggedImage's url
    var url: URL
}
