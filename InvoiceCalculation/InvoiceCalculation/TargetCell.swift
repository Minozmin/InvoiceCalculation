//
//  TargetCell.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

protocol TargetCellDelegate: NSObjectProtocol {
    func targetCell(_ cell: TargetCell, textFieldDidChange textField: UITextField)
}

class TargetCell: BaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceTF: UITextField!
    public var delegate: TargetCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = ICFont.system16
        titleLabel.text = ICCommon.localizable("TargetTitle")
        
        priceTF.layer.cornerRadius = 4
        priceTF.layer.borderColor = ICColor.cLightGray.cgColor
        priceTF.layer.borderWidth = 0.5
        priceTF.layer.masksToBounds = true
        priceTF.keyboardType = .decimalPad
        priceTF.attributedPlaceholder = self.attributedPlaceholder()
        priceTF.leftView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
            return view
        }()
        priceTF.leftViewMode = .always
        priceTF.clearButtonMode = .whileEditing
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: self.priceTF)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func attributedPlaceholder() -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: ICCommon.localizable("TargetPlaceholder"))
        attributed.addAttribute(.foregroundColor, value: ICColor.cLightGray, range: NSRange(location: 0, length: attributed.length))
        attributed.addAttribute(.font, value: ICFont.system14, range: NSRange(location: 0, length: attributed.length))
        return attributed
    }
}

extension TargetCell {
    @objc func textFieldDidChange(_ nofi: Notification) {
        let textField = nofi.object as! UITextField
        self.delegate?.targetCell(self, textFieldDidChange: textField)
    }
}
