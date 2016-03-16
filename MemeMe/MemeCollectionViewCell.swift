//
//  MemeCollectionViewCell.swift
//  Contain attributes for a cell in the Collection View
//  MemeMe
//
//  Created by Venkata Palakodety on 8/23/15.
//  Copyright (c) 2015 Venkata Palakodety. All rights reserved.
//

import UIKit

// Note: This is a class instead of a struct, because we are creating a class of type UICollectionViewCell
class MemeCollectionViewCell: UICollectionViewCell {
    //Outlet for the ImageView
    @IBOutlet weak var memeImageView: UIImageView!
    
    //Outlet for the Delete Button
    @IBOutlet weak var deleteButton: UIButton!
}