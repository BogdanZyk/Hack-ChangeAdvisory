//
//  PrimaryTextField.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct PrimaryTextField: View {
    var secure: Bool = false
    let label: String
    @Binding var text: String
    var body: some View {
        Group{
            if secure{
                SecureField(text: $text) {
                    Text(label)
                        .foregroundColor(.foreground)
                }
            }else{
                TextField(text: $text) {
                     Text(label)
                         .foregroundColor(.foreground)
                 }
            }
        }
         .padding(.horizontal)
         .frame(height: 50)
         .background(Color.bg, in: RoundedRectangle(cornerRadius: 5))
         .background(Color.foreground3, in: RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1.5))
         .font(.system(size: 18))
    }
}

struct PrimaryTextField_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryTextField(label: "text", text: .constant(""))
    }
}
