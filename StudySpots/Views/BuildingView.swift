//
//  SpotsView.swift
//  StudySpots
//
//  Created by Milan Canty on 4/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct BuildingView: View {
    @FirestoreQuery (collectionPath: "buildings") var buildings: [Building]
    @Environment(\.dismiss)private var dismiss
    @State private var sheetIsPresented = false
    
    var body: some View {
        // trying to make a scroll of the diffrent buildings that are housed in the Buildings enum and wan them each to show a button that then when clicked will go to the list view which contians each of the study groups that are availble in that particular building
        NavigationStack {
            List(buildings) { building in
                NavigationLink {
                    RoomsView(building: building)
                } label: {
                    HStack{
                        Image("images-1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height:140)
                        Text (building.name)
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("BC Buildings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                            print("😡 ERROR: Could not sign out!")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    RoomsView(building: Building())
                }
            }
        }
    }
}

struct SpotsView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingView()
    }
}
