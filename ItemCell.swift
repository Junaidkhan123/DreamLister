//
//  ItemCell.swift
//  DreamLister
//
//  Created by Junaid Khan on 23/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    

    @IBOutlet weak var thumbImage: UIImageView!
         @IBOutlet weak var title: UILabel!
        @IBOutlet weak var price: UILabel!
        @IBOutlet weak var details: UILabel!
    func configure(item : Items)
    {
        title.text = item.title
        price.text = "Rs.\(item.price)"
        details.text = item.details
        thumbImage.image = item.toImage?.image as? UIImage
    }
    
}
