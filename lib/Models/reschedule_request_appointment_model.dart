class RescheduleRequestAppointmentModel {
  final String id;
  final String appointmentId;
  final String userId;
  final String userType;
  final String rescheduleDate;
  final String rescheduleStartTime;
  final String rescheduleEndTime;
  final String rescheduleStatus;
  final String consultantId;
  final String type;
  final String name;
  final String appointmentDate;
  final String startTime;
  final String amount;
  final String sessionName;
  final String sessionDetails;
  final String userDeviceToken;
  final String consultantDeviceToken;
  final String duration;
  final String consultantName;
  final String profileImage;

  RescheduleRequestAppointmentModel({
    required this.id,
    required this.appointmentId,
    required this.userId,
    required this.userType,
    required this.rescheduleDate,
    required this.rescheduleStartTime,
    required this.rescheduleEndTime,
    required this.rescheduleStatus,
    required this.consultantId,
    required this.type,
    required this.name,
    required this.appointmentDate,
    required this.startTime,
    required this.amount,
    required this.sessionName,
    required this.sessionDetails,
    required this.userDeviceToken,
    required this.consultantDeviceToken,
    required this.duration,
    required this.consultantName,
    required this.profileImage,
  });

  // Factory method to create an instance from a JSON Map
  factory RescheduleRequestAppointmentModel.fromJson(Map<String, dynamic> json) {
    return RescheduleRequestAppointmentModel(
      id: json['id'] as String,
      appointmentId: json['appointmentid'] as String,
      userId: json['userid'] as String,
      userType: json['user_type'] as String,
      rescheduleDate: json['rescheduleDate'] as String,
      rescheduleStartTime: json['reschedule_StartTime'] as String,
      rescheduleEndTime: json['reschedule_EndTime'] as String,
      rescheduleStatus: json['reschedule_status'] as String,
      consultantId: json['consultantid'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      appointmentDate: json['appointment_date'] as String,
      startTime: json['start_time'] as String,
      amount: json['amount'] as String,
      sessionName: json['session_name'] as String,
      sessionDetails: json['session_details'] as String,
      userDeviceToken: json['user_deviceToken'] as String,
      consultantDeviceToken: json['consultant_deviceToken'] as String,
      duration: json['duration'] as String,
      consultantName: json['consultant_name'] as String,
      profileImage: json['profile_image'] as String,
    );
  }

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointmentid': appointmentId,
      'userid': userId,
      'user_type': userType,
      'rescheduleDate': rescheduleDate,
      'reschedule_StartTime': rescheduleStartTime,
      'reschedule_EndTime': rescheduleEndTime,
      'reschedule_status': rescheduleStatus,
      'consultantid': consultantId,
      'type': type,
      'name': name,
      'appointment_date': appointmentDate,
      'start_time': startTime,
      'amount': amount,
      'session_name': sessionName,
      'session_details': sessionDetails,
      'user_deviceToken': userDeviceToken,
      'consultant_deviceToken': consultantDeviceToken,
      'duration': duration,
      'consultant_name': consultantName,
      'profile_image': profileImage,
    };
  }

  // Factory method to create an empty RescheduleRequestAppointmentModel instance
  factory RescheduleRequestAppointmentModel.empty() {
    return RescheduleRequestAppointmentModel(
      id: '',
      appointmentId: '',
      userId: '',
      userType: '',
      rescheduleDate: '',
      rescheduleStartTime: '',
      rescheduleEndTime: '',
      rescheduleStatus: '',
      consultantId: '',
      type: '',
      name: '',
      appointmentDate: '',
      startTime: '',
      amount: '',
      sessionName: '',
      sessionDetails: '',
      userDeviceToken: '',
      consultantDeviceToken: '',
      duration: '',
      consultantName: '',
      profileImage: '',
    );
  }
}
