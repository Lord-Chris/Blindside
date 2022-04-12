import 'package:blindside/core/models/video_model.dart';
import 'package:blindside/ui/constants/_constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: const Text(
              AppStrings.appName,
              style: kAppbarStyle,
            ),
            actions: [
              IconButton(
                onPressed: () => model.signOutUser(),
                icon: const Icon(
                  Icons.logout,
                  size: 25,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Visibility(
                    visible: model.isBusy,
                    child: Container(
                      color: Colors.black12,
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    replacement: Visibility(
                      visible: model.videos.isEmpty,
                      child: const Center(
                        child: Text(
                          "No videos yet",
                          style: kBodyStyle,
                        ),
                      ),
                      replacement: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.videos.length,
                        itemBuilder: (__, index) {
                          final data = model.videos[index];
                          return VideoInfoTile(data: data);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class VideoInfoTile extends ViewModelWidget<HomeViewmodel> {
  const VideoInfoTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final VideoModel data;

  @override
  Widget build(BuildContext context, HomeViewmodel viewModel) {
    return SizedBox(
      height: 150,
      child: InkWell(
        onTap: () => viewModel.navigateToVideo(data),
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
      ),
    );
  }
}
