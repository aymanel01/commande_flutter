# 🛍️ Application de Commande Flutter

Application mobile de commande en ligne développée dans le cadre de l'exercice technique proposé par **IZYDESK**.

> Réalisée avec Flutter et Provider, cette application consomme une API REST publique, permet d’ajouter des produits au panier, de les modifier, et de simuler la validation d’une commande.

---

## 👨‍💻 Réalisée par

**Mohamed Ayman EL MESKINE**  
📍 Casablanca, Maroc  
📧 elmeskine.ayman@gmail.com  
## 📱 Fonctionnalités

- ✅ Consommation de l’API `https://dummyjson.com/products`
- 🛒 Ajout d’articles au panier
- ✏️ Gestion de la quantité & suppression
- 💰 Calcul du prix total en temps réel
- 📤 Envoi de la commande (POST vers `jsonplaceholder`)
- 🎨 Interface propre & responsive
- ⚙️ Architecture MVVM + Provider

## 📁 Structure du projet

lib/
├── models/ → Product, CartItem
├── services/ → ApiService (GET, POST)
├── viewmodels/ → ProductViewModel, CartViewModel
├── views/ → HomePage, CartPage, CheckoutPage
├── widgets/ → ProductCard, CartItemWidget
└── main.dart → Initialisation + navigation

##🚀 Lancer le projet localement

git clone https://github.com/aymanel01/commande_flutter.git
cd commande_flutter
flutter pub get
flutter run

##⚙️ Packages utilisés

http	Consommation de l'API REST
provider	Gestion d'état simple et efficace

##🧠 Architecture & choix techniques
Architecture MVVM pour une meilleure séparation UI / logique / données

Provider pour une gestion d'état claire (produits et panier)

Code modulaire : chaque composant a son propre fichier
