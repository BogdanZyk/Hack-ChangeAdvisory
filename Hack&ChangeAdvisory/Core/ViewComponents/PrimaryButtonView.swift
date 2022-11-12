//
//  PrimaryButtonView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI


import SwiftUI

struct PrimaryButtonView: View {
    var showLoader: Bool = false
    let title: String
    var font: Font = .system(size: 18, weight: .medium)
    var bgColor: Color = .accentColor
    var fontColor: Color = .white
    var height: CGFloat = 50
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(font)
                .foregroundColor(fontColor)
                .frame(height: height)
                .hCenter()
                .background{
                    RoundedRectangle(cornerRadius: 5).fill( bgColor)
                }
                .opacity(showLoader ? 0 : 1)
                .overlay{
                    if showLoader{
                        ProgressView()
                    }
                }
        }
    }
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            PrimaryButtonView(title: "Вход", action: {})
        }
        .padding()
    }
}

