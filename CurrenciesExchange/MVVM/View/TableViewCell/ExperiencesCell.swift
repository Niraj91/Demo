//
//  experiencesCell.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit
import SDWebImage

class ExperiencesCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCurrenciesPrice: UILabel!
    @IBOutlet weak var img: UIImageView!

    // MARK: - Variable
    var currentCurrencieQuote:Float!
    var currentCurrencieType:String!
    var dataSouce:Experience? {
        didSet {
            self.img.sd_setImage(with: dataSouce!.imgURL) { (image, error, type, url) in
                self.img.image = image
            }
            self.lblTitle.text = dataSouce!.title
            self.lblCurrenciesPrice.text = String.init(format: "%.2f", dataSouce!.cost) + " (\(String(describing: dataSouce!.currencyType!)))"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         // Initialization code
        self.img.layer.masksToBounds = true
        self.img.layer.cornerRadius = (self.img.frame.height/2)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
