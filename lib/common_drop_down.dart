import 'package:flutter/material.dart';

enum DropDownType { primary, secondary }

class AppDropDownTextField extends StatefulWidget {
  final String? hintText;
  final String textFieldName;
  final DropDownType? dropDownType;
  final String? value;
  final List<String>? dropDownItemsList;
  final bool isRequired;
  final bool readOnly;
  final void Function(String?) onChanged;
  const AppDropDownTextField({
    super.key,
    this.dropDownType,
    this.hintText,
    required this.textFieldName,
    this.value,
    this.dropDownItemsList,
    required this.isRequired,
    required this.readOnly,
    required this.onChanged,
  });
  @override
  State<AppDropDownTextField> createState() => _AppDropDownTextFieldState();
}

class _AppDropDownTextFieldState extends State<AppDropDownTextField>
    with AutomaticKeepAliveClientMixin {
  String value = "";
  bool isCompulsory = false;
  @override
  void initState() {
    super.initState();
    value = widget.value!;
    isCompulsory = widget.isRequired;
    print("object");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final stopsValue = Responsive.isiPad(context) ? 0.01 : 0.02;
    print("dropdown isRequired:${widget.isRequired}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.textFieldName,
          style: TextStyle(color: Colors.red),
          // style: AppTextStyle.appTextStyleH3(context),
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: widget.dropDownType != DropDownType.secondary
                ? Colors.white
                : Colors.transparent,
            border: widget.dropDownType == DropDownType.secondary
                ? Border.all(color: Colors.white)
                : null,
            gradient: widget.dropDownType != DropDownType.secondary
                ? isCompulsory
                    ? LinearGradient(
                        stops: [0, 1],
                        colors: const [Colors.red, Colors.white],
                      )
                    : null
                : null,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              style: TextStyle(color: Colors.black),
              // style: Responsive.isiPad(context)
              //     ? AppTextStyle.appTextStyleSmall(context).copyWith(
              //         color: widget.dropDownType == DropDownType.secondary
              //             ? Colors.white
              //             : Colors.black)
              //     : AppTextStyle.appTextStyleSmall(context).copyWith(
              //         overflow: TextOverflow.ellipsis,
              //         color: widget.dropDownType == DropDownType.secondary
              //             ? Colors.white
              //             : Colors.black,
              //       ),
              items: widget.dropDownItemsList!
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: widget.readOnly
                  ? null
                  : (String? val) {
                      print("dropdown:$val");
                      //if (val != null) {
                      isCompulsory = false;
                      //if (val == "Select one option") {
                      // isCompulsory = true;
                      //}
                      setState(() {
                        if (val == null) return;
                        value = val;
                        print("dropdown:$val");
                      });
                      widget.onChanged(val);
                      //}
                    },
              hint: Text(
                widget.dropDownType == DropDownType.secondary
                    ? ""
                    : "Please select",
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: widget.dropDownType == DropDownType.secondary
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
