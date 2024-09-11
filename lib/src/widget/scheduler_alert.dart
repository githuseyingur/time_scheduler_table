import 'package:flutter/material.dart';

class SchedulerAlert extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final String? alertTitle;
  final String? hintText;
  final String? textFieldEmptyMessage;
  final int x;
  final int y;
  final bool isAdd;
  final BorderRadiusGeometry? borderRadius;
  final String? addButtonTitle;
  final String? deleteButtonTitle;
  final String? updateButtonTitle;
  final Function()? deleteOnPressed;
  final Function()? addOnPressed;
  final Function()? updateOnPressed;
  final Widget colorWidget;
  final Color? selectedColor;

  const SchedulerAlert(
      {super.key,
      required this.formKey,
      required this.textController,
      this.alertTitle,
      this.hintText,
      this.textFieldEmptyMessage,
      required this.x,
      required this.y,
      required this.isAdd,
      this.borderRadius,
      this.addButtonTitle,
      this.deleteButtonTitle,
      this.updateButtonTitle,
      this.addOnPressed,
      this.deleteOnPressed,
      this.updateOnPressed,
      this.selectedColor,
      required this.colorWidget});

  @override
  State<SchedulerAlert> createState() => _SchedulerAlertState();
}

class _SchedulerAlertState extends State<SchedulerAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius ??
            const BorderRadius.all(Radius.circular(32.0)),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.only(top: 12),
        child: StatefulBuilder(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Text(
                    widget.alertTitle ??
                        (widget.isAdd == true ? "Add Alert" : "Edit Alert"),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
                height: 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Form(
                  key: widget.formKey,
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.textFieldEmptyMessage ??
                            "Cannot be empty..";
                      }
                      return null;
                    },
                    controller: widget.textController,
                    cursorColor: Colors.grey,
                    cursorWidth: 1.2,
                    cursorHeight: 12,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      hintText: widget.hintText ?? "Event Name",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: widget.colorWidget,
              ),
              widget.isAdd == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 12),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.24,
                        child: ElevatedButton(
                            onPressed: widget.addOnPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.selectedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: Text(
                              widget.addButtonTitle ?? "ADD",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.24,
                            child: ElevatedButton(
                                onPressed: widget.deleteOnPressed!,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                ),
                                child: Text(
                                  widget.deleteButtonTitle ?? "DELETE",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.24,
                            child: ElevatedButton(
                                onPressed: widget.updateOnPressed!,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                ),
                                child: Text(
                                  widget.updateButtonTitle ?? "UPDATE",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
