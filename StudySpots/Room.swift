//
//  Building.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import Foundation
import FirebaseFirestoreSwift

enum Building: String, CaseIterable, Codable {
    case Gasson, Devlin, Higgins, Maloney, Lyons, Fulton, Campion, Stokes, McGuinn, Merkert, Schiller
}

struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    var number = ""
    var courseID = ""
    var courseName = ""
    var subject = ""
    var time = "" //make a time picker
    var building = Building.Gasson.rawValue
    var description = ""
    
    var dictionary: [String: Any] {
        return ["number": number, "courseID":courseID, "CourseName":courseName, "subject": subject, "time":time,"building":building,"description": description]
    }
}
