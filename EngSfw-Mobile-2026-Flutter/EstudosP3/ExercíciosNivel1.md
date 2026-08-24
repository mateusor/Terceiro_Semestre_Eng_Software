````md
# Exercícios — Flutter + Firebase + Gravador

---

# Nível 1 — Conceitual

## CONCEITUAL

### Ex 01 — Para que serve o finally?

Explique:

- (a) Em quais situações o bloco `finally` é executado?
- (b) Por que ele é ideal para ocultar um indicador de loading?
- (c) O que aconteceria se colocássemos `setState(() => _isLoading = false)` apenas dentro do `try`?

### Respostas

- A = O `finally` executa SEMPRE — se o `try` terminou normalmente, se caiu no `catch` ou até se ocorreu erro.
- B = Ele é ideal para loading porque o spinner precisa ser ocultado independentemente de sucesso ou erro.
- C = Se `_isLoading = false` estivesse apenas no `try`, quando ocorresse erro o loading continuaria infinito.

---

## CONCEITUAL

### Ex 02 — E-mail vs UID no Firebase

Imagine que o app salva fotos em pastas com o e-mail do usuário:

```txt
joao@gmail.com/foto.jpg
```

Liste pelo menos 3 problemas que isso pode causar em produção.

### Respostas

1. O e-mail pode mudar e a pasta antiga ficaria órfã.
2. Caracteres especiais (`@`, `.`) podem gerar problemas no path.
3. As regras do Firebase usam `request.auth.uid`, não e-mail.
4. O e-mail no path expõe informação do usuário.

---

## CONCEITUAL

### Ex 03 — Temporário vs Persistente

No app gravador, por que o arquivo é criado primeiro em:

```dart
getTemporaryDirectory()
```

e depois copiado para:

```dart
getApplicationDocumentsDirectory()
```

ao salvar?

O que aconteceria se salvássemos direto nos documentos desde o início?

### Respostas

1. O diretório temporário é melhor para arquivos provisórios durante a gravação.
2. Se o usuário cancelar, o sistema pode limpar automaticamente esses arquivos.
3. Salvar direto nos documentos acumularia gravações abandonadas permanentemente.

---

# Nível 2 — Leitura de código

## CÓDIGO

### Ex 04 — O que este código faz?

Analise o trecho abaixo e descreva linha a linha o que acontece:

```dart
final user = FirebaseAuth.instance.currentUser;

if (user == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Não autenticado')),
  );
  return;
}

final fileName =
    '${DateTime.now().millisecondsSinceEpoch}.jpg';

final ref = FirebaseStorage.instance
    .ref('${user.uid}/$fileName');
```

### Respostas

```dart
// Pega o usuário atualmente logado
final user = FirebaseAuth.instance.currentUser;

// Verifica se existe usuário autenticado
if (user == null) {

  // Mostra mensagem de erro
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Não autenticado'),
    ),
  );

  // Sai do método
  return;
}

// Cria nome único usando timestamp
final fileName =
    '${DateTime.now().millisecondsSinceEpoch}.jpg';

// Cria referência no Firebase Storage
final ref = FirebaseStorage.instance
    .ref('${user.uid}/$fileName');
```

---

## CÓDIGO

### Ex 05 — Ache os bugs

O código abaixo tem 3 problemas. Identifique-os:

```dart
void main() async {
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await _loginAsAdmin();
  runApp(MyApp());
}

Future<void> _uploadFoto() async {
  setState(() => _loading = true);

  try {
    await enviarArquivo();
    setState(() => _loading = false);
  } catch (e) {
    print('erro');
  }
}
```

### Respostas

1. `WidgetsFlutterBinding.ensureInitialized()` deveria vir antes do Firebase.
2. `_loading = false` está apenas no `try`.
3. Falta verificar `mounted` após `await`.

---

## CÓDIGO

### Ex 06 — Complete o try/catch

```dart
Future<void> _fazerLogin() async {

  setState(() => _loading = true);

  try {

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(

      email: _email,
      password: _senha,
    );

    if (!mounted) return;

    Navigator.push(

      context,

      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );

  } on FirebaseAuthException catch (e) {

    if (!mounted) return;

    String erro;

    if (e.code == 'user-not-found') {

      erro = 'Email não cadastrado';

    } else {

      erro = 'Erro de autenticação';
    }

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(erro),
      ),
    );

  } catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro inesperado: $e'),
      ),
    );

  } finally {

    if (mounted) {

      setState(() => _loading = false);
    }
  }
}
```

---

# Nível 3 — Implementação

## IMPLEMENTAÇÃO

### Ex 07 — StatefulWidget completo

```dart
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

                // Evita negativo
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
```

---

# Exercícios de Código P3 — Lab 7 + Lab 8

---

# LAB 7 — Firebase Auth + Storage

## Ex 01 — Upload básico

```dart
Future<void> _uploadPhoto() async {

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Não autenticado'),
      ),
    );

    return;
  }

  try {

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final storageRef =
        FirebaseStorage.instance.ref(
      '${user.uid}/$fileName',
    );

    await storageRef.putFile(
      File(imageFile!.path),
    );

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Upload concluído'),
      ),
    );

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro: $e'),
      ),
    );
  }
}
```

---

## Ex 02 — Upload com loading

```dart
Future<void> _uploadPhoto2() async {

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro de autenticação'),
      ),
    );

    return;
  }

  setState(() {

    _isUploading = true;

  });

  try {

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final storageRef =
        FirebaseStorage.instance.ref(
      '${user.uid}/$fileName',
    );

    await storageRef.putFile(
      File(imageFile!.path),
    );

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Upload concluído'),
      ),
    );

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro: $e'),
      ),
    );

  } finally {

    setState(() {

      _isUploading = false;

    });
  }
}
```

---

## Ex 03 — Upload com URL de download

```dart
Future<void> _uploadUrl() async {

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Não autenticado'),
      ),
    );

    return;
  }

  try {

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final storageRef =
        FirebaseStorage.instance.ref(
      '${user.uid}/$fileName',
    );

    await storageRef.putFile(
      File(imageFile!.path),
    );

    final url =
        await storageRef.getDownloadURL();

    setState(() {

      _downloadUrl = url;

    });

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text('Erro: $e'),
      ),
    );
  }
}
```
````


---

### Ex 04 — main() completo com Firebase
Escreva o `main()` completo com Firebase inicializado, login hardcoded e tratamento de erro.

**Gabarito:**
```dart

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initialized();

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

```

---

### Ex 05 — Identifique os erros

```dart
Future<void> _uploadFoto() async {
  setState(() => _loading = true);
  try {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = FirebaseStorage.instance.ref('images/$fileName');
    await ref.putFile(File(imageFile!.path));
    setState(() => _loading = false);
  } catch (e) {
    print('erro');
  }
}
```



### Respostas

1. Não verifica se o Usuario está logado!

2. ('images/$fileName') está errado, deve salvar em
2. user.uid/fileName.

3. SetState está dentro do try, deveria ser declarado como finally

4. Não utiliza a verificação (Mounted)

5. Não usa SnackBar para informar o erro.



```
```

---
### Ex 06 — Logout + exibir email e UID
Implemente uma tela que mostra email e UID do usuário e tem botão de logout.


```dart
class PerfilTela extends StatelessWidget{
  
  @override

  Widget build(BuildContext context){

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar : AppBar(title : Text ('Perfil')),

      body : Column (

        children[
          Text('Email : ${user.email}'),
          Text('UID : ${user.uid}'),
        
        ElevatedButton(
          onPressed() : async{
            await FirebaseAuth.instance.signOut();
          },
          child : Text('logout'),
        ),
        ],
      ),
     );
    }
  }
```

---

## LAB 8 — Gravador de Áudio

### Ex 07 — dispose() completo
Implemente o `dispose()` do app gravador.


```dart
@override
void dispose() {
  _recorder?.dispose();
  _player?.dispose();
  _timer?.cancel();
  super.dispose();
}
```

---

### Ex 08 — _stopRecording()
Implemente o método que para a gravação, cancela o timer e atualiza o estado.

**Gabarito:**
```dart
Future <void> _stopRecording() async{
    String? path;

    try{
        path = await _recorder?.stop();
    }

    finally{
        _timer?.cancel();

        if(mounted){
            setState((){
                _isRecording = false;
                _recordingPath = path;
                _recordingDuration = Duration.zero;
            });
        }
    }
}
```

---

### Ex 09 — _saveRecording()
Implemente o método que copia o arquivo temporário para documentos.

**Gabarito:**
```dart
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
```

---

### Ex 10 — _backupToFirebase()
Implemente o backup do áudio salvo para o Firebase Storage.

**Gabarito:**
```dart
Future<void> _backupToFirebase() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  if (_savedPath == null) return;
  try {
    final fileName = _savedPath!.split('/').last;
    final storageRef = FirebaseStorage.instance
      .ref('${user.uid}/audios/$fileName');
    await storageRef.putFile(File(_savedPath!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Backup concluído!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro no backup: $e')),
    );
  }
}
```

---

### Ex 11 — _backupToFirebase() com diálogo
Mesmo do Ex 10 mas com AlertDialog perguntando antes de enviar.

**Gabarito:**
```dart
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
```

---

### Ex 12 — _startRecording()
Implemente o método que inicia a gravação com permissão e timer.

**Gabarito:**
```dart
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
```

---

### Ex 13 — Identifique os erros

```dart
Future<void> _saveRecording() async {

  final docsDir = await getApplicationDocumentsDirectory();

  final fileName = _recordingPath!.split('/').last;

  final savedFile = File('${docsDir.path}/$fileName');

  await File(_recordingPath!).copy(savedFile.path);

  setState(() => _savedPath = savedFile.path);
}
```

**Gabarito:**
### Respostas

1. nao verifica se ter o _recordingPath
2. nao exibe SnackBar de confirmação do usuario


```

```
---

### Ex 14 — Esqueleto completo do GravadorPage
Escreva o esqueleto completo com variáveis de estado, dispose() e botões.

**Gabarito:**
```dart
class GravadorPage extends StatefulWidget {
  @override
  State<GravadorPage> createState() => _GravadorPageState();
}

class _GravadorPageState extends State<GravadorPage> {
  AudioRecorder? _recorder;
  AudioPlayer? _player;
  Timmeer? _tir;
  String? _recordingPath;
  String? _savedPath;
  Duration _recordingDuration = Duration.zero;
  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void dispose() {
    _recorder?.dispose();
    _player?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasRecording = _recordingPath != null;
    return Scaffold(
      appBar: AppBar(title: Text('Gravador')),
      body: Column(
        children: [
          Text(_recordingDuration.toString()),
          ElevatedButton(
            onPressed: _isRecording ? _stopRecording : _startRecording,
            child: Text(_isRecording ? 'Parar' : 'Gravar'),
          ),
          ElevatedButton(
            onPressed: hasRecording ? _playRecording : null,
            child: Text('Reproduzir'),
          ),
          ElevatedButton(
            onPressed: hasRecording ? _saveRecording : null,
            child: Text('Salvar'),
          ),
          ElevatedButton(
            onPressed: hasRecording ? _backupToFirebase : null,
            child: Text('Backup'),
          ),
        ],
      ),
    );
  }

  Future<void> _startRecording() async {}
  Future<void> _stopRecording() async {}
  Future<void> _playRecording() async {}
  Future<void> _saveRecording() async {}
  Future<void> _backupToFirebase() async {}
}
```

---

### Ex 15 — _playRecording()
Implemente o método que reproduz o áudio gravado.

**Gabarito:**
```dart
Future<void> _playRecording() async {
  if (_recordingPath == null) return;
  await _player?.play(DeviceFileSource(_recordingPath!));
  setState(() => _isPlaying = true);
  _player?.onPlayerComplete.listen((_) {
    setState(() => _isPlaying = false);
  });
}
```

---

## Resumo — Ordem de implementação para estudar

```
1. dispose()           → mais simples, cai com certeza
2. _saveRecording()    → Lab 8 certeza
3. _uploadPhoto()      → Lab 7 certeza
4. _backupToFirebase() → combinação dos dois
5. main()              → pode cair como identifique o erro
6. _startRecording()   → mais complexo
7. _stopRecording()    → médio
8. _playRecording()    → médio
```
