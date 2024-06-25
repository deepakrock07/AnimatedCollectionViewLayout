//
//  ZoomInOutAttributesAnimator.swift
//  AnimatedCollectionViewLayout


import UIKit
//import  iOS_Example.Sources.globalArray

//class Scrolling {
//    static var isScroll :Bool = false
//}


public protocol ScrollingState {
    func getBool() -> Bool
    func setBool(_ value: Bool)
}

/// An animator that zoom in/out cells when you scroll.
public struct ZoomInOutAttributesAnimator: LayoutAttributesAnimator {
    /// The scaleRate decides the maximum scale rate where 0 means no scale and
    /// 1 means the cell will disappear at min. 0.2 by default.
    public var scaleRate: CGFloat
    
    
    public   var sdelegate: ScrollingState?
    
    
    //        for condition 2
    public var minAlpha: CGFloat
    public var itemSpacing: CGFloat
    public var scaleRate2: CGFloat
    //    var isScrollnow = Scrolling.isScroll
    
    
    
    public init(minAlpha: CGFloat = 0.5, itemSpacing: CGFloat = 0.3, scaleRate2: CGFloat = 0.7,scaleRate: CGFloat = 0.4) {
        self.minAlpha = minAlpha
        self.itemSpacing = itemSpacing
        self.scaleRate = scaleRate
        self.scaleRate2 = scaleRate2
    }
    
    
    public func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
        let position = attributes.middleOffset
        print()
        print()
        print("position",position)
        
        let translationTransform: CGAffineTransform
        let scaleTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        print("start offset",attributes.startOffset)
        
        print("attributes.indexPath",attributes.indexPath)
        
        
             
      
        
        if self.sdelegate?.getBool() == false {
            
            ///        for left swipe
            if collectionView.panGestureRecognizer.velocity(in: collectionView.superview).x <= 0 {
                print("left swipe")
                if position == 0{
                    attributes.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                if (position > 0 && position < 1) {
                    print(" entered")
                    attributes.transform = CGAffineTransform(scaleX: 1, y: 0.6892281594571671)
                    //                isScroll = true

                }
                else   if position <= 0 && position > -1 {
                    let scaleFactor = scaleRate * position + 1.0
                    print("scaleFactor",scaleFactor)

                    if scaleFactor <= 0.8{
                        //                    make bool true
                        self.sdelegate?.setBool(true)
                        print("hope->",scaleFactor)
                    }

                    attributes.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

                }
                else {
                    print("cameout")
                    attributes.transform = .identity
                    //identity return no transformation
                }

            }
            ////        for right swip
            else if collectionView.panGestureRecognizer.velocity(in: collectionView.superview).x >= 0  {
                print("right swipe")
                if  position == 0{
                   attributes.transform = CGAffineTransform(scaleX: 1, y: 1)
               }
                if (position > -1 && position < 0) {
                    print(" entered")
                    attributes.transform = CGAffineTransform(scaleX: 1, y: 0.6892281594571671)
                    //                isScroll = true

                }
                else if (position > 0 && position < 1 ){
                    let scaleFactor = scaleRate * (-(position)) + 1.0
                    print("scaleFactor right",scaleFactor)

                    if scaleFactor <= 0.8{
                        //                    make bool true
                        self.sdelegate?.setBool(true)
                        print("hope->",scaleFactor)
                    }

                    attributes.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

                }else {
                    print("cameout")
                    attributes.transform = .identity
                    //identity return no transformation
                }
            }
            
            
        }

        else if ((self.sdelegate?.getBool()) != nil) {
            print("oooooo")
            
            
            let width = collectionView.frame.width
            let translationX = -(width * itemSpacing * position)
            
            print("translationX",translationX)
            translationTransform = CGAffineTransform(translationX: translationX, y: 0)
            
            attributes.alpha = 1.0
            attributes.transform = translationTransform.concatenating(scaleTransform)
            
        }
        
        
        
        
    }
    
}

