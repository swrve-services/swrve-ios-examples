import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Button callback.  Changes user ID to 'User_A'
    @IBAction func initUserA(sender: UIButton) {
        NSLog("Button A Pressed")
        self.changeToUserID(userID: "User_A")
    }

    // Button callback.  Changes user ID to 'User_B'
    @IBAction func initUserB(sender: UIButton) {
        NSLog("Button B Pressed")
        self.changeToUserID(userID: "User_B")
    }
    
    // Initialize an empty SDK, no events will be sent
    @IBAction func initUserNull(sender: UIButton) {
        NSLog("Button Null Pressed")
        self.changeToUserID(userID: nil)
    }
    
    // Utility function that changes the user id and sends diagnostic events
    // to make sure events are sent correctly with the old user ID and the
    // new user ID.
    func changeToUserID(userID: String?) {
        // Save the userID in defaults to be used when the app is launched next time
        UserDefaults.standard.setValue(userID, forKey: "userID")
    
        let oldUserID = SwrveSDK.userID()
        var eventName: String
        eventName = "Changing from \(oldUserID) to \(userID)"
        SwrveSDK.event(eventName)
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.identityUtils.changeUserID(userID)
    
        eventName = "Changed to \(userID) from \(oldUserID)"
        SwrveSDK.event(eventName)
        SwrveSDK.sendQueuedEvents()
    }
    
}

