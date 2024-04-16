import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/models/cleint.dart';
import 'package:pp71/core/models/order.dart';
import 'package:pp71/core/widgets/feilds/names.dart';
import 'package:pp71/core/widgets/icon_button.dart';
import 'package:pp71/feature/controller/client_bloc/client_bloc.dart';
import 'package:pp71/feature/controller/order_bloc/order_bloc.dart';
import 'package:pp71/feature/view/home/pages/home_view.dart';
import 'package:pp71/feature/view/home/pages/new_cleint.dart';

class CustomersListView extends StatefulWidget {
  final Client client;
  const CustomersListView({super.key, required this.client});

  @override
  State<CustomersListView> createState() => _CustomersListViewState();
}

class _CustomersListViewState extends State<CustomersListView> {
  late TextEditingController descriptionController;
  final List<String> _listImageFile = [];
  @override
  void initState() {
    descriptionController = TextEditingController();
    descriptionController.text = widget.client.notes;
    super.initState();
  }

  int countActiveOrders(List<Order?>? orders) {
    if (orders == null || orders.isEmpty) {
      return 0;
    }

    DateTime now = DateTime.now();
    int activeOrders = 0;

    for (Order? order in orders) {
      if (order!.endTime.isAfter(now)) {
        activeOrders++;
      }
    }

    return activeOrders;
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
        title: Text(
          widget.client.name,
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        actions: [
          CustomIconButton(
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewClientView(
                            
                              isBack: true,
                               cleint: widget.client,
                              )));
              },
              icon: Assets.icons.edit),
          SizedBox(width: 20)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomIconButton(
        onPressed: () {
          showCupertinoDialog(
              context: context,
              builder: (contex) => Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Do you really want to\ndelete this client?',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                          Text('All information about her will be lost.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .shadow)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  height: 50,
                                  width:
                                      0.4 * MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                  child: Center(
                                    child: Text('No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  height: 50,
                                  width:
                                      0.4 * MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Center(
                                    child: Text('Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background)),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<ClientBloc>(context)
                                      .add(DeleteClient(model: widget.client));

                                  BlocProvider.of<ClientBloc>(context)
                                      .add(GetAllClient());
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homeview()),
                                      (Route route) => false);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        colorIcons: Assets.icons.trash.svg(width: 35, height: 35),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text('Customers',
                  style: Theme.of(context).textTheme.displayLarge!),
              SizedBox(height: 15),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.icons.phone.svg(),
                    Text(widget.client.phone,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayMedium!),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.icons.message.svg(),
                    Text(widget.client.email,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayMedium!),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text('Notes', style: Theme.of(context).textTheme.displayLarge!),
              SizedBox(height: 20),
              DescriptionFieldWidget(
                readOnly: true,
                controller: descriptionController,
                titleHint: 'empty',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total orders',
                      style: Theme.of(context).textTheme.displayLarge!),
                  Container(
                    height: 70,
                    width: 160,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        widget.client.orders.length.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.background),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Active orders',
                      style: Theme.of(context).textTheme.displayLarge!),
                  Container(
                    height: 70,
                    width: 160,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        '${countActiveOrders(widget.client.orders)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.background),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name Device',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.background)),
                    widget.client.orders.isNotEmpty
                        ? widget.client.orders.last!.photos.isNotEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      widget.client.orders.last!.photos.length,
                                  itemBuilder: (context, index) => Container(
                                    height:
                                        100, // Устанавливаем фиксированную высоту
                                    width: 100,
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.file(
                                          File(widget.client.orders.last!
                                              .photos[index]),
                                          fit: BoxFit.fill,
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.image_not_supported,
                                      size: 35,
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
                              )
                        : Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 35,
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
                                child: Text(widget.client.name,
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
                                child: Text(
                                    widget.client.orders.isNotEmpty
                                        ? DateFormat('dd MMMM, yyyy').format(
                                            widget.client.orders.last!.endTime)
                                        : 'no date',
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
