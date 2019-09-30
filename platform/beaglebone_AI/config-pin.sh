#!/bin/dash

# Some important directories for use later
GPIODIR=/sys/class/gpio
BOARD="original"

disable_capemgr_load=$(grep -c bone_capemgr.uboot_capemgr_enabled=1 /proc/cmdline)
machine=$(sed "s/ /_/g;s/\o0//g" /proc/device-tree/model)
case "${machine}" in
TI_AM335x_BeagleBone_Blue)
	#overlays built-in, no slots file...
	OCPDIR=/sys/devices/platform/ocp/ocp*
	SLOTS=/sys/devices/platform/bone_capemgr/slots
	unset SLOTS_LOCATION
	;;
TI_AM335x_PocketBeagle)
	#overlays built-in, no slots file...
	OCPDIR=/sys/devices/platform/ocp/ocp*
	SLOTS=/sys/devices/platform/bone_capemgr/slots
	unset SLOTS_LOCATION
	BOARD="TI_AM335x_PocketBeagle"
	;;
*)
	#4.1.x where lots of things changed...
	#use the new location of bone_capemgr for detection..
	if [ -d /sys/devices/platform/bone_capemgr/ ] ; then
		OCPDIR=/sys/devices/platform/ocp/ocp*
		SLOTS=/sys/devices/platform/bone_capemgr/slots
		unset SLOTS_LOCATION
	else
		if [ ${disable_capemgr_load} -eq 1 ] ; then
			OCPDIR=/sys/devices/platform/ocp/ocp*
			SLOTS=/sys/devices/platform/bone_capemgr/slots
			unset SLOTS_LOCATION
		else
			OCPDIR=/sys/devices/ocp.*
			SLOTS=/sys/devices/bone_capemgr.*/slots
			SLOTS_LOCATION="old38kernel"
		fi
	fi
	;;
esac

# Create mappings between BeagleBone header pins and kernel gpio
# numbers.  These could be bash arrays or coded in python, but simple
# shell constructs are used so this code runs on a minimal system
# (including the BusyBox shell in an initrd, ash, and dash)

# PIN: function when no cape is loaded
# PINMUX: pin multiplexer functions when cape is loaded
# INFO: information to pin functions, starts with information for PIN and then PINMUX
# CAPE: cape that enables pinmuxing for specific pin, if no cape is set the pin is not modifyable
# GPIO: kernel GPIO pin number
# PRU: PRU pin number

if [ "x${BOARD}" = "xTI_AM335x_PocketBeagle" ] ; then
	#PocketBeagle
	P1_01_PIN="power"
	P1_01_INFO="VIN-AC"
	P1_01_CAPE=""

	P1_02_PRU="119"
	P1_02_GPIO="87"
	P1_02_PIN="gpio_input"
	P1_02_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P1_02_INFO="gpio2_23 default gpio2_23 gpio2_23 gpio2_23 gpio2_23 pru1_out9 pru1_in9"
	P1_02_CAPE=""

	P1_03_PIN="system"
	P1_03_INFO="usb1_vbus_out"
	P1_03_CAPE=""

	P1_04_PRU="121"
	P1_04_GPIO="89"
	P1_04_PIN="gpio"
	P1_04_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P1_04_INFO="gpio2_25 default gpio2_25 gpio2_25 gpio2_25 gpio2_25 pru1_out11 pru1_in11"
	P1_04_CAPE=""

	P1_05_PIN="system"
	P1_05_INFO="usb1_vbus_in"
	P1_05_CAPE=""

	P1_06_PRU="37"
	P1_06_GPIO="5"
	P1_06_PIN="spi_cs"
	P1_06_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs i2c pwm pru_uart"
	P1_06_INFO="spi0_cs0 default gpio0_5 gpio0_5 gpio0_5 gpio0_5 spi0_cs0 i2c1_scl ehrpwm0_synci pru_uart"
	P1_06_CAPE=""

	P1_07_PIN="system"
	P1_07_INFO="VIN-USB"
	P1_07_CAPE=""

	P1_08_PRU="34"
	P1_08_GPIO="2"
	P1_08_PIN="spi_sclk"
	P1_08_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_sclk uart i2c pwm pru_uart"
	P1_08_INFO="spi0_sclk default gpio0_2 gpio0_2 gpio0_2 gpio0_2 spi0_sclk uart2_rxd i2c2_sda ehrpwm0a pru_uart"
	P1_08_CAPE=""

	P1_09_PIN="system"
	P1_09_INFO="USB1-DN"
	P1_09_CAPE=""

	P1_10_PRU="35"
	P1_10_GPIO="3"
	P1_10_PIN="spi"
	P1_10_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi uart i2c pwm pru_uart"
	P1_10_INFO="spi0_d0 default gpio0_3 gpio0_3 gpio0_3 gpio0_3 spi0_d0 uart2_txd i2c2_scl ehrpwm0b pru_uart"
	P1_10_CAPE=""

	P1_11_PIN="system"
	P1_11_INFO="USB1-DP"
	P1_11_CAPE=""

	P1_12_PRU="36"
	P1_12_GPIO="4"
	P1_12_PIN="spi"
	P1_12_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi i2c pwm pru_uart"
	P1_12_INFO="spi0_d1 default gpio0_4 gpio0_4 gpio0_4 gpio0_4 spi0_d1 i2c1_sda ehrpwm0_tripzone_input pru_uart"
	P1_12_CAPE=""

	P1_13_PIN="system"
	P1_13_INFO="USB1-ID"
	P1_13_CAPE=""

	P1_14_PIN="power"
	P1_14_INFO="VOUT-3.3V"
	P1_14_CAPE=""

	P1_15_PIN="gnd"
	P1_15_INFO="GND"
	P1_15_CAPE=""

	P1_16_PIN="gnd"
	P1_16_INFO="GND"
	P1_16_CAPE=""

	P1_17_PIN="power"
	P1_17_INFO="VREFN"
	P1_17_CAPE=""

	P1_18_PIN="power"
	P1_18_INFO="VREFP"
	P1_18_CAPE=""

	P1_19_PIN="adc"
	P1_19_INFO="AIN0"
	P1_19_CAPE=""

	P1_20_PRU="52"
	P1_20_GPIO="20"
	P1_20_PIN="gpio"
	P1_20_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruin"
	P1_20_INFO="gpio0_20 default gpio0_20 gpio0_20 gpio0_20 gpio0_20 pru0_in16"
	P1_20_CAPE=""

	P1_21_PIN="adc"
	P1_21_INFO="AIN1"
	P1_21_CAPE=""

	P1_22_PIN="gnd"
	P1_22_INFO="GND"
	P1_22_CAPE=""

	P1_23_PIN="adc"
	P1_23_INFO="AIN2"
	P1_23_CAPE=""

	P1_24_PIN="power"
	P1_24_INFO="VOUT-5V"
	P1_24_CAPE=""

	P1_25_PIN="adc"
	P1_25_INFO="AIN3"
	P1_25_CAPE=""

	P1_26_PRU="44"
	P1_26_GPIO="12"
	P1_26_PIN="i2c"
	P1_26_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs can i2c pru_uart"
	P1_26_INFO="i2c2_sda default gpio0_12 gpio0_12 gpio0_12 gpio0_12 spi1_cs0 dcan0_tx i2c2_sda pru_uart"
	P1_26_CAPE=""

	P1_27_PIN="adc"
	P1_27_INFO="AIN4"
	P1_27_CAPE=""

	P1_28_PRU="45"
	P1_28_GPIO="13"
	P1_28_PIN="i2c"
	P1_28_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs can i2c pru_uart"
	P1_28_INFO="i2c2_scl default gpio0_13 gpio0_13 gpio0_13 gpio0_13 spi1_cs1 dcan0_rx i2c2_scl pru_uart"
	P1_28_CAPE=""

	P1_29_PRU="149"
	P1_29_GPIO="117"
	P1_29_PIN="pruin"
	P1_29_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P1_29_INFO="pru0_in7 default gpio3_21 gpio3_21 gpio3_21 gpio3_21 eqep0_strobe pru0_out7 pru0_in7"
	P1_29_CAPE=""

	P1_30_PRU="75"
	P1_30_GPIO="43"
	P1_30_PIN="uart"
	P1_30_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs uart can i2c pruout pruin"
	P1_30_INFO="uart0_txd default gpio1_11 gpio1_11 gpio1_11 gpio1_11 spi1_cs1 uart0_txd dcan0_rx i2c2_scl pru1_out15 pru1_in15"
	P1_30_CAPE=""

	P1_31_PRU="146"
	P1_31_GPIO="114"
	P1_31_PIN="pruin"
	P1_31_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P1_31_INFO="pru0_in4 default gpio3_18 gpio3_18 gpio3_18 gpio3_18 eqep0a_in pru0_out4 pru0_in4"
	P1_31_CAPE=""

	P1_32_PRU="74"
	P1_32_GPIO="42"
	P1_32_PIN="uart"
	P1_32_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs uart can i2c pruout pruin"
	P1_32_INFO="uart0_rxd default gpio1_10 gpio1_10 gpio1_10 gpio1_10 spi1_cs0 uart0_rxd dcan0_tx i2c2_sda pru1_out14 pru1_in14"
	P1_32_CAPE=""

	P1_33_PRU="143"
	P1_33_GPIO="111"
	P1_33_PIN="pruin"
	P1_33_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi pwm pruout pruin"
	P1_33_INFO="pru0_in1 default gpio3_15 gpio3_15 gpio3_15 gpio3_15 spi1_d0 ehrpwm0b pru0_out1 pru0_in1"
	P1_33_CAPE=""

	P1_34_PRU="58"
	P1_34_GPIO="26"
	P1_34_PIN="gpio"
	P1_34_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P1_34_INFO="gpio0_26 default gpio0_26 gpio0_26 gpio0_26 gpio0_26 ehrpwm2_tripzone_input"
	P1_34_CAPE=""

	P1_35_PRU="120"
	P1_35_GPIO="88"
	P1_35_PIN="pruin"
	P1_35_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P1_35_INFO="pru1_in10 default gpio2_24 gpio2_24 gpio2_24 gpio2_24 pru1_out10 pru1_in10"
	P1_35_CAPE=""

	P1_36_PRU="142"
	P1_36_GPIO="110"
	P1_36_PIN="pwm"
	P1_36_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_sclk pwm pruout pruin"
	P1_36_INFO="ehrpwm0a default gpio3_14 gpio3_14 gpio3_14 gpio3_14 spi1_sclk ehrpwm0a pru0_out0 pru0_in0"
	P1_36_CAPE=""

	P2_01_PRU="82"
	P2_01_GPIO="50"
	P2_01_PIN="pwm"
	P2_01_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P2_01_INFO="ehrpwm1a default gpio1_18 gpio1_18 gpio1_18 gpio1_18 ehrpwm1a"
	P2_01_CAPE=""

	P2_02_PRU="91"
	P2_02_GPIO="59"
	P2_02_PIN="gpio"
	P2_02_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P2_02_INFO="gpio1_27 default gpio1_27 gpio1_27 gpio1_27 gpio1_27"
	P2_02_CAPE=""

	P2_03_PRU="55"
	P2_03_GPIO="23"
	P2_03_PIN="gpio"
	P2_03_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P2_03_INFO="gpio0_23 default gpio0_23 gpio0_23 gpio0_23 gpio0_23 ehrpwm2b"
	P2_03_CAPE=""

	P2_04_PRU="90"
	P2_04_GPIO="58"
	P2_04_PIN="gpio"
	P2_04_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P2_04_INFO="gpio1_26 default gpio1_26 gpio1_26 gpio1_26 gpio1_26"
	P2_04_CAPE=""

	P2_05_PRU="62"
	P2_05_GPIO="30"
	P2_05_PIN="uart"
	P2_05_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart"
	P2_05_INFO="uart4_rxd default gpio0_30 gpio0_30 gpio0_30 gpio0_30 uart4_rxd"
	P2_05_CAPE=""

	P2_06_PRU="89"
	P2_06_GPIO="57"
	P2_06_PIN="gpio"
	P2_06_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P2_06_INFO="gpio1_25 default gpio1_25 gpio1_25 gpio1_25 gpio1_25"
	P2_06_CAPE=""

	P2_07_PRU="63"
	P2_07_GPIO="31"
	P2_07_PIN="uart"
	P2_07_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart"
	P2_07_INFO="uart4_txd default gpio0_31 gpio0_31 gpio0_31 gpio0_31 uart4_txd"
	P2_07_CAPE=""

	P2_08_PRU="92"
	P2_08_GPIO="60"
	P2_08_PIN="gpio"
	P2_08_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P2_08_INFO="gpio1_28 default gpio1_28 gpio1_28 gpio1_28 gpio1_28"
	P2_08_CAPE=""

	P2_09_PRU="47"
	P2_09_GPIO="15"
	P2_09_PIN="i2c"
	P2_09_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart can i2c pru_uart pruin"
	P2_09_INFO="i2c1_scl default gpio0_15 gpio0_15 gpio0_15 gpio0_15 uart1_txd dcan1_rx i2c1_scl pru_uart pru0_in16"
	P2_09_CAPE=""

	P2_10_PRU="84"
	P2_10_GPIO="52"
	P2_10_PIN="gpio"
	P2_10_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep"
	P2_10_INFO="gpio1_20 default gpio1_20 gpio1_20 gpio1_20 gpio1_20 eqep1a_in"
	P2_10_CAPE=""

	P2_11_PRU="46"
	P2_11_GPIO="14"
	P2_11_PIN="i2c"
	P2_11_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart can i2c pru_uart pruin"
	P2_11_INFO="i2c1_sda default gpio0_14 gpio0_14 gpio0_14 gpio0_14 uart1_rxd dcan1_tx i2c1_sda pru_uart pru1_in16"
	P2_11_CAPE=""

	P2_12_PIN="system"
	P2_12_INFO="POWER_BUTTON"
	P2_12_CAPE=""

	P2_13_PIN="power"
	P2_13_INFO="VOUT-5V"
	P2_13_CAPE=""

	P2_14_PIN="power"
	P2_14_INFO="BAT-VIN"
	P2_14_CAPE=""

	P2_15_PIN="gnd"
	P2_15_INFO="GND"
	P2_15_CAPE=""

	P2_16_PIN="power"
	P2_16_INFO="BAT-TEMP"
	P2_16_CAPE=""

	P2_17_PRU="97"
	P2_17_GPIO="65"
	P2_17_PIN="gpio"
	P2_17_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P2_17_INFO="gpio2_1 default gpio2_1 gpio2_1 gpio2_1 gpio2_1"
	P2_17_CAPE=""

	P2_18_PRU="79"
	P2_18_GPIO="47"
	P2_18_PIN="gpio"
	P2_18_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pru_ecap pruin"
	P2_18_INFO="gpio1_15 default gpio1_15 gpio1_15 gpio1_15 gpio1_15 eqep2_strobe pru_ecap pru0_in15"
	P2_18_CAPE=""

	P2_19_PRU="59"
	P2_19_GPIO="27"
	P2_19_PIN="gpio"
	P2_19_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P2_19_INFO="gpio0_27 default gpio0_27 gpio0_27 gpio0_27 gpio0_27 ehrpwm0_synco"
	P2_19_CAPE=""

	P2_20_PRU="96"
	P2_20_GPIO="64"
	P2_20_PIN="gpio"
	P2_20_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P2_20_INFO="gpio2_0 default gpio2_0 gpio2_0 gpio2_0 gpio2_0"
	P2_20_CAPE=""

	P2_21_PIN="gnd"
	P2_21_INFO="GND"
	P2_21_CAPE=""

	P2_22_PRU="78"
	P2_22_GPIO="46"
	P2_22_PIN="gpio"
	P2_22_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruin"
	P2_22_INFO="gpio1_14 default gpio1_14 gpio1_14 gpio1_14 gpio1_14 eqep2_index pru0_in14"
	P2_22_CAPE=""

	P2_23_PIN="power"
	P2_23_INFO="VOUT-3.3V"
	P2_23_CAPE=""

	P2_24_PRU="76"
	P2_24_GPIO="44"
	P2_24_PIN="gpio"
	P2_24_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout"
	P2_24_INFO="gpio1_12 default gpio1_12 gpio1_12 gpio1_12 gpio1_12 eqep2a_in pru0_out14"
	P2_24_CAPE=""

	P2_25_PRU="73"
	P2_25_GPIO="41"
	P2_25_PIN="spi"
	P2_25_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi spi_cs uart can i2c"
	P2_25_INFO="spi1_d1 default gpio1_9 gpio1_9 gpio1_9 gpio1_9 spi1_d1 spi1_cs0 uart4_txd dcan1_rx i2c1_scl"
	P2_25_CAPE=""

	P2_26_PIN="system"
	P2_26_INFO="RESET#"
	P2_26_CAPE=""

	P2_27_PRU="72"
	P2_27_GPIO="40"
	P2_27_PIN="spi"
	P2_27_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi uart can i2c"
	P2_27_INFO="spi1_d0 default gpio1_8 gpio1_8 gpio1_8 gpio1_8 spi1_d0 uart4_rxd dcan1_tx i2c1_sda"
	P2_27_CAPE=""

	P2_28_PRU="148"
	P2_28_GPIO="116"
	P2_28_PIN="pruin"
	P2_28_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P2_28_INFO="pru0_in6 default gpio3_20 gpio3_20 gpio3_20 gpio3_20 eqep0_index pru0_out6 pru0_in6"
	P2_28_CAPE=""

	P2_29_PRU="39"
	P2_29_GPIO="7"
	P2_29_PIN="spi_sclk"
	P2_29_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs spi_sclk uart pwm pru_ecap"
	P2_29_INFO="spi1_sclk default gpio0_7 gpio0_7 gpio0_7 gpio0_7 spi1_cs1 spi1_sclk uart3_txd ecap0_in_pwm0_out pru_ecap"
	P2_29_CAPE=""

	P2_30_PRU="145"
	P2_30_GPIO="113"
	P2_30_PIN="pruin"
	P2_30_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs pwm pruout pruin"
	P2_30_INFO="pru0_in3 default gpio3_17 gpio3_17 gpio3_17 gpio3_17 spi1_cs0 ehrpwm0_synci pru0_out3 pru0_in3"
	P2_30_CAPE=""

	P2_31_PRU="51"
	P2_31_GPIO="19"
	P2_31_PIN="spi_cs"
	P2_31_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs pruin"
	P2_31_INFO="spi1_cs1 default gpio0_19 gpio0_19 gpio0_19 gpio0_19 spi1_cs1 pru1_in16"
	P2_31_CAPE=""

	P2_32_PRU="144"
	P2_32_GPIO="112"
	P2_32_PIN="pruin"
	P2_32_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi pwm pruout pruin"
	P2_32_INFO="pru0_in2 default gpio3_16 gpio3_16 gpio3_16 gpio3_16 spi1_d1 ehrpwm0_tripzone_input pru0_out2 pru0_in2"
	P2_32_CAPE=""

	P2_33_PRU="77"
	P2_33_GPIO="45"
	P2_33_PIN="gpio"
	P2_33_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout"
	P2_33_INFO="gpio1_13 default gpio1_13 gpio1_13 gpio1_13 gpio1_13 eqep2b_in pru0_out15"
	P2_33_CAPE=""

	P2_34_PRU="147"
	P2_34_GPIO="115"
	P2_34_PIN="pruin"
	P2_34_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P2_34_INFO="pru0_in5 default gpio3_19 gpio3_19 gpio3_19 gpio3_19 eqep0b_in pru0_out5 pru0_in5"
	P2_34_CAPE=""

	P2_35_PRU="118"
	P2_35_GPIO="86"
	P2_35_PIN="gpio_input"
	P2_35_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P2_35_INFO="gpio2_22 default gpio2_22 gpio2_22 gpio2_22 gpio2_22 pru1_out8 pru1_in8"
	P2_35_CAPE=""

	P2_36_PIN="adc"
	P2_36_INFO="AIN7"
	P2_36_CAPE=""

else
	P8_01_PIN="gnd"
	P8_01_INFO="GND"
	P8_01_CAPE=""

	P8_02_PIN="gnd"
	P8_02_INFO="GND"
	P8_02_CAPE=""

	P8_03_PRU="70"
	P8_03_GPIO="38"
	P8_03_PIN="emmc"
	P8_03_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_03_INFO="gpio1_6 default gpio1_6 gpio1_6 gpio1_6 gpio1_6"
	P8_03_CAPE=""

	P8_04_PRU="71"
	P8_04_GPIO="39"
	P8_04_PIN="emmc"
	P8_04_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_04_INFO="gpio1_7 default gpio1_7 gpio1_7 gpio1_7 gpio1_7"
	P8_04_CAPE=""

	P8_05_PRU="66"
	P8_05_GPIO="34"
	P8_05_PIN="emmc"
	P8_05_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_05_INFO="gpio1_2 default gpio1_2 gpio1_2 gpio1_2 gpio1_2"
	P8_05_CAPE=""

	P8_06_PRU="67"
	P8_06_GPIO="35"
	P8_06_PIN="emmc"
	P8_06_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_06_INFO="gpio1_3 default gpio1_3 gpio1_3 gpio1_3 gpio1_3"
	P8_06_CAPE=""

	P8_07_PRU="98"
	P8_07_GPIO="66"
	P8_07_PIN="gpio"
	P8_07_PINMUX="default gpio gpio_pu gpio_pd gpio_input timer"
	P8_07_INFO="gpio2_2 default gpio2_2 gpio2_2 gpio2_2 gpio2_2 timer4"
	P8_07_CAPE=""

	P8_08_PRU="99"
	P8_08_GPIO="67"
	P8_08_PIN="gpio"
	P8_08_PINMUX="default gpio gpio_pu gpio_pd gpio_input timer"
	P8_08_INFO="gpio2_3 default gpio2_3 gpio2_3 gpio2_3 gpio2_3 timer7"
	P8_08_CAPE=""

	P8_09_PRU="101"
	P8_09_GPIO="69"
	P8_09_PIN="gpio"
	P8_09_PINMUX="default gpio gpio_pu gpio_pd gpio_input timer"
	P8_09_INFO="gpio2_5 default gpio2_5 gpio2_5 gpio2_5 gpio2_5 timer5"
	P8_09_CAPE=""

	P8_10_PRU="100"
	P8_10_GPIO="68"
	P8_10_PIN="gpio"
	P8_10_PINMUX="default gpio gpio_pu gpio_pd gpio_input timer"
	P8_10_INFO="gpio2_4 default gpio2_4 gpio2_4 gpio2_4 gpio2_4 timer6"
	P8_10_CAPE=""

	P8_11_PRU="77"
	P8_11_GPIO="45"
	P8_11_PIN="gpio"
	P8_11_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout"
	P8_11_INFO="gpio1_13 default gpio1_13 gpio1_13 gpio1_13 gpio1_13 eqep2b_in pru0_out15"
	P8_11_CAPE=""

	P8_12_PRU="76"
	P8_12_GPIO="44"
	P8_12_PIN="gpio"
	P8_12_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout"
	P8_12_INFO="gpio1_12 default gpio1_12 gpio1_12 gpio1_12 gpio1_12 eqep2a_in pru0_out14"
	P8_12_CAPE=""

	P8_13_PRU="55"
	P8_13_GPIO="23"
	P8_13_PIN="gpio"
	P8_13_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P8_13_INFO="gpio0_23 default gpio0_23 gpio0_23 gpio0_23 gpio0_23 ehrpwm2b"
	P8_13_CAPE=""

	P8_14_PRU="58"
	P8_14_GPIO="26"
	P8_14_PIN="gpio"
	P8_14_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P8_14_INFO="gpio0_26 default gpio0_26 gpio0_26 gpio0_26 gpio0_26 ehrpwm2_tripzone_input"
	P8_14_CAPE=""

	P8_15_PRU="79"
	P8_15_GPIO="47"
	P8_15_PIN="gpio"
	P8_15_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pru_ecap pruin"
	P8_15_INFO="gpio1_15 default gpio1_15 gpio1_15 gpio1_15 gpio1_15 eqep2_strobe pru_ecap pru0_in15"
	P8_15_CAPE=""

	P8_16_PRU="78"
	P8_16_GPIO="46"
	P8_16_PIN="gpio"
	P8_16_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruin"
	P8_16_INFO="gpio1_14 default gpio1_14 gpio1_14 gpio1_14 gpio1_14 eqep2_index pru0_in14"
	P8_16_CAPE=""

	P8_17_PRU="59"
	P8_17_GPIO="27"
	P8_17_PIN="gpio"
	P8_17_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P8_17_INFO="gpio0_27 default gpio0_27 gpio0_27 gpio0_27 gpio0_27 ehrpwm0_synco"
	P8_17_CAPE=""

	P8_18_PRU="97"
	P8_18_GPIO="65"
	P8_18_PIN="gpio"
	P8_18_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_18_INFO="gpio2_1 default gpio2_1 gpio2_1 gpio2_1 gpio2_1"
	P8_18_CAPE=""

	P8_19_PRU="54"
	P8_19_GPIO="22"
	P8_19_PIN="gpio"
	P8_19_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P8_19_INFO="gpio0_22 default gpio0_22 gpio0_22 gpio0_22 gpio0_22 ehrpwm2a"
	P8_19_CAPE=""

	P8_20_PRU="95"
	P8_20_GPIO="63"
	P8_20_PIN="emmc"
	P8_20_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P8_20_INFO="gpio1_31 default gpio1_31 gpio1_31 gpio1_31 gpio1_31 pru1_out13 pru1_in13"
	P8_20_CAPE=""

	P8_21_PRU="94"
	P8_21_GPIO="62"
	P8_21_PIN="emmc"
	P8_21_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P8_21_INFO="gpio1_30 default gpio1_30 gpio1_30 gpio1_30 gpio1_30 pru1_out12 pru1_in12"
	P8_21_CAPE=""

	P8_22_PRU="69"
	P8_22_GPIO="37"
	P8_22_PIN="emmc"
	P8_22_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_22_INFO="gpio1_5 default gpio1_5 gpio1_5 gpio1_5 gpio1_5"
	P8_22_CAPE=""

	P8_23_PRU="68"
	P8_23_GPIO="36"
	P8_23_PIN="emmc"
	P8_23_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_23_INFO="gpio1_4 default gpio1_4 gpio1_4 gpio1_4 gpio1_4"
	P8_23_CAPE=""

	P8_24_PRU="65"
	P8_24_GPIO="33"
	P8_24_PIN="emmc"
	P8_24_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_24_INFO="gpio1_1 default gpio1_1 gpio1_1 gpio1_1 gpio1_1"
	P8_24_CAPE=""

	P8_25_PRU="64"
	P8_25_GPIO="32"
	P8_25_PIN="emmc"
	P8_25_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_25_INFO="gpio1_0 default gpio1_0 gpio1_0 gpio1_0 gpio1_0"
	P8_25_CAPE=""

	P8_26_PRU="93"
	P8_26_GPIO="61"
	P8_26_PIN="gpio"
	P8_26_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P8_26_INFO="gpio1_29 default gpio1_29 gpio1_29 gpio1_29 gpio1_29"
	P8_26_CAPE=""

	P8_27_PRU="118"
	P8_27_GPIO="86"
	P8_27_PIN="hdmi"
	P8_27_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P8_27_INFO="gpio2_22 default gpio2_22 gpio2_22 gpio2_22 gpio2_22 pru1_out8 pru1_in8"
	P8_27_CAPE=""

	P8_28_PRU="120"
	P8_28_GPIO="88"
	P8_28_PIN="hdmi"
	P8_28_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P8_28_INFO="gpio2_24 default gpio2_24 gpio2_24 gpio2_24 gpio2_24 pru1_out10 pru1_in10"
	P8_28_CAPE=""

	P8_29_PRU="119"
	P8_29_GPIO="87"
	P8_29_PIN="hdmi"
	P8_29_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P8_29_INFO="gpio2_23 default gpio2_23 gpio2_23 gpio2_23 gpio2_23 pru1_out9 pru1_in9"
	P8_29_CAPE=""

	P8_30_PRU="121"
	P8_30_GPIO="89"
	P8_30_PIN="hdmi"
	P8_30_PINMUX="default gpio gpio_pu gpio_pd gpio_input pruout pruin"
	P8_30_INFO="gpio2_25 default gpio2_25 gpio2_25 gpio2_25 gpio2_25 pru1_out11 pru1_in11"
	P8_30_CAPE=""

	P8_31_PRU="42"
	P8_31_GPIO="10"
	P8_31_PIN="hdmi"
	P8_31_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart qep"
	P8_31_INFO="gpio0_10 default gpio0_10 gpio0_10 gpio0_10 gpio0_10 uart5_rxd eqep1_index"
	P8_31_CAPE=""

	P8_32_PRU="43"
	P8_32_GPIO="11"
	P8_32_PIN="hdmi"
	P8_32_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep"
	P8_32_INFO="gpio0_11 default gpio0_11 gpio0_11 gpio0_11 gpio0_11 eqep1_strobe"
	P8_32_CAPE=""

	P8_33_PRU="41"
	P8_33_GPIO="9"
	P8_33_PIN="hdmi"
	P8_33_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep"
	P8_33_INFO="gpio0_9 default gpio0_9 gpio0_9 gpio0_9 gpio0_9 eqep1b_in"
	P8_33_CAPE=""

	P8_34_PRU="113"
	P8_34_GPIO="81"
	P8_34_PIN="hdmi"
	P8_34_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P8_34_INFO="gpio2_17 default gpio2_17 gpio2_17 gpio2_17 gpio2_17 ehrpwm1b"
	P8_34_CAPE=""

	P8_35_PRU="40"
	P8_35_GPIO="8"
	P8_35_PIN="hdmi"
	P8_35_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep"
	P8_35_INFO="gpio0_8 default gpio0_8 gpio0_8 gpio0_8 gpio0_8 eqep1a_in"
	P8_35_CAPE=""

	P8_36_PRU="112"
	P8_36_GPIO="80"
	P8_36_PIN="hdmi"
	P8_36_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P8_36_INFO="gpio2_16 default gpio2_16 gpio2_16 gpio2_16 gpio2_16 ehrpwm1a"
	P8_36_CAPE=""

	P8_37_PRU="110"
	P8_37_GPIO="78"
	P8_37_PIN="hdmi"
	P8_37_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart pwm"
	P8_37_INFO="gpio2_14 default gpio2_14 gpio2_14 gpio2_14 gpio2_14 uart5_txd ehrpwm1_tripzone_input"
	P8_37_CAPE=""

	P8_38_PRU="111"
	P8_38_GPIO="79"
	P8_38_PIN="hdmi"
	P8_38_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart pwm"
	P8_38_INFO="gpio2_15 default gpio2_15 gpio2_15 gpio2_15 gpio2_15 uart5_rxd ehrpwm0_synco"
	P8_38_CAPE=""

	P8_39_PRU="108"
	P8_39_GPIO="76"
	P8_39_PIN="hdmi"
	P8_39_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P8_39_INFO="gpio2_12 default gpio2_12 gpio2_12 gpio2_12 gpio2_12 eqep2_index pru1_out6 pru1_in6"
	P8_39_CAPE=""

	P8_40_PRU="109"
	P8_40_GPIO="77"
	P8_40_PIN="hdmi"
	P8_40_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P8_40_INFO="gpio2_13 default gpio2_13 gpio2_13 gpio2_13 gpio2_13 eqep2_strobe pru1_out7 pru1_in7"
	P8_40_CAPE=""

	P8_41_PRU="106"
	P8_41_GPIO="74"
	P8_41_PIN="hdmi"
	P8_41_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P8_41_INFO="gpio2_10 default gpio2_10 gpio2_10 gpio2_10 gpio2_10 eqep2a_in pru1_out4 pru1_in4"
	P8_41_CAPE=""

	P8_42_PRU="107"
	P8_42_GPIO="75"
	P8_42_PIN="hdmi"
	P8_42_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P8_42_INFO="gpio2_11 default gpio2_11 gpio2_11 gpio2_11 gpio2_11 eqep2b_in pru1_out5 pru1_in5"
	P8_42_CAPE=""

	P8_43_PRU="104"
	P8_43_GPIO="72"
	P8_43_PIN="hdmi"
	P8_43_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm pruout pruin"
	P8_43_INFO="gpio2_8 default gpio2_8 gpio2_8 gpio2_8 gpio2_8 ehrpwm2_tripzone_input pru1_out2 pru1_in2"
	P8_43_CAPE=""

	P8_44_PRU="105"
	P8_44_GPIO="73"
	P8_44_PIN="hdmi"
	P8_44_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm pruout pruin"
	P8_44_INFO="gpio2_9 default gpio2_9 gpio2_9 gpio2_9 gpio2_9 ehrpwm0_synco pru1_out3 pru1_in3"
	P8_44_CAPE=""

	P8_45_PRU="102"
	P8_45_GPIO="70"
	P8_45_PIN="hdmi"
	P8_45_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm pruout pruin"
	P8_45_INFO="gpio2_6 default gpio2_6 gpio2_6 gpio2_6 gpio2_6 ehrpwm2a pru1_out0 pru1_in0"
	P8_45_CAPE=""

	P8_46_PRU="103"
	P8_46_GPIO="71"
	P8_46_PIN="hdmi"
	P8_46_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm pruout pruin"
	P8_46_INFO="gpio2_7 default gpio2_7 gpio2_7 gpio2_7 gpio2_7 ehrpwm2b pru1_out1 pru1_in1"
	P8_46_CAPE=""

	P9_01_PIN="gnd"
	P9_01_INFO="GND"
	P9_01_CAPE=""

	P9_02_PIN="gnd"
	P9_02_INFO="GND"
	P9_02_CAPE=""

	P9_03_PIN="power"
	P9_03_INFO="3V3"
	P9_03_CAPE=""

	P9_04_PIN="power"
	P9_04_INFO="3V3"
	P9_04_CAPE=""

	P9_05_PIN="power"
	P9_05_INFO="VDD_5V"
	P9_05_CAPE=""

	P9_06_PIN="power"
	P9_06_INFO="VDD_5V"
	P9_06_CAPE=""

	P9_07_PIN="power"
	P9_07_INFO="SYS_5V"
	P9_07_CAPE=""

	P9_08_PIN="power"
	P9_08_INFO="SYS_5V"
	P9_08_CAPE=""

	P9_09_PIN="system"
	P9_09_INFO="PWR_BUT"
	P9_09_CAPE=""

	P9_10_PIN="system"
	P9_10_INFO="RSTn"
	P9_10_CAPE=""

	P9_11_PRU="62"
	P9_11_GPIO="30"
	P9_11_PIN="gpio"
	P9_11_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart"
	P9_11_INFO="gpio0_30 default gpio0_30 gpio0_30 gpio0_30 gpio0_30 uart4_rxd"
	P9_11_CAPE=""

	P9_12_PRU="92"
	P9_12_GPIO="60"
	P9_12_PIN="gpio"
	P9_12_PINMUX="default gpio gpio_pu gpio_pd gpio_input"
	P9_12_INFO="gpio1_28 default gpio1_28 gpio1_28 gpio1_28 gpio1_28"
	P9_12_CAPE=""

	P9_13_PRU="63"
	P9_13_GPIO="31"
	P9_13_PIN="gpio"
	P9_13_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart"
	P9_13_INFO="gpio0_31 default gpio0_31 gpio0_31 gpio0_31 gpio0_31 uart4_txd"
	P9_13_CAPE=""

	P9_14_PRU="82"
	P9_14_GPIO="50"
	P9_14_PIN="gpio"
	P9_14_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P9_14_INFO="gpio1_18 default gpio1_18 gpio1_18 gpio1_18 gpio1_18 ehrpwm1a"
	P9_14_CAPE=""

	P9_15_PRU="80"
	P9_15_GPIO="48"
	P9_15_PIN="gpio"
	P9_15_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P9_15_INFO="gpio1_16 default gpio1_16 gpio1_16 gpio1_16 gpio1_16 ehrpwm1_tripzone_input"
	P9_15_CAPE=""

	P9_16_PRU="83"
	P9_16_GPIO="51"
	P9_16_PIN="gpio"
	P9_16_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P9_16_INFO="gpio1_19 default gpio1_19 gpio1_19 gpio1_19 gpio1_19 ehrpwm1b"
	P9_16_CAPE=""

	P9_17_PRU="37"
	P9_17_GPIO="5"
	P9_17_PIN="gpio"
	P9_17_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs i2c pwm pru_uart"
	P9_17_INFO="gpio0_5 default gpio0_5 gpio0_5 gpio0_5 gpio0_5 spi0_cs0 i2c1_scl ehrpwm0_synci pru_uart"
	P9_17_CAPE=""

	P9_18_PRU="36"
	P9_18_GPIO="4"
	P9_18_PIN="gpio"
	P9_18_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi i2c pwm pru_uart"
	P9_18_INFO="gpio0_4 default gpio0_4 gpio0_4 gpio0_4 gpio0_4 spi0_d1 i2c1_sda ehrpwm0_tripzone_input pru_uart"
	P9_18_CAPE=""

	P9_19_PRU="45"
	P9_19_GPIO="13"
	P9_19_PIN="i2c"
	P9_19_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs can i2c pru_uart timer"
	P9_19_INFO="i2c2_scl default gpio0_13 gpio0_13 gpio0_13 gpio0_13 spi1_cs1 dcan0_rx i2c2_scl pru_uart timer5"
	P9_19_CAPE=""

	P9_20_PRU="44"
	P9_20_GPIO="12"
	P9_20_PIN="i2c"
	P9_20_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs can i2c pru_uart timer"
	P9_20_INFO="i2c2_sda default gpio0_12 gpio0_12 gpio0_12 gpio0_12 spi1_cs0 dcan0_tx i2c2_sda pru_uart timer6"
	P9_20_CAPE=""

	P9_21_PRU="35"
	P9_21_GPIO="3"
	P9_21_PIN="gpio"
	P9_21_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi uart i2c pwm pru_uart"
	P9_21_INFO="gpio0_3 default gpio0_3 gpio0_3 gpio0_3 gpio0_3 spi0_d0 uart2_txd i2c2_scl ehrpwm0b pru_uart"
	P9_21_CAPE=""

	P9_22_PRU="34"
	P9_22_GPIO="2"
	P9_22_PIN="gpio"
	P9_22_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_sclk uart i2c pwm pru_uart"
	P9_22_INFO="gpio0_2 default gpio0_2 gpio0_2 gpio0_2 gpio0_2 spi0_sclk uart2_rxd i2c2_sda ehrpwm0a pru_uart"
	P9_22_CAPE=""

	P9_23_PRU="81"
	P9_23_GPIO="49"
	P9_23_PIN="gpio"
	P9_23_PINMUX="default gpio gpio_pu gpio_pd gpio_input pwm"
	P9_23_INFO="gpio1_17 default gpio1_17 gpio1_17 gpio1_17 gpio1_17 ehrpwm0_synco"
	P9_23_CAPE=""

	P9_24_PRU="47"
	P9_24_GPIO="15"
	P9_24_PIN="gpio"
	P9_24_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart can i2c pru_uart pruin"
	P9_24_INFO="gpio0_15 default gpio0_15 gpio0_15 gpio0_15 gpio0_15 uart1_txd dcan1_rx i2c1_scl pru_uart pru0_in16"
	P9_24_CAPE=""

	P9_25_PRU="149"
	P9_25_GPIO="117"
	P9_25_PIN="audio"
	P9_25_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P9_25_INFO="gpio3_21 default gpio3_21 gpio3_21 gpio3_21 gpio3_21 eqep0_strobe pru0_out7 pru0_in7"
	P9_25_CAPE=""

	P9_26_PRU="46"
	P9_26_GPIO="14"
	P9_26_PIN="gpio"
	P9_26_PINMUX="default gpio gpio_pu gpio_pd gpio_input uart can i2c pru_uart pruin"
	P9_26_INFO="gpio0_14 default gpio0_14 gpio0_14 gpio0_14 gpio0_14 uart1_rxd dcan1_tx i2c1_sda pru_uart pru1_in16"
	P9_26_CAPE=""

	P9_27_PRU="147"
	P9_27_GPIO="115"
	P9_27_PIN="gpio"
	P9_27_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P9_27_INFO="gpio3_19 default gpio3_19 gpio3_19 gpio3_19 gpio3_19 eqep0b_in pru0_out5 pru0_in5"
	P9_27_CAPE=""

	P9_28_PRU="145"
	P9_28_GPIO="113"
	P9_28_PIN="audio"
	P9_28_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs pwm pwm2 pruout pruin"
	P9_28_INFO="gpio3_17 default gpio3_17 gpio3_17 gpio3_17 gpio3_17 spi1_cs0 ehrpwm0_synci ecap2_in_pwm2_out pru0_out3 pru0_in3"
	P9_28_CAPE=""

	P9_29_PRU="143"
	P9_29_GPIO="111"
	P9_29_PIN="audio"
	P9_29_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi pwm pruout pruin"
	P9_29_INFO="gpio3_15 default gpio3_15 gpio3_15 gpio3_15 gpio3_15 spi1_d0 ehrpwm0b pru0_out1 pru0_in1"
	P9_29_CAPE=""

	P9_30_PRU="144"
	P9_30_GPIO="112"
	P9_30_PIN="gpio"
	P9_30_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi pwm pruout pruin"
	P9_30_INFO="gpio3_16 default gpio3_16 gpio3_16 gpio3_16 gpio3_16 spi1_d1 ehrpwm0_tripzone_input pru0_out2 pru0_in2"
	P9_30_CAPE=""

	P9_31_PRU="142"
	P9_31_GPIO="110"
	P9_31_PIN="audio"
	P9_31_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_sclk pwm pruout pruin"
	P9_31_INFO="gpio3_14 default gpio3_14 gpio3_14 gpio3_14 gpio3_14 spi1_sclk ehrpwm0a pru0_out0 pru0_in0"
	P9_31_CAPE=""

	P9_32_PIN="power"
	P9_32_INFO="VADC"
	P9_32_CAPE=""

	P9_33_PIN="adc"
	P9_33_INFO="AIN4"
	P9_33_CAPE=""

	P9_34_PIN="gnd"
	P9_34_INFO="AGND"
	P9_34_CAPE=""

	P9_35_PIN="adc"
	P9_35_INFO="AIN6"
	P9_35_CAPE=""

	P9_36_PIN="adc"
	P9_36_INFO="AIN5"
	P9_36_CAPE=""

	P9_37_PIN="adc"
	P9_37_INFO="AIN2"
	P9_37_CAPE=""

	P9_38_PIN="adc"
	P9_38_INFO="AIN3"
	P9_38_CAPE=""

	P9_39_PIN="adc"
	P9_39_INFO="AIN0"
	P9_39_CAPE=""

	P9_40_PIN="adc"
	P9_40_INFO="AIN1"
	P9_40_CAPE=""

	P9_41_PRU="52"
	P9_41_GPIO="20"
	P9_41_PIN="gpio"
	P9_41_PINMUX="default gpio gpio_pu gpio_pd gpio_input timer pruin"
	P9_41_INFO="gpio0_20 default gpio0_20 gpio0_20 gpio0_20 gpio0_20 timer7 pru0_in16"
	P9_41_CAPE=""

	P9_91_PRU="148"
	P9_91_GPIO="116"
	P9_91_PIN="gpio"
	P9_91_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P9_91_INFO="gpio3_20 default gpio3_20 gpio3_20 gpio3_20 gpio3_20 eqep0_index pru0_out6 pru0_in6"
	P9_91_CAPE=""

	P9_42_PRU="39"
	P9_42_GPIO="7"
	P9_42_PIN="gpio"
	P9_42_PINMUX="default gpio gpio_pu gpio_pd gpio_input spi_cs spi_sclk uart pwm pru_ecap"
	P9_42_INFO="gpio0_7 default gpio0_7 gpio0_7 gpio0_7 gpio0_7 spi1_cs1 spi1_sclk uart3_txd ecap0_in_pwm0_out pru_ecap"
	P9_42_CAPE=""

	P9_92_PRU="146"
	P9_92_GPIO="114"
	P9_92_PIN="gpio"
	P9_92_PINMUX="default gpio gpio_pu gpio_pd gpio_input qep pruout pruin"
	P9_92_INFO="gpio3_18 default gpio3_18 gpio3_18 gpio3_18 gpio3_18 eqep0a_in pru0_out4 pru0_in4"
	P9_92_CAPE=""

	P9_43_PIN="gnd"
	P9_43_INFO="GND"
	P9_43_CAPE=""

	P9_44_PIN="gnd"
	P9_44_INFO="GND"
	P9_44_CAPE=""

	P9_45_PIN="gnd"
	P9_45_INFO="GND"
	P9_45_CAPE=""

	P9_46_PIN="gnd"
	P9_46_INFO="GND"
	P9_46_CAPE=""
fi

echo_err () {
	echo "$@" 1>&2
}

echo_std () {
	echo "$@"
}

echo_dbg () {
	if [ -n "$DEBUG" ] ; then
		echo "$@" 1>&2
	fi
}

usage () {
	NAME="$(basename $0)"
	cat <<- EOF
	$NAME [-a] <pin> <mode>
	    Set <pin> to <mode>, configuring pin multiplexing and optionally
	    configuring the gpio.  Valid <mode> strings vary based on <pin>,
	    however all pins have a default and gpio mode.  The default mode is
	    the reset state of the pin, with the pin mux set to gpio, the pull
	    up/down resistor set to it's reset value, and the pin receive buffer
	    enabled.  To setup gpio, the following <mode> strings are all valid:

	        gpio : 
	            Set pinmux to gpio, existing direction and value unchanged
	        in | input:
	            Set pinmux to gpio and set gpio direction to input
	        out | output :
	            Set pinmux to gpio and set gpio direction to output
	        hi | high | 1 :
	            Set pinmux to gpio and set gpio direction to output driving high
	        lo | low | 0 :
	            Set pinmux to gpio and set gpio direction to output driving low

	    To enable pull-up or pull-down resistors, a suffex may be appended to
	    any of the above gpio modes.  Use + or _pu to enable the pull-up resistor
	    and - or _pd to enable the pull-down resistor.  Examples:

	        in+ | in_pu:
	            Enable pull-up resistor and setup pin as per input, above.
	        hi- | hi_pd:
	            Enable pull-down resistor and setup pin as per high, above.
	            While the pull-down resistor will be enabled, it will not do much
	            until application software changes the pin direction to input.

	$NAME -l <pin>
	    list valid <mode> values for <pin>

	$NAME -i <pin>
	    show information to <pin>

	$NAME -q <pin>
	    query pin and report configuration details

	$NAME -f [file]
	    Read list of pin configurations from file, one per line
	    Comments and white-space are allowed
	    With no file, or when file is -, read standard input.
	$NAME -h
	    Display this help text
	
	EOF
}

# Be friendly about pin naming conventions
# $1 = Pin name
fixup_pin () {
	local PIN
	# Use ash-friendly substitutions: ${ % } ${ # }
	case "$1" in
	[pP]*)  X="${1#?}" ;;
	*)  X="$1" ;;
	esac

	case "$X" in
	# There is no pin 00
	*00)	echo_err "Invalid pin: $1"
		exit 1
		;;
	# Missing separator, single digit pin number
	[1-9][1-9])
		PIN=P${X%?}_0${X#?}
		;;
	# Missing separator, two digit pin number
	[1-9][0-49][0-9])
		PIN=P${X%??}_${X#?}
		;;
	# Single digit pin number
	[1-9][!0-9][1-9])
		PIN=P${X%??}_0${X#??}
		;;
	# Two digit pin number
	[1-9][!0-9][0-49][0-9])
		PIN=P${X%???}_${X#??}
		;;
	# Anything else is an error
	*)  echo_err "Invalid pin: \"$1\" \"$X\""
		exit 1
		;;
	esac

	echo $PIN
}

# Be friendly about overlay naming conventions
# $1 = Overlay name
fixup_overlay () {
	case "$1" in
	[oO][vV]|[oO][vV][eE][rR][lL][aA][yY])
		echo "1"
		;;
	[cC][aA][pP][eE])
		echo "1"
		;;
	*)  echo "0"
		;;
	esac
}

# List the default mode value
# $1 = Pin Name
listmode () {
	PIN=$(fixup_pin $1)
	eval MODES="\$${PIN}_PIN"
	if [ -z "$MODES" ] ; then
		echo_err "Unknown pin name: $1"
		exit 1
	else
		echo "$MODES"
	fi
}

# List the legal mode values for a pin
# $1 = Pin Name
listmodes () {
	PIN=$(fixup_pin $1)
	eval MODES="\$${PIN}_PINMUX"
	eval INFO="\$${PIN}_INFO"
	if [ -z "$MODES" ] ; then
		echo_err "Pin is not modifiable: $1 $INFO"
		exit 1
	else
		echo "$MODES"
	fi
}

# List the capes for a pin
# $1 = Pin Name
listcape () {
	PIN=$(fixup_pin $1)
	eval CAPE="\$${PIN}_CAPE"
	if [ -z "$CAPE" ] ; then
		echo_err "Pin has no cape: $1"
		exit 1
	else
		echo "$CAPE"
	fi
}

# List info for a pin
# $1 = Pin Name
listinfo () {
	PIN=$(fixup_pin $1)
	eval INFO="\$${PIN}_INFO"
	echo "$INFO"
}

# List the kernel GPIO id for a pin
# $1 = Pin Name
listgpio () {
	PIN=$(fixup_pin $1)
	eval GPIO="\$${PIN}_GPIO"
	echo "$GPIO"
}

# List ther PRU GPIO id for a pin
# $1 = Pin Name
listpru () {
	PIN=$(fixup_pin $1)
	eval PRU="\$${PIN}_PRU"
	echo "$PRU"
}

# List current pin settings
# $1 = Pin name
query_pin () {
	set -e
	PIN=$(fixup_pin $1)
	MODES="$(listmodes $PIN)"

	check_pin $PIN

	if [ ! "x${SLOTS_LOCATION}" = "xold38kernel" ] ; then
		# Expand filename using shell globbing
		for FILE in $OCPDIR${PIN}_pinmux/state ; do
			if [ -r $FILE ] ; then
				read MODE JUNK < $FILE
			else
				echo_err "Cannot read pinmux file: $FILE"
				exit 1
			fi
		done
	else
		# Expand filename using shell globbing
		for FILE in $OCPDIR/${PIN}_pinmux.*/state ; do
			if [ -r $FILE ] ; then
				read MODE JUNK < $FILE
			else
				echo_err "Cannot read pinmux file: $FILE"
				exit 1
			fi
		done
	fi

	case "$MODE" in
	default|gpio*)
		VALUE=pin_not_exported
		DIR=pin_not_exported
		eval GPIO="\$${PIN}_GPIO"
		FILE="$GPIODIR/gpio$GPIO/value"
		[ -r $FILE ] && read VALUE JUNK < $FILE
		FILE="$GPIODIR/gpio$GPIO/direction"
		[ -r $FILE ] && read DIR JUNK < $FILE
		echo "$PIN Mode: $MODE Direction: $DIR Value: $VALUE"
		;;
	*)  echo "$PIN Mode: $MODE"
		;;
	esac
}

# Show information to a specific pin
# $1 = Pin name
show_pin () {
	set -e
	PIN=$(fixup_pin $1)
	MODE="$(listmode $PIN)"
	MODES="$(listmodes $PIN)"
#	CAPE="$(listcape $PIN)"
	INFO="$(listinfo $PIN)"
	GPIOID="$(listgpio $PIN)"
	PRUID="$(listpru $PIN)"
	
	echo Pin name: $PIN
	echo Function if no cape loaded: $MODE
	echo Function if cape loaded: $MODES
	echo Function information: $INFO
#	echo Cape: $CAPE
	echo Kernel GPIO id: $GPIOID
	echo PRU GPIO id: $PRUID
}

# Load a installed cape
# $1 cape to load
load_cape () {
	if [ -f $SLOTS ] ; then
		# Make sure required device tree overlay(s) are loaded
		# cape-bone-iio
		for DTBO in $1 ; do
			if [ ${disable_capemgr_load} -eq 0 ] ; then
				if grep -q $DTBO $SLOTS ; then
					echo_std $DTBO already loaded
				else
					# Expand filename using shell globbing
					for FILE in $SLOTS ; do
						echo_std Loading $DTBO overlay
						sudo -A bash -c "echo $DTBO > $SLOTS" || (echo_err "Error loading device tree overlay file: $DTBO" && exit 1)
						sleep 1
					done
				fi
			fi
		done;
	fi
}

# Check whether support for a specific pin is loaded or not
# $1 pin to check
check_pin () {
	if [ -e $OCPDIR/${PIN}_pinmux.* ] ; then
		echo_dbg $1 pinmux file found
	elif [ -e $OCPDIR${PIN}_pinmux ] ; then
		echo_dbg $1 pinmux file found
	else
		echo_err $1 pinmux file not found!

		if [ ${disable_capemgr_load} -eq 0 ] ; then
			CAPE="$(listcape $1)"
			# use only first overlay
			CAPE=`echo "$CAPE" | cut -d' ' -f1`

			if [ -f $SLOTS ] ; then
				if [ $AUTOLOAD -eq 0 ] ; then
					if grep -q $CAPE $SLOTS ; then
						echo_err "$CAPE already loaded"
						echo_err "Please verify your device tree file"
					else
						echo_err "$CAPE overlay not found"
						echo_err "run \"$(basename $0) overlay $CAPE\" to load the cape"
					fi
					exit 1
				else
					echo_std $1 overlay not found
					load_cape $CAPE
				fi
			fi
		fi
	fi
}

# Configure a single pin
# $1 = Pin name
# $2 = Pin mode
config_pin () {
	set -e
	OVERLAY=$(fixup_overlay $1)

	if [ $OVERLAY = "1" ] ; then
		if [ ${disable_capemgr_load} -eq 0 ] ; then
			load_cape $2
		fi
	else
		PIN=$(fixup_pin $1)

		MODE="$(listmode $PIN)"
		MODES="$(listmodes $PIN)"
		DIR=""

		check_pin $PIN

		case $2 in
		# Map special GPIO setup modes to gpio with direction set

		# GPIO with pull-up/down disabled
		[iI][nN]|[iI][nN][pP][uU][tT])
			MODE=gpio;
			DIR=in
			;;
		[oO][uU][tT]|[oO][uU][tT][pP][uU][tT])
			MODE=gpio;
			DIR=out
			;;
		[lL][oO]|[lL][oO][wW]|0)
			MODE=gpio;
			DIR=low
			;;
		[hH][iI]|[hH][iI][gG][hH]|1)
			MODE=gpio;
			DIR=high
			;;

		# GPIO with pull-down enabled
		[iI][nN]-|[iI][nN][pP][uU][tT]-|[iI][nN][-_][pP][dD]|[iI][nN][pP][uU][tT][-_][pP][dD])
			MODE=gpio_pd;
			DIR=in
			;;
		[oO][uU][tT]-|[oO][uU][tT][pP][uU][tT]-|[oO][uU][tT][-_][pP][dD]|[oO][uU][tT][pP][uU][tT][-_][pP][dD])
			MODE=gpio_pd;
			DIR=out
			;;
		[lL][oO]-|[lL][oO][wW]-|0-|[lL][oO][-_][pP][dD]|[lL][oO][wW][-_][pP][dD]|0[-_][pP][dD])
			MODE=gpio_pd;
			DIR=low
			;;
		[hH][iI]-|[hH][iI][gG][hH]-|1-|[hH][iI][-_][pP][dD]|[hH][iI][gG][hH][-_][pP][dD]|1[-_][pP][dD])
			MODE=gpio_pd;
			DIR=high
			;;

		# GPIO with pull-up enabled
		[iI][nN]+|[iI][nN][pP][uU][tT]+|[iI][nN][-_][pP][uU]|[iI][nN][pP][uU][tT][-_][pP][uU])
			MODE=gpio_pu;
			DIR=in
			;;
		[oO][uU][tT]+|[oO][uU][tT][pP][uU][tT]+|[oO][uU][tT][-_][pP][uU]|[oO][uU][tT][pP][uU][tT][-_][pP][uU])
			MODE=gpio_pu;
			DIR=out
			;;
		[lL][oO]+|[lL][oO][wW]+|0+|[lL][oO][-_][pP][uU]|[lL][oO][wW][-_][pP][uU]|0[-_][pP][uU])
			MODE=gpio_pu;
			DIR=low
			;;
		[hH][iI]+|[hH][iI][gG][hH]+|1+|[hH][iI][-_][pP][uU]|[hH][iI][gG][hH][-_][pP][uU]|1[-_][pP][uU])
			MODE=gpio_pd;
			DIR=high
			;;

		# Check to make sure the provided mode is legal
		*)  MODE="$2"; DIR=""
			FOUND=0
			set -- $MODES
			while [ $# -gt 0 ] ; do
				if [ "$MODE" = "$1" ] ; then
					FOUND=1
					break
				fi
				shift
			done
			
			if [ $FOUND != 1 ] ; then
				echo_err "Invalid mode: $MODE"
				exit 1
			fi
		esac

		echo_dbg "PIN: \"$PIN\" MODE: \"$MODE\" DIR: \"$DIR\""

		if [ -n "$DIR" ] ; then
			eval GPIO="\$${PIN}_GPIO"
			FILE="$GPIODIR/gpio$GPIO/direction"
			if [ -e $FILE ] ; then
				if [ -w $FILE ] ; then
					echo $DIR > $FILE || (echo_err "Cannot write gpio direction file: $FILE" && exit 1)
				else
					sudo -A bash -c "echo $DIR > $FILE" || (echo_err "Cannot write gpio direction file: $FILE" && exit 1)
				fi
			else
				echo_err "WARNING: GPIO pin not exported, cannot set direction or value!"
			fi
		fi

		if [ ! "x${SLOTS_LOCATION}" = "xold38kernel" ] ; then
			# Expand filename using shell globbing
			for FILE in $OCPDIR${PIN}_pinmux/state ; do
				echo_dbg "echo $MODE > $FILE"
				if [ -w $FILE ] ; then
					echo $MODE > $FILE || (echo_err "Cannot write pinmux file: $FILE" && exit 1)
				else
					sudo -A bash -c "echo $MODE > $FILE" || (echo_err "Cannot write pinmux file: $FILE" && exit 1)
				fi
			done
		else
			# Expand filename using shell globbing
			for FILE in $OCPDIR/${PIN}_pinmux.*/state ; do
				echo_dbg "echo $MODE > $FILE"
				if [ -w $FILE ] ; then
					echo $MODE > $FILE || (echo_err "Cannot write pinmux file: $FILE" && exit 1)
				else
					sudo -A bash -c "echo $MODE > $FILE" || (echo_err "Cannot write pinmux file: $FILE" && exit 1)
				fi
			done
		fi
	fi
}

# Read a file containing pin setup tuples and optional comments and whitespace
# $1 filename to read
readfile () {
	case $1 in
	# Use standard in
	""|-)   exec 3<&0 ;;

	# Use actual file
	*)  if [ ! -r "$1" ] ; then
			echo_err "Cannot read file: $1"
			exit 1
		fi
		exec 3< $1
		;;
	esac

	while read PIN MODE JUNK ; do
		case $PIN in 
		""|\#*) continue ;;
		*) config_pin $PIN $MODE ;;
		esac
	done <&3
	
}

# main ()

DEBUG=""
CMD=""
CMDARG=""
AUTOLOAD=0

while getopts adfhl:q:i: opt ; do
	case $opt in 
	d)  [ "$DEBUG" = 1 ] && set -x
		DEBUG=1
		;;
	a)  AUTOLOAD=1
		;;
	l)  CMD=list
		CMDARG="$OPTARG"
		;;
	i)  CMD=info
		CMDARG="$OPTARG"
		;;
	q)  CMD=query
		CMDARG="$OPTARG"
		;;
	f)  CMD=file
		;;
	\?) usage
		exit 1
		;;
	esac
done

shift `expr $OPTIND - 1`

echo_dbg AUTOLOAD=$AUTOLOAD
echo_dbg "Args: $@"

case $CMD in
list)   listmodes "$CMDARG" ;;
info)   show_pin  "$CMDARG" ;;
query)  query_pin "$CMDARG" ;;
file)   readfile "$@" ;;
*)  if [ $# -ne 2 ] ; then
		usage
		exit 1
	else
		config_pin "$1" "$2"
	fi
	;;
esac

exit 0
