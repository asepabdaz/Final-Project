
import UIKit


class CardDetailViewController: StatusBarAnimatableViewController, UIScrollViewDelegate {

    
    
    @IBOutlet weak var cardBottomToRootBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var heightTableMaterial: NSLayoutConstraint!
    @IBOutlet weak var dismisButtonOutlet: UIButton!
    @IBOutlet weak var outletShowMeHow: UIButton!
    @IBOutlet weak var outletComplate: UIButton!
    @IBOutlet weak var cardContentView: CardContentView!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var materialTabel: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var indexSelected = 0
    var cardViewModel: CardContentViewModel! {
        didSet {
            if self.cardContentView != nil {
                self.cardContentView.viewModel = cardViewModel
            }
        }
    }
    var transactionModel: TransactionModel!
    
    

    var unhighlightedCardViewModel: CardContentViewModel!

    var isFontStateHighlighted: Bool = true {
        didSet {
            cardContentView.setFontState(isHighlighted: isFontStateHighlighted)
        }
    }

    var draggingDownToDismiss = false

    final class DismissalPanGesture: UIPanGestureRecognizer {}
    final class DismissalScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer {}

    private lazy var dismissalPanGesture: DismissalPanGesture = {
        let pan = DismissalPanGesture()
        pan.maximumNumberOfTouches = 1
        return pan
    }()

    private lazy var dismissalScreenEdgePanGesture: DismissalScreenEdgePanGesture = {
        let pan = DismissalScreenEdgePanGesture()
        pan.edges = .left
        return pan
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if cardViewModel.storyBoard == "comingSoon" {
            let alertTitle = NSLocalizedString("coming_soon", comment: "")
            outletShowMeHow.isUserInteractionEnabled = false
            outletShowMeHow.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            outletShowMeHow.setTitle(alertTitle, for: .normal)
        }
        if GlobalConstants.isEnabledDebugAnimatingViews {
            scrollView.layer.borderWidth = 3
            scrollView.layer.borderColor = UIColor.green.cgColor

            scrollView.subviews.first!.layer.borderWidth = 3
            scrollView.subviews.first!.layer.borderColor = UIColor.purple.cgColor
        }

        materialTabel.delegate = self
        materialTabel.dataSource = self
        materialTabel.register(UINib(nibName: "\(MaterialTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "MaterialCell")
        
        
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        cardContentView.viewModel = cardViewModel
        textView.text = cardViewModel.description
        
        var descText: String = ""
        for desc in 0..<cardViewModel.descTable.count {
            descText.append("\n\n\(cardViewModel.descTable[desc])")
        }
        

        descriptionLabel.highlightedText = descText
        cardContentView.setFontState(isHighlighted: isFontStateHighlighted)
        transactionModel = TransactionModel(cardViewModel.primary, cardViewModel.material, 50_000, 1, cardViewModel.image)
        print("test ",cardViewModel.image)
        dismissalPanGesture.addTarget(self, action: #selector(handleDismissalPan(gesture:)))
        dismissalPanGesture.delegate = self

        dismissalScreenEdgePanGesture.addTarget(self, action: #selector(handleDismissalPan(gesture:)))
        dismissalScreenEdgePanGesture.delegate = self

        // Make drag down/scroll pan gesture waits til screen edge pan to fail first to begin
        dismissalPanGesture.require(toFail: dismissalScreenEdgePanGesture)
        scrollView.panGestureRecognizer.require(toFail: dismissalScreenEdgePanGesture)

        loadViewIfNeeded()
        view.addGestureRecognizer(dismissalPanGesture)
        view.addGestureRecognizer(dismissalScreenEdgePanGesture)
        
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func getThecComplete(_ sender: Any) {
      
        let storyBoard: UIStoryboard = UIStoryboard(name: "Keranjang", bundle: nil)
        let newController = storyBoard.instantiateViewController(identifier: "Keranjang") as? KeranjangViewController
        newController?.transactionModel = transactionModel
        
        
//        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: newController!)
        navigationController.modalPresentationCapturesStatusBarAppearance = false
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
        
    }
    @IBAction func showMeHow(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: cardViewModel.storyBoard, bundle: nil)
        let newController = storyBoard.instantiateViewController(identifier: cardViewModel.storyBoard)
        newController.modalPresentationCapturesStatusBarAppearance = false
        newController.modalPresentationStyle = .overFullScreen
        present(newController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        var tableViewHeight: CGFloat = 0;
        
        var heightTable = 0

        for _ in cardViewModel.material{
            heightTable += 55 // 50 is magic number
        }
        tableViewHeight = CGFloat(heightTable)
        heightTableMaterial.constant = tableViewHeight
        
        outletShowMeHow.layer.cornerRadius = 8
        outletComplate.layer.borderWidth = 1.5
        outletComplate.layer.cornerRadius = 8
        outletComplate.layer.borderColor = #colorLiteral(red: 0.1705375016, green: 0.3657338321, blue: 0.3284526467, alpha: 1)
        
        dismisButtonOutlet.layer.cornerRadius = dismisButtonOutlet.bounds.width / 2
    }
    

    func didSuccessfullyDragDownToDismiss() {
        cardViewModel = unhighlightedCardViewModel
        dismiss(animated: true)
    }

    func userWillCancelDissmissalByDraggingToTop(velocityY: CGFloat) {}

    func didCancelDismissalTransition() {
        // Clean up
        interactiveStartingPoint = nil
        dismissalAnimator = nil
        draggingDownToDismiss = false
    }

    var interactiveStartingPoint: CGPoint?
    var dismissalAnimator: UIViewPropertyAnimator?

    // This handles both screen edge and dragdown pan. As screen edge pan is a subclass of pan gesture, this input param works.
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {

        let isScreenEdgePan = gesture.isKind(of: DismissalScreenEdgePanGesture.self)
        let canStartDragDownToDismissPan = !isScreenEdgePan && !draggingDownToDismiss

        // Don't do anything when it's not in the drag down mode
        if canStartDragDownToDismissPan { return }

        let targetAnimatedView = gesture.view!
        let startingPoint: CGPoint

        if let p = interactiveStartingPoint {
            startingPoint = p
        } else {
            // Initial location
            startingPoint = gesture.location(in: nil)
            interactiveStartingPoint = startingPoint
        }

        let currentLocation = gesture.location(in: nil)
        let progress = isScreenEdgePan ? (gesture.translation(in: targetAnimatedView).x / 100) : (currentLocation.y - startingPoint.y) / 100
        let targetShrinkScale: CGFloat = 0.86
        let targetCornerRadius: CGFloat = GlobalConstants.cardCornerRadius

        func createInteractiveDismissalAnimatorIfNeeded() -> UIViewPropertyAnimator {
            if let animator = dismissalAnimator {
                return animator
            } else {
                let animator = UIViewPropertyAnimator(duration: 0, curve: .linear, animations: {
                    targetAnimatedView.transform = .init(scaleX: targetShrinkScale, y: targetShrinkScale)
                    targetAnimatedView.layer.cornerRadius = targetCornerRadius
                })
                animator.isReversed = false
                animator.pauseAnimation()
                animator.fractionComplete = progress
                return animator
            }
        }

        switch gesture.state {
        case .began:
            dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()

        case .changed:
            dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()

            let actualProgress = progress
            let isDismissalSuccess = actualProgress >= 1.0

            dismissalAnimator!.fractionComplete = actualProgress

            if isDismissalSuccess {
                dismissalAnimator!.stopAnimation(false)
                dismissalAnimator!.addCompletion { [unowned self] (pos) in
                    switch pos {
                    case .end:
                        self.didSuccessfullyDragDownToDismiss()
                    default:
                        fatalError("Must finish dismissal at end!")
                    }
                }
                dismissalAnimator!.finishAnimation(at: .end)
            }

        case .ended, .cancelled:
            if dismissalAnimator == nil {
                // Gesture's too quick that it doesn't have dismissalAnimator!
                print("Too quick there's no animator!")
                didCancelDismissalTransition()
                return
            }
            // NOTE:
            // If user lift fingers -> ended
            // If gesture.isEnabled -> cancelled
            // Ended, Animate back to start
            dismissalAnimator!.pauseAnimation()
            dismissalAnimator!.isReversed = true

            // Disable gesture until reverse closing animation finishes.
            gesture.isEnabled = false
            dismissalAnimator!.addCompletion { [unowned self] (pos) in
                self.didCancelDismissalTransition()
                gesture.isEnabled = true
            }
            dismissalAnimator!.startAnimation()
        default:
            fatalError("Impossible gesture state? \(gesture.state.rawValue)")
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.scrollIndicatorInsets = .init(top: cardContentView.bounds.height, left: 0, bottom: 0, right: 0)
        if GlobalConstants.isEnabledTopSafeAreaInsetsFixOnCardDetailViewController {
            self.additionalSafeAreaInsets = .init(top: max(-view.safeAreaInsets.top,0), left: 0, bottom: 0, right: 0)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if draggingDownToDismiss || (scrollView.isTracking && scrollView.contentOffset.y < 0) {
            draggingDownToDismiss = true
            scrollView.contentOffset = .zero
        }

        scrollView.showsVerticalScrollIndicator = !draggingDownToDismiss
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Without this, when user drag down and lift the finger fast at the top, there'll be some scrolling going on.
        // This check prevents that.
        if velocity.y > 0 && scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = .zero
        }
    }

    override var statusBarAnimatableConfig: StatusBarAnimatableConfig {
        return StatusBarAnimatableConfig(prefersHidden: true,
                                         animation: .slide)
    }
}

extension CardDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension CardDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == materialTabel {
            return cardViewModel.material.count
        }
        return cardViewModel.material.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == materialTabel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialCell", for: indexPath) as! MaterialTableViewCell
            
            

            let materialData: [String: String] = cardViewModel.material[indexPath.row]
            cell.nameMaterial.text = materialData["name"]
            cell.descMaterial.text = materialData["desc"]
            cell.imageMaterial?.image = UIImage(named: materialData["image"]!)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

