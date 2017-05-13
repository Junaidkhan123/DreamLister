//
// MainVC.swift
//  DreamLister
//
//  Created by Junaid Khan on 23/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData
class MainVC: UIViewController,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate {
    @IBOutlet weak var segmentedButtons: UISegmentedControl!

    @IBOutlet weak var dreamListerTable: UITableView!
    
    var controller : NSFetchedResultsController<Items>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       dreamListerTable.delegate = self
        dreamListerTable.dataSource = self
        attemptFetch()
      
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let  mysections = controller.sections
        {
           return mysections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mysections = controller.sections
        {
            let sectionInfo = mysections[section]
        
            return sectionInfo.numberOfObjects
           
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dreamListerTable.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell : ItemCell , indexPath: NSIndexPath)
    {
        // update the cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configure(item: item)
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0
        {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemsDetailsVC", sender: item)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ItemsDetailsVC"
        {
            if let detailVCDestination = segue.destination as? ItemsDeatilsVC
            {
             if let item = sender as?  Items
             {
                 detailVCDestination.itemToBeEdit = item
                }
                
            }
        }
    }
    
    func attemptFetch()
    {
        let  fetchRequest : NSFetchRequest<Items> = Items.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort =  NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        if segmentedButtons.selectedSegmentIndex == 0
        {
            fetchRequest.sortDescriptors = [dateSort]
        }
        else if segmentedButtons.selectedSegmentIndex == 1
        {
            fetchRequest.sortDescriptors = [priceSort]
        }
        else if segmentedButtons.selectedSegmentIndex == 2
        {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        
        
        // context parameter is derived from AppDelegate
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do
        {
            try controller.performFetch()
        }
        catch
        {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dreamListerTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dreamListerTable.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type)
        {
        case.insert:
            if let indexPath = newIndexPath
            {
                dreamListerTable.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            
                if let indexPath = indexPath
                {
                    dreamListerTable.deleteRows(at: [indexPath], with: .fade)
                }
                break
        case.update:
            if let indexPath = indexPath
            {
                let cell  = dreamListerTable.cellForRow(at: indexPath) as! ItemCell
                // later we will update it
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break;
        case.move:
            if let indexPath = indexPath
            {
                dreamListerTable.deleteRows(at: [indexPath], with: .fade)
            }
            if  let indexPath = newIndexPath
            {
                dreamListerTable.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        attemptFetch()
        dreamListerTable.reloadData()
    }
}

