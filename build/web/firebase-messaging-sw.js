importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyBihudU8RmiyQkyGUlL5EIgn9ac7LgezEk",
  authDomain: "pizza-sofian-resturant.firebaseapp.com",
  projectId: "pizza-sofian-resturant",
  storageBucket: "pizza-sofian-resturant.firebasestorage.app",
  messagingSenderId: "320713117439",
  appId: "1:320713117439:web:4ffabc1085e0f2b49486ca"
});

// متضيفش onBackgroundMessage هنا:
// الإشعار بيتبعت من السيرفر بـ notification payload والمتصفح بيعرضه لوحده،
// ولو ضفتها الإشعار هيظهر مرتين.
firebase.messaging();