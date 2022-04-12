import 'package:blindside/core/models/video_model.dart';

abstract class IVideoService {
  /// [Future]<[List<VideoModel>]> Fetches the videos from the database
  ///
  /// Parameters: null
  Future<List<VideoModel>> fetchVideos();
}
