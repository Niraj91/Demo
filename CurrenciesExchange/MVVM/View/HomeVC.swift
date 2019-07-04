//
//  HomeVC.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreData

class HomeVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblExperiences: UITableView!
    
    // ViewModel
    private let viewModel: HomeVCModel = HomeVCModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init HomeVC object
        viewModel.objHome = self
        
        //Dyamic Height of Tableview
        self.tblExperiences.estimatedRowHeight = 60
        self.tblExperiences.rowHeight = UITableView.automaticDimension
        self.tblExperiences.tableFooterView = UIView()
        
        viewModel.getExperiencesList()
    }
    
    // MARK: - IBAction
    @IBAction func onClickButtonConvert(_ sender: UIButton) {
        // get a reference to the view controller for the popover
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrenciePopover") as! CurrenciePopover
        popController.delegate = self
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = sender as UIView // button
        popController.popoverPresentationController?.sourceRect = sender.bounds
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
}

// MARK: - CurrencieDelegate
extension HomeVC: CurrencieDelegate {
    func selectedCurrencie(quote: String, currencie: String) {
        viewModel.setNewCurrencie(quote: Float(quote)!, currencieType: currencie)
    }
}

// MARK: - Tableview Delegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     }
}

// MARK: - Tableview DataSource
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ExperiencesCell = tableView.dequeueReusableCell(withIdentifier: "experiencesCell", for: indexPath) as! ExperiencesCell
        cell.dataSouce = viewModel.getDataForRow(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension HomeVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension HomeVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.tblExperiences.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    }
}
