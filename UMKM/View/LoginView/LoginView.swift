//
//  LoginView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import AuthenticationServices

import CloudKit

struct LoginView: View {
    
    @AppStorage("login") private var login = false
    @StateObject var vm: MainViewModel
    @State var selectedBookId: Int64 = 0
    @State var action: Int? = 0
    
    var body: some View {
        VStack{
            Spacer()
            let userID = UserDefaults.standard.object(forKey: "userID") as? String
            
            if (!login && (userID == nil)) {
                Text("Selamat Datang")
                    .font(.system(size: 38))
                    .fontWeight(.bold)
                    .padding()
                Text("Setiap potensi anda")
                    .font(.system(size: 15))
                Text("berarti bagi komunitas")
                    .font(.system(size: 15))
                    .accessibilityElement(children: .combine)
                    
                VStack{
                    Image("peeps")
                        .resizable()
                        .scaledToFit()
                        .frame(height:200)
                        .accessibilityHidden(true)
                    

                }
                .padding(.vertical,64)
                
                // If login = false and userID is not exist,
                // Show Sign in with Apple Button.
                SignInWithAppleButton(
                    // Request User FullName and Email
                    onRequest: { request in
                        // You can change them if needed.
                        request.requestedScopes = [.fullName, .email]
                    },
                    // Once user complete, get result
                    onCompletion: { result in
                        // Switch result
                        switch result {
                            // Auth Success
                        case .success(let authResults):
                            
                            switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                let userID = appleIDCredential.user
                                if let firstName = appleIDCredential.fullName?.givenName,
                                   let lastName = appleIDCredential.fullName?.familyName,
                                   let email = appleIDCredential.email{
                                    // For New user to signup, and
                                    // save the 3 records to CloudKit
                                    let record = CKRecord(recordType: "UsersData", recordID: CKRecord.ID(recordName: userID))
                                    record["email"] = email
                                    record["firstName"] = firstName
                                    record["lastName"] = lastName
                                    record["iCloudID"] = vm.userID
                                    // Save to local
                                    UserDefaults.standard.set(email, forKey: "email")
                                    UserDefaults.standard.set(firstName, forKey: "firstName")
                                    UserDefaults.standard.set(lastName, forKey: "lastName")
                                    let publicDatabase = CKContainer.default().publicCloudDatabase
                                    publicDatabase.save(record) { (_, _) in
                                        UserDefaults.standard.set(record.recordID.recordName, forKey: "userID")
                                    }
                                    // Change login state
                                    self.login = true
                                } else {
                                    // For returning user to signin,
                                    // fetch the saved records from Cloudkit
                                    let publicDatabase = CKContainer.default().publicCloudDatabase
                                    publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID)) { (record, error) in
                                        if let fetchedInfo = record {
                                            let email = fetchedInfo["email"] as? String
                                            let firstName = fetchedInfo["firstName"] as? String
                                            let lastName = fetchedInfo["lastName"] as? String
                                            // Save to local
                                            UserDefaults.standard.set(userID, forKey: "userID")
                                            UserDefaults.standard.set(email, forKey: "email")
                                            UserDefaults.standard.set(firstName, forKey: "firstName")
                                            UserDefaults.standard.set(lastName, forKey: "lastName")
                                            // Change login state
                                            self.login = true
                                        }
                                    }
                                }
                                
                                // default break (don't remove)
                            default:
                                break
                            }
                        case .failure(let error):
                            print("failure", error)
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black) // Button Style
                .frame(width:280,height:50)         // Set Button Size (Read iOS 14 beta 7 release note)
                Spacer()
            }else{
                TabBarView()
                
            }
            
           Spacer()
            
            
        }
    }
}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(vm: MainViewModel(container: CKContainer.default()))
//    }
//}
