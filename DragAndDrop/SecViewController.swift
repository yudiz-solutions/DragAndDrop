//
//  SecViewController.swift
//  DragAndDrop
//
//  Created by Yudiz Solutions Pvt. Ltd. on 13/06/17.
//  Copyright © 2017 Yudiz Solutions Pvt. Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices

class SecViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrImg = ["hulk","ironman","aaron","poster1","scar","poster","thor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Large Title to .never.
        navigationItem.largeTitleDisplayMode = .never
        
        // Delegate.
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource.
extension SecViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.imgV2.image = UIImage(named: arrImg[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDragDelegate.
extension SecViewController : UITableViewDragDelegate {
    
    //Method will allow to lift and drag item.
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let image = arrImg[indexPath.row]
        let provider = NSItemProvider(object: image as NSItemProviderWriting)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        return [item]
    }
    
    // Multiple items lift and drag.
    func tableView(_ tableView: UITableView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let image = arrImg[indexPath.row]
        let provider = NSItemProvider(object: image as NSItemProviderWriting)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        return [item]
    }
}

