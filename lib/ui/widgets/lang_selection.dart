import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_the_place/helpers/app_settings.dart';
import 'package:save_the_place/localization/localizations.dart';
import 'package:save_the_place/ui/widgets/app_builder.dart';

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
          onTap: () async {
            await AppSettings.setSelectedLanguageCode(locales[index].languageCode);
            CustomLocalizations.load(locales[index]);
            final appBuilder = AppBuilder.of(context);
            if (appBuilder == null) {
              debugPrint('appBuilder == null');
            } else {
              appBuilder.rebuild();
            }
            Navigator.of(context).pop();
          },
        );
      },
      itemCount: locales.length,
    );
  }
}
