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
                Text("Como você se chama?")
                    .font(.custom("Poppins-Bold", size: 28))
                    .padding(.trailing)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                    
                
                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width: geometry.size.width * 0.9)
                
                
                Spacer ()
                
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("continuar")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(.black)
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
        Onboarding2()
            .previewDevice("iPod touch (7th generation)")
    }
}
