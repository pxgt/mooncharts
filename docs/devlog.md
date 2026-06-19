# 用 AI + MoonBit 从零做一个图表库：mooncharts 开发手记

> 这是 2026 MoonBit 国产基础软件开源大赛参赛项目 **mooncharts** 的开发复盘。
> 仓库：<https://github.com/pxgt/mooncharts> ｜ 在线演示：<https://pxgt.github.io/mooncharts/>
> ｜ 包：`moon add Xpeng/mooncharts`

## 为什么是「图表库」

赛事鼓励做**真实可用、边界清晰、可维护**的 MoonBit 生态库。我在
[awesome-moonbit](https://github.com/moonbitlang/awesome-moonbit) 和
[mooncakes.io](https://mooncakes.io) 上确认了一件事：**MoonBit 生态里还没有现成的数据可视化 / 图表库**。

而图表库恰好同时满足几个目标：

- **边界清楚**：输入是数据，输出是一张 SVG，职责单一；
- **规模可控**：先做 4 种图，每多一种图就多一截，不会做不完；
- **展示效果强**：图表天然可视化，而 MoonBit 能编译到 JS，意味着同一份代码能在浏览器里实时画图；
- **真有人用**：MoonBit 大量面向 Web，一个原生图表库能直接被社区复用。

于是定下方向：**一个纯 MoonBit 实现、输出独立 SVG 的轻量图表库**。

## 架构：把「类型化数据」翻译成「SVG 字符串」

核心思路非常简单——**整个库就是一个把数据翻译成 SVG 文本的纯函数集合**，不依赖任何渲染运行时。分层如下：

```
数据 (Array[(String, Double)] 等)
        │
        ▼
图表层  bar / line / area / pie / scatter / radar …   ← 计算布局、坐标
        │  调用
        ▼
基础设施 scale(比例尺) · ticks(刻度) · axis(网格) · theme(主题) · legend(图例)
        │  调用
        ▼
SVG 基元层  escape · num · elem · container · text · document
        │
        ▼
一段独立的 <svg>…</svg> 字符串
```

MoonBit 的包是「按目录划分、同包文件共享作用域」，所以我把每种图表拆成**独立的小文件**
（`bar.mbt` / `line.mbt` / `pie.mbt` / `radar.mbt` …），它们共享同一个 `svg.mbt` 基元层，
彼此无需 import 就能互相调用。这正是 MoonBit 官方建议的「多个小而聚焦的文件」组织方式。

## 几个值得一提的设计

### 1. SVG 基元层：永不手写标签

所有图表都不直接拼接 `"<rect ...>"`，而是通过 `elem("rect", [...])`、`text(...)`、
`document(w, h, body)` 这些基元函数。好处是 **XML 转义、数字格式化只在一处实现**，
图表代码干净且不会拼出非法 SVG。比如数字格式化 `num`：四舍五入到 2 位小数、去掉多余的
`.0`，避免浮点尾巴污染输出。

### 2. 「漂亮刻度」算法

最初的柱状图没有数值参考网格，坐标轴是丑陋的原始极值。后来引入了 **Heckbert 的
nice-numbers 算法**：给定数据范围和目标刻度数，算出像 `0, 50, 100, …` 这样人类友好的整数刻度。
这是一个干净、可独立测试的真算法，也是整个库从「能用」到「专业」的关键一跳。

### 3. 主题系统

`Theme` 是一个内聚的可复用值（配色 / 背景 / 网格 / 文字 / 标题颜色），用 `Theme::light()`、
`Theme::dark()` 构造，还能 `with_palette([...])` 换配色。每个图表函数都接收一个可选的
`theme?` 参数，默认亮色。这里特意**没有**用「一个 options 结构体打包所有参数」的反模式——
MoonBit 推荐用带默认值的标签可选参数，而 `Theme` 作为一个独立概念才用结构体。

### 4. 多系列与图例

`line_chart_multi` / `bar_chart_grouped` / `bar_chart_stacked` / `radar_chart` 支持多条数据系列，
共享一个 `legend_horizontal` 助手画图例。雷达图用三角函数把各维度均匀铺在圆周上，
每条系列画成一个半透明多边形。

## MoonBit 用起来怎么样

作为一个偏新手、主要靠 AI 推进的参赛者，几个特性印象很深：

- **类型系统 + 模式匹配**：`match kind { "bar" => … }`、元组解构 `let (label, value) = data[i]`
  让代码直白好读；编译器是最好的纠错老师。
- **标签可选参数**：`title?`、`width?`、`theme?` 带默认值，调用处 `bar_chart(data, title="…")`
  非常顺手。
- **统一工具链**：`moon check`（秒级类型检查）、`moon test`（快照测试）、`moon fmt`、
  `moon info`（生成公共接口 `.mbti`）、`moon publish`，一条龙。
- **多后端**：这是压轴亮点——同一份图表代码 `moon build --target js` 编译成 JS，
  通过 `link.js.exports` 把 `render` 函数导出到 `globalThis`，浏览器里就能实时画图。
  [在线演示](https://pxgt.github.io/mooncharts/) 里拖滑块、切主题、看柱子生长动画，
  背后跑的就是 MoonBit。

## 和 AI 协作的几条实践

这个项目几乎全程由 AI（Claude）驱动开发，但有几条原则让结果可靠：

1. **不靠记忆猜 API，用 `moon ide doc` 查**。MoonBit 还在快速演进，
   `@math.sin`、`String::has_prefix`、`Double::sqrt` 这些都是现查现用、编译验证，而不是凭印象写。
2. **快照测试驱动**。`inspect(value)` 先留空，`moon test --update` 用真实输出回填，再人工 review。
   小输入的整图快照能精确钉住行为、防回归。复合类型调试用 `debug_inspect` 而非 `inspect`（避免
   Show 弃用警告）。
3. **紧凑的验证闭环**：每改一点就 `moon check --deny-warn`（警告即错误）→ `moon test` →
   `moon fmt --check`。CI 里跑的是同一套，所以本地绿了远程基本就绿。
4. **小步提交**：每个功能一个有意义的 commit，而不是空提交凑数。

## 工程化清单

- ✅ **CI**（GitHub Actions）：装 MoonBit → 格式检查 → 严格检查 → 构建 → 测试，全绿徽章；
- ✅ **测试**：20+ 个快照 / 结构测试，覆盖核心路径；
- ✅ **发布**：[mooncakes.io/Xpeng/mooncharts](https://mooncakes.io/docs/Xpeng/mooncharts)；
- ✅ **双仓库**：GitHub + Gitlink 镜像（每 8 小时自动同步）；
- ✅ **在线演示**：GitHub Pages 部署交互页面；
- ✅ **许可证**：Apache-2.0。

## 踩过的坑

- **命名空间 ≠ 仓库账号**：GitHub 用户名 `pxgt` 只有 4 个字符，不满足 mooncakes「≥5 字符」的要求，
  于是 mooncakes 用户名用了 `Xpeng`，包命名空间是 `Xpeng/mooncharts`，而 GitHub 仓库仍在 `pxgt` 名下——
  两者本就可以不同。
- **`moon.pkg` 新格式**：工具链已从 `moon.pkg.json` 迁移到新的 `moon.pkg`，`fmt` 会自动迁移；
  JS 导出配置写在 `options(link: { "js": { "exports": [...], "format": "iife" } })`。
- **入场动画放在哪**：动画用 Web Animations API 写在演示页面，而**不**塞进库的 SVG 输出里——
  保持库的输出是纯净、可复现的静态 SVG。

## 小结

mooncharts 现在有 **10 种图表 + 主题 + 漂亮坐标轴 + 浏览器交互演示**，从「能用」做到了「能展示、能复用、能维护」。
更重要的是，它验证了一条路径：**一个偏新手的开发者，靠 AI + MoonBit 的现代工具链，
也能在几周内做出一个工程质量过关、真实可用的开源生态库。**

如果你也在用 MoonBit，欢迎 `moon add Xpeng/mooncharts` 试一试，或来
[GitHub](https://github.com/pxgt/mooncharts) 提 issue。
