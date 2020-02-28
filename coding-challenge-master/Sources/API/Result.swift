//  Copyright © 2018 Hootsuite. All rights reserved.

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
