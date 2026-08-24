import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// LOGIN DIDÁTICO — apenas para laboratório
// Em produção: nunca hardcode credenciais
// ─────────────────────────────────────────────
Future<UserCredential> _loginAsAdmin() {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'admin@teste.com.br',
    password: '123456',
  );
}

void main() async {
  // 1) inicializar bindings Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2) conectar ao Firebase (usa google-services.json)
  await Firebase.initializeApp();

  // 3) autenticar usuário de teste
  try {
    await _loginAsAdmin();
    debugPrint('✅ Login realizado com sucesso');
  } on FirebaseAuthException catch (e) {
    debugPrint('❌ Erro ao autenticar: ${e.code} - ${e.message}');
  }

  // 4) listar câmeras disponíveis
  final cameras = await availableCameras();

  // 5) iniciar o app
  runApp(MyApp(cameras: cameras));
}

// ─────────────────────────────────────────────
// APP ROOT
// ─────────────────────────────────────────────
class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Camera - Lab 07',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CameraScreen(cameras: cameras),
    );
  }
}

// ─────────────────────────────────────────────
// TELA PRINCIPAL — câmera + upload
// ─────────────────────────────────────────────
class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  XFile? _imageFile;
  String? _uploadedImageUrl;
  bool _isUploading = false;
  bool _cameraReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  // ── Inicializar câmera ──────────────────────
  Future<void> _initCamera() async {
    if (widget.cameras.isEmpty) return;

    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.high,
    );

    try {
      await _controller!.initialize();
      if (mounted) setState(() => _cameraReady = true);
    } catch (e) {
      debugPrint('Erro ao inicializar câmera: $e');
    }
  }

  // ── Tirar foto ──────────────────────────────
  Future<void> _tirarFoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final foto = await _controller!.takePicture();
      setState(() {
        _imageFile = foto;
        _uploadedImageUrl = null;
      });
    } catch (e) {
      debugPrint('Erro ao tirar foto: $e');
    }
  }

  // ── Upload para Firebase Storage ────────────
  // Parte E do lab: salva em ${user.uid}/$fileName
  Future<void> _uploadToFirebase() async {
    if (_imageFile == null) return;

    // E1) Obter usuário autenticado
    final user = FirebaseAuth.instance.currentUser;

    // Abortar se não estiver logado
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário não autenticado.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Nome único baseado no timestamp
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // E2) Caminho: UID/arquivo.jpg
      // Não mais 'images/$fileName' — agora é a pasta do usuário
      final storageRef = FirebaseStorage.instance
          .ref('${user.uid}/$fileName');

      // Enviar o arquivo
      await storageRef.putFile(
        File(_imageFile!.path),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Obter URL de download
      final downloadUrl = await storageRef.getDownloadURL();

      if (!mounted) return;
      setState(() => _uploadedImageUrl = downloadUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Upload concluído com sucesso! ✅'),
          backgroundColor: Colors.green,
        ),
      );

      debugPrint('📁 Arquivo salvo em: ${user.uid}/$fileName');
      debugPrint('🔗 URL: $downloadUrl');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha no upload: $e'),
          backgroundColor: Colors.red,
        ),
      );
      debugPrint('❌ Erro no upload: $e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  // ── Teste G2: simular sem autenticação ──────
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout realizado. Upload vai falhar agora.'),
        backgroundColor: Colors.orange,
      ),
    );
    setState(() {});
  }

  // ── Relogar (voltar ao estado normal) ───────
  Future<void> _signIn() async {
    try {
      await _loginAsAdmin();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado. Upload vai funcionar.'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.message}')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // ── Build ───────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 07 — Firebase Storage'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Mostrar status do usuário
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                user != null ? '✅ ${user.email}' : '❌ Deslogado',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Info do usuário autenticado ──
            _InfoCard(user: user),
            const SizedBox(height: 16),

            // ── Preview da câmera ─────────────
            if (_cameraReady && _imageFile == null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 300,
                  child: CameraPreview(_controller!),
                ),
              ),

            // ── Foto tirada ───────────────────
            if (_imageFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imageFile!.path),
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),

            if (!_cameraReady && _imageFile == null)
              const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              ),

            const SizedBox(height: 16),

            // ── Botão: tirar foto ─────────────
            ElevatedButton.icon(
              onPressed: _cameraReady ? _tirarFoto : null,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tirar Foto'),
            ),

            const SizedBox(height: 8),

            // ── Botão: fazer upload ───────────
            ElevatedButton.icon(
              onPressed: (_imageFile != null && !_isUploading)
                  ? _uploadToFirebase
                  : null,
              icon: _isUploading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_upload),
              label: Text(_isUploading ? 'Enviando...' : 'Enviar para Storage'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            // ── URL do upload ─────────────────
            if (_uploadedImageUrl != null) ...[
              const Divider(),
              const Text(
                '✅ Upload realizado!',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 4),
              Text(
                'UID: ${user?.uid ?? "-"}',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              SelectableText(
                _uploadedImageUrl!,
                style: const TextStyle(fontSize: 11, color: Colors.blue),
              ),
            ],

            const Divider(height: 32),

            // ── Botões de teste G2 ────────────
            const Text(
              'Testes do Lab (G1, G2, G3)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _signOut,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange,
                    ),
                    child: const Text('G2: Fazer Logout'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _signIn,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                    ),
                    child: const Text('Relogar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'G2: clique em "Logout" → tente upload → deve falhar.\n'
              'G3: mude o caminho para images/\$fileName → deve dar permission-denied.\n'
              'G1: fluxo normal — foto aparece na pasta do UID no Console.',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// WIDGET auxiliar: card com info do usuário
// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final User? user;

  const _InfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          border: Border.all(color: Colors.red.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          '❌ Nenhum usuário autenticado.\nO upload será bloqueado.',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '✅ Usuário autenticado',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          Text('E-mail: ${user!.email}',
              style: const TextStyle(fontSize: 12)),
          Text('UID: ${user!.uid}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            'Fotos serão salvas em: ${user!.uid}/<timestamp>.jpg',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}




