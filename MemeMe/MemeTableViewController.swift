//
//  MemeTableViewController.swift
//  Display Memes in a Table View
//  MemeMe
//
//  Created by Venkata Palakodety on 8/22/15.
//  Copyright (c) 2015 Venkata Palakodety. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Placeholder to store the index of the Meme
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        // Allow to display the Edit button on the left of the navigation bar
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If no memes found, disable the Edit Button in the navigation bar
        navigationItem.leftBarButtonItem?.enabled = Meme.getMemeCount() > 0
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Allow deletion of a Meme
        switch editingStyle {
        case .Delete:
            Meme.removeMemeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        default:
            return
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Get the count of Memes in storage
        return Meme.getMemeCount()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // DeQueue a memeTableCell
        var cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell") as! MemeTableCell
        if let meme = Meme.getMemeAtIndex(indexPath.row) {
            cell.memeImageView.image = meme.memedImage
            cell.memeLabel.text = "\(meme.top) \(meme.bottom)"
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        // Placeholder function to modify the edit mode of the table view
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !tableView.editing {
            // If the user is not editing, then clicking on the Meme should go to the Detail View
            selectedIndex = indexPath.row
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