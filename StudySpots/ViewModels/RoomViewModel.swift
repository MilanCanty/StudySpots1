//
//  RoomViewModel.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import Foundation
import FirebaseFirestore

class RoomViewModel: ObservableObject {
    @Published var room = Room()
    
    
    func saveRoom(building:Building, room: Room) async -> Bool {
        let db = Firestore.firestore()
        
        guard let BuildingID = building.id else {
            print("error: building.id = nil")
            return false
        }
        
        let collectionString = "building/\(BuildingID)/rooms"
        
        if let id = room.id {
            do {
                try await db.collection(collectionString).document(id).setData(room.dictionary)
                print("Data updated successfully!")
                return true
            } catch {
                print("error: could not update data in 'rooms' \(error.localizedDescription)")
                return false
            }
        } else {
            do{
              _ = try await db.collection(collectionString).addDocument(data: room.dictionary)
                print ("data added successfully!")
                return true
            } catch {
                print ("error: could not create a new spot in 'reviews' \(error.localizedDescription)")
                return false
            }
        }
    }
    func deleteReview(building: Building, room: Room) async -> Bool {
        let db = Firestore.firestore()
        guard let BuildingID = building.id, let roomID = room.id else {
            print("error: building.id = \(building.id ?? "nil"), room.id = \(room.id ?? "nil"). This should not have happened.")
            return false
        }
        do {
            let _ = try await db.collection("buildings").document(BuildingID).collection("rooms").document(roomID).delete()
            print ("document successfully deleted")
            return true
        } catch {
            print("error: reoving document \(error.localizedDescription)")
            return false
        }
    }
}
