-- HOW TO USE:
-- 1. Paste this in code:
--------------------------------------------------------------
-- Modules = {
--     skybox = "github.com/gdevillele/cubzh-modules/skybox"
-- }
--------------------------------------------------------------
-- 2. Make your config, here's the example:
--------------------------------------------------------------
-- config = {
--     url = "https://e7.pngegg.com/pngimages/57/621/png-clipart-skybox-texture-mapping-panorama-others-texture-atmosphere.png",
--     scale = 1000
-- }
--------------------------------------------------------------
-- 3. Call skybox.load(config)
--
-- 4. You can also call skybox.load(config, function(obj) obj:SetParent(Camera) end)
--    to set the object as the skybox. (object is creating inside skybox.load function)

local skybox = {}

skybox.load = function(config, func)
	local defaultConfig = {
		scale = 1000,
		url = "https://files.cu.bzh/skyboxes/blue-sky-with-clouds-at-noon.png",
	}

	local url = config.url or defaultConfig.url
	local scale = config.scale or defaultConfig.scale

	HTTP:Get(url, function(data)
		if data.StatusCode ~= 200 then
			error("Error: " .. data.StatusCode)
		end

		local image = data.Body
		local object = Object()

		local distanceFromCenter = scale * 0.5
		local quadSize = Number2(scale, scale)
		object.Scale = 1

		local oneThird = 1.0 / 3.0
		local twoThirds = 2.0 / 3.0
		local halfPi = math.pi * 0.5

		local back = Quad()
		back:SetParent(object)
		back.Anchor:Set(0.5, 0.5)
		back.LocalPosition:Set(0, 0, -distanceFromCenter)
		back.LocalRotation:Set(0, math.rad(180), 0)
		back.IsDoubleSided = false
		back.Image = image
		back.Size = quadSize
		back.Tiling = Number2(0.25, oneThird)
		back.Offset = Number2(0, oneThird)
		back.IsUnlit = true

		local left = Quad()
		left:SetParent(object)
		left.Anchor:Set(0.5, 0.5)
		left.LocalPosition:Set(-distanceFromCenter, 0, 0)
		left.LocalRotation:Set(0, math.rad(-90), 0)
		left.IsDoubleSided = false
		left.Image = image
		left.Size = quadSize
		left.Tiling = Number2(0.25, oneThird)
		left.Offset = Number2(0.25, oneThird)
		left.IsUnlit = true

		local front = Quad()
		front:SetParent(object)
		front.Anchor:Set(0.5, 0.5)
		front.LocalPosition:Set(0, 0, distanceFromCenter)
		front.LocalRotation:Set(0, 0, 0)
		front.IsDoubleSided = false
		front.Image = image
		front.Size = quadSize
		front.Tiling = Number2(0.25, oneThird)
		front.Offset = Number2(0.5, oneThird)
		front.IsUnlit = true

		local right = Quad()
		right:SetParent(object)
		right.Anchor:Set(0.5, 0.5)
		right.LocalPosition:Set(distanceFromCenter, 0, 0)
		right.LocalRotation:Set(0, math.rad(90), 0)
		front.IsDoubleSided = false
		right.Image = image
		right.Size = quadSize
		right.Tiling = Number2(0.25, oneThird)
		right.Offset = Number2(0.75, oneThird)
		right.IsUnlit = true

		local down = Quad()
		down:SetParent(object)
		down.Anchor:Set(0.5, 0.5)
		down.LocalPosition:Set(0, -distanceFromCenter, 0)
		down.LocalRotation:Set(math.rad(90), 0, math.rad(90))
		down.IsDoubleSided = false
		down.Image = image
		down.Size = quadSize
		down.Tiling = Number2(0.25, oneThird)
		down.Offset = Number2(0.25, twoThirds)
		down.IsUnlit = true

		local up = Quad()
		up:SetParent(object)
		up.Anchor:Set(0.5, 0.5)
		up.LocalPosition:Set(0, distanceFromCenter, 0)
		up.LocalRotation:Set(math.rad(-90), 0, math.rad(-90))
		up.IsDoubleSided = false
		up.Image = image
		up.Size = quadSize
		up.Tiling = Number2(0.25, oneThird)
		up.Offset = Number2(0.25, 0)
		up.IsUnlit = true

		object:SetParent(Camera)
		object.LocalPosition:Set(0, 0, 0)
		object.Tick = function(self)
			self.Rotation:Set(0, 0, 0)
		end
	end)
end

return skybox
