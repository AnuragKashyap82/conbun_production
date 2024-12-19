class AppointmentModel {
  final String id;
  final String consultantId;
  final String type;
  final String name;
  final String appointmentDate;
  final String startTime;
  final String amount;
  final String sessionName;
  final String sessionDetails;
  final String? rescheduleStatus;
  final String userDeviceToken;
  final String consultantDeviceToken;
  final String duration;
  final String consultantName;
  final String? profileImage;
  final String categories;

  AppointmentModel({
    required this.id,
    required this.consultantId,
    required this.type,
    required this.name,
    required this.appointmentDate,
    required this.startTime,
    required this.amount,
    required this.sessionName,
    required this.sessionDetails,
     this.rescheduleStatus,
    required this.userDeviceToken,
    required this.consultantDeviceToken,
    required this.duration,
    required this.consultantName,
     this.profileImage,
    required this.categories,
  });

  // Factory method to create an instance from a JSON Map
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      consultantId: json['consultantid'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      appointmentDate: json['appointment_date'] as String,
      startTime: json['start_time'] as String,
      amount: json['amount'] as String,
      sessionName: json['session_name'] as String,
      sessionDetails: json['session_details'] as String,
      rescheduleStatus: json['rescheduleStatus'] ?? null,
      userDeviceToken: json['user_deviceToken'] as String,
      consultantDeviceToken: json['consultant_deviceToken'] as String,
      duration: json['duration'] as String,
      consultantName: json['consultant_name'] as String,
      profileImage: json['profile_image'] ?? null,
      categories: json['categories'] as String,
    );
  }

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'consultantid': consultantId,
      'type': type,
      'name': name,
      'appointment_date': appointmentDate,
      'start_time': startTime,
      'amount': amount,
      'session_name': sessionName,
      'session_details': sessionDetails,
      'rescheduleStatus': rescheduleStatus,
      'user_deviceToken': userDeviceToken,
      'consultant_deviceToken': consultantDeviceToken,
      'duration': duration,
      'consultant_name': consultantName,
      'profile_image': profileImage,
      'categories': categories,
    };
  }

  // Factory method to create an empty AppointmentModel instance
  factory AppointmentModel.empty() {
    return AppointmentModel(
      id: '',
      consultantId: '',
      type: '',
      name: '',
      appointmentDate: '',
      startTime: '',
      amount: '',
      sessionName: '',
      sessionDetails: '',
      rescheduleStatus: null,
      userDeviceToken: '',
      consultantDeviceToken: '',
      duration: '',
      consultantName: '',
      profileImage: '',
      categories: '',
    );
  }
}
