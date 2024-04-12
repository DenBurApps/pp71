// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/utils/show_custom_snack_bar.dart';
import 'package:pp71/core/widgets/app_button.dart';
import 'package:pp71/core/widgets/feilds/names.dart';
import 'package:pp71/core/widgets/icon_button.dart';
import 'package:pp71/feature/view/home/pages/new_cleint2.dart';

// ignore: must_be_immutable
class NewCleintView extends StatefulWidget {
  final bool isBack;
  const NewCleintView({super.key, required this.isBack});

  @override
  State<NewCleintView> createState() => _NewCleintViewState();
}

class _NewCleintViewState extends State<NewCleintView> {
  late TextEditingController nameController;
  late TextEditingController surNameController;
  late TextEditingController descriptionController;
  late GlobalKey<FormState> _formKeys;
  bool contr1 = false;
  bool contr2 = false;
  @override
  void initState() {
    _formKeys = GlobalKey<FormState>();

    nameController = TextEditingController();
    surNameController = TextEditingController();
    descriptionController = TextEditingController();

    nameController.addListener(_updateControllerState);
    surNameController.addListener(_updateControllerState);

    super.initState();
  }

  void _updateControllerState() {
    setState(() {
      contr2 = nameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        leading: widget.isBack
            ? CustomIconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Assets.icons.esc)
            : null,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewCleintSecondView(
                            isBack: widget.isBack,
                            name: nameController.text,
                            surName: surNameController.text,
                          )));
            } else {
               showCustomSnackBar(context, 'please fill in the field');
            }
          },
          label: 'Next',
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
                      currentStep: 5,
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
                        Text('Name Cleint',
                            style: Theme.of(context).textTheme.bodyLarge!),
                        const SizedBox(height: 10),
                        NamesFieldWidget(
                          controller: nameController,
                          titleHint: 'Add name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill in the “name” field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text('Surname client:',
                            style: Theme.of(context).textTheme.bodyLarge!),
                        const SizedBox(height: 10),
                        NamesFieldWidget(
                          controller: surNameController,
                          titleHint: 'Add surname',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill in the "surname" field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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