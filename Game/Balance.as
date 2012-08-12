package Game
{
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Balance
	{
		public static var factoryHealth:Number = 1500;
		
		/*****************
		 * E N E M Y E S *
		 *****************/
		static public var baloonHealth:Number = 3000;
		static public var baloonBombDamage:Number = 300;
		static public var baloonSpeed:Number = 15;
		static public var baloonScore:Number = 250;
		
		static public var btrHealth:Number = 400;
		static public var btrScore:Number = 150;
		static public var btrSpeed:Number = 70;
		static public var btrAttackDamage:Number = 25;
		static public var btrExplosionDamage:Number = 150;
		
		static public var tankSpeed:Number = 40;
		static public var tankSpeedDevation:Number = 0.2;
		static public var tankHealth:Number = 250;
		static public var tankGunDamage:Number = 10;
		static public var tankScore:Number = 50;
		static public var tankExplosionPower:Number = 50;
		static public var tankShotDelay:Number = 750;
		
		static public var troopSpeed:Number = 50;
		static public var troopHealth:Number = 120;
		static public var troopScore:Number = 25;
		static public var troopAttackDelay:Number = 500;
		static public var troopDamage:Number = 20;
		
		static public var troopGroupScore:Number = 75;
		static public var troopGroupSpeed:Number = 40;
		static public var troopGroupHealth:Number = 300;
		static public var troopGroupExplosionDamage:Number = 60;
		
		static public var planeSpeed:Number = 100;
		static public var planeHealth:Number = 180;
		static public var planeScore:Number = 75;
		static public var planeDamage:Number = 100;	
		
		/*****************
		 * W E A P O N S *
		 *****************/
		
		static public var apocalypseIncVal:Array = [2, 2, 2, 2, 2];
		static public var apocalypseDamageMin:Array = [100, 300, 400, 500, 600];
		static public var apocalypseDamageMax:Array = [500, 500, 500, 1000, 1000];
		static public var apocalypseRecovery:Array = [30000, 20000, 10000, 10000, 8000];
		static public var apocalypseUpgradeCost:Array = [5000, 7500, 10000, 15000, 20000];
		
		static public var fireballAutofire:Array = [true, true, true, true, true];
		static public var fireballDamageMin:Array = [50, 75, 100, 150, 300];
		static public var fireballDamageMax:Array = [50, 75, 100, 150, 300];
		static public var fireballDamageRadius:Array = [150, 160, 170, 180, 300];
		static public var fireballPowerInc:Array = [1.5, 1.5, 1.5, 1.5, 1.5];
		static public var fireballPowerMin:Array = [0.5, 0.5, 0.5, 0.5, 0.5];
		static public var fireballRecovery:Array = [50, 50, 50, 50, 50];
		static public var fireballUpgrageCost:Array = [1000, 2000, 4000, 8000, 16000];
		static public var fireballSpeed:Number = 400;
		
		static public var shotgunAutofire:Array = [true, true, true, true, true];
		static public var shotgunDamageMin:Array = [10, 10, 10, 10, 10];
		static public var shotgunDamageMax:Array = [10, 10, 10, 10, 10];
		static public var shotgunPowerInc:Array = [3, 3, 3, 3, 3];
		static public var shotgunPowerMin:Array = [1, 1, 1, 1, 1];
		static public var shotgunRecovery:Array = [50, 50, 50, 50, 50];
		static public var shotgunBulletCount:Array = [3, 4, 5, 6, 7];
		static public var shotgunUpdateCost:Array = [1000, 2000, 4000, 8000, 16000];
		static public var shotgunAngleDisp:Array = [Math.PI / 10, Math.PI / 10, Math.PI / 12, Math.PI / 15, Math.PI / 20];
		
		static public var rayAutofire:Array = [true, true, true, true, true];
		static public var rayDamage:Array = [50, 50, 50, 50, 50];
		static public var raySpeed:Array = [500, 500, 500, 500, 500];
		static public var rayPowerInc:Array = [2, 2, 2, 2, 2];
		static public var rayPowerMin:Array = [0.5, 0.5, 0.5, 0.5, 0.5];
		static public var rayRecovery:Array = [50, 50, 50, 50, 50];
		static public var rayUpgrageCost:Array = [1000, 2000, 4000, 8000, 16000];
		static public var rayBulletCount:Array = [1, 2, 3, 4, 5];
	}

}