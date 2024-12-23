import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/appointment_model.dart';
import 'package:conbun_production/Models/reschedule_request_appointment_model.dart';
import 'package:conbun_production/Repository/appointments_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsController extends GetxController {
  static AppointmentsController get instance => Get.find();

  final isLoading = false.obs;
  final _appointmentRepository = Get.put(AppointmentsRepository());
  RxList<AppointmentModel> upcomingAppointments = <AppointmentModel>[].obs;
  RxList<AppointmentModel> dashboardUpcomingAppointments = <AppointmentModel>[].obs;
  RxList<AppointmentModel> completedAppointments = <AppointmentModel>[].obs;
  RxList<AppointmentModel> cancelledAppointments = <AppointmentModel>[].obs;
  RxList<AppointmentModel> rejectedAppointments = <AppointmentModel>[].obs;
  RxList<AppointmentModel> waitingAppointments = <AppointmentModel>[].obs;
  RxList<RescheduleRequestAppointmentModel> rescheduledAppointments = <RescheduleRequestAppointmentModel>[].obs;

  @override
  void onInit() {
    fetchDashboardUpcomingAppointments();
    fetchWaitingAppointments();
    fetchUpcomingAppointments();
    fetchCompletedAppointments();
    fetchCancelledAppointments();
    fetchRejectedAppointments();
    fetchRescheduledAppointments();
    super.onInit();
  }
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }

  Future<void> fetchDashboardUpcomingAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllAppointmentByLimit(
          userId, "Upcoming", "3");
      dashboardUpcomingAppointments.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchUpcomingAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllAppointment(
          userId, "Upcoming");
      upcomingAppointments.assignAll(consultants);
      isLoading.value = false;
      print("Upcoming appointents ${upcomingAppointments.length}");
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWaitingAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllAppointment(
          userId, "Waiting");
      waitingAppointments.assignAll(consultants);
      isLoading.value = false;
      print("Waiting appoinents ${waitingAppointments.length}");
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchCompletedAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllAppointment(
          userId, "Completed");
      completedAppointments.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchCancelledAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllAppointment(
          userId, "Cancelled");
      cancelledAppointments.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchRescheduledAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllRescheduleAppointmentRequest(
          userId, "1000", );

      rescheduledAppointments.assignAll(consultants);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchRejectedAppointments() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _appointmentRepository.getAllAppointment(
        userId, "Reject",
      );

      rejectedAppointments.assignAll(consultants);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
