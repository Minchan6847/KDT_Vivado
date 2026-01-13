# KDT_Vivado

## 설계환경
- FPGA Board: Zybo Z7-20
- configuration: Vivado 2020.2
- Used module
  - 7-Segment LED(x2)
  - keypad(0 ~ 9, A ~ F)
  - UART RX/TX module(include USB port)

## 일자별 설계내용
### 2026-01-07 Wed.
- Digital Watch 1
  - 00:00 ~ 23:59(HH:MM) count up / every second
  - Use 7-Segment LED(x2)

### 2026-01-08 Thur.
- Digital Watch 2
  - [Function of Digital Watch 1] + [When I press the button, the time increases]
  - Use 7-Segment LED(x2)

### 2026-01-09 Fri.
- Calculator
  - N @ M = Y (N, M, Y: 0 ~ 99 / @: +, -, *)
  - Use 7-Segment LED(x2), keypad
  - Use ILA(Integrated Logic Analyzer) for debugging
  - Draw Timing Diagram(using WaveDrom)

### 2026-01-12 Mon.
- FIR Filter(8-tap)
  - Full Parallel Design
  - Use Baugh-Wooley Multiplier (WB bit signed)
  - Only simulation

### 2026-01-13 Tue.
- UART
  - Design TX, RX
  - Use UART RX/TX module

---

## For specific code descriptions, see Notability.
