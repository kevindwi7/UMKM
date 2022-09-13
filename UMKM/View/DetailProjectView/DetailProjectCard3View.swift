//
//  DetailProjectCard3View.swift
//  UMKM
//
//  Created by Kevin  Dwi on 29/08/22.
//

import SwiftUI
import CloudKit

struct DetailProjectCard3View: View {
    @StateObject var hm:HomeViewModel
    @StateObject var mvm:MainViewModel
    @Binding var project3: ProjectViewModel
    @Binding var task: [TaskViewModel]
    @State var action: Int? = 0
    @State var isActive = false
    
//    init(vm: HomeViewModel, project3: Binding<ProjectViewModel>, task: Binding<TaskViewModel>) {
//        _vm = StateObject(wrappedValue: vm)
//        self._project3 = project3
//        self._task = task
//    }
    
    var body: some View {
        VStack(alignment:.leading,spacing: 15){
            HStack{
            VStack(alignment:.leading,spacing: 6){
                Text("Tugas").font(.system(.footnote, design: .rounded)).bold()
                    .scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                Text("\(self.task.count)" )
                        .font(.system(.caption, design: .rounded))
                        .scaledFont(name: "", size: 12)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                        .accessibilityLabel("Jumlah tugas ada \(self.task.count)") //need to further update - vp
            }
                Spacer()
                    NavigationLink(destination: {
                        DetailProjectTaskCard(vm: HomeViewModel(container: CKContainer.default()), mvm: MainViewModel(container: CKContainer.default()), project: $project3, task: $task, isActive: $isActive)
    //                    TabBarView()
                    }, label: {
                        Text("Detail Tugas")
                            .font(.system(.caption, design: .rounded).bold())
                            .foregroundColor(.white)
                            .frame(width: 130, height: 30)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.cyan))
                            .accessibilityLabel("Tombol lihat detail tugas")
                
                    })
    //                Button {
    //                    //handle assign to me
    //                    print("Test")
    //                } label: {
    //                    Text("Detail Tugas").font(.system(size: 12, weight: .regular, design: .default))
    //                }
    //                .background(.blue)
    //                .frame(width: 150,height: 25)
    //                .cornerRadius(8)
    //                .foregroundColor(.white)
                }
      
            
        }
       
        .padding()
            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
    
}

//struct DetailProjectCard3View_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectCard3View()
//    }
//}
