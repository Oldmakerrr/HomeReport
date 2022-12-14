//
//  HomeListTableViewCell.swift
//  HomeReport
//
//  Created by Apple on 04.08.2022.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var sqftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    internal func configureCell(home: Home) {
        cityLabel.text = home.city
        categoryLabel.text = home.homeType
        priceLabel.text = home.price.currencyFormatter
        bedLabel.text = String(home.bed)
        bathLabel.text = String(home.bath)
        sqftLabel.text = String(home.sqft)

        if let imageData = home.image, let image = UIImage(data: imageData) {
            homeImageView.image = image
            homeImageView.layer.borderWidth = 1
            homeImageView.layer.cornerRadius = 4
        }
    }
    
}
