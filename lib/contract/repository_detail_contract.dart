import 'package:open_git/base/base_presenter.dart';
import 'package:open_git/base/i_base_view.dart';
import 'package:open_git/bean/branch_bean.dart';
import 'package:open_git/bean/repos_bean.dart';

abstract class IRepositoryDetailPresenter<V extends IRepositoryDetailView>
    extends BasePresenter<V> {
  void getReposDetail(reposOwner, reposName);

  void getReposStar(reposOwner, reposName);

  void doReposStarAction(reposOwner, reposName, int state);

  void getReposWatcher(reposOwner, reposName);

  void doRepossWatcherAction(reposOwner, reposName, int state);

  void getReadme(reposFullName, branch);

  void getBranches(reposOwner, reposName);
}

abstract class IRepositoryDetailView extends IBaseView {
  void getReposDetailSuccess(Repository repository);

  void setStarState(int state, bool isAction);

  void setWatchState(int state, bool isAction);

  void setReadmeContent(String markdown);

  void setBranches(List<BranchBean> list);
}
