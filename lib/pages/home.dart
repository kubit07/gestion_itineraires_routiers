import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:france_itineraire/components/location_list_tile.dart';
import 'package:france_itineraire/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Itinéraires",
          style: TextStyle(color: textColorLightTheme),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, top: defaultPadding),
                  child: TextFormField(
                    onChanged: (value) {},
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Départ",
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),

                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, top: 8.0, bottom: defaultPadding),
                  child: TextFormField(
                    onChanged: (value) {},
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Destination",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                height: 16,
              ),
              label: const Text("Use my Current Location"),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor10LightTheme,
                foregroundColor: textColorLightTheme,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
        /*   LocationListTile(
            press: () {},
            location: "Banasree, Dhaka, Bangladesh",
          ), */
        ],
      ),
    );
  }
}