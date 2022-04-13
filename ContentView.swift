import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State var texts: [String] = ["0"]
    
    var scene: SKScene {
        let scene = GameScene()
        scene.stateMachine = StateMachine()
        let node = SKSpriteNode()
        node.color = .systemRed
        node.size = scene.size
        node.position = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(node)
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .disabled(true)
            
            VStack {
                HStack {
                    Spacer()
                    Text("You're an atom")
                        .padding(.vertical, 16)
                    Spacer()
                }
                .background(Color.gray.opacity(0.7))
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                Spacer()
                
                VStack() {
                    ForEach(0..<texts.count, id: \.self) { i in
                        HStack(alignment: .top) {
                            Button {
                                optionSelected(index: i)
                            } label: {
                                Text(texts[i])
                                    .foregroundColor(.black)
                                    .padding(.bottom, 16)
                                    .lineLimit(<#T##number: Int?##Int?#>)
                            }.background(Color.blue)
                        }
                        .background(Color.yellow)
                    }
                    Spacer()
                }.frame(height: 140)
                    .background(Color.gray)
                
            }
            
        }
    }
    
    func optionSelected(index: Int) {
        // Mexe na state machine
        // Atualiza textos
        print(index)
        
        if (texts.count == 3) {
            texts = ["0"]
        } else {
            var newTexts = texts
            newTexts.append("O CU DO CEBOLINHA É VERDE ASSIM COMO O SEU CACHORRO FLOQUINHO")
            texts = newTexts
        }
    }
}

