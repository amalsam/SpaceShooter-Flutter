import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:spaceshooter/components/background.dart';
import 'package:spaceshooter/components/background2.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/components/game_joystick.dart';
import 'package:spaceshooter/components/rock.dart';
import 'package:spaceshooter/game/ship.dart';
import 'package:flame_audio/flame_audio.dart';
class SpaceShooterGame extends FlameGame with  HasCollisionDetection, TapDetector{
  SpaceShooterGame();
  Random random =Random();

  Ship ship = Ship();

  

  bool rockDestroyed = false;
  int score =0;

  


  @override
  Future<void> onLoad() async{
    addAll([
      Background(),
      Background2(),
      ship,
      joystick,
      ]);
      for(int i=0; i < 10; i++){   //generate 10 rocks when game starts
        generateNewRock();   
      }
      FlameAudio.bgm.initialize();
      FlameAudio.bgm.play('bg.wav');
    }




    @override
    void update(double dt){
      super.update(dt);                                                           
      if(rockDestroyed){            
        generateNewRock();        //when a rock destryoed,another will spawn
        rockDestroyed =false;
      }
    }


    void generateNewRock(){
      final rockPositionX = random.nextDouble()*size.x;
      final rockDirectionX = (random.nextDouble()*11) - 5 ;  //RockSpeed x direction ,random between -5 to +5
      final rockDirectionY = random.nextDouble()*3 + 3;     //rock speed y direction,random between 3 to 6
      add(Rock(rockPositionX: rockPositionX , rockDirectionX: rockDirectionX, rockDirectionY: rockDirectionY));
    }



    @override
    bool onTapDown(TapDownInfo event) {
      final bulletX = ship.position.x + 20;
      final bulletY = ship.position.y;

      add(Bullet(bulletX: bulletX, bulletY: bulletY));
      FlameAudio.play('pew.wav');
      return true;
  } 
}