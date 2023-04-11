import 'package:flutter/material.dart';
import 'package:homescreen_widgets/news_data.dart';

import 'article_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String newHeadline;

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
