//
//  Building.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import Foundation
import FirebaseFirestoreSwift


enum BuildingName: String, CaseIterable, Codable {
    case Gasson, Devlin, Higgins, Maloney, Lyons, Fulton, Campion, Stokes, McGuinn, Merkert, Schiller
}


struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    var number = ""
    var courseName = ""
    var time = Date.now + (60*60*24) //make a time picker
    var description = ""
    var buildingName = BuildingName.Gasson.rawValue
    
    
    var dictionary: [String: Any] {
        return ["number": number, "courseName":courseName, "time":time,"description": description, "buildingName":buildingName]
    }
}
