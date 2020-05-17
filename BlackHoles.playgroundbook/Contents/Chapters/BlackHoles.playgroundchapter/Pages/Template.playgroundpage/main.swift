//: If you want to edit this program, I recommend heading to the modules for the core code

// Because most of the code is modulated, all we need for this page is PlaygroundSupport
import PlaygroundSupport

// Create a master view, this is a UIView that manages every view
var masterView = MasterView()

// Start the program at the setup page
masterView.start(with: .setup)

// Set the liveView to the masterView
PlaygroundPage.current.liveView = masterView

// Make fullscreen
PlaygroundPage.current.wantsFullScreenLiveView = true