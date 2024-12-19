import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class AppointmentSkeletonWidget extends StatelessWidget {
  const AppointmentSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: const Color(0x3654A8C7),
            border: Border.all(color: const Color(0xffEDEDED), width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerEffect(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 8,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '11/11/11 hd dewhdgh',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontFamily: "Regular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        ShimmerEffect(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 3),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/video-solid.svg',
                                    width: 16,
                                    height: 16,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 8,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '11/11/11',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontFamily: "Regular"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 8,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Anurag Kashyap',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontFamily: "Regular"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 8,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'gdew dewfgweiuf refgref reifggf dewou',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontFamily: "Regular"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ShimmerEffect(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            )
          ],
        ),
      ),
    );
  }
}
