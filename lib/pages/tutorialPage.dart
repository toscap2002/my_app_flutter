import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';



class TutorialPage extends StatefulWidget {
  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/video/videotutorialapiclash.mp4')
      ..initialize().then((_) {
        // Assicurati che il video sia stato inizializzato prima di aggiornare lo stato.
        setState(() {});
      });
  }

  final TutorialContent tutorial = TutorialContent(
    title: "Tutorial App",
    description: "Questa è la descrizione sintetica dell'App...\n" +
        "\nLa versione completa può essere trovata nella tesina in formato .pdf." +
        "\nDurante la creazione del proprio profilo bisogna inserire le corrette credenziali:" +
        "\n--> Il Tag [combinazione alfanumerica preceduta da <<#>>] può essere trovato " +
        "all'interno del prorpio profilo una volta avviato il gioco " +
        "<<Clash of Clans>> sotto il proprio nickname " +
        "(La prima immagine sottostante mostra dove si trova)." +
        "\n--> Il proprio nome" +
        "\n--> Un'email valida" +
        "\n--> Una Password" +
        "\nA seguito della creazione del profilo ed eseguito l'accesso bisogna inserire" +
        "una chiave necessaria ad usare le API di <<Clash of Clans>>." +
        "\nPer far questo bisgna conoscere il proprio indirizzo IP " +
        "(consultabile al primo link evidenziato)." +
        "\nUna volta scoperto il proprio IP bisogna accedere al sito tramite " +
        "il secondo link evidenziato in blu " +
        "(La seconda immagina mostra la schermata del sito) " +
        "fornendo le seguenti credenziali:" +
        "\nEmail: ciao@gmail.com" +
        "\nPassword: voleviEhh" +
        "\nEntrati nel sito bisogna generare una chiave fornendo il proprio indirizzo IP " +
        "(come mostrato nel video guida)." +
        "\nGenerata la chiave bisogna copia/incollarla all'interno della schermata " +
        "apposita, chiamata <<Api Key>>, e presente nell'hamburger menu " +
        "all'interno dell'applicazione " +
        "(La terza immagine mostra la schermata dell'app).",
    linkText1: "Link per l'indirizzo IP",
    linkText2: "Link alla pagina di Clash of Clans",
    linkUrl1: "https://www.ilmioindirizzoip.it/",
    linkUrl2: "https://developer.clashofclans.com/#/login",
    imageResId: "clashapilogin",
    imageTagLocation: "taglocation",
    imageViewApp: "imageviewapp",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Tutorial App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              tutorial.title,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              tutorial.description,
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () => _launchURL(tutorial.linkUrl1),
              child: Row(
                children: [
                  Icon(Icons.link),
                  Text(tutorial.linkText1),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _launchURL(tutorial.linkUrl2),
              child: Row(
                children: [
                  Icon(Icons.link),
                  Text(tutorial.linkText2),
                ],
              ),
            ),
            Image.asset('lib/images/taglocation.jpeg'),
            Image.asset('lib/images/clashapilogin.png'),
            Image.asset('lib/images/imageviewapp.jpeg'),


            SizedBox(height: 16),
         _controller.value.isInitialized
            ? AspectRatio(
             aspectRatio: _controller.value.aspectRatio,
             child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),

            TextButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),

            )],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


class TutorialContent {
  final String title;
  final String description;
  final String linkText1;
  final String linkText2;
  final String linkUrl1;
  final String linkUrl2;
  final String imageResId;
  final String imageTagLocation;
  final String imageViewApp;

  TutorialContent({
    required this.title,
    required this.description,
    required this.linkText1,
    required this.linkText2,
    required this.linkUrl1,
    required this.linkUrl2,
    required this.imageResId,
    required this.imageTagLocation,
    required this.imageViewApp,
  });
}
