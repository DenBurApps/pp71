import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp71/core/constants/settings_const.dart';
import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/utils/agreement_popup.dart';
import 'package:pp71/core/utils/contact_dev.dart';
import 'package:pp71/core/utils/dialog_helper.dart';
import 'package:pp71/core/widgets/icon_button.dart';
import 'package:pp71/core/widgets/rate_us.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      width: 0.7 * MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Row(
              children: [
                CustomIconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    colorIcons: Assets.icons.edit.svg()),
                const SizedBox(width: 30),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
            const SizedBox(height: 40),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Center(
                child: Text(
                  'Information',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SettingsButtonWidget(
                title: 'Privacy Policy',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AgreementPopUp(
                              agreementType: AgreementType.privacy)));
                }),
            SettingsButtonWidget(
                title: 'Terms of use',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AgreementPopUp(
                              agreementType: AgreementType.terms)));
                }),
            SettingsButtonWidget(
                title: 'About Us',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: showContactDevoloper(context, controller),
                      );
                    },
                  ).then((value) {
                    setState(() {
                      controller.clear();
                    });
                  });
                }),
            const SizedBox(height: 10),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Center(
                child: Text(
                  'Contact us',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SettingsButtonWidget(
              title: 'Version',
              onPressed: () => DialogHelper.showAppVersionDialog(context),
            ),
            SettingsButtonWidget(
              title: 'Rate Us',
              onPressed: () {
                showRateUsDialog(context, Theme.of(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const SettingsButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: const EdgeInsets.only(bottom: 20),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium!),
          Assets.icons.arrowR.svg(),
        ],
      ),
    );
  }
}
