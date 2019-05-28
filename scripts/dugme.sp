#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Devil"
#define PLUGIN_VERSION "0.01"

#include <sourcemod>
#include <sdktools>
#include <tf2>
#include <tf2_stocks>
#include <sdkhooks>

public Plugin:myinfo = 
{
	name = "Jailbreak Düğme Kontrol", 
	author = PLUGIN_AUTHOR, 
	description = "", 
	version = PLUGIN_VERSION, 
	url = ""
};
public OnClientPutInServer(client) {
	//SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}
public OnPluginStart()
{
	HookEntityOutput("func_button", "OnPressed", OnActivated);
	HookEntityOutput("func_button", "OnDamaged", OnActivated);
}
public OnActivated(const String:output[], dugme, basan, Float:sure)
{
	if (IsValidClient(basan) && IsValidEdict(dugme))
		if (GetClientTeam(basan) > 1)
		HUD(-1.0, 0.2, 6.0, 255, 0, 0, 2, "\nKırmızı Takımdan: %N\n Düğmeye Bastı!", basan);
}
/*
public Action:OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype) {
	new ent = -1;
	while(ent = FindEntityByClassname(ent, "func_button") != -1)
		if(IsValidEntity(ent))
			if(GetClientTeam(attacker) > 1)
				HUD(-1.0, 0.2, 6.0, 255, 0, 0, 2, "\nKırmızı Takımdan: %N\n Düğmeye Bastı! (SDKHookDamage)", attacker);
}
*/
stock bool:IsValidClient(client, bool:nobots = true)
{
	if (client <= 0 || client > MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
	{
		return false;
	}
	return IsClientInGame(client);
}
HUD(Float:x, Float:y, Float:Sure, r, g, b, kanal, const String:message[], any:...)
{
	SetHudTextParams(x, y, Sure, r, g, b, 255, 0, 6.0, 0.1, 0.2);
	new String:buffer[256];
	VFormat(buffer, sizeof(buffer), message, 9);
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i))
		{
			ShowHudText(i, kanal, buffer);
		}
	}
} 