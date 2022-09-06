//
//  DetailProjectParticipantView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 29/08/22.
//

import SwiftUI

struct DetailProjectParticipantView: View {
    @Binding var projectParticipant: ProjectViewModel
    
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    var body: some View {
        ZStack{
            Color(UIColor.systemGray6)
            ScrollView{
                VStack(alignment:.leading){
                    ForEach (projectParticipant.participantList, id: \.self){ item in
                        HStack{
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.8, height: 40.8)
                                .foregroundColor(.black)
                                .padding()
                                .accessibilityLabel("foto \(firstName!)")
                            Text("\(firstName!)")
                            Spacer()
                            Text("3 Tugas")
                                .padding(.all, 8)
                                .background(RoundedRectangle(cornerRadius: 8).stroke())
                                .foregroundColor(.blue)
                                .accessibilityLabel("mengerjakan tiga tugas") //need to further update
                        }
                        .padding()
                    }
                    Spacer()
                }
                .navigationTitle("Detail Anggota")
                .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
                .background(.white)
                .cornerRadius(16)
            }.padding()
        }
    }
}

//struct DetailProjectParticipantView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectParticipantView()
//    }
//}
