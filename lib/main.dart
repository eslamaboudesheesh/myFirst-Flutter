import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//StatelessWidget referr to static elements
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
// title here show when open multi app can see this title
    return MaterialApp(
      // remove debuge mode 
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
        theme: ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.white,
         ),
      // Scaffold its mataril desggin widgt
      home: Scaffold(
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
    
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // sugg it's  private array from wordpair package content all item
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
 final Set<WordPair> _saved = Set<WordPair>();   // Add this line.


// first widget about title and randing listview of item
  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>( 
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordPair pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();

          return Scaffold(         
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );                    
      },
    ),       );
  }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
         actions: <Widget>[      // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],  


      ),
      
      
      body: _buildSuggestions(),
    );
  }



  Widget _buildSuggestions() {
    return ListView.builder(
        //Edginsetes it offset
        padding: const EdgeInsets.all(16.0),
        // itemBuilder take two paramter
        itemBuilder: (context, i) {
          if (i.isOdd)
            return Divider(); // divider its mataril desgin take one pixel space between element in list view

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            // addAll Appends all objects of [iterable] to the end of this list.
            _suggestions.addAll(generateWordPairs().take(10));
            // take like state in kendoui for show 10 element in viewport screan
          }
          return _buildRow(_suggestions[index]);
        });
  }



  Widget _buildRow(WordPair pair) {
      final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    trailing: Icon(   
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ),  
    onTap: () {      
      setState(() {
        if (alreadySaved) {
          _saved.remove(pair);
        } else { 
          _saved.add(pair); 
        } 
      });
    },               
    );
  }
}



/*
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:  'Flutter',
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold( //matarils design widgt
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          backgroundColor: Colors.indigo,
          elevation: 0.6,
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width /2,
          height: MediaQuery.of(context).size.height /2,
            decoration: BoxDecoration(
            border: Border.all(color: Colors.grey , width: 2)
          ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly, // horizantal
                   crossAxisAlignment: CrossAxisAlignment.start, // vertical
                   children: <Widget>[
                   Text('foo'),
                   Text('red'),
                   
                 ],)
                             
        ),
      );
  }
}


 */
