import Foundation
import UIKit


protocol removeVc: AnyObject {
    func didVcRemoved(with delc : Int)
}

class SimpleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var childViewController: UIViewController?
    
    static var Ddelegate: removeVc?
    
    //    {
    //    The awakeFromNib() method is a part of the UIView lifecycle and is called when the view is created and initialized from the storyboard or nib file.
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    ////         The purpose of this method is to set the background color of the view to clear, which means that the view will have a transparent background.
    //        backgroundColor = .clear
    //    }
    
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    //    func awakeFromNib(parentViewController: UIViewController) {
    //
    //        // Create a container view to hold the child view controller's view
    //        let containerView = UIView(frame: contentView.bounds)
    //        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //        contentView.addSubview(containerView)
    //
    //        // Create and add the child view controller
    //        let childVC = StageViewController()
    //        parentViewController.addChild(childVC)
    //        childVC.view.frame = containerView.bounds
    //        containerView.addSubview(childVC.view)
    //        childVC.didMove(toParent: parentViewController)
    //        self.childViewController = childVC
    //        // ...
    //    }
    
//    func bind(color: String, imageName: String) {
//        contentView.backgroundColor = color.hexColor
//        titleLabel.text = "\(arc4random_uniform(1000))"
//    }
    
    
    func configureCell(with vc: UIViewController, gettingbool : Bool, idx : Int) {
        
        
        print("gettingbool",gettingbool, idx)
        
        //backbutton
       
        self.index = idx
        
        if gettingbool {
            
            let backButton = UIButton(type: .system)
            backButton.setTitle("Back", for: .normal)
            //        backButton.addTarget(vc, action: #selector(""), for: .touchUpInside)
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            addSubview(backButton)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,  constant: 20),
                backButton.widthAnchor.constraint(equalToConstant: 50),
                backButton.heightAnchor.constraint(equalToConstant: 30),
            ])
            //
            //         Add title label
            let titleLabel = UILabel()
            titleLabel.text = "Google"
            titleLabel.font = UIFont.systemFont(ofSize: 18)
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: 100),
                            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            ])
            
            let closeButton = UIButton(type: .system)
            closeButton.setTitle("Close", for: .normal)
            closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
            addSubview(closeButton)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                closeButton.topAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: 10),
                closeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                contentView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: 40),
                closeButton.widthAnchor.constraint(equalToConstant: 80),
                            closeButton.heightAnchor.constraint(equalToConstant: 50),
            ])
            
            addSubview(vc.view)
            vc.view.frame = contentView.bounds
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
                vc.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                
            ])
            
            
            
           
            //        }
        }else {
            addSubview(vc.view)
            vc.view.frame = contentView.bounds
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                vc.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                vc.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
            ])
        }
        
        //

        
        
    }
    @objc func closeButtonPressed() {
        print("close button tapped ",self)
        
        
        SimpleCollectionViewCell.Ddelegate?.didVcRemoved(with: self.index )
    }
    
  

}


