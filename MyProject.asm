
_ADXL345_Write:

;MyProject.c,41 :: 		void ADXL345_Write(unsigned short address, unsigned short data1) {
;MyProject.c,42 :: 		unsigned short internal = 0;
;MyProject.c,45 :: 		CS_bit = 0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,46 :: 		SPI1_Write(internal);
	MOVF       FARG_ADXL345_Write_address+0, 0
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;MyProject.c,47 :: 		SPI1_Write(data1);
	MOVF       FARG_ADXL345_Write_data1+0, 0
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;MyProject.c,48 :: 		CS_bit = 1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,49 :: 		}
L_end_ADXL345_Write:
	RETURN
; end of _ADXL345_Write

_ADXL345_Read:

;MyProject.c,51 :: 		unsigned short ADXL345_Read(unsigned short address) {
;MyProject.c,52 :: 		unsigned short internal = 0;
;MyProject.c,53 :: 		internal = address | _SPI_READ;
	MOVLW      128
	IORWF      FARG_ADXL345_Read_address+0, 0
	MOVWF      FARG_SPI1_Write_data_+0
;MyProject.c,55 :: 		CS_bit = 0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,56 :: 		SPI1_Write(internal);
	CALL       _SPI1_Write+0
;MyProject.c,57 :: 		internal = SPI1_Read(0);
	CLRF       FARG_SPI1_Read_buffer+0
	CALL       _SPI1_Read+0
;MyProject.c,58 :: 		CS_bit = 1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,60 :: 		return internal;
;MyProject.c,61 :: 		}
L_end_ADXL345_Read:
	RETURN
; end of _ADXL345_Read

_main:

;MyProject.c,63 :: 		void main() {
;MyProject.c,64 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;MyProject.c,66 :: 		CS_bit = 1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,67 :: 		CS_Direction_bit = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;MyProject.c,68 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,69 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,70 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,72 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_HIGH, _SPI_LOW_2_HIGH);
	CLRF       FARG_SPI1_Init_Advanced_master+0
	CLRF       FARG_SPI1_Init_Advanced_data_sample+0
	MOVLW      16
	MOVWF      FARG_SPI1_Init_Advanced_clock_idle+0
	MOVLW      1
	MOVWF      FARG_SPI1_Init_Advanced_transmit_edge+0
	CALL       _SPI1_Init_Advanced+0
;MyProject.c,74 :: 		ADXL345_Write(_POWER_CTL, 0x00);
	MOVLW      45
	MOVWF      FARG_ADXL345_Write_address+0
	CLRF       FARG_ADXL345_Write_data1+0
	CALL       _ADXL345_Write+0
;MyProject.c,76 :: 		ADXL345_Write(_DATA_FORMAT, 0x0B);
	MOVLW      49
	MOVWF      FARG_ADXL345_Write_address+0
	MOVLW      11
	MOVWF      FARG_ADXL345_Write_data1+0
	CALL       _ADXL345_Write+0
;MyProject.c,78 :: 		ADXL345_Write(_BW_RATE, _SPEED);
	MOVLW      44
	MOVWF      FARG_ADXL345_Write_address+0
	MOVLW      15
	MOVWF      FARG_ADXL345_Write_data1+0
	CALL       _ADXL345_Write+0
;MyProject.c,80 :: 		ADXL345_Write(_POWER_CTL, 0x08);
	MOVLW      45
	MOVWF      FARG_ADXL345_Write_address+0
	MOVLW      8
	MOVWF      FARG_ADXL345_Write_data1+0
	CALL       _ADXL345_Write+0
;MyProject.c,82 :: 		while (1) {
L_main0:
;MyProject.c,87 :: 		readings[0] = ADXL345_Read(_DATAX0) << 8;
	MOVLW      50
	MOVWF      FARG_ADXL345_Read_address+0
	CALL       _ADXL345_Read+0
	MOVF       R0+0, 0
	MOVWF      _readings+1
	CLRF       _readings+0
;MyProject.c,90 :: 		readings[0] = readings[0] | ADXL345_Read(_DATAX1);
	MOVLW      51
	MOVWF      FARG_ADXL345_Read_address+0
	CALL       _ADXL345_Read+0
	MOVF       R0+0, 0
	IORWF      _readings+0, 1
	MOVLW      0
	IORWF      _readings+1, 1
;MyProject.c,93 :: 		readings[1] = ADXL345_Read(_DATAY0) << 8;
	MOVLW      52
	MOVWF      FARG_ADXL345_Read_address+0
	CALL       _ADXL345_Read+0
	MOVF       R0+0, 0
	MOVWF      _readings+3
	CLRF       _readings+2
;MyProject.c,96 :: 		readings[1] = readings[1] | ADXL345_Read(_DATAY1);
	MOVLW      53
	MOVWF      FARG_ADXL345_Read_address+0
	CALL       _ADXL345_Read+0
	MOVF       R0+0, 0
	IORWF      _readings+2, 1
	MOVLW      0
	IORWF      _readings+3, 1
;MyProject.c,99 :: 		readings[2] = ADXL345_Read(_DATAZ0) << 8;
	MOVLW      54
	MOVWF      FARG_ADXL345_Read_address+0
	CALL       _ADXL345_Read+0
	MOVF       R0+0, 0
	MOVWF      _readings+5
	CLRF       _readings+4
;MyProject.c,102 :: 		readings[2] = readings[2] | ADXL345_Read(_DATAZ1);
	MOVLW      55
	MOVWF      FARG_ADXL345_Read_address+0
	CALL       _ADXL345_Read+0
	MOVF       R0+0, 0
	IORWF      _readings+4, 1
	MOVLW      0
	IORWF      _readings+5, 1
;MyProject.c,106 :: 		IntToStr(readings[0], out);
	MOVF       _readings+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _readings+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _out+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,107 :: 		LCD_Out(1,1,out);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _out+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,109 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;MyProject.c,112 :: 		IntToStr(readings[1], out);
	MOVF       _readings+2, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _readings+3, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _out+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,113 :: 		LCD_Out(2,1,out);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _out+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,115 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;MyProject.c,118 :: 		IntToStr(readings[2], out);
	MOVF       _readings+4, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _readings+5, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _out+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,119 :: 		LCD_Out(2,7,out);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _out+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,121 :: 		}
	GOTO       L_main0
;MyProject.c,122 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
