import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spaceshooter/components/rock.dart';

import 'package:spaceshooter/game/shipmovement.dart';
import 'package:spaceshooter/game/space_shooter_game.dart';
import 'package:spaceshooter/components/game_joystick.dart';
import 'package:spaceshooter/game/configuration.dart';

class Ship extends SpriteGroupComponent<ShipMovement>with   HasGameRef<SpaceShooterGame>,CollisionCallbacks{

  Ship();
  @override
  Future<void> onLoad() async{
    final shipimg = await gameRef.loadSprite('playership.png');
    size = Vector2(50, 50);
    position =Vector2(gameRef.size.x/2, gameRef.size.y/2 );
    current = ShipMovement.up;
    sprites = {
      ShipMovement.up : shipimg,
      ShipMovement.down : shipimg,
      ShipMovement.left : shipimg,
      ShipMovement.right : shipimg,  
    } ;
    add(CircleHitbox());
  }
  @override
  void update(double dt){
    super.update(dt);
  

    if (position.y > gameRef.size.y- size.y){
      position.y = gameRef.size.y-size.y;
    }
    if (position.y < size.y){
      position.y = size.y;
    }
    if (position.x > gameRef.size.x- size.x){
      position.x = gameRef.size.x-size.x;
    }
    if (position.x < 0){
      position.x = 0;
    }

    if (joystick.direction == JoystickDirection.left){
      current = ShipMovement.left;
      position.x -=Config.shipSpeed;

    }
    if (joystick.direction == JoystickDirection.right){
      current = ShipMovement.right;
      position.x +=Config.shipSpeed;

    }
    if (joystick.direction == JoystickDirection.up){
      current = ShipMovement.up;
      position.y -=Config.shipSpeed;

    }
    if (joystick.direction == JoystickDirection.down){
      current = ShipMovement.down;
      position.y +=Config.shipSpeed;

    }
    if (joystick.direction == JoystickDirection.upLeft){
      current = ShipMovement.up;
      position.x -=Config.shipSpeed / sqrt2;
      position.y -=Config.shipSpeed / sqrt2;
    }
    if (joystick.direction == JoystickDirection.upRight){
      current = ShipMovement.up;
      position.x +=Config.shipSpeed / sqrt2;        //to reduce more speed in diagonal joystick direction
      position.y -=Config.shipSpeed / sqrt2;        //when accelarating in x and y direction same time it movement will be root2 times faster                                                 
    }                                                 //to reduce this divided both accilaration speed by root2
    if (joystick.direction == JoystickDirection.downLeft){
      current = ShipMovement.up;
      position.x -=Config.shipSpeed /sqrt2;
      position.y +=Config.shipSpeed /sqrt2;
    }
    if (joystick.direction == JoystickDirection.downRight){
      current = ShipMovement.up;
      position.x +=Config.shipSpeed /sqrt2;
      position.y +=Config.shipSpeed /sqrt2;
    }

  }
  @override
    void onCollisionStart(Set<Vector2> intersectionPoints,PositionComponent other,)
    {
      super.onCollisionStart(intersectionPoints, other);

      if(other is Rock){
        print("collided with roock");
      }
       
    }

}