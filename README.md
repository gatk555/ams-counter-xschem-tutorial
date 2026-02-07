# Xschem + ngspice + Icarus Verilog: tutorial completo de co-simulação AMS (contador)

Este repositório é um tutorial **do zero** para:

- entender o que é um **contador binário** em Verilog
- compilar/simular o Verilog com **Icarus Verilog (iverilog/vvp)**
- criar um **símbolo no Xschem** que referencia um `.v`
- fazer **co-simulação AMS** usando **ngspice + XSPICE `d_cosim`**
- montar um **circuito analógico simples** no Xschem para “visualizar” o estado digital (via corrente/onda)

> ⚠️ **PDK não incluído**: este repo **não** distribui modelos/símbolos do PDK. Você precisa ter o PDK instalado no seu ambiente (ex.: IHP SG13G2 via OpenPDKs) ou usar um container que já tenha isso.

## Sumário

- [Quickstart](#quickstart)
- [Estrutura do repositório](#estrutura-do-repositório)
- [Documentação](#documentação)

## Quickstart

### 1) Pré-requisitos

- `xschem` (>= 3.4.x)
- `ngspice` com suporte a **XSPICE** (ngspice-45 costuma funcionar)
- `iverilog` (Icarus Verilog) e `vvp`
- símbolos/modelos do PDK (ex.: IHP SG13G2) acessíveis via `XSCHEM_LIBRARY_PATH` e via `ngspice` (sourcepath)

Valide seu ambiente:

```bash
./scripts/check_install.sh
```

### 2) Configurar paths do Xschem (recomendado)

Este script adiciona um *snippet* no `~/.xschem/xschemrc` apontando para:

- este repositório (`$AMS_DEMO_HOME/xschem`)
- biblioteca do Xschem (`/usr/share/xschem/...`)
- símbolos do PDK IHP SG13G2 (OpenPDKs)

```bash
export AMS_DEMO_HOME="$PWD"
./scripts/setup_xschem_paths.sh
```

Depois, **abra o Xschem a partir do mesmo terminal** (para herdar `AMS_DEMO_HOME`):

```bash
xschem xschem/current_mirror_cosim.sch
```

### 3) Rodar a co-simulação

Dentro do Xschem:

1. Clique no *launcher* **“Icarusate Design”** (Ctrl+Click no símbolo) para compilar o Verilog.
2. Rode a simulação do ngspice (ícone de “Run” do Xschem).
3. Clique no *launcher* **“load waves”** para carregar o `.raw` e ver os plots.

## Estrutura do repositório

- `xschem/` – schematics/símbolos e o Verilog
- `xschem/simulation/` – deck SPICE de co-simulação
- `scripts/` – setup e sanity checks
- `docs/` – tutorial completo (passo a passo)

## Documentação

- `docs/TUTORIAL.md` – tutorial completo, didático e detalhado
- `docs/TROUBLESHOOTING.md` – erros comuns (missing symbol, paths, d_cosim, etc.)

---

## Licença

MIT. Veja `LICENSE`.

## Publicar no GitHub

```bash
# 1) Descompacte o zip (se você baixou como arquivo)
unzip ams-counter-xschem-tutorial.zip
cd ams-counter-xschem-tutorial

# 2) Inicie o repositório e faça o primeiro commit
git init
git add -A
git commit -m "Initial commit: AMS cosim counter tutorial"

# 3) Crie o repositório no GitHub e conecte o remote
git branch -M main
git remote add origin <URL_DO_SEU_REPO>
git push -u origin main
```
