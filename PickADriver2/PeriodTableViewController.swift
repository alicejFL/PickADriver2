//
//  PeriodTableViewController.swift
//  PickADriver2
//
//  Created by James, Alice - PGA on 3/11/21.
//


import UIKit

let savedNamesUserDefaultsKey = "names"

class PeriodTableViewController: UITableViewController {
//    var names: [String: [String]] = [:]
//    var selectedNames: [String] = []
    var selectedPeriod = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPeriod = String(indexPath.row + 1)
       // selectedNames = names[selectedPeriod] ?? []
        performSegue(withIdentifier: "PeriodToDriverSelect", sender: nil)
    }
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let driverSelectVC = segue.destination as? DriverSelectCollectionViewController {
         //   driverSelectVC.names = selectedNames
            driverSelectVC.period = selectedPeriod
        }
    }
    
    
}
