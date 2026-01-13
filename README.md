# KDT_Vivado

- FPGA Board: Zybo Z7-20

- configuration: Vivado 2020.2

- Used module
1. 7-Segment LED(x2),
2. keypad(0 ~ 9, A ~ F),
3. UART RX/TX module(include USB port)

---

- 2026-01-07 Wed
  - Digital Watch 1
  - 00:00 ~ 23:59(HH:MM) count up / every second
  - use 7-Segment LED(x2)

- 2026-01-08 Tur
  - Digital Watch 2
  - function of Digital Watch 1 + When I press the button, the time increases
  - use 7-Segment LED(x2)

- 2026-01-09 Fri
  - Calculator
  - N @ M = Y (N, M, Y: 0 ~ 99 / @: +, -, *)
  - use 7-Segment LED(x2), keypad

- 2026-01-12 Mon
  - FIR Filter(8-tap)
  - only simulation

- 2026-01-13 Tue
  - UART
  - use UART RX/TX module
