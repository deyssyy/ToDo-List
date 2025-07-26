import UIKit
class EditNoteViewController: UIViewController{
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var editNoteTextView: UITextView!
    weak var delegate: AddNoteDelegate?
    var name: String?
    var note: String?
    var index: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(note)
        print(name)
        print(index)
        nameTextView.text = name
        editNoteTextView.text = note
    }
    
}
