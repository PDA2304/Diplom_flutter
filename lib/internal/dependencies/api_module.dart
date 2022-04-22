import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/data/api/service/sunrice_service.dart';

class ApiModule {
  static ApiUtil? _apiUtil;

  static ApiUtil apiUtil() {
    _apiUtil ??= ApiUtil(SunriseService());
    return _apiUtil!;
  }
}
