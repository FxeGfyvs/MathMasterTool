import UIKit
import AVKit
class resultViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = UserDefaults.standard.string(forKey: "Name")
        print(name ?? "error")
        self.title = name
        if(isKeyPresentInUserDefaults(key:"isfirstime") != true){
            UserDefaults.standard.set(true, forKey: "isfirstime")
        showAlert()
        }
        if let url = Bundle.main.url(forResource: name, withExtension: ".html",subdirectory: name) {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            webView.scalesPageToFit = true
            webView.scrollView.setZoomScale(-10, animated: true)
            let pdfVC = self
            pdfVC.view.addSubview(webView)
            pdfVC.title = name
            webView.delegate = self
            webView.dataDetectorTypes.remove(UIDataDetectorTypes.all)
        }else{
            if let pdfURL = Bundle.main.url(forResource: name,withExtension: ".pdf")  {
                let webView = UIWebView(frame: self.view.frame)
                         let urlRequest = URLRequest(url: pdfURL)
                do {
                         webView.loadRequest(urlRequest as URLRequest)
                         webView.scalesPageToFit = true
                         webView.scrollView.setZoomScale(-10, animated: true)
                         let pdfVC = self
                         pdfVC.view.addSubview(webView)
                         pdfVC.title = name
                         webView.delegate = self
                         webView.dataDetectorTypes.remove(UIDataDetectorTypes.all)
                }
                catch
                {
                }
            }else
            {
            print("error")
            print(Bundle.main.url(forResource: name, withExtension: "pdf") ?? "Error parsing url")
            alert(message: "Error", title: "File not found")
            }
        }
    }
    func showAlert() {
        let alert = UIAlertController(title: "Tip", message: "Double tap to zoom in", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.startAnimating()
    }
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool
    {
        if navigationType == .linkClicked
        {
          print(request)
            return  false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
