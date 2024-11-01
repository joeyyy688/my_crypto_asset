// ignore_for_file: file_names

import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/models/myWalletDetails.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/widgets/titledAppBar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class MyWalletPieChartScreen extends StatefulWidget {
  static const routeName = '/walletPieChartScreen';

  const MyWalletPieChartScreen({super.key});

  @override
  State<MyWalletPieChartScreen> createState() => _MyWalletPieChartScreenState();
}

class _MyWalletPieChartScreenState extends State<MyWalletPieChartScreen> {
  int touchedIndex = -1;

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  List<PieChartSectionData> showingSections() {
    final appStateProvider = Provider.of<AppState>(context, listen: false);

    double calculatePercentage(
      List<MyWalletDetails> list,
      MyWalletDetails item,
    ) {
      int itemCount = list.where((element) => element == item).length;
      return (itemCount / list.length) * 100;
    }

    return List<PieChartSectionData>.generate(
        appStateProvider.getMyWalletData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      for (int index = 0;
          index < appStateProvider.getMyWalletData.length;
          index++) {
        if (index == i) {
          return PieChartSectionData(
            color: getRandomColor(),
            value:
                appStateProvider.getMyWalletData[index].myWalletAmountBalance,
            title: appStateProvider
                .getMyWalletData[index].selectedCryptoCurrency.symbol
                .toUpperCase(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColor.mainTextColor1,
              shadows: shadows,
            ),
          );
        }
      }
      throw Error();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey9,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: TitledAppBar(
          pageTitle: 'Pie Chart',
          pageBackButtonCallback: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: AspectRatio(
        aspectRatio: 1.0,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Consumer<AppState>(builder: (_, appStateData, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...appStateData.getMyWalletData.map(
                    (e) => Indicator(
                      text: e.selectedCryptoCurrency.name,
                      cryptoImage: e.selectedCryptoCurrency.image,
                    ),
                  )
                ],
              );
            }),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.text,
    required this.cryptoImage,
    this.size = 16,
    this.textColor,
  });
  final String text;
  final String cryptoImage;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColor.grey8,
          child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            imageUrl: cryptoImage,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const CupertinoActivityIndicator(color: AppColor.primary),
            errorWidget: (_, __, ___) =>
                const CupertinoActivityIndicator(color: AppColor.primary),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        )
      ],
    );
  }
}
