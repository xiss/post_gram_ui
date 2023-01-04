import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';

class AuthorHeaderWidget extends StatelessWidget {
  final Future<NetworkImage?>? _avatar;
  final String _name;
  final DateTime _created;
  final DateTime? _edited;
  const AuthorHeaderWidget({
    Key? key,
    required avatar,
    required name,
    required created,
    edited,
  })  : _avatar = avatar,
        _created = created,
        _edited = edited,
        _name = name,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //avatar
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
          child: FutureBuilder(
            future: _avatar,
            builder: (_, snapshot) {
              return CircleAvatar(foregroundImage: snapshot.data);
            },
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //author name
            Text(
              _name,
              style: FontStyles.getHeaderTextStyle(),
            ),
            //created
            Text(
              DateFormat('dd.MM.yyyy hh:mm').format(
                _created.toLocal(),
              ),
              style: FontStyles.getSmallTextStyle(),
            ),
            //edited
            _edited != null
                ? Text(
                    "edited: ${DateFormat('dd.MM.yyyy hh:mm').format(
                      _edited!.toLocal(),
                    )}",
                    style: FontStyles.getSmallTextStyle(),
                  )
                : const Text(""),
          ],
        )
      ],
    );
  }
}
