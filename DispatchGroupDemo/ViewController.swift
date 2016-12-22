import UIKit

class ViewController: UIViewController {

    @IBOutlet var runButton: UIButton!
    @IBOutlet var worker1Label: UILabel!
    @IBOutlet var worker2Label: UILabel!
    @IBOutlet var worker3Label: UILabel!
    @IBOutlet var overallLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func runDemo(_ sender: Any) {
        runButton.isUserInteractionEnabled = false
        
        let queue = DispatchQueue(label: "au.com.magicmobile.dispatch", attributes: .concurrent, target: .main)
        let group = DispatchGroup()
        
        overallLabel.text = "Starting workers...\n"

        let labels = [self.worker1Label, self.worker2Label, self.worker3Label]
        
        for label in labels {
            print("*** start worker")
            queue.async {
                self.worker(label!)
            }
        }
        
        group.notify(queue: DispatchQueue.main) { [unowned self] in
            self.message("All workers done\n", self.overallLabel)
            self.runButton.isUserInteractionEnabled = true
        }
    }
    
    func worker(_ label: UILabel) {
        let duration = arc4random_uniform(5)+5
        
        message("sleeping for \(duration) seconds\n", label)

        sleep(duration)
        
        message("Finished\n", label)
    }
    
    func message(_ message: String, _ label: UILabel) {
        print("Update label: \(message)")
        DispatchQueue.main.async {
            label.text = message
            print("done")
        }
    }
}

