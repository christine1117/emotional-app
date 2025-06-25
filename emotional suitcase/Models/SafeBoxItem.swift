import Foundation

enum SafeBoxItemType {
    case photo, video, audio
}

struct SafeBoxItem: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let type: SafeBoxItemType
    let duration: TimeInterval? // 僅音訊和影片使用
    let description: String?
}

class SafeBoxManager: ObservableObject {
    @Published var photos: [SafeBoxItem] = [
        SafeBoxItem(title: "我和小黃的合照", date: Date(), type: .photo, duration: nil, description: "快樂的一天"),
        SafeBoxItem(title: "我和小黃的合照", date: Date(), type: .photo, duration: nil, description: "快樂的一天"),
        SafeBoxItem(title: "我和小黃的合照", date: Date(), type: .photo, duration: nil, description: "快樂的一天"),
        SafeBoxItem(title: "我和小黃的合照", date: Date(), type: .photo, duration: nil, description: "快樂的一天")
    ]
    
    @Published var videos: [SafeBoxItem] = [
        SafeBoxItem(title: "海浪聲音", date: Date(), type: .video, duration: 120, description: "放鬆影片"),
        SafeBoxItem(title: "海浪聲音", date: Date(), type: .video, duration: 180, description: "放鬆影片"),
        SafeBoxItem(title: "海浪聲音", date: Date(), type: .video, duration: 90, description: "放鬆影片")
    ]
    
    @Published var audios: [SafeBoxItem] = [
        SafeBoxItem(title: "媽媽的鼓勵", date: Date(), type: .audio, duration: 90, description: nil),
        SafeBoxItem(title: "媽媽的鼓勵", date: Date(), type: .audio, duration: 90, description: nil),
        SafeBoxItem(title: "媽媽的鼓勵", date: Date(), type: .audio, duration: 90, description: nil),
        SafeBoxItem(title: "媽媽的鼓勵", date: Date(), type: .audio, duration: 90, description: nil),
        SafeBoxItem(title: "媽媽的鼓勵", date: Date(), type: .audio, duration: 90, description: nil),
        SafeBoxItem(title: "媽媽的鼓勵", date: Date(), type: .audio, duration: 90, description: nil)
    ]
    
    func addPhoto(title: String, description: String?) {
        let newPhoto = SafeBoxItem(title: title, date: Date(), type: .photo, duration: nil, description: description)
        photos.append(newPhoto)
    }
    
    func addVideo(title: String, description: String?) {
        let newVideo = SafeBoxItem(title: title, date: Date(), type: .video, duration: 60, description: description)
        videos.append(newVideo)
    }
    
    func addAudio(title: String, duration: TimeInterval) {
        let newAudio = SafeBoxItem(title: title, date: Date(), type: .audio, duration: duration, description: nil)
        audios.append(newAudio)
    }
    
    func deletePhoto(_ photo: SafeBoxItem) {
        photos.removeAll { $0.id == photo.id }
    }
    
    func deleteVideo(_ video: SafeBoxItem) {
        videos.removeAll { $0.id == video.id }
    }
    
    func deleteAudio(_ audio: SafeBoxItem) {
        audios.removeAll { $0.id == audio.id }
    }
}
