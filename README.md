
<div align="right">
  <details>
    <summary >🌐 Language</summary>
    <div>
      <div align="center">
        <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=en">English</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=zh-CN">简体中文</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=zh-TW">繁體中文</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=ja">日本語</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=ko">한국어</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=hi">हिन्दी</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=th">ไทย</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=fr">Français</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=de">Deutsch</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=es">Español</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=it">Itapano</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=ru">Русский</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=pt">Português</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=nl">Nederlands</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=pl">Polski</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=ar">العربية</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=fa">فارسی</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=tr">Türkçe</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=vi">Tiếng Việt</a>
        | <a href="https://openaitx.github.io/view.html?user=baldgg&project=blueprint&lang=id">Bahasa Indonesia</a>
      </div>
    </div>
  </details>
</div>

If you'd like to learn how to use this to make games, [go here](https://learn.randy.gg/?src=template-starter)

If you want some free value like this blueprint delivered to your inbox every now and then, checkout [my mailing list](https://path.randy.gg)

---

This is practically my entire toolset that I use for no-engine game development.

I used the concepts in here to make these games:
- https://store.steampowered.com/app/2571560/ARCANA/
- https://store.steampowered.com/app/3309460/Demon_Knives/
- https://store.steampowered.com/app/3433610/Terrafactor/

I've been iterating on these ideas for the last 5 years of learning how to program a game without an engine.

Things are in various stages of completion, lots of TODOs thrown around, dumb performance bottlenecks, etc. But as it stands, it's about as production ready as I've been able to pull off so far.

I'll be updating this as I continue making games and learning new things.

# Features
- Very fast pixel art asset creation & iteration pipeline with Aseprite via `asset_workbench/aseprite_asset_export.lua`
- Shaders with a rendering system that can be completely overhauled to suit whatever VFX you need
- A single-function entity gameplay programming workflow that scales well
- Fully featured sound design via FMOD, with wrappers for making it feel extremely easy to program the actual sound playback hooks
- Very tight Game_State and Entity structure that can be easily serialized

## Coming One Day™️
No idea on an ETA for these guys. It'll happen whenever it's actually needed.
- Controller support
- Custom backends for console support (switch, xbox, ps5)
- 3D rendering package & pipeline

# The Structure

Overview of Packages in `/sauce/bald`
- `/draw` cross platform high performance 2D sprite rendering via Sokol
- `/sound` easy sound playback & design system via FMOD
- `/input` simple input abstraction
- `/utils/shape` simple shape abstraction for collisions

^ In general, these packages are made to be easily upgradable and sharable across projects.

## `main.odin`  
This is the entrypoint and the structure of the main loop.

By default, I use a variable timestep. It works nicely in most situations for as little complexity as possible. But this can be altered to fit whatever the constraints of the game are. Maybe it's multiplayer. Maybe it needs a fixed timestep. Etc.

## `game.odin`
This is where most of the magic happens. The intersection of all tech. A place to "just make game".

This is the file I spend 90% of my time in, adding in new content to whatever the game is. It gets pretty big pretty quick. It's a very cozy place for writing gameplay slop.

## `entity.odin`
The backbone of the entity megastruct. As talked about [in here](https://randyprime.beehiiv.com/p/entity-structure-made-simple).

## `bald_helpers.odin`
This is the intersection of the `/bald` packages and all the game-specific stuff.


# Building

In general, development is way easier on windows since there's more tooling and it's what [~96%](https://store.steampowered.com/hwsurvey/Steam-Hardware-Software-Survey-Welcome-to-Steam) of Steam customers use, so it leads to less bugs for the majority of people because you're daily-driving the same OS and can iron out all the platform-specific kinks. If you're planning on doing game-dev full time though and targeting Steam, I'd highly recommend getting some kind of windows environment setup.

I get that some people prefer to be linux or mac chads though. It's relatively simple to get working natively since Sokol is great, so I'm beginning to add in support for both.

## Windows
1. [install Odin](https://odin-lang.org/docs/install/)
2. call `build.bat`
3. check `build/windows_debug`
4. see instructions below for running

## Mac
1. [install Odin](https://odin-lang.org/docs/install/)
2. call `build_mac.sh`
3. check `build/mac_debug`
4. see instructions below for running

## Linux
todo

## Web
coming soon™️

# Running
Needs to run from the root directory since it's accessing /res.

I'd recommend setting up the [RAD Debugger](https://github.com/EpicGamesExt/raddebugger) (windows-only) for a great running & debugging experience. I always launch my game directly from there so it's easier to catch bugs on the fly.

# FAQ
## How do I use this to make a game?
I'm focusing my efforts on teaching people how to use this via [my paid program](https://learn.randy.gg/?src=template-starter).

If you're on a budget, here's some free alternatives:
- I do [live streams](https://www.youtube.com/@randyprime2) of development while using this
- I make educational content for this on [my YT channel](https://www.youtube.com/@randyprime)

## Why is this a "blueprint" (not a library)?
Game development is complicated.

I think trying to abstract everything away behind a library is a mistake. It makes things look and feel "clean" but sacrifices the capability, limiting what you're able to do and forcing you to use hacky workarounds instead of just doing the simplest and most direct thing possible to solve the problem.

old way:
1. use library
2. hit a wall in using it
3. work around it in a hacky way or cut the idea

new way:
1. use this blueprint
2. hit a wall in using it
3. learn the fundamental thing it's doing, then build on top of it, adjusting the source
4. (optional) open an issue so I can consider integrating it into the blueprint

> The most common example is you'll have something you want to do with the rendering. So you go off an learn graphics programming using [this](https://learnopengl.com/), maybe rewriting your own version of `/draw`, or just adjusting it to do the thing you need. (Render textures, adjusting the Vertex data, multi-stage draw passes and post-processing, etc)

I tried my best to seperate the core layer `/bald` from the game specific stuff so it's easy to upgrade later on, but there's what I believe to be an unavoidable tangling of some ideas in a lot of places.

I'll continue trying to simplify this and make it as readable and usable as possible, without sacrificing the full production-ready power of it.

## Why Odin?
Compared to C, it's a lot more fun to work in. Less overall typing, more safety by default, and great quality of life. Happy programming = more gameplay.

Compared to Jai, it has more users and is public (Jai is still in a closed beta). So that means more stability and a better ecosystem around packages, tooling etc, (because more people use it).

## Why Sokol?
It feels like a nice sweet spot high and low level.

It's not as high level as something like Raylib, so there's more flexibility with what you can do. But to use it, you need to learn graphics programming. And that kinda sucks for beginners. That's why I've built this blueprint. It's kinda like an all-in-one production ready suite, where you can opt-in to the finer details without changing your end gameplay programming workflow.

But it's not as low level as something like just manually writing win32 code & raw directx11 to get a triangle drawing on the screen.
