//
//  GameScene.swift
//  ColorGame
//
//  Created by Borja S on 12/05/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import SpriteKit


//diferentes colores
enum PlayColors {
    static let colors = [
        UIColor(red: 255/255, green: 61/255, blue: 61/255, alpha: 1.0),
        UIColor(red: 255/255, green: 218/255, blue: 0/255, alpha: 1.0),
        UIColor(red: 43/255, green: 123/255, blue: 205/255, alpha: 1.0),
        UIColor(red: 0/255, green: 199/255, blue: 74/255, alpha: 1.0),
    ]
}

//diferentes estados de la rueda de colores
enum SwitchState: Int {
    case red, yellow, blue, green
}
class GameScene: SKScene {
    
    //bola de colores
    var colorSwtich: SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    
    override func didMove(to view: SKView) {
        
        layoutScene()
        setupPhysics()
        
    }
    
    //Función que configura las físicas
    func setupPhysics(){
        //reducimos la gravedad
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        physicsWorld.contactDelegate = self
    }
    
    //función que carga los layouts del juego
    func layoutScene() {
        //cambiar color background
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        //le damos imagen del colorSwitch
        colorSwtich = SKSpriteNode(imageNamed: "colorcircle")
        //tamaño del nodo
        colorSwtich.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        //posición del nodo
        colorSwtich.position = CGPoint(x: frame.midX, y: frame.minY + colorSwtich.size.height)
        //añadimos físicas al colorSwitch
        colorSwtich.physicsBody = SKPhysicsBody(circleOfRadius: colorSwtich.size.width/2)
        colorSwtich.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        //no le afecte ninguna fuerza
        colorSwtich.physicsBody?.isDynamic = false
        //añadimos el nodo
        addChild(colorSwtich)
        
        //creamos la bola
        createBall()
    }
    
    //Función que crea la bola
    func createBall() {
        //número random al color de la bola
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        //le asociamos el SKSpriteNode, color y tamaño
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        //nos aseguramos que pilla el color de la bola
        ball.colorBlendFactor = 1.0
        //nombre
        ball.name = "Ball"
        //le damos la posición
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height)
        //añadimos físicas a la bola
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    
    //función que hace rotar los colores
    func roundWheel(){
        //comprobamos si tiene más estados disponibles
        if let newState = SwitchState(rawValue: switchState.rawValue+1){
            switchState = newState
        }else{
            //en caso contrario volvemos a empezar
            switchState = .red
        }
        
        colorSwtich.run(SKAction.rotate(byAngle: .pi / 2, duration: 0.25))
    }
    
    //función de partida finalizada
    func gameOver(){
        print("Game Over")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        roundWheel()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //comprobamos el contacto
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            //contacto entre la bola y el colorSwitch
            //comprobamos que body es la bola
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                //comprobamos si la bola y la rueda son del mismo color
                if currentColorIndex == switchState.rawValue {
                    print("Correct!")
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.createBall()
                    })
                } else {
                    gameOver()
                }
            }
            
        }
    }
}
