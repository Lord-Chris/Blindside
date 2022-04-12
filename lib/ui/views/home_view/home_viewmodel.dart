import 'dart:async';

import 'package:blindside/app/_app.dart';
import 'package:blindside/core/mixins/toast_mixin.dart';
import 'package:blindside/core/models/video_model.dart';
import 'package:blindside/services/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewmodel extends StreamViewModel with ToastMixin {
  final _authService = locator<IAuthenticationService>();
  final _videoService = locator<IVideoService>();
  final _navService = locator<NavigationService>();

  List<VideoModel> videos = [];

  void onInit() async {
    fetchVideo();
  }

  Future<void> fetchVideo() async {
    setBusy(true);
    videos = await _videoService.fetchVideos();
    setBusy(false);
  }

  Future<void> signOutUser() async {
    await _authService.logOut();
    _navService.replaceWith(Routes.loginView);
  }

  @override
  Stream<List> get stream => const Stream.empty();

  void navigateToVideo(VideoModel data) {
    _navService.navigateTo(Routes.videoDetailView,
        arguments: VideoDetailViewArguments(video: data));
  }
}
