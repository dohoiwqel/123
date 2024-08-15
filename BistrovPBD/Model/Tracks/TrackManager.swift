//
//  TrackManager.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//
import Foundation
import CoreData
import UIKit
import AVFoundation

class TrackManager {
    
    static let shared = TrackManager()
    
    private init() {}
    
    // Контекст для работы с CoreData
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrackModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Track Management
    
    func addTrack(authorName: String, trackName: String, trackData: Data, duration: String, avatar: UIImage?, creationDate: Date = Date()) {
        let newTrack = TrackEntities(context: context)
        newTrack.id = UUID()
        newTrack.authorName = authorName
        newTrack.trackName = trackName
        newTrack.trackData = trackData
        newTrack.duration = duration
        newTrack.creationDate = creationDate
        if let avatarImage = avatar {
            newTrack.avatar = avatarImage.pngData()
        }
        
        saveContext()
    }
    
    func fetchTracks() -> [TrackEntities] {
        let fetchRequest: NSFetchRequest<TrackEntities> = TrackEntities.fetchRequest()
        
        do {
            let tracks = try context.fetch(fetchRequest)
            return tracks
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TrackEntities.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            saveContext()
        } catch let error as NSError {
            print("Could not delete all tracks. \(error), \(error.userInfo)")
        }
    }
    
    func deleteTrack(track: TrackEntities) {
        context.delete(track)
        saveContext()
    }
    
    func updateTrack(track: TrackEntities, authorName: String?, trackName: String?, trackData: Data?, duration: String?, avatar: UIImage?, creationDate: Date?) {
        if let authorName = authorName {
            track.authorName = authorName
        }
        if let trackName = trackName {
            track.trackName = trackName
        }
        if let trackData = trackData {
            track.trackData = trackData
        }
        if let duration = duration {
            track.duration = duration
        }
        if let creationDate = creationDate {
            track.creationDate = creationDate
        }
        if let avatarImage = avatar {
            track.avatar = avatarImage.pngData()
        }
        
        saveContext()
    }
    
    // MARK: - Load Tracks from Bundle
    
    func loadTracksFromMusicFolder() {
        let musicFolderName = ""  // Папка с музыкой
        
        guard let avatarImage = UIImage(named: "nirvanaImage") else {
            print("Image nirvanaImage not found")
            return
        }
        
        if let musicFolderURL = Bundle.main.resourceURL?.appendingPathComponent(musicFolderName) {
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: musicFolderURL, includingPropertiesForKeys: nil)
                for fileURL in fileURLs {
                    if fileURL.pathExtension == "mp3" {
                        let trackData = try Data(contentsOf: fileURL)
                        let trackName = fileURL.deletingPathExtension().lastPathComponent
                        let authorName = "Nirvana"
                        
                        // Получение длительности трека
                        let duration = getTrackDuration(url: fileURL)
                        
                        addTrack(authorName: authorName, trackName: trackName, trackData: trackData, duration: duration, avatar: avatarImage)
                    }
                }
            } catch {
                print("Error loading tracks: \(error.localizedDescription)")
            }
        } else {
            print("Music folder not found in bundle")
        }
    }
    
    // MARK: - Helper Method
    
    public func getTrackDuration(url: URL) -> String {
        let asset = AVURLAsset(url: url)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)
        let minutes = Int(durationInSeconds) / 60
        let seconds = Int(durationInSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
