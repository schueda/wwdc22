import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else { return GameScene()}
        scene.stateMachine = StateMachine()
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
    
