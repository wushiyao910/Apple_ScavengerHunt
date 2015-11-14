//
//  ItemsManager.swift
//  Scavenger Hunt
//
//  Created by WuShiyao on 11/12/15.
//  Copyright © 2015 WuShiyao. All rights reserved.
//

import Foundation
import UIKit

class ItemsManager {
    var itemsList = [ScavengerHuntItem]()
    
    func archivePath() -> String?{
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        if let documentsPath = directoryList.first
        {
            return documentsPath + "/ScavengerHuntItems"
        }
        
        assertionFailure("Could not determine where to save file.")
        return nil
    }
    
    func save()
    {
        if let theArchivePath = archivePath()
        {
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath)
            {
                print("Save successfully")
            }
            else
            {
                assertionFailure("Could not save date to \(theArchivePath)")
            }
        }
    }
    
    func unarchiveSavedItems()
    {
        if let theArchivePath = archivePath()
        {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath)
            {
                itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
    
    init()
    {
        unarchiveSavedItems()
    }
}
