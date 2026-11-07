'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".vercel/project.json": "9f9125869adfa52282df90e318c72db8",
".vercel/README.txt": "2b13c79d37d6ed82a3255b83b6815034",
"assets/AssetManifest.bin": "effb97f04244df2aee884e0ba1647473",
"assets/AssetManifest.bin.json": "69dfc74a08384684cdca48de9792f10f",
"assets/assets/fonts/cairo/Cairo-Black.ttf": "5e8d1abc73e3cb2f4e4f28e8f1266810",
"assets/assets/fonts/cairo/Cairo-Bold.ttf": "08f051a1822e014b22374926f1406d01",
"assets/assets/fonts/cairo/Cairo-ExtraBold.ttf": "5ce7df38518378257d6df38e39db5a6e",
"assets/assets/fonts/cairo/Cairo-ExtraLight.ttf": "4ebc824ed5df082492eceb0969893ab7",
"assets/assets/fonts/cairo/Cairo-Light.ttf": "8078edb223451b37ee9e678c3b4b2f73",
"assets/assets/fonts/cairo/Cairo-Medium.ttf": "700c074c00ff17e59cc58449cfb85e75",
"assets/assets/fonts/cairo/Cairo-Regular.ttf": "5dacd3d88fa294c5c6263d4041a34935",
"assets/assets/fonts/cairo/Cairo-SemiBold.ttf": "a847fd89b0c852cfaa85478f1ef88612",
"assets/assets/fonts/poppins/Poppins-Black.ttf": "14d00dab1f6802e787183ecab5cce85e",
"assets/assets/fonts/poppins/Poppins-BlackItalic.ttf": "e9c5c588e39d0765d30bcd6594734102",
"assets/assets/fonts/poppins/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/poppins/Poppins-BoldItalic.ttf": "19406f767addf00d2ea82cdc9ab104ce",
"assets/assets/fonts/poppins/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/assets/fonts/poppins/Poppins-ExtraBoldItalic.ttf": "8afe4dc13b83b66fec0ea671419954cc",
"assets/assets/fonts/poppins/Poppins-ExtraLight.ttf": "6f8391bbdaeaa540388796c858dfd8ca",
"assets/assets/fonts/poppins/Poppins-ExtraLightItalic.ttf": "a9bed017984a258097841902b696a7a6",
"assets/assets/fonts/poppins/Poppins-Italic.ttf": "c1034239929f4651cc17d09ed3a28c69",
"assets/assets/fonts/poppins/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/poppins/Poppins-LightItalic.ttf": "0613c488cf7911af70db821bdd05dfc4",
"assets/assets/fonts/poppins/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/poppins/Poppins-MediumItalic.ttf": "cf5ba39d9ac24652e25df8c291121506",
"assets/assets/fonts/poppins/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/poppins/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/assets/fonts/poppins/Poppins-SemiBoldItalic.ttf": "9841f3d906521f7479a5ba70612aa8c8",
"assets/assets/fonts/poppins/Poppins-Thin.ttf": "9ec263601ee3fcd71763941207c9ad0d",
"assets/assets/fonts/poppins/Poppins-ThinItalic.ttf": "01555d25092b213d2ea3a982123722c9",
"assets/assets/images/aboutus_logo.png": "475cb9092d3c8b4a2caacaef0be5aea6",
"assets/assets/images/apple.svg": "0e1ae3551d9104e356882264762a9152",
"assets/assets/images/app_logo.png": "d1d5723341c12f75ff8e3e448a36175b",
"assets/assets/images/app_logo2.png": "439500ea0a94389e499e73a992161035",
"assets/assets/images/arrow%2520back.svg": "39fff3a3b5a6dac98a00b5b776ded683",
"assets/assets/images/arrow-down.svg": "508707bcb56863d178d4b38488022711",
"assets/assets/images/bedge_image.png": "008e60369e02fc6a0cc78955525d891a",
"assets/assets/images/box.svg": "97a7c2dda8cff31a7ba44187ad400c3a",
"assets/assets/images/Camera.svg": "490e93c6de8ac817f426be85f5886229",
"assets/assets/images/checkCircle.svg": "9dd6104cce3a269561bea474f829d6d7",
"assets/assets/images/crepe.png": "d04ed6f64edb442874a2c43dafcd4cdc",
"assets/assets/images/customer.png": "6201f6429de4e55a918a220264520d02",
"assets/assets/images/delivered.svg": "0173030041bdfc430f7e22bfd78b9e75",
"assets/assets/images/deliveryTruck.svg": "daacd2c512140063fcb639c8d057e881",
"assets/assets/images/edit.svg": "a5a7c5cb9c5c8c30ebc12f4a72bbbbe1",
"assets/assets/images/empty-wallet.svg": "2939ee65c9e03eca34a8cc9a6d4ab1cd",
"assets/assets/images/facebook.svg": "ba15e903a4272bdd35c85f4ca2ad0df6",
"assets/assets/images/filter.svg": "3d27a7ae845a065489ce9eca10435a69",
"assets/assets/images/filter2.svg": "c9166a4dc398328a8196a1fe8bfcf3cd",
"assets/assets/images/global.svg": "3e7427c67f53a6c0abc1e6121656b28b",
"assets/assets/images/google.svg": "692268ebc147c62b08a50d693ffc60ec",
"assets/assets/images/heart.svg": "125469cb32980d50b5749e39a2cdf656",
"assets/assets/images/info-circle.svg": "fdf7f9a9bb4aae55f634d395a36f1701",
"assets/assets/images/location.svg": "df616e2492cb2c1c0cd8359750a4fb43",
"assets/assets/images/me.png": "2bd703a28f280297823a5fb618253005",
"assets/assets/images/message.png": "a6f9bfa8cf79ab13d694e239680d7e63",
"assets/assets/images/onboarding_background_1.svg": "b35ffd4321565e15bc61d3a0356d441c",
"assets/assets/images/onboarding_background_2.svg": "b35ffd4321565e15bc61d3a0356d441c",
"assets/assets/images/openPackage.svg": "a290119ddd781f9c2ba7d89fbcf6b462",
"assets/assets/images/package.svg": "f7b85216a45afe8f66ca396132ba2e38",
"assets/assets/images/paymentSuccess.svg": "93af9cf2d705dae408c5e8086b74ea1e",
"assets/assets/images/pizza.png": "6810d3616f4550588e2265101564b3f6",
"assets/assets/images/pizza_sofian.png": "7cadd1979fe8e69b64c629bfcc176463",
"assets/assets/images/productDetailsBg.svg": "f080eb71b363dee36bea0583a93bef3c",
"assets/assets/images/search.svg": "8c112e601f7e03521934d866bd0b7c09",
"assets/assets/images/searchImage.svg": "d756a41fe162470d7454c3c843e88288",
"assets/assets/images/shippingTracking.svg": "24982791f54f6d7ef500b45cb2e201bc",
"assets/assets/images/sights.png": "6a0ededd07b8752e958602a373ebfc99",
"assets/assets/images/splash_bg.png": "ffe9b7f9878e33bc94e09a1f79674431",
"assets/assets/images/user.svg": "c5034a27dc1586c06c755147c7ecf578",
"assets/assets/json/empty.json": "670c4c3574a727cb42947fe8ec677e70",
"assets/assets/json/hekaya_loading.json": "f2602ef52db7abb23319e41a6d256298",
"assets/assets/json/shopping%2520cart.json": "c791107fbbb1f1addb0d6fc7fd4aedf2",
"assets/assets/songs/click_error.wav": "7195ed3125db31b648071a1ae2e0d71c",
"assets/assets/songs/click_song.wav": "97793a15e18da37ca200181620511610",
"assets/assets/songs/payment.mp3": "fe15b9737e4dd9152cc2180c2a03418a",
"assets/assets/songs/success.mp3": "43841284a35df09ba735ef7465c1d7bc",
"assets/FontManifest.json": "032ab5bc608eadf04d7586d901011288",
"assets/fonts/MaterialIcons-Regular.otf": "917b3379dfc1a86c85837c6b20f13096",
"assets/NOTICES": "438310596adcdc1ce06620bcff2d693b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "551fbdd0a87debed9a8e444a6cf7e0d9",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shorebird.yaml": "28e765d7f93ff5ed5b88e62e7c6420d8",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "a20b0a80b813b5af328ec2fd22a73ba6",
"firebase-messaging-sw.js": "8ade82ba477e64a7f8e8ddfe0763fafc",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "15d327929874fe3ae607ee675cb30b5d",
"icons/Icon-192.png": "8841940225df84031b587156cb679f80",
"icons/Icon-512.png": "8d31221be737f793984a96e92a5c3512",
"icons/Icon-maskable-192.png": "8841940225df84031b587156cb679f80",
"icons/Icon-maskable-512.png": "8d31221be737f793984a96e92a5c3512",
"index.html": "ae8bd73df6a6e2a28351fe4cf9bbfbe4",
"/": "ae8bd73df6a6e2a28351fe4cf9bbfbe4",
"main.dart.js": "a7b7f7b1dace2d5334a73615a39e87ab",
"manifest.json": "1e82160d599b901b1198d3ebfa4ca61b",
"vercel.json.dart": "b03c98a2eaefbe91ef5af61108b730d7",
"version.json": "0d5f9b20cbbd373edb80fd4f3357a501"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
