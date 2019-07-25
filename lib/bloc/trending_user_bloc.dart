import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base_ui/flutter_base_ui.dart';
import 'package:flutter_common_util/flutter_common_util.dart';
import 'package:open_git/bean/trending_user_bean.dart';
import 'package:open_git/manager/trending_manager.dart';

class TrendingUserBloc extends BaseListBloc<TrendingUserBean> {
  static final String TAG = "TrendingUserBloc";

  String language, since;

  bool _isInit = false;

  TrendingUserBloc(this.language, this.since);

  @override
  PageType getPageType() {
    return PageType.trending_user;
  }

  @override
  void initData(BuildContext context) async {
    if (_isInit) {
      return;
    }
    _isInit = true;

    _showLoading();
    await _fetchTrendList();
    _hideLoading();

    refreshStatusEvent();
  }

  void refreshData({String language, String since}) async {
    this.language = language ?? this.language;
    this.since = since ?? this.since;

    _showLoading();
    await _fetchTrendList();
    _hideLoading();
  }

  @override
  Future getData() async {
    await _fetchTrendList();
  }

  Future _fetchTrendList() async {
    LogUtil.v('_fetchTrendList', tag: TAG);
    try {
      var result = await TrendingManager.instance.getUser(language, since);
      if (bean.data == null) {
        bean.data = List();
      }
      bean.data.clear();
      if (result != null) {
        bean.data.addAll(result);
      }
      sink.add(bean);
    } catch (_) {}
  }

  void _showLoading() {
    bean.isLoading = true;
    sink.add(bean);
  }

  void _hideLoading() {
    bean.isLoading = false;
    sink.add(bean);
  }
}