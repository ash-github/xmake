--!The Automatic Cross-platform Build Tool
-- 
-- XMake is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- 
-- XMake is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public License
-- along with XMake; 
-- If not, see <a href="http://www.gnu.org/licenses/"> http://www.gnu.org/licenses/</a>
-- 
-- Copyright (C) 2009 - 2015, ruki All rights reserved.
--
-- @author      ruki
-- @file        platform.lua
--

-- define module: platform
local platform = platform or {}

-- load modules
local utils     = require("base/utils")
local config    = require("base/config")

-- init platform
function platform.init()

    -- have been existed?
    if platform._CONFIGS then
        return platform._CONFIGS
    end

    -- get target
    local target = config.target()
    assert(target)

    -- load platform
    local p = require("platform/_" .. target.plat)
    if not p then
        return nil
    end

    -- init platform
    platform._CONFIGS = p.init()

    -- ok?
    return platform._CONFIGS
end

-- dump configs
function platform.dump()
    
    -- check
    assert(platform._CONFIGS)

    -- dump
    if xmake._OPTIONS.verbose then
        utils.dump(platform._CONFIGS)
    end
   
end

-- return module: platform
return platform