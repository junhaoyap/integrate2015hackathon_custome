//
//  ViewController.swift
//  GoodService-iOS
//
//  Created by Jingrong (: on 26/9/15.
//  Copyright © 2015 Lim Jing Rong. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AWSS3

class CallViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var hangUpButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!

    var timer: NSTimer?
    var min: String?
    var sec: String?
   
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberLabel.text = ""
        callStatusLabel.text = "Awaiting..."
        durationLabel.text = "--:--"
        hangUpButton.enabled = false

        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let soundFileURL = documentsURL.URLByAppendingPathComponent("local_file_name.file_format")
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
                                   AVEncoderBitRateKey: 16,
                                 AVNumberOfChannelsKey: 2,
                                       AVSampleRateKey: 44100.0]


        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print(error)
        }

        do {
            try audioRecorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings as! [String : AnyObject])
        } catch {
            print(error)
        }

        audioRecorder?.prepareToRecord()
    }

    func playSound() {
        if audioRecorder?.recording == false {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: (audioRecorder?.url)!)
            } catch {
                print(error)
            }

            audioPlayer?.delegate = self

            audioPlayer?.play()
        }
    }

    func sendAudioToServer(soundFileUrl: NSURL) {
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: "amazon_bucket_access_key", secretKey: "amazon_bucket_secret_key")
        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.USWest2,
            credentialsProvider: credentialsProvider)
        defaultServiceConfiguration.maxRetryCount = 5
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = defaultServiceConfiguration

        let transferManager = AWSS3TransferManager.defaultS3TransferManager()

        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.bucket = "amazon_bucket_name"
        uploadRequest.key = "amazon_bucket_file_name.file_format"
        uploadRequest.body = soundFileUrl

        let task = transferManager.upload(uploadRequest)
        task.continueWithBlock { (task) -> AnyObject! in
            if task.error != nil {
                print("Error: \(task.error)")
            } else {
                print("Upload successful")
            }
            return nil
        }
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        sendAudioToServer(recorder.url)
    }

    func stopRecording() {
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }

    func startRecording() {
        if audioRecorder?.recording == false {
            audioRecorder?.delegate = self
            audioRecorder?.record()
        }
    }

    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder) {
        print("Audio Record Encode Error")
    }

    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("Audio Play Decode Error")
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        // do something if we need but... we don't need
    }

    func updateCounter() {
        if Int(sec!) == 59 {
            min = String(Int(min!)! + 1)
            sec = "00"
        } else {
            sec = String(Int(sec!)! + 1)
            if Int(sec!) < 10 {
                sec = "0" + sec!
            }
        }
        durationLabel.text = min! + ":" + sec!
    }


    @IBAction func callAction(sender: UIButton) {
        startRecording()
        callButton.enabled = false
        hangUpButton.enabled = true
        phoneNumberLabel.text = "a_phone_number"
        callStatusLabel.text = "Connected"
        durationLabel.text = "0:00"
        min = "0"
        sec = "0"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }

    @IBAction func hangUpAction(sender: UIButton) {
        stopRecording()
        callButton.enabled = true
        hangUpButton.enabled = false
        phoneNumberLabel.text = ""
        callStatusLabel.text = "Awaiting..."
        durationLabel.text = "--:--"
        timer?.invalidate()
    }

    @IBAction func backAction(sender: UIButton) {
        timer?.invalidate()
        audioPlayer = nil
        audioRecorder = nil
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}

