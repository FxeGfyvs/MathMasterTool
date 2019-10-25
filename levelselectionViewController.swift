import UIKit
class levelselectionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func Buttonpressed(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "index")
        self.performSegue(withIdentifier: "hi", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
