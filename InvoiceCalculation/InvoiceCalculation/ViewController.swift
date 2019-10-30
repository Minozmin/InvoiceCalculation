//
//  ViewController.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var cells: Array = [Array<String>]()
    private var datas: ArraySlice<InvoiceModel> = []
    private var targetAmount: String?
    private var invoiceAmount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = ICCommon.localizable("NavTitle")
        view.backgroundColor = ICColor.cF1
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = ICColor.cF1
        tableView.keyboardDismissMode = .onDrag
        tableView.tableHeaderView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: ICCommon.screenWidth, height: 60))
            view.backgroundColor = ICColor.cWhite
            
            let label = UILabel(frame: CGRect(x: 20, y: 20, width: view.frame.width - 40, height: view.frame.height))
            label.text = "*  " + ICCommon.localizable("Introduction")
            label.font = ICFont.system12
            label.textColor = UIColor.red
            label.textAlignment = .left
            label.numberOfLines = 0;
            label.sizeToFit()
            
            view.addSubview(label)
            return view
        }()
        
        tableView.register(TargetCell.nib, forCellReuseIdentifier: TargetCell.identifier)
        tableView.register(InvoiceCell.nib, forCellReuseIdentifier: InvoiceCell.identifier)
        tableView.register(InquireCell.nib, forCellReuseIdentifier: InquireCell.identifier)
        tableView.register(ResultCell.nib, forCellReuseIdentifier: ResultCell.identifier)
        
        updateCells()
    }
    
    private func updateCells() {
        var mCells = [Array<String>]()
        
        mCells.append([TargetCell.identifier])
        mCells.append([InvoiceCell.identifier])
        mCells.append([InquireCell.identifier])
        
        var result: Array<String> = []
        for _ in self.datas {
            result.append(ResultCell.identifier)
        }
        
        if result.isEmpty == false {
            mCells.append(result)
        }
        
        self.cells = mCells
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cells[indexPath.section][indexPath.row]
        
        switch identifier {
        case TargetCell.identifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TargetCell
            cell.delegate = self
            return cell
            
        case InvoiceCell.identifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! InvoiceCell
            cell.delegate = self
            return cell
            
        case ResultCell.identifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ResultCell
            cell.setData(data: datas[indexPath.row], delegate: self)
            return cell
            
        case InquireCell.identifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! InquireCell
            cell.delegate = self
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let identifier = cells[indexPath.section][indexPath.row]
        switch identifier {
        case TargetCell.identifier:
            return 100
        case InvoiceCell.identifier:
            return 150
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 40
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
            let title = UILabel.init(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
            title.text = ICCommon.localizable("ResultTitle")
            title.font = ICFont.system16
            view.addSubview(title)
            return view
        }
        return nil
    }
}

extension ViewController: TargetCellDelegate, InvoiceCellDelegate, InquireCellDelegate {
    func targetCell(_ cell: TargetCell, textFieldDidChange textField: UITextField) {
        self.targetAmount = textField.text
    }
    
    func invoiceCell(_ cell: InvoiceCell, didChange textView: UITextView) {
        self.invoiceAmount = textView.text
    }
    
    func inquireCellDidClick(_ cell: InquireCell) {
        guard self.targetAmount?.count ?? 0 > 0 ||
            self.invoiceAmount?.count ?? 0 > 0 else {
                return
        }
        
        let target: Double = Double(self.targetAmount ?? "")!
        var invoices = [Double]()
        
        var text: String = self.invoiceAmount ?? ""
        text = text.replacingOccurrences(of: "，", with: ",")
        let array: Array<String> = text.components(separatedBy: ",")
        for item in array {
            if item.isEmpty == false {
                invoices.append(Double(item)!)
            }
        }

        self.datas = InvoiceViewModel.matchResult(targetAmount: target, invoices: invoices)
        updateCells()
    }
}
