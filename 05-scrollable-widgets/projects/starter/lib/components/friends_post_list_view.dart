import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class PostListView extends StatelessWidget {
  const PostListView({Key? key, required this.friendPost}) : super(key: key);

  final List<Post> friendPost;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Text('Social Chefs ', style: Theme.of(context).textTheme.headline1),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friendPost.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FriendsPostTile(post: friendPost[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
