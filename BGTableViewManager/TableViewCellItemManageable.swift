//  Created by Bartlomiej Guminiak on 15/10/15.
//  Copyright © 2015 Bartłomiej Guminiak. All rights reserved.

import UIKit

typealias SelectionAction = () -> (Void)
typealias WillDisplayCellAction = () -> (Void)

@objc protocol TableViewCellIRowManageable: NSObjectProtocol {
    
    var cellClass: AnyClass { get }
    var cellHeight: CGFloat { get }
    var cellEstimatedHeight: CGFloat { get }
    func configureCell(cell: AnyObject)
    
    optional func cellSelected()
    optional func willDisplayCell()
}
