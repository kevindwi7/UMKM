//
//  TaskView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 26/08/22.
//

import SwiftUI

struct TaskView: View {
    
    @State private var totalTask:Int = 2
    @State private var tasks = ["",""]
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    var body: some View {
        ZStack {
            Color.primaryGray.ignoresSafeArea()
            VStack {
                Spacer().frame(height:20)
                ScrollView {
                    VStack{
                        Text("Tulis tugas apa saja yang di perlukan untuk menjalankan proyek komunitasmu").font(.system(size: 12, weight: .medium, design: .default))
                        ForEach(0...totalTask-1, id: \.self) { task in
                            TextField("Tugas \(task+1)", text: self.$tasks[task]).textFieldStyle(CustomTextFieldStyle())
                                .frame(width: UIScreen.main.bounds.width/1.2,height: 50)
                        }
                        Button {
                            self.totalTask+=1
                            tasks.append("")
                        } label: {
                            Text("Tambah Tugas").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.2,height: 30)
                                .background(.blue)
                                .cornerRadius(12)
                                .padding()
                        }
                        Spacer()
                    }.navigationTitle("Atur Tugas")
                    Spacer()
                }.frame(width:UIScreen.main.bounds.width/1.2).padding().background(.white).cornerRadius(8)
                Button {
                    //handle save project
                } label: {
                    Text("Selesai").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                        .background(.blue)
                        .cornerRadius(12)
                        .padding()
                }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        // set the inner Text Field Font
            .padding(10) // Set the inner Text Field Padding
        //Give it some style
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.primary.opacity(0.2), lineWidth: 1))
    }
}
