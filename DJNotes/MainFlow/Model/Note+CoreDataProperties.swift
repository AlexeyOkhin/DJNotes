//
//  Note+CoreDataProperties.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var lastUpdated: Date!
    @NSManaged public var text: String!

}

extension Note : Identifiable {

}
