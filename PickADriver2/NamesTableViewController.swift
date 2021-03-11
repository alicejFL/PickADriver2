//
//  NamesTableViewController.swift
//  PickADriver2
//
//  Created by James, Alice - PGA on 3/11/21.
//

import UIKit

class NamesTableViewController: UITableViewController {
    var names:[String] = []
var period = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Period \(period)"
        tableView.isEditing = true
    }
    @IBAction func onAddButtonTapped(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add a name", message: nil, preferredStyle: .alert)
        var nameField: UITextField?
        alert.addTextField(configurationHandler: {(textField) in
            nameField = textField
            nameField?.placeholder = "Name"
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let name = nameField?.text {
                self.names.append(name)
                self.save()
                self.tableView.reloadData()
            }
        }
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)

        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
  
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            names.remove(at: indexPath.row)
            save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let namesToMove = names.remove(at: fromIndexPath.row)
        names.insert(namesToMove, at: to.row)
        save()

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    func save() {
        if var savedNames = UserDefaults.standard.value(forKey: savedNamesUserDefaultsKey) as? [String:[String]] {
            savedNames[period] = names
            UserDefaults.standard.set(savedNames, forKey: savedNamesUserDefaultsKey)
        }
    }

}
