Ex 1 — O papel do google-services.json?
Explique com suas palavras:
(a) O que é o arquivo google-services.json?
(b) Onde ele deve ser colocado?
(c) O que pode acontecer se o applicationId no Gradle
for diferente do registrado no Firebase?

Respostas:

A)
    O arquivo google-services.json é o arquivo gerado pelo Firebase
    ao registrar um app Android. Contém as chaves, IDs e configurações
    do projeto Firebase. Ele é responsével por conectar
    o app ao projeto correto.

B)
    Deve ficar em android/app/google-services.json 
    não na raiz do projeto, não em outra pasta.


C) 
    O Firebase não reconhece o app. O pacote registrado no Console
    não bate com o do app instalado, então o Firebase rejeita a conexão
    (erro em runtime ao inicializar).


Ex 2 — Provider, e-mail e UID

Responda:
(a) O que é um provider de autenticação?
(b) Qual a diferença entre o e-mail e o UID de um usuário?
(c) Por que o UID é preferível para nomear pastas no Storage?

Respostas:

A)
    Um provider é um método de autenticação suportado pelo Firebase
    (e-mail/senha, Google, Apple...). Você precisa habilitar cada
    provider no Console antes de usá-lo.

B) 
    O e-mail é definido pelo usuário e pode ser alterado.
    O UID é gerado automaticamente pelo Firebase no momento do cadastro
    e nunca muda.

C) 
    O UID é imutável, único, sem caracteres especiais e
    é exatamente o valor disponível em request.auth.uid
    nas regras de segurança — tornando a comparação direta e segura.


Ex 3 — Complete o main.dart
▾
Ordene as etapas corretamente no main() e complete os trechos faltando:

void main() async {
  // ??? (1)
  await Firebase.???();       // (2)
  try {
    await ???();               // (3)
  } on ??? catch (e) { ... }  // (4)
  ???(const MyApp());         // (5)
}

Respostas:

Sequência correta de inicialização
📌 A ordem importa: WidgetsFlutterBinding → Firebase.initializeApp() → login → runApp(). Inverter qualquer etapa causa crash.


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // (1)
  await Firebase.initializeApp();           // (2)
  try {
    await _loginAsAdmin();                   // (3)
  } on FirebaseAuthException catch (e) {    // (4)
    debugPrint('Erro: ${"{"}e.code{"}"}');
  }
  runApp(const MyApp());                    // (5)
}

Ex 4 — Corrija o caminho do upload
▾
O código abaixo tem dois problemas. Identifique e corrija:

final fileName = 'foto.jpg';
final storageRef = FirebaseStorage.instance.ref('images/$fileName');


Respostas:

// Problema 1: nome fixo 'foto.jpg' → sobrescreve arquivos anteriores
// Problema 2: pasta 'images' → bloqueada pelas regras de segurança

// Solução:
final user = FirebaseAuth.instance.currentUser;
final fileName = '${"{"}DateTime.now().millisecondsSinceEpoch{"}"}.jpg';
final storageRef = FirebaseStorage.instance
    .ref('${"{"}user!.uid{"}"}/$fileName');


Ex 5 — Interprete a regra
▾
Dada a regra abaixo e o usuário com UID user42, diga se cada operação é PERMITIDA ou BLOQUEADA:

allow read, write: if request.auth != null
                   && request.auth.uid == userId;

Leitura de user42/selfie.jpg logado como user42 
Escrita em user99/foto.jpg logado como user42
Escrita em images/foto.jpg logado como user42
Leitura de user42/doc.pdf sem estar logado

Respostas:

1. PERMITIDA — request.auth.uid ("user42") == userId ("user42") ✓
2. BLOQUEADA — "user42" ≠ "user99"
3. BLOQUEADA — "user42" ≠ "images"
4. BLOQUEADA — request.auth é null (não está logado)

Ex 6 — Reflexão: login falhou, app abriu
▾
    O professor pergunta: "Se o login falhar no main() e o app abrir mesmo assim
    (por causa do try/catch), o upload vai funcionar? Por quê?"

    Não vai funcionar, pois para escrever qualquer coisa PRECISA estar logado
    allow read, write: if request.auth != null -> ISSO GARANTE que só pode ler
    ou escrever estando LOGADO!