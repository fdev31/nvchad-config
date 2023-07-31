local exported = {}

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

exported.isWorkLaptop = file_exists('/home/fab/liberty/code')

return exported
