//  Created by Bartlomiej Guminiak on 15/10/15.
//  Copyright © 2015 Bartłomiej Guminiak. All rights reserved.

import UIKit

public class TableViewSection {
    
    var header: TableViewHeaderFooterManageable?
    var cellRows: [TableViewCellRowManageable]
    var footer: TableViewHeaderFooterManageable?
    
    public init(header: TableViewHeaderFooterManageable?, cellRows: [TableViewCellRowManageable], footer: TableViewHeaderFooterManageable?) {
        self.header = header
        self.cellRows = cellRows
        self.footer = footer
    }
    
    public convenience init() {
        self.init(header: nil, cellRows: [], footer: nil)
    }
    
    public convenience init(cellRows: [TableViewCellRowManageable]) {
        self.init(header: nil, cellRows: cellRows, footer: nil)
    }

    public convenience init(header: TableViewHeaderFooterManageable, cellRows: [TableViewCellRowManageable]) {
        self.init(header: header, cellRows: cellRows, footer: nil)
    }
}
