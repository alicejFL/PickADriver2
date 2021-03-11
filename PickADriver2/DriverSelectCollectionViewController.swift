//
//  DriverSelectCollectionViewController.swift
//  PickADriver2
//
//  Created by James, Alice - PGA on 3/11/21.
//

import UIKit

private let reuseIdentifier = "StudentNameCell"


class DriverSelectCollectionViewController: UICollectionViewController {
    var names: [String] = []
    var period = "O"
    var isSelectingDriver = false
    var timer = Timer()
    var classList: [String] = []
    var delay: TimeInterval = 0.2
    
    
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var playButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
      

        // Do any additional setup after loading the view.
    }

    @IBAction func onPlayTapped(_ sender: UIBarButtonItem)
    {
        if isSelectingDriver {
            playButton.image = UIImage(systemName: "play.fill")
            playButton.tintColor = .systemGreen
            timer.invalidate()
            names = classList
            collectionView.reloadData()
        } else {
            playButton.image = UIImage(systemName: "stop.fill")
            playButton.tintColor = .systemRed
            delay = 0.2
            timer = .scheduledTimer(timeInterval: delay, target: self, selector: #selector(eliminateDriver), userInfo: nil, repeats: false)
        }
        isSelectingDriver = !isSelectingDriver
        editButton.isEnabled = !isSelectingDriver
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let namesTableVC = segue.destination as? NamesTableViewController {
            namesTableVC.names = classList
            namesTableVC.period = period
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let studentName = names[indexPath.item]
        if let textLabel = cell.contentView.subviews.first as? UILabel {
            textLabel.text = studentName
        }
        print(studentName)
        if names.count == 1 {
            cell.contentView.backgroundColor = .systemYellow
        }
        else {
        cell.contentView.backgroundColor = .lightGray
        // Configure the cell
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedNames = UserDefaults.standard.value(forKey: savedNamesUserDefaultsKey) as? [String:[String]] {
            names = savedNames[period] ?? []
            classList = names
            collectionView.reloadData()
        }
        else {
            let empty:[String:[String]] = [:]
            UserDefaults.standard.set(empty, forKey: savedNamesUserDefaultsKey)
        }
        playButton.isEnabled = names.count > 1
    }
    
    @objc func eliminateDriver() {
        if names.count > 1 {
            let next = Int.random(in: 0..<names.count)
            names.remove(at: next)
            collectionView.deleteItems(at: [IndexPath(item: next, section: 0)])
            delay += 0.2
            timer = .scheduledTimer(timeInterval: delay, target: self, selector: #selector(eliminateDriver), userInfo: nil, repeats: false)
        }
        else {
            timer.invalidate()
            collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
}
