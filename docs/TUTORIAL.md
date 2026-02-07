# Tutorial completo: contador em Verilog + co-simulação AMS no Xschem/ngspice (d_cosim) + Icarus

Este texto assume **zero** conhecimento prévio do fluxo, mas não evita termos técnicos. Onde necessário, eu traduzo e contextualizo.

> **Objetivo final**: abrir `xschem/current_mirror_cosim.sch`, compilar `counter.v` com Icarus, rodar ngspice com `d_cosim`, e plotar:
> - `clk`
> - `count_out[3:0]`
> - `i(VAMM2)` (corrente “analógica” que muda com o estado digital)

---

## 0) Conceitos mínimos

### O que é um contador?

Um **contador binário** é um circuito digital que, a cada pulso de clock, incrementa seu estado interno:

- 4 bits: `count[3:0]`
- sequência: 0, 1, 2, 3, ..., 15, volta para 0 (módulo 16)

Cada bit alterna em frequências diferentes:

- bit0 alterna a cada clock
- bit1 alterna a cada 2 clocks
- bit2 alterna a cada 4 clocks
- bit3 alterna a cada 8 clocks

Isso é útil para: divisores de frequência, temporização, endereçamento, FSMs, etc.

### O que é co-simulação AMS?

**AMS (Analog/Mixed-Signal)** significa simular digital e analógico no mesmo experimento.

Neste tutorial:

- o **digital** (contador) está em **Verilog**
- o **analógico** (current mirror + carga/medição) está em **SPICE**
- o “colar” entre eles é o **ngspice** usando um modelo XSPICE chamado **`d_cosim`**

O `d_cosim` permite que o ngspice chame um simulador digital externo (aqui: Icarus) e troque sinais com o circuito analógico.

---

## 1) Ferramentas usadas

### 1.1 Xschem

Editor de esquemáticos que:

- desenha circuitos
- gera netlist
- integra com ngspice
- tem simbologia própria (`.sym`) e esquemáticos (`.sch`)

### 1.2 ngspice + XSPICE

- ngspice simula circuitos SPICE
- XSPICE adiciona modelos “de evento” (digitais), e é aí que entra o `d_cosim`

### 1.3 Icarus Verilog (iverilog/vvp)

- `iverilog`: compila Verilog
- `vvp`: executa a simulação compilada

No nosso caso, o `d_cosim` chama o Icarus por baixo.

---

## 2) Estrutura do projeto

Você vai trabalhar com estes arquivos:

- `xschem/counter.v` – o módulo Verilog do contador
- `xschem/counter.sym` – símbolo do contador (para instanciar no Xschem)
- `xschem/current_mirror_cosim.sch` – esquemático top (analógico + contador)
- `xschem/simulation/current_mirror_cosim.spice` – deck SPICE usado no ngspice

---

## 3) Verilog do contador (do zero)

Abra `xschem/counter.v`. Ele implementa um contador simples de 4 bits:

```verilog
`timescale 1ns/1ns

module counter (
  input clk,
  output reg [3:0] count
);

initial begin
  $display("initial");
  count = 0;
end

always @(posedge clk) begin
  count <= count + 1;
  $display("clock event: count=%d", count);
end

endmodule
```

Pontos-chave:

- **`timescale`**: define unidade/precisão de tempo (ex.: 1ns). O Icarus costuma exigir isso em alguns fluxos.
- **`output reg [3:0] count`**: em Verilog “clássico”, `reg` indica que o valor é armazenado (estado).
- **`initial`**: executa uma vez no início da simulação; aqui, zera o contador.
- **`always @(posedge clk)`**: executa em cada borda de subida.
- **`<=` (non-blocking assignment)**: padrão para lógica sequencial.

> Dica: para ASIC/FPGA “real”, normalmente você também terá `reset` síncrono/assíncrono. Aqui mantivemos minimalista para didática.

---

## 4) Compilar Verilog com Icarus (standalone)

Você pode testar o Verilog fora do Xschem também.

### 4.1 Compilação

```bash
iverilog -o counter_sim xschem/counter.v
```

### 4.2 Execução

Sem testbench, o Verilog não “anda” porque não há clock. No nosso fluxo, quem fornece clock é o ngspice (via `d_cosim`), então o teste standalone é opcional.

Se quiser um testbench puro Verilog, crie `verilog/tb_counter.v` (não é necessário para o tutorial principal).

---

## 5) Xschem: paths e por que aparecem “MISSING SYMBOL”

O Xschem encontra símbolos em diretórios listados em `XSCHEM_LIBRARY_PATH`.

Se ele não encontra um símbolo, ele desenha um retângulo amarelo “MISSING SYMBOL”. Foi exatamente seu problema com:

- transistores `sg13_lv_nmos` (PDK)
- símbolos de dispositivos (`vsource`, `isource`, `ammeter`, `code_shown`, `launcher`)

Por isso o setup correto precisa incluir **três blocos de libraries**:

1. **seu projeto** (este repo)
2. **biblioteca do Xschem** (devices, etc.)
3. **biblioteca do PDK** (símbolos do IHP SG13G2)

O script `./scripts/setup_xschem_paths.sh` escreve uma configuração segura.

---

## 6) Como criar um símbolo do zero no Xschem para um módulo Verilog

Aqui está o ponto que não ficou claro: **o símbolo do contador é um `.sym` comum**, mas com propriedades específicas para co-simulação.

### 6.1 Criar o símbolo (UI)

1. Abra o Xschem vazio
2. Menu: **File → New symbol**
3. Desenhe um retângulo (só estética)
4. Insira pinos:
   - `clk` como **input**
   - `count[3:0]` como **output** (bus)

> Em Xschem, o nome do pino é importante. Se você usar `count[3:0]` no símbolo, o netlist usa o bus como vetor.

5. Salve como `xschem/counter.sym`

### 6.2 Propriedades essenciais (o “segredo”)

Abra as propriedades do símbolo (ou do componente instanciado) e adicione:

- `device_model`: define que este símbolo será tratado como um **A-device** com modelo `d_cosim`.
- `tclcommand`: comando acionado pelo Xschem quando você faz **Ctrl+Click** (padrão) sobre o símbolo.

No nosso exemplo (já pronto em `counter.sym`), a instância do contador no schematic usa:

```tcl
name=a1 model=counter

device_model=".model counter d_cosim simulation=\"ivlng\" sim_args=[\"counter\"] delay=0"

tclcommand="edit_file [abs_sym_path counter.v]"
```

O que isso significa:

- `.model counter d_cosim ...` cria um modelo XSPICE chamado `counter` baseado em `d_cosim`
- `simulation="ivlng"` seleciona o backend digital (Icarus)
- `sim_args=["counter"]` diz para o co-simulador qual “top” executar (o executável `counter` gerado pelo iverilog)
- `tclcommand="edit_file ..."` abre `counter.v` no editor do Xschem quando você faz **Ctrl+Click** no símbolo

📌 **Importante**: em muitas instalações do Xschem, `tclcommand` executa com **Ctrl+Click**, não com duplo clique. Duplo clique costuma abrir o menu/edição do componente.

---

## 7) Os dois “launcher” e o que eles fazem

O símbolo `launcher.sym` é um “botão” genérico do Xschem que executa comandos Tcl.

No schematic, ele é usado para automatizar duas tarefas repetitivas:

### 7.1 Launcher “Icarusate Design”

Propriedade `tclcommand`:

```tcl
execute 1 sh -c "cd $netlist_dir; iverilog -o counter [abs_sym_path counter.v]"
```

Interpretação:

- `cd $netlist_dir`: muda para o diretório onde o Xschem gera netlists (aqui, `xschem/simulation/`)
- `iverilog -o counter .../counter.v`: compila o Verilog e gera o executável `counter`

Isso é necessário porque o `d_cosim` espera encontrar o executável no diretório da simulação.

### 7.2 Launcher “load waves”

Propriedade `tclcommand`:

```tcl
xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current name]]].raw tran
```

Interpretação:

- constrói o nome do arquivo `.raw` baseado no nome do schematic atual
- manda o Xschem carregar as ondas do `.raw` (resultado do ngspice)

---

## 8) O circuito analógico de teste (current mirror + “monitor” do contador)

O arquivo `xschem/simulation/current_mirror_cosim.spice` descreve o circuito que você viu no schematic.

### 8.1 Por que um circuito analógico aqui?

O objetivo não é “fazer um DAC perfeito”. É criar um **proxy analógico** simples para:

- garantir que os bits do contador realmente mudam
- conseguir plotar algo analógico (`i(VAMM2)`) que dependa do estado digital

### 8.2 Blocos do circuito

**(A) Fonte e clock**

- `V1 vdd 0 1.5` – alimentação
- `V2 clk 0 PULSE(...)` – gera o clock que entra no contador

**(B) Current mirror (gera bias Vg e corrente base)**

- `I0 vdd net1 10u` injeta uma corrente constante
- `M1` é NMOS “diodo” (gate=dreno) que estabelece a tensão `Vg`
- `M2` replica (espelha) a corrente em outro ramo usando o mesmo `Vg`

O nó `Vg` vira uma referência para as outras perninhas.

**(C) Pernas controladas pelos bits**

Para cada bit (`count_out0..3`) existe um par de NMOS em série:

- transistor de cima: gate = `count_outX` (atua como “chave”)
- transistor de baixo: gate = `Vg` (define a corrente, via mirror)

Resultado:

- se `count_outX = 0`, o transistor de cima corta → a perna praticamente não conduz
- se `count_outX = 1`, o transistor de cima conduz → a perna passa corrente para o GND

Com isso, o **número de bits em 1** altera a corrente total drenada.

**(D) Medição com VAMM2**

- `VAMM2 net5 net4 0` é uma fonte de 0 V
- em SPICE, isso é o jeito padrão de medir corrente: `I(VAMM2)`

Então a corrente plotada no topo é `i(VAMM2)`.

### 8.3 O que você deve ver no plot

- `clk`: um quadrado (PULSE)
- `count_out[3:0]`: cada bit alternando como esperado para contador binário
- `i(VAMM2)`: uma corrente “saltando” conforme os bits ligam/desligam as pernas

Esse último plot é o “monitor analógico” do estado digital.

---

## 9) Rodando tudo pelo Xschem

1. Abra:

```bash
xschem xschem/current_mirror_cosim.sch
```

2. Clique no launcher **Icarusate Design** (Ctrl+Click)
   - verifique se o executável `xschem/simulation/counter` foi criado

3. Rode simulação do ngspice pelo Xschem
   - deve gerar `xschem/simulation/current_mirror_cosim.raw`

4. Clique em **load waves** (Ctrl+Click)

---

## 10) Próximos passos (opcionais)

- adicionar `reset` no contador e observar o comportamento
- tornar o “monitor analógico” binariamente ponderado (1x, 2x, 4x, 8x)
- substituir o current mirror por outra carga (R, C, RC) para observar resposta dinâmica
