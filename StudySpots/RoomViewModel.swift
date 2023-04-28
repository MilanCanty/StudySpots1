//
//  RoomViewModel.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

class RoomViewModel: ObservableObject {
    @Published var room = Room()
    
func saveRoom(room: Room) async -> String? {
        let db = Firestore.firestore()
        if let id = room.id { // place must already exist, so save
            do {
                try await db.collection("places").document(id).setData(room.dictionary)
                print("😎 Data updated successfully!")
                return room.id
            } catch {
                print("😡 ERROR: Could not update data in 'places' \(error.localizedDescription)")
                return nil
            }
        } else { // no id? Then this must be a new student to add
            do {
                let docRef = try await db.collection("places").addDocument(data: room.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new place in 'places' \(error.localizedDescription)")
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
            try await db.collection("places").document(id).delete()
            return
        } catch {
            print("error: removing document")
            return
        }
    }
    func saveImage(id: String, image: UIImage) async {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("\(id)/image.jpg")
        
        let resizedImage = image.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let resizedImage = resizedImage {
            do {
                let metadata = try await storageRef.putDataAsync(resizedImage)
                print("Metadata: ", metadata)
                print("📸 Image Saved!")
            } catch {
                print("😡 ERROR: uploading image to FirebaseStorage \(error.localizedDescription)")
            }
        }
    }
}


