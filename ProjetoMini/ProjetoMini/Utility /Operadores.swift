//
//  Operadores.swift
//  ProjetoMini
//
//  Created by Luca Lacerda on 17/07/23.
//

import SpriteKit

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

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

func distance(a:CGPoint, b:CGPoint) -> CGFloat{
    let dx = pow(a.x - b.x, 2)
    let dy = pow(a.y - b.y, 2)
    let dab = sqrt(dx + dy)
    
    return dab
}

func distanceX(a:CGPoint, b:CGPoint) -> CGFloat{
    let dx = pow(a.x - b.x, 2)
    let dab = sqrt(dx)
    
    return dab
}
