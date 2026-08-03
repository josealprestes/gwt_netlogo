# Global Workspace Theory (GWT) em NetLogo

[![License: MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg)](LICENSE)

> [!IMPORTANT]
> **Status do Projeto: CONGELADO**
> Este repositório encontra-se em manutenção/congelamento. Não há planos para novas implementações no curto prazo, servindo como base estável para estudos e referências futuras.

## Sobre

Simulação em NetLogo de um conceito de **Consciência Artificial** baseado na **Teoria do Espaço de Trabalho Global** (Global Workspace Theory, GWT), proposta pelo neurocientista Bernard Baars.

A teoria descreve a consciência como um "teatro da mente": diversos processos inconscientes competem por um foco de atenção (a consciência). Uma vez no foco, a informação vencedora é transmitida globalmente para todos os outros processos, moldando o comportamento do agente.

O modelo implementa essa competição com **processadores especializados** (visual e auditivo) que geram mensagens com níveis de **urgência**; o processador com maior urgência acima do limiar vence o ciclo e transmite sua mensagem pelo espaço de trabalho global.

## Contexto Acadêmico

Projeto desenvolvido no âmbito da disciplina **IA006 - Tópicos em Sistemas Inteligentes II**, oferecida pelo Programa de Pós-Graduação em Engenharia Elétrica da **Faculdade de Engenharia Elétrica e de Computação (FEEC) da Unicamp**, no **segundo semestre de 2025 (2S/2025)**, cursada como **estudante especial**.

Docentes responsáveis: **Prof. Gilmar Barreto** e **Prof. Bruno Sanches Masiero** (Turma G, quartas-feiras 14h-18h).

Ementa oficial (DAC/Unicamp, 2S/2025):

> "Esta disciplina tem como objetivo aprofundar o conhecimento em sistemas inteligentes, explorando tópicos avançados e recentes na área."
> Bibliografia: definida no semestre do oferecimento.

O modelo foi desenvolvido a partir das discussões havidas em sala de aula sobre **Consciência Artificial**, tema que dialoga diretamente com meu interesse de pesquisa em **Pseudo-Consciência em Grandes Modelos de Linguagem (LLM)**: ao simular o mecanismo de competição pelo foco da consciência, o GWT oferece uma lente para investigar o que distingue um processo consciente de uma simulação de consciência.

O projeto conecta também uma trajetória profissional multidisciplinar de mais de 25 anos, que integra **Direito, Tecnologia e Gestão**, com a pesquisa acadêmica em sistemas inteligentes, arquiteturas cognitivas e simulação baseada em agentes.

## O Modelo

### Componentes implementados

- **Processadores especializados**: módulos visual (vermelho) e auditivo (azul) que reagem a estímulos específicos.
- **Mecanismo de competição**: uso de `urgency` (urgência) para determinar qual processador ganha o foco.
- **Espaço de Trabalho Global**: estrutura central que armazena e propaga a mensagem do processador vencedor.
- **Visualização dinâmica**: feedback visual em tempo real através de cores e links no NetLogo.
- **Interface de controle**: sliders para frequência de estímulos, taxa de decaimento e limiar de urgência.

### Interface (widgets)

| Widget | Nome | Função |
|--------|------|--------|
| Botão | `Setup` | Inicializa o ambiente e os processadores |
| Botão | `Go` | Inicia a simulação em loop |
| Slider | `num-processors-per-type` | Quantidade de processadores de cada tipo |
| Slider | `stimulus-frequency` | Frequência de geração de estímulos externos |
| Slider | `activation-boost` | Incremento de urgência ao receber estímulo |
| Slider | `urgency-threshold` | Limiar mínimo para vencer a competição |
| Slider | `decay-rate` | Taxa de decaimento da urgência por ciclo |
| Plot | `Níveis de Urgência` | Evolução temporal da urgência dos processadores |
| Monitor | `Foco Atual` | Processador vencedor do ciclo atual |

## Como Usar

### Pré-requisitos

- **NetLogo 6.4.0** (ou versão 6.x compatível)
- Sistema operacional com suporte ao NetLogo (Windows, macOS, Linux)

### Passo a passo

1. Abra o arquivo `gwt_netlogo.nlogo` no NetLogo.
2. Clique no botão `Setup` para inicializar o ambiente.
3. Clique no botão `Go` para iniciar a simulação.
4. Observe o monitor `Foco Atual` e o plot `Níveis de Urgência`.
5. Ajuste os sliders para explorar como diferentes configurações afetam o "fluxo de consciência".

### Sugestões de exploração

- **Aumente `stimulus-frequency`**: mais estímulos competem pelo foco, alternância mais rápida entre processadores.
- **Aumente `urgency-threshold`**: o foco muda com menos frequência, simula atenção mais estável.
- **Aumente `decay-rate`**: urgências decaem rápido, favorecendo o processador recém-estimulado.

## Estrutura do Repositório

```text
.
├── README.md               # Este documento
├── LICENSE                 # Licença MIT
└── gwt_netlogo.nlogo       # Modelo NetLogo (arquivo principal)
```

## Próximos Passos Planejados (quando o desenvolvimento for retomado)

1. **Pensamentos internos (memória)**: novo tipo de processador que gera picos de urgência espontâneos, simulando pensamentos sem estímulos externos.
2. **Mecanismos de inibição**: ao vencer, o processador suprime temporariamente a urgência dos demais, estabilizando o foco.
3. **Execução de ações**: o agente do espaço de trabalho executa ações concretas (movimentação ou mudança de estado) baseadas na mensagem em foco.
4. **Aprendizado**: a eficácia de um processador em ganhar o foco aumenta com base no sucesso de ações passadas.

## FAQ

**Qual versão do NetLogo é necessária?**
NetLogo 6.4.0 ou qualquer versão 6.x compatível.

**O que o modelo demonstra?**
A competição entre processos inconscientes pelo foco da consciência, conforme a Global Workspace Theory de Baars (1988).

**Os processadores têm papéis diferentes?**
Sim. Os processadores visuais (vermelho) e auditivos (azul) reagem a estímulos do mesmo tipo, gerando mensagens com urgência própria.

**Como exporto os resultados?**
O modelo não inclui integração com BehaviorSpace nesta versão. Para registro manual, use os plots e monitores da interface.

**O projeto está ativo?**
Não. O repositório está congelado e serve como base estável para estudos e referências.

**Posso contribuir?**
Sim. Faça um fork, implemente as melhorias da seção "Próximos Passos Planejados" e abra um pull request.

## Referências Teóricas

- **Baars, B. J. (1988).** *A Cognitive Theory of Consciousness*. Cambridge, MA: Cambridge University Press.

## Licença

MIT © 2025 José Augusto de Lima Prestes. Veja o arquivo [LICENSE](LICENSE).

## Citação

Se você usar este software em pesquisas, cite como:

```bibtex
@software{prestes_gwt_2025,
  author = {de Lima Prestes, José Augusto},
  title = {Global Workspace Theory (GWT) em NetLogo},
  year = {2025},
  url = {https://github.com/josealprestes/gwt_netlogo},
  note = {Desenvolvido no âmbito da disciplina IA006, Tópicos em Sistemas Inteligentes II, FEEC/Unicamp, 2S/2025.}
}
```

## Links

- **Site:** [joseprestes.com](https://joseprestes.com)
- **ORCID:** [0000-0001-8686-5360](https://orcid.org/0000-0001-8686-5360)
