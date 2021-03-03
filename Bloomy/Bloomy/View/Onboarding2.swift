//
//  Onboarding2.swift
//  Bloomy
//
//  Created by Wilton Ramos on 02/03/21.
//

import SwiftUI

struct Onboarding2: View {
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack() {
                Text("Como posso te chamar?")
                    .font(.custom("Poppins-Medium", size: 30))
                    .foregroundColor(Color("cor_fonte"))
                    .padding(.trailing)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                
                TextField("Aninha", text: .constant(""))
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Rectangle()
                    .background(Color("cor_fonte"))
                    .opacity(0.6)
                    .position(x: geometry.size.width * 0.30)
                    .frame(width: geometry.size.width * 0.75, height: 3, alignment: .leading)
                
                
                
                Spacer ()
                
                Button(action: {}) {
                    Text("continuar")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(Color("cor_fonte"))
                        .padding(.vertical, geometry.size.height * 0.02)
                        .padding(.horizontal, geometry.size.width * 0.15)
                }
                .background(Color("cor_botao"))
                .clipShape(Capsule())
            }
            .padding(.bottom, geometry.size.height * 0.05)
            .frame(width: geometry.size.width)
            
        }.background(Color("cor_fundo").edgesIgnoringSafeArea(.all))
    }
}

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        
        Onboarding2()
            .previewDevice("iPhone 11")
        Onboarding2()
            .previewDevice("iPhone 12 Pro Max")
        Onboarding2()
            .previewDevice("iPod touch (7th generation)")
    }
}
