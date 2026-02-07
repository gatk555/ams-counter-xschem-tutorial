# Troubleshooting (erros comuns)

## 1) “MISSING SYMBOL” para NMOS/PMOS (sg13_lv_nmos, etc.)

Causa: `XSCHEM_LIBRARY_PATH` não inclui os símbolos do PDK.

Ação:

- garanta que o path do PDK existe (exemplo):
  - `/usr/local/share/OpenPDKs/IHP-Open-PDK/ihp-sg13g2/libs.tech/xschem`
  - `/usr/local/share/OpenPDKs/IHP-Open-PDK/ihp-sg13g2/libs.tech/xschem/sg13g2_pr`
- rode `./scripts/setup_xschem_paths.sh`

## 2) “MISSING SYMBOL” para vsource/isource/ammeter/code_shown/launcher

Causa: biblioteca do Xschem não está no path.

Ação: inclua pelo menos:

- `/usr/share/xschem/xschem_library`
- `/usr/share/xschem/xschem_library/devices`

## 3) `echo $XSCHEM_LIBRARY_PATH` vazio, mas você “setou” antes

Causas comuns:

- você exportou em um terminal, mas abriu o Xschem por um launcher do desktop (não herda env)
- você abriu um novo terminal (perdeu export)

Ação:

- abra o Xschem no **mesmo terminal** onde você exportou
- ou configure permanentemente via `~/.xschem/xschemrc` (script faz isso)

## 4) ngspice não acha `cornerMOSlv.lib` (ou outros modelos)

Causa: ngspice não está com o `sourcepath` configurado para o diretório de modelos do PDK.

Ação:

- verifique se seu ambiente usa `.spiceinit` do PDK (muito comum em OpenPDKs)
- se você estiver em container, veja se o PDK já injeta isso automaticamente

## 5) `d_cosim` não existe

Causa: seu ngspice foi compilado sem XSPICE.

Ação:

- use um ngspice que explicitamente suporta XSPICE
- em ambientes educacionais, o `ngspice-45` geralmente funciona

## 6) Ctrl+Click vs duplo clique não abre arquivo

Normal: o `tclcommand` (ex.: `edit_file ...`) costuma estar mapeado para **Ctrl+Click**.

Se você quiser outro comportamento, isso depende da configuração do Xschem na sua instalação.
