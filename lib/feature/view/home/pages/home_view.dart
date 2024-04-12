import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp71/core/generated/assets.gen.dart';
import 'package:pp71/core/widgets/drawer.dart';
import 'package:pp71/core/widgets/icon_button.dart';

import '../../widgets/select_device.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  bool isTab1 = true;
  bool isTab2 = false;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leadingWidth: 65,
        leading: CustomIconButton(
          onPressed: () {
             _scaffoldKey.currentState?.openDrawer();
          },
          icon: Assets.icons.settingLine,
        ),
        
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Assets.icons.statistics,
          ),
          SizedBox(width: 20)
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            isTab1 = true;
                            isTab2 = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isTab1
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: Text(
                            'Customers',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: isTab1
                                        ? Theme.of(context)
                                            .colorScheme
                                            .background
                                        : Theme.of(context).colorScheme.shadow),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            isTab2 = true;
                            isTab1 = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isTab2
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: Text('Orders',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          color: isTab1
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .shadow
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .background))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Assets.icons.plusBig.svg(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if(isTab1)
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 22.0,
                    childAspectRatio: 0.9),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return DeviceContainer(
                      onPressed: () {
                        setState(() {
                          // selectedIndex = index;
                          // widget.onPressed.call(index);
                        });
                      },
                      selected: false);
                },
              ),
              if(isTab2)
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 22.0,
                    childAspectRatio: 0.9),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return DeviceContainer(
                      onPressed: () {
                        setState(() {
                          // selectedIndex = index;
                          // widget.onPressed.call(index);
                        });
                      },
                      selected: false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
