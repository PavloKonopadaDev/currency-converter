import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_converter/repository/models/modal.dart';
import 'package:money_converter/repository/repositiry.dart';
import 'package:money_converter/utils/dimens.dart';
import 'package:money_converter/utils/global.dart';
import 'package:money_converter/utils/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CurrencyConvert?> future;
  TextEditingController amtController = TextEditingController();

  TextStyle fromToStyle = TextStyle(
    color: Global.appColor,
    fontSize: ThemeDimens.fontSize,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    future = CurrencyConvertAPI.curencyAPI
        .currencyConvertorAPI(from: "USD", to: "UAH", amt: 1);

    amtController.text = "1";
  }

  String fromCurrency = "USD";
  String toCurrency = "UAH";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Global.appColor,
        middle: const Text(
          title,
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      backgroundColor: CupertinoColors.white,
      child: FutureBuilder(
        future: future,
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text("${snapShot.error}"),
            );
          } else if (snapShot.hasData) {
            CurrencyConvert? data = snapShot.data;

            return Container(
              padding: const EdgeInsets.all(ThemeDimens.spaceTheBiggest),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(inputLabel, style: fromToStyle),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: ThemeDimens.spaceSmall),
                            child: CupertinoTextField(
                              keyboardType: TextInputType.number,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ThemeDimens.borderRadusSmall),
                                border: Border.all(color: Global.appColor),
                              ),
                              controller: amtController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ThemeDimens.fontSize),
                    Divider(
                      color: Global.appColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.all(ThemeDimens.spaceSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(popFrom, style: fromToStyle),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (_) => SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  ThemeDimens.mediaQuaryMult,
                                              height: ThemeDimens.spaceSizedBox,
                                              child: CupertinoPicker(
                                                backgroundColor: Colors.white,
                                                itemExtent:
                                                    ThemeDimens.spaceGrand,
                                                children:
                                                    Global.currency.map((e) {
                                                  return Text(e);
                                                }).toList(),
                                                onSelectedItemChanged: (value) {
                                                  setState(() {
                                                    fromCurrency =
                                                        Global.currency[value];
                                                  });
                                                },
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    color: Global.appColor.withOpacity(
                                        ThemeDimens.opacitySmallest),
                                    height: ThemeDimens.dialogMinHeight,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                            width: ThemeDimens.spaceSmall),
                                        Text(
                                          fromCurrency,
                                        ),
                                        const Spacer(),
                                        const Icon(
                                            CupertinoIcons.arrow_2_squarepath),
                                        const SizedBox(
                                            width: ThemeDimens.spaceSmall),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.all(ThemeDimens.spaceSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(popTo, style: fromToStyle),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) => SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                ThemeDimens.mediaQuaryMult,
                                        height: ThemeDimens.spaceSizedBox,
                                        child: CupertinoPicker(
                                          backgroundColor: Colors.white,
                                          itemExtent: ThemeDimens.spaceGrand,
                                          children: Global.currency.map((e) {
                                            return Text(e);
                                          }).toList(),
                                          onSelectedItemChanged: (value) {
                                            setState(() {
                                              toCurrency =
                                                  Global.currency[value];
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    color: Global.appColor.withOpacity(
                                        ThemeDimens.opacitySmallest),
                                    height: ThemeDimens.dialogMinHeight,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                            width: ThemeDimens.spaceSmall),
                                        Text(
                                          toCurrency,
                                        ),
                                        const Spacer(),
                                        const Icon(
                                            CupertinoIcons.arrow_2_squarepath),
                                        const SizedBox(
                                            width: ThemeDimens.spaceSmall),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ThemeDimens.spaceSizedBox),
                    Container(
                      height: ThemeDimens.borderRadiusBig,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            ThemeDimens.borderRadiusBigger),
                        color: Global.appColor
                            .withOpacity(ThemeDimens.opacitySmall),
                      ),
                      child: Text(
                        "$resultLabel  ${data!.difference}",
                        style: TextStyle(
                          color: Global.appColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: ThemeDimens.fontSize),
                    SizedBox(
                      height: ThemeDimens.borderRadiusBig,
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        borderRadius:
                            BorderRadius.circular(ThemeDimens.borderRadiusBig),
                        onPressed: () {
                          if (amtController.text.isEmpty) {
                          } else {
                            int amt = int.parse(amtController.text);
                            setState(() {
                              future = CurrencyConvertAPI.curencyAPI
                                  .currencyConvertorAPI(
                                from: fromCurrency,
                                to: toCurrency,
                                amt: amt,
                              );
                            });
                          }
                        },
                        child: const Text(
                          buttonLlabel,
                          style: TextStyle(fontSize: ThemeDimens.spaceBig),
                        ),
                      ),
                    ),
                    const SizedBox(height: ThemeDimens.spaceTheBiggest),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
