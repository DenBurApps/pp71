// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/utils/email_helper.dart';
import 'package:pp71/core/widgets/app_button.dart';
import 'package:pp71/core/widgets/feilds/names.dart';
import 'package:pp71/core/widgets/icon_button.dart';
import 'package:pp71/feature/view/home/pages/orders_view.dart';

class SelectDeviceWidget extends StatefulWidget {
  final List list;
  final Function(int) onPressed;

  const SelectDeviceWidget({
    super.key,
    required this.list,
    required this.onPressed,
  });

  @override
  _SelectDeviceWidgetState createState() => _SelectDeviceWidgetState();
}

class _SelectDeviceWidgetState extends State<SelectDeviceWidget> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7 * MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Assets.icons.esc,
              ),
              SizedBox(width: 10),
              Text(
                'Select a client',
                style: Theme.of(context).textTheme.displayMedium!,
              ),
              selectedIndex != null
                  ? AppButton(
                      height: 40,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 0.2 * MediaQuery.of(context).size.width,
                      onPressed: () async {
                        widget.onPressed.call(selectedIndex!);
                        Navigator.pop(context);
                      },
                      label: 'Add',
                    )
                  : SizedBox(width: 70),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
              child: GridCleint(
                  list: widget.list,
                  onPressed: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  })),
        ],
      ),
    );
  }
}

class GridCleint extends StatefulWidget {
  final List list;
  final Function(int) onPressed;
  const GridCleint({
    super.key,
    required this.list,
    required this.onPressed,
  });

  @override
  State<GridCleint> createState() => _GridCleintState();
}

class _GridCleintState extends State<GridCleint> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 22.0,
          childAspectRatio: 0.9),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        return DeviceContainer(
            onPressed: () {
              setState(() {
                selectedIndex = index;
                widget.onPressed.call(index);
              });
            },
            selected: selectedIndex == index);
      },
    );
  }
}

class DeviceContainer extends StatelessWidget {
  final Function() onPressed;

  final bool selected;
  const DeviceContainer(
      {Key? key, required this.onPressed, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 200,
        width: 163,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            border:
                Border.all(color: Theme.of(context).colorScheme.onBackground)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('0 active orders',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.shadow)),
            Flexible(
              child: Text('Cleint Name',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: selected
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.onBackground,
                      )),
            ),
            Text('3 orders',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.shadow)),
          ],
        ),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final Function() onPressed;
  final List<String> listImageFile;
  final String name;
  final String nameDevice;
  final String date;

  final bool selected;
  const OrderContainer(
      {super.key,
      required this.onPressed,
      required this.selected,
      required this.listImageFile,
      required this.name,
      required this.nameDevice,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: listImageFile.isNotEmpty
          ? null
          : () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrdersListView()));
            },
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nameDevice,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background)),
              listImageFile.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: listImageFile.length,
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
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
                          ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 0.3 * MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Assets.icons.userAltLight.svg(),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.3 * MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Assets.icons.tumer.svg(),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(date,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
