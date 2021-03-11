//
//  PeriodTableViewController.swift
//  PickADriver2
//
//  Created by James, Alice - PGA on 3/11/21.
//

import UIKit

class PeriodTableViewController: UITableViewController {
    var names = [["First", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Second", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Third", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Fourth", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Fifth", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Sixth", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Seventh", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"], ["Eighth", "Henry", "Benny", "Violet", "Jesse", "Watch", "Gertrude", "Chandler"]]
    var selectedNames: [String] = []
    var selectedPeriod = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNames = names[indexPath.row]
        selectedPeriod = indexPath.row + 1
        performSegue(withIdentifier: "PeriodToNames", sender: nil)
    }
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let namesTableVC = segue.destination as? NamesTableViewController {
            namesTableVC.names = selectedNames
            namesTableVC.period = selectedPeriod
        }
    }
    

}
