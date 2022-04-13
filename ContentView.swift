import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var store = ContentViewStore()

    @State var narratorText: String = ""
    @State var buttonTexts: [String] = []
    
    var scene: GameScene {
        let scene = GameScene()
        scene.stateMachine = store.stateMachine
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
                    Text(narratorText)
                        .padding(.vertical, 16)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .background(Color.gray.opacity(0.7))
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                Spacer()
                
                VStack() {
                    ForEach(0..<buttonTexts.count, id: \.self) { i in
                        HStack(alignment: .top) {
                            Spacer()
                            Button {
                                optionSelected(index: i)
                            } label: {
                                Text("\(i+1). \(buttonTexts[i])")
                                    .foregroundColor(.black)
                                    .padding(.top, 16)
                                    .lineLimit(2)
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .frame(height: 150)
                .background(Color.gray.opacity(0.7))
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            }
            
        }.onAppear {
            let initialState = scene.stateMachine?.currentState
            narratorText = initialState?.phrase ?? ""
            buttonTexts = initialState?.options.map { $0.text } ?? []
        }
    }
    
    func optionSelected(index: Int) {
        let currentState = scene.stateMachine?.transition(to: index)
        narratorText = currentState?.phrase ?? ""
        buttonTexts = currentState?.options.map { $0.text } ?? []
        scene.present(currentState)
    }

}

