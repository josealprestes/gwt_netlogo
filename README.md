# Global Workspace Theory (GWT) Simulation Model

> [!IMPORTANT]
> **Status do Projeto: CONGELADO**
> Este projeto está atualmente paralisado. A documentação abaixo reflete o estado atual e os próximos passos planejados para quando o desenvolvimento for retomado.

Este repositório contém uma simulação de um conceito de **Consciência Artificial** baseada na **Teoria do Espaço de Trabalho Global (Global Workspace Theory - GWT)**, proposta pelo neurocientista Bernard Baars.

A teoria sugere que a consciência funciona como um "teatro da mente", onde diversos processos inconscientes competem por um "foco de luz" (a consciência). Uma vez no foco, a informação é transmitida globalmente para todos os outros processos.

## 🚀 Estágio Atual de Desenvolvimento

O modelo está em uma fase **funcional simplificada**, implementado no NetLogo 6.4.0.

### Funcionalidades Implementadas:
- **Processadores Especializados**: Módulos visuais e auditivos que reagem a estímulos específicos.
- **Mecanismo de Competição**: Uso de `urgency` (urgência) para determinar qual processador ganha o foco.
- **Espaço de Trabalho Global (Global Workspace)**: Estrutura central que armazena e propaga a mensagem do processador vencedor.
- **Visualização Dinâmica**: Feedback visual em tempo real através de cores e links no NetLogo.
- **Interface de Controle**: Sliders para ajuste de frequência de estímulos, taxa de decaimento e limiar de urgência.

## 🛠️ Próximos Passos Planejados

Para evoluir a simulação além do estágio atual, os seguintes passos foram identificados:

1.  **Pensamentos Internos (Memória)**: Implementar um novo tipo de processador que gera picos de urgência espontâneos, simulando pensamentos que surgem sem estímulos externos.
2.  **Mecanismos de Inibição**: Adicionar lógica para que, quando um processador vença a competição, ele suprima temporariamente a urgência de outros, melhorando a estabilidade do foco.
3.  **Execução de Ações**: Fazer com que o agente do Espaço de Trabalho execute ações concretas (movimentação ou mudança de estado) baseadas na mensagem em foco.
4.  **Aprendizado**: Introduzir mecanismos onde a eficácia de um processador em ganhar o foco aumente com base no sucesso de ações passadas.

## 📖 Como Usar

1.  Abra o arquivo `gwt_netlogo.nlogo` no **NetLogo**.
2.  Clique no botão `Setup` para inicializar o ambiente.
3.  Clique no botão `Go` para iniciar a simulação.
4.  Ajuste os sliders na interface para observar como diferentes configurações afetam o "fluxo de consciência".

## 📚 Referências Teóricas

- **Autor**: José Augusto de Lima Prestes
- **Data**: Setembro de 2025
- **Referência Principal**: Baars, Bernard J. (1988). *A Cognitive Theory of Consciousness*. Cambridge, MA: Cambridge University Press.

---
*Este documento foi atualizado em Abril de 2026 para refletir o congelamento do projeto.*
