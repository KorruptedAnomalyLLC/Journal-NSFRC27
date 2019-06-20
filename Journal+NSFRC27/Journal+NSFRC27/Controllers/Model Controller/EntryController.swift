//
//  EntryController.swift
//  Journal+NSFRC27
//
//  Created by Austin West on 6/20/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
    var fetchedResultsController: NSFetchedResultsController<Entry>
    
    init() {
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch!! \(error.localizedDescription)")
        }
    }
    
    // Create
    func createEntry(withTitle: String, body: String) {
        let entry = Entry(title: withTitle, body: body)
        
        saveToPersistentStore()
    }
    // Update
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        // Save
        saveToPersistentStore()
    }
    // Delete
    
    func deleteEntry(entry: Entry) {
        // Save
        //entry.managedObjectContext?.delete(entry)
        CoreDataStack.context.delete(entry)
        saveToPersistentStore()
    }
    // Save
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("error saving Managed Object. Item not saved!!!")
        }
    }
    // Load
}
