import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/widgets/feilds/names.dart';
import 'package:pp71/core/widgets/icon_button.dart';
import 'package:pp71/feature/view/widgets/select_device.dart';

class OrdersListView extends StatefulWidget {
  const OrdersListView({super.key});

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  late TextEditingController descriptionController;
  final List<String> _listImageFile = [];
  @override
  void initState() {
    descriptionController = TextEditingController();
    super.initState();
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
        actions: [
          CustomIconButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              icon: Assets.icons.edit),
          SizedBox(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeviceContainer(onPressed: () {}, selected: false),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Name Device',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayLarge!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: _listImageFile.isNotEmpty
                    ? Center(
                        child: Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _listImageFile.length,
                            itemBuilder: (context, index) => Container(
                              height: 130,
                              width: 130,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.1),
                              ),
                              // child: Center(
                              //   child: ClipRRect(
                              //       borderRadius:
                              //           const BorderRadius.all(
                              //               Radius.circular(15)),
                              //       child: Image.file(
                              //         File(_listImageFile[index]),
                              //         fit: BoxFit.fill,
                              //         height: 100,
                              //         width: 100,
                              //       )),
                              // ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 35,
                               color: Theme.of(context).colorScheme.background,
                            ),
                            const SizedBox(height: 10),
                            Text('No Image',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background)),
                          ],
                        ),
                      ),
              ),
              SizedBox(height: 20),
              Text('Description of the problem',
                  style: Theme.of(context).textTheme.displayLarge!),
              SizedBox(height: 10),
              DescriptionFieldWidget(
                readOnly: true,
                controller: descriptionController,
                titleHint: 'empty',
              ),
              SizedBox(height: 20),
              Text('Start date',
                  style: Theme.of(context).textTheme.displayLarge!),
              SizedBox(height: 10),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Center(
                  child: Text('16 March, 2024',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayMedium!),
                ),
              ),
              SizedBox(height: 20),
              Text('End date',
                  style: Theme.of(context).textTheme.displayLarge!),
              SizedBox(height: 10),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Center(
                  child: Text('16 March, 2024',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayMedium!),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
          
        ),
      ),
    );
  }
}
