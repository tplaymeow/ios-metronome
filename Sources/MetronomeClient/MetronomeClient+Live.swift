import AVFoundation
import MetronomeModels

extension MetronomeClient {
  public static var liveValue: Self {
    let metronome = Metronome()
    return .init(
      _implementation: .init(
        setup: .init { item in
          try await metronome.setup(file: item)
        },
        play: .init { tempo in
          try await metronome.play(tempo: tempo)
        },
        stop: .init {
          await metronome.stop()
        }
      )
    )
  }
}

extension MetronomeClient {
  private actor Metronome {
    func setup(file item: AudioItem) throws {
      do {
        let file = try AVAudioFile(forReading: item.url)
        let playerNode = AVAudioPlayerNode()
        let engine = AVAudioEngine()

        engine.attach(playerNode)
        engine.connect(
          playerNode,
          to: engine.mainMixerNode,
          format: file.processingFormat)

        self.file = file
        self.playerNode = playerNode
        self.engine = engine
      } catch {
        throw MetronomeClient.Error.setupError(underlying: error)
      }
    }

    func play(tempo: Tempo) throws {
      self.playerNode?.stop()
      self.engine?.stop()

      guard
        let playerNode = self.playerNode,
        let engine = self.engine,
        let file = self.file
      else {
        throw MetronomeClient.Error.notSetup
      }

      let sampleRate = file.processingFormat.sampleRate
      let periodLength = AVAudioFrameCount(sampleRate / tempo.bps)
      guard let buffer = AVAudioPCMBuffer(
        pcmFormat: file.processingFormat,
        frameCapacity: periodLength
      ) else {
        throw MetronomeClient.Error.startError(underlying: nil)
      }

      do {
        file.framePosition = 0
        try file.read(into: buffer)
        buffer.frameLength = periodLength
      } catch {
        throw MetronomeClient.Error.startError(underlying: error)
      }

      do {
        try engine.start()
        playerNode.play()
        playerNode.scheduleBuffer(
          buffer,
          at: nil,
          options: .loops,
          completionHandler: nil)
      } catch {
        throw MetronomeClient.Error.startError(underlying: error)
      }
    }

    func stop() {
      self.playerNode?.stop()
      self.engine?.stop()
    }

    private var file: AVAudioFile?
    private var playerNode: AVAudioPlayerNode?
    private var engine: AVAudioEngine?
  }
}
