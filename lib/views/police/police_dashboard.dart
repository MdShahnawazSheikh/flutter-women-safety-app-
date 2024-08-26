import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/data/global/appdata.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/components/buttons/wide_elevated_button.dart';
import 'package:women_safety_app/res/components/spacing/vspace.dart';
import 'package:women_safety_app/view_model/bottom_sheat_view_model.dart';
import 'package:women_safety_app/view_model/police_distress_actions/constants.dart';
import 'package:women_safety_app/view_model/police_distress_actions/police_distress_handler.dart';
import 'package:women_safety_app/views/child/accounts/accounts_screen.dart';

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({super.key});

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceDashboard> {
  BottomSheetControllers locationController = Get.put(BottomSheetControllers());
  PoliceDistressHandler policeDistressHandler = PoliceDistressHandler();
  bool isPoliceAvailable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    policeData = (await policeDistressHandler.getPoliceInfo(userData["id"]))!;
    isPoliceAvailable = policeData["isAvailable"];
    log(policeData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userData["imageUrl"]),
          ),
        ),
        title: Text("Hi ${userData["name"]}"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: locationController.updateLocation,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                  ),
                  Obx(
                    () => Text(
                      locationController.realtimeAddress.value.substring(0, 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status:",
                  style: TextStyle(fontSize: size.width * 0.05),
                ),
                Text(
                  isPoliceAvailable.toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: isPoliceAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Vspace(size: 10),
            isPoliceAvailable
                ? WideElevatedButton(
                    size: size,
                    onCLick: () async {
                      await policeDistressHandler
                          .updateDistressSignalStatus(userData["id"]);
                      policeData = (await policeDistressHandler
                          .getPoliceInfo(userData["id"]))!;
                      isPoliceAvailable = false;
                      setState(() {});
                    },
                    label: "Register as Unavailable",
                    primary: Colors.red,
                  )
                : WideElevatedButton(
                    onCLick: () async {
                      policeData = (await policeDistressHandler
                          .getPoliceInfo(userData["id"]))!;
                      await policeDistressHandler.registerPoliceLocation();
                      isPoliceAvailable = true;
                      setState(() {});
                    },
                    label: "Register as Available",
                    primary: Colors.green,
                    size: size,
                  ),
            const Vspace(size: 10),
            WideElevatedButton(
              size: size,
              onCLick: () {
                Get.to(() => const AccountScreen());
              },
              label: "Edit Profile",
              primary: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
