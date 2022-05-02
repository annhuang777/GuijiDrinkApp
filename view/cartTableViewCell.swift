//
//  cartTableViewCell.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/25.
//

import UIKit

class cartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cartOrderName: UILabel!
    @IBOutlet weak var cartDrinkName: UILabel!
    @IBOutlet weak var cartIce: UILabel!
    @IBOutlet weak var cartSugar: UILabel!
    @IBOutlet weak var cartTopping: UILabel!
    @IBOutlet weak var cartQuantity: UILabel!
    @IBOutlet weak var cartSubtotal: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
