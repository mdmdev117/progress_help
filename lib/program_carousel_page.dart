import 'package:flutter/material.dart';
import 'category_page.dart';
import 'package:progresshelp/styles/gradient_background.dart';

class ProgramCarouselPage extends StatefulWidget {
  const ProgramCarouselPage({super.key});

  @override
  State<ProgramCarouselPage> createState() => _ProgramCarouselPageState();
}

class _ProgramCarouselPageState extends State<ProgramCarouselPage> {
  final List<String> programs = [
    'Presenze Project',
    'Presenze Infinity',
    'Workflow',
    'ZTravel',
    'ZTimeSheet',
  ];

  String? selectedProgram;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('PROGRESS HELP',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0, // blocca ombra in scroll
        surfaceTintColor: Colors.transparent, // evita overlay bianco
      ),
      body: GradientBackground(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Seleziona il software:',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.vertical,
                itemCount: programs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  final program = programs[index];
                  final isSelected = program == selectedProgram;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProgram = program;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      height: isSelected ? 140 : 120,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blueAccent
                            : Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(32),
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        program,
                        style: TextStyle(
                          fontSize: isSelected ? 22 : 20,
                          color: Colors.white,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: selectedProgram == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            selectedProgram: selectedProgram!,
                          ),
                        ),
                      );
                    },
              child: const Text(
                'Avanti',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
