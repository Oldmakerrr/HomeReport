//
//  SaleHistoryTableViewCell.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit

class SaleHistoryTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var soldDateLabel: UILabel!
    @IBOutlet weak var soldPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(saleHistory: SaleHistory) {
        soldDateLabel.text = saleHistory.soldDate?.toString
        soldPriceLabel.text = saleHistory.soldPrice.currencyFormatter
    }
    
}
