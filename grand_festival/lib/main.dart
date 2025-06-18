import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '공정녀의 칠순을 축하 드립니다!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE57373), // 부드러운 분홍색
          primary: const Color(0xFFE57373),
          secondary: const Color(0xFFFFB74D), // 부드러운 주황색
        ),
        textTheme: GoogleFonts.notoSansKrTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool _isGamePlaying = false;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const GuestBookPage(),
      GamePage(onGameStateChanged: _onGameStateChanged),
    ];
  }

  void _onGameStateChanged(bool isPlaying) {
    setState(() {
      _isGamePlaying = isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _isGamePlaying
          ? null
          : NavigationBar(
              height: 65,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: '홈',
                ),
                NavigationDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: '방명록',
                ),
                NavigationDestination(
                  icon: Icon(Icons.games_outlined),
                  selectedIcon: Icon(Icons.games),
                  label: '게임',
                ),
              ],
            ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '♡',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.pink[50]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primary,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '누나이자 언니이자 고모이자 큰고모이자',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '큰이모인 ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26,
                                ),
                          ),
                          TextSpan(
                            text: '공정녀',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  foreground: Paint()
                                    ..shader = const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(0xFFFFB74D),
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(
                                          0.0, 0.0, 200.0, 70.0),
                                    ),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                ),
                          ),
                          TextSpan(
                            text: '의 칠순을',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '진심으로 축하드립니다',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoSection(
                      context,
                      '일시',
                      '2025년 6월 19일 (토) 오후 12시',
                      Icons.calendar_today,
                    ),
                    const SizedBox(height: 32),
                    _buildInfoSection(
                      context,
                      '장소',
                      '경기 평택시 진위면 동천리 593 디세농원',
                      Icons.location_on,
                    ),
                    const SizedBox(height: 32),
                    _buildInfoSection(
                      context,
                      '지켜야할 것',
                      '믿음 소망 사랑',
                      Icons.favorite,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(
      BuildContext context, String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

class GuestBookPage extends StatefulWidget {
  const GuestBookPage({super.key});

  @override
  State<GuestBookPage> createState() => _GuestBookPageState();
}

class _GuestBookPageState extends State<GuestBookPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _guestMessages = [
    {
      'name': '박형주',
      'message': '테스트',
      'date': '2025-06-18',
    },
    {
      'name': '김현정',
      'message': '테스트',
      'date': '2025-06-18',
    },
    {
      'name': '공진용',
      'message': '해보자',
      'date': '2025-06-18',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('방명록'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.pink[50]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _guestMessages.length,
                itemBuilder: (context, index) {
                  final message = _guestMessages[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                message['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                message['date']!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(message['message']!),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final Function(bool) onGameStateChanged;

  const GamePage({
    super.key,
    required this.onGameStateChanged,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isGameStarted = false;
  int _score = 0;
  int _timeLeft = 30;
  bool _isGameOver = false;
  Timer? _moveTimer;
  final Random _random = Random();

  // 여러 개의 공진성을 관리하기 위한 리스트
  final List<GongJinSeong> _targets = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void _startGame() {
    widget.onGameStateChanged(true);
    setState(() {
      _isGameStarted = true;
      _score = 0;
      _timeLeft = 30;
      _isGameOver = false;
      _targets.clear();

      // 3개의 공진성 생성
      for (int i = 0; i < 3; i++) {
        _targets.add(GongJinSeong(
          x: _random.nextDouble() * (MediaQuery.of(context).size.width - 100),
          y: _random.nextDouble() * (MediaQuery.of(context).size.height - 276),
          isVisible: true,
          rotation: 0.0,
        ));
      }
    });
    _startRandomMovement();
    _startTimer();
  }

  void _startRandomMovement() {
    _moveTimer?.cancel();
    _moveTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (_isGameStarted && !_isGameOver) {
        for (var target in _targets) {
          if (target.isVisible) {
            setState(() {
              target.x = _random.nextDouble() *
                  (MediaQuery.of(context).size.width - 100);
              target.y = _random.nextDouble() *
                  (MediaQuery.of(context).size.height - 276);
            });
          }
        }
      }
    });
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 0 && _isGameStarted) {
        setState(() {
          _timeLeft--;
        });
        _startTimer();
      } else {
        setState(() {
          _isGameOver = true;
          _isGameStarted = false;
        });
        widget.onGameStateChanged(false);
        _moveTimer?.cancel();
      }
    });
  }

  void _catchTarget(int index) {
    if (_isGameStarted && !_isGameOver && _targets[index].isVisible) {
      setState(() {
        _score += 1;
        _targets[index].isVisible = false;
        _targets[index].rotation += 360;
      });

      // 0.5초 후에 새로운 위치에 나타나기
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_isGameStarted && !_isGameOver) {
          setState(() {
            _targets[index].x = _random.nextDouble() *
                (MediaQuery.of(context).size.width - 100);
            _targets[index].y = _random.nextDouble() *
                (MediaQuery.of(context).size.height - 276);
            _targets[index].isVisible = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    widget.onGameStateChanged(false);
    _controller.dispose();
    _moveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공진성 잡기'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.pink[50]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isGameStarted && !_isGameOver) ...[
                const Text(
                  '공진성 잡기 게임',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('게임 시작하기'),
                ),
              ] else if (_isGameOver) ...[
                const Text(
                  '게임 종료!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '공진성을 ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '$_score',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text: '번 잡았어요!!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('다시 시작하기'),
                ),
              ] else ...[
                Text(
                  '남은 시간: $_timeLeft초',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '점수: $_score',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          for (int i = 0; i < _targets.length; i++)
                            if (_targets[i].isVisible)
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                left: _targets[i].x,
                                top: _targets[i].y,
                                child: GestureDetector(
                                  onTap: () => _catchTarget(i),
                                  child: AnimatedRotation(
                                    duration: const Duration(milliseconds: 500),
                                    turns: _targets[i].rotation / 360,
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity:
                                          _targets[i].isVisible ? 1.0 : 0.0,
                                      child: Image.asset(
                                        'assets/images/gongjinseong.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// 공진성 캐릭터 클래스
class GongJinSeong {
  double x;
  double y;
  bool isVisible;
  double rotation;

  GongJinSeong({
    required this.x,
    required this.y,
    required this.isVisible,
    required this.rotation,
  });
}
