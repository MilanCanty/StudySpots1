//
//  SpotsView.swift
//  StudySpots
//
//  Created by Milan Canty on 4/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct SpotsView: View {
    @FirestoreQuery (collectionPath: "rooms") var rooms: [Room]
    @Environment(\.dismiss)private var dismiss
    @EnvironmentObject var RoomVM: RoomViewModel
    
    var body: some View {
        ScrollView {
            // trying to make a scroll of the diffrent buildings that are housed in the Buildings enum and wan them each to show a button that then when clicked will go to the list view which contians each of the study groups that are availble in that particular building
            LazyVGrid (columns: [GridItem(.adaptive(minimum: 100), spacing: 30)]) {
                ForEach(Building.allCases) { i in
                    Button {
                        // add code for slide up list sheet
                    } label: {
                        VStack{
                            Image(systemName: "books.vertical.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height:140)
                                .foregroundColor(.green)
                            Text (i.rawValue)
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    print("🪵➡️ Log out successful!")
                    dismiss()
                } catch {
                    print("😡 ERROR: Could not sign out!")
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            .foregroundColor(.white)
            //align to the left bottom
        }
    }
}

struct SpotsView_Previews: PreviewProvider {
    static var previews: some View {
        SpotsView()
    }
}
