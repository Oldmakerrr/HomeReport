//
//  SaleHistoryViewController.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit
import CoreData

class SaleHistoryViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    private lazy var soldHistory = [SaleHistory]()
    private var home: Home?
    private var managedObjectContext: NSManagedObjectContext? {
        didSet {
            guard let moc = managedObjectContext else { return }
            saleHistory = SaleHistory(context: moc)
        }
    }
    
    private var saleHistory: SaleHistory?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSoldHistory()
        setupImage()
        tableView.dataSource = self
    }
    
    func prepareViewController(with home: Home, moc: NSManagedObjectContext) {
        self.home = home
        managedObjectContext = moc
    }
    
    //MARK: - Private Methods
    
    private func loadSoldHistory() {
        guard let moc = managedObjectContext,
              let home = home,
              let saleHistory = saleHistory else { return }
        soldHistory = saleHistory.soldHistoryData(for: home, moc: moc)
        tableView.reloadData()
    }
    
    private func setupImage() {
        guard let imageData = home?.image, let image = UIImage(data: imageData) else { return }
        imageView.image = image
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
    }

}

//MARK: - SaleHistoryViewController

extension SaleHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soldHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleHistoryCell", for: indexPath) as! SaleHistoryTableViewCell
        let saleHistory = soldHistory[indexPath.row]
        cell.configureCell(saleHistory: saleHistory)
        return cell
    }
    
}
