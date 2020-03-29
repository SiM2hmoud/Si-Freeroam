// --------------------------------------------------------------- //
//                        Si Freeroam                              //
//                     Developer: SiM2hmoud                        //
//                 Version: 2.0  (Full Version)                    //
// --------------------------------------------------------------- //
// -------------------- { Changelog: } --------------------------- //
// ------------------- { Added or Removed: } --------------------- //
// - Added credits to includes.
// - Added more Random messages.
// - Removed Driving & Pilot licenses.
// - Added a simple anti-ban evade.
// - Improved Drug system.
// - Removed "/useweed, /usecocaine, /usemeth, /mydrugs, /myfood, /usetaco, /usesoda, /usepizza".
// - Added " /usedrug <weed, meth or cocaine ".
// - Added " /inventory ".
// - Added Drug effects.
// - Added Animation when using drugs.
// - Added " /usefood <pizza, soda or taco".
// - Added Animations when using food.
// - Removed " /bweed, /bcocaine, /bmeth, /btaco, /bsoda, /bpizza ".
// - Added V.I.P shop (/vipshop).
// - Removed " /buyskin ".
// - Added " /gethealth, /getarmour, /aslap, /disarm, /banip " to Admins.
// - Added " /giveitem ", it can be used to sell items as well. 
// - Added Materials, that can be used to craft weapons using /craftweapon.
// - Players can use /tag to put tags above their names.
// - Added simple GPS system, " /gps ".
// - Added Anti C-bugging.
// - Added simple Anti-Cheat {Airbreak, Anti-Vehicle Speed Hack, Health Hack, Armour Hack, Jetpack Hack}.
// - Added Headshot system.
// - Removed the mapped objects & added more vehicles.
// ---------------------- { Optimazed: } ------------------------- //
// - Optimazed OnPlayerDeath.
// - Optimazed Drug system & Food system.
// - Optimazed V.I.P system.
// - Optimazed Admin system.
// ---------------------- { Bug fixes: } ------------------------- //
// - Fixed a bug where the " kill " added to the victim not the killer.
// - Fixed a bug where the V.I.P level is not saving.
// - Fixed a bug when you can buy weed, cocaine and meth without paying (V.I.P).
// - Fixed bug when you use ' /help or /rules ', the login & register dialogs appear.
// ---------------------------------------------------------------- //

// -------------------- { Includes: } --------------------------- //

#include <a_samp> // Thanks to SA:MP Team.
#include <YSI\y_ini> // Thanks to Y_Less.
#include <sscanf2> // Thanks to Y_Less.
#include <zcmd> // Thanks to Zeex.
#include <foreach> // Thanks to Y_Less.
#include <mSelection> // Thanks to Blint96.

// ---------------------- { Defines: } ---------------------------- //

#define DRegister 1
#define DLogin 2
#define DRegister2 3
#define DLogin2 4
#define DCWhite "{FFFFFF}"
#define DCRed "{F81414}"
#define DCGreen "{00FF22}"
#define CGREY 0xAFAFAFAA
#define CGREEN 0x33AA33AA
#define CYELLOW 0xFFFF00AA
#define CLIGHTBLUE 0x33CCFFAA
#define CORANGE 0xFF9900AA
#define CRED 0xAA3333AA
#define CLIME 0x10F441AA
#define CBLUE 0x0000BBAA
#define DRules 5
#define DHelp 6
#define DCmds 7
#define DCredits 8
#define DWebsite 9
#define DUpdates 10
#define DACmds 11
#define DVCmds 12
#define DWshop 13
#define DDshop 14
#define DGPS 15



#define MAX_WARNINGS 3
#define MAX_VEHICLE_SPEED 290
#define MAX_HEALTH 99.0
#define MAX_ARMOUR 99.0

// -------------------- { Variables: } ---------------------------- //

new IsSpawned;
new PM[MAX_PLAYER_NAME];
new Weaponshop; // Ammu-nation.
new DrugBoyZ; // Drug BoyZ.
new DrugDepot; // Drug Depot.
new DrugDen; // Drug Den.
new ClothesShop2; // Another Clothes shop.
new ClothesShop3; // Another Clothes shop.
new ClothesShop; // Clothes Shop.
new Weaponshop2; // Another Ammu-nation.
new cskins; // Skin selection for Clothes shop.
new Text:rmsg; // Random messages.
new RandomMessages[][] =
{
    "~y~Si Freeroam: ~w~Make sure to read /rules to avoid ~r~Punishments~w~.",
    "~y~Si Freeroam: ~w~Invite your ~g~friends~w~ to play here!",
    "~y~Si Freeroam: ~w~Having a hard time? read /help & /cmds.",
    "~y~Si Freeroam: ~w~Found a ~r~Cheater~w~? Contact a Staff member.",
    "~y~Si Freeroam: ~w~Want to become a Admin? Visit our website to know more about it!",
    "~y~Si Freeroam: ~w~Found a ~r~Bug~w~? Report it on the forums!",
    "~y~Si Freeroam: ~w~Our website is: www.website.com!",
    "~y~Si Freeroam: ~w~You got any suggestions? Contact us via forums."

};

// -------------------- { Saving system: } ---------------------------- //

#define PATH "/Accounts/%s.ini"

enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pKills,
    pDeaths,
    pVip,
    pInterior,
    pVw,
    pWarns,
    pSkin,
    pScore,
    pWeed,
    pCoke,
    pMeth,
    pTaco,
    pPizza,
    pSoda,
    pMuted,
    pBanned,
    pDrugged,
    pMaterials

}
new PlayerInfo[MAX_PLAYERS][pInfo];

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password:",PlayerInfo[playerid][pPass]);
    INI_Int("Cash:",PlayerInfo[playerid][pCash]);
    INI_Int("Admin:",PlayerInfo[playerid][pAdmin]);
    INI_Int("Kills:",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths:",PlayerInfo[playerid][pDeaths]);
    INI_Int("V.I.P:",PlayerInfo[playerid][pVip]);
    INI_Int("Interior:",PlayerInfo[playerid][pInterior]);
    INI_Int("Virtual World:",PlayerInfo[playerid][pVw]);
    INI_Int("Warns:",PlayerInfo[playerid][pWarns]);
    INI_Int("Skin:",PlayerInfo[playerid][pSkin]);
    INI_Int("Score:",PlayerInfo[playerid][pScore]);
    INI_Int("Weed:",PlayerInfo[playerid][pWeed]);
    INI_Int("Coke:",PlayerInfo[playerid][pCoke]);
    INI_Int("Meth:",PlayerInfo[playerid][pMeth]);
    INI_Int("Taco:",PlayerInfo[playerid][pTaco]);
    INI_Int("Pizza:",PlayerInfo[playerid][pPizza]);
    INI_Int("Soda",PlayerInfo[playerid][pSoda]);
    INI_Int("Muted:",PlayerInfo[playerid][pMuted]);
    INI_Int("Banned:",PlayerInfo[playerid][pBanned]);
    INI_Int("Drugged:",PlayerInfo[playerid][pDrugged]);
    INI_Int("Materials:",PlayerInfo[playerid][pMaterials]);
    return 1;
}

// -------------------- { Gamemode: } ---------------------------- //

main()
{
	print("[GAMEMODE]: Loading...");
	print("[GAMEMODE]: Loading...");
    print("[GAMEMODE]: Loading...");
	print("[GAMEMODE]: Si Freeroam loaded successfully.");
}

public OnGameModeInit()
{
	SetGameModeText("| SiFreeroam |");
    UsePlayerPedAnims();
    EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
    SetTimer("RandomMessage",10000,1); 
    AddPlayerClass(1, 2507.9558,-1670.9633,13.3790, 90, 24, 100, 0, 0, 0, 0);
    Weaponshop = CreatePickup(1242, 1, 1365.4104,-1280.0146,13.5469, 0); // Ammu-nation pickup.
    Weaponshop2 = CreatePickup(1242, 1, 2400.5239,-1981.5889,13.5469, 0); // Ammu-nation pickup.
    DrugBoyZ = CreatePickup(1279, 1,2351.2463,-1169.8097,28.0331, 0); // DrugBoyZ pickup.
    DrugDen = CreatePickup(1279, 1,2166.2820,-1671.3414,15.0736, 0); // Drug Den pickup.
    DrugDepot = CreatePickup(1279, 1,1919.9303,-1863.7692,13.5608, 0); // Drug Depot pickup.
    ClothesShop = CreatePickup(1275, 1, 2245.0327,-1663.6989,15.4766, 0); // Clothes Shop.
    ClothesShop2 = CreatePickup(1275, 1, 1498.5842,-1582.4598,13.5469, 0); // Clothes Shop.
    ClothesShop3 = CreatePickup(1275, 1, 2045.2283,-1913.0979,13.5469, 0); // Clothes Shop.
    cskins = LoadModelSelectionMenu("skins.txt");
    rmsg = TextDrawCreate(7.000000, 427.000000, "You don't need to add any text here");
    TextDrawBackgroundColor(rmsg, 255);
    TextDrawFont(rmsg, 1);
    TextDrawLetterSize(rmsg, 0.379999, 1.499999);
    TextDrawColor(rmsg, -1);
    TextDrawSetOutline(rmsg, 1);
    TextDrawSetProportional(rmsg, 1);
    LoadStaticVehiclesFromFile("vehicles/bone.txt");
    LoadStaticVehiclesFromFile("vehicles/flint.txt");
    LoadStaticVehiclesFromFile("vehicles/ls_airport.txt");
    LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
    LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");
    LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
    LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
    LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");
    LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
    LoadStaticVehiclesFromFile("vehicles/pilots.txt");
    LoadStaticVehiclesFromFile("vehicles/red_county.txt");
    LoadStaticVehiclesFromFile("vehicles/sf_airport.txt");
    LoadStaticVehiclesFromFile("vehicles/sf_gen.txt");
    LoadStaticVehiclesFromFile("vehicles/sf_law.txt");
    LoadStaticVehiclesFromFile("vehicles/sf_train.txt");
    LoadStaticVehiclesFromFile("vehicles/tierra.txt");
    LoadStaticVehiclesFromFile("vehicles/trains.txt");
    LoadStaticVehiclesFromFile("vehicles/trains_platform.txt");
    LoadStaticVehiclesFromFile("vehicles/whetstone.txt"); 
	return 1;
}

public OnPlayerConnect(playerid)
{
   
    SendClientMessage(playerid, CORANGE, "[SERVER]: Welcome to SiFreeroam hope you enjoy your stay with us, use /help & /rules!");
    SetPlayerMapIcon(playerid, 0, 1365.4104,-1280.0146,13.5469, 6, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 1, 2351.2463,-1169.8097,28.0331, 24, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 2, 2245.0327,-1663.6989,15.4766, 45, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 3, 2400.5239,-1981.5889,13.5469, 6, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 4, 2166.2820,-1671.3414,15.0736, 24, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 5, 1919.9303,-1863.7692,13.5608, 24, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 6,1498.5842,-1582.4598,13.5469, 45, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 6,2045.2283,-1913.0979,13.5469, 45, MAPICON_LOCAL);
    CreatePlayer3DTextLabel(playerid, " Ammu-nation ", CGREEN, 1365.4104,-1280.0146,13.5469, 50);
    CreatePlayer3DTextLabel(playerid, " Drug Fellas ", CGREEN, 2351.2463,-1169.8097,28.0331, 50);
    CreatePlayer3DTextLabel(playerid, " Clothes Shop ", CGREEN, 2245.0327,-1663.6989,15.4766, 50);
    CreatePlayer3DTextLabel(playerid, " Ammu-nation ", CGREEN, 2400.5239,-1981.5889,13.5469, 50);
    CreatePlayer3DTextLabel(playerid, " Drug Depot ", CGREEN, 1919.9303,-1863.7692,13.5608, 50);
    CreatePlayer3DTextLabel(playerid, " Clothes Shop ", CGREEN, 1498.5842,-1582.4598,13.5469, 50);
    CreatePlayer3DTextLabel(playerid, " Drug Den ", CGREEN, 2166.2820,-1671.3414,15.0736, 50);
    CreatePlayer3DTextLabel(playerid, " Clothes Shop ", CGREEN, 2045.2283,-1913.0979,13.5469, 50);
    IsSpawned = 0;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: %s has connected to the server.", pname);
    SendClientMessageToAll(CLIME, string);
    PlayerInfo[playerid][pInterior] = 0;
    PlayerInfo[playerid][pVw] = 0;
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DLogin, DIALOG_STYLE_INPUT,""DCWhite"Login:",""DCWhite"Please type your password below to login.","Login","Quit");
    }
    else
    {
        ShowPlayerDialog(playerid, DRegister, DIALOG_STYLE_INPUT,""DCWhite"Create an account:",""DCWhite"Please type your password below to register a new account.","Register","Quit");
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{ 

    new pname[MAX_PLAYER_NAME], string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: %s has left to the server.", pname);
    SendClientMessageToAll(CGREY, string);
    new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash:",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin:",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills:",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths:",PlayerInfo[playerid][pDeaths]);
    INI_WriteInt(File,"V.I.P:",PlayerInfo[playerid][pVip]);
    INI_WriteInt(File,"Interior:",GetPlayerInterior(playerid));
    INI_WriteInt(File,"Virtual World:",GetPlayerVirtualWorld(playerid));
    INI_WriteInt(File,"Warns:",PlayerInfo[playerid][pWarns]);
    INI_WriteInt(File,"Skin:",GetPlayerSkin(playerid));
    INI_WriteInt(File,"Score:",GetPlayerScore(playerid));
    INI_WriteInt(File, "Weed:",PlayerInfo[playerid][pWeed]);
    INI_WriteInt(File, "Cocaine:",PlayerInfo[playerid][pCoke]);
    INI_WriteInt(File, "Meth:",PlayerInfo[playerid][pMeth]);
    INI_WriteInt(File, "Taco:",PlayerInfo[playerid][pTaco]);
    INI_WriteInt(File, "Pizza:",PlayerInfo[playerid][pPizza]);
    INI_WriteInt(File, "Soda:",PlayerInfo[playerid][pSoda]);    
    INI_WriteInt(File, "Muted:",PlayerInfo[playerid][pMuted]);
    INI_WriteInt(File, "Banned:",PlayerInfo[playerid][pBanned]);
    INI_WriteInt(File, "Drugged:",PlayerInfo[playerid][pDrugged]);
    INI_WriteInt(File, "Materials:",PlayerInfo[playerid][pMaterials]);
    INI_Close(File);
    return 1;
}
public OnPlayerSpawn(playerid)
{
    if(PlayerInfo[playerid][pBanned] == 1) 
    {
        SendClientMessage(playerid, CRED, "[SERVER]: This account is banned!");
        SetTimerEx("DelayedBan", 1000, false, "i", playerid);
    }
    IsSpawned = 1;
    SetPlayerHealth(playerid, MAX_HEALTH);
    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    TextDrawShowForPlayer(playerid, rmsg);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerInfo[killerid][pKills]++;
    PlayerInfo[playerid][pDeaths]++;
    if(GetPlayerMoney(playerid) < 500)
    {
      SendClientMessage(playerid, CRED, "[SERVER]: You didn't have $500 to fix your wounds, the server paid in your place!");
    }
    else if(GetPlayerMoney(playerid) > 500)
    {
      SendClientMessage(playerid, CRED, "[SERVER]: You got killed and paid $500 to fix your wounds.");
    }
    new pname[MAX_PLAYER_NAME], ename[MAX_PLAYER_NAME], string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(killerid, ename, sizeof(ename));
    format(string, sizeof(string), "[SERVER]: You killed %s and looted $1,000 from him (+ 1 Score).", pname);
    SendClientMessage(killerid, CLIME, string);
    format(string, sizeof(string), "[SERVER]: You have been killed by %s!", ename);
    SendClientMessage(playerid, CRED, string);
    GivePlayerMoney(killerid, 1000);
    GivePlayerMoney(playerid, -500);
    SetPlayerScore(killerid, GetPlayerScore(playerid)+1);
    SendDeathMessage(killerid, playerid, reason);
    return 1;
}

public OnPlayerText(playerid, text[])
{
    ChatLog(playerid, text);
    if(PlayerInfo[playerid][pMuted] == 1) return SendClientMessage(playerid, CRED, "[SERVER]: You're muted, you can't talk on the chat!");
    else if(PlayerInfo[playerid][pMuted] == 0) return 1;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(IsSpawned == 0) return SendClientMessage(playerid, CRED, "[SERVER]: You must be spawned to use commands!");
	return 0;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    return 1;
}

// -------------------- { Commands: } ---------------------------- //

CMD:rules(playerid, params[])
{
    ShowPlayerDialog(playerid, DRules, DIALOG_STYLE_LIST, "Server Rules:", "- Do not use any Hacks or Cheats [Ban].\n- Do not spam, flood or insult [Warn/Mute].\n- Do not scam any players [Ban].\n- Do not abuse bugs [Ban].\n- Do not advertise any servers or websites [Ban].", "Close", "");
    return 1;
}
CMD:help(playerid, params[])
{
    ShowPlayerDialog(playerid, DHelp, DIALOG_STYLE_MSGBOX, "Server Help:", "- Hello and welcome to Si Freeroam, hope you enjoy your stay with us!\n- Want to earn some money? try killing people or doing jobs. Trading isn't a bad option`!\n- Want a vehicle? maybe look around you in the streets.\n- Found a cheater? contact a Staff member!\n- Found a bug? report it on our website!", "Close","");
    return 1;
}
CMD:cmds(playerid, params[])
{
    ShowPlayerDialog(playerid, DCmds, DIALOG_STYLE_MSGBOX, "Server Commands:", "- Commands: /rules, /help, /cmds, /credits, /website, /updates, /kill, /repairveh, /mywarns, /inventory, /stats, /usedrug, /usefood, /pm, /pm(on/off), /givecash, /giveitem, /craftweapon, /tag.", "Close", "");
    return 1;
}
CMD:credits(playerid, params[])
{
    ShowPlayerDialog(playerid, DCredits, DIALOG_STYLE_MSGBOX, "Server Credits:", "- Credits: This server scripted by SiM2hmoud.", "Close","");
    return 1;
}
CMD:website(playerid, params[])
{
    ShowPlayerDialog(playerid, DWebsite, DIALOG_STYLE_MSGBOX, "Server Website:", "- Website: www.mywebsite.com", "Close","");
    return 1;
}
CMD:updates(playerid, params[])
{
    ShowPlayerDialog(playerid, DUpdates, DIALOG_STYLE_MSGBOX, "Server Upates:", "- No new updates!", "Close","");
    return 1;
}
CMD:kill(playerid, params[])
{
    SendClientMessage(playerid, CYELLOW, "[SERVER]: You just killed yourself!");
    SetPlayerHealth(playerid, 0.0);
    return 1;
}
CMD:repairveh(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, CRED, "[SERVER]: You are not in a vehicle!");
    if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, CRED, "[SERVER]: You need $500 to fix your vehicle!");
    SendClientMessage(playerid, CGREEN, "[SERVER]: You payed $500 & fixed your vehicle!");
    GivePlayerMoney(playerid, -500);
    RepairVehicle(GetPlayerVehicleID(playerid));
    return 1;
}
CMD:stats(playerid, params[])
{
    new string[128], pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "| NAME: %s | SCORE: %d | CASH: %d | ADMIN RANK: %d | V.I.P RANK: %d |", pname, GetPlayerScore(playerid), GetPlayerMoney(playerid), PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pVip]);
    SendClientMessage(playerid, CLIGHTBLUE, string);
    return 1;
}
CMD:mywarns(playerid, params[])
{
    new string[128];
    format(string, sizeof(string), "[SERVER]: You got %d warns, 3 warns and you will be kicked out from the server!", PlayerInfo[playerid][pWarns]);
    SendClientMessage(playerid, CRED, string);
}
CMD:inventory(playerid, params[])
{
    new pname[MAX_PLAYER_NAME], string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "| WEED: %d | COKE: %d | METH: %d | TACO: %d | PIZZA: %d | SODA: %d | MATERIALS: %d |", PlayerInfo[playerid][pWeed], PlayerInfo[playerid][pCoke], PlayerInfo[playerid][pMeth], PlayerInfo[playerid][pTaco], PlayerInfo[playerid][pPizza], PlayerInfo[playerid][pSoda], PlayerInfo[playerid][pMaterials]);
    SendClientMessage(playerid, CLIME, string);
    return 1;

}
CMD:gps(playerid, params[])
{
    ShowPlayerDialog(playerid, DGPS, DIALOG_STYLE_LIST, "Server GPS:", "- Ammu-nation\n- Ammu-nation II\n- DrugBoyZ\n- Drug Den\n- Drug Depot\n- Clothes shop\n- Clothes shop II\n- Clothes shop III", "Select","Close"); 
    return 1;
}
CMD:usedrug(playerid, params[])
{
    new drug[32], Float:health;
    GetPlayerHealth(playerid, health);
    if(sscanf(params,"s[32]", drug)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /usedrug <name> '!");
    if(strcmp(drug, "cocaine", true) == 0)
    {
                if(PlayerInfo[playerid][pCoke] >= 5)
                {
                        SetPlayerWeather(playerid, -66);
                        SetPlayerDrunkLevel(playerid, 100);
                        SetPlayerTime(playerid, 12, 00);
                        GameTextForPlayer(playerid, "~r~Woahhh!!!", 3000, 5);
                        SendClientMessage(playerid, CGREEN, "[SERVER]: You used 5 grams of cocaine.");
                        if(health > 50)
                        {
                            SetPlayerHealth(playerid, MAX_HEALTH);
                        } 
                        else GiveHealth(playerid, 50);
                        ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 1, 1, 1, 1, 1, 1);
                        PlayerInfo[playerid][pDrugged] = 1;
                        SetTimer("IsDrugged", 120000, false);
                        PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]-5;
                }
                else
                {
                    SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 5 grams of cocaine to use them.");
                }
    }
    if(strcmp(drug, "weed", true) == 0)
    {
                if(PlayerInfo[playerid][pWeed] >= 5)
                {
                        SetPlayerWeather(playerid, -66);
                        SetPlayerDrunkLevel(playerid, 100);
                        SetPlayerTime(playerid, 12, 00);
                        GameTextForPlayer(playerid, "~r~Woahhh!!!", 3000, 5);
                        SendClientMessage(playerid, CGREEN, "[SERVER]: You smoked 5 grams of weed.");
                        if(health > 75)
                        {
                            SetPlayerHealth(playerid, MAX_HEALTH);
                        } 
                        else GiveHealth(playerid, 25);
                        ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 1, 1, 1, 1, 1, 1);
                        PlayerInfo[playerid][pDrugged] = 1;
                        SetTimer("IsDrugged", 120000, false);
                        PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]-5;

                }
                else
                {
                    SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 5 grams of weed to smoke them.");
                }
 
    }
    if(strcmp(drug, "meth", true) == 0)
    {
                if(PlayerInfo[playerid][pMeth] >= 5)
                {
                        SetPlayerWeather(playerid, -66);
                        SetPlayerDrunkLevel(playerid, 100);
                        SetPlayerTime(playerid, 12, 00);
                        GameTextForPlayer(playerid, "~r~Woahh!!!", 3000, 5);
                        SendClientMessage(playerid, CGREEN, "[SERVER]: You used 5 grams of meth.");
                        if(health > 25)
                        {
                            SetPlayerHealth(playerid, MAX_HEALTH);
                        } 
                        else GiveHealth(playerid, 75);
                        ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 1, 1, 1, 1, 1, 1);
                        PlayerInfo[playerid][pDrugged] = 1;
                        SetTimer("IsDrugged", 120000, false);
                        PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]-5;


                }
                else
                {
                    SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 5 grams of meth to use them.");
                }
    }
    return 1;
}
forward IsDrugged(playerid);
public IsDrugged(playerid)
{
        PlayerInfo[playerid][pDrugged] = 0;
        SetPlayerWeather(playerid, 1);
        SetPlayerDrunkLevel(playerid, 0);
}
CMD:usefood(playerid, params[])
{
    new food[32], Float:health;
    GetPlayerHealth(playerid, health);
    if(sscanf(params,"s[32]", food)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /usefood <name> '!");
    if(strcmp(food, "pizza", true) == 0)
    {
                if(PlayerInfo[playerid][pPizza] >= 1)
                {
                        SendClientMessage(playerid, CYELLOW, "[SERVER]: You ate 1 slice of pizza.");
                        if(health > 75)
                        {
                            SetPlayerHealth(playerid, MAX_HEALTH);
                        } 
                        else GiveHealth(playerid, 25);
                        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 1, 1, 1, 1, 1, 1);
                        PlayerInfo[playerid][pPizza] = PlayerInfo[playerid][pPizza]-1;
                }
                else
                {
                    SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 1 slice of pizza to eat it.");
                }
    }
    if(strcmp(food, "taco", true) == 0)
    {
                if(PlayerInfo[playerid][pTaco] >= 1)
                {
                        SendClientMessage(playerid, CYELLOW, "[SERVER]: You ate 1 taco.");
                        if(health > 50)
                        {
                            SetPlayerHealth(playerid, MAX_HEALTH);
                        } 
                        else GiveHealth(playerid, 50);
                        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 1, 1, 1, 1, 1, 1);
                        PlayerInfo[playerid][pTaco] = PlayerInfo[playerid][pTaco]-1;
                }
                else
                {
                    SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 1 taco to eat it.");
                }
    }
    if(strcmp(food, "soda", true) == 0)
    {
                if(PlayerInfo[playerid][pSoda] >= 1)
                {
                        SendClientMessage(playerid, CYELLOW, "[SERVER]: You drinked 1 cup of soda.");
                        if(health > 25)
                        {
                            SetPlayerHealth(playerid, MAX_HEALTH);
                        } 
                        else GiveHealth(playerid, 75);
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
                        PlayerInfo[playerid][pSoda] = PlayerInfo[playerid][pSoda]-1;
                }
                else
                {
                    SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 1 cup of soda to drink it.");
                }
    }
    return 1;
}
CMD:pmon(playerid, params[])
{
    if(PM[playerid] == 0) return SendClientMessage(playerid, CRED, "[SERVER]: Your PM is already on!");
    PM[playerid] = 0;
    SendClientMessage(playerid, CGREEN, "[SERVER]: 'PM' turned ON!");

    return 1;
}
CMD:pmoff(playerid, params[])
{
    if(PM[playerid] == 1) return SendClientMessage(playerid, CRED, "[SERVER]: Your PM is already off!");
    PM[playerid] = 1;
    SendClientMessage(playerid, CGREEN, "[SERVER]: 'PM' turned OFF!");
    return 1;
}
CMD:pm(playerid, params[])
{
    new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], targetid, message;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    if(sscanf(params, "us", targetid, message)) SendClientMessage(playerid, CRED, "[SERVER]: Usage: /PM <ID> <Message>.");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player id.");
    if(PM[playerid] == 1) return SendClientMessage(playerid, CRED, "[SERVER]: Your PM is off, you can't send messages!");
    if(PM[targetid] == 1) return SendClientMessage(playerid, CRED, "[SERVER]: This player's PM is off, you can't send him messages!");
    format(string, sizeof(string), "(PM)%s: %s", pname, message);
    SendClientMessage(playerid, CGREEN, string);
    format(string, sizeof(string), "(PM)%s: %s", pname, message);
    SendClientMessage(targetid, CBLUE, string);
    return 1;
}
CMD:tag(playerid, params[])
{
    new string[128];
    new Text3D:label = Create3DTextLabel(string , CLIME, 30.0, 40.0, 50.0, 40.0, 0);
    if(sscanf(params,"s", string)) return SendClientMessage(playerid, CRED, "[SERVER]: Usage: /tag <Text>.");
    Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.7);
    return 1;
}
CMD:givecash(playerid, params[])
{
    new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], targetid, cash;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    if(sscanf(params, "ud", targetid, cash)) return SendClientMessage(playerid, CRED, "[SERVER]: Use /givecash <ID> <amount>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player ID!");
    if(targetid == playerid) return SendClientMessage(playerid, CRED, "[SERVER]: You can't send money to yourself!");
    if(GetPlayerMoney(playerid) < cash) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money!");
    GivePlayerMoney(targetid, cash);
    GivePlayerMoney(playerid, -cash);
    format(string, sizeof(string), "[SERVER]: You've sent %s $%d.", tname, cash);
    SendClientMessage(playerid, CGREEN, string);
    format(string, sizeof(string), "[SERVER]: %s sent you $%d.", pname, cash);
    SendClientMessage(targetid, CBLUE, string);
    return 1;

}
CMD:craftweapon(playerid, params[])
{
    new weapon[32];
    SendClientMessage(playerid, CGREY, "[SERVER]: Items: ' Deagle, Shotgun, SMG, M4 '.");
    if(sscanf(params,"s[32]", weapon)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /craftweapon <name> '!");
    if(strcmp(weapon, "deagle", true) == 0)
    {
        if(PlayerInfo[playerid][pMaterials] < 5000) return SendClientMessage(playerid, CRED, "[SERVER]: You need 5000 materials to craft this!");
        GivePlayerWeapon(playerid, 24, 10000);
        PlayerInfo[playerid][pMaterials] = PlayerInfo[playerid][pMaterials]-5000;
        SendClientMessage(playerid, CLIME, "[SERVER]: You crafted a Desert eagle.");
    
    }
    if(strcmp(weapon, "shotgun", true) == 0)
    {
        if(PlayerInfo[playerid][pMaterials] < 2000) return SendClientMessage(playerid, CRED, "[SERVER]: You need 2000 materials to craft this!");
        GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 10000);
        PlayerInfo[playerid][pMaterials] = PlayerInfo[playerid][pMaterials]-2000;
        SendClientMessage(playerid, CLIME, "[SERVER]: You crafted a Shotgun.");
    
    }
    if(strcmp(weapon, "smg", true) == 0)
    {
        if(PlayerInfo[playerid][pMaterials] < 8000) return SendClientMessage(playerid, CRED, "[SERVER]: You need 8000 materials to craft this!");
        GivePlayerWeapon(playerid, WEAPON_MP5, 10000);
        PlayerInfo[playerid][pMaterials] = PlayerInfo[playerid][pMaterials]-8000;
        SendClientMessage(playerid, CLIME, "[SERVER]: You crafted a SMG.");
    
    }
    if(strcmp(weapon, "m4", true) == 0)
    {
        if(PlayerInfo[playerid][pMaterials] < 10000) return SendClientMessage(playerid, CRED, "[SERVER]: You need 10000 materials to craft this!");
        GivePlayerWeapon(playerid, WEAPON_M4, 10000);
        PlayerInfo[playerid][pMaterials] = PlayerInfo[playerid][pMaterials]-10000;
        SendClientMessage(playerid, CLIME, "[SERVER]: You crafted a M4.");
    
    }
    return 1;
}
CMD:giveitem(playerid, params[])
{
    new item[32], amount, pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], targetid, string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    SendClientMessage(playerid, CGREY, "[SERVER]: Items: ' weed, cocaine, meth, taco, soda and pizza '.");
    if(sscanf(params,"s[32]",item, targetid, amount)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /giveitem <item> <amount> '!");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED,"[SERVER]: Invalid Player ID!");
    if(strcmp(item, "cocaine", true) == 0)
    {
        if(PlayerInfo[playerid][pCoke] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pCoke] = PlayerInfo[targetid][pCoke]+amount;
        PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d grams of cocaine!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d grams of cocaine!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    }
    if(strcmp(item, "weed", true) == 0)
    {
        if(PlayerInfo[playerid][pWeed] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pWeed] = PlayerInfo[targetid][pWeed]+amount;
        PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d grams of weed!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d grams of weed!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    
    }
    if(strcmp(item, "meth", true) == 0)
    {
        if(PlayerInfo[playerid][pMeth] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pMeth] = PlayerInfo[targetid][pMeth]+amount;
        PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d grams of meth!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d grams of meth!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    
    }
    if(strcmp(item, "taco", true) == 0)
    {
        if(PlayerInfo[playerid][pTaco] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pTaco] = PlayerInfo[targetid][pTaco]+amount;
        PlayerInfo[playerid][pTaco] = PlayerInfo[playerid][pTaco]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d tacos!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d tacos!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    
    }
    if(strcmp(item, "pizza", true) == 0)
    {
        if(PlayerInfo[playerid][pPizza] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pPizza] = PlayerInfo[targetid][pPizza]+amount;
        PlayerInfo[playerid][pPizza] = PlayerInfo[playerid][pPizza]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d slices of pizza!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d slices of pizza!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    }
    if(strcmp(item, "soda", true) == 0)
    {
        if(PlayerInfo[playerid][pSoda] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pSoda] = PlayerInfo[targetid][pSoda]+amount;
        PlayerInfo[playerid][pSoda] = PlayerInfo[playerid][pSoda]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d cups of soda!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d cups of soda!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    
    }
    if(strcmp(item, "materials", true) == 0)
    {
        if(PlayerInfo[playerid][pMaterials] < amount) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have that amount!");
        PlayerInfo[targetid][pMaterials] = PlayerInfo[targetid][pMaterials]+amount;
        PlayerInfo[playerid][pMaterials] = PlayerInfo[playerid][pMaterials]-amount;
        format(string, sizeof(string), "[SERVER]: You gave %s %d pieces of materials!");
        format(string, sizeof(string), "[SERVER]: %s gave you %d pieces of materials!");
        SendClientMessage(playerid, CLIGHTBLUE, string);
        SendClientMessage(targetid, CLIME, string);
    
    }
    return 1;
}
// -------------------- { Admin Section: } ---------------------------- //

// -------------------- { Server Owner: } ---------------------------- //


CMD:setadmin(playerid, params[])
{
    new targetid, pname[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], mfp[128], mfa[128], level;
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a RCON Admin to use this command!");
    if(sscanf(params, "ui", targetid, level)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setadmin <ID> <Level>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 < level > 3) return SendClientMessage(playerid, CRED, "[SERVER]: Admin level must be between 0 & 3.");
    PlayerInfo[playerid][pAdmin] = level;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your Admin level to %d!", pname, PlayerInfo[playerid][pAdmin]);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's Admin level to %d!", targetname, PlayerInfo[playerid][pAdmin]);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:setvip(playerid, params[])
{
    new targetid, pname[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], mfp[128], mfa[128], level;
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a RCON Admin to use this command!");
    if(sscanf(params, "ui", targetid, level)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setvip <ID> <Level>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 < level > 3) return SendClientMessage(playerid, CRED, "[SERVER]: V.I.P level must be between 0 & 3.");
    PlayerInfo[playerid][pVip] = level;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your V.I.P level to %d!", pname, PlayerInfo[playerid][pVip]);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's V.I.P level to %d!", targetname, PlayerInfo[playerid][pVip]);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}

// -------------------- { Admin level 1: } ---------------------------- //

CMD:acmds(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    ShowPlayerDialog(playerid, DACmds, DIALOG_STYLE_MSGBOX, "Server Admin Commands:", "- Admin commands:\nAdmin level 1: /warn, /set(health, armour), /akill, /get, /goto, /(un)freeze, /explode, /spec(off), /write, /get(health, armour), /aslap, /disarm.\nAdmin level 2: /kick, /ban, /setskin, /setvw, /agivecash, /healall, /armourall, /agivecashall, /aspawnall, /respawnallvehicles.\nAdmin level 3: /skick, /sban, /setscore, /getall, /setallskin, /setallvw, /setallscore, /giveallscore, /banip.", "Close","");
    return 1;
}
CMD:gethealth(playerid, params[])
{
    new tname[MAX_PLAYER_NAME], string[128], targetid, Float:phealth;
    GetPlayerName(targetid, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Usage: /gethealth <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player.");
    GetPlayerHealth(targetid, phealth);
    format(string, sizeof(string), "[SERVER]: %s's health is %d.", tname, phealth );
    SendClientMessage(playerid, CLIME, string);
    return 1;
}
CMD:getarmour(playerid, params[])
{
    new tname[MAX_PLAYER_NAME], string[128], targetid, Float:armour;
    GetPlayerName(targetid, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Usage: /getarmour <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player.");
    GetPlayerArmour(targetid, armour);
    format(string, sizeof(string), "[SERVER]: %s's armour is %d.", tname, armour);
    SendClientMessage(playerid, CLIME, string);
    return 1;
}
CMD:warn(playerid, params[])
{
    new targetid, pname[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], reason[64], mfp[128], mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid, reason)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /warn <ID> <Reason>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    PlayerInfo[playerid][pWarns]++;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s warned %s for ' %s'! ", pname, targetname, reason);
    SendClientMessageToAll(CRED, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've warned %s for ' %s '!", targetname, reason);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:sethealth(playerid, params[])
{
    new Float:hamount, targetid, pname[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], mfp[128], mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, hamount)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /sethealth <ID> <Amount>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 > hamount > MAX_HEALTH) return SendClientMessage(playerid, CRED, "[SERVER]: Health amount must be between 0 & 99!");
    SetPlayerHealth(targetid, hamount);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your health to %d!", pname, hamount);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's health to %d!", targetname, hamount);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:setarmour(playerid, params[])
{
    new Float:aamount, targetid, pname[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], mfp[128], mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, aamount)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setarmour <ID> <Amount>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 > aamount > MAX_ARMOUR) return SendClientMessage(playerid, CRED, "[SERVER]: Armour amount must be between 0 & 100!");
    SetPlayerArmour(targetid, aamount);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your armour to %d!", pname, aamount);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's armour to %d!", targetname, aamount);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:akill(playerid, params[])
{
    new targetid, pname[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], mfp[128], mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /akill <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetPlayerHealth(targetid, 0);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s executed you!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've executed %s!", targetname);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:freeze(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /freeze <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    TogglePlayerControllable(targetid, 0);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s freezed you!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've freezed %s!", targetname);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:unfreeze(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /freeze <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    TogglePlayerControllable(targetid, 1);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s unfreezed you!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've unfreezed %s!", targetname);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:goto(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    new Float:x;
    new Float:y;
    new Float:z;
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /goto <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    GetPlayerPos(targetid, x, y, z);
    SetPlayerPos(playerid, x, y, z);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s teleported to you!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've teleported to %s!", targetname);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:get(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    new Float:x;
    new Float:y;
    new Float:z;
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /get <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(targetid, x, y, z);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s teleported you to his position!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've teleported %s to your position!", targetname);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:aslap(playerid, params[])
{
    new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], targetid, Float:x, Float:y, Float:z;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Usage: /aslap <ID>.");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player id.");
    PlayerPlaySound(targetid, 1190, 0.0, 0.0, 0.0);
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(targetid, x, y, z+6);
    format(string, sizeof(string), "[ADMIN]: Admin %s slapped you.", pname);
    SendClientMessage(targetid, CRED, string);
    format(string, sizeof(string), "[ADMIN]: You successfully slapped %s.", tname);
    SendClientMessage(playerid, CLIME, string);
    return 1;
}
CMD:disarm(playerid, params[])
{
    new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], targetid;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Usage: /disarm <ID>.");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player id.");
    ResetPlayerWeapons(targetid);
    format(string, sizeof(string), "[ADMIN]: Admin %s disarmed you.", pname);
    SendClientMessage(targetid, CRED, string);
    format(string, sizeof(string), "[ADMIN]: You successfully disarmed %s.", tname);
    SendClientMessage(playerid, CLIME, string);
    return 1;
}
CMD:explode(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    new Float:x;
    new Float:y;
    new Float:z;
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /explode <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    GetPlayerPos(targetid, x, y, z);
    CreateExplosion(x, y, z, 1, 1);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s exploded you!", pname);
    SendClientMessage(targetid, CRED, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've exploded %s!", targetname);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:write(playerid, params[])
{
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", string)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /write <Text>");
    SendClientMessageToAll(CYELLOW, string);
    return 1;
}
CMD:spec(playerid, params[])
{
    new targetid;
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /spec <ID>");
    TogglePlayerSpectating(playerid, 1);
    PlayerSpectatePlayer(playerid, targetid);
    return 1;
}
CMD:specoff(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    TogglePlayerSpectating(playerid, 0);
    return 1;
}

// -------------------- { Admin level 2: } ---------------------------- //

CMD:mute(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new tname[MAX_PLAYER_NAME];
    new string[128]; 
    new targetid;
    new reason[28];
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid, reason)) SendClientMessage(playerid, CRED, "[SERVER]: Usage: /mute <ID> <Reason>.");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player id.");
    PlayerInfo[playerid][pMuted] = 1;
    format(string, sizeof(string), "[SERVER]: Admin %s muted  %s for ' %s '!", pname, tname, reason);
    SendClientMessageToAll(CRED, string);
    format(string, sizeof(string), "[SERVER]: You muted %s for ' %s '!", tname, reason);
    SendClientMessage(playerid, CGREEN, string);
    return 1;
}
CMD:unmute(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new tname[MAX_PLAYER_NAME];
    new string[128];
    new targetid;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid)) SendClientMessage(playerid, CRED, "[SERVER]: Usage: /unmute <ID>.");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Invalid player id.");
    PlayerInfo[playerid][pMuted] = 0;
    format(string, sizeof(string), "[SERVER]: Admin %s unmuted  %s.", pname, tname);
    SendClientMessageToAll(CRED, string);
    format(string, sizeof(string), "[SERVER]: You unmuted %s for ' %s '!", tname);
    SendClientMessage(playerid, CGREEN, string);
    return 1;
}
CMD:kick(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new reason[128];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid, reason)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /kick <ID> <Reason>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetTimerEx("DelayedKick", 1000, false, "i", targetid);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s banned %s for ' %s '.", pname, targetname, reason);
    SendClientMessageToAll(CRED, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've kicked %s for ' %s '!", targetname, reason);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:ban(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new reason[128];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid, reason)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /ban <ID> <Reason>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetTimerEx("DelayedBan", 1000, false, "i", targetid);
    PlayerInfo[targetid][pBanned] = 1;
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s banned %s for ' %s '.", pname, targetname, reason);
    SendClientMessageToAll(CRED, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've banned %s for ' %s '!", targetname, reason);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:setskin(playerid, params[])
{
    new skinid;
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, skinid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setskin <ID> <Skin ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 > skinid > 311) return SendClientMessage(playerid, CRED, "[SERVER]: Skin ID must be between 0 & 311!");
    SetPlayerSkin(targetid, skinid);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your skin to %d!", pname, skinid);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's skin to %d!", targetname, skinid);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:setvw(playerid, params[])
{
    new vw;
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, vw)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setvw <ID> <Virtual World ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetPlayerVirtualWorld(targetid, vw);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your virtual world to %d!", pname, vw);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's virtual world to %d!", targetname, vw);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:agivecash(playerid, params[])
{
    new cash;
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, cash)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /agivecash <ID> <Amount>' ");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    GivePlayerMoney(targetid, cash);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s gave you $%d!", pname, cash);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've given %s  $%d!", targetname, cash);
    SendClientMessage(playerid, CLIGHTBLUE, mfa);
    return 1;
}
CMD:healall(playerid, params[])
{
    new Float:health;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", health)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /healall <Amount>' ");
    if(0 > health > MAX_HEALTH) return SendClientMessage(playerid, CRED, "[SERVER]: Health must be between 0 & 99.");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s changed everyone's health to %s!", pname, health);
    SetAllHealth(health);
    return 1;
}
CMD:armourall(playerid, params[])
{
    new Float:armour;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", armour)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /armourall <Amount>' ");
    if(0 > armour > MAX_ARMOUR) return SendClientMessage(playerid, CRED, "[SERVER]: Armour must be between 0 & 99.");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s changed everyone's armour to %s!", pname, armour);
    SetAllArmour(armour);
    return 1;
}
CMD:agiveallcash(playerid, params[])
{
    new money;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", money)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /agiveallcash <Amount>' ");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s gave everyone $%s!", pname, money);
    GiveAllMoney(money);
    return 1;
}
CMD:aspawnall(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s spawned everyone!", pname );
    SpawnAll();
    return 1;
}
//--------------- { Admin level 3: } ---------------------------- //


CMD:skick(playerid, params[])
{
    new targetid;
    new targetname[MAX_PLAYER_NAME];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /skick <ID> '");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetTimerEx("DelayedKick", 1000, false, "i", targetid);
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfa, sizeof(mfa), "[SERVER]: You've kicked %s!", targetname);
    SendClientMessage(playerid, CBLUE, mfa);
    return 1;
}
CMD:sban(playerid, params[])
{
    new targetid;
    new targetname[MAX_PLAYER_NAME];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "us", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /ban <ID> '");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetTimerEx("DelayedBan", 1000, false, "i", targetid);
    PlayerInfo[targetid][pBanned] = 1;
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfa, sizeof(mfa), "[SERVER]: You've banned %s!", targetname);
    SendClientMessage(playerid, CBLUE, mfa);
    return 1;
}
CMD:setscore(playerid, params[])
{
    new score;
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, score)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setscore <ID> <Amount>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    SetPlayerScore(targetid, score);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: Admin %s set your score to %d!", pname, score);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfa, sizeof(mfa), "[SERVER]: You've set %s's score to %d!", targetname, score);
    SendClientMessage(playerid, CBLUE, mfa);
    return 1;
}
CMD:setallskin(playerid, params[])
{
    new skin;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", skin)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setallskin <ID>' ");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s changed everyone's skin!", pname);
    SendClientMessageToAll(CLIME, string);
    SetAllSkin(skin);
    return 1;
}
CMD:setallscore(playerid, params[])
{
    new score;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", score)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setallscore <score>' ");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s changed everyone's score to %d!", pname, score);
    SetAllScore(score);
    return 1;
}
CMD:setallvw(playerid, params[])
{
    new vw;
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "d", vw)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setallvw <score>' ");
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: Admin %s changed everyone's virtual world to %d!", pname, vw);
    SetAllVirtualWorld(vw);
    return 1;
}
CMD:banip(playerid, params[])
{
    new type[32], string[128];
    if(sscanf(params, "s[128]", type)) return SendClientMessage(playerid, CRED, "Usage: ' /banip [IP]'.");
    else
    {
        format(string, sizeof(string),"banip %s", type);
        SendRconCommand(string);
        SendRconCommand("reloadbans");
    }
    return true;
}
// -------------------- { V.I.P Level 1: } ---------------------------- //

CMD:vcmds(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] == 0) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    ShowPlayerDialog(playerid, DVCmds, DIALOG_STYLE_MSGBOX, "Server V.I.P Commands:", "- V.I.P Level 1: /bhealth, /barmour, /vwpack (Changes at every level!)\n- V.I.P Level 2: /vipshop\n- V.I.P Level 3: /vget, /vcolor, /vskins", "Close","");
    return 1;
}
CMD:bhealth(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $2,000 to heal yourself!");
    GivePlayerMoney(playerid, -2000);
    SetPlayerHealth(playerid, MAX_HEALTH);
    format(string, sizeof(string), "[SERVER]: %s has bought a Health pack from V.I.P Shop!", pname);
    SendClientMessageToAll(CGREEN, string);
    return 1;
}
CMD:barmour(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $3,000 to heal yourself!");
    GivePlayerMoney(playerid, -3000);
    SetPlayerArmour(playerid, MAX_ARMOUR);
    format(string, sizeof(string), "[SERVER]: %s has bought a Armour vest from V.I.P Shop!", pname);
    SendClientMessageToAll(CGREEN, string);
    return 1;
}

// -------------------- { V.I.P Level 2: } ---------------------------- //

CMD:vgoto(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfv[128];
    new Float:x;
    new Float:y;
    new Float:z;
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /vgoto <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    GetPlayerPos(targetid, x, y, z);
    SetPlayerPos(playerid, x, y, z);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: V.I.P %s teleported to you!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfv, sizeof(mfv), "[SERVER]: You've teleported to %s!", targetname);
    SendClientMessage(playerid, CBLUE, mfv);
    return 1;
}
CMD:vipbuy(playerid, params[])
{
    new item[32];
    if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    SendClientMessage(playerid, CGREY, "[SERVER]: Items: ' weed, cocaine, meth, taco, soda and pizza '.");
    if(sscanf(params,"s[32]", item)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /vipshop <item> '!");
    if(strcmp(item, "cocaine", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $10,000 to buy this item!");
        PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]+5;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought 5 grams of cocaine from V.I.P Shop.");
        GivePlayerMoney(playerid, -10000);   
    }
    if(strcmp(item, "weed", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $5,000 to buy this item!");
        PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]+5;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought 5 grams of weed from V.I.P Shop.");
        GivePlayerMoney(playerid, -5000);
    
    }
    if(strcmp(item, "meth", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 15000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $15,000 to buy this item!");
        PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]+5;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought 5 grams of meth from V.I.P Shop.");
        GivePlayerMoney(playerid, -15000);
    
    }
    if(strcmp(item, "taco", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $2,000 to buy this item!");
        PlayerInfo[playerid][pTaco] = PlayerInfo[playerid][pTaco]+1;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought a taco from V.I.P Shop.");
        GivePlayerMoney(playerid, -2000);
    
    }
    if(strcmp(item, "pizza", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $5,000 to buy this item!");
        PlayerInfo[playerid][pPizza] = PlayerInfo[playerid][pPizza]+1;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought a slice of pizza from V.I.P Shop.");
        GivePlayerMoney(playerid, -5000);
    
    }
    if(strcmp(item, "soda", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $1,000 to buy this item!");
        PlayerInfo[playerid][pSoda] = PlayerInfo[playerid][pSoda]+1;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought a soda cup from V.I.P Shop.");
        GivePlayerMoney(playerid, -1000);
    
    }
    if(strcmp(item, "materials", true) == 0)
    {
        if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $10,000 to buy this item!");
        PlayerInfo[playerid][pMaterials] = PlayerInfo[playerid][pMaterials]+5000;
        SendClientMessage(playerid, CLIME, "[SERVER]: You bought a package of materials from V.I.P Shop.");
        GivePlayerMoney(playerid, -10000);
    
    }
    return 1;
}

// -------------------- { V.I.P Level 3: } ---------------------------- //

CMD:vget(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfv[128];
    new Float:x;
    new Float:y;
    new Float:z;
    if(PlayerInfo[playerid][pVip] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /vget <ID>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(targetid, x, y, z);
    GetPlayerName(playerid, pname, sizeof(pname));
    GetPlayerName(targetid, targetname, sizeof(targetname));
    format(mfp, sizeof(mfp), "[SERVER]: V.I.P %s teleported you to his position!", pname);
    SendClientMessage(targetid, CGREEN, mfp);
    format(mfv, sizeof(mfv), "[SERVER]: You've teleported %s to your position!", targetname);
    SendClientMessage(playerid, CBLUE, mfv);
    return 1;
}
CMD:vskin(playerid, params[])
{
    new skinid;
    if(PlayerInfo[playerid][pVip] < 3) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(sscanf(params, "d", skinid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /vskin <ID> '");
    if(0 > skinid > 311) return SendClientMessage(playerid, CRED, "[SERVER]: Skin ID must be between 0 & 311!");
    SetPlayerSkin(playerid, skinid);
    return 1;
}
CMD:vwpack(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] == 1) 
    {
        GivePlayerWeapon(playerid, WEAPON_COLT45, 500);
        GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 100);
        GivePlayerWeapon(playerid, WEAPON_TEC9, 500);
        return 1;
    }
    if(PlayerInfo[playerid][pVip] == 2)
    {
        GivePlayerWeapon(playerid, WEAPON_DEAGLE, 300);
        GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 200);
        GivePlayerWeapon(playerid, WEAPON_MP5, 500);
        GivePlayerWeapon(playerid, WEAPON_AK47, 500);
        GivePlayerWeapon(playerid, WEAPON_RIFLE, 100);
        return 1;
    }
    if(PlayerInfo[playerid][pVip] == 3)
    {
        GivePlayerWeapon(playerid, WEAPON_DEAGLE, 10000);
        GivePlayerWeapon(playerid, WEAPON_SHOTGSPA, 10000);
        GivePlayerWeapon(playerid, WEAPON_UZI, 10000);
        GivePlayerWeapon(playerid, WEAPON_M4, 10000);
        GivePlayerWeapon(playerid, WEAPON_SNIPER, 10000);
    }
    return 1;
}
forward CbugTimer(playerid);
public CbugTimer(playerid)
{
        TogglePlayerControllable(playerid, 1);
        return 1;
}
forward RandomMessage();
public RandomMessage()
{
        TextDrawSetString(rmsg, RandomMessages[random(sizeof(RandomMessages))]); 
        return 1;
}
forward DelayedKick(playerid);
public DelayedKick(playerid)
{
    Kick(playerid);
    return 1;
}
forward DelayedBan(playerid);
public DelayedBan(playerid)
{
    Ban(playerid);
    return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
     if(newkeys & KEY_FIRE && oldkeys & KEY_CROUCH && IsCbugWeapon(playerid))
     {
        SendClientMessage(playerid, CRED, "[SERVER]: C-bug is not allowed here!");
        SetTimer("CbugTimer", 20000, false);
     }
     return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == Weaponshop)
    {
        ShowPlayerDialog(playerid, DWshop, DIALOG_STYLE_LIST, "Ammu-nation:", "- 9mm [$300] [100 ammo]\n- Silenced 9mm [$500] [100 ammo]\n- Desert Eagle [$1,000] [100 ammo]\n- Pump shotgun [$1,500] [100 ammo]\n- Sawn off [$2,000] [50 ammo]\n- Combat Shotgun [$3,000] [50 ammo]\n- Tec9 [$500] [500 ammo]\n- Micro SMG [$800] [500 ammo]\n- SMG [$1,000] [300 ammo]\n- AK47 [$3,000] [200 ammo]\n- M4 [$5,000] [200 ammo]\n- County rifle [$2,000] [100 ammo]\n- Sniper rifle [$8,000] [100 ammo]", "Select","Close");
    }
    if(pickupid == DrugBoyZ)
    {
        ShowPlayerDialog(playerid, DDshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$5,000] per 5 grams.\n- Cocaine [$10,000] per 5 grams.\n- Meth [$15,000] per 5 grams.", "Select","Close");
    }
    if(pickupid  == ClothesShop)
    {
        ShowModelSelectionMenu(playerid, cskins, "Select a Skin");
    }
    if(pickupid == Weaponshop2)
    {
        ShowPlayerDialog(playerid, DWshop, DIALOG_STYLE_LIST, "Ammu-nation:", "- 9mm [$300] [100 ammo]\n- Silenced 9mm [$500] [100 ammo]\n- Desert Eagle [$1,000] [100 ammo]\n- Pump shotgun [$1,500] [100 ammo]\n- Sawn off [$2,000] [50 ammo]\n- Combat Shotgun [$3,000] [50 ammo]\n- Tec9 [$500] [500 ammo]\n- Micro SMG [$800] [500 ammo]\n- SMG [$1,000] [300 ammo]\n- AK47 [$3,000] [200 ammo]\n- M4 [$5,000] [200 ammo]\n- County rifle [$2,000] [100 ammo]\n- Sniper rifle [$8,000] [100 ammo]", "Select","Close");
    }
    if(pickupid == DrugDepot)
    {
        ShowPlayerDialog(playerid, DDshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$5,000] per 5 grams.\n- Cocaine [$10,000] per 5 grams.\n- Meth [$15,000] per 5 grams.", "Select","Close");
    }
    if(pickupid  == ClothesShop2)
    {
        ShowModelSelectionMenu(playerid, cskins, "Select a Skin");
    }
    if(pickupid == DrugDen)
    {
        ShowPlayerDialog(playerid, DDshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$5,000] per 5 grams.\n- Cocaine [$10,000] per 5 grams.\n- Meth [$15,000] per 5 grams.", "Select","Close");
    }
    if(pickupid  == ClothesShop3)
    {
        ShowModelSelectionMenu(playerid, cskins, "Select a Skin");
    }
    return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
    DisablePlayerCheckpoint(playerid);
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount)
{
    if(issuerid != INVALID_PLAYER_ID )
    {
        SetPlayerHealth(playerid, 0);
    }
    return 1;
}
public OnPlayerUpdate(playerid)
{
    if(PlayerInfo[playerid][pWarns]>= MAX_WARNINGS) 
    {
        new pname[MAX_PLAYER_NAME], string[128], targetid, Float:animX, Float:animY, Float:animZ;
        GetPlayerName(playerid, pname, sizeof(pname));
        format(string, sizeof(string), "[SERVER]: %s has been kicked from the server for being warned too much!", pname);
        SendClientMessageToAll(CRED, string);
        PlayerInfo[playerid][pWarns] = 0;
        SetTimerEx("DelayedKick", 1000, false, "i", targetid);
        // ----- { Anti-Airbreak } ----- //
        new anim = GetPlayerAnimationIndex(playerid);
        GetPlayerPos(playerid, animX, animY, animZ);
        if((anim >= 1538) && (anim <= 1542) && animZ > 5)
        {
           TogglePlayerControllable(playerid, false);
           SendClientMessage(playerid, CRED, "[SERVER]: You got kicked from the server for 'Airbreak'.");
           SetTimer("DelayedKick", 1000, false);
        }
        // ----- { Anti-Vehicle Speed Hack } ----- //
        if(IsPlayerInAnyVehicle(playerid))
        {
            new Float:Speed[3],Round_Speed;
            GetVehicleVelocity(GetPlayerVehicleID(playerid), Speed[0], Speed[1], Speed[2]);
            Round_Speed = floatround(floatsqroot(Speed[0] * Speed[0] + Speed[1] * Speed[1] + Speed[2] * Speed[2]) * 170.00);
            if(Round_Speed > MAX_VEHICLE_SPEED)
            {
                TogglePlayerControllable(playerid, false);
                SendClientMessage(playerid, CRED, "[SERVER]: You got kicked from the server for 'Vehicle Speed Hack'.");
                SetTimer("DelayedKick", 1000, false);
                
            }
        }
        // ----- { Anti-Health Hack } ----- //
        new Float:health, Float:armour;
        GetPlayerHealth(playerid, health);
        GetPlayerArmour(playerid, armour);
        if(health > MAX_HEALTH)
        {
            TogglePlayerControllable(playerid, false);
            SendClientMessage(playerid, CRED, "[SERVER]: You got kicked from the server for 'Health Hack'.");
            SetTimer("DelayedKick", 1000, false);
        }
        // ----- { Anti-Armour Hack } ----- //
        if(armour > MAX_ARMOUR)
        {
            TogglePlayerControllable(playerid, false);
            SendClientMessage(playerid, CRED, "[SERVER]: You got kicked from the server for 'Armour Hack'.");
            SetTimer("DelayedKick", 1000, false);
        }
        if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
        {        
            TogglePlayerControllable(playerid, false);
            SendClientMessage(playerid, CRED, "[SERVER]: You got kicked from the server for 'Jetpack Hack'.");
            SetTimer("DelayedKick", 1000, false);
        }
    }
	return 1;
}
public OnPlayerModelSelection(playerid, response, listid, modelid)
{

    if(listid == cskins)
    {
        if(response)
        {
            SendClientMessage(playerid, CGREEN, "[SERVER]: You successfully changed your skin!");
            SetPlayerSkin(playerid, modelid);
        }
        else SendClientMessage(playerid, CRED, "[SERVER]: You successfully canceled Skin Selection.");
        return 1;
    }
    if(listid == cskins)
    {
        if(response)
        {
            if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money!");
            SendClientMessage(playerid, CGREEN, "[SERVER]: You successfully changed your skin and paid $5,000!");
            GivePlayerMoney(playerid, -5000);
            SetPlayerSkin(playerid, modelid);
        }
        else SendClientMessage(playerid, CRED, "[SERVER]: You successfully canceled Skin Selection.");
        return 1;
    }
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {
        case DRegister:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DRegister, DIALOG_STYLE_INPUT, ""DCWhite"Create an account:",""DCRed"You have entered an invalid password.\n"DCWhite"Please type your password below to register a new account.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password:",udb_hash(inputtext));
                INI_WriteInt(File,"Cash:",0);
                INI_WriteInt(File,"Admin:",0);
                INI_WriteInt(File,"Kills:",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"V.I.P:",0);
                INI_WriteInt(File,"Interior:",0);
                INI_WriteInt(File,"Virtual World:",0);
                INI_WriteInt(File,"Warns:",0);
                INI_WriteInt(File,"Skin:",1);
                INI_WriteInt(File,"Score:",0);
                INI_WriteInt(File,"Weed:", 0);
                INI_WriteInt(File,"Cocaine:", 0);
                INI_WriteInt(File,"Meth:", 0);
                INI_WriteInt(File,"Taco:", 0);
                INI_WriteInt(File,"Pizza:", 0);
                INI_WriteInt(File,"Soda:", 0);
                INI_WriteInt(File,"Banned:", 0);
                INI_WriteInt(File,"Drugged:", 0);
                INI_WriteInt(File,"Materials:", 0);

                INI_Close(File);

                SetSpawnInfo(playerid, 0, 1, 2507.9558,-1670.9633,13.3790, 90, 24, 100, 0, 0, 0, 0);
                SpawnPlayer(playerid);
                ShowPlayerDialog(playerid, DRegister2, DIALOG_STYLE_MSGBOX,""DCWhite"Success!",""DCWhite"You successfully created an account!","Okay","");
			}
        }

        case DLogin:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
					ShowPlayerDialog(playerid, DLogin2, DIALOG_STYLE_MSGBOX,""DCWhite"Success!",""DCGreen"You have successfully logged in!","Okay","");
                }
                else
                {
                    ShowPlayerDialog(playerid, DLogin, DIALOG_STYLE_INPUT,""DCWhite"Login:",""DCRed"You have entered an incorrect password.\n"DCWhite"Please type your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
        case DWshop:
        {
            if(response)
            {

                switch(listitem)
                {
                   case 0: {

                    if(GetPlayerMoney(playerid) < 300) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -300);
                    GivePlayerWeapon(playerid, WEAPON_COLT45, 100);
                   }
                   case 1: {

                    if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -500);
                    GivePlayerWeapon(playerid, WEAPON_SILENCED, 100);
                   }
                   case 2: {

                    if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -1000);
                    GivePlayerWeapon(playerid, WEAPON_DEAGLE, 100);
                   }
                   case 3: {

                    if(GetPlayerMoney(playerid) < 1500) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -1500);
                    GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 100);
                   }
                   case 4: {

                    if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -2000);
                    GivePlayerWeapon(playerid, WEAPON_SAWEDOFF, 50);
                   }
                   case 5: {

                    if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -3000);
                    GivePlayerWeapon(playerid, WEAPON_SHOTGSPA, 50);
                   }
                    case 6: {

                    if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -500);
                    GivePlayerWeapon(playerid, WEAPON_TEC9, 500);
                   }
                    case 7: {

                    if(GetPlayerMoney(playerid) < 800) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -800);
                    GivePlayerWeapon(playerid, WEAPON_UZI, 800);
                   }
                    case 8: {

                    if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -1000);
                    GivePlayerWeapon(playerid, WEAPON_MP5, 300);
                   }
                    case 9: {

                    if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -3000);
                    GivePlayerWeapon(playerid, WEAPON_AK47, 200);
                   }
                    case 10: {

                    if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -5000);
                    GivePlayerWeapon(playerid, WEAPON_M4, 200);
                   }
                    case 11: {

                    if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -2000);
                    GivePlayerWeapon(playerid, WEAPON_RIFLE, 100);
                   }
                    case 12: {

                    if(GetPlayerMoney(playerid) < 8000) return SendClientMessage(playerid, CRED, "[SERVER]: You don't have enough money to buy this weapon");
                    GivePlayerMoney(playerid, -8000);
                    GivePlayerWeapon(playerid, WEAPON_SNIPER, 100);
                   }


                }
                return 1;

            }
        }
        case DDshop:
        {
            if(response)
            {

                switch(listitem)
                {

                    case 0: {

                    if(GetPlayerMoney(playerid < 5000)) return SendClientMessage(playerid, CRED, "[SERVER]: You need more money to buy 5 grams of weed.");
                    GivePlayerMoney(playerid, -5000);
                    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought 5 grams of weed!");
                    PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]+5;
                   }
                    case 1: {

                    if(GetPlayerMoney(playerid < 10000)) return SendClientMessage(playerid, CRED, "[SERVER]: You need more money to buy 5 grams of cocaine.");
                    GivePlayerMoney(playerid, -10000);
                    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought 5 grams of cocaine!");
                    PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]+5;
                   }
                    case 2: {

                    if(GetPlayerMoney(playerid < 15000)) return SendClientMessage(playerid, CRED, "[SERVER]: You need more money to buy 5 grams of meth.");
                    GivePlayerMoney(playerid, -15000);
                    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought 5 grams of meth!");
                    PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]+5;
                   }

                }
                return 1;
            }
        }
        case DGPS:
        {
            if(response)
            {

                switch(listitem)
                {

                    case 0: {
                    SetPlayerCheckpoint(playerid,1365.4104,-1280.0146,13.5469, 3.0);
                   }
                    case 1: {
                    SetPlayerCheckpoint(playerid,2400.5239,-1981.5889,13.5469, 3.0);
                   }
                    case 2: {
                    SetPlayerCheckpoint(playerid,2351.2463,-1169.8097,28.0331, 3.0);
                   }
                    case 3: {
                    SetPlayerCheckpoint(playerid,2166.2820,-1671.3414,15.0736, 3.0);
                   }
                    case 4: {
                    SetPlayerCheckpoint(playerid,1919.9303,-1863.7692,13.5608, 3.0);
                   }
                    case 5: {
                    SetPlayerCheckpoint(playerid,2245.0327,-1663.6989,15.4766, 3.0);
                   }
                   case 6: {
                    SetPlayerCheckpoint(playerid,1498.5842,-1582.4598,13.5469, 3.0);
                   }
                    case 7: {
                    SetPlayerCheckpoint(playerid,2045.2283,-1913.0979,13.5469, 3.0);
                   }

                }
                return 1;
            }
        }
    
    }
    return 1;
}

// -------------------- { Stocks: } ---------------------------- //


stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}
stock SpawnAll()
{
        foreach(new i : Player) SpawnPlayer( i );
        return true;
}

stock SpawnAllVehicles()
{
        for ( new v = 0; v < MAX_VEHICLES; v ++) SetVehicleToRespawn( v );
        return true;
}
stock GetAll(Float:x, Float:y, Float:z)
{
       foreach(new i : Player) SetPlayerPos( i, Float:x, Float:y, Float:z );
        return true;
}
stock SetAllColor(color)
{
        foreach(new i : Player) SetPlayerColor( i, color );
        return true;
}
stock SetAllSkin(skinid)
{
        foreach(new i : Player) SetPlayerSkin( i, skinid );
        return true;
}
stock SetAllVirtualWorld(virtualworld)
{
        foreach(new i : Player) SetPlayerVirtualWorld( i, virtualworld );
        return true;
}

stock GiveAllMoney(money)
{
        foreach(new i : Player)  GivePlayerMoney( i, money );
        return true;
}

stock GiveAllWeapon(weaponid, ammo)
{
        foreach(new i : Player) GivePlayerWeapon( i, weaponid, ammo );
        return true;
}
stock SetAllScore(score)
{
        foreach(new i : Player) SetPlayerScore( i, score );
        return true;
}
stock SetAllArmour(Float:armor)
{
        foreach(new i : Player) SetPlayerArmour( i, Float: armor);
        return true;
}  
stock SetAllHealth(Float:health)
{
        foreach(new i : Player) SetPlayerHealth( i, Float: health);
        return true;
}
stock GiveHealth(playerid,Float:Health)
{
        new Float:health; GetPlayerHealth(playerid,health);
        SetPlayerHealth(playerid,health+Health);
}
stock IsCbugWeapon(playerid)
{
    if(GetPlayerWeapon(playerid) == 22 || GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 25 || GetPlayerWeapon(playerid) == 27)
    {
        return 1;
    }
    return 0;
}
stock ChatLog(playerid, text[])
{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    new
     File:lFile = fopen("Logs/Chat.txt", io_append),
     logData[178],
        fyear, fmonth, fday,
        fhour, fminute, fsecond;
        
    getdate(fyear, fmonth, fday);
    gettime(fhour, fminute, fsecond);
    
    format(logData, sizeof(logData),"[%02d/%02d/%04d %02d:%02d:%02d] %s: %s \r\n", fday, fmonth, fyear, fhour, fminute, fsecond, pname, text);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}
stock LoadStaticVehiclesFromFile(const filename[])
{
    new File:file_ptr;
    new line[256];
    new var_from_line[64];
    new vehicletype;
    new Float:vSpawnX;
    new Float:vSpawnY;
    new Float:vSpawnZ;
    new Float:SpawnRot;
    new Color1, Color2;
    new index;
    new vehicles_loaded;

    file_ptr = fopen(filename,filemode:io_read);
    if(!file_ptr) return 0;

    vehicles_loaded = 0;

    while(fread(file_ptr,line,256) > 0)
    {
          index = 0;

        
          index = token_by_delim(line,var_from_line,',',index);
          if(index == (-1)) continue;
          vehicletype = strval(var_from_line);
          if(vehicletype < 400 || vehicletype > 611) continue;

         
          index = token_by_delim(line,var_from_line,',',index+1);
          if(index == (-1)) continue;
          vSpawnX = floatstr(var_from_line);

          index = token_by_delim(line,var_from_line,',',index+1);
          if(index == (-1)) continue;
          vSpawnY = floatstr(var_from_line);

          index = token_by_delim(line,var_from_line,',',index+1);
          if(index == (-1)) continue;
          vSpawnZ = floatstr(var_from_line);

          index = token_by_delim(line,var_from_line,',',index+1);
          if(index == (-1)) continue;
          SpawnRot = floatstr(var_from_line);

          
          index = token_by_delim(line,var_from_line,',',index+1);
          if(index == (-1)) continue;
          Color1 = strval(var_from_line);

          index = token_by_delim(line,var_from_line,';',index+1);
          Color2 = strval(var_from_line);

          AddStaticVehicleEx(vehicletype,vSpawnX,vSpawnY,vSpawnZ,SpawnRot,Color1,Color2,180); // respawn 3 minutes
          vehicles_loaded++;
    }

    fclose(file_ptr);
    printf("Loaded %d vehicles from: %s",vehicles_loaded,filename);
    return vehicles_loaded;
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
    new x=0;
    while(string[start_index] != EOS && string[start_index] != delim) {
        return_str[x] = string[start_index];
        x++;
        start_index++;
    }
    return_str[x] = EOS;
    if(string[start_index] == EOS) start_index = (-1);
    return start_index;
} 