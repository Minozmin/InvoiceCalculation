//
//  BaseTableViewCell.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension BaseTableViewCell {
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String.init(describing: self)
    }
    
    @objc func setData(data: Any?, delegate: Any?) {
        
    }
}
