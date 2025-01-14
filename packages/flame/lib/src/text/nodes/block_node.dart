import 'package:flame/src/text/elements/element.dart';
import 'package:flame/src/text/elements/group_element.dart';
import 'package:flame/src/text/elements/rect_element.dart';
import 'package:flame/src/text/elements/rrect_element.dart';
import 'package:flame/src/text/styles/background_style.dart';

/// An abstract base class for all entities with "block" placement rules.
abstract class BlockNode {
  Element? makeBackground(BackgroundStyle? style, double width, double height) {
    if (style == null) {
      return null;
    }
    final out = <Element>[];
    final backgroundPaint = style.backgroundPaint;
    final borderPaint = style.borderPaint;
    final borders = style.borderWidths;
    final radius = style.borderRadius;

    if (backgroundPaint != null) {
      if (radius == 0) {
        out.add(RectElement(width, height, backgroundPaint));
      } else {
        out.add(RRectElement(width, height, radius, backgroundPaint));
      }
    }
    if (borderPaint != null) {
      if (radius == 0) {
        out.add(
          RectElement(
            width - borders.horizontal / 2,
            height - borders.vertical / 2,
            borderPaint,
          )..translate(borders.left / 2, borders.top / 2),
        );
      } else {
        out.add(
          RRectElement(
            width - borders.horizontal / 2,
            height - borders.vertical / 2,
            radius,
            borderPaint,
          )..translate(borders.left / 2, borders.top / 2),
        );
      }
    }
    if (out.isEmpty) {
      return null;
    }
    if (out.length == 1) {
      return out.first;
    } else {
      return GroupElement(width, height, out);
    }
  }
}
