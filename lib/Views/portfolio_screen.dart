import 'package:conbun_production/Models/portfolio_model.dart';
import 'package:conbun_production/Views/portfolio_full_screen.dart';
import 'package:conbun_production/Views/video_player_screen.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../Controllers/portfolio_controller.dart';
import '../utils/colors.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  PortfolioController portfolioController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
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
        title: const Text(
          "Portfolio",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body: Obx(() {
        if (portfolioController.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 50,
              itemBuilder: (context, index) {
                // Set isVideo to true for every 5th item as an example
                return ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300),
                  ),
                );
              },
            ),
          );
        }
        if (portfolioController.allPortfolio.isEmpty) {
          return Center(child: Text("No Portfolio"));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: portfolioController.allPortfolio.length,
            itemBuilder: (context, index) {
              final portfolio = portfolioController.allPortfolio[index];
              return PortfolioWidget(portfolio: portfolio);
            },
          ),
        );
      }),
    );
  }
}

class PortfolioWidget extends StatefulWidget {
  final PortfolioModel portfolio;

  const PortfolioWidget({super.key, required this.portfolio});

  @override
  State<PortfolioWidget> createState() => _PortfolioWidgetState();
}

class _PortfolioWidgetState extends State<PortfolioWidget> {

  // late VideoPlayerController _controller;
  // bool _isControllerInitialized = false;
  // String _errorMessage = '';
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initializeVideoPlayer();
  // }
  //
  // Future<void> _initializeVideoPlayer() async {
  //   try {
  //     _controller = VideoPlayerController.network(
  //         'https://api.contu.in/uploads/portfolio/1/sample-5s.mp4')
  //       ..initialize().then((_) {
  //         setState(() {
  //           _isControllerInitialized = true;
  //         });
  //       }).catchError((error) {
  //         setState(() {
  //           _errorMessage = 'Error initializing video: $error';
  //         });
  //       });
  //   } catch (e) {
  //     setState(() {
  //       _errorMessage = 'Error initializing video: $e';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: GestureDetector(
        onTap: () {
          if(widget.portfolio.filetype.contains("image")){
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => PortfolioFullScreen(imageUrl: widget.portfolio.fileUrl,)));
          }else{
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: widget.portfolio.fileUrl, isAppBar: true,)));
          }

        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                widget.portfolio.filetype.contains("image")?
                Image.network(
                  widget.portfolio.fileUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                ): Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                ),
                widget.portfolio.filetype.contains("image")
                    ? SizedBox()
                    : Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade300,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: colorWhite)),
                              child: Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: colorWhite,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
