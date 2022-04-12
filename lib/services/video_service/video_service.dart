import 'package:blindside/app/app_setup.locator.dart';
import 'package:blindside/core/models/video_model.dart';
import 'package:blindside/services/_services.dart';
import 'package:blindside/ui/constants/app_strings.dart';
import 'package:blindside/ui/constants/videos.dart';

class VideoService extends IVideoService {
  final _storageService = locator<IStorageService>();
  @override
  Future<List<VideoModel>> fetchVideos() async {
    await Future.delayed(const Duration(seconds: 2));
    final res = _storageService.getMap(AppStrings.videoData, def: data);
    return (res!["video_files"] as List)
        .map((e) => VideoModel.fromMap(e))
        .toList();
  }
}
