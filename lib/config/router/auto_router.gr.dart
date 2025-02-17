// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:beier_app2/view/auth/auth_page.dart' as _i1;
import 'package:beier_app2/view/download/download_page.dart' as _i2;
import 'package:beier_app2/view/home/home_page.dart' as _i3;
import 'package:beier_app2/view/questions/question_page.dart' as _i4;
import 'package:beier_app2/view/test_detail/test_detail_page.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AuthPage(),
      );
    },
    DownloadPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DownloadPage(),
      );
    },
    HomePage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomePage(),
      );
    },
    QuestionPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.QuestionPage(),
      );
    },
    TestDetailPage.name: (routeData) {
      final args = routeData.argsAs<TestDetailPageArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.TestDetailPage(testName: args.testName),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthPage]
class AuthPage extends _i6.PageRouteInfo<void> {
  const AuthPage({List<_i6.PageRouteInfo>? children})
      : super(
          AuthPage.name,
          initialChildren: children,
        );

  static const String name = 'AuthPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DownloadPage]
class DownloadPage extends _i6.PageRouteInfo<void> {
  const DownloadPage({List<_i6.PageRouteInfo>? children})
      : super(
          DownloadPage.name,
          initialChildren: children,
        );

  static const String name = 'DownloadPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomePage extends _i6.PageRouteInfo<void> {
  const HomePage({List<_i6.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.QuestionPage]
class QuestionPage extends _i6.PageRouteInfo<void> {
  const QuestionPage({List<_i6.PageRouteInfo>? children})
      : super(
          QuestionPage.name,
          initialChildren: children,
        );

  static const String name = 'QuestionPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TestDetailPage]
class TestDetailPage extends _i6.PageRouteInfo<TestDetailPageArgs> {
  TestDetailPage({
    required String testName,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          TestDetailPage.name,
          args: TestDetailPageArgs(testName: testName),
          initialChildren: children,
        );

  static const String name = 'TestDetailPage';

  static const _i6.PageInfo<TestDetailPageArgs> page =
      _i6.PageInfo<TestDetailPageArgs>(name);
}

class TestDetailPageArgs {
  const TestDetailPageArgs({required this.testName});

  final String testName;

  @override
  String toString() {
    return 'TestDetailPageArgs{testName: $testName}';
  }
}
