//import Foundation
import UIKit


//public protocol LayoutAttributesAnimator {
//    func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes)
//}

/// A `UICollectionViewFlowLayout` subclass enables custom transitions between cells.
/// A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid.
open class AnimatedCollectionViewLayout: UICollectionViewFlowLayout {
    
    /// The animator that would actually handle the transitions.
    open var animator: LayoutAttributesAnimator?
    
    
    /// Overrided so that we can store extra information in the layout attributes.
    open override class var layoutAttributesClass: AnyClass { return AnimatedCollectionViewLayoutAttributes.self }
    
    
///    layoutAttributesForElements(in:)
///   Retrieves the layout attributes for all of the cells and views in the specified rectangle.
///   CRRect-The rectangle (specified in the collection view’s coordinate system) containing the target views.
///   return val-An array of UICollectionViewLayoutAttributes objects representing the layout information for the cells and views. The default implementation returns nil.
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
///        {
//            attributes.compactMap { $0.copy() as? AnimatedCollectionViewLayoutAttributes }: This line uses the compactMap method to iterate over each layout attribute returned by the superclass method, copy it, and try to cast it as an instance of AnimatedCollectionViewLayoutAttributes. The compactMap method returns an array of non-nil results of the transformation closure.
 ///       }
        ///
//        print("cgrect and poUICollectionViewLayoutAttributes",UICollectionViewLayoutAttributes())
        return attributes.compactMap { $0.copy() as? AnimatedCollectionViewLayoutAttributes }.map { self.transformLayoutAttributes($0) }
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // We have to return true here so that the layout attributes would be recalculated
        // everytime we scroll the collection view.
        return true
    }
    
    private func transformLayoutAttributes(_ attributes: AnimatedCollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let a = attributes
        
        /** 
         The position for each cell is defined as the ratio of the distance between
         the center of the cell and the center of the collectionView and the collectionView width/height
         depending on the scroll direction. It can be negative if the cell is, for instance,
         on the left of the screen if you're scrolling horizontally.
         */
        
        let distance: CGFloat
        let itemOffset: CGFloat
        
        print("frame of collection view ->", collectionView.frame)
        print("frame of collectionView.contentOffset.x ->", collectionView.contentOffset.x)
        print("a frame", a.frame, " & a.center--->",a.center, " & a.center.x",a.center.x)
        if scrollDirection == .horizontal {
            
            distance = collectionView.frame.width
            print("distance ",distance)
            
            
            itemOffset = a.center.x - collectionView.contentOffset.x
            print(" itemOffset(psn of cell wrt to colln view ",itemOffset)
            
            
            
            a.startOffset = (a.frame.origin.x - collectionView.contentOffset.x) / a.frame.width
            print("a.startOffset ",a.startOffset)
            
            
            
            a.endOffset = (a.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / a.frame.width
            print("a.endOffset ",a.endOffset)
        } else {
            distance = collectionView.frame.height
            itemOffset = a.center.y - collectionView.contentOffset.y
            a.startOffset = (a.frame.origin.y - collectionView.contentOffset.y) / a.frame.height
            a.endOffset = (a.frame.origin.y - collectionView.contentOffset.y - collectionView.frame.height) / a.frame.height
        }
        
        a.scrollDirection = scrollDirection
        a.middleOffset = itemOffset / distance - 0.5
        
        print("a.middleOffset ->",a.middleOffset)
        
        // Cache the contentView since we're going to use it a lot.
        if a.contentView == nil,
            let c = collectionView.cellForItem(at: attributes.indexPath)?.contentView {
            a.contentView = c
        }
        
        animator?.animate(collectionView: collectionView, attributes: a)
        
        return a
    }
}

/// A custom layout attributes that contains extra information.
/// Layout objects create instances of this class when asked to do so by the collection view. In turn, the collection view uses the layout information to position cells and supplementary views inside its bounds.
open class AnimatedCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    public var contentView: UIView?
    public var scrollDirection: UICollectionView.ScrollDirection = .vertical
    
    /// The ratio of the distance between the start of the cell and the start of the collectionView and the height/width of the cell depending on the scrollDirection. It's 0 when the start of the cell aligns the start of the collectionView. It gets positive when the cell moves towards the scrolling direction (right/down) while getting negative when moves opposite.
    public var startOffset: CGFloat = 0
    
    /// The ratio of the distance between the center of the cell and the center of the collectionView and the height/width of the cell depending on the scrollDirection. It's 0 when the center of the cell aligns the center of the collectionView. It gets positive when the cell moves towards the scrolling direction (right/down) while getting negative when moves opposite.
    public var middleOffset: CGFloat = 0
    
    /// The ratio of the distance between the **start** of the cell and the end of the collectionView and the height/width of the cell depending on the scrollDirection. It's 0 when the **start** of the cell aligns the end of the collectionView. It gets positive when the cell moves towards the scrolling direction (right/down) while getting negative when moves opposite.
    public var endOffset: CGFloat = 0
    
    
//    NSCopying
//    A protocol that objects adopt to provide functional copies of themselves.
    
//    {
//
//        In most cases, you use this class as-is. If you want to supplement the base layout attributes with custom layout attributes, you can subclass and define whatever properties you want to store the additional layout data. Because layout attribute objects may be copied by the collection view, make sure your subclass conforms to the NSCopying protocol by implementing any methods appropriate for copying your custom attributes to new instances of your subclass. In addition to defining your subclass, your UICollectionReusableView objects need to implement the apply(_:) method so that they can apply any custom attributes at layout time.
//}
//    NSCollectionViewLayoutAttributes
//    An object that contains layout-related attributes for an element in a collection view.
//    Returns a new instance that’s a copy of the receiver.
    open override func copy(with zone: NSZone? = nil) -> Any {
        
// NSCopying declares one method, copy(with:), but copying is commonly invoked with the convenience method copy().
        let copy = super.copy(with: zone) as! AnimatedCollectionViewLayoutAttributes
        copy.contentView = contentView
        copy.scrollDirection = scrollDirection
        copy.startOffset = startOffset
        copy.middleOffset = middleOffset
        copy.endOffset = endOffset
        return copy
    }
    
//    Override the inherited isEqual(_:) method to perform any relevant equality checks.
    open override func isEqual(_ object: Any?) -> Bool {
        guard let o = object as? AnimatedCollectionViewLayoutAttributes else { return false }
        
        return super.isEqual(o)
            && o.contentView == contentView
            && o.scrollDirection == scrollDirection
            && o.startOffset == startOffset
            && o.middleOffset == middleOffset
            && o.endOffset == endOffset
    }
}
