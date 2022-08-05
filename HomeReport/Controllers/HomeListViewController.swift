//
//  HomeListViewController.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit
import CoreData

class HomeListViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            guard let managedObjectContext = managedObjectContext else { return }
            home = Home(context: managedObjectContext)
        }
    }
    
    //MARK: - Private Properties
    
    private lazy var homes = [Home]()
    private var home: Home?
    
    private var isForSale = true {
        didSet { loadData() }
    }
    
    private var sortDescriptors = [NSSortDescriptor]()
    private var searchPredicate: NSPredicate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    //MARK: - Methods

    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
        isForSale = selectedValue == "For Sale" ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "History":
            guard let selectedIndexPath = tableView.indexPathForSelectedRow,
                  let moc = managedObjectContext else { return }
            let destination = segue.destination as? SaleHistoryViewController
            let selectedHome = homes[selectedIndexPath.row]
            destination?.prepareViewController(with: selectedHome, moc: moc)
        case "ToFilter":
            sortDescriptors = []
            searchPredicate = nil
            let destination = segue.destination as? FilterTableViewController
            destination?.delegate = self
        default:
            break
        }
    }
    
    //MARK: - Private Methods
    
    private func loadData() {
        guard let moc = managedObjectContext,
              let homes = home?.getHomesByStatus(isForSale: isForSale,
                                                 filterBy: searchPredicate,
                                                 sortBy: sortDescriptors,
                                                 moc: moc) else { return }
        self.homes = homes
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource

extension HomeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as! HomeListTableViewCell
        let home = homes[indexPath.row]
        cell.configureCell(home: home)
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension HomeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - FilterTableViewControllerDelegate

extension HomeListViewController: FilterTableViewControllerDelegate {
    
    func didUpdateHomeList(filterBy: NSPredicate?, sortedBy: NSSortDescriptor?) {
        if let filterBy = filterBy {
            searchPredicate = filterBy
        }
        if let sortedBy = sortedBy {
            sortDescriptors.append(sortedBy)
        }
    }
    
}
