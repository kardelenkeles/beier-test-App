import 'package:auto_route/auto_route.dart';
import 'package:beier_app2/config/router/auto_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomePage.page),
        AutoRoute(page: AuthPage.page, initial: true),
        AutoRoute(page: QuestionPage.page),
        AutoRoute(page: TestDetailPage.page),
        AutoRoute(page: DownloadPage.page),
      ];
}
