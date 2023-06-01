import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton2 extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = const Offset(0, 0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          // To avoid long text overflowing.

          isExpanded: true,
          hint: Container(
            width: 50,
            alignment: hintAlignment,
            child: Text(
              hint,
              // overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 13,
                color: value == null ? Colors.black : Colors.green,
              ),
            ),
          ),
          value: value ?? dropdownItems.first,
          items: dropdownItems
              .asMap()
              .entries
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.value,
                  child: Container(
                    alignment: valueAlignment,
                    child: Text(
                      item.value,
                      // overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 13,
                        color: value == item.value
                            ? const Color(0xff5CAF9F)
                            : null,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: selectedItemBuilder,
          buttonStyleData: ButtonStyleData(
            height: buttonHeight ?? 22,
            padding: buttonPadding ??
                const EdgeInsets.only(
                  left: 2,
                ),
            decoration: buttonDecoration ??
                BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xff5CAF9F),
                  ),
                ),
            elevation: buttonElevation,
          ),
          iconStyleData: IconStyleData(
            // Remove the existing icon widget
            iconSize: iconSize ?? 12,
            iconEnabledColor: iconEnabledColor,
            iconDisabledColor: iconDisabledColor,
            icon: Container(
              height: 10,
              child: Image.asset(
                'assets/down_icon.png', // Replace with the actual path to your image
                width: 24, // Adjust the width and height as needed
                height: 24,
              ),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            // Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null, it will take the max height possible for the items.
            maxHeight: dropdownHeight ?? 200,
            padding: dropdownPadding,
            decoration: dropdownDecoration ??
                BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xff5CAF9F))),
            elevation: dropdownElevation ?? 0,
            // Null or Offset(0, 0) will open just under the button. You can edit as you want.
            offset: offset,
            // Default is false to show the menu below the button
            isOverButton: false,
            scrollbarTheme: ScrollbarThemeData(
              radius: scrollbarRadius ?? const Radius.circular(40),
              thickness: scrollbarThickness != null
                  ? MaterialStateProperty.all<double>(scrollbarThickness!)
                  : null,
              thumbVisibility: scrollbarAlwaysShow != null
                  ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                  : null,
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: itemHeight ?? 40,
            padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
