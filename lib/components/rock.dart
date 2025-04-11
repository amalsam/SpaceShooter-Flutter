
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/game/space_shooter_game.dart';


class Rock extends SpriteComponent with  HasGameRef<SpaceShooterGame>,CollisionCallbacks{
  Rock({
    required this.rockPositionX,
    required this.rockDirectionX,
    required this.rockDirectionY
  });
  final double rockPositionX;
  final double rockDirectionX;
  final double rockDirectionY;




  @override
  Future <void> onLoad() async{
    position.y = -50;
    position.x = rockPositionX;    
    final rock = await Flame.images.load('rocktest.png');
    size = Vector2(50, 50);
    sprite = Sprite(rock);
    add(CircleHitbox());
  }




  @override
    void update(double dt){
      super.update(dt);
      position.y += rockDirectionY;
      position.x += rockDirectionX;                          //rocks movements 
      if( position.y > gameRef.size.y || position.x < -50 || position.x > gameRef.size.x + 50){
        gameRef.rockDestroyed =true;
        removeFromParent();
      }
    }


    @override
    void onCollisionStart(Set<Vector2> intersectionPoints,PositionComponent other,)
    {
      super.onCollisionStart(intersectionPoints, other);
      if(other is Bullet){
        removeFromParent();
        FlameAudio.play('crash.ogg');
        gameRef.rockDestroyed =true;
      }
       
    }
}