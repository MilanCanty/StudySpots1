//
//  BuildingViewModel.swift
//  StudySpots
//
//  Created by Milan Canty on 4/28/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

class BuildingViewModel: ObservableObject {
    @Published var building = Building()
    
    func saveBuilding(building:Building) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = building.id {
            do {
                try await db.collection("buildings").document(id).setData(building.dictionary)
                print("Data updated successfully!")
                return true
            } catch {
                print("error: could not update data in 'buildings' \(error.localizedDescription)")
                return false
            }
        } else {
            do{
                let documentRef = try await db.collection("buildings").addDocument(data: building.dictionary)
                self.building = building
                self.building.id = documentRef.documentID
                print ("data added successfully!")
                return true
            } catch {
                print ("error: could not create a new spot in 'building' \(error.localizedDescription)")
                return false
            }
        }
    }
}



