//  Created by Bartlomiej Guminiak on 15/10/15.
//  Copyright © 2015 Bartłomiej Guminiak. All rights reserved.

import UIKit

public protocol TableViewHeaderFooterManageable {
    
    var viewClass: AnyClass { get }
    var viewHeight: CGFloat { get }
    var viewEstimatedHeight: CGFloat { get }
    func configureView(view: AnyObject)
}
