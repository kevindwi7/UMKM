//
//  DetailProjectTaskCard.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct DetailProjectTaskCard: View {
    
    @Binding var test: ProjectViewModel
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    var body: some View {
        ZStack{
            Color.primaryGray
            ScrollView{
              
                    Color.primaryGray
                    VStack(alignment:.leading,spacing: 10){
                       
                        ForEach(0...15, id: \.self){ project in
                            HStack{
                                Text("Sapu Lantai").font(.system(size: 12, weight: .regular, design: .default))
                                Spacer()
                                
                                Button {
                                    //handle assign to me
                                    print("Test")
                                    
                                } label: {
                                    Text("Asign to Me").font(.system(size: 12, weight: .regular, design: .default))
                                }
                                .frame(width: 103,height: 25)
                                .foregroundColor(.white)
                                .background(test.participantList.contains(userID!) ? .blue : .gray)
                                .cornerRadius(8)
                                .disabled(!test.participantList.contains(userID!))

                                
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Detail Tugas")
                    
                        .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
                        .background(.white)
                        .cornerRadius(16)
                
           
            
               
            }
        }
        
        
    }
}

//struct DetailProjectTaskCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectTaskCard(isProjectJoined: .constant(false))
//    }
//}

