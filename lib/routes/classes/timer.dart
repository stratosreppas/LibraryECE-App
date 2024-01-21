import 'dart:async';

class TimerService {
  static final TimerService _singleton = TimerService._internal();
  Timer? _timer;

  factory TimerService() {
    return _singleton;
  }

  TimerService._internal();

  void startTimer(Function() callback) {
    const Duration duration = const Duration(seconds: 10);
    _timer = Timer.periodic(duration, (Timer timer) {
      callback();
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
