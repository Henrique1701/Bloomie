//
//  SeedDataBase.swift
//  Bloomy
//
//  Created by Wilton Ramos on 26/11/20.
//

import CoreData
import UIKit

struct SeedDataBase {
    static let shared: SeedDataBase = SeedDataBase()
    
    func seed() {
        if (UserManager.shared.getUser() == nil) {
            self.createUser()
        }
        
        if (IslandManager.shared.getIslands() == nil) {
            self.createIslands()
        }
        
        if (ChallengeManager.shared.getChallenges() == nil) {
            self.createChallenges()
        }
        
        if(RewardManager.shared.getRewards() == nil) {
            self.createRewards()
        }
    }
    
    func createIslands() {
        _ = IslandManager.shared.newIsland(withName: "Atenção Plena")
        _ = IslandManager.shared.newIsland(withName: "Lazer")
        _ = IslandManager.shared.newIsland(withName: "Pessoas Queridas")
        _ = IslandManager.shared.newIsland(withName: "Saúde")
        
        setUserToIslands()
    }
    
    func createChallenges() {
        createMindfulnessChallenges()
        createLeisureChallenges()
        createLovedsChallenges()
        createHealthChallenges()
    }
    
    func createRewards() {
        _ = RewardManager.shared.newReward(withId: "R1", withImage: UIImage())
        _ = RewardManager.shared.newReward(withId: "R2", withImage: UIImage())
        _ = RewardManager.shared.newReward(withId: "R3", withImage: UIImage())
        _ = RewardManager.shared.newReward(withId: "R4", withImage: UIImage())
        _ = RewardManager.shared.newReward(withId: "R5", withImage: UIImage())
        
        RewardManager.shared.setIsland(toReward: "R1", island: IslandManager.shared.getIsland(withName: "Atenção Plena")!)
        RewardManager.shared.setIsland(toReward: "R2", island: IslandManager.shared.getIsland(withName: "Atenção Plena")!)
        RewardManager.shared.setIsland(toReward: "R3", island: IslandManager.shared.getIsland(withName: "Lazer")!)
        RewardManager.shared.setIsland(toReward: "R4", island: IslandManager.shared.getIsland(withName: "Pessoas Queridas")!)
    }
    
    func createUser() {
        UserManager.shared.newUser(withName: "Rafa")
    }
    
    func createMindfulnessChallenges() {
        let mindfulnessChallenges = Challenges().mindfulnessChallenges
        for challenge in mindfulnessChallenges {
            _ = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                    , withSummary: challenge["Summary"]!)
        }
    }
    
    func createLeisureChallenges() {
        let leisureChallenges = Challenges().mindfulnessChallenges
        for challenge in leisureChallenges {
            _ = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                    , withSummary: challenge["Summary"]!)
        }
    }
    
    func createLovedsChallenges() {
        let lovedsChallenges = Challenges().mindfulnessChallenges
        for challenge in lovedsChallenges {
           _ = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                    , withSummary: challenge["Summary"]!)
        }
    }
    
    func createHealthChallenges() {
        let healthChallenges = Challenges().mindfulnessChallenges
        for challenge in healthChallenges {
            _ = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                    , withSummary: challenge["Summary"]!)
        }
    }
    
    func setUserToIslands() {
        if let user = UserManager.shared.getUser() {
            _ = IslandManager.shared.setUser(islandName: "Atenção Plena", user: user)
            _ = IslandManager.shared.setUser(islandName: "Lazer", user: user)
            _ = IslandManager.shared.setUser(islandName: "Pessoas Queridas", user: user)
        }
    }
}

struct Challenges {
    
    let mindfulnessChallenges = [
        ["ID": "M0", "Summary": "Pare por um momento e observe os sons aos seu redor. O que você consegue ouvir?"],
        ["ID": "M1", "Summary": "Durante alguma das suas refeições de hoje, preste atenção apenas no que você está comendo. Sem celular, sem televisão. Saboreie cada pedaço com atenção plena."],
        ["ID": "M2", "Summary": "Observe a sua respiração. Note o ar entrando e saindo dos seus pulmões. Observe como você está se sentindo."],
        ["ID": "M3", "Summary": "Olhe ao seu redor e preste atenção nos detalhes das coisas que você vê. Quais cores, formas e textura você nota?"],
        ["ID": "M4", "Summary": "Feche os olhos e imagine que você está escaneando o seu corpo, da cabeça até os pés. Preste atenção nas sensações. Relaxe as áreas do seu corpo que você sentir que estão tensionadas."],
        ["ID": "M5", "Summary": "Respire profundamente, levando o ar para a sua barriga."],
        ["ID": "M6", "Summary": "Quando você for escovar os dentes hoje, preste atenção no seu corpo e nos movimentos que você faz. Gentilmente retorne a sua atenção quando você notar que se distraiu. "],
        ["ID": "M7", "Summary": "Preste atenção em um objeto ao seu redor e o observe como se o estivesse vendo pela primeira vez."],
        ["ID": "M8", "Summary": "Note a beleza de algo ao seu redor. Pode ser algo da natureza, uma pessoa, um objeto, uma música..."]
    ]
    
    let leisureChallenges = [
        ["ID": "L0", "Summary": "Ouvir sua música favorita"],
        ["ID": "L1", "Summary": "Ouvir uma música que você gostava muito há alguns anos"],
        ["ID": "L2", "Summary": "Ouvir uma música que você saiba de cor"],
        ["ID": "L3", "Summary": "Vá para um cômodo vazio e dance como você não dançaria na frente dos outros"],
        ["ID": "L4", "Summary": "Assista um vídeo de comédia no youtube"],
        ["ID": "L5", "Summary": "Guarde 5 minutos do seu dia para olhar memes na internet"],
        ["ID": "L6", "Summary": "Faça um desenho simples e pinte-o do jeito que quiser"],
        ["ID": "L7", "Summary": "Assista um episódio de série que você nunca viu, mas sempre teve vontade de ver"],
        ["ID": "L8", "Summary": "Assista um vídeo de um canal que você não conhecia no YouTube"],
        ["ID": "L9", "Summary": "Escolha um filme para você não deixar de assistir no próximo fim de semana"],
        ["ID": "L10", "Summary": "Passe 5 minutos fazendo massagem no próprio pé"],
        ["ID": "L11", "Summary": "Abrace um bichinho de estimação ou veja vídeos fofos de cães na internet"],
        ["ID": "L12", "Summary": "Lanche sua comida favorita"],
        ["ID": "L13", "Summary": "Faça uma playlist para escutar durante sua próxima refeição "],
        ["ID": "L14", "Summary": "Faça uma playlist para seu próximo banho"],
        ["ID": "L15", "Summary": "Tire um momento do dia para refletir sobre a última conversa muito engraçada que você teve"],
        ["ID": "L16", "Summary": "Leia um pedacinho do seu livro favorito"],
        ["ID": "L17", "Summary": "Vista um look que te faz se sentir confiante"],
        ["ID": "L18", "Summary": "Dê uma pequena caminhada, nem que seja uma volta no seu quarteirão"],
        ["ID": "L19", "Summary": "Chame seus amigos para uma partida online de um jogo que vocês gostam"],
        ["ID": "L20", "Summary": "Procure uma ideia de DIY para você fazer essa semana"],
        ["ID": "L21", "Summary": "Coma algo de um restaurante que você não conhecia"],
        ["ID": "L22", "Summary": "Tome um banho à luz de velas"],
        ["ID": "L23", "Summary": "Junte vários travesseiros de uma maneira confortável e tire uma soneca"],
        ["ID": "L24", "Summary": "Pense na sua flor favorita e tente desenhá-la da sua maneira"],
        ["ID": "L25", "Summary": "Guarde 5 minutos do seu dia para olhar o por-do-sol"],
        ["ID": "L26", "Summary": "Tente uma nova receita"],
        ["ID": "L27", "Summary": "Enquanto realizando alguma atividade rotineira, tente escutar um podcast"],
        ["ID": "L28", "Summary": "Hoje, enquanto estiver numa rede social, pare de acompanhar pessoas que tragam algum tipo de ansiedade"],
        ["ID": "L29", "Summary": "Tente substituir redes sociais por outra atividade hoje"],
        ["ID": "L30", "Summary": "Assista a um episódio de uma série de comédia "],
        ["ID": "L31", "Summary": "Leia frases motivacionais"],
        ["ID": "L32", "Summary": "Assista uma entrevista com seu famoso favorito"],
        ["ID": "L33", "Summary": "Faça algo que aumenta sua autoestima hoje"],
        ["ID": "L35", "Summary": "Faça uma lista dos melhores momentos desse ano"]
    ]
    
    let lovedsChallenges = [
        ["ID": "P0", "Summary": "Mande um meme ou um vídeo engraçado para alguém "],
        ["ID": "P1", "Summary": "Mande mensagem para um amigo relembrando algum momento muito especial que vocês viveram juntos"],
        ["ID": "P2", "Summary": "Fale para alguém como essa pessoa é especial"],
        ["ID": "P3", "Summary": "Elogie duas pessoas que você ama"],
        ["ID": "P4", "Summary": "Troque indicações de música com alguém "],
        ["ID": "P5", "Summary": "Mande mensagem para um amigo com quem você não fala há muito tempo perguntando como ele está "],
        ["ID": "P6", "Summary": "Mande um doce por delivery para alguém de surpresa"],
        ["ID": "P7", "Summary": "Faça alguma surpresa para alguém que você ama"],
        ["ID": "P8", "Summary": "Cozinhe uma refeição especial para alguém "],
        ["ID": "P9", "Summary": "Compre um presente para uma pessoa querida"],
        ["ID": "P10", "Summary": "Mande uma mensagem de bom dia "],
        ["ID": "P11", "Summary": "Abrace alguém "],
        ["ID": "P12", "Summary": "Mande uma mensagem de gratidão pela pelo apoio de alguém na sua vida"],
        ["ID": "P13", "Summary": "Pergunte a alguém especial como foi seu dia"],
        ["ID": "P14", "Summary": "Olhe fotos antigas com pessoas queridas"],
        ["ID": "P15", "Summary": "Ligue para um parente mais velhinho e veja como ele está "],
        ["ID": "P16", "Summary": "Ligue para alguém que você sente saudade"],
        ["ID": "P17", "Summary": "Combine de assistir um filme com alguém "],
        ["ID": "P18", "Summary": "Cante karaokê com alguém "],
        ["ID": "P19", "Summary": "Brinque de verdade ou consequência com alguém "],
        ["ID": "P20", "Summary": "Marque uma maratona de filmes com seus amigos"]
    ]
    
    let healthChallenges = [
        ["ID": "H1", "Summary": "Ajuste a sua postura"],
        ["ID": "H2", "Summary": "Faça uma caminhada de 10 minutos"],
        ["ID": "H3", "Summary": "Se você tiver que andar de elevador hoje, escolha ir pelas escadas"],
        ["ID": "H4", "Summary": "Adicione mais vegetais às suas refeições"],
        ["ID": "H5", "Summary": "Tire 10 minutos do seu dia para organizar alguma coisa do seu ambiente. Pode ser a sua mesa do trabalho, uma gaveta no seu armário, uma prateleira da sua estante..."],
        ["ID": "H6", "Summary": "Reflita sobre três coisas pelas quais você é grato"],
        ["ID": "H7", "Summary": "Encontre um momento do seu dia para fazer uma pausa e relaxar. "],
        ["ID": "H8", "Summary": "Faça um alongamento "],
        ["ID": "H9", "Summary": "Fique em uma postura de yoga por dois minutos. Recomendamos a pose do cachorro olhando para baixo"],
        ["ID": "H10", "Summary": "Escreva uma carta para o seu eu do futuro e guarde num lugar seguro. Só abra daqui a 6 meses."],
        ["ID": "H11", "Summary": "Pratique o seu hobby favorito!"],
        ["ID": "H12", "Summary": "Preste atenção no quanto você reclama e tente evitar reclamar. Observe a mudança no seu humor."],
        ["ID": "H13", "Summary": "Proteja a sua pele! Use protetor solar!"],
        ["ID": "H14", "Summary": "Cante no chuveiro"],
        ["ID": "H15", "Summary": "Comemore uma pequena vitória sua hoje"],
        ["ID": "H16", "Summary": "Tente fazer uma nova receita saudável  que você está querendo experimentar"]
    ]
}
