--
-- ati templates for use with ResourceRace.lua
--

-- Parameter indices
--
local HCPI_RoundTime		= 0
local HCPN_Parameters		= 1
SCAR_ATITemplates =
{
	playerProgress =
	{
		{
			stringParam = HCPI_RoundTime,
			text =
			{
				colour = {1,1,1,1},
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs =
				{
					1,
					"ATIFont0",
				}
			},
			placement2D =
			{
				factorX = -1,
				factorY = -1,
				minATIArea = 0,
				maxATIArea = 1,
				visibility = {},
			},
		},
	},
}

