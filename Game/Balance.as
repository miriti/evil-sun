package Game
{
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Balance
	{
		static public var baloonHealth:Number = 3000;
		static public var baloonBombDamage:Number = 300;
		static public var baloonSpeed:Number = 15;
		static public var baloonScore:Number = 250;
		
		static public var btrHealth:Number = 500;
		static public var btrScore:Number = 150;
		static public var btrSpeed:Number = 70;
		static public var btrAttackDamage:Number = 25;
		static public var btrExplosionDamage:Number = 150;
		
		public static var tankSpeed:Number = 40;
		public static var tankSpeedDevation:Number = 0.2;
		public static var tankHealth:Number = 250;
		public static var tankGunDamage:Number = 10;
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
		static public var troopGroupHealth:Number = 500;
		static public var troopGroupExplosionDamage:Number = 60;
		
		static public var troopBossHealth:Number = 4000;
		static public var troopBossSpeed:Number = 20;
		static public var troopBossScore:Number = 1000;
		static public var troopBossExplosionDamage:Number = 500;
		
		static public var planeSpeed:Number = 100;
		static public var planeHealth:Number = 180;
		static public var planeScore:Number = 75;
		static public var planeDamage:Number = 100;
		
		public static var factoryHealth:Number = 1500;
		
		static public var apocalypseIncVal:Array = [2, 2, 2, 2, 2];
		static public var apocalypseDamageMin:Array = [100, 300, 400, 500, 600];
		static public var apocalypseDamageMax:Array = [700, 1500, 3000, 6000, 15000];
		static public var apocalypseRecovery:Array = [15000, 30000, 30000, 30000, 30000];
		static public var apocalypseUpgradeCost:Array = [5000, 5000, 7500, 10000, 10000];
		
		static public var fireballAutofire:Array = [true, true, true, true, true];
		static public var fireballDamageMin:Array = [50, 75, 100, 150, 300];
		static public var fireballDamageMax:Array = [200, 250, 500, 1000, 2000];
		static public var fireballDamageRadius:Array = [150, 160, 170, 180, 300];
		static public var fireballPowerInc:Array = [1, 1, 1, 1, 1];
		static public var fireballPowerMin:Array = [0.2, 0.2, 0.2, 0.2, 0.2];		
		static public var fireballRecovery:Array = [50, 50, 50, 50, 50];
		static public var fireballUpgrageCost:Array = [1000, 2000, 8000, 16000, 100000];
		static public var fireballSpeed:Number = 600;
		
		static public var shotgunAutofire:Array = [true, true, true, true, true];
		public static var shotgunDamageMin:Array = [10, 15, 25, 50, 100];
		public static var shotgunDamageMax:Array = [10, 15, 25, 50, 100];
		public static var shotgunPowerInc:Array = [3, 3, 3, 3, 3];
		public static var shotgunPowerMin:Array = [3, 3, 3, 3, 3];
		static public var shotgunRecovery:Array = [50, 50, 50, 50, 50];
		static public var shotgunBulletCount:Array = [3, 4, 5, 5, 6];
		public static var shotgunUpdateCost:Array = [1000, 2000, 8000, 32000, 100000];
		static public var shotgunAngleDisp:Array = [Math.PI / 8, Math.PI / 10, Math.PI / 12, Math.PI / 15, Math.PI / 20];
		
		static public var rayAutofire:Array = [true, true, true, true, true];
		static public var rayDamage:Array = [80, 90, 70, 50, 200];
		static public var raySpeed:Array = [500, 500, 500, 600, 1000];
		static public var rayPowerInc:Array = [2, 2, 3, 4, 10];
		static public var rayPowerMin:Array = [0.5, 0.5, 0.5, 0.5, 0.5];
		static public var rayRecovery:Array = [50, 50, 50, 50, 50];
		static public var rayUpgrageCost:Array = [1000, 2000, 4000, 10000, 50000];
		
		static public var cloudStrikePower:Number = 75;		
	}

}