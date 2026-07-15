#include <stdint.h>
#include "hal.h"
#include "drivers/mss_i2c/mss_i2c.h"
#include "drivers/mss_uart/mss_uart.h" // Added for UART initialization
#include "OV7725.h"                    // Matched case to reference code

#define BASE_ADDR_0             ((uint32_t)0x30000000U)
#define C_DOT_THRESH_ADDR       (BASE_ADDR_0 + 0x0FC) // Threshold register is at offset 0xFC (252)

void delay(volatile int n); // Marked volatile so compiler doesn't optimize it away
void uart_putc(char c);
void uart_puts(const char *s);
void uart_put_num(uint32_t n);

int main(void)
{
    uint32_t sum_x, sum_y, count;
    uint32_t centroid_x, centroid_y;

    /* Initialize UART0 with standard 115200 8N1 settings */
    MSS_UART_init(
        &g_mss_uart0,
        MSS_UART_115200_BAUD,
        MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT
    );

    uart_puts("\r\n--- Multi-Color & Multi-Dot Centroid Tracker Initializing ---\r\n");

    /* Initialize Camera Module via I2C */
    OV7725_init();
    uart_puts("Camera Initialized successfully.\r\n");

    /* Set background threshold for colored pixels in fabric (default 0xD0 = 208) */
    HW_set_32bit_reg(C_DOT_THRESH_ADDR, 0xD0);

    while (1)
    {
        int dot_found = 0;

        // Loop through all 8 grid cells (4x2 Grid)
        for (int i = 0; i < 8; i++) {
            uint32_t cell_addr = BASE_ADDR_0 + (i * 0x20);

            // Read pixel count for this cell
            count = HW_get_32bit_reg(cell_addr + 0x08);

            // If a significant number of pixels are detected, calculate centroid and color
            if (count > 20) {
                sum_x = HW_get_32bit_reg(cell_addr + 0x00);
                sum_y = HW_get_32bit_reg(cell_addr + 0x04);
                uint32_t sum_r = HW_get_32bit_reg(cell_addr + 0x0C);
                uint32_t sum_g = HW_get_32bit_reg(cell_addr + 0x10);
                uint32_t sum_b = HW_get_32bit_reg(cell_addr + 0x14);

                // Calculate centroid
                centroid_x = sum_x / count;
                centroid_y = sum_y / count;

                // Calculate average RGB channel values
                uint32_t avg_r = sum_r / count; // Range: 0 to 31
                uint32_t avg_g = sum_g / count; // Range: 0 to 63
                uint32_t avg_b = sum_b / count; // Range: 0 to 31

                // Classify color name based on channel relationships
                const char* color_name = "UNKNOWN";

                if (avg_r < 10 && avg_g < 20 && avg_b < 10) {
                    color_name = "BLACK";
                } else if (avg_r > (avg_g * 2 / 3) && avg_r > avg_b) {
                    // Check if it's yellow (both Red and Green channels are high)
                    if (avg_g > 30 && avg_r > 15) {
                        color_name = "YELLOW";
                    } else {
                        color_name = "RED";
                    }
                } else if (avg_g > (avg_r * 2) && avg_g > (avg_b * 2)) {
                    color_name = "GREEN";
                } else if (avg_b > avg_r && avg_b > (avg_g * 2 / 3)) {
                    color_name = "BLUE";
                } else {
                    color_name = "COLORED";
                }

                // Print cell identification and tracking statistics
                uart_puts("Dot in Cell ");
                uart_put_num(i);
                uart_puts(": Pos=(");
                uart_put_num(centroid_x);
                uart_puts(", ");
                uart_put_num(centroid_y);
                uart_puts("), Color=");
                uart_puts(color_name);
                uart_puts(" [RGB: (");
                uart_put_num(avg_r);
                uart_puts(", ");
                uart_put_num(avg_g);
                uart_puts(", ");
                uart_put_num(avg_b);
                uart_puts(")]\r\n");

                dot_found = 1;
            }
        }

        if (!dot_found) {
            uart_puts("No dots detected.\r\n");
        }

        delay(500000); // Delay between checks
    }
}

// Added volatile to prevent compiler from optimizing the loop away
void delay(volatile int n)
{
    while (n > 0) {
        n--;
    }
}

void uart_putc(char c)
{
    // Replaced bare-metal register access with the safer MSS driver equivalent
    MSS_UART_polled_tx(&g_mss_uart0, (const uint8_t*)&c, 1);
}

void uart_puts(const char *s)
{
    while (*s) {
        uart_putc(*s++);
    }
}

void uart_put_num(uint32_t n)
{
    char buf[16];
    int i = 0;
    if (n == 0) {
        uart_putc('0');
        return;
    }
    while (n > 0) {
        buf[i++] = (n % 10) + '0';
        n /= 10;
    }
    for (int j = i - 1; j >= 0; j--) {
        uart_putc(buf[j]);
    }
}
