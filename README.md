# Huawei Matebook D14 AMD (2020) OpenCore

OpenCore configuration bundle/package for running macOS on the Huawei Matebook D14 AMD (2020) (NBLK-WAX9X) laptop.

## Hardware Specs

| Component       | Details                                                |
| --------------: | :----------------------------------------------------- |
| CPU             | AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx          |
| GPU             | AMD Radeon Vega 8 (iGPU)                               |
| RAM             | Hynix 8GB DualChannel DDR4 (fixed, soldered)           |
| SSD/NVMe        | Samsung PM981 512GB (MZ-VLB5120)<br>(might have compatibility issues) |
| WiFi/BT         | Realtek RTL8822CE (M.2 PCIe A/E key) (**unsupported**) |
| Audio           | Realtek ALC256 (AppleALC layout ID 21)                 |
| Built-in camera | ov9734_azurewave_camera (UVC camera, no picture)       |
| Used SMBIOS     | MacBookPro16,3                                         |

## UEFI settings

No special configuration has to be made to the firmware settings of the device, besides that UEFI secure boot must be disabled.
Also no tampering with tools like Smokeless_UMAF (to turn off XHC0/1 devices as suggested at some places) is required, specifically
that is taken care of by the GUX-RyzenXHCFix Kext.

## Hardware modifications

### Replaced WiFi/BT module

Since the factory installed RTL8822CE M.2 PCIe module isn't supported at all by macOS or any third-party drivers (at least none is known),
it was replaced with an Intel AX210-based WiFi 6 160MHz + Bluetooth 5.3 module, which works absolutely well using the AirportItlwm drivers,
though continuity features are not supported (but not used or required at all).

### Replaced SSD

The Samsung PM981 512GB SSD was replaced by a WD_BLACK SN770 1TB, solely for the reason that the laptop runs a triple-boot setup
(Win11, Linux and now also macOS).

**NOTE**: There were at least two individual reports of issues with the stock Samsung SSD,
in that the macOS installation hangs and will ultimately fail, with NVMeFix not being of any help here. In this case, it's probably
the best to simply replace the stock SSD. Please consult ie. the NVMeFix documentation or all the various Hackintosh Forums and
Discords for advice on what works and what not.

## Compatibility

macOS Ventura (13.6) runs quite well on this machine (personally running this sort of as a daily driver), although NootedRed currently
exposes a few limits:

- Some OpenGL-heavy programs like the Chrome and Firefox browsers, or Sublime Text cause graphical corruption and even
  can cause the system to panic and reboot. There's an [open issue](https://github.com/ChefKissInc/NootedRed/issues/158) in the NootedRed
  project.
- Currently no hardware video acceleration ([project issue](https://github.com/ChefKissInc/NootedRed/issues/28))

macOS Sonoma (14.0) is unusable with NootedRed enabled. The system is highly unstable even running the first-time setup wizard, in that
it will either become very laggy and unresponsive and then panic+reboot, or just panic right away. The laptop works fine when NootedRed
is disabled, but of course without any graphics acceleration. This is discussed in the [NootedRed issue tracker](https://github.com/ChefKissInc/NootedRed/issues)
aswell.

macOS Monterey, Big Sur and Catalina are untested but might work when updated to their latest patch releases.

### Built-in Azurewave UVC camera

The built-in camera (installed into the keyboard between F6 and F7) is detected as a generic UVC camera device in macOS, but no picture
is displayed in Photobooth, and Facetime complains that the camera doesn't yield a picture. As there are other UVC cameras that don't
work too since Monterey (?), this is very likely a generic issue with the OS, no fix is known for this right now.

## Install and Use

**NOTE**: Since the machine is used in a triple-boot configuration, the first boot loader that is being loaded is GRUB from the Linux
installation, which has boot entries for the distro kernel (autogenerated using the scripts from the distro), the Windows boot manager
(BOOTMGFW.efi, added by the distro scripts aswell with the help of os-prober and the likes), and a static entry for chainloading
OpenCore.

If you opt to install this into your EFI, then either:

- make sure an UEFI boot entry is created pointing to /EFI/OC/OpenCore.efi which can then be started by the means of the device firmware
- make sure OpenCore.efi is added in whatever way to your existing boot loader configuration
- install /EFI/BOOT/BOOTX64.efi from the OpenCore distribution, which will then be started as the default boot option by the device firmware

**It is assumed that you are familar with the boot process of your device, so no further installation support is given! If you break your EFI/OS loader
or anything else boot-related and you are left with an unbootable machine, you are on your own, and you should be sure to know how to recover from such
situations!**

**NOTE**: No "Release" ZIPs will be provided, ever (as is the case with a ton of other prebuilt OpenCore repos). Either clone the repository
and install everything as needed, or download the repository ZIP and use it's content for the installation.

The repository/OpenCore config is "rolling", ie. when new OpenCore or Kext versions are released, they're pushed to the repository as needed.

### Complete SMBIOS information

Before proceeding trying to load macOS, be sure to fill in the system serial number et al. If in doubt, generate your SMBIOS data
using [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS) by [CorpNewt](https://github.com/corpnewt).

### macOS Installation

Prepare your bootable install media as usual, ie. using createinstallmedia from the "Install macOS.app".

Before booting the installer using this OpenCore configuration bundle, you might want to temporarily disable NootedRed as it might
cause the installer to hang during the pre-installation steps before the first-run wizard starts, and NootedRed being incompatible
with ie. early Ventura installer packages.

After installation, update to the latest patch version (ie. Ventura 13.6), then re-enable NootedRed.

## Credits / Thanks

Credits and thank you's for parts used throughout this OpenCore configuration bundle project:

- [Apple](https://www.apple.com) for macOS
- [Acidanthera](https://github.com/acidanthera) (and everyone involved and contributing) for
  - [OpenCore bootloader](https://github.com/acidanthera/OpenCorePkg)
  - [Lilu](https://github.com/acidanthera/Lilu) (System patcher platform Kext)
  - [VirtualSMC](https://github.com/acidanthera/VirtualSMC) (SMC emulator)
  - [AppleALC](https://github.com/acidanthera/AppleALC) (native macOS HD audio support for unsupported codecs)
  - [NVMeFix](https://github.com/acidanthera/NVMeFix) (improved compatibility for non-Apple SSDs)
  - [RestrictEvents](https://github.com/acidanthera/RestrictEvents) (unwanted process blocker and patcher)
  - [BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM) (BlueToolFixup)
  - [VoodooPS2](https://github.com/acidanthera/VoodooPS2) (PS2 input support)
  - [BrightnessKeys](https://github.com/acidanthera/BrightnessKeys) (handling of brightness keys)
- The [AMD-OSX](https://github.com/AMD-OSX) team and project for the macOS [AMD patches](https://github.com/AMD-OSX/AMD_Vanilla)
- [ChefKissInc](https://github.com/ChefKissInc) for
  - [NootedRed](https://github.com/ChefKissInc/NootedRed) (AMD iGPU support)
  - [RadeonSensor](https://github.com/ChefKissInc/RadeonSensor) (GPU sensors)
- [1Revenger1](https://github.com/1Revenger1) for [ECEnabler](https://github.com/1Revenger1/ECEnabler)
- [OpenIntelWireless](https://github.com/OpenIntelWireless) for [AirpotItlwm](https://github.com/OpenIntelWireless/itlwm) and [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware)
- [RattletraPM](https://github.com/RattletraPM) for [GUX-RyzenXHCIFix](https://github.com/RattletraPM/GUX-RyzenXHCIFix)
- The [VoodooI2C](https://github.com/VoodooI2C) team and project for [I2C (touchpad)](https://github.com/VoodooI2C/VoodooI2C) support
- The [USBToolBox](https://github.com/USBToolBox) team and project for a proper USB mapping
- [Lorys89](https://github.com/Lorys89) for the [SMCProcessorAMD](https://github.com/Lorys89/SMCProcessorAMD) VirtualSMC AMD CPU plugin
- [RehabMan](https://github.com/RehabMan) for [NullEthernet](https://github.com/RehabMan/OS-X-Null-Ethernet) (makes Apple services - ie. AppStore - work)
- [qhuyduong](https://github.com/qhuyduong) for the [AMD ZEN patched AppleALC](https://github.com/qhuyduong/AppleALC) (found via [adhocfra](https://github.com/adhocfra/HuaweiMatebookD14RyzenHackintosh)'s Matebook EFI)
- [Dortania](https://github.com/dortania) for all guides, SSDT patches and whatnot
- [CorpNewt](https://github.com/corpnewt) for all kinds of various (SSDT) helper tools like GenSMBIOS or SSDTTime

Currently unused but credited anyway of course:

- [trulyspinach](https://github.com/trulyspinach) for the [AMD Processor](https://github.com/trulyspinach/SMCAMDProcessor) Kexts
- [naveenkrdy](https://github.com/naveenkrdy) for [AmdTscSync](https://github.com/naveenkrdy/AmdTscSync)
- [chris1111](https://github.com/chris1111) for packaging up Realtek USB drivers (and lots of others) for macOS

And of course, thanks to everyone else not explicitly credited here whoever helped in getting macOS up and running on this laptop in whatever way!
