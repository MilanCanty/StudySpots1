//
//  Building.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    var number = ""
    var courseName = ""
    var time = "" //make a time picker
    var description = ""
    
    
    var dictionary: [String: Any] {
        return ["number": number, "CourseName":courseName, "time":time,"description": description]
    }
}
