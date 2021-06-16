import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/theme/app_theme.dart';

main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Despesas Pessoais',
        initialRoute: Routes.INITIAL,
        getPages: AppPages.routes,
        theme: appThemeData,
      ),
    );
