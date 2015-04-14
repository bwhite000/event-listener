part of EventListener;

class FunctionStore {
  final Map<int, StreamController<dynamic>> fnStore = <int, StreamController<dynamic>>{};

  FunctionStore();

  // Call the listeners attached to the Stream;
  // optionally, pass a data parameter
  void runEvent(final int eventCode, [final dynamic eventData]) {
    if (this.fnStore.containsKey(eventCode)) {
      if (eventData != null) {
        this.fnStore[eventCode].add(eventData);
      } else {
        this.fnStore[eventCode].add(null);
      }
    }
  }

  /// Create and get the Stream for the [eventCode]
  Stream<dynamic> operator[] (final int eventCode) {
    if (this.fnStore.containsKey(eventCode) == false) { // Not stored already
      // Create a stream controller
      final StreamController<dynamic> controller = new StreamController<dynamic>();

      // Set it to the index of the [eventCode]
      this.fnStore[eventCode] = controller;

      return controller.stream;
    } else { // Has a stream controller already stored at this eventCode
      return this.fnStore[eventCode].stream;
    }
  }
}