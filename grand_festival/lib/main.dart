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
      title: '칠순 축하',
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
      body: Stack(
        children: [
          Container(
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
                    height: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '우리 가족의 누나이자 언니이자 큰고모이자',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
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
                                      fontSize: 20,
                                    ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '공정녀',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 26,
                                        ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: '님의 칠순을',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '진심으로 축하드립니다🎉',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
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
          // D-day 위젯을 우측 상단에 배치
          Positioned(
            top: 5,
            right: 8,
            child: _buildDdayWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDdayWidget(BuildContext context) {
    // 음력 6월 11일을 양력으로 변환 (2025년 기준)
    // 2025년 음력 6월 11일은 양력으로 2025년 7월 6일입니다
    final birthday = DateTime(2025, 7, 6);
    final now = DateTime.now();
    final difference = birthday.difference(now).inDays;

    String ddayText;
    Color ddayColor;

    if (difference > 0) {
      ddayText = 'D-$difference';
      ddayColor = Colors.red;
    } else if (difference == 0) {
      ddayText = 'D-Day!';
      ddayColor = Colors.red;
    } else {
      ddayText = 'D+${difference.abs()}';
      ddayColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '생일까지',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ddayText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ddayColor,
            ),
          ),
        ],
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
      'name': '공종성',
      'message': '하나님의 은혜로  가족과 이웃을 섬김의 기쁨으로 70년! \n감사하고 사랑합니다',
      'date': '2025-06-19',
    },
    {
      'name': '박형주',
      'message':
          '큰이모 칠순 축하드립니다!\n\n큰이모께서 벌써 칠순이라는게 믿기지 않네요. 저보다 여전히 체력이 더 좋으신거 같은데말이죠.\n지금처럼 건강하시고, 늘 가족들을 위해 기도해주셔서 감사합니다.\n생신축하드려요!',
      'date': '2025-06-20',
    },
    {
      'name': '김현정',
      'message': '칠순 진심으로 축하드립니다~~ 오래오래 건강하세요',
      'date': '2025-06-20',
    },
    {
      'name': '공진용',
      'message':
          '이번 칠순을 준비하면서 큰고모한테 참 받은 게 많다는 생각을 했어요.\n 제가 착하고 건실하게 자랄 수 있었던 건, 그리고 주변 사람들을 조금이라도 더 선하게 만드려고 했던 건, 모두 큰고모의 덕입니다.\n 감사합니다. 사랑합니다! 칠순 축하드려요!',
      'date': '2025-06-18',
    },
    {
      'name': '공진성',
      'message':
          '큰고모 70번째 생신 축하드려요!\n\n진짜 70번째라는게 믿기시질 않는걸요? 형주형보다 배도 훨씬 덜 나오셨고, 아직도 40-50대 같으세요..\n\n 어렸을 때 큰고모 댁에서 배드민턴도 치고, 컴퓨터 게임하고, 컴퓨터 게임하고, 컴퓨터 게임하고 했던게 엊그제 같은데 시간이 너무 빠르네요.\n\n그래도 이제 다 직장들도 있고, 다들 잘 나가는 거 같으니 이제 조카 덕 보시길 바랍니다☺☺☺',
      'date': '2025-06-20',
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
                          Text(
                            message['message']!,
                            style: const TextStyle(
                              height: 1.5,
                            ),
                          ),
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
                  '공진성을 잡아라!',
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
