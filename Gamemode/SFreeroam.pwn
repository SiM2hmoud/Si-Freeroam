// --------------------------------------------------------------- //
//                        Si Freeroam                              //
//                     Developer: SiM2hmoud                        //
//                        Version: 1.0  (Alpha)                    //
// --------------------------------------------------------------- //
// -------------------- { Changelog: } ---------------------------- //
// - Nothing... 
// --------------------------------------------------------------- //

// -------------------- { Includes: } ---------------------------- //

#include <a_samp>
#include <YSI\y_ini>
#include <sscanf2>
#include <zcmd>
#include <foreach>
#include <mSelection>

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
#define DRules 1
#define DHelp 2
#define DCmds 3
#define DCredits 4
#define DWebsite 5
#define DUpdates 6
#define DACmds 7
#define DVCmds 8
#define DWshop 9
#define DDshop 10

// -------------------- { Variables: } ---------------------------- //

new IsSpawned;
new PM[MAX_PLAYER_NAME];
new Weaponshop; // Ammu-nation.
new DrugFellas; // Drug Fellas.
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
    "~y~Si Freeroam: ~w~Found a ~r~Cheater~w~? Contact a Staff member."

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
    pDL,
    pPL,
    pMuted

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
    INI_Int("Driving License:",PlayerInfo[playerid][pDL]);
    INI_Int("Pilot License:",PlayerInfo[playerid][pPL]);
    INI_Int("Muted:",PlayerInfo[playerid][pMuted]);



    return 1;
}

// -------------------- { Gamemode: } ---------------------------- //

main()
{
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
    AddPlayerClass(0, 2507.9558,-1670.9633,13.3790, 0, 0, 0, 0, 0, 0, 0);
    Weaponshop = CreatePickup(1242, 1, 1365.4104,-1280.0146,13.5469, 0); // Ammu-nation pickup.
    Weaponshop2 = CreatePickup(1242, 1, 2400.5239,-1981.5889,13.5469, 0); // Ammu-nation pickup.
    DrugFellas = CreatePickup(1279, 1,2351.2463,-1169.8097,28.0331, 0); // DrugFellas pickup.
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
    AddStaticVehicle(534,2453.3999000,-1662.4000000,13.1000000,90.0000000,156,161);
    AddStaticVehicle(534,2443.3999000,-1662.4000000,13.1000000,90.0000000,156,161);
    AddStaticVehicle(534,2427.8999000,-1662.3000000,13.2000000,90.0000000,156,161);
    AddStaticVehicle(534,2435.6001000,-1662.4000000,13.2000000,90.0000000,156,161);
    AddStaticVehicle(576,2406.2000000,-1655.5000000,13.1000000,90.0000000,153,78);
    AddStaticVehicle(576,2398.7000000,-1655.3000000,13.1000000,90.0000000,153,78);
    AddStaticVehicle(576,2391.5000000,-1655.3000000,13.1000000,90.0000000,153,78);
    AddStaticVehicle(576,2412.8000000,-1655.6000000,13.1000000,90.0000000,153,78);
    AddStaticVehicle(426,2291.8999000,-1680.1000000,13.9000000,0.0000000,124,28);
    AddStaticVehicle(412,2303.3999000,-1637.7000000,14.5000000,0.0000000,66,31);
    AddStaticVehicle(401,2186.6001000,-1668.4000000,14.4000000,0.0000000,57,90);
    AddStaticVehicle(533,2181.6001000,-1700.9000000,13.3000000,0.0000000,30,46);
    AddStaticVehicle(534,2121.3000000,-1780.3000000,13.2000000,0.0000000,101,106);
    AddStaticVehicle(547,2116.7000000,-1780.3000000,13.2000000,0.0000000,70,89);
    AddStaticVehicle(448,2110.5000000,-1783.7000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2109.1001000,-1783.5000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2107.8000000,-1783.5000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2106.4004000,-1783.4004000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2105.2002000,-1783.5000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2103.7000000,-1783.5000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2102.2000000,-1783.6000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(448,2100.6001000,-1783.5000000,13.1000000,0.0000000,132,4);
    AddStaticVehicle(463,2069.3000000,-1919.7000000,13.2000000,0.0000000,101,106);
    AddStaticVehicle(486,2056.0000000,-1940.8000000,13.7000000,90.0000000,245,245);
    AddStaticVehicle(451,2065.5000000,-1919.7000000,13.3000000,0.0000000,27,55);
    AddStaticVehicle(603,2055.8000000,-1904.7000000,13.5000000,0.0000000,109,24);
    AddStaticVehicle(549,2131.5000000,-1908.7000000,13.2000000,0.0000000,88,88);
    AddStaticVehicle(549,2131.3999000,-1917.8000000,13.2000000,0.0000000,88,88);
    AddStaticVehicle(529,2077.0000000,-1698.5000000,13.1000000,0.0000000,101,106);
    AddStaticVehicle(466,2077.6001000,-1736.1000000,13.3000000,0.0000000,51,95);
    AddStaticVehicle(574,2186.9004000,-1991.4004000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2189.2998000,-1991.2002000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2184.7002000,-1986.2998000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2186.7000000,-1986.4000000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2189.2000000,-1986.5000000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2189.0000000,-1982.5000000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2186.6001000,-1982.1000000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2184.2002000,-1982.0000000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(574,2184.3999000,-1991.5000000,13.3000000,0.0000000,165,169);
    AddStaticVehicle(487,1961.1000000,-2341.1001000,13.8000000,0.0000000,151,149);
    AddStaticVehicle(487,1939.2000000,-2341.2000000,13.8000000,0.0000000,151,149);
    AddStaticVehicle(487,1950.5000000,-2371.2000000,13.8000000,0.0000000,151,149);
    AddStaticVehicle(488,1856.7000000,-2404.3999000,13.8000000,0.0000000,42,119);
    AddStaticVehicle(553,1977.5000000,-2631.2000000,15.8000000,0.0000000,77,132);
    AddStaticVehicle(553,1945.3000000,-2629.7000000,15.8000000,0.0000000,77,132);
    AddStaticVehicle(577,1894.3000000,-2492.1001000,12.5000000,90.0000000,34,25);
    AddStaticVehicle(420,1784.4000000,-1932.4000000,13.2000000,0.0000000,215,142);
    AddStaticVehicle(420,1789.2000000,-1932.0000000,13.2000000,0.0000000,215,142);
    AddStaticVehicle(420,1793.7000000,-1931.9000000,13.2000000,0.0000000,215,142);
    AddStaticVehicle(420,1798.3000000,-1932.0000000,13.2000000,0.0000000,215,142);
    AddStaticVehicle(420,1803.3000000,-1931.9000000,13.2000000,0.0000000,215,142);
    AddStaticVehicle(580,1778.5000000,-1891.4000000,13.3000000,0.0000000,95,10);
    AddStaticVehicle(458,1834.7000000,-1870.8000000,13.4000000,0.0000000,37,37);
    AddStaticVehicle(434,1844.2000000,-1871.3000000,13.5000000,0.0000000,215,142);
    AddStaticVehicle(416,2000.5000000,-1413.9000000,17.3000000,180.0000000,245,245);
    AddStaticVehicle(416,2004.2000000,-1455.9000000,13.9000000,90.0000000,245,245);
    AddStaticVehicle(416,2032.6000000,-1437.1000000,17.5000000,0.0000000,245,245);
    AddStaticVehicle(481,1887.2000000,-1399.0000000,13.2000000,0.0000000,214,218);
    AddStaticVehicle(481,1889.9004000,-1395.5000000,13.2000000,0.0000000,214,218);
    AddStaticVehicle(481,1891.9000000,-1392.0000000,13.2000000,0.0000000,214,218);
    AddStaticVehicle(481,1892.9004000,-1388.5000000,13.2000000,0.0000000,214,218);
    AddStaticVehicle(481,1895.2002000,-1383.7002000,13.2000000,0.0000000,214,218);
    AddStaticVehicle(481,1896.7000000,-1380.2000000,13.2000000,0.0000000,214,218);
    AddStaticVehicle(407,1748.9000000,-1455.4000000,13.9000000,270.0000000,132,4);
    AddStaticVehicle(596,1559.2998000,-1611.0996000,13.2000000,0.0000000,-1,-1);
    AddStaticVehicle(596,1562.7002000,-1611.0000000,13.2000000,0.0000000,-1,-1);
    AddStaticVehicle(596,1566.2000000,-1611.7000000,13.2000000,0.0000000,-1,-1);
    AddStaticVehicle(596,1569.9004000,-1611.9004000,13.2000000,0.0000000,-1,-1);
    AddStaticVehicle(596,1555.6000000,-1611.1000000,13.2000000,0.0000000,-1,-1);
    AddStaticVehicle(596,1552.1000000,-1611.1000000,13.2000000,0.0000000,-1,-1);
    AddStaticVehicle(601,1535.5000000,-1667.0000000,13.3000000,0.0000000,245,245);
    AddStaticVehicle(601,1535.0996000,-1675.2002000,13.3000000,0.0000000,245,245);
    AddStaticVehicle(416,1180.4000000,-1339.2000000,14.1000000,90.0000000,245,245);
    AddStaticVehicle(416,1178.3000000,-1309.7000000,14.1000000,90.0000000,245,245);
    AddStaticVehicle(402,1210.8000000,-1378.9000000,13.2000000,0.0000000,66,31);
    AddStaticVehicle(560,1693.7000000,-1612.1000000,13.2000000,0.0000000,115,46);
    AddStaticVehicle(439,1685.7000000,-1677.7000000,13.4000000,0.0000000,189,190);
    AddStaticVehicle(409,1790.0000000,-1811.0000000,13.5000000,90.0000000,245,245);
    CreateObject(1344,2482.1001000,-1650.2000000,13.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1299,2497.3000000,-1673.6000000,12.8000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1221,2498.8999000,-1676.5000000,12.8000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1220,2497.2000000,-1675.7000000,12.7000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1221,2496.2000000,-1677.6000000,12.8000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1221,2498.8000000,-1676.5000000,13.7000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1220,2496.1001000,-1677.6000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1221,2499.0000000,-1675.4000000,12.8000000,0.0000000,0.0000000,0.0000000);
    CreateObject(3594,2503.2000000,-1668.6000000,13.0000000,0.0000000,0.0000000,0.0000000);
    CreateObject(3593,2496.8999000,-1667.3000000,13.1000000,0.0000000,0.0000000,60.0000000);
    CreateObject(3221,2495.1001000,-1670.1000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(3350,2486.1001000,-1656.6000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(3533,2465.1001000,-1665.9000000,16.7000000,0.0000000,0.0000000,0.0000000);
    CreateObject(3533,2466.5000000,-1651.5000000,16.7000000,0.0000000,0.0000000,0.0000000);
    CreateObject(14537,2482.5000000,-1667.3000000,14.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1825,2474.7000000,-1659.9000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1825,2473.0000000,-1663.4000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1825,2473.1001000,-1667.0000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1825,2474.5000000,-1670.3000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1825,2476.3000000,-1674.3000000,12.3000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1364,2480.6001000,-1655.8000000,13.1000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1364,2474.6001000,-1655.6000000,13.1000000,0.0000000,0.0000000,0.0000000);
    CreateObject(851,2499.1001000,-1680.9000000,12.7000000,0.0000000,0.0000000,0.0000000);
    CreateObject(3035,2465.0000000,-1662.2000000,13.1000000,0.0000000,0.0000000,90.0000000);
    CreateObject(3035,2464.8000000,-1659.2000000,13.1000000,0.0000000,0.0000000,90.0000000);
    CreateObject(3035,2465.1001000,-1655.8000000,13.1000000,0.0000000,0.0000000,90.0000000);
    CreateObject(1347,2495.2000000,-1675.1000000,12.9000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1550,2487.0000000,-1666.6000000,13.9000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1550,2486.8999000,-1667.8000000,13.9000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1550,2487.8999000,-1667.8000000,13.9000000,0.0000000,0.0000000,0.0000000);
    CreateObject(2035,2487.0000000,-1664.0000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(2044,2487.0000000,-1663.5000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(2710,2484.8593800,-1664.8418000,12.5147500,0.0000000,0.0000000,0.0000000);
    CreateObject(2710,2484.8999000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(2710,2485.3000000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(2710,2485.7000000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1486,2484.5000000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1520,2486.0000000,-1671.9000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1517,2486.3000000,-1672.0000000,13.7000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1543,2486.5000000,-1672.0000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1544,2486.6001000,-1671.8000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1544,2486.7000000,-1672.0000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1546,2486.8999000,-1669.7000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1668,2487.0000000,-1671.1000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1667,2487.1001000,-1670.7000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1669,2486.7000000,-1669.9000000,13.6000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1748,2483.5000000,-1671.7000000,13.5000000,0.0000000,0.0000000,0.0000000);
    CreateObject(1720,2483.3000000,-1674.0000000,12.3000000,0.0000000,0.0000000,160.0000000);
    CreateObject(3819,2484.8999000,-1679.4000000,13.3000000,0.0000000,0.0000000,270.0000000);
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

    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: %s has left to the server.", pname);
    SendClientMessageToAll(CGREY, string);
    new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash:",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin:",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills:",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths:",PlayerInfo[playerid][pDeaths]);
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
    INI_WriteInt(File, "Driving License:",PlayerInfo[playerid][pDL]);
    INI_WriteInt(File, "Pilot License:",PlayerInfo[playerid][pPL]);
    INI_WriteInt(File, "Muted:",PlayerInfo[playerid][pMuted]);

    INI_Close(File);
    return 1;
}
public OnPlayerSpawn(playerid)
{
    IsSpawned = 1;
    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    TextDrawShowForPlayer(playerid, rmsg);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    new pname[MAX_PLAYER_NAME];
    new string[64];
    GetPlayerName(playerid, pname, sizeof(pname));
    GivePlayerMoney(playerid, -500);
    SendClientMessage(playerid, CRED, "[SERVER]: You died & you payed $500 to get your wounds fixed!");
    GivePlayerMoney(killerid, 1000);
    format(string, sizeof(string), "[SERVER]: You killed %s and earned $1,000!");
    SendClientMessage(killerid, CLIGHTBLUE, string);
    PlayerInfo[playerid][pKills]++;
    PlayerInfo[playerid][pDeaths]++;
    SendDeathMessage(killerid, playerid, reason);
    return 1;
}

public OnPlayerText(playerid, text[])
{
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
    if(newstate == PLAYER_STATE_DRIVER && PlayerInfo[playerid][pDL] == 0)
    {
        SendClientMessage(playerid, CRED, "[SERVER]: You need a driving license to drive a vehicle!");
        RemovePlayerFromVehicle(playerid);
    }
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
    ShowPlayerDialog(playerid, DCmds, DIALOG_STYLE_MSGBOX, "Server Commands:", "- Commands: /rules, /help, /cmds, /credits, /website, /updates, /kill, /repairveh, /mywarns, /mydrugs, /myfood, /mylicenses, /stats, /useweed, /usecoke, /usemeth, /usetaco, /usepizza, /usesoda, /pm, /pm(on/off), /givecash.", "Close", "");
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
    new string[128];
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "| NAME: %s | SCORE: %d | CASH: %d | ADMIN RANK: %d | V.I.P RANK: %d |", pname, GetPlayerScore(playerid), GetPlayerMoney(playerid), PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pVip]);
    SendClientMessage(playerid, CLIGHTBLUE, string);
    return 1;
}
CMD:mywarns(playerid, params[])
{
    new string[128];
    format(string, sizeof(string), "[SERVER]: You got %d warns!", PlayerInfo[playerid][pWarns]);
    SendClientMessage(playerid, CRED, string);
}
CMD:mydrugs(playerid, params[])
{
    new string[128];
    format(string, sizeof(string), "[DRUG INVENTORY] => WEED: %d | COKE: %d | METH: %d", PlayerInfo[playerid][pWeed], PlayerInfo[playerid][pCoke], PlayerInfo[playerid][pMeth]);
    SendClientMessage(playerid, CLIGHTBLUE, string);
    return 1;
}
CMD:myfood(playerid, params[])
{
    new string[128];
    format(string, sizeof(string), "[FOOD INVENTORY] => TACO: %d | PIZZA: %d | SODA: %d", PlayerInfo[playerid][pTaco], PlayerInfo[playerid][pPizza], PlayerInfo[playerid][pSoda]);
    SendClientMessage(playerid, CLIGHTBLUE, string);
    return 1;
}
CMD:mylicenses(playerid, params[])
{
    new string[128];
    format(string, sizeof(string), "[LICENSES INVENTORY] => DRIVING LICENSE: %d | PILOT LICENSE: %d ", PlayerInfo[playerid][pDL], PlayerInfo[playerid][pPL]);
    SendClientMessage(playerid, CLIGHTBLUE, string);
    return 1;
}
CMD:useweed(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pWeed] < 5) return SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 5 grams of weed to use it!");
    PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]-5;
    GiveHealth(playerid, 25);
    format(string, sizeof(string), "[SERVER]: %s used 5 grams of weed!", pname);
    SendClientMessageToAll(CLIME, string);
    return 1;
}
CMD:usecoke(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pCoke] < 5) return SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 5 grams of cocaine to use it!");
    PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]-5;
    GiveHealth(playerid, 50);
    format(string, sizeof(string), "[SERVER]: %s used 5 grams of cocaine!", pname);
    SendClientMessageToAll(CLIME, string);
    return 1;
}
CMD:usemeth(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pMeth] < 5) return SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 5 grams of meth to use it!");
    PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]-5;
    GiveHealth(playerid, 75);
    format(string, sizeof(string), "[SERVER]: %s used 5 grams of meth!", pname);
    SendClientMessageToAll(CLIME, string);
    return 1;
}
CMD:usetaco(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pTaco] < 5) return SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 1 taco to use it!");
    PlayerInfo[playerid][pTaco] = PlayerInfo[playerid][pTaco]-1;
    GiveHealth(playerid, 25);
    format(string, sizeof(string), "[SERVER]: %s ate a taco!", pname);
    SendClientMessageToAll(CLIME, string);
    return 1;
}
CMD:usepizza(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pPizza] < 5) return SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 1 pizza to use it!");
    PlayerInfo[playerid][pPizza] = PlayerInfo[playerid][pPizza]-1;
    GiveHealth(playerid, 40);
    format(string, sizeof(string), "[SERVER]: %s ate a slice of pizza!", pname);
    SendClientMessageToAll(CYELLOW, string);
    return 1;
}
CMD:usesoda(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pSoda] < 5) return SendClientMessage(playerid, CRED, "[SERVER]: You need atleast 1 soda bottle use it!");
    PlayerInfo[playerid][pSoda] = PlayerInfo[playerid][pSoda]-1;
    GiveHealth(playerid, 10);
    format(string, sizeof(string), "[SERVER]: %s drinks a cup of soda!", pname);
    SendClientMessageToAll(CYELLOW, string);
    return 1;
}
CMD:buyskin(playerid, params[])
{
    new string[128];
    new skinid;
    if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $10,000 to buy a skin!");
    if(sscanf(params, "u", skinid)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /buyskin <ID> ");
    if(0 < skinid < 311) return SendClientMessage(playerid, CRED, "[SERVER]: Skin ID must be between 0 & 311!");
    SetPlayerSkin(playerid, skinid);
    format(string, sizeof(string), "[SERVER]: You bought a skin for $10,000");
    SendClientMessage(playerid, CGREEN,string);
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
    new pname[MAX_PLAYER_NAME];
    new tname[MAX_PLAYER_NAME];
    new string[128];
    new targetid;
    new message;
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
CMD:givecash(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new tname[MAX_PLAYER_NAME];
    new string[128];
    new targetid;
    new cash;
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
// -------------------- { Admin Section: } ---------------------------- //

// -------------------- { Server Owner: } ---------------------------- //


CMD:setadmin(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    new level;
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
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    new level;
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
    ShowPlayerDialog(playerid, DACmds, DIALOG_STYLE_MSGBOX, "Server Admin Commands:", "- Admin commands:\n- Admin level 1: /warn, /sethealth, /setarmour, /akill, /get, /goto, /(un)freeze, /explode, /spec(off), /write.\n- Admin level 2: /kick, /ban, /setskin, /setvw, /agivecash, /healall, /armourall, /agivecashall, /aspawnall, /respawnallvehicles.\n- Admin level 3: /skick, /sban, /setscore, /getall, /setallskin, /setallvw, /setallscore, /giveallscore.", "Close","");
    return 1;
}
CMD:warn(playerid, params[])
{
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new reason[64];
    new mfp[128];
    new mfa[128];
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
    new Float:hamount;
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, hamount)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /sethealth <ID> <Amount>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 > hamount > 100) return SendClientMessage(playerid, CRED, "[SERVER]: Health amount must be between 0 & 100!");
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
    new Float:aamount;
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", targetid, aamount)) return SendClientMessage(playerid, CRED, "[SERVER]: Use ' /setarmour <ID> <Amount>");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, CRED, "[SERVER]: Wrong ID, check if the player is online!");
    if(0 > aamount > 100) return SendClientMessage(playerid, CRED, "[SERVER]: Armour amount must be between 0 & 100!");
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
    new targetid;
    new pname[MAX_PLAYER_NAME];
    new targetname[MAX_PLAYER_NAME];
    new mfp[128];
    new mfa[128];
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
// -------------------- { V.I.P Level 1: } ---------------------------- //

CMD:vcmds(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] == 0) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    ShowPlayerDialog(playerid, DVCmds, DIALOG_STYLE_MSGBOX, "Server V.I.P Commands:", "- V.I.P Level 1: /bhealth, /barmour, /vwpack (Changes at every level!)\n- V.I.P Level 2: /vgoto, /bweed, /bcoke, /bmeth, /btaco, /bpizza, /bsoda\n- V.I.P Level 3: /vget, /vcolor, /vskins", "Close","");
    return 1;
}
CMD:bhealth(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    new string[128];
    if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, CRED, "[SERVER]: You need $2,000 to heal yourself!");
    GivePlayerMoney(playerid, -2000);
    SetPlayerHealth(playerid, 100);
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
    SetPlayerArmour(playerid, 100);
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
CMD:bweed(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 5000) SendClientMessage(playerid, CRED, "[SERVER]: You need $5,000 to buy 5 grams of weed!");
    GivePlayerMoney(playerid, -5000);
    PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]+5;
    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought 5 grams of weed!");
    return 1;
}
CMD:bcoke(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 10000) SendClientMessage(playerid, CRED, "[SERVER]: You need $10,000 to buy 5 grams of cocaine!");
    GivePlayerMoney(playerid, -10000);
    PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]+5;
    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought 5 grams of cocaine!");

    return 1;
}
CMD:bmeth(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 15000) SendClientMessage(playerid, CRED, "[SERVER]: You need $15,000 to buy 5 grams of meth!");
    GivePlayerMoney(playerid, -15000);
    PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]+5;
    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought 5 grams of meth!");
    return 1;
}
CMD:btaco(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 6000) SendClientMessage(playerid, CRED, "[SERVER]: You need $6,000 a soda bottle!");
    GivePlayerMoney(playerid, -6000);
    PlayerInfo[playerid][pTaco] = PlayerInfo[playerid][pTaco]+1;
    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought a taco!");
    return 1;
}
CMD:bpizza(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 8000) SendClientMessage(playerid, CRED, "[SERVER]: You need $8,000 a soda bottle!");
    GivePlayerMoney(playerid, -8000);
    PlayerInfo[playerid][pPizza] = PlayerInfo[playerid][pPizza]+1;
    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought a pizza slice!");
    return 1;
}
CMD:bsoda(playerid, params[])
{
    if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, CRED, "[SERVER]: You must be a high level vip to use this!");
    if(GetPlayerMoney(playerid) < 2000) SendClientMessage(playerid, CRED, "[SERVER]: You need $2,000 a soda bottle!");
    GivePlayerMoney(playerid, -2000);
    PlayerInfo[playerid][pSoda] = PlayerInfo[playerid][pSoda]+1;
    SendClientMessage(playerid, CGREEN, "[SERVER]: You bought a soda bottle!");
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

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == Weaponshop)
    {
        ShowPlayerDialog(playerid, DWshop, DIALOG_STYLE_LIST, "Ammu-nation:", "- 9mm [$300] [100 ammo]\n- Silenced 9mm [$500] [100 ammo]\n- Desert Eagle [$1,000] [100 ammo]\n- Pump shotgun [$1,500] [100 ammo]\n- Sawn off [$2,000] [50 ammo]\n- Combat Shotgun [$3,000] [50 ammo]\n- Tec9 [$500] [500 ammo]\n- Micro SMG [$800] [500 ammo]\n- SMG [$1,000] [300 ammo]\n- AK47 [$3,000] [200 ammo]\n- M4 [$5,000] [200 ammo]\n- County rifle [$2,000] [100 ammo]\n- Sniper rifle [$8,000] [100 ammo]", "Select","Close");
    }
    if(pickupid == DrugFellas)
    {
        ShowPlayerDialog(playerid, DDshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$1,000] per 5 grams.\n- Cocaine [$2,500] per 5 grams.\n- Meth [$5,000] per 5 grams.", "Select","Close");
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
        ShowPlayerDialog(playerid, DDshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$1,000] per 5 grams.\n- Cocaine [$2,500] per 5 grams.\n- Meth [$5,000] per 5 grams.", "Select","Close");
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

public OnPlayerUpdate(playerid)
{
    if(PlayerInfo[playerid][pWarns]>= 3) 
    {
        new pname[MAX_PLAYER_NAME];
        new string[128];
        new targetid;
        GetPlayerName(playerid, pname, sizeof(pname));
        format(string, sizeof(string), "[SERVER]: %s has been kicked from the server for being warned too much!", pname);
        SendClientMessageToAll(CRED, string);
        PlayerInfo[playerid][pWarns] = 0;
        SetTimerEx("DelayedKick", 1000, false, "i", targetid);
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
                INI_WriteInt(File,"Cash:",1000);
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
                INI_WriteInt(File,"Driving License", 0);
                INI_WriteInt(File,"Pilot License", 0);


                INI_Close(File);

                SetSpawnInfo(playerid, 0, 0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
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
stock GiveHealth(playerid, Float:health)
{
        new
                Float: hp
        ;
        SetPlayerHealth( playerid, GetPlayerHealth( playerid, hp ) + Float: health);
        return true;
}
