//
//  MemeCollectionViewController.swift
//  Display Memes in a Collection View
//  MemeMe
//
//  Created by Venkata Palakodety on 8/22/15.
//  Copyright (c) 2015 Venkata Palakodety. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        // Allow to display the Edit button on the left of the navigation bar
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Reload the Collection View
        collectionView!.reloadData()
        
        // If no memes found, disable the Edit Button in the navigation bar
        navigationItem.leftBarButtonItem?.enabled = Meme.getMemeCount() > 0
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        // Placeholder function to modify the edit mode of the collection view
        super.setEditing(editing, animated: animated)
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        if let meme = Meme.getMemeAtIndex(indexPath.row) {
            cell.memeImageView.image = meme.memedImage
        }
        
        // Display the Delete button only if the user has clicked on the Edit Button
        cell.deleteButton.hidden = !editing
        
        // If the user has pressed delete, be prepared to handle the delete event
        cell.deleteButton.addTarget(self, action: "didPressDelete:", forControlEvents: .TouchUpInside)
        return cell
    }
    
    @IBAction func didPressDelete(sender: UIButton) {
        // If the user pressed the delete button, then remove the meme from the Collection View
        let cell = sender.superview!.superview! as! MemeCollectionViewCell
        let index = collectionView!.indexPathForCell(cell)!
        Meme.removeMemeAtIndex(index.row)
        collectionView!.deleteItemsAtIndexPaths([index]);
        
        // Once deleted, revert editing attribute
        setEditing(false, animated: true)
        navigationItem.leftBarButtonItem?.enabled = Meme.getMemeCount() > 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Get the count of Memes in storage
        return Meme.getMemeCount()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        // If the user is not editing, then clicking on the Meme should go to the Detail View
        if !editing {
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }
    
    @IBAction func didPressAdd(sender: AnyObject) {
        // Allow the user to add a new Meme if they clicked on the + button
        performSegueWithIdentifier("showEditor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected Meme to be displayed in the Detail View
        if segue.identifier == "showDetail" {
            var destination = segue.destinationViewController as! DetailViewController
            if let meme = Meme.getMemeAtIndex(selectedIndex!) {
                destination.meme = meme
            }
        }
    }
}


