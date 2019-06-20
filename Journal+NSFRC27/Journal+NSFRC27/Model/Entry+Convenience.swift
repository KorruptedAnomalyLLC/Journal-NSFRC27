//
//  Entry+Convenience.swift
//  Journal+NSFRC27
//
//  Created by Austin West on 6/20/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    convenience init(title: String, body: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context ) {
        
        self.init(context: context)
        self.title = title
        self.body = body
        self.timestamp = timestamp
        
    }
}
