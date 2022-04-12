import 'package:blindside/core/models/video_model.dart';
import 'package:blindside/ui/constants/videos.dart';

import 'i_video_service.dart';

class VideoService extends IVideoService {
  @override
  Future<List<VideoModel>> fetchVideos() async {
    await Future.delayed(const Duration(seconds: 2));
    return (data["video_files"] as List).map((e) => VideoModel.fromMap(e)).toList();
  }
}
