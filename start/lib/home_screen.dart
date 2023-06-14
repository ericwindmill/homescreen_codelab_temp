import 'package:flutter/material.dart';

import 'article_screen.dart';
import 'news_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String newHeadline;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          )),
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Top Stories'),
            centerTitle: false,
            titleTextStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        body: ListView.separated(
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
      // child: Padding(
      //   padding: const EdgeInsets.all(0.0),
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 30),
      //       Container(
      //         padding: const EdgeInsets.all(16.0),
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).colorScheme.tertiaryContainer,
      //         ),
      //         child: Row(
      //           children: [
      //             Text(
      //               'Top Stories',
      //               textAlign: TextAlign.left,
      //               style: Theme.of(context).textTheme.headlineLarge!,
      //             ),
      //           ],
      //         ),
      //       ),
      // const SizedBox(height: 25),
    );
  }
}
