//
//  WidgetView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 13.11.2022.
//

import SwiftUI

struct WidgetFinanceView: View {
    var isSender: Bool
    @State private var index: Int = 0
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                TabView(selection: $index) {
                    ForEach(Mocks.promotions.indices, id: \.self) { index in
                        ZStack {
                            Color.accentBg
                            VStack(spacing: 5) {
                                Text(Mocks.promotions[index].title)
                                    .font(.title3.bold())
                                Text("Сектор: \(Mocks.promotions[index].sector)")
                                    .font(.system(size: 14))
                                Text(String(format: "%.02f $", Mocks.promotions[index].price))
                                    .font(.headline.weight(.medium))
                            }
                        }
                        .tag(index)
                    }
                }
                .background(Color.accentBg)
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack{
                    ForEach(Mocks.promotions.indices, id: \.self){index in
                        Circle()
                            .fill(self.index == index ? Color.accentColor : .black.opacity(0.5))
                            .frame(width: 6)
                    }
                }
                .padding(.bottom)
                .hCenter()
                .background(Color.accentBg)
                if isSender{
                    ZStack{
                        Color.foreground2
                        Text("Ожидание выбора акции")
                            .foregroundColor(.white)
                    }
                    .frame(height: 55)
                }else{
                    buttonSection
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
    }
}

struct WidgetFinanceView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetFinanceView(isSender: true)
            .frame(height: 180)
            .padding()
        
    }
}


extension WidgetFinanceView{
    private var buttonSection: some View{
        HStack(spacing: 0){
            Button {
                
            } label: {
                ZStack{
                    Color.foreground3.opacity(0.5)
                    Text("Отменить")
                        .foregroundColor(.foreground)
                }
            }
            Button {
                
            } label: {
                ZStack{
                    Color.accentColor
                    Text("Выбрать")
                        .foregroundColor(.white)
                }
            }
        }
        .font(.system(size: 16, weight: .medium))
        .frame(height: 55)
    }
}



struct CompanyPromotion: Identifiable{
    let id = UUID()
    let title: String
    let sector: String
    let price: Double
    let value: Double
}
