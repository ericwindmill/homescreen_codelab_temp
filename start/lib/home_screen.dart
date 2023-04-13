import 'package:flutter/material.dart';
// New: Add this import
import 'package:home_widget/home_widget.dart';

import 'article_screen.dart';
import 'news_data.dart';

// New: Add these constants
const String appGroupId = 'group.leighawidget';
const String iOSWidgetName = 'NewsWidgets';
const String androidWidgetName = 'NewsWidget';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String newHeadline;

  // New: Add initState
  @override
  void initState() {
    super.initState();

    // Set the group ID
    HomeWidget.setAppGroupId(appGroupId);

    // Mock read in some data and update the headline
    final newHeadline = getNewsStories()[0];
    updateHeadlineDataForHomescreenWidget(newHeadline);
  }

  // New: add this method
  void updateHeadlineDataForHomescreenWidget(NewsArticle newHeadline) {
    // Save the article data to the native database
    HomeWidget.saveWidgetData<String>(
      'headline_title',
      newHeadline.title,
    );
    HomeWidget.saveWidgetData<String>(
      'headline_description',
      newHeadline.description,
    );

    // Tell the home screen widgets to re-render
    HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: androidWidgetName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              child: Row(
                children: [
                  Text(
                    'Top Stories',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineLarge!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, idx) {
                  return const Divider();
                },
                itemCount: getNewsStories().length,
                itemBuilder: (context, idx) {
                  final article = getNewsStories()[idx];
                  return ListTile(
                    key: Key("$idx ${article.hashCode}"),
                    title: Text(article.title!),
                    subtitle: Text(article.description!),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ArticleScreen(article: article);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
