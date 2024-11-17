import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import '../business_logic/boundary_services/store_provider.dart';

class ColorChanger extends StatelessWidget{
  Future<void> _openColorPicker(context) async {
    bool pickedColor = await ColorPicker(
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      color: Theme.of(context).colorScheme.primary,
      onColorChanged: (Color newColor) {
        StoresHub.themeStore.setTheme(newColor);
      },
      width: 40,
      height: 40,
      borderRadius: 20,
      spacing: 10,
      runSpacing: 10,
      heading: const Text('Pick a color'),
      wheelDiameter: 200,
      wheelWidth: 20,

    ).showPickerDialog(context);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
                borderRadius: const BorderRadius.all(Radius.circular(200)),
                color: Theme.of(context).colorScheme.primary),
          ),
          onTap: ()=> _openColorPicker(context),
        ),

    );
  }
}