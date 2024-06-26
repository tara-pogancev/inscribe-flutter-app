import 'package:flutter/material.dart';
import 'package:inscribe/core/consts.dart';
import 'package:inscribe/core/presentation/app_color_scheme.dart';
import 'package:inscribe/core/presentation/app_text_styles.dart';

class AppDropdownFormField extends StatefulWidget {
  const AppDropdownFormField(
      {super.key,
      required this.label,
      required this.items,
      this.icon,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.onChanged});

  final String label;
  final List<String> items;
  final IconData? icon;
  final Function(String? value)? onSaved;
  final Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final String? initialValue;

  @override
  State<AppDropdownFormField> createState() => _AppDropdownFormFieldState();
}

class _AppDropdownFormFieldState extends State<AppDropdownFormField> {
  dynamic _selectedItem;

  @override
  void initState() {
    setState(() {
      _selectedItem = widget.initialValue;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: formFieldBottomPadding),
      child: DropdownButtonFormField<String>(
        items: widget.items
            .map(
              (String e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: AppTextStyles.of(context).defaultText,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedItem = value;
          });
          widget.onChanged?.call(value);
        },
        value: _selectedItem,
        onSaved: (newValue) => widget.onSaved?.call(newValue),
        validator: (value) => widget.validator?.call(value),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: BorderSide(color: AppColorScheme.of(context).black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: BorderSide(color: AppColorScheme.of(context).black),
          ),
          suffixIcon: (widget.icon != null) ? Icon(widget.icon) : null,
          label: Text(
            widget.label,
            style: AppTextStyles.of(context).grayFormLabel,
          ),
        ),
      ),
    );
  }
}
