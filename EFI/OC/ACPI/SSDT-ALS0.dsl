/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20221020 (64-bit version)
 * Copyright (c) 2000 - 2022 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-ALS0.aml, Mon Aug  7 16:01:24 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000084 (132)
 *     Revision         0x02
 *     Checksum         0xD9
 *     OEM ID           "ACDT"
 *     OEM Table ID     "ALS0"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "ALS0", 0x00000000)
{
    Scope (_SB)
    {
        Device (ALS0)
        {
            Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
            Name (_CID, "smc-als")  // _CID: Compatible ID
            Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
            Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
            {
                Package (0x02)
                {
                    0x64, 
                    0x012C
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
}

