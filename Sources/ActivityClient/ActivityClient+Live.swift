@preconcurrency import ActivityKit
import ConcurrencyExtras

extension ActivityClient {
  public static var liveValue: Self {
    let activity: ActivityClientLive = .init()
    return .init(
      _implementation: .init(
        request: .init { attributes, contentState, pushType in
          try await activity.request(
            attributes: attributes,
            contentState: contentState,
            pushType: pushType)
        },
        update: .init { contentState in
          try await activity.update(using: contentState)
        },
        end: .init { contentState, dismissalPolicy in
          try await activity.end(
            using: contentState,
            dismissalPolicy: dismissalPolicy)
        }
      )
    )
  }
}

extension ActivityClient {
  private final actor ActivityClientLive {
    func request(
      attributes: Attributes,
      contentState: Attributes.ContentState,
      pushType: PushType? = nil
    ) throws {
      self.activity = try .request(
        attributes: attributes,
        contentState: contentState,
        pushType: pushType)
    }

    func update(using contentState: Attributes.ContentState) async throws {
      guard let activity = self.activity else {
        throw Error.notSetup
      }
      await activity.update(using: contentState)
    }

    func end(
      using contentState: Activity<Attributes>.ContentState? = nil,
      dismissalPolicy: ActivityUIDismissalPolicy = .default
    ) async throws {
      guard let activity = self.activity else {
        throw Error.notSetup
      }
      await activity.end(
        using: contentState,
        dismissalPolicy: dismissalPolicy)
    }

    private var activity: Activity<Attributes>?
  }
}
