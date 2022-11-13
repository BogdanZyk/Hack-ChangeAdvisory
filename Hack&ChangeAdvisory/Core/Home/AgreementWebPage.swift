//
//  AgreementWebPage.swift
//  Hack&ChangeAdvisory
//
//  Created by Diana Princess on 13.11.2022.
//

import SwiftUI

struct AgreementwebPage: View{
    var body: some View{
        Link("Пользовательское соглашение",
             destination: URL(string: "https://www.open.ru/agreement")!)
    }
}
