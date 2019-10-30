//
//  InquireCell.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

protocol InquireCellDelegate: NSObjectProtocol {
    func inquireCellDidClick(_ cell: InquireCell)
}

class InquireCell: BaseTableViewCell {

    @IBOutlet var inquireBtn: UIButton!
    public var delegate: InquireCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        inquireBtn.titleLabel?.font = ICFont.system16
        inquireBtn.setTitle(ICCommon.localizable("Inquire"), for: .normal)
        inquireBtn.layer.cornerRadius = 3
        inquireBtn.layer.borderColor = ICColor.cBlue.cgColor
        inquireBtn.layer.borderWidth = 0.5
        inquireBtn.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onInquire(_ sender: Any) {
        self.delegate?.inquireCellDidClick(self)
    }
}
