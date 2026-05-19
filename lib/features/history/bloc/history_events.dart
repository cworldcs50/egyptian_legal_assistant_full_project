abstract class HistoryEvents {
  const HistoryEvents();
}

class FetchSessionsEvent extends HistoryEvents {
  const FetchSessionsEvent();
}

class DeleteSessionEvent extends HistoryEvents {
  final String sessionId;
  const DeleteSessionEvent(this.sessionId);
}
