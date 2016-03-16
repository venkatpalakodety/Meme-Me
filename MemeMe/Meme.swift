//
//  Meme.swift
//  Find, Save and Delete Memes
//  MemeMe
//
//  Created by Venkata Palakodety on 8/22/15.
//  Copyright (c) 2015 Venkata Palakodety. All rights reserved.
//

import UIKit

class Meme {
    /// Top Text Field's Text
    var top = ""
    /// Bottom Text Field's Text
    var bottom = ""
    /// Meme's Background Image
    var image = UIImage()
    /// The composited text and image that can be shared
    var memedImage = UIImage()
    
    
    // Constructor to set Meme properties
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
    }
    
    // Save the Meme
    func save() {
        Meme.getStorage().memes.append(self)
    }
    
    // Get the Meme Object from Storage
    class func getStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    // Get the count of all Memes in Storage
    class func getMemeCount() -> Int {
        return Meme.getStorage().memes.count
    }
    
    // Get Memes present at a specified Index
    class func getMemeAtIndex(index: Int) -> Meme? {
        if Meme.getStorage().memes.count > index {
            return Meme.getStorage().memes[index]
        }
        return nil
    }
    
    // Delete Memes at a specified Index
    class func removeMemeAtIndex(index: Int) {
        if index >= 0 && Meme.getStorage().memes.count > index {
            Meme.getStorage().memes.removeAtIndex(index)
        }
    }
}