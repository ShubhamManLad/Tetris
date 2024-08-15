import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/components/pixels.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  int rows = 18;
  int cols = 10;

  bool end = false;

  static List Line =  [0,10,20];        // Green
  static List Square = [0,1,10,11];     // Purple
  static List J_block = [1,11,20,21];   // Light Blue
  static List H_block = [0,10,11,21];   // Blue
  static List L_block = [0,10,20,21];   // Light Blue
  static List N_block = [1,10,11,20];   // Pink
  static List S_block = [1,2,10,11];    // Yellow
  static List T_block = [0,1,2,11];    // Yellow
  static List Z_block = [0,1,11,12];    // Orange

  List landed = [];

  int activeBlock = 0;
  List active = [];
  List inactive = [];

  static List blocks = [];

  @override
  void initState() {
    super.initState();
    for(int i=0; i<rows*cols; i++) landed.add(-1);
    blocks.add(Square);
    blocks.add(Line);
    blocks.add(J_block);
    blocks.add(H_block);
    blocks.add(L_block);
    blocks.add(N_block);
    blocks.add(S_block);
    blocks.add(T_block);
    blocks.add(Z_block);
    active = [...blocks[activeBlock]];
    startGame();
  }

  void moveRight(){
    bool end = false;
    for(int i in active){
      if(i%10==9  || inactive.contains(i+1)) {
        end = true;
        break;
      }
    }
    if(!end){
      setState(() {
        for(int i=0; i<active.length; i++){
          active[i]++;
        }
      });
    }

  }

  void moveLeft(){
    bool end = false;
    for(int i in active){
      if(i%10==0 || inactive.contains(i-1)) {
        end = true;
        break;
      }
    }
    if(!end){
      setState(() {
        for(int i=0; i<active.length; i++){
          active[i]--;
        }
      });
    }

  }

  void moveDown(){
    setState(() {
      for(int i=0; i<active.length; i++){
        active[i]+=10;
      }
    });

  }

  void startGame(){
    Timer.periodic(Duration(milliseconds: 400), (timer) {
      end = false;
      // Check for Boundary Condition
      for(int i in active){
        if(i+10>(rows*cols -1) || inactive.contains(i+10)) {
          end = true;
          break;
        }
      }
      if(!end){
        moveDown();
      }
      else{
        setState(() {
          // Reached the end
          inactive.addAll(active);

          for(int j in active){
            landed[j] = activeBlock;
          }

          // Reached the top
          for(int j in active){
            if(j<10) {
              // timer.cancel();
              inactive.clear();
            }
          }

          // New block
          active.clear();
          activeBlock = Random().nextInt(blocks.length);
          active = [...blocks[activeBlock]];
          int r = Random().nextInt(3)+5;
          for(int i=0; i<r; i++){
            moveRight();
          }

          end = false;
          checkLineComplete();

        });
      }

    });

  }

  void checkLineComplete(){
    for(int i=19; i>=0; i--){
      int counter = 0;
      for(int j=0; j<10;j++){
        if(!inactive.contains(i*10+j)){
          break;
        }
        else counter++;
      }
      if(counter==10){
        removeLine(i);
        moveLineDown(i);
      }
    }
  }

  void removeLine(int i){
    setState(() {
      for(int j=0; j<10; j++){
        inactive.remove(i*10+j);
      }
    });
  }

  void moveLineDown(int k){
    setState(() {
      for(int i=k; i>=0; i--){
        for(int j=0; j<10;j++){
          if(inactive.remove(i*10 + j)) inactive.add(i*10 + j+10);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: rows * cols,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols),
                itemBuilder: (context, index) {
                  if(active.contains(index)) {
                    return ActivePixel(i: activeBlock);
                  }
                  else if(inactive.contains(index)) {
                    return ActivePixel(i: landed[index]);
                  }
                  else {
                    return BlankPixel(i: index);
                  }
                }),
          ),
          Container(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: IconButton(onPressed: (){ moveLeft();}, icon: Icon(Icons.keyboard_double_arrow_left))),
                Expanded(child: IconButton(onPressed: (){ moveRight();}, icon: Icon(Icons.keyboard_double_arrow_right)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
