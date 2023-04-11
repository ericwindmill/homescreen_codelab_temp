import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/news_data.dart';

// This should be removed when HomeWidget package is updated
extension HomeWidgetRenderExtension on HomeWidget {
  /// Generate a screenshot based on the build context of a widget.
  /// This method renders the widget to an image (png) file with the provided filename.
  /// The png file is saved to the App Group container and the full path is returned as a string.
  /// The filename is optionally saved to UserDefaults using the provided key.
  static Future<String?> renderFlutterWidget(
    String appGroupId,
    BuildContext context,
    String filename,
    String? key,
  ) async {
    // Get the render object for the widget
    //   final RenderRepaintBoundary boundary =
    //       context.findRenderObject() as RenderRepaintBoundary;
    //
    //   // Create a screenshot of the widget
    //   final image = await boundary.toImage(
    //       pixelRatio: MediaQuery.of(context).devicePixelRatio);
    //   final byteData = await image.toByteData(format: ImageByteFormat.png);
    //
    //   // Save the screenshot to a file in the app group container
    //   // final PathProviderFoundation provider = PathProviderFoundation();
    //   try {
    //     final String? directory = await provider.getContainerPath(
    //       appGroupIdentifier: appGroupId,
    //     );
    //     final String path = '$directory/$filename.png';
    //     final File file = File(path);
    //     await file.writeAsBytes(byteData!.buffer.asUint8List());
    //
    //     // Save the filename to UserDefaults if a key was provided
    //     if (key != null) {
    //       _channel.invokeMethod<bool>('saveWidgetData', {
    //         'id': key,
    //         'data': '$filename.png',
    //       });
    //     }
    //     return path;
    //   } catch (e) {
    //     throw Exception('Failed to save screenshot to app group container: $e');
    //   }
  }
}

class ArticleScreen extends StatefulWidget {
  final NewsArticle article;

  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final _globalKey = GlobalKey();
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_globalKey.currentContext != null) {
            // var path = await HomeWidget.renderFlutterWidget(
            //   'group.leighawidget',
            //   _globalKey.currentContext!,
            //   "screenshot",
            //   "filename",
            // );
            setState(() {
              // imagePath = path;
            });
          }
        },
        label: const Text('Update Homescreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.article.image != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Image.asset('assets/images/${widget.article.image}'),
                  ),
                ),
              const SizedBox(height: 10.0),
              Text(
                widget.article.description!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20.0),
              Text(widget.article.articleText!),
              const SizedBox(height: 20.0),
              Center(
                child: RepaintBoundary(
                  key: _globalKey,
                  child: CustomPaint(
                    painter: LineChartPainter(),
                    child: const SizedBox(
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(widget.article.articleText!),
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dataPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final markingLinePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final mockDataPoints = [
      const Offset(15, 155),
      const Offset(20, 133),
      const Offset(34, 125),
      const Offset(40, 105),
      const Offset(70, 85),
      const Offset(80, 95),
      const Offset(90, 60),
      const Offset(120, 54),
      const Offset(160, 60),
      const Offset(200, -10),
    ];

    final axis = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);

    final markingLine = Path()
      ..moveTo(-10, 50)
      ..lineTo(size.width + 10, 50);

    final data = Path()..moveTo(1, 180);

    for (var dataPoint in mockDataPoints) {
      data.lineTo(dataPoint.dx, dataPoint.dy);
    }

    canvas.drawPath(axis, axisPaint);
    canvas.drawPath(data, dataPaint);
    canvas.drawPath(markingLine, markingLinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
