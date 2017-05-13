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
        //generateTestData()
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
        fetchRequest.sortDescriptors = [dateSort]
        
        
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
    func generateTestData()
    {
        let item = Items(context: context)
        item.title = "Mac Book Pro"
        item.price = 132600
        item.details = "I cant wait for this . I am waiting just becaues of shor of money, hope that soon I will get it "
        
        let item2 = Items(context: context)
        item2.title = "Folding Chair"
        item2.price = 1500
        item2.details = "This is the best chair to use it for sit for laptop doing somne awesome stuff"
        let item3 = Items(context: context)
        item3.title = "Tesla Model S"
        item3.price = 1000000
        item3.details = "This is the AWeosme car , I dont  know when this day will come , I will have it my own , just wait for it"
        
        
        let item4  = Items(context: context)
        item4.title = "NIA HeadPhones"
        item4.price = 1500
        item4.details = "This item has awesome bass , you can believe it that such headphones can generate such high bass , I will definetly have it"
        
        let item5 = Items(context: context)
        item5.title = "iMac"
        item5.price = 172000
        item5.details = "Well, If I say this is my first priority I will not be wrong , Is it my favourite and this is my one of biggest dream to have it and enjoy it "
        
        ad.saveContext()
    }
}

