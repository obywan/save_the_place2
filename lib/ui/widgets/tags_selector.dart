import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_the_place/ui/widgets/spinny_thing.dart';

import '../../bloc/places/places_bloc.dart';

class TagsSelector extends StatefulWidget {
  final Function(List<String>) callback;
  const TagsSelector({Key? key, required this.callback}) : super(key: key);

  @override
  State<TagsSelector> createState() => _TagsSelectorState();
}

class _TagsSelectorState extends State<TagsSelector> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state is TagsLoaded) {
          return Container(
            width: double.infinity,
            child: DropDownTextField.multiSelection(
              dropDownList: [...(state.tags.map((e) => DropDownValueModel(name: e, value: e)).toList())],
              onChanged: (val) {
                debugPrint('$val');
              },
              displayCompleteItem: true,
            ),
          );
        }
        return SpinnyThing();
      },
    );
  }
}
