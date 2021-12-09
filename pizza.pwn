#include <a_samp>


// ** Filterscripts by Rico Endico (yb), newman3
// ** DONT DELETE THIS CREDITS AND SELLING THIS SCRIPTS!
// ** Github : https://github.com/ricoendico (Release Script in here)
// ** Youtube: Rico Endico                   (Script preview upload in here)
// ** Discord: https://bit.ly/lssycommunity  (Community discord)

#define MAX_PIZZA_CAR 	6 
#define PIZZA_SLOT    	3
#define PIZZA_ICON    	40 
#define PIZZA_MONEY   	100 + random(20) 
#define PIZZA_COLOR   	0xFFFF00AA 
#define PIZZA_COLOR2   	"{FFFF00}"
#define DIALOG_PIZZA    765 



new PizzaCar[MAX_PIZZA_CAR][2];
new PizzaPickup[2];
new bool:PizzaInHands[MAX_PLAYERS];
new Text:PizzaTextDraw[6];
new PizzaCash[MAX_PLAYERS];
new bool:PizzaPlayer[MAX_PLAYERS];

new Float:PizzaSpawn[][3] = {
	{-1744.80811, 1308.67578, 6.17915},
	{-1641.17102, 1203.70410, 6.22885},
	{-1550.92126, 1168.92639, 6.18073},
	{-1616.66187, 1122.75720, 6.18036},
	{-1643.19714, 1173.81592, 6.24688},
	{-1852.49695, 1162.51379, 39.88734},
	{-1901.22290, 1203.37903, 41.35725},
	{-1983.29456, 1118.92883, 52.11228},
	{-2152.70581, 1249.37903, 24.66675}
};


SetPizzaCheckpoint(playerid){ 
	new spawnid = random(sizeof(PizzaSpawn));
	SetPlayerCheckpoint(playerid,PizzaSpawn[spawnid][0],PizzaSpawn[spawnid][1],PizzaSpawn[spawnid][2],2.0);
}

RemovePizza(playerid){ 
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 0);
	PizzaInHands[playerid] = false;
}

UpdatePizzaTextDraw(playerid){ 
	for(new i=0; i<6; i++){
		TextDrawHideForPlayer(playerid,PizzaTextDraw[i]);
	}
  	for(new i=0; i<MAX_PIZZA_CAR; i++){
		if(GetPlayerVehicleID(playerid) == PizzaCar[i][0] && PizzaCar[i][1] > 0){
			for(new t=0; t<PizzaCar[i][1]+1; t++){
				TextDrawShowForPlayer(playerid,PizzaTextDraw[t]);
			}
		}
  	}
}

forward CreatePizzaPickup();
public CreatePizzaPickup(){
	PizzaPickup[1] = CreatePickup(2814, 14, -1715.91650, 1349.89966, 6.91196, -1);
}




public OnFilterScriptInit()
{

	print("===========================");
	print(" .Pizza Boy Loaded By YB.");
	print("===========================");
/*
	PizzaCar[0][0] = CreateVehicle(448, -1722.0343, 1363.4006, 6.8175, -99.3000, -1, -1, 60*2);
	PizzaCar[1][0] = CreateVehicle(448, -1720.6392, 1364.3207, 6.8175, -99.3000, -1, -1, 60*2);
	PizzaCar[2][0] = CreateVehicle(448, -1719.2592, 1365.4016, 6.8175, -99.3000, -1, -1, 60*2);
	PizzaCar[3][0] = CreateVehicle(448, -1717.8374, 1366.5730, 6.8175, -99.3000, -1, -1, 60*2);
*/
	PizzaCar[0][0] = CreateVehicle(448, -1721.0341, 1363.5796, 6.8319, -102.6000, -1, -1, 100);
	PizzaCar[1][0] = CreateVehicle(448, -1719.8258, 1364.5298, 6.8319, -102.6000, -1, -1, 100);
	PizzaCar[2][0] = CreateVehicle(448, -1718.8534, 1365.3091, 6.8319, -102.6000, -1, -1, 100);
	PizzaCar[3][0] = CreateVehicle(448, -1717.4076, 1366.3669, 6.8319, -102.6000, -1, -1, 100);
	PizzaCar[4][0] = CreateVehicle(448, -1716.4574, 1367.2659, 6.8319, -102.6000, -1, -1, 100);
	PizzaCar[5][0] = CreateVehicle(448, -1715.3739, 1368.1494, 6.8319, -102.6000, -1, -1, 100);


	
	PizzaPickup[0] = CreatePickup(1275, 2, -1719.49963, 1354.71729, 6.91196, -1);
	CreatePizzaPickup();



	PizzaTextDraw[0] = TextDrawCreate(560.00, 140.00, "_");
	TextDrawAlignment(PizzaTextDraw[0], 2);
	TextDrawFont(PizzaTextDraw[0], 2);
	TextDrawLetterSize(PizzaTextDraw[0], 1.79, 10.00);
	TextDrawTextSize(PizzaTextDraw[0], 32.30, 64.19);
	TextDrawUseBox(PizzaTextDraw[0], 1);
	TextDrawBoxColor(PizzaTextDraw[0], 0x80808040);
	TextDrawSetProportional(PizzaTextDraw[0], 1);
	
	PizzaTextDraw[1] = TextDrawCreate(530.00, 160.00, "pizza");
	PizzaTextDraw[2] = TextDrawCreate(530.00, 150.00, "pizza");
	PizzaTextDraw[3] = TextDrawCreate(530.00, 140.00, "pizza");
	PizzaTextDraw[4] = TextDrawCreate(530.00, 130.00, "pizza");
	PizzaTextDraw[5] = TextDrawCreate(530.00, 120.00, "pizza");
	
    for(new i=1; i<6; i++){
		TextDrawAlignment(PizzaTextDraw[i], 1);
		TextDrawFont(PizzaTextDraw[i], 5);
		TextDrawLetterSize(PizzaTextDraw[i], 2.29, 5.20);
		TextDrawTextSize(PizzaTextDraw[i], 62.59, 74.30);
		TextDrawColor(PizzaTextDraw[i], 0xFFFFFFFF);
		TextDrawBackgroundColor(PizzaTextDraw[i], 0xFFFFFF00);
		TextDrawSetPreviewModel(PizzaTextDraw[i], 2814);
		TextDrawSetPreviewRot(PizzaTextDraw[i], -40.00, 0.00, -130.00, 1.00);
		TextDrawSetProportional(PizzaTextDraw[i], 1);
    }


	return 1;
	
}


public OnFilterScriptExit()
{
	for(new i=0; i<6; i++){
		TextDrawDestroy(PizzaTextDraw[i]);
	}
	for(new i=0; i<MAX_PIZZA_CAR; i++){
		DestroyVehicle(PizzaCar[i][0]);
	}
	for(new i=0; i<2; i++){
		DestroyPickup(PizzaPickup[i]);
	}
	
	return 1;
}


public OnPlayerConnect(playerid)
{
    PizzaPlayer[playerid] = false;
    PizzaCash[playerid]   = 0;
    SetPlayerMapIcon(playerid, PIZZA_ICON, -1719.49963, 1354.71729, 6.42228, 29, 0, MAPICON_LOCAL );
	return 1;
}


public OnPlayerDeath(playerid, killerid, reason)
{
    PizzaPlayer[playerid] = false;
	return 1;
}



public OnPlayerCommandText(playerid, cmdtext[])
{
	/*if (strcmp("/pizza", cmdtext, true, 10) == 0) // commands script
	{
		PizzaPlayer[playerid] = true;
		SendClientMessage(playerid,PIZZA_COLOR,"To take Pizza Use.(/getpizza).");
	    //SetPlayerSkin(playerid, 155);
		SetPizzaCheckpoint(playerid);
	}*/
	if (strcmp("/getpizza", cmdtext, true, 10) == 0)
	{
 		if(!PizzaPlayer[playerid]){
			return 1;
	    }
	    if(IsPlayerInAnyVehicle(playerid)){
	        SendClientMessage(playerid,PIZZA_COLOR,"you are too far from the vehicle.");
	        return 1;
	    }
	    new Float:x,Float:y,Float:z;
	    for(new i=0; i<MAX_PIZZA_CAR; i++){
	    	GetVehiclePos(PizzaCar[i][0], x, y, z);
    	 	if(IsPlayerInRangeOfPoint(playerid, 2.0, x, y,z)){
	 	    	if(PizzaCar[i][1] > 0){
	    	 		SetPlayerAttachedObject(playerid, PIZZA_SLOT, 2814, 6, 0.100, -0.031, -0.192, -112.900, -9.000, 175.699);
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
					PizzaCar[i][1]--;
					PizzaInHands[playerid] = true;
    	 		}else{
    	 			SendClientMessage(playerid,PIZZA_COLOR,"It's over!");
    	 		}
    	 		break;
    	 	}
	    }
		return 1;
	}
	return 0;
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
    UpdatePizzaTextDraw(playerid);
	if(newstate == PLAYER_STATE_DRIVER){
		for(new i=0; i<MAX_PIZZA_CAR; i++){
			if(PizzaCar[i][0] == GetPlayerVehicleID(playerid) && !PizzaPlayer[playerid]){
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid,PIZZA_COLOR,"Do not work in the field!");
				break;
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(PizzaPlayer[playerid]){ 
		if(PizzaInHands[playerid]){
		    new string[5];
		    new pay = PIZZA_MONEY;
	    	SetPizzaCheckpoint(playerid);
	    	RemovePizza(playerid);
	    	SendClientMessage(playerid,PIZZA_COLOR,"Pizza Stored!");
			PizzaCash[playerid] += pay; // pizza money
			format(string,5,"+%d",pay);
			GameTextForPlayer(playerid, string, 2000, 4);
	    }else{
	        SendClientMessage(playerid,PIZZA_COLOR,"[ ! ] Anda harus turun dari kendaraan, dan gunakan /getpizza untuk mengambil pizza!");
	    }
    }
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(PizzaPickup[1] == pickupid){
	    for(new i=0; i<MAX_PIZZA_CAR; i++){
			if(GetPlayerVehicleID(playerid) == PizzaCar[i][0] && PizzaCar[i][1] != 5){
				PizzaCar[i][1] = 5;
				UpdatePizzaTextDraw(playerid);
				SendClientMessage(playerid,PIZZA_COLOR,"Pizza Loaded!");
				break;
			}
		}
		DestroyPickup(PizzaPickup[1]);
		SetTimer("CreatePizzaPickup",2000,false);
	}else if(PizzaPickup[0] == pickupid){
		if(!PizzaPlayer[playerid]){
			ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_MSGBOX, ""PIZZA_COLOR2"[Pizza]", ""PIZZA_COLOR2"Would you like to start working with the pizza driver?", "Yes", "No");
	    }else{
	    	ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_MSGBOX, ""PIZZA_COLOR2"[Pizza]", ""PIZZA_COLOR2"Would you like to make sure the pump is working?", "Yes", "No");
	    }
	}
	return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_PIZZA){
	    if(response){
	        switch(PizzaPlayer[playerid]){
            	case 0:{
            	    PizzaPlayer[playerid] = true;
            	    SendClientMessage(playerid,PIZZA_COLOR,"To take pizza use (/getpizza).");
            	    SetPlayerSkin(playerid, 155);
					SetPizzaCheckpoint(playerid);
				}
           		case 1:{
					PizzaPlayer[playerid] = false;
					SendClientMessage(playerid,PIZZA_COLOR,"The work day is over..");
					GivePlayerMoney(playerid,PizzaCash[playerid]);
					PizzaCash[playerid] = 0;
					DisablePlayerCheckpoint(playerid);
				}
	        }
		}
	}
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_FIRE) && PizzaInHands[playerid]){
        RemovePizza(playerid);
        SendClientMessage(playerid,PIZZA_COLOR,"YOUR FUNCTIONS!");
    }
	return 1;
}

