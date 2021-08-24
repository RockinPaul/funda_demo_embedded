import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda_demo/blocs/details_cubit/details_cubit.dart';
import 'package:funda_demo/blocs/feed_cubit/feed_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:funda_demo/domain/models/feed_item.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    // Make sure State object has mounted in order to access its context.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<FeedCubit>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: SafeArea(
        child: BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state) {
            if (state is FeedLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FeedLoadFailure) {
              return Center(child: Text('${state.message}'));
            }
            if (state is FeedLoadSuccess) {
              final feed = state.feed;
              final objects = feed.items;

              return ListView.separated(
                itemCount: objects.length,
                padding: EdgeInsets.only(top: 3),
                separatorBuilder: (context, index) => const SizedBox(height: 3),
                itemBuilder: (context, index) {
                  final object = objects[index];
                  return FeedTile(item: object);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class FeedTile extends StatelessWidget {
  final FeedItem item;

  const FeedTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final imageUrl = item.photo;
    final address = item.address;
    final postcode = item.postal;
    final price = item.price;

    return GestureDetector(
      onTap: () {
        context.read<DetailsCubit>().retrieve(object: item);
        Navigator.of(context).pushNamed('/details');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(3.0),
        margin: const EdgeInsets.all(3.0),
        color: theme.cardColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 5.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: imageUrl,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(address,
                        textAlign: TextAlign.right, style: textTheme.bodyText1),
                    Text(postcode,
                        textAlign: TextAlign.right, style: textTheme.bodyText1),
                    Text(price,
                        textAlign: TextAlign.right, style: textTheme.headline5),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
