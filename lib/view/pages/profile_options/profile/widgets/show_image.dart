import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../data/tools/file_importer.dart';

class ShowImage extends StatefulWidget {
  ProfileController controller;
  ShowImage({super.key, required this.controller});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: (widget.controller.photoUrl.isNotEmpty)?
              CachedNetworkImage(
                imageUrl: widget.controller.photoUrl,
                placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) => Image.network(Get.find<AuthHolder>().photoUrl, height: 120.h, width: 120.w, fit: BoxFit.fitWidth),
                height: 120.h, width: 120.h, fit: BoxFit.fitWidth,)
                  :Image.network('https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg',
                  height: 120.h, width: 120.h, fit: BoxFit.fitWidth)
          ),
        ),
      ],
    );
  }
}
