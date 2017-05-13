//
//  ItemsDeatilsVC.swift
//  DreamLister
//
//  Created by Junaid Khan on 24/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData
class ItemsDeatilsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var titleTextField: CustomTextField!
    
    
    @IBOutlet weak var priceTextField: CustomTextField!
    
    @IBOutlet weak var detailsTextField: CustomTextField!
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var thmbImage: UIImageView!
    var stores = [Store]()
    var itemToBeEdit : Items?
    var imagePicker : UIImagePickerController!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self 
        
        if let topItem = self.navigationController?.navigationBar.topItem
        {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
//        let store  = Store(context: context)
//        store.name = "Best Buy"
//        
//        let store1  = Store(context: context)
//        store1.name = "Tesla DealerShip"
//        
//        let store2  = Store(context: context)
//        store2.name = "Daraz"
//        
//        let store3  = Store(context: context)
//        store3.name = "E-bay"
//        
//        let store4  = Store(context: context)
//        store4.name = "Frys Electronics"
//        
//        let store5  = Store(context: context)
//        store5.name = "OLX"
//        
//        ad.saveContext()
        getStoreData()
        
        if itemToBeEdit != nil
        {
            loadItemData()
        }
}
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // updating
    }
    
    
    func getStoreData()
    {
        let fetchRequest : NSFetchRequest<Store> = Store.fetchRequest()
        do
        {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }
        catch{
            let error   = error as NSError
            print("\(error)")
        }
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        var item: Items!
        
        // creating Image Entity 
        let picture = Image(context: context)
        picture.image = thmbImage.image
        
        
        if itemToBeEdit == nil
        {
             item = Items(context: context)
        }
        else
        {
            item = itemToBeEdit
        }
        item.toImage = picture
        if let title = titleTextField.text
        {
            item.title = title
        }
        if let price = priceTextField.text
        {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsTextField.text {
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData()
    {
        if let item = itemToBeEdit
        {
            titleTextField.text = item.title
            priceTextField.text = "\(item.price)"
            detailsTextField.text = item.details
            thmbImage.image = item.toImage?.image as? UIImage
            if let store = item.toStore
            {
                var index = 0
                repeat
                {
                    let s = stores[index]
                    if s.name == store.name
                    {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1 
                }
                while (index < stores.count)
            }
        }
        
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if itemToBeEdit != nil
        {
            context.delete(itemToBeEdit!)
        }
        ad.saveContext()
       _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            thmbImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
