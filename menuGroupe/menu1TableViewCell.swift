//
//  menu1TableViewCell.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/9.
//

import UIKit

class menu1TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var recommendLabel: UILabel!
    
    @IBOutlet weak var drinkItemLabel: UILabel!
    @IBOutlet weak var NTLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
