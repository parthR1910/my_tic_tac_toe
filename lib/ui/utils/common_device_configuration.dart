import 'package:tic_toc_toe/ui/utils/theme/theme.dart';

mobileConfiguration(BuildContext context) {
  return ScreenUtil.init(context,
      designSize: const Size(375, 812), minTextAdapt: true);
}

webConfiguration(BuildContext context) {
  return ScreenUtil.init(context,
      designSize: const Size(1920, 1080), minTextAdapt: true);
}
