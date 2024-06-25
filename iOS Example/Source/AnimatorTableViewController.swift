//
//  AnimatorTableViewController.swift
//  iOS Example
//
//  Created by Jin Wang on 8/2/17.
//  Copyright © 2017 Uthoft. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class AnimatorTableViewController: UITableViewController {
    
    /// animator, clipToBounds, row, column
    private let animators: [(LayoutAttributesAnimator, Bool, Int, Int)] = [
        (ParallaxAttributesAnimator(), true, 1, 1),
        (ZoomInOutAttributesAnimator(), true, 1, 1),
        (RotateInOutAttributesAnimator(), true, 1, 1),
        (LinearCardAttributesAnimator(), false, 1, 1),
        (CubeAttributesAnimator(), true, 1, 1),
        (CrossFadeAttributesAnimator(), true, 1, 1),
        (PageAttributesAnimator(), true, 1, 1),
        (SnapInAttributesAnimator(), true, 2, 4)]
    
//    The benefit of using weak is to avoid memory leaks in your code
    @IBOutlet weak var isHorizontalScrollToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
//    Segues are used to define the flow of your app's interface.
//    This method is used to prepare data to be passed to the destination view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? ImageCollectionViewController, let indexPath = sender as? IndexPath {
//            print("dist",dist)
//            print("animators",animators)
//            print("animators[indexPath]",indexPath)
//            print("animators[indexPath.row]",animators[indexPath.row])
            dist.animator = animators[indexPath.row]
            dist.direction = isHorizontalScrollToggle.isOn ? .horizontal : .vertical
        }
    }
    

    
    // MARK: - TableView Delegate and DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animators.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        c.textLabel?.font = UIFont.systemFont(ofSize: 12)
//        print("animators[indexPath.row]",animators[indexPath.row].0)
        c.textLabel?.text = "\(animators[indexPath.row].0.self)"
        
        return c
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowCollectionViewController", sender: indexPath)
    }
}
