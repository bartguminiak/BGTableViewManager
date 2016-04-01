//  Created by Bartlomiej Guminiak on 15/10/15.
//  Copyright © 2015 Bartłomiej Guminiak. All rights reserved.

import UIKit

class TableViewSection {
    
    var header: TableViewHeaderFooterManageable?
    var cellRows: [TableViewCellIRowManageable]
    var footer: TableViewHeaderFooterManageable?
    
    init(header: TableViewHeaderFooterManageable?, cellRows: [TableViewCellIRowManageable], footer: TableViewHeaderFooterManageable?) {
        self.header = header
        self.cellRows = cellRows
        self.footer = footer
    }
    
    convenience init() {
        self.init(header: nil, cellRows: [], footer: nil)
    }
    
    convenience init(cellRows: [TableViewCellIRowManageable]) {
        self.init(header: nil, cellRows: cellRows, footer: nil)
    }

    convenience init(header: TableViewHeaderFooterManageable, cellRows: [TableViewCellIRowManageable]) {
        self.init(header: header, cellRows: cellRows, footer: nil)
    }
}
