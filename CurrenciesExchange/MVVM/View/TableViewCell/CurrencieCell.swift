//
//  CurrencieCell.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit

class CurrencieCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCurrentPrice: UILabel!
    
    var dataSouce:String? {
        didSet {
            self.lblTitle.text = dataSouce
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
