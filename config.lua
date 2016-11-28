--calculate the aspect ratio of the device:
local aspectRatio = display.pixelHeight / display.pixelWidth

application = {
    content = {
        width =  800,
        height = 1200,
        scale = "letterBox",
        xAlign = "center",
        yAlign = "center",
        fps = 60,

        imageSuffix = {
            ["@2x"] = 1.3,
        },
    },
}