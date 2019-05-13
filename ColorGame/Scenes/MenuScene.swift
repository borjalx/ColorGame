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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
