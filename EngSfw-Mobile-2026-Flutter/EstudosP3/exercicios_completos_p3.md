# Exercícios Completos P3 — Tudo que pode cair

---

## BLOCO 1 — TELAS DO ZERO

### Ex 01 — Tela de Login simples
Crie uma tela com dois TextFields (email e senha) e um botão "Entrar" que navega para `HomeTela`.

**Gabarito:**
```dart
class LoginTela extends StatefulWidget {
  @override
  State<LoginTela> createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  final _email = TextEditingController();
  final _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _senha,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Senha'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeTela()),
              );
            },
            child: Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
```

---

### Ex 02 — Tela de Perfil com logout
Crie uma tela que mostra email e UID do usuário e tem botão de logout.

**Gabarito:**
```dart
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
            child: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
```

---

### Ex 03 — Contador com +, - e Reset
Crie um StatefulWidget com contador que não vai abaixo de 0. AppBar mostra o valor atual.

**Gabarito:**
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
      appBar: AppBar(title: Text('Contador: $_count')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _count++),
              child: Text('+'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                if (_count > 0) setState(() => _count--);
              },
              child: Text('-'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => setState(() => _count = 0),
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

### Ex 04 — Tela com TextField que mostra o que foi digitado
Crie uma tela com TextField e botão "Mostrar". Ao clicar, exibe o texto digitado abaixo.

**Gabarito:**
```dart
class TextoTela extends StatefulWidget {
  @override
  State<TextoTela> createState() => _TextoTelaState();
}

class _TextoTelaState extends State<TextoTela> {
  final _controller = TextEditingController();
  String _texto = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Texto')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Digite algo'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _texto = _controller.text);
            },
            child: Text('Mostrar'),
          ),
          Text(_texto),
        ],
      ),
    );
  }
}
```

---

### Ex 05 — Calculadora de IMC
Crie uma tela com campos Altura e Peso, botão Calcular que mostra o IMC.

**Gabarito:**
```dart
class ImcTela extends StatefulWidget {
  @override
  State<ImcTela> createState() => _ImcTelaState();
}

class _ImcTelaState extends State<ImcTela> {
  final _altura = TextEditingController();
  final _peso = TextEditingController();
  String _resultado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora IMC')),
      body: Column(
        children: [
          Image.asset('assets/imc_logo.png'),
          TextField(
            controller: _altura,
            decoration: InputDecoration(labelText: 'Altura'),
          ),
          TextField(
            controller: _peso,
            decoration: InputDecoration(labelText: 'Peso'),
          ),
          ElevatedButton(
            onPressed: () {
              final altura = double.tryParse(_altura.text) ?? 0;
              final peso = double.tryParse(_peso.text) ?? 0;
              final imc = peso / (altura * altura);
              setState(() => _resultado = imc.toStringAsFixed(2));
            },
            child: Text('Calcular'),
          ),
          Text('IMC: $_resultado'),
        ],
      ),
    );
  }
}
```

---

## BLOCO 2 — NAVEGAÇÃO

### Ex 06 — Navegação simples entre telas
Crie duas telas. Na primeira um botão que vai para a segunda. Na segunda um botão que volta.

**Gabarito:**
```dart
class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Principal')),
      body: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TelaSecundaria()),
          );
        },
        child: Text('Ir para segunda tela'),
      ),
    );
  }
}

class TelaSecundaria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Segunda')),
      body: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Voltar'),
      ),
    );
  }
}
```

---

### Ex 07 — Navegação passando dados
Crie uma lista de gravações. Ao tocar, navega para a tela de detalhe passando o nome.

**Gabarito:**
```dart
class ListaGravacoes extends StatelessWidget {
  final gravacoes = ['Gravação 1', 'Gravação 2', 'Gravação 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gravações')),
      body: ListView.builder(
        itemCount: gravacoes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.mic),
            title: Text(gravacoes[index]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetalheGravacao(nome: gravacoes[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetalheGravacao extends StatelessWidget {
  final String nome;
  const DetalheGravacao({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhe')),
      body: Column(
        children: [
          Text('Nome: $nome'),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
```

---

## BLOCO 3 — FIREBASE AUTH + STORAGE (LAB 7)

### Ex 08 — main() completo
**Gabarito:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'admin@teste.com.br',
      password: '123456',
    );
  } on FirebaseAuthException catch (e) {
    debugPrint('Erro: ${e.code}');
  }
  runApp(const MyApp());
}
```

---

### Ex 09 — Upload com loading e mounted
**Gabarito:**
```dart
Future<void> _uploadPhoto() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Não autenticado.')),
    );
    return;
  }
  setState(() => _isUploading = true);
  try {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storageRef = FirebaseStorage.instance
      .ref('${user.uid}/$fileName');
    await storageRef.putFile(File(imageFile!.path));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Upload concluído!')),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro: $e')),
    );
  } finally {
    if (mounted) setState(() => _isUploading = false);
  }
}
```

---

### Ex 10 — Identifique 3 erros
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
    final ref = FirebaseStorage.instance.ref('images/$fileName');
    await ref.putFile(File(imageFile!.path));
    setState(() => _loading = false);
  } catch (e) {
    print('erro');
  }
}
```

**Gabarito:**
```
1. ensureInitialized deve vir ANTES de initializeApp
2. Caminho 'images/' em vez de '${user.uid}/'
3. setState(_loading=false) só no try — deve ir para finally
```

---

## BLOCO 4 — GRAVADOR DE ÁUDIO (LAB 8)

### Ex 11 — dispose() completo
**Gabarito:**
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

### Ex 12 — _startRecording()
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

### Ex 13 — _stopRecording()
**Gabarito:**
```dart
Future<void> _stopRecording() async {
  final path = await _recorder?.stop();
  _timer?.cancel();
  if (!mounted) return;
  setState(() {
    _isRecording = false;
    _recordingPath = path;
    _recordingDuration = Duration.zero;
  });
}
```

---

### Ex 14 — _saveRecording()
**Gabarito:**
```dart
Future<void> _saveRecording() async {
  if (_recordingPath == null) return;
  final docsDir = await getApplicationDocumentsDirectory();
  final fileName = _recordingPath!.split('/').last;
  final savedFile = File('${docsDir.path}/$fileName');
  await File(_recordingPath!).copy(savedFile.path);
  if (!mounted) return;
  setState(() => _savedPath = savedFile.path);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Gravação salva!')),
  );
}
```

---

### Ex 15 — _playRecording()
**Gabarito:**
```dart
Future<void> _playRecording() async {
  if (_recordingPath == null) return;
  await _player?.play(DeviceFileSource(_recordingPath!));
  setState(() => _isPlaying = true);
  _player?.onPlayerComplete.listen((_) {
    if (mounted) setState(() => _isPlaying = false);
  });
}
```

---

### Ex 16 — _backupToFirebase()
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
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Backup concluído!')),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro no backup: $e')),
    );
  }
}
```

---

### Ex 17 — _backupToFirebase() com AlertDialog
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

### Ex 18 — Esqueleto completo GravadorPage
**Gabarito:**
```dart
class GravadorPage extends StatefulWidget {
  @override
  State<GravadorPage> createState() => _GravadorPageState();
}

class _GravadorPageState extends State<GravadorPage> {
  AudioRecorder? _recorder;
  AudioPlayer? _player;
  Timer? _timer;
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
            onPressed: hasRecording ? _backupComDialogo : null,
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
  Future<void> _backupComDialogo() async {}
  Future<void> _backupToFirebase() async {}
}
```

---

### Ex 19 — Identifique os erros

```dart
Future<void> _saveRecording() async {
  final docsDir = await getApplicationDocumentsDirectory();
  final fileName = _recordingPath!.split('/').last;
  final savedFile = File('${docsDir.path}/$fileName');
  await File(_recordingPath!).copy(savedFile.path);
  setState(() => _savedPath = savedFile.path);
}

Future<void> _backupToFirebase() async {
  final user = FirebaseAuth.instance.currentUser;
  final fileName = _recordingPath!.split('/').last;
  final storageRef = FirebaseStorage.instance
    .ref('audios/$fileName');
  await storageRef.putFile(File(_recordingPath!));
}
```

**Gabarito:**
```
_saveRecording:
1. Não verifica _recordingPath == null
2. Não mostra SnackBar de confirmação

_backupToFirebase:
1. Não verifica user == null
2. Caminho 'audios/' em vez de '${user.uid}/audios/'
3. Envia _recordingPath (temporário) em vez de _savedPath (persistente)
```

---

## BLOCO 5 — try/catch/finally/mounted

### Ex 20 — Login com try/catch/finally/mounted
**Gabarito:**
```dart
Future<void> _fazerLogin() async {
  setState(() => _loading = true);
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email,
      password: _senha,
    );
    if (!mounted) return;
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => HomeTela()));
  } on FirebaseAuthException catch (e) {
    if (!mounted) return;
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário não encontrado.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.code}')),
      );
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro inesperado: $e')),
    );
  } finally {
    if (mounted) setState(() => _loading = false);
  }
}
```

---

## RESUMO — O que estudar por prioridade

```
PRIORIDADE 1 — certeza que cai:
✅ _uploadPhoto()       → Lab 7
✅ _saveRecording()     → Lab 8
✅ _backupToFirebase()  → combinação
✅ dispose()            → Lab 8

PRIORIDADE 2 — muito provável:
✅ main()               → identifique erro
✅ _stopRecording()     → Lab 8
✅ Tela do zero         → estilo prova antiga

PRIORIDADE 3 — possível:
✅ Navegação entre telas
✅ try/catch/finally completo
✅ _startRecording()
```
