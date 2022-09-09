//
//  Constant.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import Foundation
import SwiftUI

struct Constant{
    
}

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension Color {
  static let primaryGray = Color("primary_gray")
}

extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

struct AutoSizingTF: UIViewRepresentable {
    
    var hint:String
    @Binding var text:String
    @Binding var containerHeight: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTF.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = hint
        textView.textColor = .gray
        
        textView.font = .systemFont(ofSize: 14)
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            if containerHeight == 0 {
                containerHeight = uiView.contentSize.height
            }
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate{
        var parent:AutoSizingTF
        
        init(parent: AutoSizingTF){
            
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.hint{
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == ""{
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
        
    }
}
