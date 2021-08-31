import Flutter
import CoreNFC
import SafariServices

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, NFCNDEFReaderSessionDelegate, NFCTagReaderSessionDelegate, SFSafariViewControllerDelegate {
    // variable for sending data back to flutter
    var flutterResult: FlutterResult!
    // reader session for grabbing UID
    var readUidSession: NFCTagReaderSession!
    // writer session for writing the URL onto the coaster
    var writeSession: NFCNDEFReaderSession!
    
    var uidForWriting : String = "sample"
    
    
// --------------------------------------------- Write Fonz URL to Coaster Funcs -----------------------------------------------------------------
    // swift protcol if error
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        DispatchQueue.main.async {
            session.invalidate()
            print(error.localizedDescription)
            self.flutterResult(error.localizedDescription)
        }
    }
    // swift protocol check if active
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
            print("became active")
    }
    // keep blank, reads the payload
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // nothing
    }
    // this runs once scan is launched, writes to coaster
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
    
        // inits first tag as active coaster
        let tag = tags.first!
        // connects to that tag
        session.connect(to: tag) { (error: Error?) in
                // ensures that it is an NDEF tag
                tag.queryNDEFStatus() { (status: NFCNDEFStatus, capacity: Int, error: Error?) in

                    // inits the URL
                    let uriPayloadFromURL = NFCNDEFPayload.wellKnownTypeURIPayload(
                        url: URL(string: "https://fonzmusic.com/\(self.uidForWriting)")!
                    )!
                    let myMessage = NFCNDEFMessage.init(records: [uriPayloadFromURL])
                    // function writes the url onto the tag
                    tag.writeNDEF(myMessage) { (error) in
                        if let error = error {
                            print("\(error)")
                            session.alertMessage = "well done!"
                        }
                        else {
                            session.alertMessage = "properly connected!"
                        }
                        // ends session
                        session.invalidate()
                        // tells app it was successful
                        DispatchQueue.main.async {
                            self.flutterResult("SUCCESS_ON_WRITE")
                        }
                    }
                }
            }
        }

    // this begins the Write URL session and launches NFC
    func writeFonzToTag(result: @escaping FlutterResult) {
        flutterResult = result
        writeSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        writeSession?.begin()
    }
    
    // --------------------------------------------- Read the UID from each Tag -----------------------------------------------------------------
    
    // swift protcol if error
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        DispatchQueue.main.async {
            session.invalidate()
            print(error.localizedDescription)
            self.flutterResult(error.localizedDescription)
        }
    }
    // swift protocol check if active
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("became active")
    }
    // this runs once nfc is launched, gets the UID
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        // ensures that the tag is mifare
        if case let NFCTag.miFare(tag) = tags.first! {
            // connects to the first tag
            session.connect(to: tags.first!) { (error: Error?) in
                // gets the UID in byte form
                let tagUIDData = tag.identifier
                // inits byte array
                var byteData: [UInt8] = []
                // adds uid from byte form into the byte array
                tagUIDData.withUnsafeBytes { byteData.append(contentsOf: $0) }
                session.alertMessage = "properly connected!"

                // ends nfc prompt
                session.invalidate()
                DispatchQueue.main.async {
                    // combines byte array into a string and sends it back to Flutter
                    self.flutterResult(self.hexEncodedString(byteArray: byteData))
                }
            }
        }
    }
    
    // this begins the Read Tag session and reads the UID
    private func startReadingNFC(result: @escaping FlutterResult) {
        flutterResult = result
        readUidSession = NFCTagReaderSession(pollingOption: .iso14443, delegate: self, queue: DispatchQueue.main)
        readUidSession?.begin()
    }
    
    // this function converts bytes into workable String
    func hexEncodedString(byteArray: [UInt8]) -> String {
            let hexDigits = Array("0123456789abcdef".utf16)
            var hexChars = [UTF16.CodeUnit]()
            hexChars.reserveCapacity(byteArray.count * 2)
            for byte in byteArray {
              let (index1, index2) = Int(byte).quotientAndRemainder(dividingBy: 16)
              hexChars.append(hexDigits[index1])
              hexChars.append(hexDigits[index2])
            }
            return String(utf16CodeUnits: hexChars, count: hexChars.count)
    }
    
    // this connects the functions above with Flutter
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // creates the view for Flutter
        let controller = window?.rootViewController as! FlutterViewController
        
        // if flutter creates a method channel with the given name, run code
        let nfcChannel = FlutterMethodChannel(name: "readUidPlatform", binaryMessenger: controller.binaryMessenger)
            nfcChannel.setMethodCallHandler({
                [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              // Note: this method is invoked on the UI thread.
                // if the function called is 'getNFCTag', get the UID
                if call.method == "getNFCTag" {
                    self?.startReadingNFC(result: result)
                }
                // if function called is 'writeFonzUrl', write to the coaster
                else if call.method == "writeFonzUrl" {
                    print("writing to coaster")
                    let args = call.arguments as? Dictionary<String, Any>
                    // gets the token that was passed in
                    let token =  args!["uid"] as? String
                    self?.uidForWriting = token ?? "ten"
                    self?.writeFonzToTag(result: result)
                }
                // otherwise ignore and give error
                else {
                    result(FlutterMethodNotImplemented)
                    return
                }
            })
        // return to Flutter
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}
