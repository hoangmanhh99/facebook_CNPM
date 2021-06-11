import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;

  // bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  String text;
  bool canExpand = false;
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    //
    canExpand = widget.text != null && widget.text.length >= 100;
    text = canExpand
        ? (isExpand ? widget.text : widget.text.substring(0, 100))
        : (widget.text);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(TextSpan(children: [
          TextSpan(children: linkify(text.trim())),
          if (canExpand)
            TextSpan(
              text: isExpand ? '\n\n thu gọn' : ' ... xem thêm',
              style: TextStyle(color: kColorGrey),
              recognizer: TapGestureRecognizer(debugOwner: true)
                ..onTap = () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
            )
        ])),
      ],
    );
    //: Text(text != null ? text : "");
  }
}

Text buildTextWithLinks(String textToLink, {String text}) =>
    Text.rich(TextSpan(children: linkify(textToLink)));

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

const String urlPattern =
    r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
const String emailPattern = r'\S+@\S+';
const String phonePattern = r'[\d-]{9,}';
final RegExp linkRegExp = RegExp(
    '($urlPattern)|($emailPattern)|($phonePattern)',
    caseSensitive: false);

WidgetSpan buildLinkComponent(String text, String linkToOpen) => WidgetSpan(
    child: InkWell(
      child: Text(
        text,
        style: TextStyle(
          color: kColorBlue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () => openUrl(linkToOpen),
    ));

List<InlineSpan> linkify(String text) {
  final List<InlineSpan> list = <InlineSpan>[];
  final RegExpMatch match = linkRegExp.firstMatch(text);
  if (match == null) {
    list.add(TextSpan(text: text));
    return list;
  }

  if (match.start > 0) {
    list.add(TextSpan(text: text.substring(0, match.start)));
  }

  final String linkText = match.group(0);
  if (linkText.contains(RegExp(urlPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, linkText));
  } else if (linkText.contains(RegExp(emailPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'mailto:$linkText'));
  } else if (linkText.contains(RegExp(phonePattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'tel:$linkText'));
  } else {
    throw 'Unexpected match: $linkText';
  }

  list.addAll(linkify(text.substring(match.start + linkText.length)));

  return list;
}
