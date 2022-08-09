//
//  SummaryTableViewController.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit
import CoreData

class SummaryTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var totalSalesDollarLabel: UILabel!
    @IBOutlet weak var numCondoSoldLabel: UILabel!
    @IBOutlet weak var numSFSoldLabel: UILabel!
    @IBOutlet weak var minPriceHomeLabel: UILabel!
    @IBOutlet weak var maxPriceHomeLabel: UILabel!
    @IBOutlet weak var avgPriceCondoLabel: UILabel!
    @IBOutlet weak var avgPriceSFLabel: UINavigationItem!
    
    //MARK: - properties
    
    var home: Home?
    
    var managedObjectContext: NSManagedObjectContext! {
        didSet { home = Home(context: managedObjectContext) }
    }
    
    private var soldPredicate: NSPredicate!
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextToLabel()
    }
    
    private func setTextToLabel() {
        guard let home = home else { return }
        totalSalesDollarLabel.text = home.totalSoldHomesValue(moc: managedObjectContext).currencyFormatter
        numCondoSoldLabel.text = String(home.totalSoldCondo(moc: managedObjectContext))
        numSFSoldLabel.text = String(home.totalSoldSingleFamilyHome(moc: managedObjectContext))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        switch section {
        case 0:
            rowCount = 3
        case 1, 2:
            rowCount = 2
        default:
            break
        }
        return rowCount
    }

}
