class DistressSignal {
  String distressCaller;
  String responder;
  int distressCallerPhone;
  String distressCallerId;
  String distressCallerImg;
  String responderBadgeNumber;
  String video;
  bool resolved;

  DistressSignal({
    required this.distressCaller,
    required this.responder,
    required this.distressCallerPhone,
    required this.distressCallerId,
    required this.distressCallerImg,
    required this.responderBadgeNumber,
    required this.video,
    required this.resolved,
  });

  Map<String, dynamic> toMap() {
    return {
      'distressCaller': distressCaller,
      'responder': responder,
      'distressCallerPhone': distressCallerPhone,
      'distressCallerId': distressCallerId,
      'distressCallerImg': distressCallerImg,
      'responderBadgeNumber': responderBadgeNumber,
      'video': video,
      'resolved': resolved,
    };
  }

  factory DistressSignal.fromMap(Map<String, dynamic> map) {
    return DistressSignal(
      distressCaller: map['distressCaller'],
      responder: map['responder'],
      distressCallerPhone: map['distressCallerPhone'],
      responderBadgeNumber: map['responderBadgeNumber'],
      video: map['video'],
      resolved: map['resolved'],
      distressCallerId: map['distressCallerId'],
      distressCallerImg: map['distressCallerImg'],
    );
  }
}
