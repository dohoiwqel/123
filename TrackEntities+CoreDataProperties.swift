//
//  TrackEntities+CoreDataProperties.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//
//

import Foundation
import CoreData


extension TrackEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackEntities> {
        return NSFetchRequest<TrackEntities>(entityName: "TrackEntities")
    }

    @NSManaged public var authorName: String?
    @NSManaged public var avatar: Data?
    @NSManaged public var duration: String?
    @NSManaged public var id: UUID?
    @NSManaged public var trackData: Data?
    @NSManaged public var trackName: String?
    @NSManaged public var creationDate: Date?

}

extension TrackEntities : Identifiable {

}
