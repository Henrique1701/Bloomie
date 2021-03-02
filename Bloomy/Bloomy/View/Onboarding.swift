//
//  Onboarding.swift
//  Bloomy
//
//  Created by Wilton Ramos on 26/02/21.
//

/*TODO:
 [] Colocar um tamanho máximo para a imagem para
 [] FontSize ter manho mínimo e máximo
 [] Ver SwiftUI em proporção à tela
 [] Ver GeomtryReader
 [] Ver iPad nas Highs
 */

import SwiftUI

struct Onboarding: View {
    var body: some View {
        VStack {
            Image("garota_onboarding")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 600, maxHeight: 600)
            
            Spacer()
            
            Text("Como vai?")
                .font(.custom("Poppins-SemiBold", size: 30))
            
            Text("Acreditamos que pequenas ações\n conseguem mudar o mundo")
                .font(.custom("Poppins-Regular", size: 16))
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Começar")
                    .font(.custom("Poppins-Bold", size: 18))
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
            }
            .background(Color("cor_botao"))
            .clipShape(Capsule())
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Onboarding()
            Onboarding()
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
            Onboarding()
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
