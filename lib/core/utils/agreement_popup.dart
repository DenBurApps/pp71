import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pp71/core/constants/settings_const.dart';
import 'package:pp71/core/constants/text_const.dart';
import 'package:pp71/core/utils/email_helper.dart';
import 'package:theme_provider/theme_provider.dart';

class AgreementPopUp extends StatelessWidget {
  final AgreementType agreementType;
  const AgreementPopUp({super.key, required this.agreementType});

  String get _body => agreementType == AgreementType.privacy
      ? TextHelper.privacy
      : TextHelper.terms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            agreementType == AgreementType.privacy
                ? 'Privacy Policy'
                : 'Terms of use',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onBackground),
          )),
      body: Material(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 30,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: MarkdownBody(
                    data: _body,
                    onTapLink: (text, href, title) =>
                        EmailHelper.launchEmailSubmission(
                      toEmail: text,
                      subject: 'Connect with support',
                      errorCallback: () {},
                      doneCallback: () {},
                    ),
                    styleSheet: MarkdownStyleSheet.fromTheme(
                        ThemeProvider.themeOf(context).data),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
