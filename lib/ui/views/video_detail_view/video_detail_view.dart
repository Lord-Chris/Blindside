import 'package:blindside/core/models/video_model.dart';
import 'package:blindside/ui/components/_components.dart';
import 'package:blindside/ui/constants/_constants.dart';
import 'package:blindside/ui/views/video_detail_view/video_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoDetailView extends StatelessWidget {
  final VideoModel video;
  VideoDetailView({
    Key? key,
    required this.video,
  }) : super(key: key);

  final _commentController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoDetailViewModel>.reactive(
      viewModelBuilder: () => VideoDetailViewModel(),
      onModelReady: (model) {
        model.initiaizePlayer(video.link);
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _scrollController.jumpTo(video.comments.length.toDouble());
        });
      },
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            video.title,
            style: kAppbarStyle,
          ),
          actions: [
            Visibility(
              visible: model.videoController!.value.isInitialized,
              child: IconButton(
                onPressed: () => model.pausePlay(),
                icon: Icon(
                  (model.videoController?.value.isPlaying ?? false)
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 25,
                  color: AppColors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () => model.toggleComments(),
              icon: Icon(
                model.showComments ? Icons.visibility_off : Icons.visibility,
                size: 25,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox.expand(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Visibility(
                    visible: model.videoController!.value.isInitialized,
                    child: AspectRatio(
                      aspectRatio: model.videoController!.value.aspectRatio,
                      child: VideoPlayer(model.videoController!),
                    ),
                    replacement: Image.network(
                      video.picture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Visibility(
                visible: model.showComments,
                replacement: const Center(
                  child: Text(
                    "Comments have been turned off",
                    style: kBodyStyle,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              controller: _scrollController,
                              itemCount:
                                  (video.comments + model.addedComments).length,
                              itemBuilder: (__, index) {
                                final comments =
                                    (video.comments + model.addedComments)
                                        .reversed
                                        .toList();
                                final comment = comments[index];
                                return Visibility(
                                  visible: model.showComments,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: AppColors.main,
                                          child: Icon(
                                            Icons.person,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        const XMargin(20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                comment.name,
                                                style: kBodyStyle,
                                              ),
                                              const YMargin(10),
                                              Text(
                                                comment.comment,
                                                style: kSubBodyStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const YMargin(10),
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Related Videos",
                                style: kMainStyle,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              padding: const EdgeInsets.all(16),
                              controller: _scrollController,
                              itemBuilder: (__, index) {
                                return RelatedVideoCard(data: video);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              hint: "Add a comment",
                              controller: _commentController,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: model.onCommentFieldChanged,
                            ),
                          ),
                          const XMargin(10),
                          AppButton(
                            width: 100,
                            height: 70,
                            borderRadius: 5,
                            isBusy: model.isBusy,
                            onTap: () {
                              final comment = _commentController.text;
                              _commentController.clear();
                              model.addComment(comment);
                              _scrollController.jumpTo(0);
                            },
                            label: "Post",
                            enabled: _commentController.text.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RelatedVideoCard extends StatelessWidget {
  final VideoModel data;
  const RelatedVideoCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox.expand(
                child: Image.network(
                  data.picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: kMainStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "QUALITY: ${data.quality.toUpperCase()}",
                      style: kSubBodyStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
