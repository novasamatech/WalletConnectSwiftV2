import XCTest

class PushNotificationTests: XCTestCase {

    private var engine: Engine!

    override func setUp() {
        super.setUp()
        engine = Engine()
    }
    
    func testPushNotification() {
        engine.routing.launch(app: .dapp, clean: true)

        // Initiate connection & copy URI from dApp
        engine.dapp.connectButton.waitTap()
        engine.dapp.newPairingButton.waitTap()
        engine.dapp.copyURIButton.waitTap()
        
        // Paste URI into Wallet & and allow connect
        engine.routing.launch(app: .wallet, clean: true)
        allowPushNotificationsIfNeeded(app: engine.wallet.instance)
        engine.wallet.getStartedButton.waitTap()
        engine.wallet.pasteURIButton.waitTap()
        pasteText(element: engine.wallet.alertUriTextField, application: engine.wallet.instance)
        engine.wallet.alertConnectButton.waitTap()
    
        // Allow session
        engine.wallet.allowButton.waitTap()
        
        // Allow notifications
        engine.wallet.allowButton.waitTap()
        
        // Trigger PN
        engine.routing.activate(app: .dapp)
        engine.dapp.accountRow.waitTap()
        engine.dapp.methodRow.waitTap()
        
        // Launch springboard
        engine.routing.activate(app: .springboard)
        let expectedCopy = "WALLETAPP, now, Signature required, You have a message to sign"
        let notification = engine.routing.springboard.otherElements["Notification"].descendants(matching: .any)["NotificationShortLookView"]
        
        XCTAssertTrue(notification.waitExists())
        XCTAssertEqual(notification.label, expectedCopy)
        
        notification.waitTap()
        XCTAssertTrue(engine.wallet.instance.waitForAppearence())
    }
}
