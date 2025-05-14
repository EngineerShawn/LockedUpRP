
# Adaptive Card Customization Guide

## 🎨 Changing Text Color

To change the color of any text inside the Adaptive Card, edit the `color` property in the `TextBlock` section.

### Example:
```json
{
  "type": "TextBlock",
  "text": "Your text here",
  "color": "Accent"  // Change this value to your preferred color
}
```

### Available Color Options:
- `Default` — Normal text color
- `Dark` — Darker text
- `Light` — Lighter text
- `Accent` — Highlighted color
- `Good` — Green (Success)
- `Warning` — Yellow (Warning)
- `Attention` — Red (Error)

> **Tip:** Just replace `"Accent"` with any color you want from the list above!

---

## 🖼️ Adding a Background Image

Go to **line 14** and update the URL with your background image:

```lua
["backgroundImage"] = {
    url = "PUT-YOUR-BACKGROUND-IMAGE-URL-HERE", -- Background image
    fillMode = "Cover",
    horizontalAlignment = "Center",
    verticalAlignment = "Center"
},
```

---

## 🖌️ Setting Your Server Logo

Go to **line 65** and update the logo image URL:

```lua
{
    ["type"] = "Column",
    ["width"] = "auto",
    ["items"] = {
        {
            ["type"] = "Image",
            ["url"] = "PUT-YOUR-LOGO-URL-HERE", -- Server logo
            ["size"] = "Medium",
            ["horizontalAlignment"] = "Center",
            ["spacing"] = "Small"
        }
    }
}
```

---

## 💬 Need Help?

Join our Discord server for support and customization help:  
👉 [https://discord.gg/Swj5A8ZhC9](https://discord.gg/Swj5A8ZhC9)

---

# 🚀 Happy Coding!
