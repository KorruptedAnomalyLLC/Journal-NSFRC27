//
//  EntryDetailViewController.swift
//  Journal+NSFRC27
//
//  Created by Austin West on 6/20/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    var entry: Entry?
    
    @IBOutlet weak var entryTextField: UITextField!
    @IBOutlet weak var entryBodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        designClearButton()
    }
    
    func designClearButton() {
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.setTitle("Clear Text", for: .normal)
        clearButton.backgroundColor = .cyan
        clearButton.setTitleColor(.black, for: .normal)
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        entryTextField.text = entry.title
        entryBodyTextView.text = entry.body
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let entryText = entryTextField.text, let bodyText = entryBodyTextView.text else {return}
        if let entry = entry {
            // Entry has a value - thusly they want to update
            EntryController.sharedInstance.updateEntry(entry: entry, newTitle: entryText, newBody: bodyText)
        } else {
            EntryController.sharedInstance.createEntry(withTitle: entryText, body: bodyText)
            // Entry is nil - thusly they want to create a new Entry
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
    }
    
    
    
    
}
