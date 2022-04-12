import 'package:blindside/core/models/video_model.dart';
import 'package:blindside/services/_services.dart';
import 'package:stacked/stacked.dart';

import '../../../app/_app.dart';

class VideoDetailViewModel extends BaseViewModel {
  final _authService = locator<IAuthenticationService>();
  bool showComments = true;
  List<Comment> addedComments = [];
  bool amountIsEmpty = true;

  void toggleComments() {
    showComments = !showComments;
    notifyListeners();
  }

  Future<void> addComment(String comment) async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 1));
    addedComments.add(Comment(
      comment: comment,
      name: username,
    ));
    amountIsEmpty = true;
    setBusy(false);
  }

  void onCommentFieldChanged(String val) {
    if ((amountIsEmpty && val.isNotEmpty) || (!amountIsEmpty && val.isEmpty)) {
      amountIsEmpty = val.isEmpty;
      notifyListeners();
    }
  }

  String get username => _authService.currentUser!.email!
      .substring(0, _authService.currentUser!.email!.indexOf("@"));
}
