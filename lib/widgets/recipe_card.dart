import 'package:flutter/material.dart';
import 'package:flutterfire_crud/models/item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RecipeCard extends StatelessWidget {
  final int index = 0;
  final Item item;
  DateTime myDateTime = DateTime.now();

  RecipeCard({Key? key, required this.item, required this.myDateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Column(
          children: [
            buildHeader(context, index),
            buildRecipeImage(),
            buildActions(context),
            Padding(padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  buildInfoColumn(context, 'Name:', item.name)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  buildInfoColumn(context, 'Description:', item.description)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  buildInfoColumn(context, 'Ingredients:', item.serves),
                  buildInfoColumn(context, 'Equipment:', item.serves),
                  // Add more info columns as needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  buildInfoColumn(context, 'Prep Time:', item.serves),
                  buildInfoColumn(context, 'Cook Time:', item.serves),
                  // Add more info columns as needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  buildInfoColumn(context, 'Serves:', item.serves),
                  buildInfoColumn(context, 'Cook Temp:', item.serves),
                  // Add more info columns as needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  buildInfoColumn(context, 'Method:', item.serves),
                  // Add more info columns as needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: [
                  DateTimeFormatterWidget(label: 'Date:', dateTime: myDateTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 2.0,
      horizontal: 12.0,
    ).copyWith(right: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildAvatar(),
        Expanded(
          child: buildUserInfo(context),
        ),
        buildEllipsisButton(context, index),
      ],
    ),
  );
}

Widget buildAvatar() {
  return const CircleAvatar(
    radius: 15.0,
    backgroundImage: AssetImage('images/avataar_ben.png'),
  );
}

Widget buildUserInfo(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ben_okular',
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ),
  );
}

Widget buildEllipsisButton(BuildContext context, int index) {
  return IconButton(
    onPressed: (){
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.black38,
            child: Container(
              height: 270.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'View Recipe',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'Share Recipe',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'Edit Recipe',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'Delete Recipe',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
    icon: const Icon(FontAwesomeIcons.ellipsis),
  );
}

Widget buildRecipeImage() {
  return Column(
    children: [
      Image.asset(
        'images/fried_rice_photo.png',
        fit: BoxFit.cover,
        height: 220.0,
        width: double.infinity,
      ),
    ],
  );
}

Widget buildActions(BuildContext context) {
  return Row(
    children: [
      buildIconButton(FontAwesomeIcons.heart, () { }),
      buildIconButton(FontAwesomeIcons.comment, () { }),
      buildBookmarkIconButton(),
    ],
  );
}

Widget buildIconButton(IconData icon, VoidCallback onPressed) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon,
    ),
  );
}

Widget buildBookmarkIconButton() {
  return Expanded(
    child: Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
        icon: const Icon(FontAwesomeIcons.bookmark),
        onPressed: () {  },
      ),
    ),
  );
}

Widget buildInfoColumn(BuildContext context, String label, String value, {Color? labelColor}) {
  return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: label,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: labelColor ?? Colors.redAccent,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 5.0)),
              TextSpan(
                text: value,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        )
      ],
    ),
  );
}


class DateTimeFormatterWidget extends StatelessWidget {
  final String label;
  final DateTime dateTime;

  const DateTimeFormatterWidget({Key? key, required this.label, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d, y');
    final formattedDate = formatter.format(dateTime);

    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(width: 5.0),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
