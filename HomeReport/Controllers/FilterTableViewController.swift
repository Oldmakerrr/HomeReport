//
//  FilterTableViewController.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit
import CoreData

protocol FilterTableViewControllerDelegate: AnyObject {
    func didUpdateHomeList(filterBy: NSPredicate?, sortedBy: NSSortDescriptor?)
}

class FilterTableViewController: UITableViewController {
    
    //MARK: - Outlets
    
    //SORT BY
    @IBOutlet weak var sortByLocationCell: UITableViewCell!
    @IBOutlet weak var sortByPriceLowHighCell: UITableViewCell!
    @IBOutlet weak var sortByPriceHighLowCell: UITableViewCell!
    //FILTER BY HOME TYPE
    @IBOutlet weak var filterByCondoCell: UITableViewCell!
    @IBOutlet weak var filterBySingleFamilyCell: UITableViewCell!
    
    //MARK: - Proerties
    
    weak var delegate: FilterTableViewControllerDelegate?
    private var sortDescriptor: NSSortDescriptor?
    private var searchPredicate: NSPredicate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 2
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) else { return }
        switch selectedCell {
        case sortByLocationCell:
            setSortDescriptor(sortBy: "city", isAscending: true)
        case sortByPriceHighLowCell:
            setSortDescriptor(sortBy: "price", isAscending: true)
        case sortByPriceLowHighCell:
            setSortDescriptor(sortBy: "price", isAscending: false)
        case filterByCondoCell, filterBySingleFamilyCell:
            guard let text = selectedCell.textLabel?.text else { return }
            setFilterSearchPredicate(filterBy: text)
        default:
            break
        }
        selectedCell.accessoryType = .checkmark
        delegate?.didUpdateHomeList(filterBy: searchPredicate, sortedBy: sortDescriptor)
    }
    
    //MARK: - Private Methods

    private func setSortDescriptor(sortBy: String, isAscending: Bool) {
        sortDescriptor = NSSortDescriptor(key: sortBy, ascending: isAscending)
    }
    
    private func setFilterSearchPredicate(filterBy: String) {
        searchPredicate = NSPredicate(format: "homeType = '\(filterBy)'")
    }
}
