import 'package:flutter/material.dart';

class ReusableListTile extends StatelessWidget {
  final String? avatarImagePath;
  final String titleText;
  final String subtitleLocation;
  final String subtitleTravel;
  final String? subtitleTravelIcon;
  final String subtitleDaysAgo;
  final String trailingCount;
  final String? trailingText;
  final String? trailingIconPath;
  final String? selectedContactInitial;

  final Color? color;
  final Color? textcolor;

  const ReusableListTile({
    Key? key,
    this.avatarImagePath,
    required this.titleText,
    required this.subtitleLocation,
    required this.subtitleTravel,
    required this.subtitleDaysAgo,
    required this.trailingCount,
    this.trailingText,
    this.subtitleTravelIcon,
    this.trailingIconPath,
    this.selectedContactInitial,
    this.color = const Color(0xff1C9611),
    this.textcolor = const Color(0xff5CAF9F),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xff5CAF9F),
          child: selectedContactInitial != null
              ? Text(
                  selectedContactInitial!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(avatarImagePath!),
                )),
      title: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  subtitleLocation,
                  style: const TextStyle(
                    color: Color(0xffC1C5C8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  subtitleTravel,
                  style: const TextStyle(
                    color: Color(0xffC1C5C8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                Image(
                  height: 13,
                  color: textcolor,
                  image: subtitleTravelIcon != null
                      ? AssetImage(subtitleTravelIcon!)
                      : const AssetImage(
                          ''), // Replace 'assets/placeholder.png' with the path to a default placeholder image
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitleDaysAgo,
              style: const TextStyle(
                color: Color(0xffC1C5C8),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailingIconPath == null
                      ? Text('')
                      : Image(
                          height: 15,
                          image: AssetImage(trailingIconPath.toString())),
                  Text(
                    trailingCount,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                trailingText!,
                style: const TextStyle(
                  color: Color(0xffC1C5C8),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
