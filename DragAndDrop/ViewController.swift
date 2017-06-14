//
//  ViewController.swift
//  DemoiOS11
//
//  Created by Yudiz Solutions Pvt. Ltd. on 13/06/17.
//  Copyright © 2017 Yudiz Solutions Pvt. Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrImg = ["ironman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Large Title on Navigation Bar.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Delegate.
        tableView.dropDelegate = self
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource.
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.imgV.image = UIImage(named: arrImg[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVC = storyboard?.instantiateViewController(withIdentifier: "secVC") as! SecViewController
        _ = navigationController?.pushViewController(secVC, animated: true)
    }
    
    //Method Swipe from left.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, bool) in
            print("Favourite")
            bool(true)
        }
        action.image = #imageLiteral(resourceName: "favourite")
        action.backgroundColor = UIColor.orange
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    //Method Swipe from Right.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, bool) in
            print("Delete")
            bool(false)
        }
        action.image = #imageLiteral(resourceName: "Delete")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

//MARK: - UITableViewDropDelegate.
extension ViewController : UITableViewDropDelegate {
    
    //Method Will Check Drop Items can be Handle or not.
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    //Method will allow drop animation and operations.
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(dropOperation: .copy, intent: .automatic)
    }
    
    //Method will performDrop items to particular indexPath.
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            guard let string = items as? [String] else { return }
            
            var indexPaths = [IndexPath]()
            
            for (index, value) in string.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.arrImg.insert(value, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

//MARK: - Class of UITableViewCell
class TableViewCell : UITableViewCell {
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var imgV2: UIImageView!
}
