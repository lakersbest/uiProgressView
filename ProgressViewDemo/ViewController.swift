import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var timer: Timer?

    /* 一開始顯示下載進度為0% */
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMessage.text = "0%"
    }
    
    /* 點擊Download按鈕，Progress View的進度條會開始變化，一直進展到最大值為止 */
    @IBAction func downloadClick(_ sender: Any) {
        progressView.progress = 0
        if timer == nil {
            /* 設定計時器不間斷地(repeats: true)每隔0.5秒鐘(timeInterval: 0.5)就透過現行物件(target: self)呼叫progressChanged方法(selector: #selector(progressChanged))一次 */
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(progressChanged), userInfo: nil, repeats: true)
        }
    }
    
    /* progressView的值每次增加0.1直到1為止 */
    @objc func progressChanged() {
        progressView.progress += 0.1
        /* 如果下載進度還沒到最大值就顯示下載進度；下載完成就顯示"Download Finished" */
        if (progressView.progress < 1) {
            /* 用%跳脫後面%，所以%%等於%文字。下載進度為0%~100%所以progressView的值乘以100 */
            lbMessage.text = String(format: "%.1f%%", progressView.progress * 100)
        } else {
            lbMessage.text = "下載完成"
            timer?.invalidate()
            timer = nil
        }
    }
}

