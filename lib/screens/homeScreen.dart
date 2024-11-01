// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_crypto_asset/apis/services/cryptoServices.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/screens/favoriteScreen.dart';
import 'package:my_crypto_asset/screens/fundCrptoWalletScreen.dart';
import 'package:my_crypto_asset/screens/loginScreen.dart';
import 'package:my_crypto_asset/utilities/utils.dart';
import 'package:my_crypto_asset/widgets/buttons/iconButton.dart';
import 'package:my_crypto_asset/widgets/cryptoBalanceCard.dart';
import 'package:my_crypto_asset/widgets/cryptoCoins.dart';
import 'package:my_crypto_asset/widgets/cryptoLabel.dart';
import 'package:my_crypto_asset/widgets/myCryptoAssets.dart';
import 'package:my_crypto_asset/widgets/platformSpecificLoader.dart';
import 'package:my_crypto_asset/widgets/userInfoCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> fetchData() async {
    final coinMarketData = await CryptoServices.fetchCurrentCoinMarket();

    //appStateProvider = ;

    Future.delayed(Duration.zero, () {
      Provider.of<AppState>(context, listen: false)
          .setCoinMarketData(coinMarketData);
    });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey9,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          margin: const EdgeInsets.only(top: 54, bottom: 12),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await signOut();

                    await Utils.clearUserInfo();

                    await Utils.clearSharedPreferences();

                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: const Icon(
                    Icons.logout_rounded,
                  ),
                ),
                const Spacer(),
                Text(
                  '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: AppTextSizes.paragraphText2,
                        fontWeight: FontWeight.w600,
                      ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(FavouriteCryptoScreen.routeName);
                  },
                  child: const Icon(
                    Icons.favorite,
                  ),
                ),
                //const Spacer(),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: PlatformSpecificLoader())
            : CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: UserInfoCard(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: TotalBalanceCard(),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Row(
                        children: [
                          const Spacer(),
                          CustomIconButton(
                            icon: Icons.add,
                            label: 'Fund Crypto Wallet',
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(FundCryptoWalletScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  Consumer<AppState>(
                    builder: (_, appStateData, __) {
                      if (appStateData.getMyWalletData.isNotEmpty) {
                        return const CryptoLabel(
                          labelText: 'My Assets',
                        );
                      }
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    },
                  ),
                  const MyCryptoAssets(),
                  const CryptoLabel(
                    labelText: 'Cryptocurrency Coins',
                  ),
                  const CryptoCoins()
                ],
              ),
      ),
    );
  }
}
