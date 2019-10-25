import UIKit
class DetailViewController: UIViewController {
    @IBOutlet var textView: UITextView!
     var masterView:NotesViewController!
    var text:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    func setText(t:String) {
        text = t
        if isViewLoaded {
            textView.text = t
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
        textView.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
