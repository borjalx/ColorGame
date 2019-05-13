//
//  MenuScene.swift
//  ColorGame
//
//  Created by Borja S on 13/05/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
        //color background
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        addLogo()
        addLabels()
    }
    
    //Función que añade el logo
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    //Función que añade los labels
    func addLabels() {
        //label para empezar a jugar
        let playLabel = SKLabelNode(text: "Tap to Start!")
        //posición
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        //modificamos la fuente y su tamaño, color
        playLabel.fontName = "HolyFat"
        playLabel.fontSize = 45.0
        playLabel.fontColor = UIColor.white
        //añadimos el label
        addChild(playLabel)
        //animamos el label
        animation(label: playLabel)
        
        //label con la máxima puntuación
        let maxScore = SKLabelNode(text: "Max. score: " + "\(UserDefaults.standard.integer(forKey: "MaxScore"))")
        //posición
        maxScore.position = CGPoint(x: frame.midX, y: frame.midY - maxScore.frame.size.height*4)
        //modificamos la fuente y su tamaño, color
        maxScore.fontName = "HolyFat"
        maxScore.fontSize = 40.0
        maxScore.fontColor = UIColor.white
        //añadimos el label
        addChild(maxScore)
        
        //label con la puntucación actual
        let actualScore = SKLabelNode(text: "Actual score:" + "\(UserDefaults.standard.integer(forKey: "ActualScore"))")
        //posición
        actualScore.position = CGPoint(x: frame.midX, y: maxScore.position.y - actualScore.frame.size.height*2)
        //modificamos la fuente y su tamaño, color
        actualScore.fontName = "HolyFat"
        actualScore.fontSize = 40.0
        actualScore.fontColor = UIColor.white
        //añadimos el label
        addChild(actualScore)
    }
    
    //Función que anima un label con efectos
    func animation(label:SKLabelNode) {
        //hacemos el texto más grande
        let scaleUP = SKAction.scale(to: 1.1, duration: 0.6)
        //hacemos el texo más pequeño - vuelta estado normal
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.6)
        //creamos sequence con las SKActions
        let sequence = SKAction.sequence([scaleUP, scaleDown])
        //el label ejecuta las acciones
        label.run(sequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //cuando el suuario toque la pantalla cambiamos la escena al juego
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
