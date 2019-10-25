import UIKit
class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    var data:[String] = []
    var selectedRow:Int = -1
    var newRowText:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        self.title = "Notes"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
               self.navigationItem.largeTitleDisplayMode = .always
        } else {
        }
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        load()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (selectedRow == -1 ||  data == []){
            return
        }else{
            print(selectedRow)
            print(data)
        data[selectedRow] = newRowText
        if newRowText == "" {
            data.remove(at: selectedRow)
        }
        table.reloadData()
        save()
    }
    }
    @objc func addNote() {
        if table.isEditing {
            return
        }
        let name:String = ""
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let txt = data[indexPath.row]
        let lines = txt.components(separatedBy: "\n")
        print(lines)
        for y in lines{
            if(y.isEmpty != true){
                cell.textLabel?.text = y
                break
            }
        }
        return cell
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailViewController = segue.destination as! DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: data[selectedRow])
    }
    func save() {
        UserDefaults.standard.set(data, forKey: "notes")
    }
    func load() {
        if let loadedData:[String] = UserDefaults.standard.value(forKey: "notes") as? [String] {
            data = loadedData
            table.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
