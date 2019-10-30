//
//  InvoiceCell.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

protocol InvoiceCellDelegate: NSObjectProtocol {
    func invoiceCell(_ cell: InvoiceCell,didChange textView: UITextView)
}

class InvoiceCell: BaseTableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var invoiceTV: UITextView!
    @IBOutlet var tipLabel: UILabel!
    public var delegate: InvoiceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = ICFont.system16
        titleLabel.text = ICCommon.localizable("InvoiceTitle")
        
        invoiceTV.layer.cornerRadius = 4
        invoiceTV.layer.borderColor = UIColor.lightGray.cgColor
        invoiceTV.layer.borderWidth = 0.5
        invoiceTV.layer.masksToBounds = true
        invoiceTV.font = ICFont.system16
        invoiceTV.delegate = self
        invoiceTV.keyboardType = .numbersAndPunctuation
        invoiceTV.returnKeyType = .done
        
        tipLabel.font = ICFont.system14
        tipLabel.textColor = ICColor.cLightGray
        tipLabel.text = ICCommon.localizable("InvoicePlaceholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension InvoiceCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.tipLabel.isHidden = (textView.text.isEmpty == false) ? true : false
        
        self.delegate?.invoiceCell(self, didChange: textView)
    }
}
