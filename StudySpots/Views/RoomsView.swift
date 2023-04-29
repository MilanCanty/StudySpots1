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
    @State private var sheetIsPresented = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var RoomVM: RoomViewModel
//    @State private var showSheetRoomSheet = false
//    @State private var showSaveAlert = false
//    @State private var showingAsSheet = false
//    @State var building: Building
//    var previewRunning = false
    
    var body: some View {
        NavigationStack {
            //            Group {
            //                TextField("Name", text: $building.name)
            //                    .font(.title)
            //                TextField("Campus", text: $building.campus)
            //                    .font(.title2)
            //            }
            //            .disabled(building.id == nil ? false: true)
            //            .textFieldStyle(.roundedBorder)
            //            .overlay {
            //                RoundedRectangle(cornerRadius: 5)
            //                    .stroke(.gray.opacity(0.5), lineWidth: building.id == nil ? 2 : 0)
            //            }
            List {
                ForEach(rooms) {room in
                    NavigationLink {
                        DetailView(room: room)
                    } label: {
                        Text(room.courseName)
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
            .navigationTitle("Study Sessions")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button("Sign out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                            print("😡 ERROR: Could not sign out!")
                        }
                    }
                }
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                DetailView(room: Room())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsView()
            .environmentObject(RoomViewModel())
    }
}

            
//            .onAppear {
//                if !previewRunning && building.id != nil {
//                    $rooms.path = "buildings/\(building.id ?? "")/rooms"
//                    print("rooms.path = \($rooms.path)")
//                } else {
//                    showingAsSheet = true
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(building.id == nil)
//            .toolbar {
//                if showingAsSheet {
//                    if building.id  == nil && showingAsSheet {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Cancel") {
//                                dismiss()
//                            }
//                        }
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button("Save") {
//                                Task {
//                                    let success = await  BuildingVM.saveBuilding(building:building)
//                                    if success{
//                                        dismiss()
//                                    } else {
//                                        print ("error in saving building!")
//                                    }
//                                }
//                                dismiss()
//                            }
//                        }
//                    } else if showingAsSheet && building.id != nil {
//                        ToolbarItem(placement:.navigationBarTrailing) {
//                            Button("Done") {
//                                dismiss()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .sheet(isPresented: $showSheetRoomSheet) {
//            NavigationStack {
//                DetailView(building:building,room: Room())
//            }
//        }
//    }
//}
//struct RoomsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            RoomsView(building: Building(name:"Gasson"), previewRunning: true)
//                .environmentObject(BuildingViewModel())
//        }
//    }
//}
