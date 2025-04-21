'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"splash/img/light-4x.png": "d880a47505874d97a0e01b0332a34bb3",
"splash/img/dark-3x.png": "d1396e049974df5b99f915eedc2451e0",
"splash/img/light-3x.png": "d1396e049974df5b99f915eedc2451e0",
"splash/img/light-1x.png": "205cd594ade66fbd3649e9e3dcd36375",
"splash/img/dark-1x.png": "205cd594ade66fbd3649e9e3dcd36375",
"splash/img/light-2x.png": "c3f08065c4a5fa22f410bcda597be0dd",
"splash/img/dark-2x.png": "c3f08065c4a5fa22f410bcda597be0dd",
"splash/img/dark-4x.png": "d880a47505874d97a0e01b0332a34bb3",
"index.html": "68af12b3fa0a71ff86cf69d8341eaec6",
"/": "68af12b3fa0a71ff86cf69d8341eaec6",
"assets/NOTICES": "b68b6fdfe131be13a042d41a2de16d72",
"assets/assets/images/bg-bottom-left.png": "c8aed0544836a456ece13a50a521b7ef",
"assets/assets/images/brush.svg": "e76c65f014c22309600a3c24895db05e",
"assets/assets/images/brush-black.svg": "c4bbcf8f36732f56f3998dd902f09091",
"assets/assets/images/bg-3.png": "f8d19568e1fad707afa401efacf4599b",
"assets/assets/images/logo.png": "d6f2bf773b280929fe5a98d8e2a59180",
"assets/assets/images/bg-1.png": "96f99417416096fd301c620f8b73644e",
"assets/assets/images/app-logo.png": "2bd9c9f95fac7cdec81ee560c037ca4f",
"assets/assets/images/profile-pic.png": "86a25a1d487508285bf366ca371de48f",
"assets/assets/images/shape.png": "0ddce4309ff1d33c860e34d3aefe2588",
"assets/assets/images/bg-top-right.png": "8bae1a7abb82ac8617243c4ae85b0ef9",
"assets/assets/images/bg-2.png": "949fbe7776925e60f0832c78440876d8",
"assets/assets/images/profile-banner.png": "df41a01484fe29e6c7fa047ade627e0f",
"assets/assets/images/wip.png": "d08697aa6ef1c3ad7d1770d41ac2a6f5",
"assets/prod.env": "12945b4001b404c870bf63b6528c22b5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "0b4a1ca371ac191723fd416bb3cf09f2",
"assets/fonts/MaterialIcons-Regular.otf": "f067dcd965ef03ae99b83522c10d96a5",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "bc196a51e2626918174e76efacc32d2d",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/AssetManifest.json": "ae52f1ee49105f7d836ceac9e17950c7",
"version.json": "ffc41c042bbf1f3afb28eff96eccdf1a",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.js": "3d23a5aaaab70af788a046594ac3a8f7",
"icons/Icon-maskable-512.png": "2bde4c089abed48e8d2dbb37ef4bde6c",
"icons/Icon-192.png": "c445cead57efb8cb22e09c126ae784f4",
"icons/Icon-512.png": "2bde4c089abed48e8d2dbb37ef4bde6c",
"icons/Icon-maskable-192.png": "c445cead57efb8cb22e09c126ae784f4",
"manifest.json": "d835103d40c17ff66f6b22fbc0196bc9",
"favicon.png": "b4f7c72cc8e57325203af704b0f0dadd",
"flutter_bootstrap.js": "691fde9b63dc5e688225979fb76b6baa"};
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
