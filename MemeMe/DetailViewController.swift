//
//  DetailViewController.swift
//  Show the selected Meme
//  MemeMe
//
//  Created by Venkata Palakodety on 8/22/15.
//  Copyright (c) 2015 Venkata Palakodety. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Declare an Outlet to show the selected Meme
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Display the selected Meme
        imageView.image = meme.memedImage
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected Meme's properties to the Meme Editor, only if the user has clicked on the Edit Button
        // in the Detail View
        if segue.identifier == "showEditor" {
            let destination = segue.destinationViewController as! EditorViewController
            destination.editMeme = meme
        }
    }
}
