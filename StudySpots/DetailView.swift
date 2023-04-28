//
//  DetailView.swift
//  StudySpots
//
//  Created by Milan Canty on 4/27/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var placeVM: RoomViewModel
    @State var room: Room
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack(alignment: .leading) {
            Group {
                Text("Room Number:")
                    .bold()
                TextField("room number", text:$room.number)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Text("Course Department & ID:")
                    .bold()
                TextField("course ID", text:$room.courseID)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Text("Course Name")
                    .bold()
                TextField("course name", text:$room.courseName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
            }
            Text("Subject Matter or Chapters:")
                .bold()
            TextField("subject", text:$room.subject)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
        
            Text("Study Time slot:")
                .bold()
            TextField("time", text:$room.time)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Text("Further Description of Study Session:")
                .bold()
            TextField("description", text:$room.description)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Spacer()
        }
        .font(.title2)
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem (placement:.navigationBarLeading){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem (placement:.navigationBarTrailing){
                Button("Save"){
                    Task {
                        let id = await placeVM.saveRoom(room: room)
                        if id != nil {
                            dismiss()
                        } else {
                            print("did not save")
                        }
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(room: Room(number: "100"))
                .environmentObject(RoomViewModel())
        }
    }
}
