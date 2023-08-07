//
//  Operadores.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 17/07/23.
//
//  Essa file declara operadores e funcoes utilizadas mem cálculos do projeto

import SpriteKit

//Operadores para operacoes com CGPoint
func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

//Extension do tipo CGPoint com, uma funcao normaliza o vetor e outra retorna o seu comprimento
extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

//Essa funcao calcula a distancia entre dois pontos
func distance(a:CGPoint, b:CGPoint) -> CGFloat{
    let dx = pow(a.x - b.x, 2)
    let dy = pow(a.y - b.y, 2)
    let dab = sqrt(dx + dy)
    
    return dab
}

//Essa calcula a distancia X entre dois pontos
func distanceX(a:CGPoint, b:CGPoint) -> CGFloat{
    let dx = pow(a.x - b.x, 2)
    let dab = sqrt(dx)
    
    return dab
}
