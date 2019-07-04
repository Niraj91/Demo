//
//  CurrenciePopover.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit

protocol CurrencieDelegate {
    func selectedCurrencie(quote: String, currencie:String)
}

class CurrenciePopover: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblCurrencies: UITableView!
    
    // MARK: - Variable
    var delegate: CurrencieDelegate?
    
    // ViewModel
    private let viewModel: CurrenciePopoverModel = CurrenciePopoverModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCurrencieList()
        self.observeEvents()
    }
    
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tblCurrencies.reloadData()
            }
        }
        
        viewModel.didSelectRow = { quote, currencie in
            self.delegate?.selectedCurrencie(quote: quote, currencie: currencie)
        }
    }
}

// MARK: - Tableview Delegate
extension CurrenciePopover: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getSelectCurrenciesPrice(index: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Tableview DataSource
extension CurrenciePopover:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CurrencieCell = tableView.dequeueReusableCell(withIdentifier: "CurrencieCell", for: indexPath) as! CurrencieCell
        cell.dataSouce = viewModel.getDataForRow(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
