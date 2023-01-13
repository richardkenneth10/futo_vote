import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_candidates_controller.dart';

class AdminCandidatesView extends StatelessWidget {
  AdminCandidatesView({super.key});

  final _ = Get.find<AdminCandidatesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voting results',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: GestureDetector(
                onTap: _.goToAddCandidateScreen,
                child: const Text(
                  'Add',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: GestureDetector(
                onTap: _.logOut,
                child: const Text(
                  'Log out',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _.candidates.length,
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => SizedBox(
            height: 80,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _.candidates[index].image,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          placeholder: (context, url) =>
                              const CupertinoActivityIndicator(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _.candidates[index].fullName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _.candidates[index].dept,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${_.candidates[index].votes} V',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        (index + 1) % 10 == 1 &&
                                !((index + 1) <= 20 && (index + 1) >= 10)
                            ? '${(index + 1)}st'
                            : (index + 1) % 10 == 2 &&
                                    !((index + 1) <= 20 && (index + 1) >= 10)
                                ? '${(index + 1)}nd'
                                : (index + 1) % 10 == 3 &&
                                        !((index + 1) <= 20 &&
                                            (index + 1) >= 10)
                                    ? '${(index + 1)}rd'
                                    : '${(index + 1)}th',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () =>
                            _.removeCandidate(context, _.candidates[index]),
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
