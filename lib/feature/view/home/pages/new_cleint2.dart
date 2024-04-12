// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/models/cleint.dart';
import 'package:pp71/core/utils/show_custom_snack_bar.dart';
import 'package:pp71/core/widgets/app_button.dart';
import 'package:pp71/core/widgets/feilds/names.dart';
import 'package:pp71/core/widgets/feilds/numeric_fields.dart';
import 'package:pp71/core/widgets/icon_button.dart';
import 'package:pp71/feature/controller/client_bloc/client_bloc.dart';
import 'package:pp71/feature/view/home/pages/home_view.dart';
import 'package:pp71/feature/view/home/pages/new_order.dart';
import 'package:pp71/feature/view/home/pages/new_order2.dart';

// ignore: must_be_immutable
class NewCleintSecondView extends StatefulWidget {
  final String name;
  final String surName;

  final bool isBack;
  const NewCleintSecondView(
      {super.key,
      required this.isBack,
      required this.name,
      required this.surName});

  @override
  State<NewCleintSecondView> createState() => _NewCleintSecondViewState();
}

class _NewCleintSecondViewState extends State<NewCleintSecondView> {
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController descriptionController;
  late GlobalKey<FormState> _formKeys;
  bool contr1 = false;
  bool contr2 = false;
  @override
  void initState() {
    _formKeys = GlobalKey<FormState>();

    phoneController = TextEditingController();
    emailController = TextEditingController();
    descriptionController = TextEditingController();

    phoneController.addListener(_updateControllerState);
    emailController.addListener(_updateControllerState);

    super.initState();
  }

  void _updateControllerState() {
    setState(() {
      contr2 = phoneController.text.isNotEmpty;
      contr2 = emailController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Assets.icons.esc),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          'New client',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: AppButton(
          onPressed: () {
            if (_formKeys.currentState!.validate()) {
              if (widget.isBack) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homeview()));
                    BlocProvider.of<CleintBloc>(context).add(AddCleint(model: Cleint(
                      name: widget.name,
                      surname: widget.surName,
                      notes: descriptionController.text,
                      phone: phoneController.text,
                      
                      email: emailController.text,
                      orders: [],
                    )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewOrderView(isBack: false)));
              }
            } else {
              showCustomSnackBar(context, 'please fill in the field');
            }
          },
          label: 'Save',
          width: MediaQuery.of(context).size.width,
          height: 50,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fill in the information about the\nclient',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressBar(
                      maxSteps: 10,
                      progressType: LinearProgressBar.progressTypeLinear,
                      currentStep: 10,
                      progressColor: Theme.of(context).colorScheme.secondary,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary),
                      minHeight: 4.0,
                    ),
                  ),
                  Form(
                    key: _formKeys,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text('Phone number:',
                            style: Theme.of(context).textTheme.bodyLarge!),
                        const SizedBox(height: 10),
                        NumericField(
                          controller: phoneController,
                          titleHint: 'Add contacts',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill in the "Phone number" field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text('Email address:',
                            style: Theme.of(context).textTheme.bodyLarge!),
                        const SizedBox(height: 10),
                        EmailFieldWidget(
                          controller: emailController,
                          titleHint: 'Add email',
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              bool isValidEmail = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      caseSensitive: false)
                                  .hasMatch(value);
                              if (!isValidEmail) {
                                return 'Enter a valid email';
                              }
                            } else {
                              return 'please fill in the "email" field';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Notes:', style: Theme.of(context).textTheme.bodyLarge!),
                  DescriptionFieldWidget(
                    controller: descriptionController,
                    titleHint: 'Add notes',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
