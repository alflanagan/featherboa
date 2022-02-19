"""
Useful global constants
"""
import board

__all__ = ["PIN_MAP", "NS_PER_SECOND"]

# feathers2 board pin map: (mostly for reference)
# pins in the same row are equivalent
PIN_MAP = [
    [board.A0, board.D14, board.DAC1, board.IO17],
    [board.A1, board.D15, board.DAC2, board.IO18],
    [board.A10, board.D5, board.IO1],
    [board.A2, board.D16, board.IO14],
    [board.A3, board.D17, board.IO12],
    [board.A4, board.D18, board.IO6],
    [board.A5, board.D19, board.IO5],
    [board.A6, board.D13, board.IO11],
    [board.A7, board.D12, board.IO10],
    [board.A8, board.D9, board.IO7],
    [board.A9, board.D6, board.IO3],
    [board.AMB, board.IO4],
    [board.APA102_MOSI],
    [board.APA102_SCK],
    [board.D0, board.IO44, board.RX],
    [board.D1, board.IO43, board.TX],
    [board.D10, board.IO8, board.SDA],
    [board.D11, board.IO9, board.SCL],
    [board.D20, board.IO33],
    [board.D21, board.IO38],
    [board.D23, board.IO37, board.MISO],
    [board.D24, board.IO35, board.MOSI],
    [board.D25, board.IO36, board.SCK],
    [board.D4, board.IO0],
    [board.IO21, board.LDO2],
    [board.LED],
]

NS_PER_SECOND = 1_000_000_000.0
