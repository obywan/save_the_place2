import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_the_place/localization/localizations.dart';

class LangSelection extends StatelessWidget {
  const LangSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Locale> locales = CustomLocalizations.supportedLocales;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return ListTile(
          title: Text(locales[index].languageCode),
          leading: Container(
            height: 24,
            width: 24,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SvgPicture.asset('assets/svg/${locales[index].languageCode}.svg'),
            ),
          ),
        );
      },
      itemCount: locales.length,
    );
  }
}
