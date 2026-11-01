import 'package:nemoventrt/core/models/translations.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';

TranslationModel appTranslation() =>
    ThemeCubit.currentTranslation ?? TranslationModel.fromJson(const {});
