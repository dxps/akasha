class SnowflakeGenerator {
  SnowflakeGenerator({
    required this.workerId,
    required this.datacenterId,
    this.epochMs = 1577836800000, // 2020-01-01 UTC
  }) {
    if (workerId < 0 || workerId > maxWorkerId) {
      throw ArgumentError('workerId must be between 0 and $maxWorkerId');
    }
    if (datacenterId < 0 || datacenterId > maxDatacenterId) {
      throw ArgumentError('datacenterId must be between 0 and $maxDatacenterId');
    }
  }

  final int workerId;
  final int datacenterId;
  final int epochMs;

  static const int workerIdBits = 5;
  static const int datacenterIdBits = 5;
  static const int sequenceBits = 12;

  static const int maxWorkerId = (1 << workerIdBits) - 1; // 31
  static const int maxDatacenterId = (1 << datacenterIdBits) - 1; // 31
  static const int sequenceMask = (1 << sequenceBits) - 1; // 4095

  static const int workerIdShift = sequenceBits;
  static const int datacenterIdShift = sequenceBits + workerIdBits;
  static const int timestampShift = sequenceBits + workerIdBits + datacenterIdBits;

  int _lastTimestamp = -1;
  int _sequence = 0;

  BigInt nextId() {
    var timestamp = _currentTimeMs();

    if (timestamp < _lastTimestamp) {
      throw StateError('Clock moved backwards.');
    }

    if (timestamp == _lastTimestamp) {
      _sequence = (_sequence + 1) & sequenceMask;
      if (_sequence == 0) {
        timestamp = _waitNextMillis(_lastTimestamp);
      }
    } else {
      _sequence = 0;
    }

    _lastTimestamp = timestamp;

    return (BigInt.from(timestamp - epochMs) << timestampShift) |
        (BigInt.from(datacenterId) << datacenterIdShift) |
        (BigInt.from(workerId) << workerIdShift) |
        BigInt.from(_sequence);
  }

  String nextIdString() => nextId().toString();

  int _currentTimeMs() => DateTime.now().millisecondsSinceEpoch;

  int _waitNextMillis(int lastTimestamp) {
    var ts = _currentTimeMs();
    while (ts <= lastTimestamp) {
      ts = _currentTimeMs();
    }
    return ts;
  }
}
