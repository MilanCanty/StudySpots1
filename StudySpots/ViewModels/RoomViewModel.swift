//
//  RoomViewModel.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import Foundation
import FirebaseStorage
import UIKit
import FirebaseFirestore

class RoomViewModel: ObservableObject {
    @Published var room = Room()
    
    func saveRoom(room: Room) async -> String? {
        let db = Firestore.firestore()
        if let id = room.id { // place must already exist, so save
            do {
                try await db.collection("rooms").document(id).setData(room.dictionary)
                print("😎 Data updated successfully!")
                return room.id
            } catch {
                print("😡 ERROR: Could not update data in 'rooms' \(error.localizedDescription)")
                return nil
            }
        } else { // no id? Then this must be a new student to add
            do {
                let docRef = try await db.collection("rooms").addDocument(data: room.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new room in 'rooms' \(error.localizedDescription)")
                return nil
            }
        }
    }
    func deleteData(room: Room) async {
        let db = Firestore.firestore()
        
        guard let id = room.id else {
            print("error: id was nil")
            return
        }
        do {
            try await db.collection("rooms").document(id).delete()
            return
        } catch {
            print("error: removing document")
            return
        }
    }
}
//    func saveRoom(building:Building, room: Room) async -> Bool {
//        let db = Firestore.firestore()
//
//        guard let BuildingID = building.id else {
//            print("error: building.id = nil")
//            return false
//        }
//
//        let collectionString = "building/\(BuildingID)/rooms"
//
//        if let id = room.id {
//            do {
//                try await db.collection(collectionString).document(id).setData(room.dictionary)
//                print("Data updated successfully!")
//                return true
//            } catch {
//                print("error: could not update data in 'rooms' \(error.localizedDescription)")
//                return false
//            }
//        } else {
//            do{
//              _ = try await db.collection(collectionString).addDocument(data: room.dictionary)
//                print ("data added successfully!")
//                return true
//            } catch {
//                print ("error: could not create a new spot in 'reviews' \(error.localizedDescription)")
//                return false
//            }
//        }
//    }
//    func deleteReview(building: Building, room: Room) async -> Bool {
//        let db = Firestore.firestore()
//        guard let BuildingID = building.id, let roomID = room.id else {
//            print("error: building.id = \(building.id ?? "nil"), room.id = \(room.id ?? "nil"). This should not have happened.")
//            return false
//        }
//        do {
//            let _ = try await db.collection("buildings").document(BuildingID).collection("rooms").document(roomID).delete()
//            print ("document successfully deleted")
//            return true
//        } catch {
//            print("error: reoving document \(error.localizedDescription)")
//            return false
//        }
//    }
//}
