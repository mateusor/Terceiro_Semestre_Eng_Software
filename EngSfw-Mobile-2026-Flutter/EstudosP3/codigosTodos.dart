//==================================================
// LOGIN COM FIREBASE AUTH
//==================================================

// Trata:
// 1) user-not-found
// 2) erro genérico
// 3) esconde loading no finally

Future<void> _fazerLogin() async {

  // Ativa loading
  setState(() => _loading = true);

  try {

    // Faz login com email e senha
    await FirebaseAuth.instance.signInWithEmailAndPassword(

      email: _email,
      password: _senha,
    );

    // Verifica se a tela ainda existe
    if (!mounted) return;

    // Navega para HomeScreen
    Navigator.push(

      context,

      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }

  // Trata erro específico do Firebase
  on FirebaseAuthException catch (e) {

    if (!mounted) return;

    String erro;

    // Usuário não encontrado
    if (e.code == 'user-not-found') {

      erro = 'E-mail não cadastrado';

    } else {

      // Qualquer outro erro
      erro = 'Erro de autenticação';
    }

    // Mostra SnackBar
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(erro),
      ),
    );
  }

  // Trata qualquer outro erro
  catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro inesperado: $e'),
      ),
    );
  }

  // Sempre executa
  finally {

    // Verifica se a tela ainda existe
    if (mounted) {

      // Desativa loading
      setState(() => _loading = false);
    }
  }
}


//==================================================
// CONTADOR - STATEFULWIDGET
//==================================================

class ContadorTela extends StatefulWidget {

  @override
  State<ContadorTela> createState() => _ContadorTelaState();
}

class _ContadorTelaState extends State<ContadorTela> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Contador: $_count'),
      ),

      body: Center(

        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // BOTÃO +
            ElevatedButton(

              onPressed: () {

                setState(() {

                  _count++;

                });
              },

              child: Text('+'),
            ),

            SizedBox(width: 10),

            // BOTÃO -
            ElevatedButton(

              onPressed: () {

                // Evita número negativo
                if (_count > 0) {

                  setState(() {

                    _count--;

                  });
                }
              },

              child: Text('-'),
            ),

            SizedBox(width: 10),

            // BOTÃO RESET
            ElevatedButton(

              onPressed: () {

                setState(() {

                  _count = 0;

                });
              },

              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}


//==================================================
// EX 01 — Upload básico
//==================================================

Future<void> _uploadPhoto() async {

  // Usuário atual
  final user = FirebaseAuth.instance.currentUser;

  // Verifica autenticação
  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Não autenticado'),
      ),
    );

    return;
  }

  try {

    // Nome do arquivo
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Referência do Storage
    final storageRef = FirebaseStorage.instance.ref(
      '${user.uid}/$fileName',
    );

    // Faz upload
    await storageRef.putFile(
      File(imageFile!.path),
    );

    if (!mounted) return;

    // Upload concluído
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Upload concluído'),
      ),
    );

  } catch (e) {

    if (!mounted) return;

    // Mostra erro
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro: $e'),
      ),
    );
  }
}


//==================================================
// EX 02 — Upload com loading
//==================================================

Future<void> _uploadPhoto2() async {

  final user = FirebaseAuth.instance.currentUser;

  // Verifica autenticação
  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro de autenticação'),
      ),
    );

    return;
  }

  // Ativa loading
  setState(() {

    _isUploading = true;

  });

  try {

    // Nome do arquivo
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Referência do Storage
    final storageRef = FirebaseStorage.instance.ref(
      '${user.uid}/$fileName',
    );

    // Faz upload
    await storageRef.putFile(
      File(imageFile!.path),
    );

    if (!mounted) return;

    // Upload concluído
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Upload concluído'),
      ),
    );

  } catch (e) {

    if (!mounted) return;

    // Mostra erro
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro: $e'),
      ),
    );

  } finally {

    // Sempre desativa loading
    if (mounted) {

      setState(() {

        _isUploading = false;

      });
    }
  }
}


//==================================================
// EX 03 — Upload com URL
//==================================================

Future<void> _uploadUrl() async {

  // Usuário atual
  final user = FirebaseAuth.instance.currentUser;

  // Verifica autenticação
  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Não autenticado'),
      ),
    );

    return;
  }

  try {

    // Nome do arquivo
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Referência do Storage
    final storageRef = FirebaseStorage.instance.ref(
      '${user.uid}/$fileName',
    );

    // Upload
    await storageRef.putFile(
      File(imageFile!.path),
    );

    if (!mounted) return;

    // Pega URL da imagem
    final url = await storageRef.getDownloadURL();

    // Salva URL
    setState(() {

      _downloadUrl = url;

    });

  } catch (e) {

    if (!mounted) return;

    // Mostra erro
    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro: $e'),
      ),
    );
  }
}

//==================================================
// EX 04 —  main() completo com Firebase
//==================================================

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializedApp();

 try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email : 'adm@test.com',
    password : '123456',
  );

 } on FirebaseAuthException catch (e){
  debugPrint('Erro : ${e.code}');
 }
 runApp(const MyApp());
}

//==================================================
// EX 06 — Logout + exibir email e UID
//==================================================

class PerfilTela extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(title: Text('Perfil')),
      body: Column(
        children: [
          Text('Email: ${user?.email}'),
          Text('UID: ${user?.uid}'),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

//==================================================
// EX 07 — dispose() completo
//==================================================

@override

void dispose (){
    _recoder?.dispose();
    _player?.dispose();
    _timer?.cancel();
    super.dispose();
}

//==================================================
// EX 08 — _stopRecording()
// Implemente o método que para a gravação, cancela o timer e atualiza o estado.
//==================================================

Future <void> _stopRecording() async {

    String? path;

    try{
        path = _recorder?.stop();
    }

    finally{
        _timer?.cancel();

        if (mounted){

            setState((){

                _isRecoding = false;
                _recodingPath = path;
                _recodingDuration = Duration.zero;
            });
        }
    }
}

//==================================================
// Ex 09 — _saveRecording()
// Implemente o método que copia o arquivo temporário para documentos.
//==================================================

Future<void> _saveRecording() async {
  if (_recordingPath == null) return;

  final docsDir = await getApplicationDocumentsDirectory();

  final fileName = _recordingPath!.split('/').last;

  final savedFile = File('${docsDir.path}/$fileName');

  await File(_recordingPath!).copy(savedFile.path);

  if (!mounted) return;

  setState(() {
    _savedPath = savedFile.path;
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Salvo'),
    ),
  );
}

//==================================================
// Ex 10 — _backupToFirebase()
// Implemente o backup do áudio salvo para o Firebase Storage.
//==================================================

Future<void> _backupToFirebase() async{

    final user = FirebaseAuth.instace.currentUser;

    if(user == null) return;

    if(_recordingPath == null) return;

    try{
        final fileName = (_recordingPath!).split('/').last;
        final storageRef = FirebaseStorage.instance.ref('${user.uid}/audios/$fileName');

        await storageRet.putFile(File(_savedPath!));

        if(!moutend) return;
    }
    
     ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Backup concluído!')),
    );

    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Erro no backup: $e')),
    );
  }


//==================================================
// Ex 11 — _backupToFirebase() com diálogo
// mesmo do Ex 10 mas com AlertDialog perguntando antes de enviar.
//==================================================

Future<void> _backupComDialogo() async {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Backup na nuvem?'),
      content: Text('Deseja enviar o áudio para o Firebase?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Não'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await _backupToFirebase();
          },
          child: Text('Sim'),
        ),
      ],
    ),
  );
}
    
//==================================================
// Ex 12 — _startRecording()
// Implemente o método que inicia a gravação com permissão e timer.
//==================================================

Future<void> _startRecording() async {
  final hasPermission = await _recorder?.hasPermission();
  if (hasPermission != true) return;

  final tempDir = await getTemporaryDirectory();
  final path = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';

  await _recorder?.start(RecordConfig(), path: path);

  _timer = Timer.periodic(Duration(seconds: 1), (_) {
    setState(() => _recordingDuration += Duration(seconds: 1));
  });

  setState(() => _isRecording = true);
}



//==================================================
// Ex 13 — _playRecording()
// Implemente o método que reproduz o áudio gravado.
//==================================================

Future<void> _playRecording() async {
  if (_recordingPath == null) return;
  await _player?.play(DeviceFileSource(_recordingPath!));
  setState(() => _isPlaying = true);
  _player?.onPlayerComplete.listen((_) {
    setState(() => _isPlaying = false);
  });
}
//==================================================
// Ex 14 — CalculadoraImc()
//==================================================

import 'package:flutter/material.dart';

class ImcTela extends StatefulWidget {
  @override
  State<ImcTela> createState() => _ImcTelaState();
}

class _ImcTelaState extends State<ImcTela> {
  final altura = TextEditingController();
  final peso = TextEditingController();

  double imc = 0;

  void calcular() {
    setState(() {
      double a = double.parse(altura.text);
      double p = double.parse(peso.text);

      imc = p / (a * a);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextField(
            controller: altura,
            decoration: InputDecoration(labelText: 'Altura'),
            keyboardType: TextInputType.number,
          ),

          TextField(
            controller: peso,
            decoration: InputDecoration(labelText: 'Peso'),
            keyboardType: TextInputType.number,
          ),

          ElevatedButton(
            onPressed: calcular,
            child: Text('Calcular'),
          ),

          Text(
            imc.toString(),
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}