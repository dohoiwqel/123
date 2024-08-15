//
//  TrackEntities+CoreDataClass.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//
//

import Foundation
import CoreData

@objc(TrackEntities)
public class TrackEntities: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case authorName
        case avatar
        case duration
        case id
        case trackData
        case trackName
        case creationDate
    }
    
    // MARK: - Decodable
    required public convenience init(from decoder: Decoder) throws {
        guard let context = CodingUserInfoKey.context,
              let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "TrackEntities", in: managedObjectContext)!
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
        self.avatar = try container.decodeIfPresent(Data.self, forKey: .avatar)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id)
        self.trackData = try container.decodeIfPresent(Data.self, forKey: .trackData)
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
        self.creationDate = try container.decodeIfPresent(Date.self, forKey: .creationDate)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(authorName, forKey: .authorName)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(duration, forKey: .duration)
        try container.encode(id, forKey: .id)
        try container.encode(trackData, forKey: .trackData)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(creationDate, forKey: .creationDate)
    }
}

// MARK: - CodingUserInfoKey Helper
extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

// MARK: - DecoderConfigurationError
enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}
