local gradient = ix.util.GetMaterial("vgui/gradient-r.vtf")

local PANEL = {}

function PANEL:Init()
    if (IsValid(ix.gui.intro)) then
        ix.gui.intro:Remove()
    end

    ix.gui.intro = self
    self:SetSize(ScrW(), ScrH())
    self:SetZPos(9999)
    self.loaded = false
end

function PANEL:StartIntro()
    self:PlayYouTubeVideo("TU_ID_DE_VIDEO_YOUTUBE") -- Reemplaza "TU_ID_DE_VIDEO_YOUTUBE" con el ID del video de YouTube que deseas reproducir.
end

function PANEL:PlayYouTubeVideo(videoID)
    local htmlPanel = self:Add("DHTML")
    htmlPanel:Dock(FILL)
    htmlPanel:SetHTML([[
        <html>
            <head>
                <style>
                    body, html {
                        margin: 0;
                        overflow: hidden;
                    }
                </style>
            </head>
            <body>
                <iframe
                    width="100%"
                    height="100%"
                    src="https://www.youtube.com/embed/]] .. videoID .. [[?autoplay=1&controls=0&showinfo=0&autohide=1&loop=1&rel=0&fs=0"
                    frameborder="0"
                    allowfullscreen
                ></iframe>
            </body>
        </html>
    ]])

    self.htmlPanel = htmlPanel
end

function PANEL:ShowRules()

end;

function PANEL:Think()
    if(IsValid(ix.gui.characterMenu) and !self.closing) then
        ix.gui.characterMenu:SetVisible(false)
    end

    if(IsValid(LocalPlayer()) and !self.loaded) then
        self.loaded = true
        self:StartIntro();
    end

    if (input.IsKeyDown(KEY_SPACE) and !self.closing) then
        self.closing = true
        ix.gui.characterMenu:SetVisible(true)
        self:Remove()
    end
end

function PANEL:OnRemove()
    if (self.sound) then
        self.sound:Stop()
        self.sound = nil
    end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("ixPluginIntro", PANEL, "EditablePanel")

-- Override default introduction.
function PLUGIN:LoadIntro()
    vgui.Create("ixPluginIntro")
end