//
//  listView.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct RoomsView: View {
    @FirestoreQuery (collectionPath: "rooms") var rooms: [Room]
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var RoomVM: RoomViewModel
    @State private var presentSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(rooms) { room in
                    NavigationLink {
                        DetailView(room: room)
                    } label: {
                        Text(room.number)
                        Text(room.courseID)
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else {return}
                    Task {
                        await RoomVM.deleteData(room: rooms[index])
                    }
                }
            }
            .listStyle(.plain)
            .font(.title2)
            .navigationTitle("Rooms & Courses:")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button("Home") {
                        //add navigation back to home screen
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        presentSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .fullScreenCover(isPresented: $presentSheet) {
                DetailView(room:Room())
            }
        }
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(room: Room(number:"245"))
        }
    }
}
