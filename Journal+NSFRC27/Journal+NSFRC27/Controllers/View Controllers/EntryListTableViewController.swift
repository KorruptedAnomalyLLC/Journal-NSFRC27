//
//  EntryListTableViewController.swift
//  Journal+NSFRC27
//
//  Created by Austin West on 6/20/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import UIKit
import CoreData

class EntryListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.sharedInstance.fetchedResultsController.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.sharedInstance.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let entry = EntryController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row] else {return UITableViewCell() }
        
        cell.textLabel?.text = entry.title
        // TODO: - Detal show the timestamp
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let entry = EntryController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            EntryController.sharedInstance.deleteEntry(entry: entry)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        // Identifier
        if segue.identifier == "toDetailVC" {
              // Index
            // Destination
            guard let selectedIndexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? EntryDetailViewController else { return }
             // Object
            let entry = EntryController.sharedInstance.fetchedResultsController.fetchedObjects? [selectedIndexPath.row]
            destinationVC.entry = entry
        }
        // Object
    }
} // End of class

extension EntryListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            
            switch type {
                
            case .delete:
                guard let indexPath = indexPath else {return}
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            case .insert:
                guard let newIndexPath = newIndexPath else {return}
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            case .move:
                guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
                tableView.moveRow(at: oldIndexPath, to: newIndexPath)
                
            case .update:
                guard let indexPath = indexPath else {return}
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                fatalError()
            }
        }
        
    }
}

