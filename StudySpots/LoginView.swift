//
//  ContentView.swift
//  StudySpots
//
//  Created by Milan Canty on 4/22/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field {
        case email, password
    }
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonDisabled = true
    @State private var presentSheet = false
    @FocusState private var focusField: Field?
    
    var body: some View {
        NavigationStack {
            Text("StudySpot \n Login")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.black)
            
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 270, height: 270)
                .fontWeight(.light)
                .padding()
                .foregroundColor(.blue)
            
            Group {
                TextField("E-mail", text: $email )
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: email) { newValue in
                        enableButtons()
                    }
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil
                    }
                    .onChange(of: password) { newValue in
                        enableButtons()
                    }
            }
            .textFieldStyle(.roundedBorder)
            .overlay{
               RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            HStack {
                Button {
                    register()
                } label: {
                    Text("Sign up")
                }
                .padding()
                Button {
                   login()
                } label: {
                    Text("Log In")
                }
                .padding(.leading)
            }
            .disabled(buttonDisabled)
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .padding(.top)
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role:.cancel){}
        }
        
        .onAppear {
            if Auth.auth().currentUser != nil {
                print("login succesful!")
                presentSheet = true
            }
        }
        .fullScreenCover(isPresented: $presentSheet) {
            SpotsView()
        }//TODO:add new view for this)
    }
    func enableButtons(){
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("login error: \(error.localizedDescription)")
                alertMessage = "registration error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration success!")
                presentSheet = true
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("login error: \(error.localizedDescription)")
                alertMessage = "login error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("login succesful!")
                presentSheet = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
