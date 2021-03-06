import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var store = ContentViewStore()

    @State var narratorText: String = ""
    @State var buttonTexts: [String] = []
    @State var isShowingText: Bool = true
    
    var scene: GameScene {
        let scene = store.scene
        scene.stateMachine = store.stateMachine
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .disabled(true)
            
            VStack {
                if isShowingText {
                    HStack {
                        Text(narratorText)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.init(uiColor: .appWhite))
                            .font(.custom("Kenney-Mini", size: 40))
                        Spacer()
                    }
                    .background(Color.init(uiColor: .appBlack).opacity(0.9))
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                }
                
                Spacer()
                
                VStack() {
                    ForEach(0..<buttonTexts.count, id: \.self) { i in
                        HStack(alignment: .top) {
                            Button {
                                optionSelected(index: i)
                            } label: {
                                Text("\(i+1). \(buttonTexts[i])")
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color.init(uiColor: .appWhite))
                                    .font(.custom("Kenney-Mini", size: 30))
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .frame(height: 150)
                .background(Color.init(uiColor: .appBlack).opacity(0.9))
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
        guard let currentState = scene.stateMachine?.transition(to: index) else { return }
        isShowingText = false
        buttonTexts = []
        narratorText = ""
        
        scene.present(currentState) {
            if !(currentState.phrase.isEmpty) {
                isShowingText = true
                var count = 0
                var auxString = ""
                _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true){ t in
                    if !(count < currentState.phrase.count - 1) {
                        t.invalidate()
                        writeButtonTexts(currentState)
                    }
                    auxString += "\(currentState.phrase[count])"
                    narratorText = auxString
                    count += 1
                }
            } else {
                writeButtonTexts(currentState)                
            }
        }
    }
    
    func writeButtonTexts(_ state: StateMachineSymbol) {
        buttonTexts = state.options.map { $0.text }
    }

}
