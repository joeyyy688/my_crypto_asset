// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/providers/userDataProvider.dart';
import 'package:provider/provider.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (_, userData, __) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              if (userData.getUserInfoData.photoUrl.contains('http')) ...{
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  imageUrl: userData.getUserInfoData.photoUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: AppColor.grey6,
                    child: CupertinoActivityIndicator(color: AppColor.primary),
                  ),
                  errorWidget: (_, __, ___) =>
                      const CupertinoActivityIndicator(color: AppColor.primary),
                ),
              } else ...{
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColor.grey8,
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 81,
                    color: AppColor.grey3,
                  ),
                ),
              },
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      userData.getUserInfoData.displayName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: AppTextSizes.paragraphText1Medium,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      userData.getUserInfoData.email,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: AppTextSizes.buttonTextRegular,
                            fontWeight: FontWeight.w200,
                            color: AppColor.grey3,
                          ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Badge(
                child: Icon(
                  Icons.notifications_none_rounded,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
