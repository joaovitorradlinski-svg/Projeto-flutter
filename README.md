Este repositório contém um aplicativo Flutter totalmente funcional, incluindo autenticação, telas principais e integração com Firebase.

🔧 Pré-requisitos

Antes de rodar o projeto, instale:

✔ Flutter SDK

https://flutter.dev/docs/get-started/install

✔ Editor (VS Code ou Android Studio)
✔ Git

https://git-scm.com/downloads

✔ Conta no Firebase

https://console.firebase.google.com

📥 1. Clonar o repositório
git clone https://github.com/joaovitorradlinski-svg/Projeto-flutter.git
cd Projeto-flutter


Caso necessário:

git checkout main

📦 2. Instalar dependências
flutter pub get

🔥 3. Configurar Firebase

O projeto utiliza:

Firebase Authentication

Cloud Firestore

Firebase Storage (opcional)

🟦 3.1 Criar projeto no Firebase

Acesse o console:
https://console.firebase.google.com

Crie um novo projeto ou use um existente.

🟩 3.2 Adicionar aplicativo Web ao Firebase

O Flutter usa config Web para multiplataforma.

Ao registrar o app, o Firebase mostrará um objeto assim:

const firebaseConfig = {
  apiKey: "",
  authDomain: "",
  projectId: "",
  storageBucket: "",
  messagingSenderId: "",
  appId: ""
};


Copie essas informações e coloque no arquivo:

lib/firebase_options.dart


ou onde seu projeto faz o Firebase.initializeApp().

Se preferir, posso ajustar isso para você.

▶️ 4. Rodar o aplicativo
Rodar no navegador (recomendado)
flutter run -d chrome

Ou rodar normalmente
flutter run
