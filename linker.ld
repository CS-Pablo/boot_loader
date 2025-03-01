ENTRY(kernel_main)

SECTIONS {
    . = 1M; /* Charger à 1MB */
    .text : { *(.text) }
    .data : { *(.data) }
    .bss  : { *(.bss)  }
}
