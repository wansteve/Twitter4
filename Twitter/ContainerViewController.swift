//
//  ContainerViewController.swift
//  Twitter
//
//  Created by Steve Wan on 5/30/15.
//  Copyright (c) 2015 Steve Wan. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case MenuCollapsed
    case LeftMenuExpanded
}

class ContainerViewController: UIViewController, CenterViewControllerDelegate, LeftMenuViewControllerDelegate , UIGestureRecognizerDelegate {

    /* Probably don't need this anymore
    private var viewControllerArray: [UIViewController] = [
        OrangeViewController(nibName: "OrangeViewController", bundle: nil),
        SingleTweetViewController(nibName: "SingleTweetViewController", bundle: nil)]
*/
    
    /*
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let viewController = storyboard.instantiateViewControllerWithIdentifier("IdentifierThatWasSetInStoryboard") as MyViewControllerClass
    
    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! UIViewController
    window?.rootViewController = vc


*/

    var tweetsViewController: TweetsViewController!
    var composeViewController: ComposeViewController!
    var leftMenuViewController: LeftMenuViewController?
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var profileViewController: ProfileViewController!

    
    let twitterBlue: UIColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1.0)
    
    var currentState: SlideOutState = .MenuCollapsed {
        didSet {
            let shouldShowShadow = currentState != .MenuCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    let centerPanelExpandedOffset: CGFloat = 80
    
    // delegate of leftmenu
    //   let menuItems: NSArray = ["Timeline", "Profile", "Compose Tweet", "Settings"]
    func cellSelected(menuItem: NSString){
        println("\(menuItem)")
        switch(menuItem){
        case "Timeline":
//            tweetsViewController.navItem.title = "Timeline"
//            tweetsViewController.loadTweets()
//            setCenterNavigationController(tweetsViewController)
            
            if centerViewController != nil {
                centerViewController!.view.removeFromSuperview()
                centerViewController = nil;
            }
            // centerViewController = tweetsViewController as! CenterViewController
            // centerViewController.delegate = self
            centerNavigationController = UINavigationController(rootViewController: tweetsViewController)
            centerNavigationController.navigationBar.barTintColor = twitterBlue
            centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
            centerNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            centerNavigationController.navigationBar.translucent = false
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            centerNavigationController.didMoveToParentViewController(self)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
            centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
            
            
        case "Mentions":
//            timelineViewController.navItem.title = "Mentions"
//            timelineViewController.loadTweets()
//            setCenterNavigationController(tweetsViewController)
            
            
            if centerViewController != nil {
                centerViewController!.view.removeFromSuperview()
                centerViewController = nil;
            }
            // centerViewController = tweetsViewController as! CenterViewController
            // centerViewController.delegate = self
            centerNavigationController = UINavigationController(rootViewController: tweetsViewController)
            centerNavigationController.navigationBar.barTintColor = twitterBlue
            centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
            centerNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            centerNavigationController.navigationBar.translucent = false
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            centerNavigationController.didMoveToParentViewController(self)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
            centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
            
            
            
        case "Compose Tweet":
 //           setCenterNavigationController(composeViewController)
            
            
            if centerViewController != nil {
                centerViewController!.view.removeFromSuperview()
                centerViewController = nil;
            }
            // centerViewController = tweetsViewController as! CenterViewController
            // centerViewController.delegate = self
            centerNavigationController = UINavigationController(rootViewController: composeViewController)
            centerNavigationController.navigationBar.barTintColor = twitterBlue
            centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
            centerNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            centerNavigationController.navigationBar.translucent = false
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            centerNavigationController.didMoveToParentViewController(self)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
            centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
            
            
            
        case "Profile":
            let profileVCtypecast = profileViewController as ProfileViewController
            profileVCtypecast.user = User.currentUser
//            setCenterNavigationController(profileViewController)
            
            
            if centerViewController != nil {
                centerViewController!.view.removeFromSuperview()
                centerViewController = nil;
            }
            // centerViewController = tweetsViewController as! CenterViewController
            // centerViewController.delegate = self
            println("Profile View Controller is \(profileViewController)")
            centerNavigationController = UINavigationController(rootViewController: profileViewController)
            centerNavigationController.navigationBar.barTintColor = twitterBlue
            centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
            centerNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            centerNavigationController.navigationBar.translucent = false
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            centerNavigationController.didMoveToParentViewController(self)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
            centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
            
            
            
        case "Log Out":
            User.currentUser?.logout()
        default:
            break
        }
        collapseSidePanels()
    }

    /*
    func setCenterNavigationController(controller: CenterViewController){
        if centerViewController != nil {
            centerViewController!.view.removeFromSuperview()
            centerViewController = nil;
        }
        centerViewController = controller
        // centerViewController.delegate = self
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        centerNavigationController.navigationBar.barTintColor = twitterBlue
        centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
        centerNavigationController.navigationBar.translucent = false
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
    }
*/
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var activeViewContainer: UIView!
    
    
    @IBAction func onTapTweets(sender: AnyObject) {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! UIViewController
//        var vc = storyboard.instantiateViewControllerWithIdentifier("ComposeViewController") as! UIViewController
        activeViewController = vc
    }

    
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }

    
    /* FIXED
    required init(coder aDecoder: NSCoder) { // this calls app delegate causes problem
    super.init(nibName: "MenuViewController", bundle: nil)
    }
    */

    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if isViewLoaded() {
            if let inActiveVC = inactiveViewController {
                inActiveVC.willMoveToParentViewController(nil)
                inActiveVC.view.removeFromSuperview()
                inActiveVC.removeFromParentViewController()
            }
        }
    }
    
    private func updateActiveViewController() {
        println("updateActiveViewController is called")
        if isViewLoaded() {
            if let activeVC = activeViewController {
                addChildViewController(activeVC)
                activeVC.view.frame = activeViewContainer.bounds
                activeViewContainer.addSubview(activeVC.view)
                navItem.title = activeVC.title
                activeVC.didMoveToParentViewController(self)
            }
        }
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("container view loaded")
        composeViewController = UIStoryboard.composeController()
        tweetsViewController = UIStoryboard.tweetsController()
        profileViewController = UIStoryboard.profileViewController()

        
        println("Fixed: need to add back setCenterNavigationController")
        /* This works
        // setCenterNavigationController(timelineViewController)
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("CenterViewController") as! UIViewController
        //activeViewController = vc

        // activeViewController = viewControllerArray[1]
        updateActiveViewController()

        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        // panGestureRecognizer.cancelsTouchesInView = false // always commented out
        
        centerNavigationController = UINavigationController(rootViewController: activeViewController!)
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        */
        
        
        if centerViewController != nil {
            centerViewController!.view.removeFromSuperview()
            centerViewController = nil;
        }
        // centerViewController = tweetsViewController as! CenterViewController
        // centerViewController.delegate = self
        centerNavigationController = UINavigationController(rootViewController: tweetsViewController)
        centerNavigationController.navigationBar.barTintColor = twitterBlue
        centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
        centerNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        centerNavigationController.navigationBar.translucent = false
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 /* add Hamburger menu code */
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftMenuExpanded)
        
        if notAlreadyExpanded {
            addLeftMenuViewController()
        }
        
        animateLeftMenu(shouldExpand: notAlreadyExpanded)
    }
    
    
    func collapseSidePanels() {
        switch (currentState) {
        case .LeftMenuExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func addLeftMenuViewController() {
        if (leftMenuViewController == nil) {
            leftMenuViewController = UIStoryboard.leftMenuViewController()! as LeftMenuViewController
            leftMenuViewController?.delegate = self //centerViewController
            println("left menu delegate: \(leftMenuViewController?.delegate)")
            view.insertSubview(leftMenuViewController!.view, atIndex: 0)
            addChildViewController(leftMenuViewController!)
            leftMenuViewController!.didMoveToParentViewController(self)
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func snapToRight(){
        // animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame))
        animateCenterPanelXPosition(targetPosition: 0) { _ in
            self.currentState = .MenuCollapsed
        }
    }
    
    
    func animateLeftMenu(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftMenuExpanded
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .MenuCollapsed
                self.leftMenuViewController!.view.removeFromSuperview()
                self.leftMenuViewController = nil;
            }
        }
    }
    
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        // we can determine whether the user is revealing the left or right
        // panel by looking at the velocity of the gesture
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        println("inside handlePanGesture")
        switch(recognizer.state) {
        case .Began:
            if (currentState == .MenuCollapsed) {
                // If the user starts panning, and neither panel is visible
                // then show the correct panel based on the pan direction
                
                if (gestureIsDraggingFromLeftToRight) {
                    addLeftMenuViewController()
                } else {
                    snapToRight()
                }
                
                showShadowForCenterViewController(true)
            }
        case .Changed:
            // If the user is already panning, translate the center view controller's
            // view by the amount that the user has panned
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            // When the pan ends, check whether the left or right view controller is visible
            if (leftMenuViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftMenu(shouldExpand: hasMovedGreaterThanHalfway)
            } else {
                snapToRight()
            }
        default:
            break
        }
    }
}

var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! UIViewController
var vc = storyboard.instantiateViewControllerWithIdentifier("ComposeViewController") as! UIViewController

private extension UIStoryboard {
    
    class func leftMenuViewController() -> LeftMenuViewController? {
        //let storyboard = UIStoryboard(name: "LeftMenuViewController", bundle: nil)
        //return storyboard.instantiateInitialViewController() as? LeftMenuViewController
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("LeftMenuViewController") as? LeftMenuViewController
        return vc
    }
    
    class func tweetsController() -> TweetsViewController? {
        //let storyboard = UIStoryboard(name: "TweetsViewController", bundle: nil)
        //let navController = storyboard.instantiateInitialViewController() as! UINavigationController
        //return navController.topViewController as? TweetsViewController
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController
        return vc
    }
    
    class func profileViewController() -> ProfileViewController? {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController
        return vc
    }
    
    class func composeController() -> ComposeViewController? {
        //let storyboard = UIStoryboard(name: "ComposeViewController", bundle: nil)
        //let navController = storyboard.instantiateInitialViewController() as! UINavigationController
        //return navController.topViewController as? ComposeViewController
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("ComposeViewController") as? ComposeViewController
        return vc
    }
}

