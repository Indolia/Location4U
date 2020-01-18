//
//  UserLocation+CoreDataProperties.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation

extension UserLocation {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserLocation> {
        return NSFetchRequest<UserLocation>(entityName: "UserLocation")
    }
    
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var appState: String?
    @NSManaged public var date: Date?
    
}


//
extension UserLocation {
    static func save(with location: CLLocation , appState: String) {
        let viewContext = CoreDataManager.share.viewContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "UserLocation", into: viewContext) as! UserLocation
        entity.latitude = location.coordinate.latitude
        entity.longitude = location.coordinate.latitude
        entity.appState = appState
        entity.date = Date()
        CoreDataManager.share.saveContext()
        print("location save with  latitude: \(location.coordinate.latitude) longitude: \(location.coordinate.longitude)")
    }
    
    
    static func updateDataOnServerAndCleanLocalData() {
        
        let fetchRequest:NSFetchRequest<UserLocation> = UserLocation.fetchRequest()
        let managedContext = CoreDataManager.share.viewContext()
        do {
            let userLocations = try managedContext.fetch(fetchRequest)
            for location in userLocations {
                print("saved Location is \(location.latitude ) : \(location.longitude)" )
            }
            
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // Do API (server task )
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        CoreDataManager.share.deleteAll(for: batchDeleteRequest)
    }
}
