//
//  DetailView.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var RoomVM: RoomViewModel
//    @State var building: Building
    @State var room: Room
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text ("Building Name")
                    .bold()
                    .font(.title)
                Picker("", selection: $room.buildingName) {
                    ForEach(BuildingName.allCases, id: \.self) { buildingName in
                        Text(buildingName.rawValue.capitalized)
                            .tag(buildingName.rawValue)
                    }
                }
                
                Text("Room Number:")
                    .bold()
                TextField("room number", text:$room.number)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Text("Course Name")
                    .bold()
                TextField("course name", text:$room.courseName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
            }
                
                Text("Study Time slot:")
                    .bold()
                DatePicker("time", text:$room.time)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Text("Description of Study Session:")
                    .bold()
            TextField("description", text:$room.description, axis:.vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
            Spacer()
        }
        .font(.title2)
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem (placement:.cancellationAction){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem (placement:.navigationBarTrailing){
                Button("Save"){
                    Task {
                        let id = await RoomVM.saveRoom(room: room)
                        if id != nil {
                            dismiss()
                        } else {
                            print("did not save")
                        }
                    }
                }
            }
        }
        .onAppear {
            print("I got to my detail view!")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(room: Room(number: "245"))
                .environmentObject(RoomViewModel())
        }
    }
}
