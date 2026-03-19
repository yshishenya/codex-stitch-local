# codex-stitch-local

[![Node.js](https://img.shields.io/badge/node-%3E%3D22-339933?logo=node.js&logoColor=white)](https://nodejs.org/)
[![npm](https://img.shields.io/badge/npm-supported-CB3837?logo=npm&logoColor=white)](https://www.npmjs.com/)
[![Agent Skills](https://img.shields.io/badge/format-Agent%20Skills-7B61FF)](https://agentskills.io)
[![Codex](https://img.shields.io/badge/OpenAI-Codex-10A37F)](https://developers.openai.com/codex/skills)
[![Claude Code](https://img.shields.io/badge/Anthropic-Claude%20Code-D97706)](https://code.claude.com/docs/en/slash-commands)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-ClawHub-2563EB)](https://docs.openclaw.ai/tools/clawhub)

Cross-agent Stitch skill bundle for local UI generation and iteration with the official `@google/stitch-sdk`.

This repository is designed to work across:

- Codex
- Claude Code
- OpenClaw
- any other client that can consume `SKILL.md` or `AGENTS.md`

Этот репозиторий сделан как универсальный bundle для:

- Codex
- Claude Code
- OpenClaw
- и других клиентов, которые понимают `SKILL.md` или `AGENTS.md`

## Table Of Contents

- [English](#english)
- [Русский](#русский)
- [Contributing](./CONTRIBUTING.md)

## English

### Overview

`codex-stitch-local` packages a reusable `stitch-design-local` skill plus a local runtime toolkit called `stitch-starter`.

The main goal is portability:

- one canonical skill source
- one shared toolkit location
- native compatibility for Codex, Claude Code, and OpenClaw
- no hardcoded machine-specific home paths

This repository uses the open `Agent Skills` model and adds thin compatibility layers for each client ecosystem.

### What Is Included

```text
codex-stitch-local/
├── AGENTS.md
├── install.sh
├── .claude-plugin/plugin.json
├── skills/
│   └── stitch-design-local/
│       ├── SKILL.md
│       ├── agents/openai.yaml
│       ├── references/
│       └── workflows/
└── stitch-starter/
    ├── package.json
    ├── .env.example
    ├── scripts/
    └── README.md
```

### Compatibility Model

The repository is structured around a single canonical skill and a single shared toolkit:

- canonical skill install path: `${AGENT_SKILLS_HOME:-$HOME/.agents}/skills/stitch-design-local`
- canonical toolkit install path: `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}`

Then `install.sh` creates native compatibility links for:

- Codex: `${CODEX_HOME:-$HOME/.codex}/skills/stitch-design-local`
- Claude Code: `${CLAUDE_HOME:-$HOME/.claude}/skills/stitch-design-local`
- OpenClaw: `${OPENCLAW_HOME:-$HOME/.openclaw}/skills/stitch-design-local`

This gives you one maintained source of truth instead of separate per-client copies.

### Requirements

- Linux or macOS shell environment
- Node.js `22+`
- npm
- a valid `STITCH_API_KEY`
- one of: Codex, Claude Code, OpenClaw, or another agent that can read the skill

### Quick Start

```bash
git clone https://github.com/yshishenya/codex-stitch-local.git
cd codex-stitch-local
bash install.sh --target all
```

What this does:

1. Installs the canonical skill into `~/.agents/skills/stitch-design-local`
2. Installs the toolkit into `~/.agents/stitch-starter`
3. Creates native compatibility links for Codex, Claude Code, and OpenClaw
4. Creates `.env` from `.env.example` if needed
5. Runs `npm ci` or `npm install`
6. Runs `npm run list` if `STITCH_API_KEY` is already configured

### Installation Targets

Install for every supported client:

```bash
bash install.sh --target all
```

Install only the canonical Agent Skills layout:

```bash
bash install.sh --target universal
```

Install for Codex only:

```bash
bash install.sh --target codex
```

Install for Claude Code only:

```bash
bash install.sh --target claude
```

Install for OpenClaw only:

```bash
bash install.sh --target openclaw
```

Other useful flags:

```bash
bash install.sh --target all --force
bash install.sh --target all --skip-npm
bash install.sh --target all --skip-smoke
```

### Platform-Specific Usage

#### Codex

Official references:

- OpenAI Codex Skills: https://developers.openai.com/codex/skills
- OpenAI skills catalog: https://github.com/openai/skills

Install:

```bash
bash install.sh --target codex
```

Use:

```text
Use $stitch-design-local to generate a premium desktop dashboard for an internal analytics product.
```

Codex-specific notes:

- the skill includes `agents/openai.yaml` for better Codex UI metadata
- the trigger quality depends heavily on the `description` field in `SKILL.md`
- repo-local discovery in Codex today centers on `.agents/skills`

#### Claude Code

Official references:

- Skills docs: https://code.claude.com/docs/en/slash-commands
- Plugin docs: https://code.claude.com/docs/en/plugins

Install:

```bash
bash install.sh --target claude
```

Use:

```text
/stitch-design-local landing page for a design tool aimed at enterprise product teams
```

This repository also includes a Claude plugin manifest:

- [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)

Claude-specific notes:

- the plugin manifest makes the repo easier to package as a Claude Code plugin source
- the skill itself stays in portable `SKILL.md` format rather than a Claude-only format
- the repository can also be indexed by custom Claude plugin marketplaces

#### OpenClaw

Official references:

- Skills: https://docs.openclaw.ai/tools/skills
- ClawHub: https://docs.openclaw.ai/tools/clawhub

Install:

```bash
bash install.sh --target openclaw
```

Use:

```text
Use the stitch-design-local skill to explore three mobile-first UI directions for a checkout experience.
```

OpenClaw-specific notes:

- the skill frontmatter is kept single-line friendly for OpenClaw compatibility
- metadata is encoded in a single-line inline map for safer parsing
- the canonical public distribution surface for OpenClaw is ClawHub

### Direct CLI Usage

All toolkit commands run from:

```bash
cd "${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"
```

List projects and screens:

```bash
npm run list
```

Generate a screen:

```bash
npm run generate -- --prompt "A modern SaaS dashboard with sidebar and stat cards"
```

Edit the latest screen:

```bash
npm run edit -- --prompt "Make it more premium and add stronger typography"
```

Generate variants:

```bash
npm run variants -- --prompt "Explore three different visual directions" --variant-count 3
```

### Output Files

Runs are saved under:

```text
${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/<timestamp>-<operation>-<slug>/
```

Typical artifacts:

- `result.json` or `variants.json`
- `screen.html`
- `screen.png`, `screen.jpeg`, or `screen.webp`
- `html-url.txt`
- `image-url.txt`

Latest single-screen pointer:

```text
${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/latest-screen.json
```

### Discoverability For AI Agents

This repository is intentionally optimized for discovery:

- strong `description` field in `SKILL.md`
- portable `Agent Skills` structure
- root-level [`AGENTS.md`](./AGENTS.md) for catalog-style discovery
- Codex UI metadata in [`agents/openai.yaml`](./skills/stitch-design-local/agents/openai.yaml)
- Claude plugin metadata in [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)
- GitHub-friendly repository naming and keyword coverage

If you are building your own agent client or marketplace, start by reading:

- [AGENTS.md](./AGENTS.md)
- [SKILL.md](./skills/stitch-design-local/SKILL.md)

### Publishing And Distribution

This repository is now usable through several channels:

- direct GitHub clone and installer
- Codex-compatible install from GitHub
- Claude Code plugin-compatible packaging
- OpenClaw-native publication through ClawHub

Current practical distribution surfaces:

- GitHub repository: canonical source
- ClawHub: OpenClaw-native registry
- external skill catalogues and marketplaces through PRs or submissions

### Updating An Existing Install

```bash
git pull
bash install.sh --target all --force
```

The installer preserves the current toolkit `.env` during forced reinstalls.

### Troubleshooting

#### `STITCH_API_KEY is not set`

Add your key to:

```text
${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/.env
```

Expected format:

```dotenv
STITCH_API_KEY=your_key_here
```

#### `Node.js 22+ is required`

Install Node.js 22 or newer and rerun:

```bash
bash install.sh --target all
```

#### The skill does not appear in the client

Restart the client after installation:

- restart Codex
- restart Claude Code
- restart the OpenClaw session

#### Smoke test fails

Run manually:

```bash
cd "${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"
npm run list
```

Then verify:

- `.env` exists
- `STITCH_API_KEY` is valid
- outbound network access is available

### Security Notes

- do not commit `.env`
- do not print `STITCH_API_KEY`
- generated `runs/` outputs may contain internal UI concepts or product directions
- review artifacts before sharing publicly

### Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

Contribution priorities:

- improve portability
- improve cross-agent compatibility
- improve discoverability
- improve installer reliability
- improve documentation and validation

### License

No explicit open-source license has been added yet.

Until a license is published, treat the repository as `UNLICENSED`.

## Русский

### Обзор

`codex-stitch-local` объединяет:

- переносимый skill `stitch-design-local`
- локальный toolkit `stitch-starter`
- совместимость сразу с Codex, Claude Code и OpenClaw

Главная идея здесь не просто “положить `SKILL.md` в репозиторий”, а сделать один канонический skill и один shared toolkit, а уже потом дать нативные точки входа для разных клиентов.

### Что Входит В Репозиторий

```text
codex-stitch-local/
├── AGENTS.md
├── install.sh
├── .claude-plugin/plugin.json
├── skills/
│   └── stitch-design-local/
│       ├── SKILL.md
│       ├── agents/openai.yaml
│       ├── references/
│       └── workflows/
└── stitch-starter/
    ├── package.json
    ├── .env.example
    ├── scripts/
    └── README.md
```

### Модель Совместимости

Канонические пути установки:

- skill: `${AGENT_SKILLS_HOME:-$HOME/.agents}/skills/stitch-design-local`
- toolkit: `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}`

Дальше `install.sh` создает native compatibility links:

- Codex: `${CODEX_HOME:-$HOME/.codex}/skills/stitch-design-local`
- Claude Code: `${CLAUDE_HOME:-$HOME/.claude}/skills/stitch-design-local`
- OpenClaw: `${OPENCLAW_HOME:-$HOME/.openclaw}/skills/stitch-design-local`

За счет этого у вас нет трех независимых копий skill-а, которые потом начинают расходиться.

### Требования

- Linux или macOS shell environment
- Node.js `22+`
- npm
- валидный `STITCH_API_KEY`
- один из клиентов: Codex, Claude Code, OpenClaw или другой агент, который умеет читать skill

### Быстрый Старт

```bash
git clone https://github.com/yshishenya/codex-stitch-local.git
cd codex-stitch-local
bash install.sh --target all
```

Что делает установщик:

1. Ставит canonical skill в `~/.agents/skills/stitch-design-local`
2. Ставит toolkit в `~/.agents/stitch-starter`
3. Создает compatibility links для Codex, Claude Code и OpenClaw
4. Создает `.env` из `.env.example`, если нужно
5. Запускает `npm ci` или `npm install`
6. Запускает `npm run list`, если `STITCH_API_KEY` уже настроен

### Таргеты Установки

Для всех поддерживаемых клиентов:

```bash
bash install.sh --target all
```

Только canonical Agent Skills layout:

```bash
bash install.sh --target universal
```

Только для Codex:

```bash
bash install.sh --target codex
```

Только для Claude Code:

```bash
bash install.sh --target claude
```

Только для OpenClaw:

```bash
bash install.sh --target openclaw
```

Полезные флаги:

```bash
bash install.sh --target all --force
bash install.sh --target all --skip-npm
bash install.sh --target all --skip-smoke
```

### Использование По Платформам

#### Codex

Официальные источники:

- OpenAI Codex Skills: https://developers.openai.com/codex/skills
- каталог OpenAI skills: https://github.com/openai/skills

Установка:

```bash
bash install.sh --target codex
```

Использование:

```text
Use $stitch-design-local to generate a premium desktop dashboard for an internal analytics product.
```

Нюансы для Codex:

- skill содержит `agents/openai.yaml` для лучшей UI-discoverability
- качество автоподхвата сильно зависит от `description` в `SKILL.md`
- repo-local discovery в актуальной документации завязан на `.agents/skills`

#### Claude Code

Официальные источники:

- skills docs: https://code.claude.com/docs/en/slash-commands
- plugins docs: https://code.claude.com/docs/en/plugins

Установка:

```bash
bash install.sh --target claude
```

Использование:

```text
/stitch-design-local landing page for a design tool aimed at enterprise product teams
```

В репозитории уже есть Claude plugin manifest:

- [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)

Нюансы для Claude Code:

- plugin manifest упрощает упаковку repo как plugin source
- сам skill остается в переносимом формате `SKILL.md`, а не в Claude-only формате
- репозиторий можно индексировать и через custom Claude plugin marketplaces

#### OpenClaw

Официальные источники:

- skills: https://docs.openclaw.ai/tools/skills
- ClawHub: https://docs.openclaw.ai/tools/clawhub

Установка:

```bash
bash install.sh --target openclaw
```

Использование:

```text
Use the stitch-design-local skill to explore three mobile-first UI directions for a checkout experience.
```

Нюансы для OpenClaw:

- frontmatter skill-а держится single-line friendly
- `metadata` записан inline-map строкой ради более безопасной совместимости с парсером OpenClaw
- каноническая native-distribution surface для OpenClaw это ClawHub

### Использование Через CLI

Все команды toolkit-а выполняются из:

```bash
cd "${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"
```

Список проектов и экранов:

```bash
npm run list
```

Сгенерировать экран:

```bash
npm run generate -- --prompt "A modern SaaS dashboard with sidebar and stat cards"
```

Отредактировать последний экран:

```bash
npm run edit -- --prompt "Make it more premium and add stronger typography"
```

Сгенерировать варианты:

```bash
npm run variants -- --prompt "Explore three different visual directions" --variant-count 3
```

### Выходные Артефакты

Результаты сохраняются в:

```text
${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/<timestamp>-<operation>-<slug>/
```

Типичные файлы:

- `result.json` или `variants.json`
- `screen.html`
- `screen.png`, `screen.jpeg` или `screen.webp`
- `html-url.txt`
- `image-url.txt`

Ссылка на последний single-screen run:

```text
${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/latest-screen.json
```

### Discoverability Для ИИ-Агентов

Репозиторий специально оптимизирован под discoverability:

- сильный `description` в `SKILL.md`
- portable `Agent Skills` structure
- root-level [`AGENTS.md`](./AGENTS.md) для catalog-style discovery
- метаданные Codex в [`agents/openai.yaml`](./skills/stitch-design-local/agents/openai.yaml)
- метаданные Claude plugin в [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)
- GitHub-friendly naming и keyword coverage

Если вы строите свой агент, marketplace или indexer, начните с:

- [AGENTS.md](./AGENTS.md)
- [SKILL.md](./skills/stitch-design-local/SKILL.md)

### Публикация И Дистрибуция

Репозиторий уже пригоден для распространения через:

- прямой GitHub clone + installer
- Codex-compatible install из GitHub
- Claude Code plugin-compatible packaging
- OpenClaw-native publication через ClawHub

Практические каналы распространения сейчас:

- GitHub repo как canonical source
- ClawHub как native registry для OpenClaw
- внешние skill catalogs / marketplaces через PR или submission

### Обновление Уже Установленной Версии

```bash
git pull
bash install.sh --target all --force
```

Установщик сохраняет текущий `.env` toolkit-а при `--force`.

### Решение Проблем

#### `STITCH_API_KEY is not set`

Добавьте ключ в:

```text
${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/.env
```

Формат:

```dotenv
STITCH_API_KEY=your_key_here
```

#### `Node.js 22+ is required`

Поставьте Node.js 22 или новее и повторите:

```bash
bash install.sh --target all
```

#### Skill не появился в клиенте

После установки перезапустите клиент:

- restart Codex
- restart Claude Code
- restart OpenClaw session

#### Smoke test падает

Запустите вручную:

```bash
cd "${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"
npm run list
```

И проверьте:

- что `.env` существует
- что `STITCH_API_KEY` валиден
- что есть исходящий доступ в сеть

### Безопасность

- не коммитьте `.env`
- не печатайте `STITCH_API_KEY`
- папка `runs/` может содержать внутренние UI-концепты и продуктовые направления
- перед публикацией внешних артефактов проверяйте содержимое

### Контрибьютинг

Смотрите [CONTRIBUTING.md](./CONTRIBUTING.md).

Приоритеты для вклада:

- portability
- cross-agent compatibility
- discoverability
- reliability installer-а
- docs и validation

### Лицензия

Явная open-source лицензия пока не добавлена.

До публикации лицензии считайте репозиторий `UNLICENSED`.
