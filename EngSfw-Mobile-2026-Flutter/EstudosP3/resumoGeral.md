# Flutter + Firebase + Gravador — Resumo Master P3

---

## 1. SEQUÊNCIA DO main() — CAI MUITO

### Ordem obrigatória

```dart
void main() async {
  // 1. bindings Flutter ANTES de tudo
  WidgetsFlutterBinding.ensureInitialized();

  // 2. conectar ao Firebase
  await Firebase.initializeApp();

  // 3. autenticar (tratar erro sem travar o app)
  try {
    await _loginAsAdmin();
  } on FirebaseAuthException catch (e) {
    debugPrint('Erro: ${e.code} - ${e.message}');
  }

  // 4. só então iniciar o app
  runApp(const MyApp());
}

Future<UserCredential> _loginAsAdmin() {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'admin@teste.com.br',
    password: '123456',
  );
}


// IR para outra tela
Navigator.push(context,
  MaterialPageRoute(builder: (_) => DetalheTela(dado: valor)),
);


// VOLTAR
Navigator.pop(context);

// Receber dado na nova tela — via construtor
class DetalheTela extends StatelessWidget {
  final String dado;
  const DetalheTela({required this.dado});
  @override
  Widget build(BuildContext context) => Scaffold(...);
}

```

### Regra de ouro

```
ensureInitialized
↓
initializeApp
↓
login
↓
runApp
```

> ⚠️ Inverter = BUG

---

## 2. ESTRUTURA DO PROJETO

```
meu_app/
├── lib/
│   └── main.dart
├── android/app/
│   └── google-services.json   ← aqui sempre!
└── pubspec.yaml
```

---

## 3. STATELESS vs STATEFUL

| | Stateless | Stateful |
|---|---|---|
| Estado | Não tem | Tem |
| Tela muda? | Não | Sim com setState() |
| Classes | 1 | 2 (widget + state) |
| build() fica em | No próprio widget | Na classe State |

```dart
// StatefulWidget — estrutura obrigatória
class GravadorPage extends StatefulWidget {
  @override
  State<GravadorPage> createState() => _GravadorPageState();
}

class _GravadorPageState extends State<GravadorPage> {
  // variáveis de estado aqui

  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```

> ⚠️ O build() fica na classe State, NUNCA no StatefulWidget!

---

## 4. CÓDIGOS ESSENCIAIS — DECORAR

### Upload com UID (Lab 7)

```dart
Future<void> _uploadPhoto() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuário não autenticado.')),
    );
    return;
  }

  try {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storageRef = FirebaseStorage.instance
      .ref('${user.uid}/$fileName');

    await storageRef.putFile(File(imageFile!.path));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Upload concluído!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro: $e')),
    );
  }
}
```

### Salvar local (Lab 8)

```dart
Future<void> _saveRecording() async {
  if (_recordingPath == null) return;

  final docsDir = await getApplicationDocumentsDirectory();
  final fileName = _recordingPath!.split('/').last;
  final savedFile = File('${docsDir.path}/$fileName');

  await File(_recordingPath!).copy(savedFile.path);

  setState(() { _savedPath = savedFile.path; });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Gravação salva!')),
  );
}
```

### Backup no Firebase (Lab 8 Parte M)

```dart
Future<void> _backupToFirebase() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  if (_savedPath == null) return;

  final fileName = _savedPath!.split('/').last;
  final storageRef = FirebaseStorage.instance
    .ref('${user.uid}/audios/$fileName');

  try {
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

### dispose() (Lab 8)

```dart
@override
void dispose() {
  _recorder?.dispose();
  _player?.dispose();
  _timer?.cancel();
  super.dispose(); // sempre por último
}
```

### _stopRecording() (Lab 8)

```dart
Future<void> _stopRecording() async {
  final path = await _recorder?.stop();
  _timer?.cancel();
  setState(() {
    _isRecording = false;
    _recordingPath = path;
    _recordingDuration = Duration.zero;
  });
}
```

---

## 5. REGRAS DE SEGURANÇA DO STORAGE

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{userId}/{allPaths=**} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;
    }
  }
}
```

> Cada usuário só acessa sua própria pasta.

---

## 6. PACOTES DO LAB 8

| Pacote | Para que serve |
|---|---|
| `record` | Gravar áudio em .m4a |
| `audioplayers` | Reproduzir áudio |
| `path_provider` | Encontrar pastas do dispositivo |
| `permission_handler` | Pedir permissão de microfone |

---

## 7. TEMPORÁRIO vs PERSISTENTE

| | Temporário | Persistente |
|---|---|---|
| Método | `getTemporaryDirectory()` | `getApplicationDocumentsDirectory()` |
| Pode ser apagado? | Sim, pelo SO | Não, fica até desinstalar |
| Variável | `_recordingPath` | `_savedPath` |
| Quando existe | Durante a gravação | Após o usuário salvar |

---

## 8. FLUXO DO GRAVADOR

```
Gravar  → pede permissão → cria arquivo temporário → inicia Timer
Parar   → para gravação → cancela Timer → guarda _recordingPath
Salvar  → copia para documents/ → guarda _savedPath
Backup  → envia _savedPath para Firebase Storage
```

---

## 9. FIREBASE AUTH — MÉTODOS

| Método | Para que serve |
|---|---|
| `signInWithEmailAndPassword` | Fazer login |
| `signOut()` | Fazer logout |
| `currentUser` | Pegar usuário atual (ou null) |
| `currentUser?.uid` | Pegar o UID |
| `currentUser?.email` | Pegar o email |

---

## 10. UID vs EMAIL

| UID | Email |
|---|---|
| Nunca muda | Pode mudar |
| Gerado pelo Firebase | Digitado pelo usuário |
| Seguro para nomear pastas | Pode quebrar o código |

---

## 11. OS 3 TESTES DO LAB 7

| Teste | Situação | Resultado |
|---|---|---|
| G1 | Upload autenticado | Foto salva em UID/arquivo.jpg ✅ |
| G2 | signOut() antes do upload | Erro — não autenticado ❌ |
| G3 | Caminho images/ em vez de UID | permission-denied ❌ |

---

## 12. TIMER.PERIODIC

```dart
// inicia o cronômetro
_timer = Timer.periodic(Duration(seconds: 1), (_) {
  setState(() {
    _recordingDuration += Duration(seconds: 1);
  });
});

// cancela o cronômetro
_timer?.cancel();
```

---

## 13. DEVICEFILESOURCE

```dart
// informa ao audioplayers que o arquivo está no dispositivo
await _player?.play(DeviceFileSource(_recordingPath!));
```

---

## 14. COMPLETE — RESPOSTAS RÁPIDAS

- `google-services.json` → `android/app/`
- Usuário atual → `FirebaseAuth.instance.currentUser`
- Logout → `FirebaseAuth.instance.signOut()`
- Grava áudio → `record`
- Reproduz áudio → `audioplayers`
- Pastas do device → `path_provider`
- Permissão micro → `permission_handler`
- Cronômetro → `Timer.periodic`
- Libera recursos → `dispose()`
- Regra Storage → `request.auth.uid == userId`
