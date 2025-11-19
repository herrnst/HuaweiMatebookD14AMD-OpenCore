// SPDX-License-Identifier: GPL-2.0

/* SSDT-WIFI.dsl - ACPI device for the Matebook's PCIe WiFi card slot
 *
 * Adds an ACPI device for the M.2 PCIe WiFi card slot in the Huawei Matebook
 * D14 AMD (2020) laptop. Required to apply IOName spoofing in OpenCore for
 * the WiFi card slot to "trick" OCLP to apply the modern wireless root
 * patches. Only the actual ACPI device is added at the corresponding 
 * address, any patching/spoofing is to be done with OpenCore's
 * DeviceProperties config section.
 *
 */

DefinitionBlock("", "SSDT", 2, "nst", "WIFI", 0x00001000)
{
    External (\_SB.PCI0.GPP6, DeviceObj)

    Scope (\_SB.PCI0.GPP6)
    {
        Device (WIFI)
        {
            Name (_ADR, Zero)
        }
    }
}
