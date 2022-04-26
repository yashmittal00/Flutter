import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TileCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  const TileCard({
    Key? key,
    this.title,
    this.description,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title == null && description == null && imageUrl == null
        ? const SizedBox.shrink()
        : Card(
            shadowColor: Colors.grey,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (description != null)
                          Flexible(
                            child: Text(
                              description ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  if (imageUrl != null)
                    CachedNetworkImage(
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl.toString(),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                ],
              ),
            ),
          );
  }
}
