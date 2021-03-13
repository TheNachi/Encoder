//
//  EncodingViewModel.swift
//  Encoder
//
//  Created by Munachimso Ugorji on 13/03/2021.
//

import AVFoundation
import NextLevelSessionExporter

class EncodingViewModel {
    
    private var videoUrl: URL
    weak var delegate: EncodingDelegate?
    
    init(with url: URL) {
        self.videoUrl = url
    }
    
    func encodeVideo2()  {
        let asset = AVAsset(url: self.videoUrl)
        if let trimmedVideo = try? asset.trim(startTime: CMTimeMake(value: 1, timescale: 10), endTime: CMTimeMake(value: 200, timescale: 10)) {
            let exporter = NextLevelSessionExporter(withAsset: trimmedVideo)
            exporter.outputFileType = AVFileType.mp4
            let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                .appendingPathComponent(ProcessInfo().globallyUniqueString)
                .appendingPathExtension("mp4")
            exporter.outputURL = tmpURL
            
            let compressionDict: [String: Any] = [
                AVVideoAverageBitRateKey: NSNumber(integerLiteral: 1000000),
                AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel as String,
                AVVideoExpectedSourceFrameRateKey: NSNumber(integerLiteral: 24),
                AVVideoMaxKeyFrameIntervalDurationKey: NSNumber(integerLiteral: 1)
            ]
            
            exporter.videoOutputConfiguration = [
                AVVideoCodecKey: AVVideoCodecType.h264,
                AVVideoWidthKey: NSNumber(integerLiteral: 540),
                AVVideoHeightKey: NSNumber(integerLiteral: 960),
                AVVideoScalingModeKey: AVVideoScalingModeResizeAspectFill,
                AVVideoCompressionPropertiesKey: compressionDict,
                
                
            ]
            exporter.audioOutputConfiguration = [
                AVFormatIDKey: kAudioFormatMPEG4AAC,
                AVEncoderBitRateKey: NSNumber(integerLiteral: 64000),
                AVNumberOfChannelsKey: NSNumber(integerLiteral: 1),
                AVSampleRateKey: NSNumber(value: Float(44100)),
            ]
            
            exporter.export(progressHandler: { (progress) in
                self.delegate?.trackProgress(with: progress)
            }, completionHandler: { result in
                switch result {
                case .success(let status):
                    print(status, "the status")
                    switch status {
                    case .completed:
                        if let url = exporter.outputURL {
                            self.delegate?.saveVideo(with: url)
                        }
                        break
                    default:
                        self.delegate?.handleFail(CustomError(message: "for now"))
                        break
                    }
                    break
                case .failure(let error):
                    self.delegate?.handleFail(error)
                    break
                }
            })
        } else {
            self.delegate?.handleFail(CustomError(message: "for now"))
        }
        
    }
}

protocol EncodingDelegate: class {
    func saveVideo(with url: URL)
    func trackProgress(with progress: Float)
    func handleFail(_ error: Error)
}
