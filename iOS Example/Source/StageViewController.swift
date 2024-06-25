import UIKit





protocol VCAddingDelegate{
    
    func didVCAdded(newVC: UIViewController)
}

class StageViewController: UIViewController{
    

    var item = GlobalVariables.view_Controller_Array
    var delegate: VCAddingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = .blue
//        print("Acessing global array  in  stage view controller   b", item)
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.setTitle("Add App", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 6
        button.tintColor = UIColor.black
        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        
        // Disable the button's default autoresizing behavior
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to pin the button to the bottom of the view and center it horizontally
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //        print("view controller views -> " ,self.view.subviews)
    
    
    
    
    @objc func addButtonTapped() {
        
   
        let new = WebViewController()
        let navvc = UINavigationController(rootViewController: new)
        navvc.view.backgroundColor = .green
//        new.delegate = self
        let random = randomColor()
        new.view.backgroundColor = .white
//        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        delegate?.didVCAdded( newVC : navvc)
//        print("new vc atr stage view controller",new)
        
        

    }
    

    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0.0 ... 1.0)
        let green = CGFloat.random(in: 0.0 ... 1.0)
        let blue = CGFloat.random(in: 0.0 ... 1.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    
}
