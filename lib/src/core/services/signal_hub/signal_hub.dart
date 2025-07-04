import 'dart:async';

final signalHub = SignalHub();

class SignalHub {
  final StreamController<dynamic> _streamController;

  StreamController<dynamic> get streamController => _streamController;

  SignalHub({bool sync = false}) : _streamController = StreamController.broadcast(sync: sync);

  SignalHub.customController(StreamController<dynamic> controller) : _streamController = controller;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void sendSignal(dynamic signal) {
    _streamController.add(signal);
  }

  void destroy() {
    _streamController.close();
  }
}
