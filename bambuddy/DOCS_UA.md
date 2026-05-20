# BamBuddy на Home Assistant — 3 кроки

## Що вже зроблено автоматично

- Ваша нова функція злита в **`main`** на https://github.com/Poltavtcev/bambuddy
- Add-on тягне образ **`ghcr.io/poltavtcev/bambuddy:latest`** (не maziggy)

## Що залишилось (один раз, ~15 хв, без терміналу)

### Крок 1 — Зібрати Docker-образ (на GitHub, не на HA)

1. Відкрийте: https://github.com/Poltavtcev/hassio-koinsight/actions
2. Зліва: **Publish BamBuddy image (Poltavtcev fork)**
3. Справа: **Run workflow** → **Run workflow**
4. Дочекайтесь зеленої галочки (10–20 хв)

### Крок 2 — Зробити образ публічним (якщо Rebuild на HA падає)

1. https://github.com/Poltavtcev?tab=packages
2. **bambuddy** → **Package settings** → **Change visibility** → **Public**

### Крок 3 — Home Assistant

1. Оновити репозиторій add-on
2. **Bambuddy → Rebuild** (версія **1.3.0**)
3. **Start** → http://IP:8480

## Після наступних змін у BamBuddy

1. `git push` у **Poltavtcev/bambuddy** (гілка `main`)
2. Знову **Run workflow** (крок 1) або дочекайтесь — після push у **hassio-koinsight** workflow теж може стартувати сам
3. **Rebuild** add-on на HA
