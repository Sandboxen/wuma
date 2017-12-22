
local object = {}
local static = {}

object._id = "WUMA_Loadout_Weapon"
static._id = "WUMA_Loadout_Weapon"

/////////////////////////////////////////////////////////
/////       		 Static functions				/////
/////////////////////////////////////////////////////////
function static:GetID()
	return Loadout_Weapon._id
end

/////////////////////////////////////////////////////////
/////       		 Object functions				/////
/////////////////////////////////////////////////////////
function object:Construct(tbl)
	self.m.origin = tbl.origin or nil
	self.m.parent = tbl.parent or nil
	self.m.isprimary = tbl.isprimary or nil
	self.class = tbl.class or nil
	self.primary = tbl.primary or -1
	self.secondary = tbl.secondary or -1
	self.respect_restrictions = tbl.respect_restrictions or nil
	
	self.m._id = Loadout_Weapon._id
	
	if tbl.scope then self:SetScope(tbl.scope) else self.m.scope = "Permenant" end
end 

function object:__tostring()
	return string.format("Loadout_Weapon [%s]",self.class)
end

function object:__eq(v1,v2)
	if v1._id and v2._id then return (v1._id == v2._id) end
	return false
end

function object:Clone()
	local copy = table.Copy(self)
	local origin
	
	if self.origin then
		origin = self.origin
	else
		origin = self
	end
	
	copy.origin = origin
	local obj = Loadout_Weapon:new(copy)

	return obj
end

function object:Delete()
	if self.scope then
		self.scope:Delete()
	end
end

function object:GetBarebones()
	local tbl = {}
	for k,v in pairs(self) do
		if v then
			tbl[k] = v
		end
	end
	return tbl
end

function object:GetUniqueID()
	return obj.m._uniqueid or false
end

function object:GetID()
	return string.lower(string.format("loadout_weapon_%s",self.class))
end

function object:GetStatic()
	return Loadout_Weapon
end

function object:SetClass(parent)
	self.class = class
end

function object:GetClass()
	return self.class
end

function object:SetPrimaryAmmo(num)
	self.primary = num
end

function object:GetPrimaryAmmo()
	return self.primary
end

function object:SetSecondaryAmmo(num)
	self.secondary = num
end

function object:GetSecondaryAmmo()
	return self.secondary
end

function object:GetParent()
	return self.m.parent
end

function object:SetParent(parent)
	self.m.parent = parent
end

function object:GetOrigin()
	return self.origin
end

function object:SetScope(scope)	
	if not self:GetOrigin() then
		self.scope = scope
		if not scope.m then self.scope = Scope:new(scope) end
	
		self.scope:SetParent(self)
		
		self.scope:AllowThink()
	end
end

function object:Disable()
	self.m.disabled = true
end

function object:Enable()
	self.m.disabled = false
end

function object:IsPersonal()
	return self:GetParent():IsPersonal()
end

function object:IsPrimary()
	return self.m.isprimary or false
end

function object:SetIsPrimary(isprimary)
	self.m.isprimary = isprimary
end

function object:Shred()
	if (self:IsPersonal()) then
		WUMA.RemoveUserLoadoutWeapon(_,self:GetParent():GetParentID(),self:GetClass())
	else
		WUMA.RemoveLoadoutWeapon(_,self:GetParent():GetUserGroup(),self:GetClass())
	end
end

function object:IsDisabled() 
	if self.m and self.m.disabled then return true end
	return false
end

function object:SetRespectRestrictions(boolean)
	self.respect_restrictions = boolean
end

function object:DoesRespectRestriction()
	return self.respect_restrictions
end

Loadout_Weapon = UserObject:Inherit(static, object)