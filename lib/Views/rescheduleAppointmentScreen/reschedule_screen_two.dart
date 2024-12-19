import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:conbun_production/Views/book_appointment_screen/book_appointment_apis.dart';
import 'package:conbun_production/Views/book_appointment_screen/book_appointment_screen.dart';
import 'package:conbun_production/Views/rescheduleAppointmentScreen/reschedule_appointment_apis.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Controllers/consultants_details_controller.dart';
import '../../Controllers/working_hour_controller.dart';
import '../../NotificationServices/push_notification.dart';
import '../../utils/colors.dart';
import '../bottomNavScreens/appointmentsScreen/my_appointments_screen.dart';

class RescheduleScreenTwo extends StatefulWidget {
  final bool isReschedule;
  final String consultantId;
  ConsultantsDetailsModel consultantsDetailsModel;

  RescheduleScreenTwo({
    super.key,
    required this.isReschedule,
    required this.consultantId,
    required this.consultantsDetailsModel,
  });

  @override
  State<RescheduleScreenTwo> createState() => _RescheduleScreenTwoState();
}

class _RescheduleScreenTwoState extends State<RescheduleScreenTwo> {
  RescheduleAppointmentApis rescheduleAppointmentApis = Get.find();
  AppointmentsController appointmentsController = Get.find();
  UserController userController = Get.find();
  ConsultantDetailsController consultantDetailsController =
      Get.put(ConsultantDetailsController());
  DateTime now = DateTime.now();
  BookAppointmentApis bookAppointmentApis = Get.put(BookAppointmentApis());

  // Convert DateTime.weekday to a string that matches the names in weekDays list
  String _convertWeekdayToString(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'monday';
      case DateTime.tuesday:
        return 'tuesday';
      case DateTime.wednesday:
        return 'wednesday';
      case DateTime.thursday:
        return 'thursday';
      case DateTime.friday:
        return 'friday';
      case DateTime.saturday:
        return 'saturday';
      case DateTime.sunday:
        return 'sunday';
      default:
        return '';
    }
  }

  List<String> generateTimeSlots(String startTimeStr, String endTimeStr) {
    List<String> timeSlots = [];

    // Parse the start and end time strings into DateTime objects
    DateFormat inputTimeFormat = DateFormat('HH:mm'); // 24-hour format
    DateTime startTime = inputTimeFormat.parse(startTimeStr);
    DateTime endTime = inputTimeFormat.parse(endTimeStr);

    // Define the output format as 12-hour with AM/PM
    DateFormat outputTimeFormat = DateFormat('hh:mm a');

    // Generate time slots in 30-minute intervals
    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      timeSlots.add(outputTimeFormat.format(startTime));
      startTime = startTime.add(const Duration(minutes: 30));
    }

    print(timeSlots);

    return timeSlots;
  }

  WorkingHourController workingHourController =
      Get.put(WorkingHourController());

  // Define a list to store the weekdays and a map for their schedules

  Future<void>? workingHourFuture;

  // Function to get working hours and store them in the lists
  Future<void> getWorkingHour() async {
    try {
      await workingHourController.fetchSchedules(widget.consultantId);
      if (workingHourController.errorMessage.value.isNotEmpty) {
        workingHourController.isWorkingHourNull.value = true;
        print('Error: ${workingHourController.errorMessage.value}');
        await rescheduleAppointmentApis.clearDateAndTime();
      } else {
        workingHourController.isWorkingHourNull.value = false;
        await rescheduleAppointmentApis.clearDateAndTime();
        workingHourController.schedules.forEach((day, schedules) {
          rescheduleAppointmentApis.weekDays.add(day);
          rescheduleAppointmentApis.weekDaySchedules[day] =
              schedules.map((schedule) {
            return {'openAt': schedule.openAt, 'closeAt': schedule.closeAt};
          }).toList();
        });
        rescheduleAppointmentApis.weekDaySchedules.forEach((day, schedules) {
          schedules.forEach((schedule) {});
        });
        print(rescheduleAppointmentApis.weekDays);
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  Future<void> getConsultantDetails() async {
    await consultantDetailsController.fetchUserData(widget.consultantId, userController.userData().id);
    widget.consultantsDetailsModel = await consultantDetailsController.userData();
    rescheduleAppointmentApis.selectedDay.value =await DateTime.parse(rescheduleAppointmentApis.rescheduleAppointModel().appointmentDate);
    rescheduleAppointmentApis.selectedHour.value =await rescheduleAppointmentApis.rescheduleAppointModel().startTime;
    rescheduleAppointmentApis.selectedFormattedDate.value =await rescheduleAppointmentApis.rescheduleAppointModel().appointmentDate;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // List<String> times = generateTimeSlots('09:30 AM', '06:30 PM');
    if (widget.isReschedule) {
      workingHourFuture = getWorkingHour();
      getConsultantDetails();
    } else {
      rescheduleAppointmentApis.clearDateAndTime();
      workingHourFuture = getWorkingHour();
    }
  }

  void _onTimeSlotTap(int index, String hour) {
    rescheduleAppointmentApis.selectedIndex.value = index;
    rescheduleAppointmentApis.selectedHour.value = hour;
    print(rescheduleAppointmentApis.selectedHour.value);
  }

  String formattedDate = '10:00 AM';
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('hh:mm a').format(now);
    print(formattedDate);

    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 20,
                )),
            title: Text(
              widget.consultantsDetailsModel.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (consultantDetailsController.isLoading.value) {
                  return ShimmerEffect(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                    ),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.consultantsDetailsModel.profileImage,
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.consultantsDetailsModel.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: colorSecondaryViolet,
                                    fontFamily: "Bold"),
                              ),
                              Text(
                                  "${widget.consultantsDetailsModel.city} | ${widget.consultantsDetailsModel.state}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff60697B),
                                    fontFamily: "SemiBold",
                                  )),
                              const Divider(
                                height: 8,
                                color: Color(0xffEDEDED),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                child: Text(
                                  widget.consultantsDetailsModel.categories,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff60697B),
                                    fontFamily: "SemiBold",
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              const Divider(
                                height: 8,
                                color: Color(0xffEDEDED),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade700,
                                    size: 10,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.consultantsDetailsModel.avgRating,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: colorSecondaryViolet,
                                        fontFamily: "Bold"),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    height: 3,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                        color: colorSecondaryViolet,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "${widget.consultantsDetailsModel.reviews.length} Reviews",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff60697B),
                                      fontFamily: "SemiBold",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: Color(0xffE4E4E4),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Select Date",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorBlack,
                  fontFamily: "Bold",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder<void>(
                  future: workingHourFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerEffect(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade100,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error fetching data'));
                    }
                    return Obx(() {
                      return Stack(
                        children: [
                          TableCalendar(
                            firstDay: DateTime.now(),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay:
                                rescheduleAppointmentApis.selectedDay.value,
                            headerStyle: const HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              decoration:
                                  BoxDecoration(color: Color(0xffECEEF1)),
                              titleTextStyle: TextStyle(
                                  color: Color(0xff5A6171),
                                  fontSize: 16,
                                  fontFamily: 'Bold'),
                              leftChevronIcon: Icon(
                                Icons.arrow_back_ios,
                                size: 18,
                                color: Color(0xff5A6171),
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Color(0xff5A6171),
                              ),
                            ),
                            availableGestures: AvailableGestures.all,
                            selectedDayPredicate: (day) {
                              return isSameDay(
                                  rescheduleAppointmentApis.selectedDay.value,
                                  day);
                            },

                            ///Available day
                            enabledDayPredicate: (day) {
                              String weekdayString =
                                  _convertWeekdayToString(day.weekday);
                              return rescheduleAppointmentApis.weekDays
                                  .contains(weekdayString);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              rescheduleAppointmentApis.selectedDay.value =
                                  selectedDay;
                              rescheduleAppointmentApis.selectedFormattedDate
                                  .value = "${dateFormat.format(selectedDay)}";
                              rescheduleAppointmentApis.selectedHour.value = '';
                              String selectedWeekday =
                                  _convertWeekdayToString(selectedDay.weekday);
                              if (rescheduleAppointmentApis.weekDaySchedules
                                  .containsKey(selectedWeekday)) {
                                print(
                                    'Schedule for $selectedWeekday: ${rescheduleAppointmentApis.weekDaySchedules[selectedWeekday]}');
                                var schedules = rescheduleAppointmentApis
                                    .weekDaySchedules[selectedWeekday];

                                rescheduleAppointmentApis.times.clear();

                                for (var schedule in schedules!) {
                                  String openAt = schedule['openAt']!;
                                  String closeAt = schedule['closeAt']!;
                                  rescheduleAppointmentApis.times.addAll(
                                      generateTimeSlots(openAt, closeAt));
                                }
                              } else {
                                print('No schedule found for $selectedWeekday');
                              }
                            },
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                                if (rescheduleAppointmentApis.weekDays.contains(
                                    _convertWeekdayToString(day.weekday))) {
                                  return Container(
                                    margin: const EdgeInsets.all(6.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                                return null;
                              },
                            ),
                            calendarStyle: const CalendarStyle(
                              rowDecoration:
                                  BoxDecoration(color: colorBackground),
                              defaultTextStyle: TextStyle(
                                  color: Color(0xff6B6B6B),
                                  fontSize: 12,
                                  fontFamily: 'Bold'),
                              weekendTextStyle: TextStyle(
                                  color: Color(0xff6B6B6B),
                                  fontSize: 12,
                                  fontFamily: 'Bold'),
                              selectedTextStyle: TextStyle(
                                  color: colorWhite,
                                  fontSize: 12,
                                  fontFamily: 'Bold'),
                              todayTextStyle: TextStyle(
                                  color: Color(0xff6B6B6B),
                                  fontSize: 12,
                                  fontFamily: 'Bold'),
                              selectedDecoration: BoxDecoration(
                                color: colorBlack,
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              markerDecoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Obx(() {
                            return workingHourController.isWorkingHourNull.value
                                ? Positioned(
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        decoration: BoxDecoration(
                                            color:
                                                colorOrange.withOpacity(0.2)),
                                        child: Center(
                                            child: Text(
                                          "Not Available",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.red,
                                              fontFamily: "Bold"),
                                        ))))
                                : SizedBox();
                          })
                        ],
                      );
                    });
                  }),
              const SizedBox(
                height: 8,
              ),
              Obx((){
                return workingHourController.isWorkingHourNull.value?SizedBox():Text(
                  "Select Hours",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorBlack,
                      fontFamily: "Bold"),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8),
                  itemCount: rescheduleAppointmentApis.times.length,
                  itemBuilder: (context, index) {
                    final timeSlot = rescheduleAppointmentApis.times[index];
                    final isBooked = rescheduleAppointmentApis.bookedTimeSlot
                        .contains(timeSlot);
                    final isSelected = rescheduleAppointmentApis.selectedIndex.value == index;

                    String time1 = formattedDate;
                    String time2 = rescheduleAppointmentApis.times[index];

                    bool isBefore(String t1, String t2) {
                      // Function to convert a time string to minutes past midnight
                      int toMinutes(String time) {
                        List<String> parts = time.split(RegExp(r'[:\s]'));
                        int hour = int.parse(parts[0]);
                        int minute = int.parse(parts[1]);
                        String period = parts[2];

                        if (period == "PM" && hour != 12) {
                          hour += 12;
                        } else if (period == "AM" && hour == 12) {
                          hour = 0;
                        }

                        return hour * 60 + minute;
                      }

                      return toMinutes(t1) < toMinutes(t2);
                    }

                    if (rescheduleAppointmentApis.selectedDay.value.year ==
                            now.year &&
                        rescheduleAppointmentApis.selectedDay.value.month ==
                            now.month &&
                        rescheduleAppointmentApis.selectedDay.value.day ==
                            now.day) {
                      if (isBefore(time1, time2)) {
                        print('$time1 is before $time2');
                        rescheduleAppointmentApis.isClickable.value = false;
                      } else if (isBefore(time2, time1)) {
                        print('$time1  after $time2');
                        rescheduleAppointmentApis.isClickable.value = true;
                      } else {
                        print('$time1 is at the same time as $time2');
                        rescheduleAppointmentApis.isClickable.value = true;
                      }
                    } else {
                      rescheduleAppointmentApis.isClickable.value = false;
                    }

                    return Obx(() {
                      return GestureDetector(
                        onTap: rescheduleAppointmentApis.isClickable.value
                            ? null
                            : isBooked
                                ? null
                                : () => _onTimeSlotTap(index,
                                    rescheduleAppointmentApis.times[index]),
                        child: HoursWidget(
                          time: rescheduleAppointmentApis.times[index],
                          isSelected:
                              rescheduleAppointmentApis.selectedIndex.value ==
                                  index,
                          isClickable:
                              rescheduleAppointmentApis.isClickable.value,
                          isBooked: isBooked,
                        ),
                      );
                    });
                  },
                );
              }),
              const SizedBox(
                height: 36,
              ),
              Obx((){
                return GestureDetector(
                  onTap: () async {
                    if (widget.isReschedule) {
                      if (rescheduleAppointmentApis.selectedHour.isNotEmpty) {
                        String endTime =
                        await rescheduleAppointmentApis.getEndTime(
                            rescheduleAppointmentApis.selectedHour.value,
                            Duration(
                                minutes: int.parse(rescheduleAppointmentApis
                                    .rescheduleAppointModel()
                                    .duration)));
                        final message =
                        await rescheduleAppointmentApis.rescheduleAppointment(
                            rescheduleAppointmentApis
                                .rescheduleAppointModel()
                                .consultantId,
                            userController.userData().id,
                            rescheduleAppointmentApis
                                .rescheduleAppointModel()
                                .id,
                            rescheduleAppointmentApis
                                .selectedFormattedDate.value,
                            rescheduleAppointmentApis.selectedHour.value,
                            endTime);
                        if (message['Error'] == 0) {
                          await appointmentsController
                              .fetchUpcomingAppointments();
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width:
                                          MediaQuery.of(context).size.width,
                                        ),
                                        Image.asset(
                                            'assets/images/rescheduleImage.png'),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Text(
                                          "ReScheduling Success",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Bold",
                                            color: colorViolet,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Appointment successfully changed You will\nreceved a notification and the consultant will contact you.",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Regular",
                                            color: Color(0xff5E5E5E),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 26,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: colorWhite,
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff636363)),
                                                    borderRadius:
                                                    BorderRadius.circular(4)),
                                                child: const Center(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: colorBlack,
                                                        fontFamily: "SemiBold"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                        const MyAppointmentScreen()));
                                              },
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: colorBlack,
                                                    borderRadius:
                                                    BorderRadius.circular(4)),
                                                child: const Center(
                                                  child: Text(
                                                    "View Appointment",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: colorWhite,
                                                        fontFamily: "SemiBold"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 26,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          // await PushNotificationServices
                          //     .sendNotificationToSelectedDriver(
                          //   consultantDetailsController.userData().devicetoken,
                          //   context,
                          //   "Appointment",
                          //   "You have a new appointment request",
                          // );
                        } else {
                          showSnackBar(message['message'], context);
                        }
                      } else {
                        showSnackBar("Select Date and slot first", context);
                      }
                    } else {
                      if (rescheduleAppointmentApis.selectedHour.isNotEmpty) {
                        print(rescheduleAppointmentApis.selectedDay.value);
                        print(rescheduleAppointmentApis.selectedHour.value);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookAppointmentScreen(
                              consultantId: widget.consultantId,
                              consultantToken:
                              widget.consultantsDetailsModel.devicetoken,
                              isLiveBooking: false,
                            ),
                          ),
                        );
                      } else {}
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: rescheduleAppointmentApis.selectedHour.isNotEmpty
                              ? colorBlack
                              : colorBlack.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          widget.isReschedule ? "Submit" : 'Next',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorWhite,
                              fontFamily: "SemiBold"),
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class HoursWidget extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isClickable;
  final bool isBooked;

  const HoursWidget({
    super.key,
    required this.time,
    required this.isSelected,
    required this.isClickable,
    required this.isBooked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isClickable
              ? Colors.grey.shade300
              : isBooked
                  ? Colors.red
                  : isSelected
                      ? colorBlack
                      : colorBackground,
          border: Border.all(
              color: isClickable
                  ? Colors.grey.shade300
                  : isBooked
                      ? Colors.red
                      : Color(0xff636363)),
          borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            time,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? colorWhite
                    : isBooked
                        ? colorWhite
                        : colorBlack,
                fontFamily: "SemiBold"),
          ),
        ),
      ),
    );
  }
}
