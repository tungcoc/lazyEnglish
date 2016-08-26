

import Foundation
import XLPagerTabStrip

class YoutubeExampleViewController: BaseButtonBarPagerTabStripViewController<YoutubeIconCell> {
    
    let tabbarColor = UIColor(red: 250/255.0, green: 228/255.0, blue: 225/255.0, alpha: 1.0)
    //color icon
    let unselectedIconColor = UIColor(red: 251/255.0, green: 140/255.0, blue: 113/255.0, alpha: 1.0)
    let selectedIconColor = UIColor(red: 251/255.0, green: 71/255.0, blue: 44/255.0, alpha: 1.0)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonBarItemSpec = ButtonBarItemSpec.NibFile(nibName: "YoutubeIconCell", bundle: NSBundle(forClass: YoutubeIconCell.self), width: { (cell: IndicatorInfo) -> CGFloat in
            return 55.0
        })
    }
    
    override func viewDidLoad() {
        UINavigationBar.appearance().barTintColor = UIColor.greenColor()
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = tabbarColor
        //settings.style.buttonBarItemBackgroundColor = .clearColor()
        
        settings.style.selectedBarBackgroundColor = UIColor(red: 246/255.0, green: 32/255.0, blue: 0/255.0, alpha: 1.0)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)
        
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: YoutubeIconCell?, newCell: YoutubeIconCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.iconImage.tintColor = self?.unselectedIconColor
            newCell?.iconImage.tintColor = self?.selectedIconColor
            
        }
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let childVocabulary = VocabularyViewController(style: .Plain, itemInfo: IndicatorInfo(title: "Vocabulary", image: UIImage(named: "vocabulary")))
        
        let childQuotations = QuotationViewController(style: .Plain, itemInfo: IndicatorInfo(title: "Quotations", image: UIImage(named: "quotation")))
        
        let childMusic = MusicViewController(style: .Plain, itemInfo: IndicatorInfo(title: "Music", image: UIImage(named: "music")))

        let childVideo = VideoViewController(style: .Plain, itemInfo: IndicatorInfo(title: "Video", image: UIImage(named: "video")))

        return [childVocabulary, childQuotations, childMusic, childVideo]
    }
    
    
    override func configureCell(cell: YoutubeIconCell, indicatorInfo: IndicatorInfo) {
        cell.iconImage.image = indicatorInfo.image?.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    
    override func pagerTabStripViewController(pagerTabStripViewController: PagerTabStripViewController, updateIndicatorFromIndex fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.pagerTabStripViewController(pagerTabStripViewController, updateIndicatorFromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        
        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
            let child = viewControllers[toIndex] as! IndicatorInfoProvider
            UIView.performWithoutAnimation({ [weak self] () -> Void in
                guard let me = self else { return }
                me.navigationItem.title =  child.indicatorInfoForPagerTabStrip(me).title
                })
        }
    }
    
    // MARK: - Actions
    
    //    @IBAction func closeAction(sender: UIButton) {
    //        dismissViewControllerAnimated(true, completion: nil)
    //    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        navigationItem.backBarButtonItem = nil;
        if segue.identifier == "setting" {
            let vc = segue.destinationViewController as UIViewController
            vc.navigationItem.title = "Settings"
            navigationItem.title = nil
        }
        if segue.identifier == "notificationAll" {
            let vc = segue.destinationViewController as UIViewController
            vc.navigationItem.title = "Notificaton"
            navigationItem.title = nil
        }
        
    }
}





