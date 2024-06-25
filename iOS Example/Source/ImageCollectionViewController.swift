

import UIKit
import AnimatedCollectionViewLayout
//import An





extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class ImageCollectionViewController: UICollectionViewController,VCAddingDelegate,enableScrolling_delegate,ScrollingState,removeVc{
  
  
    
  
    
    
    @IBOutlet var dismissGesture: UISwipeGestureRecognizer!
    
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?

    var direction: UICollectionView.ScrollDirection = .horizontal
    
    
    let cellIdentifier = "SimpleCollectionViewCell"
    let vcs = [("f44336", "nature1"),
               ("9c27b0", "nature2"),
               ("3f51b5", "nature3"),
               ("03a9f4", "animal1"),
               ("009688", "animal2"),
               ("8bc34a", "animal3"),
               ("FFEB3B", "nature1"),
               ("FF9800", "nature2"),
               ("795548", "nature3"),
               ("607D8B", "animal1")]
    
    var item = GlobalVariables.view_Controller_Array
    
    var webViewController: WebViewController?
    
   public var isScroll: Bool = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Turn on the paging mode for auto snaping support.
        collectionView?.isPagingEnabled = true
        self.view.backgroundColor = .green
        collectionView.backgroundColor = .yellow
        
        
        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
//            layout.animator = animator?.0
            
            var  animator = ZoomInOutAttributesAnimator()
            animator.sdelegate = self
            layout.animator = animator
        }
        
        dismissGesture.direction = direction == .horizontal ? .down : .left
        
        
        let stage_vc = StageViewController()
        item.append(stage_vc)
        stage_vc.delegate = self
        
        // Create an instance of WebViewController and set its edelegate to self
//                let webViewController = WebViewController()
        WebViewController.edelegate = self
        SimpleCollectionViewCell.Ddelegate = self
//                self.webViewController = webViewController
//        (animator?.0 as?  ZoomInOutAttributesAnimator)?.sdelegate = self
        
//        print("GlobalVariables.view_Controller_Array",item)
    }

    func showingCurrent (with curr : UIViewController){
//        print("printing navigation controller",navigationController)
        navigationController?.pushViewController(curr, animated: true)
    }
    
    
    func setEnableScrolling(set: Bool) {
//        print("seting nabling")
        collectionView.scrollToItem(at: [0,0], at: .left, animated: false)
    collectionView.isScrollEnabled = set
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reloadData() {
            collectionView.reloadData()
        }
    func didVCAdded(newVC: UIViewController) {
        item.append(newVC)
//        reloadData()
        
        
        if let index = item.firstIndex(of: newVC){
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.insertItems(at: [indexPath])
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
        }else{
            print("index not found in array")
        }
        collectionView.isScrollEnabled = false
        
    }
    
    func didVcRemoved(with delvc: Int) {
        
        print("delvc",delvc)
        
      
            item.remove(at: delvc)
            collectionView.deleteItems(at: [IndexPath(item: delvc, section: 0)])
 
            reloadData()
            print("removed index", delvc)
        
        
        print("item: ", item)
        
        //        if let vc = delvc.parent,
        //            let index = item.firstIndex(of: vc){
        //            item.remove(at: index)
        //
        //            collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        //
        //            reloadData()
        //            print("removed index", index)
        //
        ////            let indexPath = IndexPath(item: index - 1, section: 0)
        ////            collectionView.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)
        //        }else{
        //            print("index not found in array")
        //        }


    }
    
    func getBool() -> Bool {
        return isScroll
    }
    
    func setBool(_ value: Bool) {
        isScroll = value
        collectionView.reloadData()
        print("value", value)
    }
    
    @IBAction func didSwipeDown(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
  

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle the selection of the item at indexPath
        print("Selected item at indexPath: \(indexPath)")
        
        if getBool() {
            
            setBool(false)
            print("ontap")
                    reloadData()
//            collectionView.isScrollEnabled = false
            

        }
        //        setBool(true)
            }
    
}









extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        
        
        if let cell = c as? SimpleCollectionViewCell {
            
//            cell.bind(color: v.0, imageName: v.1)
//            ask
            cell.clipsToBounds = animator?.1 ?? true
//            cell.backgroundColor = .black
//            cell.awakeFromNib(parentViewController: self)
//            print("vc at cell making",item[indexPath.item])
            cell.configureCell(with: item[indexPath.item], gettingbool: getBool(), idx: indexPath.item)
          
        }
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return view.bounds.size }
//        print("animator-->",animator," & animator.2->>",animator.2," & animator.3",animator.3)
        return CGSize(width: view.bounds.width / CGFloat(animator.2), height: view.bounds.height / CGFloat(animator.3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    

    }
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        print("fighting too muchh")
//        let vc = WebViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }





extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let nextResponder = parentResponder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
        return nil
    }
}
