//
//  ResultCell.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

class ResultCell: BaseTableViewCell {

    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var combinationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        totalLabel.font = ICFont.system14
        totalLabel.text = ""
        
        combinationLabel.font = ICFont.system14
        combinationLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(data: Any?, delegate: Any?) {
        guard let model = data as? InvoiceModel else {
            return
        }
        totalLabel.text = ICCommon.localizable("Total") + "\(model.totalAmount ?? 0)"
        combinationLabel.text = ICCommon.localizable("Combination") + "\(model.group ?? "")"
    }
}
