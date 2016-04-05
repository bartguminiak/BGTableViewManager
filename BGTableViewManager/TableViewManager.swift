//  Created by Bartlomiej Guminiak on 15/10/15.
//  Copyright © 2015 Bartłomiej Guminiak. All rights reserved.

import UIKit

public class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    public private(set) var sections = [TableViewSection]()
    public weak var delegate: TableViewManagerDelegate?
    
    public override init() {
        super.init()
    }
    
    // MARK: Delegates
    
    public func attachDelegates(inTableView tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Adding
    
    public func addSection(section: TableViewSection, inTableView tableView: UITableView, animation: UITableViewRowAnimation) {
        registerSection(section, inTableView: tableView)
        
        tableView.beginUpdates()
        tableView.insertSections(
            NSIndexSet(index: sections.count),
            withRowAnimation: animation
        )
        sections.append(section)
        tableView.endUpdates()
    }
    
    public func addSection(section: TableViewSection, inTableView tableView: UITableView) {
        registerSection(section, inTableView: tableView)
        
        sections.append(section)
        tableView.reloadData()
    }
    
    public func addSections(sections newSections: [TableViewSection], inTableView tableView: UITableView, animation: UITableViewRowAnimation) {
        registerSections(newSections, inTableView: tableView)
        
        tableView.beginUpdates()
        tableView.insertSections(
            NSIndexSet(indexesInRange: NSMakeRange(sections.count, newSections.count)),
            withRowAnimation: animation
        )
        sections.appendContentsOf(newSections)
        tableView.endUpdates()
    }
    
    public func addSections(sections newSections: [TableViewSection], inTableView tableView: UITableView) {
        registerSections(newSections, inTableView: tableView)
        
        sections.appendContentsOf(newSections)
        tableView.reloadData()
    }
    
    // MARK: Removing
    
    public func removeSection(section: TableViewSection, inTableView tableView: UITableView, animation: UITableViewRowAnimation) {
        if let idx = sections.indexOf( { $0 === section } ) {
            tableView.beginUpdates()
            tableView.deleteSections(
                NSIndexSet(index: idx),
                withRowAnimation: animation
            )
            sections.removeAtIndex(idx)
            tableView.endUpdates()
        }
    }
    
    public func removeSection(section: TableViewSection, inTableView tableView: UITableView) {
        if let idx = sections.indexOf( { $0 === section } ) {
            sections.removeAtIndex(idx)
            tableView.reloadData()
        }
    }
    
    // MARK: Updating
    
    public func updateSection(section: TableViewSection, withSection newSection: TableViewSection, inTableView tableView: UITableView, animation: UITableViewRowAnimation) {
        if let idx = sections.indexOf( { $0 === section } ) {
            tableView.beginUpdates()
            tableView.deleteSections(
                NSIndexSet(index: idx),
                withRowAnimation: animation
            )
            tableView.insertSections(
                NSIndexSet(index: sections.count - 1),
                withRowAnimation: animation
            )
            sections[idx] = newSection
            tableView.endUpdates()
        }
    }
    
    public func updateSections(sections newSections: [TableViewSection], inTableView tableView: UITableView, animation: UITableViewRowAnimation) {
        registerSections(newSections, inTableView: tableView)
        
        tableView.beginUpdates()
        tableView.deleteSections(
            NSIndexSet(indexesInRange: NSMakeRange(0, sections.count)),
            withRowAnimation: animation
        )
        tableView.insertSections(
            NSIndexSet(indexesInRange: NSMakeRange(0, newSections.count)),
            withRowAnimation: animation
        )
        sections.removeAll()
        sections.appendContentsOf(newSections)
        tableView.endUpdates()
    }
    
    public func updateSections(sections newSections: [TableViewSection], inTableView tableView: UITableView) {
        registerSections(newSections, inTableView: tableView)
        
        sections.removeAll()
        sections.appendContentsOf(newSections)
        tableView.reloadData()
    }
    
    // MARK: Clearing
    
    public func clearAllSections(inTableView tableView: UITableView) {
        sections.removeAll()
        tableView.reloadData()
    }
    
    // MARK: Single row operations
    
    public func replaceCellRow(cellRow: TableViewCellRowManageable, withNewCellRow newCellRow: TableViewCellRowManageable, inTableView tableView: UITableView) {
        for section in sections {
            if let cellRowIdx = section.cellRows.indexOf( {$0 === cellRow } ) {
                section.cellRows[cellRowIdx] = newCellRow
                registerCellRow(newCellRow, inTableView: tableView)
                reloadSection(section, inTableView: tableView)
            }
        }
    }
    
    public func removeCellRow(cellRow: TableViewCellRowManageable, inTableView tableView: UITableView, animation: UITableViewRowAnimation) {
        for section in sections {
            if let cellRowIdx = section.cellRows.indexOf( {$0 === cellRow } ), sectionIdx = sections.indexOf({ $0 === section }) {
                tableView.beginUpdates()
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: cellRowIdx, inSection: sectionIdx)], withRowAnimation: animation)
                section.cellRows.removeAtIndex(cellRowIdx)
                tableView.endUpdates()
            }
        }
    }
    
    public func removeCellRow(cellRow: TableViewCellRowManageable, inTableView tableView: UITableView) {
        for section in sections {
            if let cellRowIdx = section.cellRows.indexOf( {$0 === cellRow } ) {
                section.cellRows.removeAtIndex(cellRowIdx)
                reloadSection(section, inTableView: tableView)
            }
        }
    }
    
    // MARK: Reloading
    
    public func reloadSection(section: TableViewSection, inTableView tableView: UITableView) {
        let indexSet = NSIndexSet(index: sections.indexOf( { $0 === section } )!)
        tableView.reloadSections(indexSet, withRowAnimation: .None)
    }
    
    public func reloadCellRow(cellRow: TableViewCellRowManageable, inTableView tableView: UITableView) {
        for section in sections {
            if let cellRowIdx = section.cellRows.indexOf( {$0 === cellRow } ), sectionIdx = sections.indexOf({ $0 === section }) {
                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: cellRowIdx, inSection: sectionIdx)], withRowAnimation: .None)
            }
        }
    }
    
}

public extension TableViewManager {
    
    private func registerHeaderFooter(headerFooter: TableViewHeaderFooterManageable, inTableView tableView: UITableView) {
        tableView.registerClass(headerFooter.viewClass, forHeaderFooterViewReuseIdentifier: rowIdFromClass(headerFooter.viewClass))
    }
    
    private func registerCellRow(row: TableViewCellRowManageable, inTableView tableView: UITableView) {
        tableView.registerClass(row.cellClass, forCellReuseIdentifier: rowIdFromClass(row.cellClass))
    }
    
    private func registerSection(section: TableViewSection, inTableView tableView: UITableView) {
        if let header = section.header {
            registerHeaderFooter(header, inTableView: tableView)
        }
        let cellRows = section.cellRows
        _ = cellRows.map( { [weak self] (cellRow: TableViewCellRowManageable) -> () in
            self?.registerCellRow(cellRow, inTableView: tableView) }
        )
        
        if let footer = section.footer {
            registerHeaderFooter(footer, inTableView: tableView)
        }
    }
    
    private func registerSections(sections: [TableViewSection], inTableView tableView: UITableView) {
        _ = sections.map( { [unowned self] (section: TableViewSection) -> () in
            self.registerSection(section, inTableView: tableView) }
        )
    }
    
    private func rowIdFromClass(className: AnyClass) -> String {
        return "\(className)Id"
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellRows.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellRow = sections[indexPath.section].cellRows[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(rowIdFromClass(cellRow.cellClass), forIndexPath: indexPath)
        cellRow.configureCell(cell)
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = sections[section].header!
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(rowIdFromClass(header.viewClass))!
        header.configureView(view)
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellRow = sections[indexPath.section].cellRows[indexPath.row]
        return cellRow.cellHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellRow = sections[indexPath.section].cellRows[indexPath.row]
        return cellRow.cellEstimatedHeight
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let header = sections[section].header!
        return header.viewHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header?.viewEstimatedHeight ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellRow = sections[indexPath.section].cellRows[indexPath.row]
        cellRow.cellSelected?()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellRow = sections[indexPath.section].cellRows[indexPath.row]
        cellRow.willDisplayCell?()
    }
    
    // MARK:UIScrollViewDelegate
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
    }
    
}
