.segment "HEADER"
  .byte "NES", $1a ; This is a NES rom!
  .byte $08 ; 8 * 16KB PRG ROM
  .byte $10 ; 16 * 8KB CHR ROM
  .byte %01000000 ; Mapper and mirroring
  .byte $00
  .byte $00
  .byte $00
  .byte $00
  .byte $00, $00, $00, $00, $00 ; Filler

.segment "ZEROPAGE"

.segment "STARTUP"
Reset:
  SEI ; Disable all interrupts during startup
  CLD ; Disable decimal mode as it is not supported by the NES

  ;; Disable Sound IRQ
  LDX #$40
  STX $4017

  ;; Mirroing
  LDX #$01
  STX $A000

  ;; Init stack register
  LDX #$FF
  TXS

  ;; Zero PPU registers
  INX ; X = #$00
  STX $2000
  STX $2001

  STX $4010

  JSR WaitForVBlank

  TXA
;; Clear memory by filling with 0, except for 200-2FF which will be
;; filled with FF as we will be copying the sprite data from there
ClearMemory:
  STA $0000, X
  STA $0100, X
  STA $0300, X
  STA $0400, X
  STA $0500, X
  STA $0600, X
  STA $0700, X
  LDA #$FF
  STA $0200, X
  LDA #$00
  INX
  BNE ClearMemory

  JSR WaitForVBlank

Loop:
  SpriteDMA:
    LDA #$02
    STA $4014

  JMP Loop

WaitForVBlank:
  BIT $2002
  BPL WaitForVBlank
  RTS

NMI:
  RTI

IRQ:
  RTI

.segment "VECTORS"
  .word NMI
  .word Reset
  .word IRQ

.segment "CHARS"

.segment "BANK0"

.segment "BANK1"

.segment "BANK2"

.segment "BANK3"

.segment "BANK4"

.segment "BANK5"

.segment "BANK6"

.segment "BANK7"

.segment "BANK8"

.segment "BANK9"

.segment "BANK10"

.segment "BANK11"

.segment "BANK12"
