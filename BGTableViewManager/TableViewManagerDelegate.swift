//  Created by Bartlomiej Guminiak on 15/10/15.
//  Copyright © 2015 Bartłomiej Guminiak. All rights reserved.

import UIKit

@objc public protocol TableViewManagerDelegate {
    
    optional func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    optional func scrollViewDidScroll(scrollView: UIScrollView)
    
}
