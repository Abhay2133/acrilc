import 'package:acrilc/models/post.dart';

List<Map<String, dynamic>> hardcodedPostData = [
  {
    "postId": "10001",
    "profileUrl":
        "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    "name": "Alice",
    "createdAt": "1d ago",
    "description": "Lovely day!",
    "images": [
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    ],
    "likesCount": 150,
    "isLiked": true,
    "commentsCount": 30,
    "shareLink": "https://example.com/post/10001",
  },
  {
    "postId": "10002",
    "profileUrl":
        "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    "name": "Bob",
    "createdAt": "2d ago",
    "description": "Just chilling.",
    "images": [
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    ],
    "likesCount": 80,
    "isLiked": false,
    "commentsCount": 15,
    "shareLink": "https://example.com/post/10002",
  },
  {
    "postId": "10003",
    "profileUrl":
        "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    "name": "Charlie",
    "createdAt": "3d ago",
    "description": "Exploring new places.",
    "images": [
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    ],
    "likesCount": 200,
    "isLiked": true,
    "commentsCount": 45,
    "shareLink": "https://example.com/post/10003",
  },
  {
    "postId": "10004",
    "profileUrl":
        "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    "name": "David",
    "createdAt": "4d ago",
    "description": "Coding time!",
    "images": [
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    ],
    "likesCount": 120,
    "isLiked": false,
    "commentsCount": 20,
    "shareLink": "https://example.com/post/10004",
  },
  {
    "postId": "10005",
    "profileUrl":
        "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    "name": "Eve",
    "createdAt": "5d ago",
    "description": "Sunset vibes.",
    "images": [
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    ],
    "likesCount": 250,
    "isLiked": true,
    "commentsCount": 60,
    "shareLink": "https://example.com/post/10005",
  },
  {
    "postId": "10006",
    "profileUrl":
        "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    "name": "Frank",
    "createdAt": "6d ago",
    "description": "Morning coffee.",
    "images": [
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    ],
    "likesCount": 90,
    "isLiked": false,
    "commentsCount": 18,
    "shareLink": "https://example.com/post/10006",
  },
  {
    "postId": "10007",
    "profileUrl":
        "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    "name": "Grace",
    "createdAt": "7d ago",
    "description": "Beautiful flowers.",
    "images": [
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    ],
    "likesCount": 180,
    "isLiked": true,
    "commentsCount": 35,
    "shareLink": "https://example.com/post/10007",
  },
  {
    "postId": "10008",
    "profileUrl":
        "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    "name": "Henry",
    "createdAt": "8d ago",
    "description": "Hiking adventure.",
    "images": [
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    ],
    "likesCount": 130,
    "isLiked": false,
    "commentsCount": 25,
    "shareLink": "https://example.com/post/10008",
  },
  {
    "postId": "10009",
    "profileUrl":
        "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    "name": "Ivy",
    "createdAt": "9d ago",
    "description": "Reading a good book.",
    "images": [
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    ],
    "likesCount": 220,
    "isLiked": true,
    "commentsCount": 50,
    "shareLink": "https://example.com/post/10009",
  },
  {
    "postId": "10010",
    "profileUrl":
        "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    "name": "Jack",
    "createdAt": "10d ago",
    "description": "Cooking dinner.",
    "images": [
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    ],
    "likesCount": 100,
    "isLiked": false,
    "commentsCount": 22,
    "shareLink": "https://example.com/post/10010",
  },
  {
    "postId": "10011",
    "profileUrl":
        "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    "name": "Karen",
    "createdAt": "11d ago",
    "description": "Weekend getaway.",
    "images": [
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    ],
    "likesCount": 160,
    "isLiked": true,
    "commentsCount": 32,
    "shareLink": "https://example.com/post/10011",
  },
  {
    "postId": "10012",
    "profileUrl":
        "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    "name": "Liam",
    "createdAt": "12d ago",
    "description": "Relaxing at the beach.",
    "images": [
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    ],
    "likesCount": 110,
    "isLiked": false,
    "commentsCount": 23,
    "shareLink": "https://example.com/post/10012",
  },
  {
    "postId": "10013",
    "profileUrl":
        "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    "name": "Mia",
    "createdAt": "13d ago",
    "description": "Art gallery visit.",
    "images": [
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    ],
    "likesCount": 190,
    "isLiked": true,
    "commentsCount": 40,
    "shareLink": "https://example.com/post/10013",
  },
  {
    "postId": "10014",
    "profileUrl":
        "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    "name": "Noah",
    "createdAt": "14d ago",
    "description": "Playing music.",
    "images": [
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    ],
    "likesCount": 140,
    "isLiked": false,
    "commentsCount": 27,
    "shareLink": "https://example.com/post/10014",
  },
  {
    "postId": "10015",
    "profileUrl":
        "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    "name": "Olivia",
    "createdAt": "15d ago",
    "description": "City lights.",
    "images": [
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    ],
    "likesCount": 230,
    "isLiked": true,
    "commentsCount": 55,
    "shareLink": "https://example.com/post/10015",
  },
  {
    "postId": "10016",
    "profileUrl":
        "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    "name": "Peter",
    "createdAt": "16d ago",
    "description": "Working on a project.",
    "images": [
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    ],
    "likesCount": 105,
    "isLiked": false,
    "commentsCount": 19,
    "shareLink": "https://example.com/post/10016",
  },
  {
    "postId": "10017",
    "profileUrl":
        "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    "name": "Quinn",
    "createdAt": "17d ago",
    "description": "Gardening time.",
    "images": [
      "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    ],
    "likesCount": 170,
    "isLiked": true,
    "commentsCount": 33,
    "shareLink": "https://example.com/post/10017",
  },
  {
    "postId": "10018",
    "profileUrl":
        "https://i.pinimg.com/736x/21/70/17/2170177059835c48d37fc227a84d2172.jpg",
    "name": "Ryan",
    "createdAt": "18d ago",
    "description": "Road trip!",
    "images": [
      "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    ],
    "likesCount": 125,
    "isLiked": false,
    "commentsCount": 21,
    "shareLink": "https://example.com/post/10018",
  },
  {
    "postId": "10019",
    "profileUrl":
        "https://i.pinimg.com/736x/ba/b3/72/bab3724108baef940f16b28f54058142.jpg",
    "name": "Sophia",
    "createdAt": "19d ago",
    "description": "Enjoying nature.",
    "images": [
      "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    ],
    "likesCount": 210,
    "isLiked": true,
    "commentsCount": 48,
    "shareLink": "https://example.com/post/10019",
  },
  {
    "postId": "10020",
    "profileUrl":
        "https://i.pinimg.com/736x/dd/c1/29/ddc129ec1fe997801fc62b3dacdb12f3.jpg",
    "name": "Tyler",
    "createdAt": "20d ago",
    "description": "Trying new food.",
    "images": [
      "https://i.pinimg.com/736x/58/8c/fb/588cfbf996ebf57efa87db65fb47e53d.jpg",
    ],
    "likesCount": 95,
    "isLiked": false,
    "commentsCount": 17,
    "shareLink": "https://example.com/post/10020",
  },
];

PostData samplePost = PostData(
  id: '68069fa8f1219279f151e851',
  author: 'user_123',
  title: 'Exploring Acrylic Techniques',
  subtitle: 'Blending and Layering in Modern Art',
  story:
      'In this post, I share my latest techniques for working with acrylic paint, including blending and layering tips.',
  size: 'medium',
  links: ['https://example.com/my-art', 'https://portfolio.com/user123'],
  hashTags: ['#acrylic', '#artlife', '#painting'],
  mentions: ['@artlover', '@galleryhub'],
  media: [
    {
      'type': 'image',
      'url':
          'https://i.pinimg.com/474x/21/52/05/215205fa5fedbcbb0d0cdfe2f09a76f4.jpg',
    },
    {
      'type': 'image',
      'url':
          'https://i.pinimg.com/474x/8c/8f/cd/8c8fcd2685a142ee5af8876bb5263ada.jpg',
    },
  ],
  forte: 'acrylic painting',
  location: 'New York, USA',
  applauds: ['user456', 'user789'],
  comments: ['Nice work!', 'Love your technique!', 'So inspiring!'],
  createdAt: DateTime.now().subtract(Duration(days: 2)),
  updatedAt: DateTime.now(),
);
