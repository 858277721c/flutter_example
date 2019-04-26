import 'package:flutter/material.dart';

import 'ext.dart';

class FBText extends FWidgetBuilder {
  String data;
  TextStyle style;
  StrutStyle strutStyle;
  TextAlign textAlign;
  TextDirection textDirection;
  Locale locale;
  bool softWrap;
  TextOverflow overflow;
  double textScaleFactor;
  int maxLines;
  String semanticsLabel;

  Text build(String data) {
    data ??= this.data;
    data ??= '';

    return Text(
      data,
      key: this.key,
      style: this.style,
      strutStyle: this.strutStyle,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      locale: this.locale,
      softWrap: this.softWrap,
      overflow: this.overflow,
      textScaleFactor: this.textScaleFactor,
      maxLines: this.maxLines,
      semanticsLabel: this.semanticsLabel,
    );
  }
}

class FBRichText extends FWidgetBuilder {
  TextSpan text;
  TextAlign textAlign = TextAlign.start;
  TextDirection textDirection;
  bool softWrap = true;
  TextOverflow overflow = TextOverflow.clip;
  double textScaleFactor = 1.0;
  int maxLines;
  Locale locale;
  StrutStyle strutStyle;

  RichText build(TextSpan text) {
    text ??= this.text;
    text ??= TextSpan(text: '');

    return RichText(
      key: this.key,
      text: text,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      softWrap: this.softWrap,
      textScaleFactor: this.textScaleFactor,
      maxLines: this.maxLines,
      locale: this.locale,
      strutStyle: this.strutStyle,
    );
  }
}
