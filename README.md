🔧 O que você precisa instalar antes

Antes de começar, instale os seguintes programas:

✓ Flutter SDK

https://flutter.dev/docs/get-started/install

✓ Android Studio ou VS Code

(use apenas como editor — não é necessário configurar Android)

✓ Git

 https://git-scm.com/downloads

✓ Firebase CLI (opcional, somente se quiser deploy)

 https://firebase.google.com/docs/cli

 Passo 1 – Clonar o repositório

Abra o terminal, CMD ou Git Bash e rode:

git clone https://github.com/joaovitorradlinski-svg/Projeto-flutter.git
cd Projeto-flutter
git checkout Flutter_finalizado

 Passo 2 – Instalar dependências do Flutter

Execute:

flutter pub get


Isso baixa todos os pacotes usados no projeto.

 Passo 3 – Configurar o Firebase

O projeto utiliza Firebase (Auth / Firestore / Storage).

3.1 – Abrir o Firebase

 https://console.firebase.google.com

Crie um projeto ou use um já existente.

3.2 – Adicionar o app Flutter ao Firebase

No Firebase, adiciona-se:

App Web

Motivo: o Flutter usa o Firebase por meio da configuração Web no modo multiplataforma.

3.3 – Copiar seu firebaseConfig para o projeto

O Firebase vai te fornecer algo assim:

const firebaseConfig = {
  apiKey: "",
  authDomain: "",
  projectId: "",
  storageBucket: "",
  messagingSenderId: "",
  appId: ""
};


Cole esses valores no seu arquivo de inicialização Firebase em Flutter, normalmente em:

lib/services/firebase_options.dart


ou

lib/main.dart


(depende de como seu projeto está organizado — posso ajustar para você!)

 Passo 4 – Rodar o projeto
Rodar no navegador (recomendado)
flutter run -d chrome

Rodar no modo padrão
flutter run

 Passo 5 – Estrutura do Projeto

A pasta principal de código fica em:

lib/


E contém:

screens/ → Telas do app

widgets/ → Componentes reutilizáveis

services/ → Integrações com Firebase

models/ → Estruturas de dados

utils/ → Funções auxiliares

👤 Login e Registro

O app possui autenticação completa via Firebase:

Criar conta

Login

Logout

Basta rodar o app e acessar a tela de login.
